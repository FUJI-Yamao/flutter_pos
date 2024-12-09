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
import '../../../../lib/app/common/cls_conf/barcode_payJsonFile.dart';

late Barcode_payJsonFile barcode_pay;

void main(){
  barcode_payJsonFile_test();
}

void barcode_payJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "barcode_pay.json";
  const String section = "linepay";
  const String key = "url";
  const defaultData = "http://";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Barcode_payJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Barcode_payJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Barcode_payJsonFile().setDefault();
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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await barcode_pay.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(barcode_pay,true);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        barcode_pay.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await barcode_pay.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(barcode_pay,true);

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
      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①：loadを実行する。
      await barcode_pay.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = barcode_pay.linepay.url;
      barcode_pay.linepay.url = testData1s;
      expect(barcode_pay.linepay.url == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await barcode_pay.load();
      expect(barcode_pay.linepay.url != testData1s, true);
      expect(barcode_pay.linepay.url == prefixData, true);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = barcode_pay.linepay.url;
      barcode_pay.linepay.url = testData1s;
      expect(barcode_pay.linepay.url, testData1s);

      // ③saveを実行する。
      await barcode_pay.save();

      // ④loadを実行する。
      await barcode_pay.load();

      expect(barcode_pay.linepay.url != prefixData, true);
      expect(barcode_pay.linepay.url == testData1s, true);
      allPropatyCheck(barcode_pay,false);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await barcode_pay.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await barcode_pay.save();

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await barcode_pay.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(barcode_pay.linepay.url, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = barcode_pay.linepay.url;
      barcode_pay.linepay.url = testData1s;

      // ③ saveを実行する。
      await barcode_pay.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(barcode_pay.linepay.url, testData1s);

      // ④ loadを実行する。
      await barcode_pay.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(barcode_pay.linepay.url == testData1s, true);
      allPropatyCheck(barcode_pay,false);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await barcode_pay.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(barcode_pay,true);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②任意のプロパティの値を変更する。
      barcode_pay.linepay.url = testData1s;
      expect(barcode_pay.linepay.url, testData1s);

      // ③saveを実行する。
      await barcode_pay.save();
      expect(barcode_pay.linepay.url, testData1s);

      // ④loadを実行する。
      await barcode_pay.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(barcode_pay,true);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await barcode_pay.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await barcode_pay.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(barcode_pay.linepay.url == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await barcode_pay.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await barcode_pay.setValueWithName(section, "test_key", testData1s);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②任意のプロパティを変更する。
      barcode_pay.linepay.url = testData1s;

      // ③saveを実行する。
      await barcode_pay.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await barcode_pay.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②任意のプロパティを変更する。
      barcode_pay.linepay.url = testData1s;

      // ③saveを実行する。
      await barcode_pay.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await barcode_pay.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②任意のプロパティを変更する。
      barcode_pay.linepay.url = testData1s;

      // ③saveを実行する。
      await barcode_pay.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await barcode_pay.getValueWithName(section, "test_key");
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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await barcode_pay.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      barcode_pay.linepay.url = testData1s;
      expect(barcode_pay.linepay.url, testData1s);

      // ④saveを実行する。
      await barcode_pay.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(barcode_pay.linepay.url, testData1s);
      
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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await barcode_pay.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + barcode_pay.linepay.url.toString());
      expect(barcode_pay.linepay.url == testData1s, true);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await barcode_pay.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + barcode_pay.linepay.url.toString());
      expect(barcode_pay.linepay.url == testData2s, true);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await barcode_pay.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + barcode_pay.linepay.url.toString());
      expect(barcode_pay.linepay.url == testData1s, true);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await barcode_pay.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + barcode_pay.linepay.url.toString());
      expect(barcode_pay.linepay.url == testData2s, true);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await barcode_pay.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + barcode_pay.linepay.url.toString());
      expect(barcode_pay.linepay.url == testData1s, true);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await barcode_pay.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + barcode_pay.linepay.url.toString());
      expect(barcode_pay.linepay.url == testData1s, true);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await barcode_pay.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + barcode_pay.linepay.url.toString());
      allPropatyCheck(barcode_pay,true);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await barcode_pay.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + barcode_pay.linepay.url.toString());
      allPropatyCheck(barcode_pay,true);

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

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.linepay.url;
      print(barcode_pay.linepay.url);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.linepay.url = testData1s;
      print(barcode_pay.linepay.url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.linepay.url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.linepay.url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.linepay.url = testData2s;
      print(barcode_pay.linepay.url);
      expect(barcode_pay.linepay.url == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.linepay.url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.linepay.url = defalut;
      print(barcode_pay.linepay.url);
      expect(barcode_pay.linepay.url == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.linepay.url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.linepay.timeout;
      print(barcode_pay.linepay.timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.linepay.timeout = testData1;
      print(barcode_pay.linepay.timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.linepay.timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.linepay.timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.linepay.timeout = testData2;
      print(barcode_pay.linepay.timeout);
      expect(barcode_pay.linepay.timeout == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.linepay.timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.linepay.timeout = defalut;
      print(barcode_pay.linepay.timeout);
      expect(barcode_pay.linepay.timeout == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.linepay.timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.linepay.channelId;
      print(barcode_pay.linepay.channelId);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.linepay.channelId = testData1s;
      print(barcode_pay.linepay.channelId);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.linepay.channelId == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.linepay.channelId == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.linepay.channelId = testData2s;
      print(barcode_pay.linepay.channelId);
      expect(barcode_pay.linepay.channelId == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.linepay.channelId == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.linepay.channelId = defalut;
      print(barcode_pay.linepay.channelId);
      expect(barcode_pay.linepay.channelId == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.linepay.channelId == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.linepay.channelSecretKey;
      print(barcode_pay.linepay.channelSecretKey);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.linepay.channelSecretKey = testData1s;
      print(barcode_pay.linepay.channelSecretKey);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.linepay.channelSecretKey == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.linepay.channelSecretKey == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.linepay.channelSecretKey = testData2s;
      print(barcode_pay.linepay.channelSecretKey);
      expect(barcode_pay.linepay.channelSecretKey == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.linepay.channelSecretKey == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.linepay.channelSecretKey = defalut;
      print(barcode_pay.linepay.channelSecretKey);
      expect(barcode_pay.linepay.channelSecretKey == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.linepay.channelSecretKey == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.linepay.line_at;
      print(barcode_pay.linepay.line_at);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.linepay.line_at = testData1s;
      print(barcode_pay.linepay.line_at);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.linepay.line_at == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.linepay.line_at == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.linepay.line_at = testData2s;
      print(barcode_pay.linepay.line_at);
      expect(barcode_pay.linepay.line_at == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.linepay.line_at == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.linepay.line_at = defalut;
      print(barcode_pay.linepay.line_at);
      expect(barcode_pay.linepay.line_at == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.linepay.line_at == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.linepay.debug_bal;
      print(barcode_pay.linepay.debug_bal);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.linepay.debug_bal = testData1;
      print(barcode_pay.linepay.debug_bal);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.linepay.debug_bal == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.linepay.debug_bal == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.linepay.debug_bal = testData2;
      print(barcode_pay.linepay.debug_bal);
      expect(barcode_pay.linepay.debug_bal == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.linepay.debug_bal == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.linepay.debug_bal = defalut;
      print(barcode_pay.linepay.debug_bal);
      expect(barcode_pay.linepay.debug_bal == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.linepay.debug_bal == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.onepay.url;
      print(barcode_pay.onepay.url);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.onepay.url = testData1s;
      print(barcode_pay.onepay.url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.onepay.url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.onepay.url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.onepay.url = testData2s;
      print(barcode_pay.onepay.url);
      expect(barcode_pay.onepay.url == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.onepay.url = defalut;
      print(barcode_pay.onepay.url);
      expect(barcode_pay.onepay.url == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.onepay.timeout;
      print(barcode_pay.onepay.timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.onepay.timeout = testData1;
      print(barcode_pay.onepay.timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.onepay.timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.onepay.timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.onepay.timeout = testData2;
      print(barcode_pay.onepay.timeout);
      expect(barcode_pay.onepay.timeout == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.onepay.timeout = defalut;
      print(barcode_pay.onepay.timeout);
      expect(barcode_pay.onepay.timeout == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.onepay.product_key;
      print(barcode_pay.onepay.product_key);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.onepay.product_key = testData1s;
      print(barcode_pay.onepay.product_key);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.onepay.product_key == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.onepay.product_key == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.onepay.product_key = testData2s;
      print(barcode_pay.onepay.product_key);
      expect(barcode_pay.onepay.product_key == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.product_key == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.onepay.product_key = defalut;
      print(barcode_pay.onepay.product_key);
      expect(barcode_pay.onepay.product_key == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.product_key == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.onepay.branch_code;
      print(barcode_pay.onepay.branch_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.onepay.branch_code = testData1s;
      print(barcode_pay.onepay.branch_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.onepay.branch_code == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.onepay.branch_code == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.onepay.branch_code = testData2s;
      print(barcode_pay.onepay.branch_code);
      expect(barcode_pay.onepay.branch_code == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.branch_code == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.onepay.branch_code = defalut;
      print(barcode_pay.onepay.branch_code);
      expect(barcode_pay.onepay.branch_code == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.branch_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.onepay.termnl_code;
      print(barcode_pay.onepay.termnl_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.onepay.termnl_code = testData1s;
      print(barcode_pay.onepay.termnl_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.onepay.termnl_code == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.onepay.termnl_code == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.onepay.termnl_code = testData2s;
      print(barcode_pay.onepay.termnl_code);
      expect(barcode_pay.onepay.termnl_code == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.termnl_code == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.onepay.termnl_code = defalut;
      print(barcode_pay.onepay.termnl_code);
      expect(barcode_pay.onepay.termnl_code == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.termnl_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.onepay.mercnt_code;
      print(barcode_pay.onepay.mercnt_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.onepay.mercnt_code = testData1s;
      print(barcode_pay.onepay.mercnt_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.onepay.mercnt_code == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.onepay.mercnt_code == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.onepay.mercnt_code = testData2s;
      print(barcode_pay.onepay.mercnt_code);
      expect(barcode_pay.onepay.mercnt_code == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.mercnt_code == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.onepay.mercnt_code = defalut;
      print(barcode_pay.onepay.mercnt_code);
      expect(barcode_pay.onepay.mercnt_code == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.mercnt_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.onepay.debug_bal;
      print(barcode_pay.onepay.debug_bal);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.onepay.debug_bal = testData1;
      print(barcode_pay.onepay.debug_bal);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.onepay.debug_bal == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.onepay.debug_bal == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.onepay.debug_bal = testData2;
      print(barcode_pay.onepay.debug_bal);
      expect(barcode_pay.onepay.debug_bal == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.debug_bal == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.onepay.debug_bal = defalut;
      print(barcode_pay.onepay.debug_bal);
      expect(barcode_pay.onepay.debug_bal == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.onepay.debug_bal == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.barcodepay.url;
      print(barcode_pay.barcodepay.url);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.barcodepay.url = testData1s;
      print(barcode_pay.barcodepay.url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.barcodepay.url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.barcodepay.url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.barcodepay.url = testData2s;
      print(barcode_pay.barcodepay.url);
      expect(barcode_pay.barcodepay.url == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.barcodepay.url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.barcodepay.url = defalut;
      print(barcode_pay.barcodepay.url);
      expect(barcode_pay.barcodepay.url == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.barcodepay.url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.barcodepay.timeout;
      print(barcode_pay.barcodepay.timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.barcodepay.timeout = testData1;
      print(barcode_pay.barcodepay.timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.barcodepay.timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.barcodepay.timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.barcodepay.timeout = testData2;
      print(barcode_pay.barcodepay.timeout);
      expect(barcode_pay.barcodepay.timeout == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.barcodepay.timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.barcodepay.timeout = defalut;
      print(barcode_pay.barcodepay.timeout);
      expect(barcode_pay.barcodepay.timeout == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.barcodepay.timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.barcodepay.merchantCode;
      print(barcode_pay.barcodepay.merchantCode);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.barcodepay.merchantCode = testData1s;
      print(barcode_pay.barcodepay.merchantCode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.barcodepay.merchantCode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.barcodepay.merchantCode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.barcodepay.merchantCode = testData2s;
      print(barcode_pay.barcodepay.merchantCode);
      expect(barcode_pay.barcodepay.merchantCode == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.barcodepay.merchantCode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.barcodepay.merchantCode = defalut;
      print(barcode_pay.barcodepay.merchantCode);
      expect(barcode_pay.barcodepay.merchantCode == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.barcodepay.merchantCode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.barcodepay.cliantId;
      print(barcode_pay.barcodepay.cliantId);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.barcodepay.cliantId = testData1s;
      print(barcode_pay.barcodepay.cliantId);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.barcodepay.cliantId == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.barcodepay.cliantId == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.barcodepay.cliantId = testData2s;
      print(barcode_pay.barcodepay.cliantId);
      expect(barcode_pay.barcodepay.cliantId == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.barcodepay.cliantId == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.barcodepay.cliantId = defalut;
      print(barcode_pay.barcodepay.cliantId);
      expect(barcode_pay.barcodepay.cliantId == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.barcodepay.cliantId == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.barcodepay.validFlg;
      print(barcode_pay.barcodepay.validFlg);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.barcodepay.validFlg = testData1;
      print(barcode_pay.barcodepay.validFlg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.barcodepay.validFlg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.barcodepay.validFlg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.barcodepay.validFlg = testData2;
      print(barcode_pay.barcodepay.validFlg);
      expect(barcode_pay.barcodepay.validFlg == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.barcodepay.validFlg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.barcodepay.validFlg = defalut;
      print(barcode_pay.barcodepay.validFlg);
      expect(barcode_pay.barcodepay.validFlg == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.barcodepay.validFlg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.barcodepay.debug_bal;
      print(barcode_pay.barcodepay.debug_bal);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.barcodepay.debug_bal = testData1;
      print(barcode_pay.barcodepay.debug_bal);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.barcodepay.debug_bal == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.barcodepay.debug_bal == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.barcodepay.debug_bal = testData2;
      print(barcode_pay.barcodepay.debug_bal);
      expect(barcode_pay.barcodepay.debug_bal == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.barcodepay.debug_bal == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.barcodepay.debug_bal = defalut;
      print(barcode_pay.barcodepay.debug_bal);
      expect(barcode_pay.barcodepay.debug_bal == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.barcodepay.debug_bal == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.canalpayment.url;
      print(barcode_pay.canalpayment.url);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.canalpayment.url = testData1s;
      print(barcode_pay.canalpayment.url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.canalpayment.url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.canalpayment.url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.canalpayment.url = testData2s;
      print(barcode_pay.canalpayment.url);
      expect(barcode_pay.canalpayment.url == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.canalpayment.url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.canalpayment.url = defalut;
      print(barcode_pay.canalpayment.url);
      expect(barcode_pay.canalpayment.url == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.canalpayment.url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.canalpayment.timeout;
      print(barcode_pay.canalpayment.timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.canalpayment.timeout = testData1;
      print(barcode_pay.canalpayment.timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.canalpayment.timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.canalpayment.timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.canalpayment.timeout = testData2;
      print(barcode_pay.canalpayment.timeout);
      expect(barcode_pay.canalpayment.timeout == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.canalpayment.timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.canalpayment.timeout = defalut;
      print(barcode_pay.canalpayment.timeout);
      expect(barcode_pay.canalpayment.timeout == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.canalpayment.timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.canalpayment.company_code;
      print(barcode_pay.canalpayment.company_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.canalpayment.company_code = testData1;
      print(barcode_pay.canalpayment.company_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.canalpayment.company_code == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.canalpayment.company_code == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.canalpayment.company_code = testData2;
      print(barcode_pay.canalpayment.company_code);
      expect(barcode_pay.canalpayment.company_code == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.canalpayment.company_code == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.canalpayment.company_code = defalut;
      print(barcode_pay.canalpayment.company_code);
      expect(barcode_pay.canalpayment.company_code == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.canalpayment.company_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.canalpayment.branch_code;
      print(barcode_pay.canalpayment.branch_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.canalpayment.branch_code = testData1s;
      print(barcode_pay.canalpayment.branch_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.canalpayment.branch_code == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.canalpayment.branch_code == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.canalpayment.branch_code = testData2s;
      print(barcode_pay.canalpayment.branch_code);
      expect(barcode_pay.canalpayment.branch_code == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.canalpayment.branch_code == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.canalpayment.branch_code = defalut;
      print(barcode_pay.canalpayment.branch_code);
      expect(barcode_pay.canalpayment.branch_code == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.canalpayment.branch_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.canalpayment.merchantId;
      print(barcode_pay.canalpayment.merchantId);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.canalpayment.merchantId = testData1s;
      print(barcode_pay.canalpayment.merchantId);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.canalpayment.merchantId == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.canalpayment.merchantId == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.canalpayment.merchantId = testData2s;
      print(barcode_pay.canalpayment.merchantId);
      expect(barcode_pay.canalpayment.merchantId == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.canalpayment.merchantId == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.canalpayment.merchantId = defalut;
      print(barcode_pay.canalpayment.merchantId);
      expect(barcode_pay.canalpayment.merchantId == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.canalpayment.merchantId == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.canalpayment.debug_bal;
      print(barcode_pay.canalpayment.debug_bal);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.canalpayment.debug_bal = testData1;
      print(barcode_pay.canalpayment.debug_bal);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.canalpayment.debug_bal == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.canalpayment.debug_bal == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.canalpayment.debug_bal = testData2;
      print(barcode_pay.canalpayment.debug_bal);
      expect(barcode_pay.canalpayment.debug_bal == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.canalpayment.debug_bal == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.canalpayment.debug_bal = defalut;
      print(barcode_pay.canalpayment.debug_bal);
      expect(barcode_pay.canalpayment.debug_bal == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.canalpayment.debug_bal == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.netstars.url;
      print(barcode_pay.netstars.url);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.netstars.url = testData1s;
      print(barcode_pay.netstars.url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.netstars.url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.netstars.url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.netstars.url = testData2s;
      print(barcode_pay.netstars.url);
      expect(barcode_pay.netstars.url == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.netstars.url = defalut;
      print(barcode_pay.netstars.url);
      expect(barcode_pay.netstars.url == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.netstars.timeout;
      print(barcode_pay.netstars.timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.netstars.timeout = testData1;
      print(barcode_pay.netstars.timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.netstars.timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.netstars.timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.netstars.timeout = testData2;
      print(barcode_pay.netstars.timeout);
      expect(barcode_pay.netstars.timeout == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.netstars.timeout = defalut;
      print(barcode_pay.netstars.timeout);
      expect(barcode_pay.netstars.timeout == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.netstars.company_name;
      print(barcode_pay.netstars.company_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.netstars.company_name = testData1s;
      print(barcode_pay.netstars.company_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.netstars.company_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.netstars.company_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.netstars.company_name = testData2s;
      print(barcode_pay.netstars.company_name);
      expect(barcode_pay.netstars.company_name == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.company_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.netstars.company_name = defalut;
      print(barcode_pay.netstars.company_name);
      expect(barcode_pay.netstars.company_name == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.company_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.netstars.merchant_license;
      print(barcode_pay.netstars.merchant_license);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.netstars.merchant_license = testData1s;
      print(barcode_pay.netstars.merchant_license);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.netstars.merchant_license == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.netstars.merchant_license == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.netstars.merchant_license = testData2s;
      print(barcode_pay.netstars.merchant_license);
      expect(barcode_pay.netstars.merchant_license == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.merchant_license == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.netstars.merchant_license = defalut;
      print(barcode_pay.netstars.merchant_license);
      expect(barcode_pay.netstars.merchant_license == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.merchant_license == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.netstars.api_key;
      print(barcode_pay.netstars.api_key);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.netstars.api_key = testData1s;
      print(barcode_pay.netstars.api_key);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.netstars.api_key == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.netstars.api_key == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.netstars.api_key = testData2s;
      print(barcode_pay.netstars.api_key);
      expect(barcode_pay.netstars.api_key == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.api_key == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.netstars.api_key = defalut;
      print(barcode_pay.netstars.api_key);
      expect(barcode_pay.netstars.api_key == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.api_key == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.netstars.verify_key;
      print(barcode_pay.netstars.verify_key);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.netstars.verify_key = testData1s;
      print(barcode_pay.netstars.verify_key);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.netstars.verify_key == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.netstars.verify_key == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.netstars.verify_key = testData2s;
      print(barcode_pay.netstars.verify_key);
      expect(barcode_pay.netstars.verify_key == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.verify_key == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.netstars.verify_key = defalut;
      print(barcode_pay.netstars.verify_key);
      expect(barcode_pay.netstars.verify_key == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.verify_key == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.netstars.rcpt_info;
      print(barcode_pay.netstars.rcpt_info);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.netstars.rcpt_info = testData1s;
      print(barcode_pay.netstars.rcpt_info);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.netstars.rcpt_info == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.netstars.rcpt_info == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.netstars.rcpt_info = testData2s;
      print(barcode_pay.netstars.rcpt_info);
      expect(barcode_pay.netstars.rcpt_info == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.rcpt_info == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.netstars.rcpt_info = defalut;
      print(barcode_pay.netstars.rcpt_info);
      expect(barcode_pay.netstars.rcpt_info == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.rcpt_info == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.netstars.proxy;
      print(barcode_pay.netstars.proxy);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.netstars.proxy = testData1s;
      print(barcode_pay.netstars.proxy);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.netstars.proxy == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.netstars.proxy == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.netstars.proxy = testData2s;
      print(barcode_pay.netstars.proxy);
      expect(barcode_pay.netstars.proxy == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.proxy == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.netstars.proxy = defalut;
      print(barcode_pay.netstars.proxy);
      expect(barcode_pay.netstars.proxy == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.proxy == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.netstars.debug_bal;
      print(barcode_pay.netstars.debug_bal);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.netstars.debug_bal = testData1;
      print(barcode_pay.netstars.debug_bal);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.netstars.debug_bal == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.netstars.debug_bal == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.netstars.debug_bal = testData2;
      print(barcode_pay.netstars.debug_bal);
      expect(barcode_pay.netstars.debug_bal == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.debug_bal == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.netstars.debug_bal = defalut;
      print(barcode_pay.netstars.debug_bal);
      expect(barcode_pay.netstars.debug_bal == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.netstars.debug_bal == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.quiz.ccid;
      print(barcode_pay.quiz.ccid);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.quiz.ccid = testData1s;
      print(barcode_pay.quiz.ccid);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.quiz.ccid == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.quiz.ccid == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.quiz.ccid = testData2s;
      print(barcode_pay.quiz.ccid);
      expect(barcode_pay.quiz.ccid == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.ccid == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.quiz.ccid = defalut;
      print(barcode_pay.quiz.ccid);
      expect(barcode_pay.quiz.ccid == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.ccid == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.quiz.key;
      print(barcode_pay.quiz.key);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.quiz.key = testData1s;
      print(barcode_pay.quiz.key);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.quiz.key == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.quiz.key == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.quiz.key = testData2s;
      print(barcode_pay.quiz.key);
      expect(barcode_pay.quiz.key == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.key == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.quiz.key = defalut;
      print(barcode_pay.quiz.key);
      expect(barcode_pay.quiz.key == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.key == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.quiz.timeout;
      print(barcode_pay.quiz.timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.quiz.timeout = testData1;
      print(barcode_pay.quiz.timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.quiz.timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.quiz.timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.quiz.timeout = testData2;
      print(barcode_pay.quiz.timeout);
      expect(barcode_pay.quiz.timeout == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.quiz.timeout = defalut;
      print(barcode_pay.quiz.timeout);
      expect(barcode_pay.quiz.timeout == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.quiz.storeID;
      print(barcode_pay.quiz.storeID);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.quiz.storeID = testData1s;
      print(barcode_pay.quiz.storeID);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.quiz.storeID == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.quiz.storeID == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.quiz.storeID = testData2s;
      print(barcode_pay.quiz.storeID);
      expect(barcode_pay.quiz.storeID == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.storeID == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.quiz.storeID = defalut;
      print(barcode_pay.quiz.storeID);
      expect(barcode_pay.quiz.storeID == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.storeID == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.quiz.terminalID;
      print(barcode_pay.quiz.terminalID);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.quiz.terminalID = testData1s;
      print(barcode_pay.quiz.terminalID);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.quiz.terminalID == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.quiz.terminalID == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.quiz.terminalID = testData2s;
      print(barcode_pay.quiz.terminalID);
      expect(barcode_pay.quiz.terminalID == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.terminalID == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.quiz.terminalID = defalut;
      print(barcode_pay.quiz.terminalID);
      expect(barcode_pay.quiz.terminalID == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.terminalID == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.quiz.debug_flag;
      print(barcode_pay.quiz.debug_flag);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.quiz.debug_flag = testData1;
      print(barcode_pay.quiz.debug_flag);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.quiz.debug_flag == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.quiz.debug_flag == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.quiz.debug_flag = testData2;
      print(barcode_pay.quiz.debug_flag);
      expect(barcode_pay.quiz.debug_flag == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.debug_flag == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.quiz.debug_flag = defalut;
      print(barcode_pay.quiz.debug_flag);
      expect(barcode_pay.quiz.debug_flag == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.debug_flag == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.quiz.debug_rescode;
      print(barcode_pay.quiz.debug_rescode);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.quiz.debug_rescode = testData1s;
      print(barcode_pay.quiz.debug_rescode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.quiz.debug_rescode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.quiz.debug_rescode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.quiz.debug_rescode = testData2s;
      print(barcode_pay.quiz.debug_rescode);
      expect(barcode_pay.quiz.debug_rescode == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.debug_rescode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.quiz.debug_rescode = defalut;
      print(barcode_pay.quiz.debug_rescode);
      expect(barcode_pay.quiz.debug_rescode == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.debug_rescode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.quiz.debug_vcode;
      print(barcode_pay.quiz.debug_vcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.quiz.debug_vcode = testData1s;
      print(barcode_pay.quiz.debug_vcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.quiz.debug_vcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.quiz.debug_vcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.quiz.debug_vcode = testData2s;
      print(barcode_pay.quiz.debug_vcode);
      expect(barcode_pay.quiz.debug_vcode == testData2s, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.debug_vcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.quiz.debug_vcode = defalut;
      print(barcode_pay.quiz.debug_vcode);
      expect(barcode_pay.quiz.debug_vcode == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.debug_vcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      barcode_pay = Barcode_payJsonFile();
      allPropatyCheckInit(barcode_pay);

      // ①loadを実行する。
      await barcode_pay.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = barcode_pay.quiz.debug_bal;
      print(barcode_pay.quiz.debug_bal);

      // ②指定したプロパティにテストデータ1を書き込む。
      barcode_pay.quiz.debug_bal = testData1;
      print(barcode_pay.quiz.debug_bal);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(barcode_pay.quiz.debug_bal == testData1, true);

      // ④saveを実行後、loadを実行する。
      await barcode_pay.save();
      await barcode_pay.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(barcode_pay.quiz.debug_bal == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      barcode_pay.quiz.debug_bal = testData2;
      print(barcode_pay.quiz.debug_bal);
      expect(barcode_pay.quiz.debug_bal == testData2, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.debug_bal == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      barcode_pay.quiz.debug_bal = defalut;
      print(barcode_pay.quiz.debug_bal);
      expect(barcode_pay.quiz.debug_bal == defalut, true);
      await barcode_pay.save();
      await barcode_pay.load();
      expect(barcode_pay.quiz.debug_bal == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(barcode_pay, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Barcode_payJsonFile test)
{
  expect(test.linepay.url, "");
  expect(test.linepay.timeout, 0);
  expect(test.linepay.channelId, "");
  expect(test.linepay.channelSecretKey, "");
  expect(test.linepay.line_at, "");
  expect(test.linepay.debug_bal, 0);
  expect(test.onepay.url, "");
  expect(test.onepay.timeout, 0);
  expect(test.onepay.product_key, "");
  expect(test.onepay.branch_code, "");
  expect(test.onepay.termnl_code, "");
  expect(test.onepay.mercnt_code, "");
  expect(test.onepay.debug_bal, 0);
  expect(test.barcodepay.url, "");
  expect(test.barcodepay.timeout, 0);
  expect(test.barcodepay.merchantCode, "");
  expect(test.barcodepay.cliantId, "");
  expect(test.barcodepay.validFlg, 0);
  expect(test.barcodepay.debug_bal, 0);
  expect(test.canalpayment.url, "");
  expect(test.canalpayment.timeout, 0);
  expect(test.canalpayment.company_code, 0);
  expect(test.canalpayment.branch_code, "");
  expect(test.canalpayment.merchantId, "");
  expect(test.canalpayment.debug_bal, 0);
  expect(test.netstars.url, "");
  expect(test.netstars.timeout, 0);
  expect(test.netstars.company_name, "");
  expect(test.netstars.merchant_license, "");
  expect(test.netstars.api_key, "");
  expect(test.netstars.verify_key, "");
  expect(test.netstars.rcpt_info, "");
  expect(test.netstars.proxy, "");
  expect(test.netstars.debug_bal, 0);
  expect(test.quiz.ccid, "");
  expect(test.quiz.key, "");
  expect(test.quiz.timeout, 0);
  expect(test.quiz.storeID, "");
  expect(test.quiz.terminalID, "");
  expect(test.quiz.debug_flag, 0);
  expect(test.quiz.debug_rescode, "");
  expect(test.quiz.debug_vcode, "");
  expect(test.quiz.debug_bal, 0);
}

void allPropatyCheck(Barcode_payJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.linepay.url, "http://");
  }
  expect(test.linepay.timeout, 40);
  expect(test.linepay.channelId, "none");
  expect(test.linepay.channelSecretKey, "none");
  expect(test.linepay.line_at, "none");
  expect(test.linepay.debug_bal, 10000);
  expect(test.onepay.url, "http://");
  expect(test.onepay.timeout, 20);
  expect(test.onepay.product_key, "none");
  expect(test.onepay.branch_code, "none");
  expect(test.onepay.termnl_code, "none");
  expect(test.onepay.mercnt_code, "none");
  expect(test.onepay.debug_bal, 10000);
  expect(test.barcodepay.url, "https://");
  expect(test.barcodepay.timeout, 30);
  expect(test.barcodepay.merchantCode, "none");
  expect(test.barcodepay.cliantId, "none");
  expect(test.barcodepay.validFlg, 0);
  expect(test.barcodepay.debug_bal, 10000);
  expect(test.canalpayment.url, "https://");
  expect(test.canalpayment.timeout, 30);
  expect(test.canalpayment.company_code, 0);
  expect(test.canalpayment.branch_code, "none");
  expect(test.canalpayment.merchantId, "none");
  expect(test.canalpayment.debug_bal, 10000);
  expect(test.netstars.url, "https://");
  expect(test.netstars.timeout, 45);
  expect(test.netstars.company_name, "none");
  expect(test.netstars.merchant_license, "none");
  expect(test.netstars.api_key, "none");
  expect(test.netstars.verify_key, "none");
  expect(test.netstars.rcpt_info, "none");
  expect(test.netstars.proxy, "none");
  expect(test.netstars.debug_bal, 10000);
  expect(test.quiz.ccid, "");
  expect(test.quiz.key, "");
  expect(test.quiz.timeout, 60);
  expect(test.quiz.storeID, "none");
  expect(test.quiz.terminalID, "none");
  expect(test.quiz.debug_flag, 0);
  expect(test.quiz.debug_rescode, "Q000");
  expect(test.quiz.debug_vcode, "1001000000000000");
  expect(test.quiz.debug_bal, 10000);
}

