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
import '../../../../lib/app/common/cls_conf/suicaJsonFile.dart';

late SuicaJsonFile suica;

void main(){
  suicaJsonFile_test();
}

void suicaJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "suica.json";
  const String section = "suica";
  const String key = "SuicaNo";
  const defaultData = "0000000000000";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('SuicaJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await SuicaJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await SuicaJsonFile().setDefault();
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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await suica.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(suica,true);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        suica.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await suica.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(suica,true);

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
      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①：loadを実行する。
      await suica.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = suica.suica.SuicaNo;
      suica.suica.SuicaNo = testData1s;
      expect(suica.suica.SuicaNo == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await suica.load();
      expect(suica.suica.SuicaNo != testData1s, true);
      expect(suica.suica.SuicaNo == prefixData, true);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = suica.suica.SuicaNo;
      suica.suica.SuicaNo = testData1s;
      expect(suica.suica.SuicaNo, testData1s);

      // ③saveを実行する。
      await suica.save();

      // ④loadを実行する。
      await suica.load();

      expect(suica.suica.SuicaNo != prefixData, true);
      expect(suica.suica.SuicaNo == testData1s, true);
      allPropatyCheck(suica,false);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await suica.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await suica.save();

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await suica.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(suica.suica.SuicaNo, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = suica.suica.SuicaNo;
      suica.suica.SuicaNo = testData1s;

      // ③ saveを実行する。
      await suica.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(suica.suica.SuicaNo, testData1s);

      // ④ loadを実行する。
      await suica.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(suica.suica.SuicaNo == testData1s, true);
      allPropatyCheck(suica,false);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await suica.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(suica,true);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②任意のプロパティの値を変更する。
      suica.suica.SuicaNo = testData1s;
      expect(suica.suica.SuicaNo, testData1s);

      // ③saveを実行する。
      await suica.save();
      expect(suica.suica.SuicaNo, testData1s);

      // ④loadを実行する。
      await suica.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(suica,true);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await suica.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await suica.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(suica.suica.SuicaNo == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await suica.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await suica.setValueWithName(section, "test_key", testData1s);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②任意のプロパティを変更する。
      suica.suica.SuicaNo = testData1s;

      // ③saveを実行する。
      await suica.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await suica.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②任意のプロパティを変更する。
      suica.suica.SuicaNo = testData1s;

      // ③saveを実行する。
      await suica.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await suica.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②任意のプロパティを変更する。
      suica.suica.SuicaNo = testData1s;

      // ③saveを実行する。
      await suica.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await suica.getValueWithName(section, "test_key");
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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await suica.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      suica.suica.SuicaNo = testData1s;
      expect(suica.suica.SuicaNo, testData1s);

      // ④saveを実行する。
      await suica.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(suica.suica.SuicaNo, testData1s);
      
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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await suica.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + suica.suica.SuicaNo.toString());
      expect(suica.suica.SuicaNo == testData1s, true);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await suica.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + suica.suica.SuicaNo.toString());
      expect(suica.suica.SuicaNo == testData2s, true);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await suica.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + suica.suica.SuicaNo.toString());
      expect(suica.suica.SuicaNo == testData1s, true);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await suica.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + suica.suica.SuicaNo.toString());
      expect(suica.suica.SuicaNo == testData2s, true);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await suica.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + suica.suica.SuicaNo.toString());
      expect(suica.suica.SuicaNo == testData1s, true);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await suica.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + suica.suica.SuicaNo.toString());
      expect(suica.suica.SuicaNo == testData1s, true);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await suica.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + suica.suica.SuicaNo.toString());
      allPropatyCheck(suica,true);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await suica.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + suica.suica.SuicaNo.toString());
      allPropatyCheck(suica,true);

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

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.suica.SuicaNo;
      print(suica.suica.SuicaNo);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.suica.SuicaNo = testData1s;
      print(suica.suica.SuicaNo);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.suica.SuicaNo == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.suica.SuicaNo == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.suica.SuicaNo = testData2s;
      print(suica.suica.SuicaNo);
      expect(suica.suica.SuicaNo == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.suica.SuicaNo == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.suica.SuicaNo = defalut;
      print(suica.suica.SuicaNo);
      expect(suica.suica.SuicaNo == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.suica.SuicaNo == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.suica.ng_print;
      print(suica.suica.ng_print);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.suica.ng_print = testData1;
      print(suica.suica.ng_print);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.suica.ng_print == testData1, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.suica.ng_print == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.suica.ng_print = testData2;
      print(suica.suica.ng_print);
      expect(suica.suica.ng_print == testData2, true);
      await suica.save();
      await suica.load();
      expect(suica.suica.ng_print == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.suica.ng_print = defalut;
      print(suica.suica.ng_print);
      expect(suica.suica.ng_print == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.suica.ng_print == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.send_date;
      print(suica.sense.send_date);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.send_date = testData1s;
      print(suica.sense.send_date);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.send_date == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.send_date == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.send_date = testData2s;
      print(suica.sense.send_date);
      expect(suica.sense.send_date == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.send_date == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.send_date = defalut;
      print(suica.sense.send_date);
      expect(suica.sense.send_date == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.send_date == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.offset;
      print(suica.sense.offset);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.offset = testData1s;
      print(suica.sense.offset);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.offset == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.offset == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.offset = testData2s;
      print(suica.sense.offset);
      expect(suica.sense.offset == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.offset == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.offset = defalut;
      print(suica.sense.offset);
      expect(suica.sense.offset == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.offset == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.rw_code;
      print(suica.sense.rw_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.rw_code = testData1s;
      print(suica.sense.rw_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.rw_code == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.rw_code == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.rw_code = testData2s;
      print(suica.sense.rw_code);
      expect(suica.sense.rw_code == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.rw_code == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.rw_code = defalut;
      print(suica.sense.rw_code);
      expect(suica.sense.rw_code == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.rw_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.str_id;
      print(suica.sense.str_id);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.str_id = testData1s;
      print(suica.sense.str_id);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.str_id == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.str_id == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.str_id = testData2s;
      print(suica.sense.str_id);
      expect(suica.sense.str_id == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.str_id == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.str_id = defalut;
      print(suica.sense.str_id);
      expect(suica.sense.str_id == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.str_id == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.rw_mac;
      print(suica.sense.rw_mac);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.rw_mac = testData1s;
      print(suica.sense.rw_mac);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.rw_mac == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.rw_mac == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.rw_mac = testData2s;
      print(suica.sense.rw_mac);
      expect(suica.sense.rw_mac == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.rw_mac == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.rw_mac = defalut;
      print(suica.sense.rw_mac);
      expect(suica.sense.rw_mac == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.rw_mac == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.rw_ip;
      print(suica.sense.rw_ip);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.rw_ip = testData1s;
      print(suica.sense.rw_ip);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.rw_ip == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.rw_ip == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.rw_ip = testData2s;
      print(suica.sense.rw_ip);
      expect(suica.sense.rw_ip == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.rw_ip == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.rw_ip = defalut;
      print(suica.sense.rw_ip);
      expect(suica.sense.rw_ip == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.rw_ip == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.subnet;
      print(suica.sense.subnet);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.subnet = testData1s;
      print(suica.sense.subnet);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.subnet == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.subnet == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.subnet = testData2s;
      print(suica.sense.subnet);
      expect(suica.sense.subnet == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.subnet == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.subnet = defalut;
      print(suica.sense.subnet);
      expect(suica.sense.subnet == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.subnet == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.gateway;
      print(suica.sense.gateway);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.gateway = testData1s;
      print(suica.sense.gateway);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.gateway == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.gateway == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.gateway = testData2s;
      print(suica.sense.gateway);
      expect(suica.sense.gateway == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.gateway == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.gateway = defalut;
      print(suica.sense.gateway);
      expect(suica.sense.gateway == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.gateway == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.svr_ip;
      print(suica.sense.svr_ip);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.svr_ip = testData1s;
      print(suica.sense.svr_ip);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.svr_ip == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.svr_ip == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.svr_ip = testData2s;
      print(suica.sense.svr_ip);
      expect(suica.sense.svr_ip == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.svr_ip == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.svr_ip = defalut;
      print(suica.sense.svr_ip);
      expect(suica.sense.svr_ip == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.svr_ip == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.port_no;
      print(suica.sense.port_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.port_no = testData1s;
      print(suica.sense.port_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.port_no == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.port_no == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.port_no = testData2s;
      print(suica.sense.port_no);
      expect(suica.sense.port_no == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.port_no == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.port_no = defalut;
      print(suica.sense.port_no);
      expect(suica.sense.port_no == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.port_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.serial_no;
      print(suica.sense.serial_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.serial_no = testData1s;
      print(suica.sense.serial_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.serial_no == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.serial_no == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.serial_no = testData2s;
      print(suica.sense.serial_no);
      expect(suica.sense.serial_no == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.serial_no == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.serial_no = defalut;
      print(suica.sense.serial_no);
      expect(suica.sense.serial_no == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.serial_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.product_no;
      print(suica.sense.product_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.product_no = testData1s;
      print(suica.sense.product_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.product_no == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.product_no == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.product_no = testData2s;
      print(suica.sense.product_no);
      expect(suica.sense.product_no == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.product_no == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.product_no = defalut;
      print(suica.sense.product_no);
      expect(suica.sense.product_no == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.product_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.end_icseq;
      print(suica.sense.end_icseq);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.end_icseq = testData1s;
      print(suica.sense.end_icseq);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.end_icseq == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.end_icseq == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.end_icseq = testData2s;
      print(suica.sense.end_icseq);
      expect(suica.sense.end_icseq == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.end_icseq == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.end_icseq = defalut;
      print(suica.sense.end_icseq);
      expect(suica.sense.end_icseq == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.end_icseq == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.send_cnt;
      print(suica.sense.send_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.send_cnt = testData1s;
      print(suica.sense.send_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.send_cnt == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.send_cnt == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.send_cnt = testData2s;
      print(suica.sense.send_cnt);
      expect(suica.sense.send_cnt == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.send_cnt == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.send_cnt = defalut;
      print(suica.sense.send_cnt);
      expect(suica.sense.send_cnt == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.send_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.non_send_cnt;
      print(suica.sense.non_send_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.non_send_cnt = testData1s;
      print(suica.sense.non_send_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.non_send_cnt == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.non_send_cnt == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.non_send_cnt = testData2s;
      print(suica.sense.non_send_cnt);
      expect(suica.sense.non_send_cnt == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.non_send_cnt == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.non_send_cnt = defalut;
      print(suica.sense.non_send_cnt);
      expect(suica.sense.non_send_cnt == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.non_send_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.timeout1;
      print(suica.sense.timeout1);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.timeout1 = testData1s;
      print(suica.sense.timeout1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.timeout1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.timeout1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.timeout1 = testData2s;
      print(suica.sense.timeout1);
      expect(suica.sense.timeout1 == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.timeout1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.timeout1 = defalut;
      print(suica.sense.timeout1);
      expect(suica.sense.timeout1 == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.timeout1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.timeout2;
      print(suica.sense.timeout2);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.timeout2 = testData1s;
      print(suica.sense.timeout2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.timeout2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.timeout2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.timeout2 = testData2s;
      print(suica.sense.timeout2);
      expect(suica.sense.timeout2 == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.timeout2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.timeout2 = defalut;
      print(suica.sense.timeout2);
      expect(suica.sense.timeout2 == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.timeout2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.timeout3;
      print(suica.sense.timeout3);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.timeout3 = testData1s;
      print(suica.sense.timeout3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.timeout3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.timeout3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.timeout3 = testData2s;
      print(suica.sense.timeout3);
      expect(suica.sense.timeout3 == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.timeout3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.timeout3 = defalut;
      print(suica.sense.timeout3);
      expect(suica.sense.timeout3 == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.timeout3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.trm_data_pt;
      print(suica.sense.trm_data_pt);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.trm_data_pt = testData1s;
      print(suica.sense.trm_data_pt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.trm_data_pt == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.trm_data_pt == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.trm_data_pt = testData2s;
      print(suica.sense.trm_data_pt);
      expect(suica.sense.trm_data_pt == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.trm_data_pt == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.trm_data_pt = defalut;
      print(suica.sense.trm_data_pt);
      expect(suica.sense.trm_data_pt == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.trm_data_pt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.trm_data_vr;
      print(suica.sense.trm_data_vr);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.trm_data_vr = testData1s;
      print(suica.sense.trm_data_vr);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.trm_data_vr == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.trm_data_vr == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.trm_data_vr = testData2s;
      print(suica.sense.trm_data_vr);
      expect(suica.sense.trm_data_vr == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.trm_data_vr == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.trm_data_vr = defalut;
      print(suica.sense.trm_data_vr);
      expect(suica.sense.trm_data_vr == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.trm_data_vr == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.cent_occnt;
      print(suica.sense.cent_occnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.cent_occnt = testData1s;
      print(suica.sense.cent_occnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.cent_occnt == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.cent_occnt == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.cent_occnt = testData2s;
      print(suica.sense.cent_occnt);
      expect(suica.sense.cent_occnt == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.cent_occnt == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.cent_occnt = defalut;
      print(suica.sense.cent_occnt);
      expect(suica.sense.cent_occnt == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.cent_occnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.est_part;
      print(suica.sense.est_part);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.est_part = testData1s;
      print(suica.sense.est_part);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.est_part == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.est_part == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.est_part = testData2s;
      print(suica.sense.est_part);
      expect(suica.sense.est_part == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.est_part == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.est_part = defalut;
      print(suica.sense.est_part);
      expect(suica.sense.est_part == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.est_part == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.parse_amt;
      print(suica.sense.parse_amt);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.parse_amt = testData1s;
      print(suica.sense.parse_amt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.parse_amt == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.parse_amt == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.parse_amt = testData2s;
      print(suica.sense.parse_amt);
      expect(suica.sense.parse_amt == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.parse_amt == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.parse_amt = defalut;
      print(suica.sense.parse_amt);
      expect(suica.sense.parse_amt == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.parse_amt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.sense.rw_fver;
      print(suica.sense.rw_fver);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.sense.rw_fver = testData1s;
      print(suica.sense.rw_fver);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.sense.rw_fver == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.sense.rw_fver == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.sense.rw_fver = testData2s;
      print(suica.sense.rw_fver);
      expect(suica.sense.rw_fver == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.rw_fver == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.sense.rw_fver = defalut;
      print(suica.sense.rw_fver);
      expect(suica.sense.rw_fver == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.sense.rw_fver == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.TRAN.before_tran_typ;
      print(suica.TRAN.before_tran_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.TRAN.before_tran_typ = testData1s;
      print(suica.TRAN.before_tran_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.TRAN.before_tran_typ == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.TRAN.before_tran_typ == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.TRAN.before_tran_typ = testData2s;
      print(suica.TRAN.before_tran_typ);
      expect(suica.TRAN.before_tran_typ == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.TRAN.before_tran_typ == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.TRAN.before_tran_typ = defalut;
      print(suica.TRAN.before_tran_typ);
      expect(suica.TRAN.before_tran_typ == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.TRAN.before_tran_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.TRAN.before_tran_amt;
      print(suica.TRAN.before_tran_amt);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.TRAN.before_tran_amt = testData1s;
      print(suica.TRAN.before_tran_amt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.TRAN.before_tran_amt == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.TRAN.before_tran_amt == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.TRAN.before_tran_amt = testData2s;
      print(suica.TRAN.before_tran_amt);
      expect(suica.TRAN.before_tran_amt == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.TRAN.before_tran_amt == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.TRAN.before_tran_amt = defalut;
      print(suica.TRAN.before_tran_amt);
      expect(suica.TRAN.before_tran_amt == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.TRAN.before_tran_amt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.TRAN.before_seq_ic;
      print(suica.TRAN.before_seq_ic);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.TRAN.before_seq_ic = testData1s;
      print(suica.TRAN.before_seq_ic);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.TRAN.before_seq_ic == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.TRAN.before_seq_ic == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.TRAN.before_seq_ic = testData2s;
      print(suica.TRAN.before_seq_ic);
      expect(suica.TRAN.before_seq_ic == testData2s, true);
      await suica.save();
      await suica.load();
      expect(suica.TRAN.before_seq_ic == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.TRAN.before_seq_ic = defalut;
      print(suica.TRAN.before_seq_ic);
      expect(suica.TRAN.before_seq_ic == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.TRAN.before_seq_ic == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.key.suica_debug_key;
      print(suica.key.suica_debug_key);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.key.suica_debug_key = testData1;
      print(suica.key.suica_debug_key);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.key.suica_debug_key == testData1, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.key.suica_debug_key == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.key.suica_debug_key = testData2;
      print(suica.key.suica_debug_key);
      expect(suica.key.suica_debug_key == testData2, true);
      await suica.save();
      await suica.load();
      expect(suica.key.suica_debug_key == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.key.suica_debug_key = defalut;
      print(suica.key.suica_debug_key);
      expect(suica.key.suica_debug_key == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.key.suica_debug_key == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.multi_nimoca.nimoca_aplchg_wait1;
      print(suica.multi_nimoca.nimoca_aplchg_wait1);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.multi_nimoca.nimoca_aplchg_wait1 = testData1;
      print(suica.multi_nimoca.nimoca_aplchg_wait1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.multi_nimoca.nimoca_aplchg_wait1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.multi_nimoca.nimoca_aplchg_wait1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.multi_nimoca.nimoca_aplchg_wait1 = testData2;
      print(suica.multi_nimoca.nimoca_aplchg_wait1);
      expect(suica.multi_nimoca.nimoca_aplchg_wait1 == testData2, true);
      await suica.save();
      await suica.load();
      expect(suica.multi_nimoca.nimoca_aplchg_wait1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.multi_nimoca.nimoca_aplchg_wait1 = defalut;
      print(suica.multi_nimoca.nimoca_aplchg_wait1);
      expect(suica.multi_nimoca.nimoca_aplchg_wait1 == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.multi_nimoca.nimoca_aplchg_wait1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.multi_nimoca.nimoca_aplchg_wait2;
      print(suica.multi_nimoca.nimoca_aplchg_wait2);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.multi_nimoca.nimoca_aplchg_wait2 = testData1;
      print(suica.multi_nimoca.nimoca_aplchg_wait2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.multi_nimoca.nimoca_aplchg_wait2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.multi_nimoca.nimoca_aplchg_wait2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.multi_nimoca.nimoca_aplchg_wait2 = testData2;
      print(suica.multi_nimoca.nimoca_aplchg_wait2);
      expect(suica.multi_nimoca.nimoca_aplchg_wait2 == testData2, true);
      await suica.save();
      await suica.load();
      expect(suica.multi_nimoca.nimoca_aplchg_wait2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.multi_nimoca.nimoca_aplchg_wait2 = defalut;
      print(suica.multi_nimoca.nimoca_aplchg_wait2);
      expect(suica.multi_nimoca.nimoca_aplchg_wait2 == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.multi_nimoca.nimoca_aplchg_wait2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      suica = SuicaJsonFile();
      allPropatyCheckInit(suica);

      // ①loadを実行する。
      await suica.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = suica.multi_nimoca.nimoca_aplchg_wait3;
      print(suica.multi_nimoca.nimoca_aplchg_wait3);

      // ②指定したプロパティにテストデータ1を書き込む。
      suica.multi_nimoca.nimoca_aplchg_wait3 = testData1;
      print(suica.multi_nimoca.nimoca_aplchg_wait3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(suica.multi_nimoca.nimoca_aplchg_wait3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await suica.save();
      await suica.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(suica.multi_nimoca.nimoca_aplchg_wait3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      suica.multi_nimoca.nimoca_aplchg_wait3 = testData2;
      print(suica.multi_nimoca.nimoca_aplchg_wait3);
      expect(suica.multi_nimoca.nimoca_aplchg_wait3 == testData2, true);
      await suica.save();
      await suica.load();
      expect(suica.multi_nimoca.nimoca_aplchg_wait3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      suica.multi_nimoca.nimoca_aplchg_wait3 = defalut;
      print(suica.multi_nimoca.nimoca_aplchg_wait3);
      expect(suica.multi_nimoca.nimoca_aplchg_wait3 == defalut, true);
      await suica.save();
      await suica.load();
      expect(suica.multi_nimoca.nimoca_aplchg_wait3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(suica, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

  });
}

void allPropatyCheckInit(SuicaJsonFile test)
{
  expect(test.suica.SuicaNo, "");
  expect(test.suica.ng_print, 0);
  expect(test.sense.send_date, "");
  expect(test.sense.offset, "");
  expect(test.sense.rw_code, "");
  expect(test.sense.str_id, "");
  expect(test.sense.rw_mac, "");
  expect(test.sense.rw_ip, "");
  expect(test.sense.subnet, "");
  expect(test.sense.gateway, "");
  expect(test.sense.svr_ip, "");
  expect(test.sense.port_no, "");
  expect(test.sense.serial_no, "");
  expect(test.sense.product_no, "");
  expect(test.sense.end_icseq, "");
  expect(test.sense.send_cnt, "");
  expect(test.sense.non_send_cnt, "");
  expect(test.sense.timeout1, "");
  expect(test.sense.timeout2, "");
  expect(test.sense.timeout3, "");
  expect(test.sense.trm_data_pt, "");
  expect(test.sense.trm_data_vr, "");
  expect(test.sense.cent_occnt, "");
  expect(test.sense.est_part, "");
  expect(test.sense.parse_amt, "");
  expect(test.sense.rw_fver, "");
  expect(test.TRAN.before_tran_typ, "");
  expect(test.TRAN.before_tran_amt, "");
  expect(test.TRAN.before_seq_ic, "");
  expect(test.key.suica_debug_key, 0);
  expect(test.multi_nimoca.nimoca_aplchg_wait1, 0);
  expect(test.multi_nimoca.nimoca_aplchg_wait2, 0);
  expect(test.multi_nimoca.nimoca_aplchg_wait3, 0);
}

void allPropatyCheck(SuicaJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.suica.SuicaNo, "0000000000000");
  }
  expect(test.suica.ng_print, 0);
  expect(test.sense.send_date, "");
  expect(test.sense.offset, "");
  expect(test.sense.rw_code, "");
  expect(test.sense.str_id, "");
  expect(test.sense.rw_mac, "");
  expect(test.sense.rw_ip, "");
  expect(test.sense.subnet, "");
  expect(test.sense.gateway, "");
  expect(test.sense.svr_ip, "");
  expect(test.sense.port_no, "");
  expect(test.sense.serial_no, "");
  expect(test.sense.product_no, "");
  expect(test.sense.end_icseq, "");
  expect(test.sense.send_cnt, "");
  expect(test.sense.non_send_cnt, "");
  expect(test.sense.timeout1, "");
  expect(test.sense.timeout2, "");
  expect(test.sense.timeout3, "");
  expect(test.sense.trm_data_pt, "");
  expect(test.sense.trm_data_vr, "");
  expect(test.sense.cent_occnt, "");
  expect(test.sense.est_part, "");
  expect(test.sense.parse_amt, "");
  expect(test.sense.rw_fver, "");
  expect(test.TRAN.before_tran_typ, "");
  expect(test.TRAN.before_tran_amt, "");
  expect(test.TRAN.before_seq_ic, "");
  expect(test.key.suica_debug_key, 0);
  expect(test.multi_nimoca.nimoca_aplchg_wait1, 4);
  expect(test.multi_nimoca.nimoca_aplchg_wait2, 2);
  expect(test.multi_nimoca.nimoca_aplchg_wait3, 4);
}

