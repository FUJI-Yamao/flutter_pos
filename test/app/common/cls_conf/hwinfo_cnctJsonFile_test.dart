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
import '../../../../lib/app/common/cls_conf/hwinfo_cnctJsonFile.dart';

late Hwinfo_cnctJsonFile hwinfo_cnct;

void main(){
  hwinfo_cnctJsonFile_test();
}

void hwinfo_cnctJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "hwinfo_cnct.json";
  const String section = "comm";
  const String key = "head";
  const defaultData = "http://";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Hwinfo_cnctJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Hwinfo_cnctJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Hwinfo_cnctJsonFile().setDefault();
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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await hwinfo_cnct.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(hwinfo_cnct,true);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        hwinfo_cnct.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await hwinfo_cnct.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(hwinfo_cnct,true);

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
      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①：loadを実行する。
      await hwinfo_cnct.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = hwinfo_cnct.comm.head;
      hwinfo_cnct.comm.head = testData1s;
      expect(hwinfo_cnct.comm.head == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.head != testData1s, true);
      expect(hwinfo_cnct.comm.head == prefixData, true);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = hwinfo_cnct.comm.head;
      hwinfo_cnct.comm.head = testData1s;
      expect(hwinfo_cnct.comm.head, testData1s);

      // ③saveを実行する。
      await hwinfo_cnct.save();

      // ④loadを実行する。
      await hwinfo_cnct.load();

      expect(hwinfo_cnct.comm.head != prefixData, true);
      expect(hwinfo_cnct.comm.head == testData1s, true);
      allPropatyCheck(hwinfo_cnct,false);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await hwinfo_cnct.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await hwinfo_cnct.save();

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await hwinfo_cnct.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(hwinfo_cnct.comm.head, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = hwinfo_cnct.comm.head;
      hwinfo_cnct.comm.head = testData1s;

      // ③ saveを実行する。
      await hwinfo_cnct.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(hwinfo_cnct.comm.head, testData1s);

      // ④ loadを実行する。
      await hwinfo_cnct.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(hwinfo_cnct.comm.head == testData1s, true);
      allPropatyCheck(hwinfo_cnct,false);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await hwinfo_cnct.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(hwinfo_cnct,true);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②任意のプロパティの値を変更する。
      hwinfo_cnct.comm.head = testData1s;
      expect(hwinfo_cnct.comm.head, testData1s);

      // ③saveを実行する。
      await hwinfo_cnct.save();
      expect(hwinfo_cnct.comm.head, testData1s);

      // ④loadを実行する。
      await hwinfo_cnct.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(hwinfo_cnct,true);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await hwinfo_cnct.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await hwinfo_cnct.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(hwinfo_cnct.comm.head == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await hwinfo_cnct.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await hwinfo_cnct.setValueWithName(section, "test_key", testData1s);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②任意のプロパティを変更する。
      hwinfo_cnct.comm.head = testData1s;

      // ③saveを実行する。
      await hwinfo_cnct.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await hwinfo_cnct.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②任意のプロパティを変更する。
      hwinfo_cnct.comm.head = testData1s;

      // ③saveを実行する。
      await hwinfo_cnct.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await hwinfo_cnct.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②任意のプロパティを変更する。
      hwinfo_cnct.comm.head = testData1s;

      // ③saveを実行する。
      await hwinfo_cnct.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await hwinfo_cnct.getValueWithName(section, "test_key");
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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await hwinfo_cnct.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      hwinfo_cnct.comm.head = testData1s;
      expect(hwinfo_cnct.comm.head, testData1s);

      // ④saveを実行する。
      await hwinfo_cnct.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(hwinfo_cnct.comm.head, testData1s);
      
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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await hwinfo_cnct.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + hwinfo_cnct.comm.head.toString());
      expect(hwinfo_cnct.comm.head == testData1s, true);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await hwinfo_cnct.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + hwinfo_cnct.comm.head.toString());
      expect(hwinfo_cnct.comm.head == testData2s, true);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await hwinfo_cnct.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + hwinfo_cnct.comm.head.toString());
      expect(hwinfo_cnct.comm.head == testData1s, true);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await hwinfo_cnct.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + hwinfo_cnct.comm.head.toString());
      expect(hwinfo_cnct.comm.head == testData2s, true);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await hwinfo_cnct.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + hwinfo_cnct.comm.head.toString());
      expect(hwinfo_cnct.comm.head == testData1s, true);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await hwinfo_cnct.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + hwinfo_cnct.comm.head.toString());
      expect(hwinfo_cnct.comm.head == testData1s, true);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await hwinfo_cnct.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + hwinfo_cnct.comm.head.toString());
      allPropatyCheck(hwinfo_cnct,true);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await hwinfo_cnct.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + hwinfo_cnct.comm.head.toString());
      allPropatyCheck(hwinfo_cnct,true);

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

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hwinfo_cnct.comm.head;
      print(hwinfo_cnct.comm.head);

      // ②指定したプロパティにテストデータ1を書き込む。
      hwinfo_cnct.comm.head = testData1s;
      print(hwinfo_cnct.comm.head);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hwinfo_cnct.comm.head == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hwinfo_cnct.comm.head == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hwinfo_cnct.comm.head = testData2s;
      print(hwinfo_cnct.comm.head);
      expect(hwinfo_cnct.comm.head == testData2s, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.head == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hwinfo_cnct.comm.head = defalut;
      print(hwinfo_cnct.comm.head);
      expect(hwinfo_cnct.comm.head == defalut, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.head == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hwinfo_cnct, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hwinfo_cnct.comm.host;
      print(hwinfo_cnct.comm.host);

      // ②指定したプロパティにテストデータ1を書き込む。
      hwinfo_cnct.comm.host = testData1s;
      print(hwinfo_cnct.comm.host);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hwinfo_cnct.comm.host == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hwinfo_cnct.comm.host == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hwinfo_cnct.comm.host = testData2s;
      print(hwinfo_cnct.comm.host);
      expect(hwinfo_cnct.comm.host == testData2s, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.host == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hwinfo_cnct.comm.host = defalut;
      print(hwinfo_cnct.comm.host);
      expect(hwinfo_cnct.comm.host == defalut, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.host == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hwinfo_cnct, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hwinfo_cnct.comm.url;
      print(hwinfo_cnct.comm.url);

      // ②指定したプロパティにテストデータ1を書き込む。
      hwinfo_cnct.comm.url = testData1s;
      print(hwinfo_cnct.comm.url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hwinfo_cnct.comm.url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hwinfo_cnct.comm.url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hwinfo_cnct.comm.url = testData2s;
      print(hwinfo_cnct.comm.url);
      expect(hwinfo_cnct.comm.url == testData2s, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hwinfo_cnct.comm.url = defalut;
      print(hwinfo_cnct.comm.url);
      expect(hwinfo_cnct.comm.url == defalut, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hwinfo_cnct, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hwinfo_cnct.comm.time_out;
      print(hwinfo_cnct.comm.time_out);

      // ②指定したプロパティにテストデータ1を書き込む。
      hwinfo_cnct.comm.time_out = testData1;
      print(hwinfo_cnct.comm.time_out);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hwinfo_cnct.comm.time_out == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hwinfo_cnct.comm.time_out == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hwinfo_cnct.comm.time_out = testData2;
      print(hwinfo_cnct.comm.time_out);
      expect(hwinfo_cnct.comm.time_out == testData2, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.time_out == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hwinfo_cnct.comm.time_out = defalut;
      print(hwinfo_cnct.comm.time_out);
      expect(hwinfo_cnct.comm.time_out == defalut, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.time_out == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hwinfo_cnct, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hwinfo_cnct.comm.portal_user;
      print(hwinfo_cnct.comm.portal_user);

      // ②指定したプロパティにテストデータ1を書き込む。
      hwinfo_cnct.comm.portal_user = testData1s;
      print(hwinfo_cnct.comm.portal_user);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hwinfo_cnct.comm.portal_user == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hwinfo_cnct.comm.portal_user == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hwinfo_cnct.comm.portal_user = testData2s;
      print(hwinfo_cnct.comm.portal_user);
      expect(hwinfo_cnct.comm.portal_user == testData2s, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.portal_user == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hwinfo_cnct.comm.portal_user = defalut;
      print(hwinfo_cnct.comm.portal_user);
      expect(hwinfo_cnct.comm.portal_user == defalut, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.portal_user == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hwinfo_cnct, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hwinfo_cnct.comm.portal_pass;
      print(hwinfo_cnct.comm.portal_pass);

      // ②指定したプロパティにテストデータ1を書き込む。
      hwinfo_cnct.comm.portal_pass = testData1s;
      print(hwinfo_cnct.comm.portal_pass);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hwinfo_cnct.comm.portal_pass == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hwinfo_cnct.comm.portal_pass == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hwinfo_cnct.comm.portal_pass = testData2s;
      print(hwinfo_cnct.comm.portal_pass);
      expect(hwinfo_cnct.comm.portal_pass == testData2s, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.portal_pass == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hwinfo_cnct.comm.portal_pass = defalut;
      print(hwinfo_cnct.comm.portal_pass);
      expect(hwinfo_cnct.comm.portal_pass == defalut, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.portal_pass == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hwinfo_cnct, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hwinfo_cnct.comm.dns1;
      print(hwinfo_cnct.comm.dns1);

      // ②指定したプロパティにテストデータ1を書き込む。
      hwinfo_cnct.comm.dns1 = testData1s;
      print(hwinfo_cnct.comm.dns1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hwinfo_cnct.comm.dns1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hwinfo_cnct.comm.dns1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hwinfo_cnct.comm.dns1 = testData2s;
      print(hwinfo_cnct.comm.dns1);
      expect(hwinfo_cnct.comm.dns1 == testData2s, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.dns1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hwinfo_cnct.comm.dns1 = defalut;
      print(hwinfo_cnct.comm.dns1);
      expect(hwinfo_cnct.comm.dns1 == defalut, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.dns1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hwinfo_cnct, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hwinfo_cnct.comm.dns2;
      print(hwinfo_cnct.comm.dns2);

      // ②指定したプロパティにテストデータ1を書き込む。
      hwinfo_cnct.comm.dns2 = testData1s;
      print(hwinfo_cnct.comm.dns2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hwinfo_cnct.comm.dns2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hwinfo_cnct.comm.dns2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hwinfo_cnct.comm.dns2 = testData2s;
      print(hwinfo_cnct.comm.dns2);
      expect(hwinfo_cnct.comm.dns2 == testData2s, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.dns2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hwinfo_cnct.comm.dns2 = defalut;
      print(hwinfo_cnct.comm.dns2);
      expect(hwinfo_cnct.comm.dns2 == defalut, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.dns2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hwinfo_cnct, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      hwinfo_cnct = Hwinfo_cnctJsonFile();
      allPropatyCheckInit(hwinfo_cnct);

      // ①loadを実行する。
      await hwinfo_cnct.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hwinfo_cnct.comm.max_data_len;
      print(hwinfo_cnct.comm.max_data_len);

      // ②指定したプロパティにテストデータ1を書き込む。
      hwinfo_cnct.comm.max_data_len = testData1;
      print(hwinfo_cnct.comm.max_data_len);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hwinfo_cnct.comm.max_data_len == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hwinfo_cnct.comm.max_data_len == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hwinfo_cnct.comm.max_data_len = testData2;
      print(hwinfo_cnct.comm.max_data_len);
      expect(hwinfo_cnct.comm.max_data_len == testData2, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.max_data_len == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hwinfo_cnct.comm.max_data_len = defalut;
      print(hwinfo_cnct.comm.max_data_len);
      expect(hwinfo_cnct.comm.max_data_len == defalut, true);
      await hwinfo_cnct.save();
      await hwinfo_cnct.load();
      expect(hwinfo_cnct.comm.max_data_len == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hwinfo_cnct, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Hwinfo_cnctJsonFile test)
{
  expect(test.comm.head, "");
  expect(test.comm.host, "");
  expect(test.comm.url, "");
  expect(test.comm.time_out, 0);
  expect(test.comm.portal_user, "");
  expect(test.comm.portal_pass, "");
  expect(test.comm.dns1, "");
  expect(test.comm.dns2, "");
  expect(test.comm.max_data_len, 0);
}

void allPropatyCheck(Hwinfo_cnctJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.comm.head, "http://");
  }
  expect(test.comm.host, "iot.975194.jp");
  expect(test.comm.url, "/api/v1/info");
  expect(test.comm.time_out, 180);
  expect(test.comm.portal_user, "use-token-auth");
  expect(test.comm.portal_pass, "Teraoka0893");
  expect(test.comm.dns1, "8.8.8.8");
  expect(test.comm.dns2, "8.8.4.4");
  expect(test.comm.max_data_len, 0);
}

