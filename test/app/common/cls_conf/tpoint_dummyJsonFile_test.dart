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
import '../../../../lib/app/common/cls_conf/tpoint_dummyJsonFile.dart';

late Tpoint_dummyJsonFile tpoint_dummy;

void main(){
  tpoint_dummyJsonFile_test();
}

void tpoint_dummyJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "tpoint_dummy.json";
  const String section = "tpoint";
  const String key = "pts";
  const defaultData = 10000;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Tpoint_dummyJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Tpoint_dummyJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Tpoint_dummyJsonFile().setDefault();
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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await tpoint_dummy.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(tpoint_dummy,true);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        tpoint_dummy.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await tpoint_dummy.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(tpoint_dummy,true);

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
      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①：loadを実行する。
      await tpoint_dummy.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = tpoint_dummy.tpoint.pts;
      tpoint_dummy.tpoint.pts = testData1;
      expect(tpoint_dummy.tpoint.pts == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint.pts != testData1, true);
      expect(tpoint_dummy.tpoint.pts == prefixData, true);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = tpoint_dummy.tpoint.pts;
      tpoint_dummy.tpoint.pts = testData1;
      expect(tpoint_dummy.tpoint.pts, testData1);

      // ③saveを実行する。
      await tpoint_dummy.save();

      // ④loadを実行する。
      await tpoint_dummy.load();

      expect(tpoint_dummy.tpoint.pts != prefixData, true);
      expect(tpoint_dummy.tpoint.pts == testData1, true);
      allPropatyCheck(tpoint_dummy,false);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await tpoint_dummy.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await tpoint_dummy.save();

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await tpoint_dummy.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(tpoint_dummy.tpoint.pts, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = tpoint_dummy.tpoint.pts;
      tpoint_dummy.tpoint.pts = testData1;

      // ③ saveを実行する。
      await tpoint_dummy.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(tpoint_dummy.tpoint.pts, testData1);

      // ④ loadを実行する。
      await tpoint_dummy.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(tpoint_dummy.tpoint.pts == testData1, true);
      allPropatyCheck(tpoint_dummy,false);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await tpoint_dummy.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(tpoint_dummy,true);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②任意のプロパティの値を変更する。
      tpoint_dummy.tpoint.pts = testData1;
      expect(tpoint_dummy.tpoint.pts, testData1);

      // ③saveを実行する。
      await tpoint_dummy.save();
      expect(tpoint_dummy.tpoint.pts, testData1);

      // ④loadを実行する。
      await tpoint_dummy.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(tpoint_dummy,true);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await tpoint_dummy.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await tpoint_dummy.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(tpoint_dummy.tpoint.pts == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await tpoint_dummy.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await tpoint_dummy.setValueWithName(section, "test_key", testData1);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②任意のプロパティを変更する。
      tpoint_dummy.tpoint.pts = testData1;

      // ③saveを実行する。
      await tpoint_dummy.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await tpoint_dummy.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②任意のプロパティを変更する。
      tpoint_dummy.tpoint.pts = testData1;

      // ③saveを実行する。
      await tpoint_dummy.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await tpoint_dummy.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②任意のプロパティを変更する。
      tpoint_dummy.tpoint.pts = testData1;

      // ③saveを実行する。
      await tpoint_dummy.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await tpoint_dummy.getValueWithName(section, "test_key");
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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await tpoint_dummy.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      tpoint_dummy.tpoint.pts = testData1;
      expect(tpoint_dummy.tpoint.pts, testData1);

      // ④saveを実行する。
      await tpoint_dummy.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(tpoint_dummy.tpoint.pts, testData1);
      
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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await tpoint_dummy.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + tpoint_dummy.tpoint.pts.toString());
      expect(tpoint_dummy.tpoint.pts == testData1, true);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await tpoint_dummy.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + tpoint_dummy.tpoint.pts.toString());
      expect(tpoint_dummy.tpoint.pts == testData2, true);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await tpoint_dummy.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + tpoint_dummy.tpoint.pts.toString());
      expect(tpoint_dummy.tpoint.pts == testData1, true);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await tpoint_dummy.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + tpoint_dummy.tpoint.pts.toString());
      expect(tpoint_dummy.tpoint.pts == testData2, true);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await tpoint_dummy.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + tpoint_dummy.tpoint.pts.toString());
      expect(tpoint_dummy.tpoint.pts == testData1, true);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await tpoint_dummy.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + tpoint_dummy.tpoint.pts.toString());
      expect(tpoint_dummy.tpoint.pts == testData1, true);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await tpoint_dummy.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + tpoint_dummy.tpoint.pts.toString());
      allPropatyCheck(tpoint_dummy,true);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await tpoint_dummy.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + tpoint_dummy.tpoint.pts.toString());
      allPropatyCheck(tpoint_dummy,true);

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

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tpoint.pts;
      print(tpoint_dummy.tpoint.pts);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tpoint.pts = testData1;
      print(tpoint_dummy.tpoint.pts);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tpoint.pts == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tpoint.pts == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tpoint.pts = testData2;
      print(tpoint_dummy.tpoint.pts);
      expect(tpoint_dummy.tpoint.pts == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint.pts == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tpoint.pts = defalut;
      print(tpoint_dummy.tpoint.pts);
      expect(tpoint_dummy.tpoint.pts == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint.pts == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tpoint.ret_cd;
      print(tpoint_dummy.tpoint.ret_cd);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tpoint.ret_cd = testData1s;
      print(tpoint_dummy.tpoint.ret_cd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tpoint.ret_cd == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tpoint.ret_cd == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tpoint.ret_cd = testData2s;
      print(tpoint_dummy.tpoint.ret_cd);
      expect(tpoint_dummy.tpoint.ret_cd == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint.ret_cd == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tpoint.ret_cd = defalut;
      print(tpoint_dummy.tpoint.ret_cd);
      expect(tpoint_dummy.tpoint.ret_cd == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint.ret_cd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tpoint.err_flg;
      print(tpoint_dummy.tpoint.err_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tpoint.err_flg = testData1;
      print(tpoint_dummy.tpoint.err_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tpoint.err_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tpoint.err_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tpoint.err_flg = testData2;
      print(tpoint_dummy.tpoint.err_flg);
      expect(tpoint_dummy.tpoint.err_flg == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint.err_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tpoint.err_flg = defalut;
      print(tpoint_dummy.tpoint.err_flg);
      expect(tpoint_dummy.tpoint.err_flg == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint.err_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tpoint_use.pts;
      print(tpoint_dummy.tpoint_use.pts);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tpoint_use.pts = testData1;
      print(tpoint_dummy.tpoint_use.pts);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tpoint_use.pts == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tpoint_use.pts == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tpoint_use.pts = testData2;
      print(tpoint_dummy.tpoint_use.pts);
      expect(tpoint_dummy.tpoint_use.pts == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint_use.pts == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tpoint_use.pts = defalut;
      print(tpoint_dummy.tpoint_use.pts);
      expect(tpoint_dummy.tpoint_use.pts == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint_use.pts == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tpoint_use.ret_cd;
      print(tpoint_dummy.tpoint_use.ret_cd);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tpoint_use.ret_cd = testData1s;
      print(tpoint_dummy.tpoint_use.ret_cd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tpoint_use.ret_cd == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tpoint_use.ret_cd == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tpoint_use.ret_cd = testData2s;
      print(tpoint_dummy.tpoint_use.ret_cd);
      expect(tpoint_dummy.tpoint_use.ret_cd == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint_use.ret_cd == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tpoint_use.ret_cd = defalut;
      print(tpoint_dummy.tpoint_use.ret_cd);
      expect(tpoint_dummy.tpoint_use.ret_cd == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint_use.ret_cd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tpoint_use.err_flg;
      print(tpoint_dummy.tpoint_use.err_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tpoint_use.err_flg = testData1;
      print(tpoint_dummy.tpoint_use.err_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tpoint_use.err_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tpoint_use.err_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tpoint_use.err_flg = testData2;
      print(tpoint_dummy.tpoint_use.err_flg);
      expect(tpoint_dummy.tpoint_use.err_flg == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint_use.err_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tpoint_use.err_flg = defalut;
      print(tpoint_dummy.tpoint_use.err_flg);
      expect(tpoint_dummy.tpoint_use.err_flg == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint_use.err_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tpoint_cancel.pts;
      print(tpoint_dummy.tpoint_cancel.pts);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tpoint_cancel.pts = testData1;
      print(tpoint_dummy.tpoint_cancel.pts);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tpoint_cancel.pts == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tpoint_cancel.pts == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tpoint_cancel.pts = testData2;
      print(tpoint_dummy.tpoint_cancel.pts);
      expect(tpoint_dummy.tpoint_cancel.pts == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint_cancel.pts == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tpoint_cancel.pts = defalut;
      print(tpoint_dummy.tpoint_cancel.pts);
      expect(tpoint_dummy.tpoint_cancel.pts == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint_cancel.pts == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tpoint_cancel.ret_cd;
      print(tpoint_dummy.tpoint_cancel.ret_cd);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tpoint_cancel.ret_cd = testData1s;
      print(tpoint_dummy.tpoint_cancel.ret_cd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tpoint_cancel.ret_cd == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tpoint_cancel.ret_cd == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tpoint_cancel.ret_cd = testData2s;
      print(tpoint_dummy.tpoint_cancel.ret_cd);
      expect(tpoint_dummy.tpoint_cancel.ret_cd == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint_cancel.ret_cd == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tpoint_cancel.ret_cd = defalut;
      print(tpoint_dummy.tpoint_cancel.ret_cd);
      expect(tpoint_dummy.tpoint_cancel.ret_cd == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint_cancel.ret_cd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tpoint_cancel.err_flg;
      print(tpoint_dummy.tpoint_cancel.err_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tpoint_cancel.err_flg = testData1;
      print(tpoint_dummy.tpoint_cancel.err_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tpoint_cancel.err_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tpoint_cancel.err_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tpoint_cancel.err_flg = testData2;
      print(tpoint_dummy.tpoint_cancel.err_flg);
      expect(tpoint_dummy.tpoint_cancel.err_flg == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint_cancel.err_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tpoint_cancel.err_flg = defalut;
      print(tpoint_dummy.tpoint_cancel.err_flg);
      expect(tpoint_dummy.tpoint_cancel.err_flg == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tpoint_cancel.err_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.mobile.kaiin_id;
      print(tpoint_dummy.mobile.kaiin_id);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.mobile.kaiin_id = testData1s;
      print(tpoint_dummy.mobile.kaiin_id);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.mobile.kaiin_id == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.mobile.kaiin_id == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.mobile.kaiin_id = testData2s;
      print(tpoint_dummy.mobile.kaiin_id);
      expect(tpoint_dummy.mobile.kaiin_id == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.mobile.kaiin_id == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.mobile.kaiin_id = defalut;
      print(tpoint_dummy.mobile.kaiin_id);
      expect(tpoint_dummy.mobile.kaiin_id == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.mobile.kaiin_id == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney.ret_cd;
      print(tpoint_dummy.tmoney.ret_cd);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney.ret_cd = testData1s;
      print(tpoint_dummy.tmoney.ret_cd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney.ret_cd == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney.ret_cd == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney.ret_cd = testData2s;
      print(tpoint_dummy.tmoney.ret_cd);
      expect(tpoint_dummy.tmoney.ret_cd == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney.ret_cd == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney.ret_cd = defalut;
      print(tpoint_dummy.tmoney.ret_cd);
      expect(tpoint_dummy.tmoney.ret_cd == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney.ret_cd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney.avbl;
      print(tpoint_dummy.tmoney.avbl);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney.avbl = testData1;
      print(tpoint_dummy.tmoney.avbl);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney.avbl == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney.avbl == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney.avbl = testData2;
      print(tpoint_dummy.tmoney.avbl);
      expect(tpoint_dummy.tmoney.avbl == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney.avbl == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney.avbl = defalut;
      print(tpoint_dummy.tmoney.avbl);
      expect(tpoint_dummy.tmoney.avbl == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney.avbl == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney.first;
      print(tpoint_dummy.tmoney.first);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney.first = testData1;
      print(tpoint_dummy.tmoney.first);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney.first == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney.first == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney.first = testData2;
      print(tpoint_dummy.tmoney.first);
      expect(tpoint_dummy.tmoney.first == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney.first == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney.first = defalut;
      print(tpoint_dummy.tmoney.first);
      expect(tpoint_dummy.tmoney.first == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney.first == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney.bal;
      print(tpoint_dummy.tmoney.bal);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney.bal = testData1;
      print(tpoint_dummy.tmoney.bal);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney.bal == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney.bal == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney.bal = testData2;
      print(tpoint_dummy.tmoney.bal);
      expect(tpoint_dummy.tmoney.bal == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney.bal == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney.bal = defalut;
      print(tpoint_dummy.tmoney.bal);
      expect(tpoint_dummy.tmoney.bal == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney.bal == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney_chrg.ret_cd;
      print(tpoint_dummy.tmoney_chrg.ret_cd);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney_chrg.ret_cd = testData1s;
      print(tpoint_dummy.tmoney_chrg.ret_cd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney_chrg.ret_cd == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney_chrg.ret_cd == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney_chrg.ret_cd = testData2s;
      print(tpoint_dummy.tmoney_chrg.ret_cd);
      expect(tpoint_dummy.tmoney_chrg.ret_cd == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_chrg.ret_cd == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney_chrg.ret_cd = defalut;
      print(tpoint_dummy.tmoney_chrg.ret_cd);
      expect(tpoint_dummy.tmoney_chrg.ret_cd == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_chrg.ret_cd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney_chrg.err_flg;
      print(tpoint_dummy.tmoney_chrg.err_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney_chrg.err_flg = testData1;
      print(tpoint_dummy.tmoney_chrg.err_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney_chrg.err_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney_chrg.err_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney_chrg.err_flg = testData2;
      print(tpoint_dummy.tmoney_chrg.err_flg);
      expect(tpoint_dummy.tmoney_chrg.err_flg == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_chrg.err_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney_chrg.err_flg = defalut;
      print(tpoint_dummy.tmoney_chrg.err_flg);
      expect(tpoint_dummy.tmoney_chrg.err_flg == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_chrg.err_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney_chrg_rc.ret_cd;
      print(tpoint_dummy.tmoney_chrg_rc.ret_cd);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney_chrg_rc.ret_cd = testData1s;
      print(tpoint_dummy.tmoney_chrg_rc.ret_cd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney_chrg_rc.ret_cd == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney_chrg_rc.ret_cd == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney_chrg_rc.ret_cd = testData2s;
      print(tpoint_dummy.tmoney_chrg_rc.ret_cd);
      expect(tpoint_dummy.tmoney_chrg_rc.ret_cd == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_chrg_rc.ret_cd == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney_chrg_rc.ret_cd = defalut;
      print(tpoint_dummy.tmoney_chrg_rc.ret_cd);
      expect(tpoint_dummy.tmoney_chrg_rc.ret_cd == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_chrg_rc.ret_cd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney_chrg_rc.err_flg;
      print(tpoint_dummy.tmoney_chrg_rc.err_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney_chrg_rc.err_flg = testData1;
      print(tpoint_dummy.tmoney_chrg_rc.err_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney_chrg_rc.err_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney_chrg_rc.err_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney_chrg_rc.err_flg = testData2;
      print(tpoint_dummy.tmoney_chrg_rc.err_flg);
      expect(tpoint_dummy.tmoney_chrg_rc.err_flg == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_chrg_rc.err_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney_chrg_rc.err_flg = defalut;
      print(tpoint_dummy.tmoney_chrg_rc.err_flg);
      expect(tpoint_dummy.tmoney_chrg_rc.err_flg == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_chrg_rc.err_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney_chrg_vd.ret_cd;
      print(tpoint_dummy.tmoney_chrg_vd.ret_cd);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney_chrg_vd.ret_cd = testData1s;
      print(tpoint_dummy.tmoney_chrg_vd.ret_cd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney_chrg_vd.ret_cd == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney_chrg_vd.ret_cd == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney_chrg_vd.ret_cd = testData2s;
      print(tpoint_dummy.tmoney_chrg_vd.ret_cd);
      expect(tpoint_dummy.tmoney_chrg_vd.ret_cd == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_chrg_vd.ret_cd == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney_chrg_vd.ret_cd = defalut;
      print(tpoint_dummy.tmoney_chrg_vd.ret_cd);
      expect(tpoint_dummy.tmoney_chrg_vd.ret_cd == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_chrg_vd.ret_cd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney_chrg_vd.err_flg;
      print(tpoint_dummy.tmoney_chrg_vd.err_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney_chrg_vd.err_flg = testData1;
      print(tpoint_dummy.tmoney_chrg_vd.err_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney_chrg_vd.err_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney_chrg_vd.err_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney_chrg_vd.err_flg = testData2;
      print(tpoint_dummy.tmoney_chrg_vd.err_flg);
      expect(tpoint_dummy.tmoney_chrg_vd.err_flg == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_chrg_vd.err_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney_chrg_vd.err_flg = defalut;
      print(tpoint_dummy.tmoney_chrg_vd.err_flg);
      expect(tpoint_dummy.tmoney_chrg_vd.err_flg == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_chrg_vd.err_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney_tran.ret_cd;
      print(tpoint_dummy.tmoney_tran.ret_cd);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney_tran.ret_cd = testData1s;
      print(tpoint_dummy.tmoney_tran.ret_cd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney_tran.ret_cd == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney_tran.ret_cd == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney_tran.ret_cd = testData2s;
      print(tpoint_dummy.tmoney_tran.ret_cd);
      expect(tpoint_dummy.tmoney_tran.ret_cd == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_tran.ret_cd == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney_tran.ret_cd = defalut;
      print(tpoint_dummy.tmoney_tran.ret_cd);
      expect(tpoint_dummy.tmoney_tran.ret_cd == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_tran.ret_cd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney_tran.err_flg;
      print(tpoint_dummy.tmoney_tran.err_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney_tran.err_flg = testData1;
      print(tpoint_dummy.tmoney_tran.err_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney_tran.err_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney_tran.err_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney_tran.err_flg = testData2;
      print(tpoint_dummy.tmoney_tran.err_flg);
      expect(tpoint_dummy.tmoney_tran.err_flg == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_tran.err_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney_tran.err_flg = defalut;
      print(tpoint_dummy.tmoney_tran.err_flg);
      expect(tpoint_dummy.tmoney_tran.err_flg == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_tran.err_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney_tran_rc.ret_cd;
      print(tpoint_dummy.tmoney_tran_rc.ret_cd);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney_tran_rc.ret_cd = testData1s;
      print(tpoint_dummy.tmoney_tran_rc.ret_cd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney_tran_rc.ret_cd == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney_tran_rc.ret_cd == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney_tran_rc.ret_cd = testData2s;
      print(tpoint_dummy.tmoney_tran_rc.ret_cd);
      expect(tpoint_dummy.tmoney_tran_rc.ret_cd == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_tran_rc.ret_cd == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney_tran_rc.ret_cd = defalut;
      print(tpoint_dummy.tmoney_tran_rc.ret_cd);
      expect(tpoint_dummy.tmoney_tran_rc.ret_cd == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_tran_rc.ret_cd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney_tran_rc.err_flg;
      print(tpoint_dummy.tmoney_tran_rc.err_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney_tran_rc.err_flg = testData1;
      print(tpoint_dummy.tmoney_tran_rc.err_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney_tran_rc.err_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney_tran_rc.err_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney_tran_rc.err_flg = testData2;
      print(tpoint_dummy.tmoney_tran_rc.err_flg);
      expect(tpoint_dummy.tmoney_tran_rc.err_flg == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_tran_rc.err_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney_tran_rc.err_flg = defalut;
      print(tpoint_dummy.tmoney_tran_rc.err_flg);
      expect(tpoint_dummy.tmoney_tran_rc.err_flg == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_tran_rc.err_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney_tran_vd.ret_cd;
      print(tpoint_dummy.tmoney_tran_vd.ret_cd);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney_tran_vd.ret_cd = testData1s;
      print(tpoint_dummy.tmoney_tran_vd.ret_cd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney_tran_vd.ret_cd == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney_tran_vd.ret_cd == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney_tran_vd.ret_cd = testData2s;
      print(tpoint_dummy.tmoney_tran_vd.ret_cd);
      expect(tpoint_dummy.tmoney_tran_vd.ret_cd == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_tran_vd.ret_cd == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney_tran_vd.ret_cd = defalut;
      print(tpoint_dummy.tmoney_tran_vd.ret_cd);
      expect(tpoint_dummy.tmoney_tran_vd.ret_cd == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_tran_vd.ret_cd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tmoney_tran_vd.err_flg;
      print(tpoint_dummy.tmoney_tran_vd.err_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tmoney_tran_vd.err_flg = testData1;
      print(tpoint_dummy.tmoney_tran_vd.err_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tmoney_tran_vd.err_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tmoney_tran_vd.err_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tmoney_tran_vd.err_flg = testData2;
      print(tpoint_dummy.tmoney_tran_vd.err_flg);
      expect(tpoint_dummy.tmoney_tran_vd.err_flg == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_tran_vd.err_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tmoney_tran_vd.err_flg = defalut;
      print(tpoint_dummy.tmoney_tran_vd.err_flg);
      expect(tpoint_dummy.tmoney_tran_vd.err_flg == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tmoney_tran_vd.err_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.total;
      print(tpoint_dummy.kikan.total);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.total = testData1s;
      print(tpoint_dummy.kikan.total);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.total == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.total == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.total = testData2s;
      print(tpoint_dummy.kikan.total);
      expect(tpoint_dummy.kikan.total == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.total == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.total = defalut;
      print(tpoint_dummy.kikan.total);
      expect(tpoint_dummy.kikan.total == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.total == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.minlim;
      print(tpoint_dummy.kikan.minlim);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.minlim = testData1s;
      print(tpoint_dummy.kikan.minlim);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.minlim == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.minlim == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.minlim = testData2s;
      print(tpoint_dummy.kikan.minlim);
      expect(tpoint_dummy.kikan.minlim == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.minlim == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.minlim = defalut;
      print(tpoint_dummy.kikan.minlim);
      expect(tpoint_dummy.kikan.minlim == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.minlim == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.count;
      print(tpoint_dummy.kikan.count);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.count = testData1;
      print(tpoint_dummy.kikan.count);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.count == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.count == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.count = testData2;
      print(tpoint_dummy.kikan.count);
      expect(tpoint_dummy.kikan.count == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.count == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.count = defalut;
      print(tpoint_dummy.kikan.count);
      expect(tpoint_dummy.kikan.count == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.count == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.id1;
      print(tpoint_dummy.kikan.id1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.id1 = testData1s;
      print(tpoint_dummy.kikan.id1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.id1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.id1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.id1 = testData2s;
      print(tpoint_dummy.kikan.id1);
      expect(tpoint_dummy.kikan.id1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.id1 = defalut;
      print(tpoint_dummy.kikan.id1);
      expect(tpoint_dummy.kikan.id1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.pts1;
      print(tpoint_dummy.kikan.pts1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.pts1 = testData1s;
      print(tpoint_dummy.kikan.pts1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.pts1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.pts1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.pts1 = testData2s;
      print(tpoint_dummy.kikan.pts1);
      expect(tpoint_dummy.kikan.pts1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.pts1 = defalut;
      print(tpoint_dummy.kikan.pts1);
      expect(tpoint_dummy.kikan.pts1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.date1;
      print(tpoint_dummy.kikan.date1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.date1 = testData1s;
      print(tpoint_dummy.kikan.date1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.date1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.date1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.date1 = testData2s;
      print(tpoint_dummy.kikan.date1);
      expect(tpoint_dummy.kikan.date1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.date1 = defalut;
      print(tpoint_dummy.kikan.date1);
      expect(tpoint_dummy.kikan.date1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.id2;
      print(tpoint_dummy.kikan.id2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.id2 = testData1s;
      print(tpoint_dummy.kikan.id2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.id2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.id2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.id2 = testData2s;
      print(tpoint_dummy.kikan.id2);
      expect(tpoint_dummy.kikan.id2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.id2 = defalut;
      print(tpoint_dummy.kikan.id2);
      expect(tpoint_dummy.kikan.id2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.pts2;
      print(tpoint_dummy.kikan.pts2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.pts2 = testData1s;
      print(tpoint_dummy.kikan.pts2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.pts2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.pts2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.pts2 = testData2s;
      print(tpoint_dummy.kikan.pts2);
      expect(tpoint_dummy.kikan.pts2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.pts2 = defalut;
      print(tpoint_dummy.kikan.pts2);
      expect(tpoint_dummy.kikan.pts2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.date2;
      print(tpoint_dummy.kikan.date2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.date2 = testData1s;
      print(tpoint_dummy.kikan.date2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.date2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.date2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.date2 = testData2s;
      print(tpoint_dummy.kikan.date2);
      expect(tpoint_dummy.kikan.date2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.date2 = defalut;
      print(tpoint_dummy.kikan.date2);
      expect(tpoint_dummy.kikan.date2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.id3;
      print(tpoint_dummy.kikan.id3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.id3 = testData1s;
      print(tpoint_dummy.kikan.id3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.id3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.id3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.id3 = testData2s;
      print(tpoint_dummy.kikan.id3);
      expect(tpoint_dummy.kikan.id3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.id3 = defalut;
      print(tpoint_dummy.kikan.id3);
      expect(tpoint_dummy.kikan.id3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.pts3;
      print(tpoint_dummy.kikan.pts3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.pts3 = testData1s;
      print(tpoint_dummy.kikan.pts3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.pts3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.pts3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.pts3 = testData2s;
      print(tpoint_dummy.kikan.pts3);
      expect(tpoint_dummy.kikan.pts3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.pts3 = defalut;
      print(tpoint_dummy.kikan.pts3);
      expect(tpoint_dummy.kikan.pts3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.date3;
      print(tpoint_dummy.kikan.date3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.date3 = testData1s;
      print(tpoint_dummy.kikan.date3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.date3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.date3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.date3 = testData2s;
      print(tpoint_dummy.kikan.date3);
      expect(tpoint_dummy.kikan.date3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.date3 = defalut;
      print(tpoint_dummy.kikan.date3);
      expect(tpoint_dummy.kikan.date3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.id4;
      print(tpoint_dummy.kikan.id4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.id4 = testData1s;
      print(tpoint_dummy.kikan.id4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.id4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.id4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.id4 = testData2s;
      print(tpoint_dummy.kikan.id4);
      expect(tpoint_dummy.kikan.id4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.id4 = defalut;
      print(tpoint_dummy.kikan.id4);
      expect(tpoint_dummy.kikan.id4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.pts4;
      print(tpoint_dummy.kikan.pts4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.pts4 = testData1s;
      print(tpoint_dummy.kikan.pts4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.pts4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.pts4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.pts4 = testData2s;
      print(tpoint_dummy.kikan.pts4);
      expect(tpoint_dummy.kikan.pts4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.pts4 = defalut;
      print(tpoint_dummy.kikan.pts4);
      expect(tpoint_dummy.kikan.pts4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.date4;
      print(tpoint_dummy.kikan.date4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.date4 = testData1s;
      print(tpoint_dummy.kikan.date4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.date4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.date4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.date4 = testData2s;
      print(tpoint_dummy.kikan.date4);
      expect(tpoint_dummy.kikan.date4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.date4 = defalut;
      print(tpoint_dummy.kikan.date4);
      expect(tpoint_dummy.kikan.date4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.id5;
      print(tpoint_dummy.kikan.id5);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.id5 = testData1s;
      print(tpoint_dummy.kikan.id5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.id5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.id5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.id5 = testData2s;
      print(tpoint_dummy.kikan.id5);
      expect(tpoint_dummy.kikan.id5 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.id5 = defalut;
      print(tpoint_dummy.kikan.id5);
      expect(tpoint_dummy.kikan.id5 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.pts5;
      print(tpoint_dummy.kikan.pts5);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.pts5 = testData1s;
      print(tpoint_dummy.kikan.pts5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.pts5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.pts5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.pts5 = testData2s;
      print(tpoint_dummy.kikan.pts5);
      expect(tpoint_dummy.kikan.pts5 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.pts5 = defalut;
      print(tpoint_dummy.kikan.pts5);
      expect(tpoint_dummy.kikan.pts5 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.date5;
      print(tpoint_dummy.kikan.date5);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.date5 = testData1s;
      print(tpoint_dummy.kikan.date5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.date5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.date5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.date5 = testData2s;
      print(tpoint_dummy.kikan.date5);
      expect(tpoint_dummy.kikan.date5 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.date5 = defalut;
      print(tpoint_dummy.kikan.date5);
      expect(tpoint_dummy.kikan.date5 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.id6;
      print(tpoint_dummy.kikan.id6);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.id6 = testData1s;
      print(tpoint_dummy.kikan.id6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.id6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.id6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.id6 = testData2s;
      print(tpoint_dummy.kikan.id6);
      expect(tpoint_dummy.kikan.id6 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.id6 = defalut;
      print(tpoint_dummy.kikan.id6);
      expect(tpoint_dummy.kikan.id6 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.pts6;
      print(tpoint_dummy.kikan.pts6);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.pts6 = testData1s;
      print(tpoint_dummy.kikan.pts6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.pts6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.pts6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.pts6 = testData2s;
      print(tpoint_dummy.kikan.pts6);
      expect(tpoint_dummy.kikan.pts6 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.pts6 = defalut;
      print(tpoint_dummy.kikan.pts6);
      expect(tpoint_dummy.kikan.pts6 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.date6;
      print(tpoint_dummy.kikan.date6);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.date6 = testData1s;
      print(tpoint_dummy.kikan.date6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.date6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.date6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.date6 = testData2s;
      print(tpoint_dummy.kikan.date6);
      expect(tpoint_dummy.kikan.date6 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.date6 = defalut;
      print(tpoint_dummy.kikan.date6);
      expect(tpoint_dummy.kikan.date6 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.id7;
      print(tpoint_dummy.kikan.id7);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.id7 = testData1s;
      print(tpoint_dummy.kikan.id7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.id7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.id7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.id7 = testData2s;
      print(tpoint_dummy.kikan.id7);
      expect(tpoint_dummy.kikan.id7 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.id7 = defalut;
      print(tpoint_dummy.kikan.id7);
      expect(tpoint_dummy.kikan.id7 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.pts7;
      print(tpoint_dummy.kikan.pts7);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.pts7 = testData1s;
      print(tpoint_dummy.kikan.pts7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.pts7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.pts7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.pts7 = testData2s;
      print(tpoint_dummy.kikan.pts7);
      expect(tpoint_dummy.kikan.pts7 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.pts7 = defalut;
      print(tpoint_dummy.kikan.pts7);
      expect(tpoint_dummy.kikan.pts7 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.date7;
      print(tpoint_dummy.kikan.date7);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.date7 = testData1s;
      print(tpoint_dummy.kikan.date7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.date7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.date7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.date7 = testData2s;
      print(tpoint_dummy.kikan.date7);
      expect(tpoint_dummy.kikan.date7 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.date7 = defalut;
      print(tpoint_dummy.kikan.date7);
      expect(tpoint_dummy.kikan.date7 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.id8;
      print(tpoint_dummy.kikan.id8);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.id8 = testData1s;
      print(tpoint_dummy.kikan.id8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.id8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.id8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.id8 = testData2s;
      print(tpoint_dummy.kikan.id8);
      expect(tpoint_dummy.kikan.id8 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.id8 = defalut;
      print(tpoint_dummy.kikan.id8);
      expect(tpoint_dummy.kikan.id8 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.pts8;
      print(tpoint_dummy.kikan.pts8);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.pts8 = testData1s;
      print(tpoint_dummy.kikan.pts8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.pts8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.pts8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.pts8 = testData2s;
      print(tpoint_dummy.kikan.pts8);
      expect(tpoint_dummy.kikan.pts8 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.pts8 = defalut;
      print(tpoint_dummy.kikan.pts8);
      expect(tpoint_dummy.kikan.pts8 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.date8;
      print(tpoint_dummy.kikan.date8);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.date8 = testData1s;
      print(tpoint_dummy.kikan.date8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.date8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.date8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.date8 = testData2s;
      print(tpoint_dummy.kikan.date8);
      expect(tpoint_dummy.kikan.date8 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.date8 = defalut;
      print(tpoint_dummy.kikan.date8);
      expect(tpoint_dummy.kikan.date8 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.id9;
      print(tpoint_dummy.kikan.id9);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.id9 = testData1s;
      print(tpoint_dummy.kikan.id9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.id9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.id9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.id9 = testData2s;
      print(tpoint_dummy.kikan.id9);
      expect(tpoint_dummy.kikan.id9 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.id9 = defalut;
      print(tpoint_dummy.kikan.id9);
      expect(tpoint_dummy.kikan.id9 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.pts9;
      print(tpoint_dummy.kikan.pts9);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.pts9 = testData1s;
      print(tpoint_dummy.kikan.pts9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.pts9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.pts9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.pts9 = testData2s;
      print(tpoint_dummy.kikan.pts9);
      expect(tpoint_dummy.kikan.pts9 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.pts9 = defalut;
      print(tpoint_dummy.kikan.pts9);
      expect(tpoint_dummy.kikan.pts9 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.date9;
      print(tpoint_dummy.kikan.date9);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.date9 = testData1s;
      print(tpoint_dummy.kikan.date9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.date9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.date9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.date9 = testData2s;
      print(tpoint_dummy.kikan.date9);
      expect(tpoint_dummy.kikan.date9 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.date9 = defalut;
      print(tpoint_dummy.kikan.date9);
      expect(tpoint_dummy.kikan.date9 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.id10;
      print(tpoint_dummy.kikan.id10);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.id10 = testData1s;
      print(tpoint_dummy.kikan.id10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.id10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.id10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.id10 = testData2s;
      print(tpoint_dummy.kikan.id10);
      expect(tpoint_dummy.kikan.id10 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.id10 = defalut;
      print(tpoint_dummy.kikan.id10);
      expect(tpoint_dummy.kikan.id10 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.id10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.pts10;
      print(tpoint_dummy.kikan.pts10);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.pts10 = testData1s;
      print(tpoint_dummy.kikan.pts10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.pts10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.pts10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.pts10 = testData2s;
      print(tpoint_dummy.kikan.pts10);
      expect(tpoint_dummy.kikan.pts10 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.pts10 = defalut;
      print(tpoint_dummy.kikan.pts10);
      expect(tpoint_dummy.kikan.pts10 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.pts10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan.date10;
      print(tpoint_dummy.kikan.date10);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan.date10 = testData1s;
      print(tpoint_dummy.kikan.date10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan.date10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan.date10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan.date10 = testData2s;
      print(tpoint_dummy.kikan.date10);
      expect(tpoint_dummy.kikan.date10 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan.date10 = defalut;
      print(tpoint_dummy.kikan.date10);
      expect(tpoint_dummy.kikan.date10 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan.date10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.total;
      print(tpoint_dummy.kikan_use.total);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.total = testData1s;
      print(tpoint_dummy.kikan_use.total);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.total == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.total == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.total = testData2s;
      print(tpoint_dummy.kikan_use.total);
      expect(tpoint_dummy.kikan_use.total == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.total == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.total = defalut;
      print(tpoint_dummy.kikan_use.total);
      expect(tpoint_dummy.kikan_use.total == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.total == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.minlim;
      print(tpoint_dummy.kikan_use.minlim);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.minlim = testData1s;
      print(tpoint_dummy.kikan_use.minlim);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.minlim == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.minlim == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.minlim = testData2s;
      print(tpoint_dummy.kikan_use.minlim);
      expect(tpoint_dummy.kikan_use.minlim == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.minlim == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.minlim = defalut;
      print(tpoint_dummy.kikan_use.minlim);
      expect(tpoint_dummy.kikan_use.minlim == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.minlim == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.count;
      print(tpoint_dummy.kikan_use.count);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.count = testData1;
      print(tpoint_dummy.kikan_use.count);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.count == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.count == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.count = testData2;
      print(tpoint_dummy.kikan_use.count);
      expect(tpoint_dummy.kikan_use.count == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.count == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.count = defalut;
      print(tpoint_dummy.kikan_use.count);
      expect(tpoint_dummy.kikan_use.count == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.count == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.id1;
      print(tpoint_dummy.kikan_use.id1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.id1 = testData1s;
      print(tpoint_dummy.kikan_use.id1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.id1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.id1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.id1 = testData2s;
      print(tpoint_dummy.kikan_use.id1);
      expect(tpoint_dummy.kikan_use.id1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.id1 = defalut;
      print(tpoint_dummy.kikan_use.id1);
      expect(tpoint_dummy.kikan_use.id1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.pts1;
      print(tpoint_dummy.kikan_use.pts1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.pts1 = testData1s;
      print(tpoint_dummy.kikan_use.pts1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.pts1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.pts1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.pts1 = testData2s;
      print(tpoint_dummy.kikan_use.pts1);
      expect(tpoint_dummy.kikan_use.pts1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.pts1 = defalut;
      print(tpoint_dummy.kikan_use.pts1);
      expect(tpoint_dummy.kikan_use.pts1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.date1;
      print(tpoint_dummy.kikan_use.date1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.date1 = testData1s;
      print(tpoint_dummy.kikan_use.date1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.date1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.date1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.date1 = testData2s;
      print(tpoint_dummy.kikan_use.date1);
      expect(tpoint_dummy.kikan_use.date1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.date1 = defalut;
      print(tpoint_dummy.kikan_use.date1);
      expect(tpoint_dummy.kikan_use.date1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.id2;
      print(tpoint_dummy.kikan_use.id2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.id2 = testData1s;
      print(tpoint_dummy.kikan_use.id2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.id2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.id2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.id2 = testData2s;
      print(tpoint_dummy.kikan_use.id2);
      expect(tpoint_dummy.kikan_use.id2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.id2 = defalut;
      print(tpoint_dummy.kikan_use.id2);
      expect(tpoint_dummy.kikan_use.id2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.pts2;
      print(tpoint_dummy.kikan_use.pts2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.pts2 = testData1s;
      print(tpoint_dummy.kikan_use.pts2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.pts2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.pts2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.pts2 = testData2s;
      print(tpoint_dummy.kikan_use.pts2);
      expect(tpoint_dummy.kikan_use.pts2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.pts2 = defalut;
      print(tpoint_dummy.kikan_use.pts2);
      expect(tpoint_dummy.kikan_use.pts2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.date2;
      print(tpoint_dummy.kikan_use.date2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.date2 = testData1s;
      print(tpoint_dummy.kikan_use.date2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.date2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.date2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.date2 = testData2s;
      print(tpoint_dummy.kikan_use.date2);
      expect(tpoint_dummy.kikan_use.date2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.date2 = defalut;
      print(tpoint_dummy.kikan_use.date2);
      expect(tpoint_dummy.kikan_use.date2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.id3;
      print(tpoint_dummy.kikan_use.id3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.id3 = testData1s;
      print(tpoint_dummy.kikan_use.id3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.id3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.id3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.id3 = testData2s;
      print(tpoint_dummy.kikan_use.id3);
      expect(tpoint_dummy.kikan_use.id3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.id3 = defalut;
      print(tpoint_dummy.kikan_use.id3);
      expect(tpoint_dummy.kikan_use.id3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.pts3;
      print(tpoint_dummy.kikan_use.pts3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.pts3 = testData1s;
      print(tpoint_dummy.kikan_use.pts3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.pts3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.pts3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.pts3 = testData2s;
      print(tpoint_dummy.kikan_use.pts3);
      expect(tpoint_dummy.kikan_use.pts3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.pts3 = defalut;
      print(tpoint_dummy.kikan_use.pts3);
      expect(tpoint_dummy.kikan_use.pts3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.date3;
      print(tpoint_dummy.kikan_use.date3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.date3 = testData1s;
      print(tpoint_dummy.kikan_use.date3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.date3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.date3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.date3 = testData2s;
      print(tpoint_dummy.kikan_use.date3);
      expect(tpoint_dummy.kikan_use.date3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.date3 = defalut;
      print(tpoint_dummy.kikan_use.date3);
      expect(tpoint_dummy.kikan_use.date3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.id4;
      print(tpoint_dummy.kikan_use.id4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.id4 = testData1s;
      print(tpoint_dummy.kikan_use.id4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.id4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.id4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.id4 = testData2s;
      print(tpoint_dummy.kikan_use.id4);
      expect(tpoint_dummy.kikan_use.id4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.id4 = defalut;
      print(tpoint_dummy.kikan_use.id4);
      expect(tpoint_dummy.kikan_use.id4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.pts4;
      print(tpoint_dummy.kikan_use.pts4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.pts4 = testData1s;
      print(tpoint_dummy.kikan_use.pts4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.pts4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.pts4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.pts4 = testData2s;
      print(tpoint_dummy.kikan_use.pts4);
      expect(tpoint_dummy.kikan_use.pts4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.pts4 = defalut;
      print(tpoint_dummy.kikan_use.pts4);
      expect(tpoint_dummy.kikan_use.pts4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.date4;
      print(tpoint_dummy.kikan_use.date4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.date4 = testData1s;
      print(tpoint_dummy.kikan_use.date4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.date4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.date4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.date4 = testData2s;
      print(tpoint_dummy.kikan_use.date4);
      expect(tpoint_dummy.kikan_use.date4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.date4 = defalut;
      print(tpoint_dummy.kikan_use.date4);
      expect(tpoint_dummy.kikan_use.date4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.id5;
      print(tpoint_dummy.kikan_use.id5);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.id5 = testData1s;
      print(tpoint_dummy.kikan_use.id5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.id5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.id5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.id5 = testData2s;
      print(tpoint_dummy.kikan_use.id5);
      expect(tpoint_dummy.kikan_use.id5 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.id5 = defalut;
      print(tpoint_dummy.kikan_use.id5);
      expect(tpoint_dummy.kikan_use.id5 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.pts5;
      print(tpoint_dummy.kikan_use.pts5);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.pts5 = testData1s;
      print(tpoint_dummy.kikan_use.pts5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.pts5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.pts5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.pts5 = testData2s;
      print(tpoint_dummy.kikan_use.pts5);
      expect(tpoint_dummy.kikan_use.pts5 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.pts5 = defalut;
      print(tpoint_dummy.kikan_use.pts5);
      expect(tpoint_dummy.kikan_use.pts5 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.date5;
      print(tpoint_dummy.kikan_use.date5);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.date5 = testData1s;
      print(tpoint_dummy.kikan_use.date5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.date5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.date5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.date5 = testData2s;
      print(tpoint_dummy.kikan_use.date5);
      expect(tpoint_dummy.kikan_use.date5 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.date5 = defalut;
      print(tpoint_dummy.kikan_use.date5);
      expect(tpoint_dummy.kikan_use.date5 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.id6;
      print(tpoint_dummy.kikan_use.id6);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.id6 = testData1s;
      print(tpoint_dummy.kikan_use.id6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.id6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.id6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.id6 = testData2s;
      print(tpoint_dummy.kikan_use.id6);
      expect(tpoint_dummy.kikan_use.id6 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.id6 = defalut;
      print(tpoint_dummy.kikan_use.id6);
      expect(tpoint_dummy.kikan_use.id6 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.pts6;
      print(tpoint_dummy.kikan_use.pts6);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.pts6 = testData1s;
      print(tpoint_dummy.kikan_use.pts6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.pts6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.pts6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.pts6 = testData2s;
      print(tpoint_dummy.kikan_use.pts6);
      expect(tpoint_dummy.kikan_use.pts6 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.pts6 = defalut;
      print(tpoint_dummy.kikan_use.pts6);
      expect(tpoint_dummy.kikan_use.pts6 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.date6;
      print(tpoint_dummy.kikan_use.date6);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.date6 = testData1s;
      print(tpoint_dummy.kikan_use.date6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.date6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.date6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.date6 = testData2s;
      print(tpoint_dummy.kikan_use.date6);
      expect(tpoint_dummy.kikan_use.date6 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.date6 = defalut;
      print(tpoint_dummy.kikan_use.date6);
      expect(tpoint_dummy.kikan_use.date6 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.id7;
      print(tpoint_dummy.kikan_use.id7);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.id7 = testData1s;
      print(tpoint_dummy.kikan_use.id7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.id7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.id7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.id7 = testData2s;
      print(tpoint_dummy.kikan_use.id7);
      expect(tpoint_dummy.kikan_use.id7 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.id7 = defalut;
      print(tpoint_dummy.kikan_use.id7);
      expect(tpoint_dummy.kikan_use.id7 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.pts7;
      print(tpoint_dummy.kikan_use.pts7);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.pts7 = testData1s;
      print(tpoint_dummy.kikan_use.pts7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.pts7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.pts7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.pts7 = testData2s;
      print(tpoint_dummy.kikan_use.pts7);
      expect(tpoint_dummy.kikan_use.pts7 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.pts7 = defalut;
      print(tpoint_dummy.kikan_use.pts7);
      expect(tpoint_dummy.kikan_use.pts7 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.date7;
      print(tpoint_dummy.kikan_use.date7);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.date7 = testData1s;
      print(tpoint_dummy.kikan_use.date7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.date7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.date7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.date7 = testData2s;
      print(tpoint_dummy.kikan_use.date7);
      expect(tpoint_dummy.kikan_use.date7 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.date7 = defalut;
      print(tpoint_dummy.kikan_use.date7);
      expect(tpoint_dummy.kikan_use.date7 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.id8;
      print(tpoint_dummy.kikan_use.id8);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.id8 = testData1s;
      print(tpoint_dummy.kikan_use.id8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.id8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.id8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.id8 = testData2s;
      print(tpoint_dummy.kikan_use.id8);
      expect(tpoint_dummy.kikan_use.id8 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.id8 = defalut;
      print(tpoint_dummy.kikan_use.id8);
      expect(tpoint_dummy.kikan_use.id8 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.pts8;
      print(tpoint_dummy.kikan_use.pts8);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.pts8 = testData1s;
      print(tpoint_dummy.kikan_use.pts8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.pts8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.pts8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.pts8 = testData2s;
      print(tpoint_dummy.kikan_use.pts8);
      expect(tpoint_dummy.kikan_use.pts8 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.pts8 = defalut;
      print(tpoint_dummy.kikan_use.pts8);
      expect(tpoint_dummy.kikan_use.pts8 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.date8;
      print(tpoint_dummy.kikan_use.date8);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.date8 = testData1s;
      print(tpoint_dummy.kikan_use.date8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.date8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.date8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.date8 = testData2s;
      print(tpoint_dummy.kikan_use.date8);
      expect(tpoint_dummy.kikan_use.date8 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.date8 = defalut;
      print(tpoint_dummy.kikan_use.date8);
      expect(tpoint_dummy.kikan_use.date8 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.id9;
      print(tpoint_dummy.kikan_use.id9);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.id9 = testData1s;
      print(tpoint_dummy.kikan_use.id9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.id9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.id9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.id9 = testData2s;
      print(tpoint_dummy.kikan_use.id9);
      expect(tpoint_dummy.kikan_use.id9 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.id9 = defalut;
      print(tpoint_dummy.kikan_use.id9);
      expect(tpoint_dummy.kikan_use.id9 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.pts9;
      print(tpoint_dummy.kikan_use.pts9);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.pts9 = testData1s;
      print(tpoint_dummy.kikan_use.pts9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.pts9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.pts9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.pts9 = testData2s;
      print(tpoint_dummy.kikan_use.pts9);
      expect(tpoint_dummy.kikan_use.pts9 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.pts9 = defalut;
      print(tpoint_dummy.kikan_use.pts9);
      expect(tpoint_dummy.kikan_use.pts9 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.date9;
      print(tpoint_dummy.kikan_use.date9);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.date9 = testData1s;
      print(tpoint_dummy.kikan_use.date9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.date9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.date9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.date9 = testData2s;
      print(tpoint_dummy.kikan_use.date9);
      expect(tpoint_dummy.kikan_use.date9 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.date9 = defalut;
      print(tpoint_dummy.kikan_use.date9);
      expect(tpoint_dummy.kikan_use.date9 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.id10;
      print(tpoint_dummy.kikan_use.id10);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.id10 = testData1s;
      print(tpoint_dummy.kikan_use.id10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.id10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.id10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.id10 = testData2s;
      print(tpoint_dummy.kikan_use.id10);
      expect(tpoint_dummy.kikan_use.id10 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.id10 = defalut;
      print(tpoint_dummy.kikan_use.id10);
      expect(tpoint_dummy.kikan_use.id10 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.id10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.pts10;
      print(tpoint_dummy.kikan_use.pts10);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.pts10 = testData1s;
      print(tpoint_dummy.kikan_use.pts10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.pts10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.pts10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.pts10 = testData2s;
      print(tpoint_dummy.kikan_use.pts10);
      expect(tpoint_dummy.kikan_use.pts10 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.pts10 = defalut;
      print(tpoint_dummy.kikan_use.pts10);
      expect(tpoint_dummy.kikan_use.pts10 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.pts10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_use.date10;
      print(tpoint_dummy.kikan_use.date10);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_use.date10 = testData1s;
      print(tpoint_dummy.kikan_use.date10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_use.date10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_use.date10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_use.date10 = testData2s;
      print(tpoint_dummy.kikan_use.date10);
      expect(tpoint_dummy.kikan_use.date10 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_use.date10 = defalut;
      print(tpoint_dummy.kikan_use.date10);
      expect(tpoint_dummy.kikan_use.date10 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_use.date10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.total;
      print(tpoint_dummy.kikan_cancel.total);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.total = testData1s;
      print(tpoint_dummy.kikan_cancel.total);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.total == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.total == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.total = testData2s;
      print(tpoint_dummy.kikan_cancel.total);
      expect(tpoint_dummy.kikan_cancel.total == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.total == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.total = defalut;
      print(tpoint_dummy.kikan_cancel.total);
      expect(tpoint_dummy.kikan_cancel.total == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.total == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.minlim;
      print(tpoint_dummy.kikan_cancel.minlim);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.minlim = testData1s;
      print(tpoint_dummy.kikan_cancel.minlim);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.minlim == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.minlim == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.minlim = testData2s;
      print(tpoint_dummy.kikan_cancel.minlim);
      expect(tpoint_dummy.kikan_cancel.minlim == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.minlim == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.minlim = defalut;
      print(tpoint_dummy.kikan_cancel.minlim);
      expect(tpoint_dummy.kikan_cancel.minlim == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.minlim == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.count;
      print(tpoint_dummy.kikan_cancel.count);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.count = testData1;
      print(tpoint_dummy.kikan_cancel.count);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.count == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.count == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.count = testData2;
      print(tpoint_dummy.kikan_cancel.count);
      expect(tpoint_dummy.kikan_cancel.count == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.count == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.count = defalut;
      print(tpoint_dummy.kikan_cancel.count);
      expect(tpoint_dummy.kikan_cancel.count == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.count == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.id1;
      print(tpoint_dummy.kikan_cancel.id1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.id1 = testData1s;
      print(tpoint_dummy.kikan_cancel.id1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.id1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.id1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.id1 = testData2s;
      print(tpoint_dummy.kikan_cancel.id1);
      expect(tpoint_dummy.kikan_cancel.id1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.id1 = defalut;
      print(tpoint_dummy.kikan_cancel.id1);
      expect(tpoint_dummy.kikan_cancel.id1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.pts1;
      print(tpoint_dummy.kikan_cancel.pts1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.pts1 = testData1s;
      print(tpoint_dummy.kikan_cancel.pts1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.pts1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.pts1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.pts1 = testData2s;
      print(tpoint_dummy.kikan_cancel.pts1);
      expect(tpoint_dummy.kikan_cancel.pts1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.pts1 = defalut;
      print(tpoint_dummy.kikan_cancel.pts1);
      expect(tpoint_dummy.kikan_cancel.pts1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.date1;
      print(tpoint_dummy.kikan_cancel.date1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.date1 = testData1s;
      print(tpoint_dummy.kikan_cancel.date1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.date1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.date1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.date1 = testData2s;
      print(tpoint_dummy.kikan_cancel.date1);
      expect(tpoint_dummy.kikan_cancel.date1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.date1 = defalut;
      print(tpoint_dummy.kikan_cancel.date1);
      expect(tpoint_dummy.kikan_cancel.date1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.id2;
      print(tpoint_dummy.kikan_cancel.id2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.id2 = testData1s;
      print(tpoint_dummy.kikan_cancel.id2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.id2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.id2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.id2 = testData2s;
      print(tpoint_dummy.kikan_cancel.id2);
      expect(tpoint_dummy.kikan_cancel.id2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.id2 = defalut;
      print(tpoint_dummy.kikan_cancel.id2);
      expect(tpoint_dummy.kikan_cancel.id2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.pts2;
      print(tpoint_dummy.kikan_cancel.pts2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.pts2 = testData1s;
      print(tpoint_dummy.kikan_cancel.pts2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.pts2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.pts2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.pts2 = testData2s;
      print(tpoint_dummy.kikan_cancel.pts2);
      expect(tpoint_dummy.kikan_cancel.pts2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.pts2 = defalut;
      print(tpoint_dummy.kikan_cancel.pts2);
      expect(tpoint_dummy.kikan_cancel.pts2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.date2;
      print(tpoint_dummy.kikan_cancel.date2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.date2 = testData1s;
      print(tpoint_dummy.kikan_cancel.date2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.date2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.date2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.date2 = testData2s;
      print(tpoint_dummy.kikan_cancel.date2);
      expect(tpoint_dummy.kikan_cancel.date2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.date2 = defalut;
      print(tpoint_dummy.kikan_cancel.date2);
      expect(tpoint_dummy.kikan_cancel.date2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.id3;
      print(tpoint_dummy.kikan_cancel.id3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.id3 = testData1s;
      print(tpoint_dummy.kikan_cancel.id3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.id3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.id3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.id3 = testData2s;
      print(tpoint_dummy.kikan_cancel.id3);
      expect(tpoint_dummy.kikan_cancel.id3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.id3 = defalut;
      print(tpoint_dummy.kikan_cancel.id3);
      expect(tpoint_dummy.kikan_cancel.id3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.pts3;
      print(tpoint_dummy.kikan_cancel.pts3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.pts3 = testData1s;
      print(tpoint_dummy.kikan_cancel.pts3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.pts3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.pts3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.pts3 = testData2s;
      print(tpoint_dummy.kikan_cancel.pts3);
      expect(tpoint_dummy.kikan_cancel.pts3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.pts3 = defalut;
      print(tpoint_dummy.kikan_cancel.pts3);
      expect(tpoint_dummy.kikan_cancel.pts3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.date3;
      print(tpoint_dummy.kikan_cancel.date3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.date3 = testData1s;
      print(tpoint_dummy.kikan_cancel.date3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.date3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.date3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.date3 = testData2s;
      print(tpoint_dummy.kikan_cancel.date3);
      expect(tpoint_dummy.kikan_cancel.date3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.date3 = defalut;
      print(tpoint_dummy.kikan_cancel.date3);
      expect(tpoint_dummy.kikan_cancel.date3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.id4;
      print(tpoint_dummy.kikan_cancel.id4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.id4 = testData1s;
      print(tpoint_dummy.kikan_cancel.id4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.id4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.id4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.id4 = testData2s;
      print(tpoint_dummy.kikan_cancel.id4);
      expect(tpoint_dummy.kikan_cancel.id4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.id4 = defalut;
      print(tpoint_dummy.kikan_cancel.id4);
      expect(tpoint_dummy.kikan_cancel.id4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.pts4;
      print(tpoint_dummy.kikan_cancel.pts4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.pts4 = testData1s;
      print(tpoint_dummy.kikan_cancel.pts4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.pts4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.pts4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.pts4 = testData2s;
      print(tpoint_dummy.kikan_cancel.pts4);
      expect(tpoint_dummy.kikan_cancel.pts4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.pts4 = defalut;
      print(tpoint_dummy.kikan_cancel.pts4);
      expect(tpoint_dummy.kikan_cancel.pts4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.date4;
      print(tpoint_dummy.kikan_cancel.date4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.date4 = testData1s;
      print(tpoint_dummy.kikan_cancel.date4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.date4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.date4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.date4 = testData2s;
      print(tpoint_dummy.kikan_cancel.date4);
      expect(tpoint_dummy.kikan_cancel.date4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.date4 = defalut;
      print(tpoint_dummy.kikan_cancel.date4);
      expect(tpoint_dummy.kikan_cancel.date4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.id5;
      print(tpoint_dummy.kikan_cancel.id5);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.id5 = testData1s;
      print(tpoint_dummy.kikan_cancel.id5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.id5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.id5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.id5 = testData2s;
      print(tpoint_dummy.kikan_cancel.id5);
      expect(tpoint_dummy.kikan_cancel.id5 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.id5 = defalut;
      print(tpoint_dummy.kikan_cancel.id5);
      expect(tpoint_dummy.kikan_cancel.id5 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.pts5;
      print(tpoint_dummy.kikan_cancel.pts5);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.pts5 = testData1s;
      print(tpoint_dummy.kikan_cancel.pts5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.pts5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.pts5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.pts5 = testData2s;
      print(tpoint_dummy.kikan_cancel.pts5);
      expect(tpoint_dummy.kikan_cancel.pts5 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.pts5 = defalut;
      print(tpoint_dummy.kikan_cancel.pts5);
      expect(tpoint_dummy.kikan_cancel.pts5 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.date5;
      print(tpoint_dummy.kikan_cancel.date5);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.date5 = testData1s;
      print(tpoint_dummy.kikan_cancel.date5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.date5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.date5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.date5 = testData2s;
      print(tpoint_dummy.kikan_cancel.date5);
      expect(tpoint_dummy.kikan_cancel.date5 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.date5 = defalut;
      print(tpoint_dummy.kikan_cancel.date5);
      expect(tpoint_dummy.kikan_cancel.date5 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.id6;
      print(tpoint_dummy.kikan_cancel.id6);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.id6 = testData1s;
      print(tpoint_dummy.kikan_cancel.id6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.id6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.id6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.id6 = testData2s;
      print(tpoint_dummy.kikan_cancel.id6);
      expect(tpoint_dummy.kikan_cancel.id6 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.id6 = defalut;
      print(tpoint_dummy.kikan_cancel.id6);
      expect(tpoint_dummy.kikan_cancel.id6 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.pts6;
      print(tpoint_dummy.kikan_cancel.pts6);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.pts6 = testData1s;
      print(tpoint_dummy.kikan_cancel.pts6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.pts6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.pts6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.pts6 = testData2s;
      print(tpoint_dummy.kikan_cancel.pts6);
      expect(tpoint_dummy.kikan_cancel.pts6 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.pts6 = defalut;
      print(tpoint_dummy.kikan_cancel.pts6);
      expect(tpoint_dummy.kikan_cancel.pts6 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.date6;
      print(tpoint_dummy.kikan_cancel.date6);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.date6 = testData1s;
      print(tpoint_dummy.kikan_cancel.date6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.date6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.date6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.date6 = testData2s;
      print(tpoint_dummy.kikan_cancel.date6);
      expect(tpoint_dummy.kikan_cancel.date6 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.date6 = defalut;
      print(tpoint_dummy.kikan_cancel.date6);
      expect(tpoint_dummy.kikan_cancel.date6 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.id7;
      print(tpoint_dummy.kikan_cancel.id7);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.id7 = testData1s;
      print(tpoint_dummy.kikan_cancel.id7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.id7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.id7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.id7 = testData2s;
      print(tpoint_dummy.kikan_cancel.id7);
      expect(tpoint_dummy.kikan_cancel.id7 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.id7 = defalut;
      print(tpoint_dummy.kikan_cancel.id7);
      expect(tpoint_dummy.kikan_cancel.id7 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

    test('00138_element_check_00115', () async {
      print("\n********** テスト実行：00138_element_check_00115 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.pts7;
      print(tpoint_dummy.kikan_cancel.pts7);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.pts7 = testData1s;
      print(tpoint_dummy.kikan_cancel.pts7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.pts7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.pts7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.pts7 = testData2s;
      print(tpoint_dummy.kikan_cancel.pts7);
      expect(tpoint_dummy.kikan_cancel.pts7 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.pts7 = defalut;
      print(tpoint_dummy.kikan_cancel.pts7);
      expect(tpoint_dummy.kikan_cancel.pts7 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00138_element_check_00115 **********\n\n");
    });

    test('00139_element_check_00116', () async {
      print("\n********** テスト実行：00139_element_check_00116 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.date7;
      print(tpoint_dummy.kikan_cancel.date7);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.date7 = testData1s;
      print(tpoint_dummy.kikan_cancel.date7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.date7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.date7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.date7 = testData2s;
      print(tpoint_dummy.kikan_cancel.date7);
      expect(tpoint_dummy.kikan_cancel.date7 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.date7 = defalut;
      print(tpoint_dummy.kikan_cancel.date7);
      expect(tpoint_dummy.kikan_cancel.date7 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00139_element_check_00116 **********\n\n");
    });

    test('00140_element_check_00117', () async {
      print("\n********** テスト実行：00140_element_check_00117 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.id8;
      print(tpoint_dummy.kikan_cancel.id8);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.id8 = testData1s;
      print(tpoint_dummy.kikan_cancel.id8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.id8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.id8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.id8 = testData2s;
      print(tpoint_dummy.kikan_cancel.id8);
      expect(tpoint_dummy.kikan_cancel.id8 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.id8 = defalut;
      print(tpoint_dummy.kikan_cancel.id8);
      expect(tpoint_dummy.kikan_cancel.id8 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00140_element_check_00117 **********\n\n");
    });

    test('00141_element_check_00118', () async {
      print("\n********** テスト実行：00141_element_check_00118 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.pts8;
      print(tpoint_dummy.kikan_cancel.pts8);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.pts8 = testData1s;
      print(tpoint_dummy.kikan_cancel.pts8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.pts8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.pts8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.pts8 = testData2s;
      print(tpoint_dummy.kikan_cancel.pts8);
      expect(tpoint_dummy.kikan_cancel.pts8 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.pts8 = defalut;
      print(tpoint_dummy.kikan_cancel.pts8);
      expect(tpoint_dummy.kikan_cancel.pts8 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00141_element_check_00118 **********\n\n");
    });

    test('00142_element_check_00119', () async {
      print("\n********** テスト実行：00142_element_check_00119 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.date8;
      print(tpoint_dummy.kikan_cancel.date8);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.date8 = testData1s;
      print(tpoint_dummy.kikan_cancel.date8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.date8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.date8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.date8 = testData2s;
      print(tpoint_dummy.kikan_cancel.date8);
      expect(tpoint_dummy.kikan_cancel.date8 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.date8 = defalut;
      print(tpoint_dummy.kikan_cancel.date8);
      expect(tpoint_dummy.kikan_cancel.date8 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00142_element_check_00119 **********\n\n");
    });

    test('00143_element_check_00120', () async {
      print("\n********** テスト実行：00143_element_check_00120 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.id9;
      print(tpoint_dummy.kikan_cancel.id9);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.id9 = testData1s;
      print(tpoint_dummy.kikan_cancel.id9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.id9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.id9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.id9 = testData2s;
      print(tpoint_dummy.kikan_cancel.id9);
      expect(tpoint_dummy.kikan_cancel.id9 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.id9 = defalut;
      print(tpoint_dummy.kikan_cancel.id9);
      expect(tpoint_dummy.kikan_cancel.id9 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00143_element_check_00120 **********\n\n");
    });

    test('00144_element_check_00121', () async {
      print("\n********** テスト実行：00144_element_check_00121 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.pts9;
      print(tpoint_dummy.kikan_cancel.pts9);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.pts9 = testData1s;
      print(tpoint_dummy.kikan_cancel.pts9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.pts9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.pts9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.pts9 = testData2s;
      print(tpoint_dummy.kikan_cancel.pts9);
      expect(tpoint_dummy.kikan_cancel.pts9 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.pts9 = defalut;
      print(tpoint_dummy.kikan_cancel.pts9);
      expect(tpoint_dummy.kikan_cancel.pts9 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00144_element_check_00121 **********\n\n");
    });

    test('00145_element_check_00122', () async {
      print("\n********** テスト実行：00145_element_check_00122 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.date9;
      print(tpoint_dummy.kikan_cancel.date9);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.date9 = testData1s;
      print(tpoint_dummy.kikan_cancel.date9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.date9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.date9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.date9 = testData2s;
      print(tpoint_dummy.kikan_cancel.date9);
      expect(tpoint_dummy.kikan_cancel.date9 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.date9 = defalut;
      print(tpoint_dummy.kikan_cancel.date9);
      expect(tpoint_dummy.kikan_cancel.date9 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00145_element_check_00122 **********\n\n");
    });

    test('00146_element_check_00123', () async {
      print("\n********** テスト実行：00146_element_check_00123 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.id10;
      print(tpoint_dummy.kikan_cancel.id10);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.id10 = testData1s;
      print(tpoint_dummy.kikan_cancel.id10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.id10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.id10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.id10 = testData2s;
      print(tpoint_dummy.kikan_cancel.id10);
      expect(tpoint_dummy.kikan_cancel.id10 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.id10 = defalut;
      print(tpoint_dummy.kikan_cancel.id10);
      expect(tpoint_dummy.kikan_cancel.id10 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.id10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00146_element_check_00123 **********\n\n");
    });

    test('00147_element_check_00124', () async {
      print("\n********** テスト実行：00147_element_check_00124 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.pts10;
      print(tpoint_dummy.kikan_cancel.pts10);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.pts10 = testData1s;
      print(tpoint_dummy.kikan_cancel.pts10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.pts10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.pts10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.pts10 = testData2s;
      print(tpoint_dummy.kikan_cancel.pts10);
      expect(tpoint_dummy.kikan_cancel.pts10 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.pts10 = defalut;
      print(tpoint_dummy.kikan_cancel.pts10);
      expect(tpoint_dummy.kikan_cancel.pts10 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.pts10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00147_element_check_00124 **********\n\n");
    });

    test('00148_element_check_00125', () async {
      print("\n********** テスト実行：00148_element_check_00125 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.kikan_cancel.date10;
      print(tpoint_dummy.kikan_cancel.date10);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.kikan_cancel.date10 = testData1s;
      print(tpoint_dummy.kikan_cancel.date10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.kikan_cancel.date10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.kikan_cancel.date10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.kikan_cancel.date10 = testData2s;
      print(tpoint_dummy.kikan_cancel.date10);
      expect(tpoint_dummy.kikan_cancel.date10 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.kikan_cancel.date10 = defalut;
      print(tpoint_dummy.kikan_cancel.date10);
      expect(tpoint_dummy.kikan_cancel.date10 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.kikan_cancel.date10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00148_element_check_00125 **********\n\n");
    });

    test('00149_element_check_00126', () async {
      print("\n********** テスト実行：00149_element_check_00126 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon.count;
      print(tpoint_dummy.tcoupon.count);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon.count = testData1;
      print(tpoint_dummy.tcoupon.count);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon.count == testData1, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon.count == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon.count = testData2;
      print(tpoint_dummy.tcoupon.count);
      expect(tpoint_dummy.tcoupon.count == testData2, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon.count == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon.count = defalut;
      print(tpoint_dummy.tcoupon.count);
      expect(tpoint_dummy.tcoupon.count == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon.count == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00149_element_check_00126 **********\n\n");
    });

    test('00150_element_check_00127', () async {
      print("\n********** テスト実行：00150_element_check_00127 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.no;
      print(tpoint_dummy.tcoupon1.no);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.no = testData1s;
      print(tpoint_dummy.tcoupon1.no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.no == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.no == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.no = testData2s;
      print(tpoint_dummy.tcoupon1.no);
      expect(tpoint_dummy.tcoupon1.no == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.no == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.no = defalut;
      print(tpoint_dummy.tcoupon1.no);
      expect(tpoint_dummy.tcoupon1.no == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00150_element_check_00127 **********\n\n");
    });

    test('00151_element_check_00128', () async {
      print("\n********** テスト実行：00151_element_check_00128 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.prom;
      print(tpoint_dummy.tcoupon1.prom);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.prom = testData1s;
      print(tpoint_dummy.tcoupon1.prom);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.prom == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.prom == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.prom = testData2s;
      print(tpoint_dummy.tcoupon1.prom);
      expect(tpoint_dummy.tcoupon1.prom == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.prom == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.prom = defalut;
      print(tpoint_dummy.tcoupon1.prom);
      expect(tpoint_dummy.tcoupon1.prom == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.prom == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00151_element_check_00128 **********\n\n");
    });

    test('00152_element_check_00129', () async {
      print("\n********** テスト実行：00152_element_check_00129 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.jan;
      print(tpoint_dummy.tcoupon1.jan);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.jan = testData1s;
      print(tpoint_dummy.tcoupon1.jan);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.jan == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.jan == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.jan = testData2s;
      print(tpoint_dummy.tcoupon1.jan);
      expect(tpoint_dummy.tcoupon1.jan == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.jan == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.jan = defalut;
      print(tpoint_dummy.tcoupon1.jan);
      expect(tpoint_dummy.tcoupon1.jan == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.jan == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00152_element_check_00129 **********\n\n");
    });

    test('00153_element_check_00130', () async {
      print("\n********** テスト実行：00153_element_check_00130 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.kanri;
      print(tpoint_dummy.tcoupon1.kanri);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.kanri = testData1s;
      print(tpoint_dummy.tcoupon1.kanri);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.kanri == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.kanri == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.kanri = testData2s;
      print(tpoint_dummy.tcoupon1.kanri);
      expect(tpoint_dummy.tcoupon1.kanri == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.kanri == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.kanri = defalut;
      print(tpoint_dummy.tcoupon1.kanri);
      expect(tpoint_dummy.tcoupon1.kanri == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.kanri == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00153_element_check_00130 **********\n\n");
    });

    test('00154_element_check_00131', () async {
      print("\n********** テスト実行：00154_element_check_00131 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.keihyo;
      print(tpoint_dummy.tcoupon1.keihyo);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.keihyo = testData1s;
      print(tpoint_dummy.tcoupon1.keihyo);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.keihyo == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.keihyo == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.keihyo = testData2s;
      print(tpoint_dummy.tcoupon1.keihyo);
      expect(tpoint_dummy.tcoupon1.keihyo == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.keihyo == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.keihyo = defalut;
      print(tpoint_dummy.tcoupon1.keihyo);
      expect(tpoint_dummy.tcoupon1.keihyo == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.keihyo == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00154_element_check_00131 **********\n\n");
    });

    test('00155_element_check_00132', () async {
      print("\n********** テスト実行：00155_element_check_00132 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.mbr;
      print(tpoint_dummy.tcoupon1.mbr);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.mbr = testData1s;
      print(tpoint_dummy.tcoupon1.mbr);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.mbr == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.mbr == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.mbr = testData2s;
      print(tpoint_dummy.tcoupon1.mbr);
      expect(tpoint_dummy.tcoupon1.mbr == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.mbr == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.mbr = defalut;
      print(tpoint_dummy.tcoupon1.mbr);
      expect(tpoint_dummy.tcoupon1.mbr == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.mbr == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00155_element_check_00132 **********\n\n");
    });

    test('00156_element_check_00133', () async {
      print("\n********** テスト実行：00156_element_check_00133 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.shop;
      print(tpoint_dummy.tcoupon1.shop);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.shop = testData1s;
      print(tpoint_dummy.tcoupon1.shop);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.shop == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.shop == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.shop = testData2s;
      print(tpoint_dummy.tcoupon1.shop);
      expect(tpoint_dummy.tcoupon1.shop == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.shop == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.shop = defalut;
      print(tpoint_dummy.tcoupon1.shop);
      expect(tpoint_dummy.tcoupon1.shop == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.shop == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00156_element_check_00133 **********\n\n");
    });

    test('00157_element_check_00134', () async {
      print("\n********** テスト実行：00157_element_check_00134 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.txt1;
      print(tpoint_dummy.tcoupon1.txt1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.txt1 = testData1s;
      print(tpoint_dummy.tcoupon1.txt1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.txt1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.txt1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.txt1 = testData2s;
      print(tpoint_dummy.tcoupon1.txt1);
      expect(tpoint_dummy.tcoupon1.txt1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.txt1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.txt1 = defalut;
      print(tpoint_dummy.tcoupon1.txt1);
      expect(tpoint_dummy.tcoupon1.txt1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.txt1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00157_element_check_00134 **********\n\n");
    });

    test('00158_element_check_00135', () async {
      print("\n********** テスト実行：00158_element_check_00135 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.txt2;
      print(tpoint_dummy.tcoupon1.txt2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.txt2 = testData1s;
      print(tpoint_dummy.tcoupon1.txt2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.txt2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.txt2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.txt2 = testData2s;
      print(tpoint_dummy.tcoupon1.txt2);
      expect(tpoint_dummy.tcoupon1.txt2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.txt2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.txt2 = defalut;
      print(tpoint_dummy.tcoupon1.txt2);
      expect(tpoint_dummy.tcoupon1.txt2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.txt2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00158_element_check_00135 **********\n\n");
    });

    test('00159_element_check_00136', () async {
      print("\n********** テスト実行：00159_element_check_00136 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.txt3;
      print(tpoint_dummy.tcoupon1.txt3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.txt3 = testData1s;
      print(tpoint_dummy.tcoupon1.txt3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.txt3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.txt3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.txt3 = testData2s;
      print(tpoint_dummy.tcoupon1.txt3);
      expect(tpoint_dummy.tcoupon1.txt3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.txt3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.txt3 = defalut;
      print(tpoint_dummy.tcoupon1.txt3);
      expect(tpoint_dummy.tcoupon1.txt3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.txt3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00159_element_check_00136 **********\n\n");
    });

    test('00160_element_check_00137', () async {
      print("\n********** テスト実行：00160_element_check_00137 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.txt4;
      print(tpoint_dummy.tcoupon1.txt4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.txt4 = testData1s;
      print(tpoint_dummy.tcoupon1.txt4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.txt4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.txt4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.txt4 = testData2s;
      print(tpoint_dummy.tcoupon1.txt4);
      expect(tpoint_dummy.tcoupon1.txt4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.txt4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.txt4 = defalut;
      print(tpoint_dummy.tcoupon1.txt4);
      expect(tpoint_dummy.tcoupon1.txt4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.txt4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00160_element_check_00137 **********\n\n");
    });

    test('00161_element_check_00138', () async {
      print("\n********** テスト実行：00161_element_check_00138 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.kenmen;
      print(tpoint_dummy.tcoupon1.kenmen);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.kenmen = testData1s;
      print(tpoint_dummy.tcoupon1.kenmen);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.kenmen == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.kenmen == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.kenmen = testData2s;
      print(tpoint_dummy.tcoupon1.kenmen);
      expect(tpoint_dummy.tcoupon1.kenmen == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.kenmen == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.kenmen = defalut;
      print(tpoint_dummy.tcoupon1.kenmen);
      expect(tpoint_dummy.tcoupon1.kenmen == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.kenmen == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00161_element_check_00138 **********\n\n");
    });

    test('00162_element_check_00139', () async {
      print("\n********** テスト実行：00162_element_check_00139 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.kikaku;
      print(tpoint_dummy.tcoupon1.kikaku);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.kikaku = testData1s;
      print(tpoint_dummy.tcoupon1.kikaku);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.kikaku == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.kikaku == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.kikaku = testData2s;
      print(tpoint_dummy.tcoupon1.kikaku);
      expect(tpoint_dummy.tcoupon1.kikaku == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.kikaku == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.kikaku = defalut;
      print(tpoint_dummy.tcoupon1.kikaku);
      expect(tpoint_dummy.tcoupon1.kikaku == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.kikaku == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00162_element_check_00139 **********\n\n");
    });

    test('00163_element_check_00140', () async {
      print("\n********** テスト実行：00163_element_check_00140 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.limit;
      print(tpoint_dummy.tcoupon1.limit);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.limit = testData1s;
      print(tpoint_dummy.tcoupon1.limit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.limit == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.limit == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.limit = testData2s;
      print(tpoint_dummy.tcoupon1.limit);
      expect(tpoint_dummy.tcoupon1.limit == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.limit == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.limit = defalut;
      print(tpoint_dummy.tcoupon1.limit);
      expect(tpoint_dummy.tcoupon1.limit == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.limit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00163_element_check_00140 **********\n\n");
    });

    test('00164_element_check_00141', () async {
      print("\n********** テスト実行：00164_element_check_00141 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.title;
      print(tpoint_dummy.tcoupon1.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.title = testData1s;
      print(tpoint_dummy.tcoupon1.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.title = testData2s;
      print(tpoint_dummy.tcoupon1.title);
      expect(tpoint_dummy.tcoupon1.title == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.title = defalut;
      print(tpoint_dummy.tcoupon1.title);
      expect(tpoint_dummy.tcoupon1.title == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00164_element_check_00141 **********\n\n");
    });

    test('00165_element_check_00142', () async {
      print("\n********** テスト実行：00165_element_check_00142 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.subt;
      print(tpoint_dummy.tcoupon1.subt);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.subt = testData1s;
      print(tpoint_dummy.tcoupon1.subt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.subt == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.subt == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.subt = testData2s;
      print(tpoint_dummy.tcoupon1.subt);
      expect(tpoint_dummy.tcoupon1.subt == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.subt == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.subt = defalut;
      print(tpoint_dummy.tcoupon1.subt);
      expect(tpoint_dummy.tcoupon1.subt == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.subt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00165_element_check_00142 **********\n\n");
    });

    test('00166_element_check_00143', () async {
      print("\n********** テスト実行：00166_element_check_00143 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.note1;
      print(tpoint_dummy.tcoupon1.note1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.note1 = testData1s;
      print(tpoint_dummy.tcoupon1.note1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.note1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.note1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.note1 = testData2s;
      print(tpoint_dummy.tcoupon1.note1);
      expect(tpoint_dummy.tcoupon1.note1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.note1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.note1 = defalut;
      print(tpoint_dummy.tcoupon1.note1);
      expect(tpoint_dummy.tcoupon1.note1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.note1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00166_element_check_00143 **********\n\n");
    });

    test('00167_element_check_00144', () async {
      print("\n********** テスト実行：00167_element_check_00144 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.note2;
      print(tpoint_dummy.tcoupon1.note2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.note2 = testData1s;
      print(tpoint_dummy.tcoupon1.note2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.note2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.note2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.note2 = testData2s;
      print(tpoint_dummy.tcoupon1.note2);
      expect(tpoint_dummy.tcoupon1.note2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.note2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.note2 = defalut;
      print(tpoint_dummy.tcoupon1.note2);
      expect(tpoint_dummy.tcoupon1.note2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.note2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00167_element_check_00144 **********\n\n");
    });

    test('00168_element_check_00145', () async {
      print("\n********** テスト実行：00168_element_check_00145 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.info1;
      print(tpoint_dummy.tcoupon1.info1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.info1 = testData1s;
      print(tpoint_dummy.tcoupon1.info1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.info1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.info1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.info1 = testData2s;
      print(tpoint_dummy.tcoupon1.info1);
      expect(tpoint_dummy.tcoupon1.info1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.info1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.info1 = defalut;
      print(tpoint_dummy.tcoupon1.info1);
      expect(tpoint_dummy.tcoupon1.info1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.info1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00168_element_check_00145 **********\n\n");
    });

    test('00169_element_check_00146', () async {
      print("\n********** テスト実行：00169_element_check_00146 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.info2;
      print(tpoint_dummy.tcoupon1.info2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.info2 = testData1s;
      print(tpoint_dummy.tcoupon1.info2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.info2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.info2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.info2 = testData2s;
      print(tpoint_dummy.tcoupon1.info2);
      expect(tpoint_dummy.tcoupon1.info2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.info2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.info2 = defalut;
      print(tpoint_dummy.tcoupon1.info2);
      expect(tpoint_dummy.tcoupon1.info2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.info2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00169_element_check_00146 **********\n\n");
    });

    test('00170_element_check_00147', () async {
      print("\n********** テスト実行：00170_element_check_00147 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.info3;
      print(tpoint_dummy.tcoupon1.info3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.info3 = testData1s;
      print(tpoint_dummy.tcoupon1.info3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.info3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.info3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.info3 = testData2s;
      print(tpoint_dummy.tcoupon1.info3);
      expect(tpoint_dummy.tcoupon1.info3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.info3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.info3 = defalut;
      print(tpoint_dummy.tcoupon1.info3);
      expect(tpoint_dummy.tcoupon1.info3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.info3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00170_element_check_00147 **********\n\n");
    });

    test('00171_element_check_00148', () async {
      print("\n********** テスト実行：00171_element_check_00148 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.info4;
      print(tpoint_dummy.tcoupon1.info4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.info4 = testData1s;
      print(tpoint_dummy.tcoupon1.info4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.info4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.info4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.info4 = testData2s;
      print(tpoint_dummy.tcoupon1.info4);
      expect(tpoint_dummy.tcoupon1.info4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.info4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.info4 = defalut;
      print(tpoint_dummy.tcoupon1.info4);
      expect(tpoint_dummy.tcoupon1.info4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.info4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00171_element_check_00148 **********\n\n");
    });

    test('00172_element_check_00149', () async {
      print("\n********** テスト実行：00172_element_check_00149 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.urltxt;
      print(tpoint_dummy.tcoupon1.urltxt);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.urltxt = testData1s;
      print(tpoint_dummy.tcoupon1.urltxt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.urltxt == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.urltxt == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.urltxt = testData2s;
      print(tpoint_dummy.tcoupon1.urltxt);
      expect(tpoint_dummy.tcoupon1.urltxt == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.urltxt == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.urltxt = defalut;
      print(tpoint_dummy.tcoupon1.urltxt);
      expect(tpoint_dummy.tcoupon1.urltxt == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.urltxt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00172_element_check_00149 **********\n\n");
    });

    test('00173_element_check_00150', () async {
      print("\n********** テスト実行：00173_element_check_00150 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.url_1;
      print(tpoint_dummy.tcoupon1.url_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.url_1 = testData1s;
      print(tpoint_dummy.tcoupon1.url_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.url_1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.url_1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.url_1 = testData2s;
      print(tpoint_dummy.tcoupon1.url_1);
      expect(tpoint_dummy.tcoupon1.url_1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.url_1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.url_1 = defalut;
      print(tpoint_dummy.tcoupon1.url_1);
      expect(tpoint_dummy.tcoupon1.url_1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.url_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00173_element_check_00150 **********\n\n");
    });

    test('00174_element_check_00151', () async {
      print("\n********** テスト実行：00174_element_check_00151 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.url_2;
      print(tpoint_dummy.tcoupon1.url_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.url_2 = testData1s;
      print(tpoint_dummy.tcoupon1.url_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.url_2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.url_2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.url_2 = testData2s;
      print(tpoint_dummy.tcoupon1.url_2);
      expect(tpoint_dummy.tcoupon1.url_2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.url_2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.url_2 = defalut;
      print(tpoint_dummy.tcoupon1.url_2);
      expect(tpoint_dummy.tcoupon1.url_2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.url_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00174_element_check_00151 **********\n\n");
    });

    test('00175_element_check_00152', () async {
      print("\n********** テスト実行：00175_element_check_00152 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon1.url_3;
      print(tpoint_dummy.tcoupon1.url_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon1.url_3 = testData1s;
      print(tpoint_dummy.tcoupon1.url_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon1.url_3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon1.url_3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon1.url_3 = testData2s;
      print(tpoint_dummy.tcoupon1.url_3);
      expect(tpoint_dummy.tcoupon1.url_3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.url_3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon1.url_3 = defalut;
      print(tpoint_dummy.tcoupon1.url_3);
      expect(tpoint_dummy.tcoupon1.url_3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon1.url_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00175_element_check_00152 **********\n\n");
    });

    test('00176_element_check_00153', () async {
      print("\n********** テスト実行：00176_element_check_00153 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.no;
      print(tpoint_dummy.tcoupon2.no);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.no = testData1s;
      print(tpoint_dummy.tcoupon2.no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.no == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.no == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.no = testData2s;
      print(tpoint_dummy.tcoupon2.no);
      expect(tpoint_dummy.tcoupon2.no == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.no == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.no = defalut;
      print(tpoint_dummy.tcoupon2.no);
      expect(tpoint_dummy.tcoupon2.no == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00176_element_check_00153 **********\n\n");
    });

    test('00177_element_check_00154', () async {
      print("\n********** テスト実行：00177_element_check_00154 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.prom;
      print(tpoint_dummy.tcoupon2.prom);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.prom = testData1s;
      print(tpoint_dummy.tcoupon2.prom);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.prom == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.prom == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.prom = testData2s;
      print(tpoint_dummy.tcoupon2.prom);
      expect(tpoint_dummy.tcoupon2.prom == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.prom == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.prom = defalut;
      print(tpoint_dummy.tcoupon2.prom);
      expect(tpoint_dummy.tcoupon2.prom == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.prom == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00177_element_check_00154 **********\n\n");
    });

    test('00178_element_check_00155', () async {
      print("\n********** テスト実行：00178_element_check_00155 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.jan;
      print(tpoint_dummy.tcoupon2.jan);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.jan = testData1s;
      print(tpoint_dummy.tcoupon2.jan);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.jan == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.jan == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.jan = testData2s;
      print(tpoint_dummy.tcoupon2.jan);
      expect(tpoint_dummy.tcoupon2.jan == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.jan == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.jan = defalut;
      print(tpoint_dummy.tcoupon2.jan);
      expect(tpoint_dummy.tcoupon2.jan == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.jan == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00178_element_check_00155 **********\n\n");
    });

    test('00179_element_check_00156', () async {
      print("\n********** テスト実行：00179_element_check_00156 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.kanri;
      print(tpoint_dummy.tcoupon2.kanri);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.kanri = testData1s;
      print(tpoint_dummy.tcoupon2.kanri);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.kanri == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.kanri == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.kanri = testData2s;
      print(tpoint_dummy.tcoupon2.kanri);
      expect(tpoint_dummy.tcoupon2.kanri == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.kanri == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.kanri = defalut;
      print(tpoint_dummy.tcoupon2.kanri);
      expect(tpoint_dummy.tcoupon2.kanri == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.kanri == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00179_element_check_00156 **********\n\n");
    });

    test('00180_element_check_00157', () async {
      print("\n********** テスト実行：00180_element_check_00157 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.keihyo;
      print(tpoint_dummy.tcoupon2.keihyo);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.keihyo = testData1s;
      print(tpoint_dummy.tcoupon2.keihyo);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.keihyo == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.keihyo == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.keihyo = testData2s;
      print(tpoint_dummy.tcoupon2.keihyo);
      expect(tpoint_dummy.tcoupon2.keihyo == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.keihyo == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.keihyo = defalut;
      print(tpoint_dummy.tcoupon2.keihyo);
      expect(tpoint_dummy.tcoupon2.keihyo == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.keihyo == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00180_element_check_00157 **********\n\n");
    });

    test('00181_element_check_00158', () async {
      print("\n********** テスト実行：00181_element_check_00158 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.mbr;
      print(tpoint_dummy.tcoupon2.mbr);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.mbr = testData1s;
      print(tpoint_dummy.tcoupon2.mbr);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.mbr == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.mbr == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.mbr = testData2s;
      print(tpoint_dummy.tcoupon2.mbr);
      expect(tpoint_dummy.tcoupon2.mbr == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.mbr == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.mbr = defalut;
      print(tpoint_dummy.tcoupon2.mbr);
      expect(tpoint_dummy.tcoupon2.mbr == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.mbr == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00181_element_check_00158 **********\n\n");
    });

    test('00182_element_check_00159', () async {
      print("\n********** テスト実行：00182_element_check_00159 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.shop;
      print(tpoint_dummy.tcoupon2.shop);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.shop = testData1s;
      print(tpoint_dummy.tcoupon2.shop);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.shop == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.shop == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.shop = testData2s;
      print(tpoint_dummy.tcoupon2.shop);
      expect(tpoint_dummy.tcoupon2.shop == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.shop == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.shop = defalut;
      print(tpoint_dummy.tcoupon2.shop);
      expect(tpoint_dummy.tcoupon2.shop == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.shop == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00182_element_check_00159 **********\n\n");
    });

    test('00183_element_check_00160', () async {
      print("\n********** テスト実行：00183_element_check_00160 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.txt1;
      print(tpoint_dummy.tcoupon2.txt1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.txt1 = testData1s;
      print(tpoint_dummy.tcoupon2.txt1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.txt1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.txt1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.txt1 = testData2s;
      print(tpoint_dummy.tcoupon2.txt1);
      expect(tpoint_dummy.tcoupon2.txt1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.txt1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.txt1 = defalut;
      print(tpoint_dummy.tcoupon2.txt1);
      expect(tpoint_dummy.tcoupon2.txt1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.txt1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00183_element_check_00160 **********\n\n");
    });

    test('00184_element_check_00161', () async {
      print("\n********** テスト実行：00184_element_check_00161 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.txt2;
      print(tpoint_dummy.tcoupon2.txt2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.txt2 = testData1s;
      print(tpoint_dummy.tcoupon2.txt2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.txt2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.txt2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.txt2 = testData2s;
      print(tpoint_dummy.tcoupon2.txt2);
      expect(tpoint_dummy.tcoupon2.txt2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.txt2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.txt2 = defalut;
      print(tpoint_dummy.tcoupon2.txt2);
      expect(tpoint_dummy.tcoupon2.txt2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.txt2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00184_element_check_00161 **********\n\n");
    });

    test('00185_element_check_00162', () async {
      print("\n********** テスト実行：00185_element_check_00162 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.txt3;
      print(tpoint_dummy.tcoupon2.txt3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.txt3 = testData1s;
      print(tpoint_dummy.tcoupon2.txt3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.txt3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.txt3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.txt3 = testData2s;
      print(tpoint_dummy.tcoupon2.txt3);
      expect(tpoint_dummy.tcoupon2.txt3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.txt3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.txt3 = defalut;
      print(tpoint_dummy.tcoupon2.txt3);
      expect(tpoint_dummy.tcoupon2.txt3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.txt3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00185_element_check_00162 **********\n\n");
    });

    test('00186_element_check_00163', () async {
      print("\n********** テスト実行：00186_element_check_00163 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.txt4;
      print(tpoint_dummy.tcoupon2.txt4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.txt4 = testData1s;
      print(tpoint_dummy.tcoupon2.txt4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.txt4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.txt4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.txt4 = testData2s;
      print(tpoint_dummy.tcoupon2.txt4);
      expect(tpoint_dummy.tcoupon2.txt4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.txt4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.txt4 = defalut;
      print(tpoint_dummy.tcoupon2.txt4);
      expect(tpoint_dummy.tcoupon2.txt4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.txt4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00186_element_check_00163 **********\n\n");
    });

    test('00187_element_check_00164', () async {
      print("\n********** テスト実行：00187_element_check_00164 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.kenmen;
      print(tpoint_dummy.tcoupon2.kenmen);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.kenmen = testData1s;
      print(tpoint_dummy.tcoupon2.kenmen);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.kenmen == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.kenmen == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.kenmen = testData2s;
      print(tpoint_dummy.tcoupon2.kenmen);
      expect(tpoint_dummy.tcoupon2.kenmen == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.kenmen == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.kenmen = defalut;
      print(tpoint_dummy.tcoupon2.kenmen);
      expect(tpoint_dummy.tcoupon2.kenmen == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.kenmen == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00187_element_check_00164 **********\n\n");
    });

    test('00188_element_check_00165', () async {
      print("\n********** テスト実行：00188_element_check_00165 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.kikaku;
      print(tpoint_dummy.tcoupon2.kikaku);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.kikaku = testData1s;
      print(tpoint_dummy.tcoupon2.kikaku);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.kikaku == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.kikaku == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.kikaku = testData2s;
      print(tpoint_dummy.tcoupon2.kikaku);
      expect(tpoint_dummy.tcoupon2.kikaku == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.kikaku == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.kikaku = defalut;
      print(tpoint_dummy.tcoupon2.kikaku);
      expect(tpoint_dummy.tcoupon2.kikaku == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.kikaku == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00188_element_check_00165 **********\n\n");
    });

    test('00189_element_check_00166', () async {
      print("\n********** テスト実行：00189_element_check_00166 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.limit;
      print(tpoint_dummy.tcoupon2.limit);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.limit = testData1s;
      print(tpoint_dummy.tcoupon2.limit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.limit == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.limit == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.limit = testData2s;
      print(tpoint_dummy.tcoupon2.limit);
      expect(tpoint_dummy.tcoupon2.limit == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.limit == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.limit = defalut;
      print(tpoint_dummy.tcoupon2.limit);
      expect(tpoint_dummy.tcoupon2.limit == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.limit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00189_element_check_00166 **********\n\n");
    });

    test('00190_element_check_00167', () async {
      print("\n********** テスト実行：00190_element_check_00167 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.title;
      print(tpoint_dummy.tcoupon2.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.title = testData1s;
      print(tpoint_dummy.tcoupon2.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.title = testData2s;
      print(tpoint_dummy.tcoupon2.title);
      expect(tpoint_dummy.tcoupon2.title == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.title = defalut;
      print(tpoint_dummy.tcoupon2.title);
      expect(tpoint_dummy.tcoupon2.title == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00190_element_check_00167 **********\n\n");
    });

    test('00191_element_check_00168', () async {
      print("\n********** テスト実行：00191_element_check_00168 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.subt;
      print(tpoint_dummy.tcoupon2.subt);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.subt = testData1s;
      print(tpoint_dummy.tcoupon2.subt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.subt == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.subt == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.subt = testData2s;
      print(tpoint_dummy.tcoupon2.subt);
      expect(tpoint_dummy.tcoupon2.subt == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.subt == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.subt = defalut;
      print(tpoint_dummy.tcoupon2.subt);
      expect(tpoint_dummy.tcoupon2.subt == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.subt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00191_element_check_00168 **********\n\n");
    });

    test('00192_element_check_00169', () async {
      print("\n********** テスト実行：00192_element_check_00169 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.note1;
      print(tpoint_dummy.tcoupon2.note1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.note1 = testData1s;
      print(tpoint_dummy.tcoupon2.note1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.note1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.note1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.note1 = testData2s;
      print(tpoint_dummy.tcoupon2.note1);
      expect(tpoint_dummy.tcoupon2.note1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.note1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.note1 = defalut;
      print(tpoint_dummy.tcoupon2.note1);
      expect(tpoint_dummy.tcoupon2.note1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.note1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00192_element_check_00169 **********\n\n");
    });

    test('00193_element_check_00170', () async {
      print("\n********** テスト実行：00193_element_check_00170 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.note2;
      print(tpoint_dummy.tcoupon2.note2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.note2 = testData1s;
      print(tpoint_dummy.tcoupon2.note2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.note2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.note2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.note2 = testData2s;
      print(tpoint_dummy.tcoupon2.note2);
      expect(tpoint_dummy.tcoupon2.note2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.note2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.note2 = defalut;
      print(tpoint_dummy.tcoupon2.note2);
      expect(tpoint_dummy.tcoupon2.note2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.note2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00193_element_check_00170 **********\n\n");
    });

    test('00194_element_check_00171', () async {
      print("\n********** テスト実行：00194_element_check_00171 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.info1;
      print(tpoint_dummy.tcoupon2.info1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.info1 = testData1s;
      print(tpoint_dummy.tcoupon2.info1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.info1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.info1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.info1 = testData2s;
      print(tpoint_dummy.tcoupon2.info1);
      expect(tpoint_dummy.tcoupon2.info1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.info1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.info1 = defalut;
      print(tpoint_dummy.tcoupon2.info1);
      expect(tpoint_dummy.tcoupon2.info1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.info1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00194_element_check_00171 **********\n\n");
    });

    test('00195_element_check_00172', () async {
      print("\n********** テスト実行：00195_element_check_00172 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.info2;
      print(tpoint_dummy.tcoupon2.info2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.info2 = testData1s;
      print(tpoint_dummy.tcoupon2.info2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.info2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.info2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.info2 = testData2s;
      print(tpoint_dummy.tcoupon2.info2);
      expect(tpoint_dummy.tcoupon2.info2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.info2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.info2 = defalut;
      print(tpoint_dummy.tcoupon2.info2);
      expect(tpoint_dummy.tcoupon2.info2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.info2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00195_element_check_00172 **********\n\n");
    });

    test('00196_element_check_00173', () async {
      print("\n********** テスト実行：00196_element_check_00173 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.info3;
      print(tpoint_dummy.tcoupon2.info3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.info3 = testData1s;
      print(tpoint_dummy.tcoupon2.info3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.info3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.info3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.info3 = testData2s;
      print(tpoint_dummy.tcoupon2.info3);
      expect(tpoint_dummy.tcoupon2.info3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.info3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.info3 = defalut;
      print(tpoint_dummy.tcoupon2.info3);
      expect(tpoint_dummy.tcoupon2.info3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.info3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00196_element_check_00173 **********\n\n");
    });

    test('00197_element_check_00174', () async {
      print("\n********** テスト実行：00197_element_check_00174 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.info4;
      print(tpoint_dummy.tcoupon2.info4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.info4 = testData1s;
      print(tpoint_dummy.tcoupon2.info4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.info4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.info4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.info4 = testData2s;
      print(tpoint_dummy.tcoupon2.info4);
      expect(tpoint_dummy.tcoupon2.info4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.info4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.info4 = defalut;
      print(tpoint_dummy.tcoupon2.info4);
      expect(tpoint_dummy.tcoupon2.info4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.info4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00197_element_check_00174 **********\n\n");
    });

    test('00198_element_check_00175', () async {
      print("\n********** テスト実行：00198_element_check_00175 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.urltxt;
      print(tpoint_dummy.tcoupon2.urltxt);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.urltxt = testData1s;
      print(tpoint_dummy.tcoupon2.urltxt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.urltxt == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.urltxt == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.urltxt = testData2s;
      print(tpoint_dummy.tcoupon2.urltxt);
      expect(tpoint_dummy.tcoupon2.urltxt == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.urltxt == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.urltxt = defalut;
      print(tpoint_dummy.tcoupon2.urltxt);
      expect(tpoint_dummy.tcoupon2.urltxt == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.urltxt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00198_element_check_00175 **********\n\n");
    });

    test('00199_element_check_00176', () async {
      print("\n********** テスト実行：00199_element_check_00176 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.url_1;
      print(tpoint_dummy.tcoupon2.url_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.url_1 = testData1s;
      print(tpoint_dummy.tcoupon2.url_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.url_1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.url_1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.url_1 = testData2s;
      print(tpoint_dummy.tcoupon2.url_1);
      expect(tpoint_dummy.tcoupon2.url_1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.url_1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.url_1 = defalut;
      print(tpoint_dummy.tcoupon2.url_1);
      expect(tpoint_dummy.tcoupon2.url_1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.url_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00199_element_check_00176 **********\n\n");
    });

    test('00200_element_check_00177', () async {
      print("\n********** テスト実行：00200_element_check_00177 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.url_2;
      print(tpoint_dummy.tcoupon2.url_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.url_2 = testData1s;
      print(tpoint_dummy.tcoupon2.url_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.url_2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.url_2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.url_2 = testData2s;
      print(tpoint_dummy.tcoupon2.url_2);
      expect(tpoint_dummy.tcoupon2.url_2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.url_2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.url_2 = defalut;
      print(tpoint_dummy.tcoupon2.url_2);
      expect(tpoint_dummy.tcoupon2.url_2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.url_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00200_element_check_00177 **********\n\n");
    });

    test('00201_element_check_00178', () async {
      print("\n********** テスト実行：00201_element_check_00178 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon2.url_3;
      print(tpoint_dummy.tcoupon2.url_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon2.url_3 = testData1s;
      print(tpoint_dummy.tcoupon2.url_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon2.url_3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon2.url_3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon2.url_3 = testData2s;
      print(tpoint_dummy.tcoupon2.url_3);
      expect(tpoint_dummy.tcoupon2.url_3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.url_3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon2.url_3 = defalut;
      print(tpoint_dummy.tcoupon2.url_3);
      expect(tpoint_dummy.tcoupon2.url_3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon2.url_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00201_element_check_00178 **********\n\n");
    });

    test('00202_element_check_00179', () async {
      print("\n********** テスト実行：00202_element_check_00179 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.no;
      print(tpoint_dummy.tcoupon3.no);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.no = testData1s;
      print(tpoint_dummy.tcoupon3.no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.no == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.no == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.no = testData2s;
      print(tpoint_dummy.tcoupon3.no);
      expect(tpoint_dummy.tcoupon3.no == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.no == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.no = defalut;
      print(tpoint_dummy.tcoupon3.no);
      expect(tpoint_dummy.tcoupon3.no == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00202_element_check_00179 **********\n\n");
    });

    test('00203_element_check_00180', () async {
      print("\n********** テスト実行：00203_element_check_00180 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.prom;
      print(tpoint_dummy.tcoupon3.prom);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.prom = testData1s;
      print(tpoint_dummy.tcoupon3.prom);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.prom == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.prom == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.prom = testData2s;
      print(tpoint_dummy.tcoupon3.prom);
      expect(tpoint_dummy.tcoupon3.prom == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.prom == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.prom = defalut;
      print(tpoint_dummy.tcoupon3.prom);
      expect(tpoint_dummy.tcoupon3.prom == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.prom == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00203_element_check_00180 **********\n\n");
    });

    test('00204_element_check_00181', () async {
      print("\n********** テスト実行：00204_element_check_00181 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.jan;
      print(tpoint_dummy.tcoupon3.jan);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.jan = testData1s;
      print(tpoint_dummy.tcoupon3.jan);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.jan == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.jan == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.jan = testData2s;
      print(tpoint_dummy.tcoupon3.jan);
      expect(tpoint_dummy.tcoupon3.jan == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.jan == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.jan = defalut;
      print(tpoint_dummy.tcoupon3.jan);
      expect(tpoint_dummy.tcoupon3.jan == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.jan == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00204_element_check_00181 **********\n\n");
    });

    test('00205_element_check_00182', () async {
      print("\n********** テスト実行：00205_element_check_00182 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.kanri;
      print(tpoint_dummy.tcoupon3.kanri);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.kanri = testData1s;
      print(tpoint_dummy.tcoupon3.kanri);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.kanri == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.kanri == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.kanri = testData2s;
      print(tpoint_dummy.tcoupon3.kanri);
      expect(tpoint_dummy.tcoupon3.kanri == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.kanri == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.kanri = defalut;
      print(tpoint_dummy.tcoupon3.kanri);
      expect(tpoint_dummy.tcoupon3.kanri == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.kanri == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00205_element_check_00182 **********\n\n");
    });

    test('00206_element_check_00183', () async {
      print("\n********** テスト実行：00206_element_check_00183 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.keihyo;
      print(tpoint_dummy.tcoupon3.keihyo);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.keihyo = testData1s;
      print(tpoint_dummy.tcoupon3.keihyo);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.keihyo == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.keihyo == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.keihyo = testData2s;
      print(tpoint_dummy.tcoupon3.keihyo);
      expect(tpoint_dummy.tcoupon3.keihyo == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.keihyo == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.keihyo = defalut;
      print(tpoint_dummy.tcoupon3.keihyo);
      expect(tpoint_dummy.tcoupon3.keihyo == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.keihyo == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00206_element_check_00183 **********\n\n");
    });

    test('00207_element_check_00184', () async {
      print("\n********** テスト実行：00207_element_check_00184 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.mbr;
      print(tpoint_dummy.tcoupon3.mbr);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.mbr = testData1s;
      print(tpoint_dummy.tcoupon3.mbr);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.mbr == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.mbr == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.mbr = testData2s;
      print(tpoint_dummy.tcoupon3.mbr);
      expect(tpoint_dummy.tcoupon3.mbr == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.mbr == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.mbr = defalut;
      print(tpoint_dummy.tcoupon3.mbr);
      expect(tpoint_dummy.tcoupon3.mbr == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.mbr == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00207_element_check_00184 **********\n\n");
    });

    test('00208_element_check_00185', () async {
      print("\n********** テスト実行：00208_element_check_00185 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.shop;
      print(tpoint_dummy.tcoupon3.shop);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.shop = testData1s;
      print(tpoint_dummy.tcoupon3.shop);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.shop == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.shop == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.shop = testData2s;
      print(tpoint_dummy.tcoupon3.shop);
      expect(tpoint_dummy.tcoupon3.shop == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.shop == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.shop = defalut;
      print(tpoint_dummy.tcoupon3.shop);
      expect(tpoint_dummy.tcoupon3.shop == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.shop == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00208_element_check_00185 **********\n\n");
    });

    test('00209_element_check_00186', () async {
      print("\n********** テスト実行：00209_element_check_00186 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.txt1;
      print(tpoint_dummy.tcoupon3.txt1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.txt1 = testData1s;
      print(tpoint_dummy.tcoupon3.txt1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.txt1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.txt1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.txt1 = testData2s;
      print(tpoint_dummy.tcoupon3.txt1);
      expect(tpoint_dummy.tcoupon3.txt1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.txt1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.txt1 = defalut;
      print(tpoint_dummy.tcoupon3.txt1);
      expect(tpoint_dummy.tcoupon3.txt1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.txt1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00209_element_check_00186 **********\n\n");
    });

    test('00210_element_check_00187', () async {
      print("\n********** テスト実行：00210_element_check_00187 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.txt2;
      print(tpoint_dummy.tcoupon3.txt2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.txt2 = testData1s;
      print(tpoint_dummy.tcoupon3.txt2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.txt2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.txt2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.txt2 = testData2s;
      print(tpoint_dummy.tcoupon3.txt2);
      expect(tpoint_dummy.tcoupon3.txt2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.txt2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.txt2 = defalut;
      print(tpoint_dummy.tcoupon3.txt2);
      expect(tpoint_dummy.tcoupon3.txt2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.txt2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00210_element_check_00187 **********\n\n");
    });

    test('00211_element_check_00188', () async {
      print("\n********** テスト実行：00211_element_check_00188 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.txt3;
      print(tpoint_dummy.tcoupon3.txt3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.txt3 = testData1s;
      print(tpoint_dummy.tcoupon3.txt3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.txt3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.txt3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.txt3 = testData2s;
      print(tpoint_dummy.tcoupon3.txt3);
      expect(tpoint_dummy.tcoupon3.txt3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.txt3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.txt3 = defalut;
      print(tpoint_dummy.tcoupon3.txt3);
      expect(tpoint_dummy.tcoupon3.txt3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.txt3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00211_element_check_00188 **********\n\n");
    });

    test('00212_element_check_00189', () async {
      print("\n********** テスト実行：00212_element_check_00189 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.txt4;
      print(tpoint_dummy.tcoupon3.txt4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.txt4 = testData1s;
      print(tpoint_dummy.tcoupon3.txt4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.txt4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.txt4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.txt4 = testData2s;
      print(tpoint_dummy.tcoupon3.txt4);
      expect(tpoint_dummy.tcoupon3.txt4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.txt4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.txt4 = defalut;
      print(tpoint_dummy.tcoupon3.txt4);
      expect(tpoint_dummy.tcoupon3.txt4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.txt4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00212_element_check_00189 **********\n\n");
    });

    test('00213_element_check_00190', () async {
      print("\n********** テスト実行：00213_element_check_00190 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.kenmen;
      print(tpoint_dummy.tcoupon3.kenmen);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.kenmen = testData1s;
      print(tpoint_dummy.tcoupon3.kenmen);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.kenmen == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.kenmen == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.kenmen = testData2s;
      print(tpoint_dummy.tcoupon3.kenmen);
      expect(tpoint_dummy.tcoupon3.kenmen == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.kenmen == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.kenmen = defalut;
      print(tpoint_dummy.tcoupon3.kenmen);
      expect(tpoint_dummy.tcoupon3.kenmen == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.kenmen == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00213_element_check_00190 **********\n\n");
    });

    test('00214_element_check_00191', () async {
      print("\n********** テスト実行：00214_element_check_00191 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.kikaku;
      print(tpoint_dummy.tcoupon3.kikaku);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.kikaku = testData1s;
      print(tpoint_dummy.tcoupon3.kikaku);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.kikaku == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.kikaku == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.kikaku = testData2s;
      print(tpoint_dummy.tcoupon3.kikaku);
      expect(tpoint_dummy.tcoupon3.kikaku == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.kikaku == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.kikaku = defalut;
      print(tpoint_dummy.tcoupon3.kikaku);
      expect(tpoint_dummy.tcoupon3.kikaku == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.kikaku == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00214_element_check_00191 **********\n\n");
    });

    test('00215_element_check_00192', () async {
      print("\n********** テスト実行：00215_element_check_00192 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.limit;
      print(tpoint_dummy.tcoupon3.limit);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.limit = testData1s;
      print(tpoint_dummy.tcoupon3.limit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.limit == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.limit == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.limit = testData2s;
      print(tpoint_dummy.tcoupon3.limit);
      expect(tpoint_dummy.tcoupon3.limit == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.limit == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.limit = defalut;
      print(tpoint_dummy.tcoupon3.limit);
      expect(tpoint_dummy.tcoupon3.limit == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.limit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00215_element_check_00192 **********\n\n");
    });

    test('00216_element_check_00193', () async {
      print("\n********** テスト実行：00216_element_check_00193 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.title;
      print(tpoint_dummy.tcoupon3.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.title = testData1s;
      print(tpoint_dummy.tcoupon3.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.title = testData2s;
      print(tpoint_dummy.tcoupon3.title);
      expect(tpoint_dummy.tcoupon3.title == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.title = defalut;
      print(tpoint_dummy.tcoupon3.title);
      expect(tpoint_dummy.tcoupon3.title == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00216_element_check_00193 **********\n\n");
    });

    test('00217_element_check_00194', () async {
      print("\n********** テスト実行：00217_element_check_00194 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.subt;
      print(tpoint_dummy.tcoupon3.subt);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.subt = testData1s;
      print(tpoint_dummy.tcoupon3.subt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.subt == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.subt == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.subt = testData2s;
      print(tpoint_dummy.tcoupon3.subt);
      expect(tpoint_dummy.tcoupon3.subt == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.subt == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.subt = defalut;
      print(tpoint_dummy.tcoupon3.subt);
      expect(tpoint_dummy.tcoupon3.subt == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.subt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00217_element_check_00194 **********\n\n");
    });

    test('00218_element_check_00195', () async {
      print("\n********** テスト実行：00218_element_check_00195 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.note1;
      print(tpoint_dummy.tcoupon3.note1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.note1 = testData1s;
      print(tpoint_dummy.tcoupon3.note1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.note1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.note1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.note1 = testData2s;
      print(tpoint_dummy.tcoupon3.note1);
      expect(tpoint_dummy.tcoupon3.note1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.note1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.note1 = defalut;
      print(tpoint_dummy.tcoupon3.note1);
      expect(tpoint_dummy.tcoupon3.note1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.note1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00218_element_check_00195 **********\n\n");
    });

    test('00219_element_check_00196', () async {
      print("\n********** テスト実行：00219_element_check_00196 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.note2;
      print(tpoint_dummy.tcoupon3.note2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.note2 = testData1s;
      print(tpoint_dummy.tcoupon3.note2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.note2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.note2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.note2 = testData2s;
      print(tpoint_dummy.tcoupon3.note2);
      expect(tpoint_dummy.tcoupon3.note2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.note2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.note2 = defalut;
      print(tpoint_dummy.tcoupon3.note2);
      expect(tpoint_dummy.tcoupon3.note2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.note2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00219_element_check_00196 **********\n\n");
    });

    test('00220_element_check_00197', () async {
      print("\n********** テスト実行：00220_element_check_00197 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.info1;
      print(tpoint_dummy.tcoupon3.info1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.info1 = testData1s;
      print(tpoint_dummy.tcoupon3.info1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.info1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.info1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.info1 = testData2s;
      print(tpoint_dummy.tcoupon3.info1);
      expect(tpoint_dummy.tcoupon3.info1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.info1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.info1 = defalut;
      print(tpoint_dummy.tcoupon3.info1);
      expect(tpoint_dummy.tcoupon3.info1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.info1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00220_element_check_00197 **********\n\n");
    });

    test('00221_element_check_00198', () async {
      print("\n********** テスト実行：00221_element_check_00198 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.info2;
      print(tpoint_dummy.tcoupon3.info2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.info2 = testData1s;
      print(tpoint_dummy.tcoupon3.info2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.info2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.info2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.info2 = testData2s;
      print(tpoint_dummy.tcoupon3.info2);
      expect(tpoint_dummy.tcoupon3.info2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.info2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.info2 = defalut;
      print(tpoint_dummy.tcoupon3.info2);
      expect(tpoint_dummy.tcoupon3.info2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.info2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00221_element_check_00198 **********\n\n");
    });

    test('00222_element_check_00199', () async {
      print("\n********** テスト実行：00222_element_check_00199 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.info3;
      print(tpoint_dummy.tcoupon3.info3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.info3 = testData1s;
      print(tpoint_dummy.tcoupon3.info3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.info3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.info3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.info3 = testData2s;
      print(tpoint_dummy.tcoupon3.info3);
      expect(tpoint_dummy.tcoupon3.info3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.info3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.info3 = defalut;
      print(tpoint_dummy.tcoupon3.info3);
      expect(tpoint_dummy.tcoupon3.info3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.info3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00222_element_check_00199 **********\n\n");
    });

    test('00223_element_check_00200', () async {
      print("\n********** テスト実行：00223_element_check_00200 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.info4;
      print(tpoint_dummy.tcoupon3.info4);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.info4 = testData1s;
      print(tpoint_dummy.tcoupon3.info4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.info4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.info4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.info4 = testData2s;
      print(tpoint_dummy.tcoupon3.info4);
      expect(tpoint_dummy.tcoupon3.info4 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.info4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.info4 = defalut;
      print(tpoint_dummy.tcoupon3.info4);
      expect(tpoint_dummy.tcoupon3.info4 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.info4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00223_element_check_00200 **********\n\n");
    });

    test('00224_element_check_00201', () async {
      print("\n********** テスト実行：00224_element_check_00201 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.urltxt;
      print(tpoint_dummy.tcoupon3.urltxt);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.urltxt = testData1s;
      print(tpoint_dummy.tcoupon3.urltxt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.urltxt == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.urltxt == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.urltxt = testData2s;
      print(tpoint_dummy.tcoupon3.urltxt);
      expect(tpoint_dummy.tcoupon3.urltxt == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.urltxt == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.urltxt = defalut;
      print(tpoint_dummy.tcoupon3.urltxt);
      expect(tpoint_dummy.tcoupon3.urltxt == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.urltxt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00224_element_check_00201 **********\n\n");
    });

    test('00225_element_check_00202', () async {
      print("\n********** テスト実行：00225_element_check_00202 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.url_1;
      print(tpoint_dummy.tcoupon3.url_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.url_1 = testData1s;
      print(tpoint_dummy.tcoupon3.url_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.url_1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.url_1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.url_1 = testData2s;
      print(tpoint_dummy.tcoupon3.url_1);
      expect(tpoint_dummy.tcoupon3.url_1 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.url_1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.url_1 = defalut;
      print(tpoint_dummy.tcoupon3.url_1);
      expect(tpoint_dummy.tcoupon3.url_1 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.url_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00225_element_check_00202 **********\n\n");
    });

    test('00226_element_check_00203', () async {
      print("\n********** テスト実行：00226_element_check_00203 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.url_2;
      print(tpoint_dummy.tcoupon3.url_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.url_2 = testData1s;
      print(tpoint_dummy.tcoupon3.url_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.url_2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.url_2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.url_2 = testData2s;
      print(tpoint_dummy.tcoupon3.url_2);
      expect(tpoint_dummy.tcoupon3.url_2 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.url_2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.url_2 = defalut;
      print(tpoint_dummy.tcoupon3.url_2);
      expect(tpoint_dummy.tcoupon3.url_2 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.url_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00226_element_check_00203 **********\n\n");
    });

    test('00227_element_check_00204', () async {
      print("\n********** テスト実行：00227_element_check_00204 **********");

      tpoint_dummy = Tpoint_dummyJsonFile();
      allPropatyCheckInit(tpoint_dummy);

      // ①loadを実行する。
      await tpoint_dummy.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = tpoint_dummy.tcoupon3.url_3;
      print(tpoint_dummy.tcoupon3.url_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      tpoint_dummy.tcoupon3.url_3 = testData1s;
      print(tpoint_dummy.tcoupon3.url_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(tpoint_dummy.tcoupon3.url_3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await tpoint_dummy.save();
      await tpoint_dummy.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(tpoint_dummy.tcoupon3.url_3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      tpoint_dummy.tcoupon3.url_3 = testData2s;
      print(tpoint_dummy.tcoupon3.url_3);
      expect(tpoint_dummy.tcoupon3.url_3 == testData2s, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.url_3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      tpoint_dummy.tcoupon3.url_3 = defalut;
      print(tpoint_dummy.tcoupon3.url_3);
      expect(tpoint_dummy.tcoupon3.url_3 == defalut, true);
      await tpoint_dummy.save();
      await tpoint_dummy.load();
      expect(tpoint_dummy.tcoupon3.url_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(tpoint_dummy, true);

      print("********** テスト終了：00227_element_check_00204 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Tpoint_dummyJsonFile test)
{
  expect(test.tpoint.pts, 0);
  expect(test.tpoint.ret_cd, "");
  expect(test.tpoint.err_flg, 0);
  expect(test.tpoint_use.pts, 0);
  expect(test.tpoint_use.ret_cd, "");
  expect(test.tpoint_use.err_flg, 0);
  expect(test.tpoint_cancel.pts, 0);
  expect(test.tpoint_cancel.ret_cd, "");
  expect(test.tpoint_cancel.err_flg, 0);
  expect(test.mobile.kaiin_id, "");
  expect(test.tmoney.ret_cd, "");
  expect(test.tmoney.avbl, 0);
  expect(test.tmoney.first, 0);
  expect(test.tmoney.bal, 0);
  expect(test.tmoney_chrg.ret_cd, "");
  expect(test.tmoney_chrg.err_flg, 0);
  expect(test.tmoney_chrg_rc.ret_cd, "");
  expect(test.tmoney_chrg_rc.err_flg, 0);
  expect(test.tmoney_chrg_vd.ret_cd, "");
  expect(test.tmoney_chrg_vd.err_flg, 0);
  expect(test.tmoney_tran.ret_cd, "");
  expect(test.tmoney_tran.err_flg, 0);
  expect(test.tmoney_tran_rc.ret_cd, "");
  expect(test.tmoney_tran_rc.err_flg, 0);
  expect(test.tmoney_tran_vd.ret_cd, "");
  expect(test.tmoney_tran_vd.err_flg, 0);
  expect(test.kikan.total, "");
  expect(test.kikan.minlim, "");
  expect(test.kikan.count, 0);
  expect(test.kikan.id1, "");
  expect(test.kikan.pts1, "");
  expect(test.kikan.date1, "");
  expect(test.kikan.id2, "");
  expect(test.kikan.pts2, "");
  expect(test.kikan.date2, "");
  expect(test.kikan.id3, "");
  expect(test.kikan.pts3, "");
  expect(test.kikan.date3, "");
  expect(test.kikan.id4, "");
  expect(test.kikan.pts4, "");
  expect(test.kikan.date4, "");
  expect(test.kikan.id5, "");
  expect(test.kikan.pts5, "");
  expect(test.kikan.date5, "");
  expect(test.kikan.id6, "");
  expect(test.kikan.pts6, "");
  expect(test.kikan.date6, "");
  expect(test.kikan.id7, "");
  expect(test.kikan.pts7, "");
  expect(test.kikan.date7, "");
  expect(test.kikan.id8, "");
  expect(test.kikan.pts8, "");
  expect(test.kikan.date8, "");
  expect(test.kikan.id9, "");
  expect(test.kikan.pts9, "");
  expect(test.kikan.date9, "");
  expect(test.kikan.id10, "");
  expect(test.kikan.pts10, "");
  expect(test.kikan.date10, "");
  expect(test.kikan_use.total, "");
  expect(test.kikan_use.minlim, "");
  expect(test.kikan_use.count, 0);
  expect(test.kikan_use.id1, "");
  expect(test.kikan_use.pts1, "");
  expect(test.kikan_use.date1, "");
  expect(test.kikan_use.id2, "");
  expect(test.kikan_use.pts2, "");
  expect(test.kikan_use.date2, "");
  expect(test.kikan_use.id3, "");
  expect(test.kikan_use.pts3, "");
  expect(test.kikan_use.date3, "");
  expect(test.kikan_use.id4, "");
  expect(test.kikan_use.pts4, "");
  expect(test.kikan_use.date4, "");
  expect(test.kikan_use.id5, "");
  expect(test.kikan_use.pts5, "");
  expect(test.kikan_use.date5, "");
  expect(test.kikan_use.id6, "");
  expect(test.kikan_use.pts6, "");
  expect(test.kikan_use.date6, "");
  expect(test.kikan_use.id7, "");
  expect(test.kikan_use.pts7, "");
  expect(test.kikan_use.date7, "");
  expect(test.kikan_use.id8, "");
  expect(test.kikan_use.pts8, "");
  expect(test.kikan_use.date8, "");
  expect(test.kikan_use.id9, "");
  expect(test.kikan_use.pts9, "");
  expect(test.kikan_use.date9, "");
  expect(test.kikan_use.id10, "");
  expect(test.kikan_use.pts10, "");
  expect(test.kikan_use.date10, "");
  expect(test.kikan_cancel.total, "");
  expect(test.kikan_cancel.minlim, "");
  expect(test.kikan_cancel.count, 0);
  expect(test.kikan_cancel.id1, "");
  expect(test.kikan_cancel.pts1, "");
  expect(test.kikan_cancel.date1, "");
  expect(test.kikan_cancel.id2, "");
  expect(test.kikan_cancel.pts2, "");
  expect(test.kikan_cancel.date2, "");
  expect(test.kikan_cancel.id3, "");
  expect(test.kikan_cancel.pts3, "");
  expect(test.kikan_cancel.date3, "");
  expect(test.kikan_cancel.id4, "");
  expect(test.kikan_cancel.pts4, "");
  expect(test.kikan_cancel.date4, "");
  expect(test.kikan_cancel.id5, "");
  expect(test.kikan_cancel.pts5, "");
  expect(test.kikan_cancel.date5, "");
  expect(test.kikan_cancel.id6, "");
  expect(test.kikan_cancel.pts6, "");
  expect(test.kikan_cancel.date6, "");
  expect(test.kikan_cancel.id7, "");
  expect(test.kikan_cancel.pts7, "");
  expect(test.kikan_cancel.date7, "");
  expect(test.kikan_cancel.id8, "");
  expect(test.kikan_cancel.pts8, "");
  expect(test.kikan_cancel.date8, "");
  expect(test.kikan_cancel.id9, "");
  expect(test.kikan_cancel.pts9, "");
  expect(test.kikan_cancel.date9, "");
  expect(test.kikan_cancel.id10, "");
  expect(test.kikan_cancel.pts10, "");
  expect(test.kikan_cancel.date10, "");
  expect(test.tcoupon.count, 0);
  expect(test.tcoupon1.no, "");
  expect(test.tcoupon1.prom, "");
  expect(test.tcoupon1.jan, "");
  expect(test.tcoupon1.kanri, "");
  expect(test.tcoupon1.keihyo, "");
  expect(test.tcoupon1.mbr, "");
  expect(test.tcoupon1.shop, "");
  expect(test.tcoupon1.txt1, "");
  expect(test.tcoupon1.txt2, "");
  expect(test.tcoupon1.txt3, "");
  expect(test.tcoupon1.txt4, "");
  expect(test.tcoupon1.kenmen, "");
  expect(test.tcoupon1.kikaku, "");
  expect(test.tcoupon1.limit, "");
  expect(test.tcoupon1.title, "");
  expect(test.tcoupon1.subt, "");
  expect(test.tcoupon1.note1, "");
  expect(test.tcoupon1.note2, "");
  expect(test.tcoupon1.info1, "");
  expect(test.tcoupon1.info2, "");
  expect(test.tcoupon1.info3, "");
  expect(test.tcoupon1.info4, "");
  expect(test.tcoupon1.urltxt, "");
  expect(test.tcoupon1.url_1, "");
  expect(test.tcoupon1.url_2, "");
  expect(test.tcoupon1.url_3, "");
  expect(test.tcoupon2.no, "");
  expect(test.tcoupon2.prom, "");
  expect(test.tcoupon2.jan, "");
  expect(test.tcoupon2.kanri, "");
  expect(test.tcoupon2.keihyo, "");
  expect(test.tcoupon2.mbr, "");
  expect(test.tcoupon2.shop, "");
  expect(test.tcoupon2.txt1, "");
  expect(test.tcoupon2.txt2, "");
  expect(test.tcoupon2.txt3, "");
  expect(test.tcoupon2.txt4, "");
  expect(test.tcoupon2.kenmen, "");
  expect(test.tcoupon2.kikaku, "");
  expect(test.tcoupon2.limit, "");
  expect(test.tcoupon2.title, "");
  expect(test.tcoupon2.subt, "");
  expect(test.tcoupon2.note1, "");
  expect(test.tcoupon2.note2, "");
  expect(test.tcoupon2.info1, "");
  expect(test.tcoupon2.info2, "");
  expect(test.tcoupon2.info3, "");
  expect(test.tcoupon2.info4, "");
  expect(test.tcoupon2.urltxt, "");
  expect(test.tcoupon2.url_1, "");
  expect(test.tcoupon2.url_2, "");
  expect(test.tcoupon2.url_3, "");
  expect(test.tcoupon3.no, "");
  expect(test.tcoupon3.prom, "");
  expect(test.tcoupon3.jan, "");
  expect(test.tcoupon3.kanri, "");
  expect(test.tcoupon3.keihyo, "");
  expect(test.tcoupon3.mbr, "");
  expect(test.tcoupon3.shop, "");
  expect(test.tcoupon3.txt1, "");
  expect(test.tcoupon3.txt2, "");
  expect(test.tcoupon3.txt3, "");
  expect(test.tcoupon3.txt4, "");
  expect(test.tcoupon3.kenmen, "");
  expect(test.tcoupon3.kikaku, "");
  expect(test.tcoupon3.limit, "");
  expect(test.tcoupon3.title, "");
  expect(test.tcoupon3.subt, "");
  expect(test.tcoupon3.note1, "");
  expect(test.tcoupon3.note2, "");
  expect(test.tcoupon3.info1, "");
  expect(test.tcoupon3.info2, "");
  expect(test.tcoupon3.info3, "");
  expect(test.tcoupon3.info4, "");
  expect(test.tcoupon3.urltxt, "");
  expect(test.tcoupon3.url_1, "");
  expect(test.tcoupon3.url_2, "");
  expect(test.tcoupon3.url_3, "");
}

void allPropatyCheck(Tpoint_dummyJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.tpoint.pts, 10000);
  }
  expect(test.tpoint.ret_cd, "00");
  expect(test.tpoint.err_flg, 0);
  expect(test.tpoint_use.pts, 1000);
  expect(test.tpoint_use.ret_cd, "00");
  expect(test.tpoint_use.err_flg, 0);
  expect(test.tpoint_cancel.pts, 2000);
  expect(test.tpoint_cancel.ret_cd, "00");
  expect(test.tpoint_cancel.err_flg, 0);
  expect(test.mobile.kaiin_id, "1234567890123456");
  expect(test.tmoney.ret_cd, "00");
  expect(test.tmoney.avbl, 1);
  expect(test.tmoney.first, 1);
  expect(test.tmoney.bal, 1000);
  expect(test.tmoney_chrg.ret_cd, "00");
  expect(test.tmoney_chrg.err_flg, 0);
  expect(test.tmoney_chrg_rc.ret_cd, "00");
  expect(test.tmoney_chrg_rc.err_flg, 0);
  expect(test.tmoney_chrg_vd.ret_cd, "00");
  expect(test.tmoney_chrg_vd.err_flg, 0);
  expect(test.tmoney_tran.ret_cd, "00");
  expect(test.tmoney_tran.err_flg, 0);
  expect(test.tmoney_tran_rc.ret_cd, "00");
  expect(test.tmoney_tran_rc.err_flg, 0);
  expect(test.tmoney_tran_vd.ret_cd, "00");
  expect(test.tmoney_tran_vd.err_flg, 0);
  expect(test.kikan.total, "");
  expect(test.kikan.minlim, "");
  expect(test.kikan.count, 0);
  expect(test.kikan.id1, "");
  expect(test.kikan.pts1, "");
  expect(test.kikan.date1, "");
  expect(test.kikan.id2, "");
  expect(test.kikan.pts2, "");
  expect(test.kikan.date2, "");
  expect(test.kikan.id3, "");
  expect(test.kikan.pts3, "");
  expect(test.kikan.date3, "");
  expect(test.kikan.id4, "");
  expect(test.kikan.pts4, "");
  expect(test.kikan.date4, "");
  expect(test.kikan.id5, "");
  expect(test.kikan.pts5, "");
  expect(test.kikan.date5, "");
  expect(test.kikan.id6, "");
  expect(test.kikan.pts6, "");
  expect(test.kikan.date6, "");
  expect(test.kikan.id7, "");
  expect(test.kikan.pts7, "");
  expect(test.kikan.date7, "");
  expect(test.kikan.id8, "");
  expect(test.kikan.pts8, "");
  expect(test.kikan.date8, "");
  expect(test.kikan.id9, "");
  expect(test.kikan.pts9, "");
  expect(test.kikan.date9, "");
  expect(test.kikan.id10, "");
  expect(test.kikan.pts10, "");
  expect(test.kikan.date10, "");
  expect(test.kikan_use.total, "");
  expect(test.kikan_use.minlim, "");
  expect(test.kikan_use.count, 0);
  expect(test.kikan_use.id1, "");
  expect(test.kikan_use.pts1, "");
  expect(test.kikan_use.date1, "");
  expect(test.kikan_use.id2, "");
  expect(test.kikan_use.pts2, "");
  expect(test.kikan_use.date2, "");
  expect(test.kikan_use.id3, "");
  expect(test.kikan_use.pts3, "");
  expect(test.kikan_use.date3, "");
  expect(test.kikan_use.id4, "");
  expect(test.kikan_use.pts4, "");
  expect(test.kikan_use.date4, "");
  expect(test.kikan_use.id5, "");
  expect(test.kikan_use.pts5, "");
  expect(test.kikan_use.date5, "");
  expect(test.kikan_use.id6, "");
  expect(test.kikan_use.pts6, "");
  expect(test.kikan_use.date6, "");
  expect(test.kikan_use.id7, "");
  expect(test.kikan_use.pts7, "");
  expect(test.kikan_use.date7, "");
  expect(test.kikan_use.id8, "");
  expect(test.kikan_use.pts8, "");
  expect(test.kikan_use.date8, "");
  expect(test.kikan_use.id9, "");
  expect(test.kikan_use.pts9, "");
  expect(test.kikan_use.date9, "");
  expect(test.kikan_use.id10, "");
  expect(test.kikan_use.pts10, "");
  expect(test.kikan_use.date10, "");
  expect(test.kikan_cancel.total, "");
  expect(test.kikan_cancel.minlim, "");
  expect(test.kikan_cancel.count, 0);
  expect(test.kikan_cancel.id1, "");
  expect(test.kikan_cancel.pts1, "");
  expect(test.kikan_cancel.date1, "");
  expect(test.kikan_cancel.id2, "");
  expect(test.kikan_cancel.pts2, "");
  expect(test.kikan_cancel.date2, "");
  expect(test.kikan_cancel.id3, "");
  expect(test.kikan_cancel.pts3, "");
  expect(test.kikan_cancel.date3, "");
  expect(test.kikan_cancel.id4, "");
  expect(test.kikan_cancel.pts4, "");
  expect(test.kikan_cancel.date4, "");
  expect(test.kikan_cancel.id5, "");
  expect(test.kikan_cancel.pts5, "");
  expect(test.kikan_cancel.date5, "");
  expect(test.kikan_cancel.id6, "");
  expect(test.kikan_cancel.pts6, "");
  expect(test.kikan_cancel.date6, "");
  expect(test.kikan_cancel.id7, "");
  expect(test.kikan_cancel.pts7, "");
  expect(test.kikan_cancel.date7, "");
  expect(test.kikan_cancel.id8, "");
  expect(test.kikan_cancel.pts8, "");
  expect(test.kikan_cancel.date8, "");
  expect(test.kikan_cancel.id9, "");
  expect(test.kikan_cancel.pts9, "");
  expect(test.kikan_cancel.date9, "");
  expect(test.kikan_cancel.id10, "");
  expect(test.kikan_cancel.pts10, "");
  expect(test.kikan_cancel.date10, "");
  expect(test.tcoupon.count, 0);
  expect(test.tcoupon1.no, "");
  expect(test.tcoupon1.prom, "");
  expect(test.tcoupon1.jan, "");
  expect(test.tcoupon1.kanri, "");
  expect(test.tcoupon1.keihyo, "");
  expect(test.tcoupon1.mbr, "");
  expect(test.tcoupon1.shop, "");
  expect(test.tcoupon1.txt1, "");
  expect(test.tcoupon1.txt2, "");
  expect(test.tcoupon1.txt3, "");
  expect(test.tcoupon1.txt4, "");
  expect(test.tcoupon1.kenmen, "");
  expect(test.tcoupon1.kikaku, "");
  expect(test.tcoupon1.limit, "");
  expect(test.tcoupon1.title, "");
  expect(test.tcoupon1.subt, "");
  expect(test.tcoupon1.note1, "");
  expect(test.tcoupon1.note2, "");
  expect(test.tcoupon1.info1, "");
  expect(test.tcoupon1.info2, "");
  expect(test.tcoupon1.info3, "");
  expect(test.tcoupon1.info4, "");
  expect(test.tcoupon1.urltxt, "");
  expect(test.tcoupon1.url_1, "");
  expect(test.tcoupon1.url_2, "");
  expect(test.tcoupon1.url_3, "");
  expect(test.tcoupon2.no, "");
  expect(test.tcoupon2.prom, "");
  expect(test.tcoupon2.jan, "");
  expect(test.tcoupon2.kanri, "");
  expect(test.tcoupon2.keihyo, "");
  expect(test.tcoupon2.mbr, "");
  expect(test.tcoupon2.shop, "");
  expect(test.tcoupon2.txt1, "");
  expect(test.tcoupon2.txt2, "");
  expect(test.tcoupon2.txt3, "");
  expect(test.tcoupon2.txt4, "");
  expect(test.tcoupon2.kenmen, "");
  expect(test.tcoupon2.kikaku, "");
  expect(test.tcoupon2.limit, "");
  expect(test.tcoupon2.title, "");
  expect(test.tcoupon2.subt, "");
  expect(test.tcoupon2.note1, "");
  expect(test.tcoupon2.note2, "");
  expect(test.tcoupon2.info1, "");
  expect(test.tcoupon2.info2, "");
  expect(test.tcoupon2.info3, "");
  expect(test.tcoupon2.info4, "");
  expect(test.tcoupon2.urltxt, "");
  expect(test.tcoupon2.url_1, "");
  expect(test.tcoupon2.url_2, "");
  expect(test.tcoupon2.url_3, "");
  expect(test.tcoupon3.no, "");
  expect(test.tcoupon3.prom, "");
  expect(test.tcoupon3.jan, "");
  expect(test.tcoupon3.kanri, "");
  expect(test.tcoupon3.keihyo, "");
  expect(test.tcoupon3.mbr, "");
  expect(test.tcoupon3.shop, "");
  expect(test.tcoupon3.txt1, "");
  expect(test.tcoupon3.txt2, "");
  expect(test.tcoupon3.txt3, "");
  expect(test.tcoupon3.txt4, "");
  expect(test.tcoupon3.kenmen, "");
  expect(test.tcoupon3.kikaku, "");
  expect(test.tcoupon3.limit, "");
  expect(test.tcoupon3.title, "");
  expect(test.tcoupon3.subt, "");
  expect(test.tcoupon3.note1, "");
  expect(test.tcoupon3.note2, "");
  expect(test.tcoupon3.info1, "");
  expect(test.tcoupon3.info2, "");
  expect(test.tcoupon3.info3, "");
  expect(test.tcoupon3.info4, "");
  expect(test.tcoupon3.urltxt, "");
  expect(test.tcoupon3.url_1, "");
  expect(test.tcoupon3.url_2, "");
  expect(test.tcoupon3.url_3, "");
}

