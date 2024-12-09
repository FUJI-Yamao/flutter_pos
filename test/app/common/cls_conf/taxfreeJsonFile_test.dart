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
import '../../../../lib/app/common/cls_conf/taxfreeJsonFile.dart';

late TaxfreeJsonFile taxfree;

void main(){
  taxfreeJsonFile_test();
}

void taxfreeJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "taxfree.json";
  const String section = "term_info";
  const String key = "corp_code";
  const defaultData = 1;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('TaxfreeJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await TaxfreeJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await TaxfreeJsonFile().setDefault();
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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await taxfree.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(taxfree,true);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        taxfree.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await taxfree.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(taxfree,true);

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
      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①：loadを実行する。
      await taxfree.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = taxfree.term_info.corp_code;
      taxfree.term_info.corp_code = testData1;
      expect(taxfree.term_info.corp_code == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await taxfree.load();
      expect(taxfree.term_info.corp_code != testData1, true);
      expect(taxfree.term_info.corp_code == prefixData, true);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = taxfree.term_info.corp_code;
      taxfree.term_info.corp_code = testData1;
      expect(taxfree.term_info.corp_code, testData1);

      // ③saveを実行する。
      await taxfree.save();

      // ④loadを実行する。
      await taxfree.load();

      expect(taxfree.term_info.corp_code != prefixData, true);
      expect(taxfree.term_info.corp_code == testData1, true);
      allPropatyCheck(taxfree,false);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await taxfree.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await taxfree.save();

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await taxfree.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(taxfree.term_info.corp_code, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = taxfree.term_info.corp_code;
      taxfree.term_info.corp_code = testData1;

      // ③ saveを実行する。
      await taxfree.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(taxfree.term_info.corp_code, testData1);

      // ④ loadを実行する。
      await taxfree.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(taxfree.term_info.corp_code == testData1, true);
      allPropatyCheck(taxfree,false);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await taxfree.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(taxfree,true);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②任意のプロパティの値を変更する。
      taxfree.term_info.corp_code = testData1;
      expect(taxfree.term_info.corp_code, testData1);

      // ③saveを実行する。
      await taxfree.save();
      expect(taxfree.term_info.corp_code, testData1);

      // ④loadを実行する。
      await taxfree.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(taxfree,true);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await taxfree.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await taxfree.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(taxfree.term_info.corp_code == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await taxfree.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await taxfree.setValueWithName(section, "test_key", testData1);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②任意のプロパティを変更する。
      taxfree.term_info.corp_code = testData1;

      // ③saveを実行する。
      await taxfree.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await taxfree.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②任意のプロパティを変更する。
      taxfree.term_info.corp_code = testData1;

      // ③saveを実行する。
      await taxfree.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await taxfree.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②任意のプロパティを変更する。
      taxfree.term_info.corp_code = testData1;

      // ③saveを実行する。
      await taxfree.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await taxfree.getValueWithName(section, "test_key");
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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await taxfree.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      taxfree.term_info.corp_code = testData1;
      expect(taxfree.term_info.corp_code, testData1);

      // ④saveを実行する。
      await taxfree.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(taxfree.term_info.corp_code, testData1);
      
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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await taxfree.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + taxfree.term_info.corp_code.toString());
      expect(taxfree.term_info.corp_code == testData1, true);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await taxfree.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + taxfree.term_info.corp_code.toString());
      expect(taxfree.term_info.corp_code == testData2, true);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await taxfree.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + taxfree.term_info.corp_code.toString());
      expect(taxfree.term_info.corp_code == testData1, true);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await taxfree.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + taxfree.term_info.corp_code.toString());
      expect(taxfree.term_info.corp_code == testData2, true);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await taxfree.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + taxfree.term_info.corp_code.toString());
      expect(taxfree.term_info.corp_code == testData1, true);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await taxfree.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + taxfree.term_info.corp_code.toString());
      expect(taxfree.term_info.corp_code == testData1, true);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await taxfree.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + taxfree.term_info.corp_code.toString());
      allPropatyCheck(taxfree,true);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await taxfree.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + taxfree.term_info.corp_code.toString());
      allPropatyCheck(taxfree,true);

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

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.term_info.corp_code;
      print(taxfree.term_info.corp_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.term_info.corp_code = testData1;
      print(taxfree.term_info.corp_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.term_info.corp_code == testData1, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.term_info.corp_code == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.term_info.corp_code = testData2;
      print(taxfree.term_info.corp_code);
      expect(taxfree.term_info.corp_code == testData2, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.corp_code == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.term_info.corp_code = defalut;
      print(taxfree.term_info.corp_code);
      expect(taxfree.term_info.corp_code == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.corp_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.term_info.shop_code;
      print(taxfree.term_info.shop_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.term_info.shop_code = testData1;
      print(taxfree.term_info.shop_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.term_info.shop_code == testData1, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.term_info.shop_code == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.term_info.shop_code = testData2;
      print(taxfree.term_info.shop_code);
      expect(taxfree.term_info.shop_code == testData2, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.shop_code == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.term_info.shop_code = defalut;
      print(taxfree.term_info.shop_code);
      expect(taxfree.term_info.shop_code == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.shop_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.term_info.licence_key;
      print(taxfree.term_info.licence_key);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.term_info.licence_key = testData1s;
      print(taxfree.term_info.licence_key);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.term_info.licence_key == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.term_info.licence_key == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.term_info.licence_key = testData2s;
      print(taxfree.term_info.licence_key);
      expect(taxfree.term_info.licence_key == testData2s, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.licence_key == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.term_info.licence_key = defalut;
      print(taxfree.term_info.licence_key);
      expect(taxfree.term_info.licence_key == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.licence_key == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.term_info.licence_get;
      print(taxfree.term_info.licence_get);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.term_info.licence_get = testData1s;
      print(taxfree.term_info.licence_get);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.term_info.licence_get == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.term_info.licence_get == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.term_info.licence_get = testData2s;
      print(taxfree.term_info.licence_get);
      expect(taxfree.term_info.licence_get == testData2s, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.licence_get == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.term_info.licence_get = defalut;
      print(taxfree.term_info.licence_get);
      expect(taxfree.term_info.licence_get == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.licence_get == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.term_info.master_get;
      print(taxfree.term_info.master_get);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.term_info.master_get = testData1s;
      print(taxfree.term_info.master_get);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.term_info.master_get == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.term_info.master_get == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.term_info.master_get = testData2s;
      print(taxfree.term_info.master_get);
      expect(taxfree.term_info.master_get == testData2s, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.master_get == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.term_info.master_get = defalut;
      print(taxfree.term_info.master_get);
      expect(taxfree.term_info.master_get == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.master_get == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.term_info.country_get;
      print(taxfree.term_info.country_get);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.term_info.country_get = testData1s;
      print(taxfree.term_info.country_get);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.term_info.country_get == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.term_info.country_get == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.term_info.country_get = testData2s;
      print(taxfree.term_info.country_get);
      expect(taxfree.term_info.country_get == testData2s, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.country_get == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.term_info.country_get = defalut;
      print(taxfree.term_info.country_get);
      expect(taxfree.term_info.country_get == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.country_get == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.term_info.term_code;
      print(taxfree.term_info.term_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.term_info.term_code = testData1s;
      print(taxfree.term_info.term_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.term_info.term_code == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.term_info.term_code == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.term_info.term_code = testData2s;
      print(taxfree.term_info.term_code);
      expect(taxfree.term_info.term_code == testData2s, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.term_code == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.term_info.term_code = defalut;
      print(taxfree.term_info.term_code);
      expect(taxfree.term_info.term_code == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info.term_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.term_info_demo.corp_code;
      print(taxfree.term_info_demo.corp_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.term_info_demo.corp_code = testData1;
      print(taxfree.term_info_demo.corp_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.term_info_demo.corp_code == testData1, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.term_info_demo.corp_code == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.term_info_demo.corp_code = testData2;
      print(taxfree.term_info_demo.corp_code);
      expect(taxfree.term_info_demo.corp_code == testData2, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info_demo.corp_code == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.term_info_demo.corp_code = defalut;
      print(taxfree.term_info_demo.corp_code);
      expect(taxfree.term_info_demo.corp_code == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info_demo.corp_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.term_info_demo.shop_code;
      print(taxfree.term_info_demo.shop_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.term_info_demo.shop_code = testData1;
      print(taxfree.term_info_demo.shop_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.term_info_demo.shop_code == testData1, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.term_info_demo.shop_code == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.term_info_demo.shop_code = testData2;
      print(taxfree.term_info_demo.shop_code);
      expect(taxfree.term_info_demo.shop_code == testData2, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info_demo.shop_code == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.term_info_demo.shop_code = defalut;
      print(taxfree.term_info_demo.shop_code);
      expect(taxfree.term_info_demo.shop_code == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info_demo.shop_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.term_info_demo.licence_key;
      print(taxfree.term_info_demo.licence_key);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.term_info_demo.licence_key = testData1s;
      print(taxfree.term_info_demo.licence_key);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.term_info_demo.licence_key == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.term_info_demo.licence_key == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.term_info_demo.licence_key = testData2s;
      print(taxfree.term_info_demo.licence_key);
      expect(taxfree.term_info_demo.licence_key == testData2s, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info_demo.licence_key == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.term_info_demo.licence_key = defalut;
      print(taxfree.term_info_demo.licence_key);
      expect(taxfree.term_info_demo.licence_key == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info_demo.licence_key == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.term_info_demo.licence_get;
      print(taxfree.term_info_demo.licence_get);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.term_info_demo.licence_get = testData1s;
      print(taxfree.term_info_demo.licence_get);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.term_info_demo.licence_get == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.term_info_demo.licence_get == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.term_info_demo.licence_get = testData2s;
      print(taxfree.term_info_demo.licence_get);
      expect(taxfree.term_info_demo.licence_get == testData2s, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info_demo.licence_get == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.term_info_demo.licence_get = defalut;
      print(taxfree.term_info_demo.licence_get);
      expect(taxfree.term_info_demo.licence_get == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info_demo.licence_get == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.term_info_demo.term_code;
      print(taxfree.term_info_demo.term_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.term_info_demo.term_code = testData1s;
      print(taxfree.term_info_demo.term_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.term_info_demo.term_code == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.term_info_demo.term_code == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.term_info_demo.term_code = testData2s;
      print(taxfree.term_info_demo.term_code);
      expect(taxfree.term_info_demo.term_code == testData2s, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info_demo.term_code == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.term_info_demo.term_code = defalut;
      print(taxfree.term_info_demo.term_code);
      expect(taxfree.term_info_demo.term_code == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.term_info_demo.term_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.url_info.server_typ;
      print(taxfree.url_info.server_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.url_info.server_typ = testData1;
      print(taxfree.url_info.server_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.url_info.server_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.url_info.server_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.url_info.server_typ = testData2;
      print(taxfree.url_info.server_typ);
      expect(taxfree.url_info.server_typ == testData2, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.url_info.server_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.url_info.server_typ = defalut;
      print(taxfree.url_info.server_typ);
      expect(taxfree.url_info.server_typ == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.url_info.server_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.url_info.url_business;
      print(taxfree.url_info.url_business);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.url_info.url_business = testData1s;
      print(taxfree.url_info.url_business);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.url_info.url_business == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.url_info.url_business == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.url_info.url_business = testData2s;
      print(taxfree.url_info.url_business);
      expect(taxfree.url_info.url_business == testData2s, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.url_info.url_business == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.url_info.url_business = defalut;
      print(taxfree.url_info.url_business);
      expect(taxfree.url_info.url_business == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.url_info.url_business == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.url_info.url_demo;
      print(taxfree.url_info.url_demo);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.url_info.url_demo = testData1s;
      print(taxfree.url_info.url_demo);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.url_info.url_demo == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.url_info.url_demo == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.url_info.url_demo = testData2s;
      print(taxfree.url_info.url_demo);
      expect(taxfree.url_info.url_demo == testData2s, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.url_info.url_demo == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.url_info.url_demo = defalut;
      print(taxfree.url_info.url_demo);
      expect(taxfree.url_info.url_demo == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.url_info.url_demo == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.url_info.timeout;
      print(taxfree.url_info.timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.url_info.timeout = testData1;
      print(taxfree.url_info.timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.url_info.timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.url_info.timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.url_info.timeout = testData2;
      print(taxfree.url_info.timeout);
      expect(taxfree.url_info.timeout == testData2, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.url_info.timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.url_info.timeout = defalut;
      print(taxfree.url_info.timeout);
      expect(taxfree.url_info.timeout == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.url_info.timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      taxfree = TaxfreeJsonFile();
      allPropatyCheckInit(taxfree);

      // ①loadを実行する。
      await taxfree.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = taxfree.data.keep_day;
      print(taxfree.data.keep_day);

      // ②指定したプロパティにテストデータ1を書き込む。
      taxfree.data.keep_day = testData1;
      print(taxfree.data.keep_day);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(taxfree.data.keep_day == testData1, true);

      // ④saveを実行後、loadを実行する。
      await taxfree.save();
      await taxfree.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(taxfree.data.keep_day == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      taxfree.data.keep_day = testData2;
      print(taxfree.data.keep_day);
      expect(taxfree.data.keep_day == testData2, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.data.keep_day == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      taxfree.data.keep_day = defalut;
      print(taxfree.data.keep_day);
      expect(taxfree.data.keep_day == defalut, true);
      await taxfree.save();
      await taxfree.load();
      expect(taxfree.data.keep_day == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(taxfree, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

  });
}

void allPropatyCheckInit(TaxfreeJsonFile test)
{
  expect(test.term_info.corp_code, 0);
  expect(test.term_info.shop_code, 0);
  expect(test.term_info.licence_key, "");
  expect(test.term_info.licence_get, "");
  expect(test.term_info.master_get, "");
  expect(test.term_info.country_get, "");
  expect(test.term_info.term_code, "");
  expect(test.term_info_demo.corp_code, 0);
  expect(test.term_info_demo.shop_code, 0);
  expect(test.term_info_demo.licence_key, "");
  expect(test.term_info_demo.licence_get, "");
  expect(test.term_info_demo.term_code, "");
  expect(test.url_info.server_typ, 0);
  expect(test.url_info.url_business, "");
  expect(test.url_info.url_demo, "");
  expect(test.url_info.timeout, 0);
  expect(test.data.keep_day, 0);
}

void allPropatyCheck(TaxfreeJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.term_info.corp_code, 1);
  }
  expect(test.term_info.shop_code, 1);
  expect(test.term_info.licence_key, "");
  expect(test.term_info.licence_get, "");
  expect(test.term_info.master_get, "");
  expect(test.term_info.country_get, "");
  expect(test.term_info.term_code, "");
  expect(test.term_info_demo.corp_code, 855);
  expect(test.term_info_demo.shop_code, 1);
  expect(test.term_info_demo.licence_key, "vd3href2dz4s");
  expect(test.term_info_demo.licence_get, "");
  expect(test.term_info_demo.term_code, "");
  expect(test.url_info.server_typ, 0);
  expect(test.url_info.url_business, "https://j-taxfree.com/ceapi/");
  expect(test.url_info.url_demo, "https://japantaxfree.com/ceapi/");
  expect(test.url_info.timeout, 10);
  expect(test.data.keep_day, 7);
}

