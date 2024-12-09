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
import '../../../../lib/app/common/cls_conf/recogkey_dataJsonFile.dart';

late Recogkey_dataJsonFile recogkey_data;

void main(){
  recogkey_dataJsonFile_test();
}

void recogkey_dataJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "recogkey_data.json";
  const String section = "page1";
  const String key = "password";
  const defaultData = "";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Recogkey_dataJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Recogkey_dataJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Recogkey_dataJsonFile().setDefault();
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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await recogkey_data.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(recogkey_data,true);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        recogkey_data.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await recogkey_data.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(recogkey_data,true);

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
      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①：loadを実行する。
      await recogkey_data.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = recogkey_data.page1.password;
      recogkey_data.page1.password = testData1s;
      expect(recogkey_data.page1.password == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await recogkey_data.load();
      expect(recogkey_data.page1.password != testData1s, true);
      expect(recogkey_data.page1.password == prefixData, true);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = recogkey_data.page1.password;
      recogkey_data.page1.password = testData1s;
      expect(recogkey_data.page1.password, testData1s);

      // ③saveを実行する。
      await recogkey_data.save();

      // ④loadを実行する。
      await recogkey_data.load();

      expect(recogkey_data.page1.password != prefixData, true);
      expect(recogkey_data.page1.password == testData1s, true);
      allPropatyCheck(recogkey_data,false);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await recogkey_data.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await recogkey_data.save();

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await recogkey_data.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(recogkey_data.page1.password, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = recogkey_data.page1.password;
      recogkey_data.page1.password = testData1s;

      // ③ saveを実行する。
      await recogkey_data.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(recogkey_data.page1.password, testData1s);

      // ④ loadを実行する。
      await recogkey_data.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(recogkey_data.page1.password == testData1s, true);
      allPropatyCheck(recogkey_data,false);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await recogkey_data.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(recogkey_data,true);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②任意のプロパティの値を変更する。
      recogkey_data.page1.password = testData1s;
      expect(recogkey_data.page1.password, testData1s);

      // ③saveを実行する。
      await recogkey_data.save();
      expect(recogkey_data.page1.password, testData1s);

      // ④loadを実行する。
      await recogkey_data.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(recogkey_data,true);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await recogkey_data.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await recogkey_data.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(recogkey_data.page1.password == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await recogkey_data.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await recogkey_data.setValueWithName(section, "test_key", testData1s);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②任意のプロパティを変更する。
      recogkey_data.page1.password = testData1s;

      // ③saveを実行する。
      await recogkey_data.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await recogkey_data.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②任意のプロパティを変更する。
      recogkey_data.page1.password = testData1s;

      // ③saveを実行する。
      await recogkey_data.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await recogkey_data.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②任意のプロパティを変更する。
      recogkey_data.page1.password = testData1s;

      // ③saveを実行する。
      await recogkey_data.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await recogkey_data.getValueWithName(section, "test_key");
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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await recogkey_data.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      recogkey_data.page1.password = testData1s;
      expect(recogkey_data.page1.password, testData1s);

      // ④saveを実行する。
      await recogkey_data.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(recogkey_data.page1.password, testData1s);
      
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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await recogkey_data.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + recogkey_data.page1.password.toString());
      expect(recogkey_data.page1.password == testData1s, true);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await recogkey_data.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + recogkey_data.page1.password.toString());
      expect(recogkey_data.page1.password == testData2s, true);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await recogkey_data.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + recogkey_data.page1.password.toString());
      expect(recogkey_data.page1.password == testData1s, true);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await recogkey_data.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + recogkey_data.page1.password.toString());
      expect(recogkey_data.page1.password == testData2s, true);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await recogkey_data.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + recogkey_data.page1.password.toString());
      expect(recogkey_data.page1.password == testData1s, true);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await recogkey_data.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + recogkey_data.page1.password.toString());
      expect(recogkey_data.page1.password == testData1s, true);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await recogkey_data.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + recogkey_data.page1.password.toString());
      allPropatyCheck(recogkey_data,true);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await recogkey_data.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + recogkey_data.page1.password.toString());
      allPropatyCheck(recogkey_data,true);

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

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page1.password;
      print(recogkey_data.page1.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page1.password = testData1s;
      print(recogkey_data.page1.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page1.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page1.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page1.password = testData2s;
      print(recogkey_data.page1.password);
      expect(recogkey_data.page1.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page1.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page1.password = defalut;
      print(recogkey_data.page1.password);
      expect(recogkey_data.page1.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page1.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page1.fcode;
      print(recogkey_data.page1.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page1.fcode = testData1s;
      print(recogkey_data.page1.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page1.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page1.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page1.fcode = testData2s;
      print(recogkey_data.page1.fcode);
      expect(recogkey_data.page1.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page1.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page1.fcode = defalut;
      print(recogkey_data.page1.fcode);
      expect(recogkey_data.page1.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page1.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page1.qcjc_type;
      print(recogkey_data.page1.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page1.qcjc_type = testData1s;
      print(recogkey_data.page1.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page1.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page1.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page1.qcjc_type = testData2s;
      print(recogkey_data.page1.qcjc_type);
      expect(recogkey_data.page1.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page1.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page1.qcjc_type = defalut;
      print(recogkey_data.page1.qcjc_type);
      expect(recogkey_data.page1.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page1.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page2.password;
      print(recogkey_data.page2.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page2.password = testData1s;
      print(recogkey_data.page2.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page2.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page2.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page2.password = testData2s;
      print(recogkey_data.page2.password);
      expect(recogkey_data.page2.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page2.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page2.password = defalut;
      print(recogkey_data.page2.password);
      expect(recogkey_data.page2.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page2.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page2.fcode;
      print(recogkey_data.page2.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page2.fcode = testData1s;
      print(recogkey_data.page2.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page2.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page2.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page2.fcode = testData2s;
      print(recogkey_data.page2.fcode);
      expect(recogkey_data.page2.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page2.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page2.fcode = defalut;
      print(recogkey_data.page2.fcode);
      expect(recogkey_data.page2.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page2.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page2.qcjc_type;
      print(recogkey_data.page2.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page2.qcjc_type = testData1s;
      print(recogkey_data.page2.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page2.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page2.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page2.qcjc_type = testData2s;
      print(recogkey_data.page2.qcjc_type);
      expect(recogkey_data.page2.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page2.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page2.qcjc_type = defalut;
      print(recogkey_data.page2.qcjc_type);
      expect(recogkey_data.page2.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page2.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page3.password;
      print(recogkey_data.page3.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page3.password = testData1s;
      print(recogkey_data.page3.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page3.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page3.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page3.password = testData2s;
      print(recogkey_data.page3.password);
      expect(recogkey_data.page3.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page3.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page3.password = defalut;
      print(recogkey_data.page3.password);
      expect(recogkey_data.page3.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page3.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page3.fcode;
      print(recogkey_data.page3.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page3.fcode = testData1s;
      print(recogkey_data.page3.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page3.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page3.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page3.fcode = testData2s;
      print(recogkey_data.page3.fcode);
      expect(recogkey_data.page3.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page3.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page3.fcode = defalut;
      print(recogkey_data.page3.fcode);
      expect(recogkey_data.page3.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page3.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page3.qcjc_type;
      print(recogkey_data.page3.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page3.qcjc_type = testData1s;
      print(recogkey_data.page3.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page3.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page3.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page3.qcjc_type = testData2s;
      print(recogkey_data.page3.qcjc_type);
      expect(recogkey_data.page3.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page3.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page3.qcjc_type = defalut;
      print(recogkey_data.page3.qcjc_type);
      expect(recogkey_data.page3.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page3.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page4.password;
      print(recogkey_data.page4.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page4.password = testData1s;
      print(recogkey_data.page4.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page4.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page4.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page4.password = testData2s;
      print(recogkey_data.page4.password);
      expect(recogkey_data.page4.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page4.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page4.password = defalut;
      print(recogkey_data.page4.password);
      expect(recogkey_data.page4.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page4.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page4.fcode;
      print(recogkey_data.page4.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page4.fcode = testData1s;
      print(recogkey_data.page4.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page4.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page4.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page4.fcode = testData2s;
      print(recogkey_data.page4.fcode);
      expect(recogkey_data.page4.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page4.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page4.fcode = defalut;
      print(recogkey_data.page4.fcode);
      expect(recogkey_data.page4.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page4.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page4.qcjc_type;
      print(recogkey_data.page4.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page4.qcjc_type = testData1s;
      print(recogkey_data.page4.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page4.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page4.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page4.qcjc_type = testData2s;
      print(recogkey_data.page4.qcjc_type);
      expect(recogkey_data.page4.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page4.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page4.qcjc_type = defalut;
      print(recogkey_data.page4.qcjc_type);
      expect(recogkey_data.page4.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page4.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page5.password;
      print(recogkey_data.page5.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page5.password = testData1s;
      print(recogkey_data.page5.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page5.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page5.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page5.password = testData2s;
      print(recogkey_data.page5.password);
      expect(recogkey_data.page5.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page5.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page5.password = defalut;
      print(recogkey_data.page5.password);
      expect(recogkey_data.page5.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page5.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page5.fcode;
      print(recogkey_data.page5.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page5.fcode = testData1s;
      print(recogkey_data.page5.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page5.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page5.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page5.fcode = testData2s;
      print(recogkey_data.page5.fcode);
      expect(recogkey_data.page5.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page5.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page5.fcode = defalut;
      print(recogkey_data.page5.fcode);
      expect(recogkey_data.page5.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page5.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page5.qcjc_type;
      print(recogkey_data.page5.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page5.qcjc_type = testData1s;
      print(recogkey_data.page5.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page5.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page5.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page5.qcjc_type = testData2s;
      print(recogkey_data.page5.qcjc_type);
      expect(recogkey_data.page5.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page5.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page5.qcjc_type = defalut;
      print(recogkey_data.page5.qcjc_type);
      expect(recogkey_data.page5.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page5.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page6.password;
      print(recogkey_data.page6.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page6.password = testData1s;
      print(recogkey_data.page6.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page6.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page6.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page6.password = testData2s;
      print(recogkey_data.page6.password);
      expect(recogkey_data.page6.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page6.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page6.password = defalut;
      print(recogkey_data.page6.password);
      expect(recogkey_data.page6.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page6.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page6.fcode;
      print(recogkey_data.page6.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page6.fcode = testData1s;
      print(recogkey_data.page6.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page6.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page6.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page6.fcode = testData2s;
      print(recogkey_data.page6.fcode);
      expect(recogkey_data.page6.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page6.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page6.fcode = defalut;
      print(recogkey_data.page6.fcode);
      expect(recogkey_data.page6.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page6.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page6.qcjc_type;
      print(recogkey_data.page6.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page6.qcjc_type = testData1s;
      print(recogkey_data.page6.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page6.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page6.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page6.qcjc_type = testData2s;
      print(recogkey_data.page6.qcjc_type);
      expect(recogkey_data.page6.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page6.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page6.qcjc_type = defalut;
      print(recogkey_data.page6.qcjc_type);
      expect(recogkey_data.page6.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page6.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page7.password;
      print(recogkey_data.page7.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page7.password = testData1s;
      print(recogkey_data.page7.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page7.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page7.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page7.password = testData2s;
      print(recogkey_data.page7.password);
      expect(recogkey_data.page7.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page7.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page7.password = defalut;
      print(recogkey_data.page7.password);
      expect(recogkey_data.page7.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page7.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page7.fcode;
      print(recogkey_data.page7.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page7.fcode = testData1s;
      print(recogkey_data.page7.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page7.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page7.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page7.fcode = testData2s;
      print(recogkey_data.page7.fcode);
      expect(recogkey_data.page7.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page7.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page7.fcode = defalut;
      print(recogkey_data.page7.fcode);
      expect(recogkey_data.page7.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page7.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page7.qcjc_type;
      print(recogkey_data.page7.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page7.qcjc_type = testData1s;
      print(recogkey_data.page7.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page7.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page7.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page7.qcjc_type = testData2s;
      print(recogkey_data.page7.qcjc_type);
      expect(recogkey_data.page7.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page7.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page7.qcjc_type = defalut;
      print(recogkey_data.page7.qcjc_type);
      expect(recogkey_data.page7.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page7.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page8.password;
      print(recogkey_data.page8.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page8.password = testData1s;
      print(recogkey_data.page8.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page8.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page8.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page8.password = testData2s;
      print(recogkey_data.page8.password);
      expect(recogkey_data.page8.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page8.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page8.password = defalut;
      print(recogkey_data.page8.password);
      expect(recogkey_data.page8.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page8.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page8.fcode;
      print(recogkey_data.page8.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page8.fcode = testData1s;
      print(recogkey_data.page8.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page8.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page8.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page8.fcode = testData2s;
      print(recogkey_data.page8.fcode);
      expect(recogkey_data.page8.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page8.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page8.fcode = defalut;
      print(recogkey_data.page8.fcode);
      expect(recogkey_data.page8.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page8.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page8.qcjc_type;
      print(recogkey_data.page8.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page8.qcjc_type = testData1s;
      print(recogkey_data.page8.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page8.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page8.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page8.qcjc_type = testData2s;
      print(recogkey_data.page8.qcjc_type);
      expect(recogkey_data.page8.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page8.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page8.qcjc_type = defalut;
      print(recogkey_data.page8.qcjc_type);
      expect(recogkey_data.page8.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page8.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page9.password;
      print(recogkey_data.page9.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page9.password = testData1s;
      print(recogkey_data.page9.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page9.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page9.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page9.password = testData2s;
      print(recogkey_data.page9.password);
      expect(recogkey_data.page9.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page9.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page9.password = defalut;
      print(recogkey_data.page9.password);
      expect(recogkey_data.page9.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page9.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page9.fcode;
      print(recogkey_data.page9.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page9.fcode = testData1s;
      print(recogkey_data.page9.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page9.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page9.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page9.fcode = testData2s;
      print(recogkey_data.page9.fcode);
      expect(recogkey_data.page9.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page9.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page9.fcode = defalut;
      print(recogkey_data.page9.fcode);
      expect(recogkey_data.page9.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page9.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page9.qcjc_type;
      print(recogkey_data.page9.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page9.qcjc_type = testData1s;
      print(recogkey_data.page9.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page9.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page9.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page9.qcjc_type = testData2s;
      print(recogkey_data.page9.qcjc_type);
      expect(recogkey_data.page9.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page9.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page9.qcjc_type = defalut;
      print(recogkey_data.page9.qcjc_type);
      expect(recogkey_data.page9.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page9.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page10.password;
      print(recogkey_data.page10.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page10.password = testData1s;
      print(recogkey_data.page10.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page10.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page10.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page10.password = testData2s;
      print(recogkey_data.page10.password);
      expect(recogkey_data.page10.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page10.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page10.password = defalut;
      print(recogkey_data.page10.password);
      expect(recogkey_data.page10.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page10.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page10.fcode;
      print(recogkey_data.page10.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page10.fcode = testData1s;
      print(recogkey_data.page10.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page10.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page10.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page10.fcode = testData2s;
      print(recogkey_data.page10.fcode);
      expect(recogkey_data.page10.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page10.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page10.fcode = defalut;
      print(recogkey_data.page10.fcode);
      expect(recogkey_data.page10.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page10.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page10.qcjc_type;
      print(recogkey_data.page10.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page10.qcjc_type = testData1s;
      print(recogkey_data.page10.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page10.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page10.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page10.qcjc_type = testData2s;
      print(recogkey_data.page10.qcjc_type);
      expect(recogkey_data.page10.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page10.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page10.qcjc_type = defalut;
      print(recogkey_data.page10.qcjc_type);
      expect(recogkey_data.page10.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page10.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page11.password;
      print(recogkey_data.page11.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page11.password = testData1s;
      print(recogkey_data.page11.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page11.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page11.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page11.password = testData2s;
      print(recogkey_data.page11.password);
      expect(recogkey_data.page11.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page11.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page11.password = defalut;
      print(recogkey_data.page11.password);
      expect(recogkey_data.page11.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page11.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page11.fcode;
      print(recogkey_data.page11.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page11.fcode = testData1s;
      print(recogkey_data.page11.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page11.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page11.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page11.fcode = testData2s;
      print(recogkey_data.page11.fcode);
      expect(recogkey_data.page11.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page11.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page11.fcode = defalut;
      print(recogkey_data.page11.fcode);
      expect(recogkey_data.page11.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page11.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page11.qcjc_type;
      print(recogkey_data.page11.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page11.qcjc_type = testData1s;
      print(recogkey_data.page11.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page11.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page11.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page11.qcjc_type = testData2s;
      print(recogkey_data.page11.qcjc_type);
      expect(recogkey_data.page11.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page11.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page11.qcjc_type = defalut;
      print(recogkey_data.page11.qcjc_type);
      expect(recogkey_data.page11.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page11.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page12.password;
      print(recogkey_data.page12.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page12.password = testData1s;
      print(recogkey_data.page12.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page12.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page12.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page12.password = testData2s;
      print(recogkey_data.page12.password);
      expect(recogkey_data.page12.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page12.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page12.password = defalut;
      print(recogkey_data.page12.password);
      expect(recogkey_data.page12.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page12.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page12.fcode;
      print(recogkey_data.page12.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page12.fcode = testData1s;
      print(recogkey_data.page12.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page12.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page12.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page12.fcode = testData2s;
      print(recogkey_data.page12.fcode);
      expect(recogkey_data.page12.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page12.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page12.fcode = defalut;
      print(recogkey_data.page12.fcode);
      expect(recogkey_data.page12.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page12.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page12.qcjc_type;
      print(recogkey_data.page12.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page12.qcjc_type = testData1s;
      print(recogkey_data.page12.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page12.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page12.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page12.qcjc_type = testData2s;
      print(recogkey_data.page12.qcjc_type);
      expect(recogkey_data.page12.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page12.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page12.qcjc_type = defalut;
      print(recogkey_data.page12.qcjc_type);
      expect(recogkey_data.page12.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page12.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page13.password;
      print(recogkey_data.page13.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page13.password = testData1s;
      print(recogkey_data.page13.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page13.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page13.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page13.password = testData2s;
      print(recogkey_data.page13.password);
      expect(recogkey_data.page13.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page13.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page13.password = defalut;
      print(recogkey_data.page13.password);
      expect(recogkey_data.page13.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page13.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page13.fcode;
      print(recogkey_data.page13.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page13.fcode = testData1s;
      print(recogkey_data.page13.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page13.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page13.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page13.fcode = testData2s;
      print(recogkey_data.page13.fcode);
      expect(recogkey_data.page13.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page13.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page13.fcode = defalut;
      print(recogkey_data.page13.fcode);
      expect(recogkey_data.page13.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page13.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page13.qcjc_type;
      print(recogkey_data.page13.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page13.qcjc_type = testData1s;
      print(recogkey_data.page13.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page13.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page13.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page13.qcjc_type = testData2s;
      print(recogkey_data.page13.qcjc_type);
      expect(recogkey_data.page13.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page13.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page13.qcjc_type = defalut;
      print(recogkey_data.page13.qcjc_type);
      expect(recogkey_data.page13.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page13.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page14.password;
      print(recogkey_data.page14.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page14.password = testData1s;
      print(recogkey_data.page14.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page14.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page14.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page14.password = testData2s;
      print(recogkey_data.page14.password);
      expect(recogkey_data.page14.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page14.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page14.password = defalut;
      print(recogkey_data.page14.password);
      expect(recogkey_data.page14.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page14.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page14.fcode;
      print(recogkey_data.page14.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page14.fcode = testData1s;
      print(recogkey_data.page14.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page14.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page14.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page14.fcode = testData2s;
      print(recogkey_data.page14.fcode);
      expect(recogkey_data.page14.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page14.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page14.fcode = defalut;
      print(recogkey_data.page14.fcode);
      expect(recogkey_data.page14.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page14.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page14.qcjc_type;
      print(recogkey_data.page14.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page14.qcjc_type = testData1s;
      print(recogkey_data.page14.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page14.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page14.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page14.qcjc_type = testData2s;
      print(recogkey_data.page14.qcjc_type);
      expect(recogkey_data.page14.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page14.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page14.qcjc_type = defalut;
      print(recogkey_data.page14.qcjc_type);
      expect(recogkey_data.page14.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page14.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page15.password;
      print(recogkey_data.page15.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page15.password = testData1s;
      print(recogkey_data.page15.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page15.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page15.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page15.password = testData2s;
      print(recogkey_data.page15.password);
      expect(recogkey_data.page15.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page15.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page15.password = defalut;
      print(recogkey_data.page15.password);
      expect(recogkey_data.page15.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page15.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page15.fcode;
      print(recogkey_data.page15.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page15.fcode = testData1s;
      print(recogkey_data.page15.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page15.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page15.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page15.fcode = testData2s;
      print(recogkey_data.page15.fcode);
      expect(recogkey_data.page15.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page15.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page15.fcode = defalut;
      print(recogkey_data.page15.fcode);
      expect(recogkey_data.page15.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page15.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page15.qcjc_type;
      print(recogkey_data.page15.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page15.qcjc_type = testData1s;
      print(recogkey_data.page15.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page15.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page15.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page15.qcjc_type = testData2s;
      print(recogkey_data.page15.qcjc_type);
      expect(recogkey_data.page15.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page15.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page15.qcjc_type = defalut;
      print(recogkey_data.page15.qcjc_type);
      expect(recogkey_data.page15.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page15.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page16.password;
      print(recogkey_data.page16.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page16.password = testData1s;
      print(recogkey_data.page16.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page16.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page16.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page16.password = testData2s;
      print(recogkey_data.page16.password);
      expect(recogkey_data.page16.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page16.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page16.password = defalut;
      print(recogkey_data.page16.password);
      expect(recogkey_data.page16.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page16.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page16.fcode;
      print(recogkey_data.page16.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page16.fcode = testData1s;
      print(recogkey_data.page16.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page16.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page16.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page16.fcode = testData2s;
      print(recogkey_data.page16.fcode);
      expect(recogkey_data.page16.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page16.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page16.fcode = defalut;
      print(recogkey_data.page16.fcode);
      expect(recogkey_data.page16.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page16.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page16.qcjc_type;
      print(recogkey_data.page16.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page16.qcjc_type = testData1s;
      print(recogkey_data.page16.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page16.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page16.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page16.qcjc_type = testData2s;
      print(recogkey_data.page16.qcjc_type);
      expect(recogkey_data.page16.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page16.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page16.qcjc_type = defalut;
      print(recogkey_data.page16.qcjc_type);
      expect(recogkey_data.page16.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page16.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page17.password;
      print(recogkey_data.page17.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page17.password = testData1s;
      print(recogkey_data.page17.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page17.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page17.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page17.password = testData2s;
      print(recogkey_data.page17.password);
      expect(recogkey_data.page17.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page17.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page17.password = defalut;
      print(recogkey_data.page17.password);
      expect(recogkey_data.page17.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page17.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page17.fcode;
      print(recogkey_data.page17.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page17.fcode = testData1s;
      print(recogkey_data.page17.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page17.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page17.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page17.fcode = testData2s;
      print(recogkey_data.page17.fcode);
      expect(recogkey_data.page17.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page17.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page17.fcode = defalut;
      print(recogkey_data.page17.fcode);
      expect(recogkey_data.page17.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page17.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page17.qcjc_type;
      print(recogkey_data.page17.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page17.qcjc_type = testData1s;
      print(recogkey_data.page17.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page17.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page17.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page17.qcjc_type = testData2s;
      print(recogkey_data.page17.qcjc_type);
      expect(recogkey_data.page17.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page17.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page17.qcjc_type = defalut;
      print(recogkey_data.page17.qcjc_type);
      expect(recogkey_data.page17.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page17.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page18.password;
      print(recogkey_data.page18.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page18.password = testData1s;
      print(recogkey_data.page18.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page18.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page18.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page18.password = testData2s;
      print(recogkey_data.page18.password);
      expect(recogkey_data.page18.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page18.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page18.password = defalut;
      print(recogkey_data.page18.password);
      expect(recogkey_data.page18.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page18.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page18.fcode;
      print(recogkey_data.page18.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page18.fcode = testData1s;
      print(recogkey_data.page18.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page18.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page18.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page18.fcode = testData2s;
      print(recogkey_data.page18.fcode);
      expect(recogkey_data.page18.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page18.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page18.fcode = defalut;
      print(recogkey_data.page18.fcode);
      expect(recogkey_data.page18.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page18.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page18.qcjc_type;
      print(recogkey_data.page18.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page18.qcjc_type = testData1s;
      print(recogkey_data.page18.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page18.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page18.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page18.qcjc_type = testData2s;
      print(recogkey_data.page18.qcjc_type);
      expect(recogkey_data.page18.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page18.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page18.qcjc_type = defalut;
      print(recogkey_data.page18.qcjc_type);
      expect(recogkey_data.page18.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page18.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page19.password;
      print(recogkey_data.page19.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page19.password = testData1s;
      print(recogkey_data.page19.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page19.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page19.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page19.password = testData2s;
      print(recogkey_data.page19.password);
      expect(recogkey_data.page19.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page19.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page19.password = defalut;
      print(recogkey_data.page19.password);
      expect(recogkey_data.page19.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page19.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page19.fcode;
      print(recogkey_data.page19.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page19.fcode = testData1s;
      print(recogkey_data.page19.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page19.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page19.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page19.fcode = testData2s;
      print(recogkey_data.page19.fcode);
      expect(recogkey_data.page19.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page19.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page19.fcode = defalut;
      print(recogkey_data.page19.fcode);
      expect(recogkey_data.page19.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page19.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page19.qcjc_type;
      print(recogkey_data.page19.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page19.qcjc_type = testData1s;
      print(recogkey_data.page19.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page19.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page19.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page19.qcjc_type = testData2s;
      print(recogkey_data.page19.qcjc_type);
      expect(recogkey_data.page19.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page19.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page19.qcjc_type = defalut;
      print(recogkey_data.page19.qcjc_type);
      expect(recogkey_data.page19.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page19.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page20.password;
      print(recogkey_data.page20.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page20.password = testData1s;
      print(recogkey_data.page20.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page20.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page20.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page20.password = testData2s;
      print(recogkey_data.page20.password);
      expect(recogkey_data.page20.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page20.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page20.password = defalut;
      print(recogkey_data.page20.password);
      expect(recogkey_data.page20.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page20.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page20.fcode;
      print(recogkey_data.page20.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page20.fcode = testData1s;
      print(recogkey_data.page20.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page20.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page20.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page20.fcode = testData2s;
      print(recogkey_data.page20.fcode);
      expect(recogkey_data.page20.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page20.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page20.fcode = defalut;
      print(recogkey_data.page20.fcode);
      expect(recogkey_data.page20.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page20.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page20.qcjc_type;
      print(recogkey_data.page20.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page20.qcjc_type = testData1s;
      print(recogkey_data.page20.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page20.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page20.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page20.qcjc_type = testData2s;
      print(recogkey_data.page20.qcjc_type);
      expect(recogkey_data.page20.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page20.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page20.qcjc_type = defalut;
      print(recogkey_data.page20.qcjc_type);
      expect(recogkey_data.page20.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page20.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page21.password;
      print(recogkey_data.page21.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page21.password = testData1s;
      print(recogkey_data.page21.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page21.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page21.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page21.password = testData2s;
      print(recogkey_data.page21.password);
      expect(recogkey_data.page21.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page21.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page21.password = defalut;
      print(recogkey_data.page21.password);
      expect(recogkey_data.page21.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page21.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page21.fcode;
      print(recogkey_data.page21.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page21.fcode = testData1s;
      print(recogkey_data.page21.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page21.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page21.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page21.fcode = testData2s;
      print(recogkey_data.page21.fcode);
      expect(recogkey_data.page21.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page21.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page21.fcode = defalut;
      print(recogkey_data.page21.fcode);
      expect(recogkey_data.page21.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page21.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page21.qcjc_type;
      print(recogkey_data.page21.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page21.qcjc_type = testData1s;
      print(recogkey_data.page21.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page21.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page21.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page21.qcjc_type = testData2s;
      print(recogkey_data.page21.qcjc_type);
      expect(recogkey_data.page21.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page21.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page21.qcjc_type = defalut;
      print(recogkey_data.page21.qcjc_type);
      expect(recogkey_data.page21.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page21.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page22.password;
      print(recogkey_data.page22.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page22.password = testData1s;
      print(recogkey_data.page22.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page22.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page22.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page22.password = testData2s;
      print(recogkey_data.page22.password);
      expect(recogkey_data.page22.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page22.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page22.password = defalut;
      print(recogkey_data.page22.password);
      expect(recogkey_data.page22.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page22.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page22.fcode;
      print(recogkey_data.page22.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page22.fcode = testData1s;
      print(recogkey_data.page22.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page22.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page22.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page22.fcode = testData2s;
      print(recogkey_data.page22.fcode);
      expect(recogkey_data.page22.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page22.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page22.fcode = defalut;
      print(recogkey_data.page22.fcode);
      expect(recogkey_data.page22.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page22.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page22.qcjc_type;
      print(recogkey_data.page22.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page22.qcjc_type = testData1s;
      print(recogkey_data.page22.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page22.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page22.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page22.qcjc_type = testData2s;
      print(recogkey_data.page22.qcjc_type);
      expect(recogkey_data.page22.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page22.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page22.qcjc_type = defalut;
      print(recogkey_data.page22.qcjc_type);
      expect(recogkey_data.page22.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page22.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page23.password;
      print(recogkey_data.page23.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page23.password = testData1s;
      print(recogkey_data.page23.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page23.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page23.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page23.password = testData2s;
      print(recogkey_data.page23.password);
      expect(recogkey_data.page23.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page23.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page23.password = defalut;
      print(recogkey_data.page23.password);
      expect(recogkey_data.page23.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page23.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page23.fcode;
      print(recogkey_data.page23.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page23.fcode = testData1s;
      print(recogkey_data.page23.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page23.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page23.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page23.fcode = testData2s;
      print(recogkey_data.page23.fcode);
      expect(recogkey_data.page23.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page23.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page23.fcode = defalut;
      print(recogkey_data.page23.fcode);
      expect(recogkey_data.page23.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page23.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page23.qcjc_type;
      print(recogkey_data.page23.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page23.qcjc_type = testData1s;
      print(recogkey_data.page23.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page23.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page23.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page23.qcjc_type = testData2s;
      print(recogkey_data.page23.qcjc_type);
      expect(recogkey_data.page23.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page23.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page23.qcjc_type = defalut;
      print(recogkey_data.page23.qcjc_type);
      expect(recogkey_data.page23.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page23.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page24.password;
      print(recogkey_data.page24.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page24.password = testData1s;
      print(recogkey_data.page24.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page24.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page24.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page24.password = testData2s;
      print(recogkey_data.page24.password);
      expect(recogkey_data.page24.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page24.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page24.password = defalut;
      print(recogkey_data.page24.password);
      expect(recogkey_data.page24.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page24.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page24.fcode;
      print(recogkey_data.page24.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page24.fcode = testData1s;
      print(recogkey_data.page24.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page24.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page24.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page24.fcode = testData2s;
      print(recogkey_data.page24.fcode);
      expect(recogkey_data.page24.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page24.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page24.fcode = defalut;
      print(recogkey_data.page24.fcode);
      expect(recogkey_data.page24.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page24.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page24.qcjc_type;
      print(recogkey_data.page24.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page24.qcjc_type = testData1s;
      print(recogkey_data.page24.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page24.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page24.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page24.qcjc_type = testData2s;
      print(recogkey_data.page24.qcjc_type);
      expect(recogkey_data.page24.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page24.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page24.qcjc_type = defalut;
      print(recogkey_data.page24.qcjc_type);
      expect(recogkey_data.page24.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page24.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page25.password;
      print(recogkey_data.page25.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page25.password = testData1s;
      print(recogkey_data.page25.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page25.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page25.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page25.password = testData2s;
      print(recogkey_data.page25.password);
      expect(recogkey_data.page25.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page25.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page25.password = defalut;
      print(recogkey_data.page25.password);
      expect(recogkey_data.page25.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page25.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page25.fcode;
      print(recogkey_data.page25.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page25.fcode = testData1s;
      print(recogkey_data.page25.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page25.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page25.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page25.fcode = testData2s;
      print(recogkey_data.page25.fcode);
      expect(recogkey_data.page25.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page25.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page25.fcode = defalut;
      print(recogkey_data.page25.fcode);
      expect(recogkey_data.page25.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page25.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page25.qcjc_type;
      print(recogkey_data.page25.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page25.qcjc_type = testData1s;
      print(recogkey_data.page25.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page25.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page25.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page25.qcjc_type = testData2s;
      print(recogkey_data.page25.qcjc_type);
      expect(recogkey_data.page25.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page25.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page25.qcjc_type = defalut;
      print(recogkey_data.page25.qcjc_type);
      expect(recogkey_data.page25.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page25.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page26.password;
      print(recogkey_data.page26.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page26.password = testData1s;
      print(recogkey_data.page26.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page26.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page26.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page26.password = testData2s;
      print(recogkey_data.page26.password);
      expect(recogkey_data.page26.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page26.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page26.password = defalut;
      print(recogkey_data.page26.password);
      expect(recogkey_data.page26.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page26.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page26.fcode;
      print(recogkey_data.page26.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page26.fcode = testData1s;
      print(recogkey_data.page26.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page26.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page26.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page26.fcode = testData2s;
      print(recogkey_data.page26.fcode);
      expect(recogkey_data.page26.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page26.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page26.fcode = defalut;
      print(recogkey_data.page26.fcode);
      expect(recogkey_data.page26.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page26.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page26.qcjc_type;
      print(recogkey_data.page26.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page26.qcjc_type = testData1s;
      print(recogkey_data.page26.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page26.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page26.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page26.qcjc_type = testData2s;
      print(recogkey_data.page26.qcjc_type);
      expect(recogkey_data.page26.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page26.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page26.qcjc_type = defalut;
      print(recogkey_data.page26.qcjc_type);
      expect(recogkey_data.page26.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page26.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page27.password;
      print(recogkey_data.page27.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page27.password = testData1s;
      print(recogkey_data.page27.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page27.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page27.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page27.password = testData2s;
      print(recogkey_data.page27.password);
      expect(recogkey_data.page27.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page27.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page27.password = defalut;
      print(recogkey_data.page27.password);
      expect(recogkey_data.page27.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page27.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page27.fcode;
      print(recogkey_data.page27.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page27.fcode = testData1s;
      print(recogkey_data.page27.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page27.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page27.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page27.fcode = testData2s;
      print(recogkey_data.page27.fcode);
      expect(recogkey_data.page27.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page27.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page27.fcode = defalut;
      print(recogkey_data.page27.fcode);
      expect(recogkey_data.page27.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page27.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page27.qcjc_type;
      print(recogkey_data.page27.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page27.qcjc_type = testData1s;
      print(recogkey_data.page27.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page27.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page27.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page27.qcjc_type = testData2s;
      print(recogkey_data.page27.qcjc_type);
      expect(recogkey_data.page27.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page27.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page27.qcjc_type = defalut;
      print(recogkey_data.page27.qcjc_type);
      expect(recogkey_data.page27.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page27.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page28.password;
      print(recogkey_data.page28.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page28.password = testData1s;
      print(recogkey_data.page28.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page28.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page28.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page28.password = testData2s;
      print(recogkey_data.page28.password);
      expect(recogkey_data.page28.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page28.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page28.password = defalut;
      print(recogkey_data.page28.password);
      expect(recogkey_data.page28.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page28.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page28.fcode;
      print(recogkey_data.page28.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page28.fcode = testData1s;
      print(recogkey_data.page28.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page28.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page28.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page28.fcode = testData2s;
      print(recogkey_data.page28.fcode);
      expect(recogkey_data.page28.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page28.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page28.fcode = defalut;
      print(recogkey_data.page28.fcode);
      expect(recogkey_data.page28.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page28.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page28.qcjc_type;
      print(recogkey_data.page28.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page28.qcjc_type = testData1s;
      print(recogkey_data.page28.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page28.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page28.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page28.qcjc_type = testData2s;
      print(recogkey_data.page28.qcjc_type);
      expect(recogkey_data.page28.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page28.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page28.qcjc_type = defalut;
      print(recogkey_data.page28.qcjc_type);
      expect(recogkey_data.page28.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page28.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page29.password;
      print(recogkey_data.page29.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page29.password = testData1s;
      print(recogkey_data.page29.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page29.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page29.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page29.password = testData2s;
      print(recogkey_data.page29.password);
      expect(recogkey_data.page29.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page29.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page29.password = defalut;
      print(recogkey_data.page29.password);
      expect(recogkey_data.page29.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page29.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page29.fcode;
      print(recogkey_data.page29.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page29.fcode = testData1s;
      print(recogkey_data.page29.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page29.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page29.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page29.fcode = testData2s;
      print(recogkey_data.page29.fcode);
      expect(recogkey_data.page29.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page29.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page29.fcode = defalut;
      print(recogkey_data.page29.fcode);
      expect(recogkey_data.page29.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page29.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page29.qcjc_type;
      print(recogkey_data.page29.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page29.qcjc_type = testData1s;
      print(recogkey_data.page29.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page29.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page29.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page29.qcjc_type = testData2s;
      print(recogkey_data.page29.qcjc_type);
      expect(recogkey_data.page29.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page29.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page29.qcjc_type = defalut;
      print(recogkey_data.page29.qcjc_type);
      expect(recogkey_data.page29.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page29.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page30.password;
      print(recogkey_data.page30.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page30.password = testData1s;
      print(recogkey_data.page30.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page30.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page30.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page30.password = testData2s;
      print(recogkey_data.page30.password);
      expect(recogkey_data.page30.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page30.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page30.password = defalut;
      print(recogkey_data.page30.password);
      expect(recogkey_data.page30.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page30.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page30.fcode;
      print(recogkey_data.page30.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page30.fcode = testData1s;
      print(recogkey_data.page30.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page30.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page30.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page30.fcode = testData2s;
      print(recogkey_data.page30.fcode);
      expect(recogkey_data.page30.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page30.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page30.fcode = defalut;
      print(recogkey_data.page30.fcode);
      expect(recogkey_data.page30.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page30.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page30.qcjc_type;
      print(recogkey_data.page30.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page30.qcjc_type = testData1s;
      print(recogkey_data.page30.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page30.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page30.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page30.qcjc_type = testData2s;
      print(recogkey_data.page30.qcjc_type);
      expect(recogkey_data.page30.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page30.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page30.qcjc_type = defalut;
      print(recogkey_data.page30.qcjc_type);
      expect(recogkey_data.page30.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page30.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page31.password;
      print(recogkey_data.page31.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page31.password = testData1s;
      print(recogkey_data.page31.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page31.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page31.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page31.password = testData2s;
      print(recogkey_data.page31.password);
      expect(recogkey_data.page31.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page31.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page31.password = defalut;
      print(recogkey_data.page31.password);
      expect(recogkey_data.page31.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page31.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page31.fcode;
      print(recogkey_data.page31.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page31.fcode = testData1s;
      print(recogkey_data.page31.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page31.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page31.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page31.fcode = testData2s;
      print(recogkey_data.page31.fcode);
      expect(recogkey_data.page31.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page31.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page31.fcode = defalut;
      print(recogkey_data.page31.fcode);
      expect(recogkey_data.page31.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page31.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page31.qcjc_type;
      print(recogkey_data.page31.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page31.qcjc_type = testData1s;
      print(recogkey_data.page31.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page31.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page31.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page31.qcjc_type = testData2s;
      print(recogkey_data.page31.qcjc_type);
      expect(recogkey_data.page31.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page31.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page31.qcjc_type = defalut;
      print(recogkey_data.page31.qcjc_type);
      expect(recogkey_data.page31.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page31.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page32.password;
      print(recogkey_data.page32.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page32.password = testData1s;
      print(recogkey_data.page32.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page32.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page32.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page32.password = testData2s;
      print(recogkey_data.page32.password);
      expect(recogkey_data.page32.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page32.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page32.password = defalut;
      print(recogkey_data.page32.password);
      expect(recogkey_data.page32.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page32.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page32.fcode;
      print(recogkey_data.page32.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page32.fcode = testData1s;
      print(recogkey_data.page32.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page32.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page32.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page32.fcode = testData2s;
      print(recogkey_data.page32.fcode);
      expect(recogkey_data.page32.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page32.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page32.fcode = defalut;
      print(recogkey_data.page32.fcode);
      expect(recogkey_data.page32.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page32.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page32.qcjc_type;
      print(recogkey_data.page32.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page32.qcjc_type = testData1s;
      print(recogkey_data.page32.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page32.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page32.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page32.qcjc_type = testData2s;
      print(recogkey_data.page32.qcjc_type);
      expect(recogkey_data.page32.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page32.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page32.qcjc_type = defalut;
      print(recogkey_data.page32.qcjc_type);
      expect(recogkey_data.page32.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page32.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page33.password;
      print(recogkey_data.page33.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page33.password = testData1s;
      print(recogkey_data.page33.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page33.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page33.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page33.password = testData2s;
      print(recogkey_data.page33.password);
      expect(recogkey_data.page33.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page33.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page33.password = defalut;
      print(recogkey_data.page33.password);
      expect(recogkey_data.page33.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page33.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page33.fcode;
      print(recogkey_data.page33.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page33.fcode = testData1s;
      print(recogkey_data.page33.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page33.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page33.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page33.fcode = testData2s;
      print(recogkey_data.page33.fcode);
      expect(recogkey_data.page33.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page33.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page33.fcode = defalut;
      print(recogkey_data.page33.fcode);
      expect(recogkey_data.page33.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page33.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page33.qcjc_type;
      print(recogkey_data.page33.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page33.qcjc_type = testData1s;
      print(recogkey_data.page33.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page33.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page33.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page33.qcjc_type = testData2s;
      print(recogkey_data.page33.qcjc_type);
      expect(recogkey_data.page33.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page33.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page33.qcjc_type = defalut;
      print(recogkey_data.page33.qcjc_type);
      expect(recogkey_data.page33.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page33.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page34.password;
      print(recogkey_data.page34.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page34.password = testData1s;
      print(recogkey_data.page34.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page34.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page34.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page34.password = testData2s;
      print(recogkey_data.page34.password);
      expect(recogkey_data.page34.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page34.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page34.password = defalut;
      print(recogkey_data.page34.password);
      expect(recogkey_data.page34.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page34.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page34.fcode;
      print(recogkey_data.page34.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page34.fcode = testData1s;
      print(recogkey_data.page34.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page34.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page34.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page34.fcode = testData2s;
      print(recogkey_data.page34.fcode);
      expect(recogkey_data.page34.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page34.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page34.fcode = defalut;
      print(recogkey_data.page34.fcode);
      expect(recogkey_data.page34.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page34.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page34.qcjc_type;
      print(recogkey_data.page34.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page34.qcjc_type = testData1s;
      print(recogkey_data.page34.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page34.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page34.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page34.qcjc_type = testData2s;
      print(recogkey_data.page34.qcjc_type);
      expect(recogkey_data.page34.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page34.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page34.qcjc_type = defalut;
      print(recogkey_data.page34.qcjc_type);
      expect(recogkey_data.page34.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page34.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page35.password;
      print(recogkey_data.page35.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page35.password = testData1s;
      print(recogkey_data.page35.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page35.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page35.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page35.password = testData2s;
      print(recogkey_data.page35.password);
      expect(recogkey_data.page35.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page35.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page35.password = defalut;
      print(recogkey_data.page35.password);
      expect(recogkey_data.page35.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page35.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page35.fcode;
      print(recogkey_data.page35.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page35.fcode = testData1s;
      print(recogkey_data.page35.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page35.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page35.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page35.fcode = testData2s;
      print(recogkey_data.page35.fcode);
      expect(recogkey_data.page35.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page35.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page35.fcode = defalut;
      print(recogkey_data.page35.fcode);
      expect(recogkey_data.page35.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page35.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page35.qcjc_type;
      print(recogkey_data.page35.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page35.qcjc_type = testData1s;
      print(recogkey_data.page35.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page35.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page35.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page35.qcjc_type = testData2s;
      print(recogkey_data.page35.qcjc_type);
      expect(recogkey_data.page35.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page35.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page35.qcjc_type = defalut;
      print(recogkey_data.page35.qcjc_type);
      expect(recogkey_data.page35.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page35.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page36.password;
      print(recogkey_data.page36.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page36.password = testData1s;
      print(recogkey_data.page36.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page36.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page36.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page36.password = testData2s;
      print(recogkey_data.page36.password);
      expect(recogkey_data.page36.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page36.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page36.password = defalut;
      print(recogkey_data.page36.password);
      expect(recogkey_data.page36.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page36.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page36.fcode;
      print(recogkey_data.page36.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page36.fcode = testData1s;
      print(recogkey_data.page36.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page36.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page36.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page36.fcode = testData2s;
      print(recogkey_data.page36.fcode);
      expect(recogkey_data.page36.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page36.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page36.fcode = defalut;
      print(recogkey_data.page36.fcode);
      expect(recogkey_data.page36.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page36.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page36.qcjc_type;
      print(recogkey_data.page36.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page36.qcjc_type = testData1s;
      print(recogkey_data.page36.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page36.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page36.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page36.qcjc_type = testData2s;
      print(recogkey_data.page36.qcjc_type);
      expect(recogkey_data.page36.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page36.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page36.qcjc_type = defalut;
      print(recogkey_data.page36.qcjc_type);
      expect(recogkey_data.page36.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page36.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page37.password;
      print(recogkey_data.page37.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page37.password = testData1s;
      print(recogkey_data.page37.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page37.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page37.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page37.password = testData2s;
      print(recogkey_data.page37.password);
      expect(recogkey_data.page37.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page37.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page37.password = defalut;
      print(recogkey_data.page37.password);
      expect(recogkey_data.page37.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page37.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page37.fcode;
      print(recogkey_data.page37.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page37.fcode = testData1s;
      print(recogkey_data.page37.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page37.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page37.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page37.fcode = testData2s;
      print(recogkey_data.page37.fcode);
      expect(recogkey_data.page37.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page37.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page37.fcode = defalut;
      print(recogkey_data.page37.fcode);
      expect(recogkey_data.page37.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page37.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page37.qcjc_type;
      print(recogkey_data.page37.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page37.qcjc_type = testData1s;
      print(recogkey_data.page37.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page37.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page37.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page37.qcjc_type = testData2s;
      print(recogkey_data.page37.qcjc_type);
      expect(recogkey_data.page37.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page37.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page37.qcjc_type = defalut;
      print(recogkey_data.page37.qcjc_type);
      expect(recogkey_data.page37.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page37.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page38.password;
      print(recogkey_data.page38.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page38.password = testData1s;
      print(recogkey_data.page38.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page38.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page38.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page38.password = testData2s;
      print(recogkey_data.page38.password);
      expect(recogkey_data.page38.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page38.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page38.password = defalut;
      print(recogkey_data.page38.password);
      expect(recogkey_data.page38.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page38.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page38.fcode;
      print(recogkey_data.page38.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page38.fcode = testData1s;
      print(recogkey_data.page38.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page38.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page38.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page38.fcode = testData2s;
      print(recogkey_data.page38.fcode);
      expect(recogkey_data.page38.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page38.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page38.fcode = defalut;
      print(recogkey_data.page38.fcode);
      expect(recogkey_data.page38.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page38.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page38.qcjc_type;
      print(recogkey_data.page38.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page38.qcjc_type = testData1s;
      print(recogkey_data.page38.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page38.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page38.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page38.qcjc_type = testData2s;
      print(recogkey_data.page38.qcjc_type);
      expect(recogkey_data.page38.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page38.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page38.qcjc_type = defalut;
      print(recogkey_data.page38.qcjc_type);
      expect(recogkey_data.page38.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page38.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

    test('00138_element_check_00115', () async {
      print("\n********** テスト実行：00138_element_check_00115 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page39.password;
      print(recogkey_data.page39.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page39.password = testData1s;
      print(recogkey_data.page39.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page39.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page39.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page39.password = testData2s;
      print(recogkey_data.page39.password);
      expect(recogkey_data.page39.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page39.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page39.password = defalut;
      print(recogkey_data.page39.password);
      expect(recogkey_data.page39.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page39.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00138_element_check_00115 **********\n\n");
    });

    test('00139_element_check_00116', () async {
      print("\n********** テスト実行：00139_element_check_00116 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page39.fcode;
      print(recogkey_data.page39.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page39.fcode = testData1s;
      print(recogkey_data.page39.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page39.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page39.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page39.fcode = testData2s;
      print(recogkey_data.page39.fcode);
      expect(recogkey_data.page39.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page39.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page39.fcode = defalut;
      print(recogkey_data.page39.fcode);
      expect(recogkey_data.page39.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page39.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00139_element_check_00116 **********\n\n");
    });

    test('00140_element_check_00117', () async {
      print("\n********** テスト実行：00140_element_check_00117 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page39.qcjc_type;
      print(recogkey_data.page39.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page39.qcjc_type = testData1s;
      print(recogkey_data.page39.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page39.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page39.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page39.qcjc_type = testData2s;
      print(recogkey_data.page39.qcjc_type);
      expect(recogkey_data.page39.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page39.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page39.qcjc_type = defalut;
      print(recogkey_data.page39.qcjc_type);
      expect(recogkey_data.page39.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page39.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00140_element_check_00117 **********\n\n");
    });

    test('00141_element_check_00118', () async {
      print("\n********** テスト実行：00141_element_check_00118 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page40.password;
      print(recogkey_data.page40.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page40.password = testData1s;
      print(recogkey_data.page40.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page40.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page40.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page40.password = testData2s;
      print(recogkey_data.page40.password);
      expect(recogkey_data.page40.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page40.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page40.password = defalut;
      print(recogkey_data.page40.password);
      expect(recogkey_data.page40.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page40.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00141_element_check_00118 **********\n\n");
    });

    test('00142_element_check_00119', () async {
      print("\n********** テスト実行：00142_element_check_00119 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page40.fcode;
      print(recogkey_data.page40.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page40.fcode = testData1s;
      print(recogkey_data.page40.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page40.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page40.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page40.fcode = testData2s;
      print(recogkey_data.page40.fcode);
      expect(recogkey_data.page40.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page40.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page40.fcode = defalut;
      print(recogkey_data.page40.fcode);
      expect(recogkey_data.page40.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page40.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00142_element_check_00119 **********\n\n");
    });

    test('00143_element_check_00120', () async {
      print("\n********** テスト実行：00143_element_check_00120 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page40.qcjc_type;
      print(recogkey_data.page40.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page40.qcjc_type = testData1s;
      print(recogkey_data.page40.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page40.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page40.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page40.qcjc_type = testData2s;
      print(recogkey_data.page40.qcjc_type);
      expect(recogkey_data.page40.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page40.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page40.qcjc_type = defalut;
      print(recogkey_data.page40.qcjc_type);
      expect(recogkey_data.page40.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page40.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00143_element_check_00120 **********\n\n");
    });

    test('00144_element_check_00121', () async {
      print("\n********** テスト実行：00144_element_check_00121 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page41.password;
      print(recogkey_data.page41.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page41.password = testData1s;
      print(recogkey_data.page41.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page41.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page41.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page41.password = testData2s;
      print(recogkey_data.page41.password);
      expect(recogkey_data.page41.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page41.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page41.password = defalut;
      print(recogkey_data.page41.password);
      expect(recogkey_data.page41.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page41.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00144_element_check_00121 **********\n\n");
    });

    test('00145_element_check_00122', () async {
      print("\n********** テスト実行：00145_element_check_00122 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page41.fcode;
      print(recogkey_data.page41.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page41.fcode = testData1s;
      print(recogkey_data.page41.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page41.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page41.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page41.fcode = testData2s;
      print(recogkey_data.page41.fcode);
      expect(recogkey_data.page41.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page41.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page41.fcode = defalut;
      print(recogkey_data.page41.fcode);
      expect(recogkey_data.page41.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page41.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00145_element_check_00122 **********\n\n");
    });

    test('00146_element_check_00123', () async {
      print("\n********** テスト実行：00146_element_check_00123 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page41.qcjc_type;
      print(recogkey_data.page41.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page41.qcjc_type = testData1s;
      print(recogkey_data.page41.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page41.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page41.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page41.qcjc_type = testData2s;
      print(recogkey_data.page41.qcjc_type);
      expect(recogkey_data.page41.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page41.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page41.qcjc_type = defalut;
      print(recogkey_data.page41.qcjc_type);
      expect(recogkey_data.page41.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page41.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00146_element_check_00123 **********\n\n");
    });

    test('00147_element_check_00124', () async {
      print("\n********** テスト実行：00147_element_check_00124 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page42.password;
      print(recogkey_data.page42.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page42.password = testData1s;
      print(recogkey_data.page42.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page42.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page42.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page42.password = testData2s;
      print(recogkey_data.page42.password);
      expect(recogkey_data.page42.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page42.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page42.password = defalut;
      print(recogkey_data.page42.password);
      expect(recogkey_data.page42.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page42.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00147_element_check_00124 **********\n\n");
    });

    test('00148_element_check_00125', () async {
      print("\n********** テスト実行：00148_element_check_00125 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page42.fcode;
      print(recogkey_data.page42.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page42.fcode = testData1s;
      print(recogkey_data.page42.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page42.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page42.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page42.fcode = testData2s;
      print(recogkey_data.page42.fcode);
      expect(recogkey_data.page42.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page42.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page42.fcode = defalut;
      print(recogkey_data.page42.fcode);
      expect(recogkey_data.page42.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page42.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00148_element_check_00125 **********\n\n");
    });

    test('00149_element_check_00126', () async {
      print("\n********** テスト実行：00149_element_check_00126 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page42.qcjc_type;
      print(recogkey_data.page42.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page42.qcjc_type = testData1s;
      print(recogkey_data.page42.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page42.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page42.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page42.qcjc_type = testData2s;
      print(recogkey_data.page42.qcjc_type);
      expect(recogkey_data.page42.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page42.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page42.qcjc_type = defalut;
      print(recogkey_data.page42.qcjc_type);
      expect(recogkey_data.page42.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page42.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00149_element_check_00126 **********\n\n");
    });

    test('00150_element_check_00127', () async {
      print("\n********** テスト実行：00150_element_check_00127 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page43.password;
      print(recogkey_data.page43.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page43.password = testData1s;
      print(recogkey_data.page43.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page43.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page43.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page43.password = testData2s;
      print(recogkey_data.page43.password);
      expect(recogkey_data.page43.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page43.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page43.password = defalut;
      print(recogkey_data.page43.password);
      expect(recogkey_data.page43.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page43.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00150_element_check_00127 **********\n\n");
    });

    test('00151_element_check_00128', () async {
      print("\n********** テスト実行：00151_element_check_00128 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page43.fcode;
      print(recogkey_data.page43.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page43.fcode = testData1s;
      print(recogkey_data.page43.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page43.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page43.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page43.fcode = testData2s;
      print(recogkey_data.page43.fcode);
      expect(recogkey_data.page43.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page43.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page43.fcode = defalut;
      print(recogkey_data.page43.fcode);
      expect(recogkey_data.page43.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page43.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00151_element_check_00128 **********\n\n");
    });

    test('00152_element_check_00129', () async {
      print("\n********** テスト実行：00152_element_check_00129 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page43.qcjc_type;
      print(recogkey_data.page43.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page43.qcjc_type = testData1s;
      print(recogkey_data.page43.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page43.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page43.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page43.qcjc_type = testData2s;
      print(recogkey_data.page43.qcjc_type);
      expect(recogkey_data.page43.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page43.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page43.qcjc_type = defalut;
      print(recogkey_data.page43.qcjc_type);
      expect(recogkey_data.page43.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page43.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00152_element_check_00129 **********\n\n");
    });

    test('00153_element_check_00130', () async {
      print("\n********** テスト実行：00153_element_check_00130 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page44.password;
      print(recogkey_data.page44.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page44.password = testData1s;
      print(recogkey_data.page44.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page44.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page44.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page44.password = testData2s;
      print(recogkey_data.page44.password);
      expect(recogkey_data.page44.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page44.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page44.password = defalut;
      print(recogkey_data.page44.password);
      expect(recogkey_data.page44.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page44.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00153_element_check_00130 **********\n\n");
    });

    test('00154_element_check_00131', () async {
      print("\n********** テスト実行：00154_element_check_00131 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page44.fcode;
      print(recogkey_data.page44.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page44.fcode = testData1s;
      print(recogkey_data.page44.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page44.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page44.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page44.fcode = testData2s;
      print(recogkey_data.page44.fcode);
      expect(recogkey_data.page44.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page44.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page44.fcode = defalut;
      print(recogkey_data.page44.fcode);
      expect(recogkey_data.page44.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page44.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00154_element_check_00131 **********\n\n");
    });

    test('00155_element_check_00132', () async {
      print("\n********** テスト実行：00155_element_check_00132 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page44.qcjc_type;
      print(recogkey_data.page44.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page44.qcjc_type = testData1s;
      print(recogkey_data.page44.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page44.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page44.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page44.qcjc_type = testData2s;
      print(recogkey_data.page44.qcjc_type);
      expect(recogkey_data.page44.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page44.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page44.qcjc_type = defalut;
      print(recogkey_data.page44.qcjc_type);
      expect(recogkey_data.page44.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page44.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00155_element_check_00132 **********\n\n");
    });

    test('00156_element_check_00133', () async {
      print("\n********** テスト実行：00156_element_check_00133 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page45.password;
      print(recogkey_data.page45.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page45.password = testData1s;
      print(recogkey_data.page45.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page45.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page45.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page45.password = testData2s;
      print(recogkey_data.page45.password);
      expect(recogkey_data.page45.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page45.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page45.password = defalut;
      print(recogkey_data.page45.password);
      expect(recogkey_data.page45.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page45.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00156_element_check_00133 **********\n\n");
    });

    test('00157_element_check_00134', () async {
      print("\n********** テスト実行：00157_element_check_00134 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page45.fcode;
      print(recogkey_data.page45.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page45.fcode = testData1s;
      print(recogkey_data.page45.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page45.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page45.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page45.fcode = testData2s;
      print(recogkey_data.page45.fcode);
      expect(recogkey_data.page45.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page45.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page45.fcode = defalut;
      print(recogkey_data.page45.fcode);
      expect(recogkey_data.page45.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page45.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00157_element_check_00134 **********\n\n");
    });

    test('00158_element_check_00135', () async {
      print("\n********** テスト実行：00158_element_check_00135 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page45.qcjc_type;
      print(recogkey_data.page45.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page45.qcjc_type = testData1s;
      print(recogkey_data.page45.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page45.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page45.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page45.qcjc_type = testData2s;
      print(recogkey_data.page45.qcjc_type);
      expect(recogkey_data.page45.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page45.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page45.qcjc_type = defalut;
      print(recogkey_data.page45.qcjc_type);
      expect(recogkey_data.page45.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page45.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00158_element_check_00135 **********\n\n");
    });

    test('00159_element_check_00136', () async {
      print("\n********** テスト実行：00159_element_check_00136 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page46.password;
      print(recogkey_data.page46.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page46.password = testData1s;
      print(recogkey_data.page46.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page46.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page46.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page46.password = testData2s;
      print(recogkey_data.page46.password);
      expect(recogkey_data.page46.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page46.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page46.password = defalut;
      print(recogkey_data.page46.password);
      expect(recogkey_data.page46.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page46.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00159_element_check_00136 **********\n\n");
    });

    test('00160_element_check_00137', () async {
      print("\n********** テスト実行：00160_element_check_00137 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page46.fcode;
      print(recogkey_data.page46.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page46.fcode = testData1s;
      print(recogkey_data.page46.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page46.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page46.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page46.fcode = testData2s;
      print(recogkey_data.page46.fcode);
      expect(recogkey_data.page46.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page46.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page46.fcode = defalut;
      print(recogkey_data.page46.fcode);
      expect(recogkey_data.page46.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page46.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00160_element_check_00137 **********\n\n");
    });

    test('00161_element_check_00138', () async {
      print("\n********** テスト実行：00161_element_check_00138 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page46.qcjc_type;
      print(recogkey_data.page46.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page46.qcjc_type = testData1s;
      print(recogkey_data.page46.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page46.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page46.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page46.qcjc_type = testData2s;
      print(recogkey_data.page46.qcjc_type);
      expect(recogkey_data.page46.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page46.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page46.qcjc_type = defalut;
      print(recogkey_data.page46.qcjc_type);
      expect(recogkey_data.page46.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page46.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00161_element_check_00138 **********\n\n");
    });

    test('00162_element_check_00139', () async {
      print("\n********** テスト実行：00162_element_check_00139 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page47.password;
      print(recogkey_data.page47.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page47.password = testData1s;
      print(recogkey_data.page47.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page47.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page47.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page47.password = testData2s;
      print(recogkey_data.page47.password);
      expect(recogkey_data.page47.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page47.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page47.password = defalut;
      print(recogkey_data.page47.password);
      expect(recogkey_data.page47.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page47.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00162_element_check_00139 **********\n\n");
    });

    test('00163_element_check_00140', () async {
      print("\n********** テスト実行：00163_element_check_00140 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page47.fcode;
      print(recogkey_data.page47.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page47.fcode = testData1s;
      print(recogkey_data.page47.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page47.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page47.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page47.fcode = testData2s;
      print(recogkey_data.page47.fcode);
      expect(recogkey_data.page47.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page47.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page47.fcode = defalut;
      print(recogkey_data.page47.fcode);
      expect(recogkey_data.page47.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page47.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00163_element_check_00140 **********\n\n");
    });

    test('00164_element_check_00141', () async {
      print("\n********** テスト実行：00164_element_check_00141 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page47.qcjc_type;
      print(recogkey_data.page47.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page47.qcjc_type = testData1s;
      print(recogkey_data.page47.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page47.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page47.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page47.qcjc_type = testData2s;
      print(recogkey_data.page47.qcjc_type);
      expect(recogkey_data.page47.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page47.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page47.qcjc_type = defalut;
      print(recogkey_data.page47.qcjc_type);
      expect(recogkey_data.page47.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page47.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00164_element_check_00141 **********\n\n");
    });

    test('00165_element_check_00142', () async {
      print("\n********** テスト実行：00165_element_check_00142 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page48.password;
      print(recogkey_data.page48.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page48.password = testData1s;
      print(recogkey_data.page48.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page48.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page48.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page48.password = testData2s;
      print(recogkey_data.page48.password);
      expect(recogkey_data.page48.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page48.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page48.password = defalut;
      print(recogkey_data.page48.password);
      expect(recogkey_data.page48.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page48.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00165_element_check_00142 **********\n\n");
    });

    test('00166_element_check_00143', () async {
      print("\n********** テスト実行：00166_element_check_00143 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page48.fcode;
      print(recogkey_data.page48.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page48.fcode = testData1s;
      print(recogkey_data.page48.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page48.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page48.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page48.fcode = testData2s;
      print(recogkey_data.page48.fcode);
      expect(recogkey_data.page48.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page48.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page48.fcode = defalut;
      print(recogkey_data.page48.fcode);
      expect(recogkey_data.page48.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page48.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00166_element_check_00143 **********\n\n");
    });

    test('00167_element_check_00144', () async {
      print("\n********** テスト実行：00167_element_check_00144 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page48.qcjc_type;
      print(recogkey_data.page48.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page48.qcjc_type = testData1s;
      print(recogkey_data.page48.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page48.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page48.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page48.qcjc_type = testData2s;
      print(recogkey_data.page48.qcjc_type);
      expect(recogkey_data.page48.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page48.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page48.qcjc_type = defalut;
      print(recogkey_data.page48.qcjc_type);
      expect(recogkey_data.page48.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page48.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00167_element_check_00144 **********\n\n");
    });

    test('00168_element_check_00145', () async {
      print("\n********** テスト実行：00168_element_check_00145 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page49.password;
      print(recogkey_data.page49.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page49.password = testData1s;
      print(recogkey_data.page49.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page49.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page49.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page49.password = testData2s;
      print(recogkey_data.page49.password);
      expect(recogkey_data.page49.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page49.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page49.password = defalut;
      print(recogkey_data.page49.password);
      expect(recogkey_data.page49.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page49.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00168_element_check_00145 **********\n\n");
    });

    test('00169_element_check_00146', () async {
      print("\n********** テスト実行：00169_element_check_00146 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page49.fcode;
      print(recogkey_data.page49.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page49.fcode = testData1s;
      print(recogkey_data.page49.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page49.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page49.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page49.fcode = testData2s;
      print(recogkey_data.page49.fcode);
      expect(recogkey_data.page49.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page49.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page49.fcode = defalut;
      print(recogkey_data.page49.fcode);
      expect(recogkey_data.page49.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page49.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00169_element_check_00146 **********\n\n");
    });

    test('00170_element_check_00147', () async {
      print("\n********** テスト実行：00170_element_check_00147 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page49.qcjc_type;
      print(recogkey_data.page49.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page49.qcjc_type = testData1s;
      print(recogkey_data.page49.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page49.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page49.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page49.qcjc_type = testData2s;
      print(recogkey_data.page49.qcjc_type);
      expect(recogkey_data.page49.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page49.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page49.qcjc_type = defalut;
      print(recogkey_data.page49.qcjc_type);
      expect(recogkey_data.page49.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page49.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00170_element_check_00147 **********\n\n");
    });

    test('00171_element_check_00148', () async {
      print("\n********** テスト実行：00171_element_check_00148 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page50.password;
      print(recogkey_data.page50.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page50.password = testData1s;
      print(recogkey_data.page50.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page50.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page50.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page50.password = testData2s;
      print(recogkey_data.page50.password);
      expect(recogkey_data.page50.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page50.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page50.password = defalut;
      print(recogkey_data.page50.password);
      expect(recogkey_data.page50.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page50.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00171_element_check_00148 **********\n\n");
    });

    test('00172_element_check_00149', () async {
      print("\n********** テスト実行：00172_element_check_00149 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page50.fcode;
      print(recogkey_data.page50.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page50.fcode = testData1s;
      print(recogkey_data.page50.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page50.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page50.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page50.fcode = testData2s;
      print(recogkey_data.page50.fcode);
      expect(recogkey_data.page50.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page50.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page50.fcode = defalut;
      print(recogkey_data.page50.fcode);
      expect(recogkey_data.page50.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page50.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00172_element_check_00149 **********\n\n");
    });

    test('00173_element_check_00150', () async {
      print("\n********** テスト実行：00173_element_check_00150 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page50.qcjc_type;
      print(recogkey_data.page50.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page50.qcjc_type = testData1s;
      print(recogkey_data.page50.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page50.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page50.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page50.qcjc_type = testData2s;
      print(recogkey_data.page50.qcjc_type);
      expect(recogkey_data.page50.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page50.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page50.qcjc_type = defalut;
      print(recogkey_data.page50.qcjc_type);
      expect(recogkey_data.page50.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page50.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00173_element_check_00150 **********\n\n");
    });

    test('00174_element_check_00151', () async {
      print("\n********** テスト実行：00174_element_check_00151 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page51.password;
      print(recogkey_data.page51.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page51.password = testData1s;
      print(recogkey_data.page51.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page51.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page51.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page51.password = testData2s;
      print(recogkey_data.page51.password);
      expect(recogkey_data.page51.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page51.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page51.password = defalut;
      print(recogkey_data.page51.password);
      expect(recogkey_data.page51.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page51.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00174_element_check_00151 **********\n\n");
    });

    test('00175_element_check_00152', () async {
      print("\n********** テスト実行：00175_element_check_00152 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page51.fcode;
      print(recogkey_data.page51.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page51.fcode = testData1s;
      print(recogkey_data.page51.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page51.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page51.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page51.fcode = testData2s;
      print(recogkey_data.page51.fcode);
      expect(recogkey_data.page51.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page51.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page51.fcode = defalut;
      print(recogkey_data.page51.fcode);
      expect(recogkey_data.page51.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page51.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00175_element_check_00152 **********\n\n");
    });

    test('00176_element_check_00153', () async {
      print("\n********** テスト実行：00176_element_check_00153 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page51.qcjc_type;
      print(recogkey_data.page51.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page51.qcjc_type = testData1s;
      print(recogkey_data.page51.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page51.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page51.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page51.qcjc_type = testData2s;
      print(recogkey_data.page51.qcjc_type);
      expect(recogkey_data.page51.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page51.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page51.qcjc_type = defalut;
      print(recogkey_data.page51.qcjc_type);
      expect(recogkey_data.page51.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page51.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00176_element_check_00153 **********\n\n");
    });

    test('00177_element_check_00154', () async {
      print("\n********** テスト実行：00177_element_check_00154 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page52.password;
      print(recogkey_data.page52.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page52.password = testData1s;
      print(recogkey_data.page52.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page52.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page52.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page52.password = testData2s;
      print(recogkey_data.page52.password);
      expect(recogkey_data.page52.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page52.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page52.password = defalut;
      print(recogkey_data.page52.password);
      expect(recogkey_data.page52.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page52.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00177_element_check_00154 **********\n\n");
    });

    test('00178_element_check_00155', () async {
      print("\n********** テスト実行：00178_element_check_00155 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page52.fcode;
      print(recogkey_data.page52.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page52.fcode = testData1s;
      print(recogkey_data.page52.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page52.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page52.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page52.fcode = testData2s;
      print(recogkey_data.page52.fcode);
      expect(recogkey_data.page52.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page52.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page52.fcode = defalut;
      print(recogkey_data.page52.fcode);
      expect(recogkey_data.page52.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page52.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00178_element_check_00155 **********\n\n");
    });

    test('00179_element_check_00156', () async {
      print("\n********** テスト実行：00179_element_check_00156 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page52.qcjc_type;
      print(recogkey_data.page52.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page52.qcjc_type = testData1s;
      print(recogkey_data.page52.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page52.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page52.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page52.qcjc_type = testData2s;
      print(recogkey_data.page52.qcjc_type);
      expect(recogkey_data.page52.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page52.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page52.qcjc_type = defalut;
      print(recogkey_data.page52.qcjc_type);
      expect(recogkey_data.page52.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page52.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00179_element_check_00156 **********\n\n");
    });

    test('00180_element_check_00157', () async {
      print("\n********** テスト実行：00180_element_check_00157 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page53.password;
      print(recogkey_data.page53.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page53.password = testData1s;
      print(recogkey_data.page53.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page53.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page53.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page53.password = testData2s;
      print(recogkey_data.page53.password);
      expect(recogkey_data.page53.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page53.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page53.password = defalut;
      print(recogkey_data.page53.password);
      expect(recogkey_data.page53.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page53.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00180_element_check_00157 **********\n\n");
    });

    test('00181_element_check_00158', () async {
      print("\n********** テスト実行：00181_element_check_00158 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page53.fcode;
      print(recogkey_data.page53.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page53.fcode = testData1s;
      print(recogkey_data.page53.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page53.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page53.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page53.fcode = testData2s;
      print(recogkey_data.page53.fcode);
      expect(recogkey_data.page53.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page53.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page53.fcode = defalut;
      print(recogkey_data.page53.fcode);
      expect(recogkey_data.page53.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page53.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00181_element_check_00158 **********\n\n");
    });

    test('00182_element_check_00159', () async {
      print("\n********** テスト実行：00182_element_check_00159 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page53.qcjc_type;
      print(recogkey_data.page53.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page53.qcjc_type = testData1s;
      print(recogkey_data.page53.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page53.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page53.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page53.qcjc_type = testData2s;
      print(recogkey_data.page53.qcjc_type);
      expect(recogkey_data.page53.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page53.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page53.qcjc_type = defalut;
      print(recogkey_data.page53.qcjc_type);
      expect(recogkey_data.page53.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page53.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00182_element_check_00159 **********\n\n");
    });

    test('00183_element_check_00160', () async {
      print("\n********** テスト実行：00183_element_check_00160 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page54.password;
      print(recogkey_data.page54.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page54.password = testData1s;
      print(recogkey_data.page54.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page54.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page54.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page54.password = testData2s;
      print(recogkey_data.page54.password);
      expect(recogkey_data.page54.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page54.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page54.password = defalut;
      print(recogkey_data.page54.password);
      expect(recogkey_data.page54.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page54.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00183_element_check_00160 **********\n\n");
    });

    test('00184_element_check_00161', () async {
      print("\n********** テスト実行：00184_element_check_00161 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page54.fcode;
      print(recogkey_data.page54.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page54.fcode = testData1s;
      print(recogkey_data.page54.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page54.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page54.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page54.fcode = testData2s;
      print(recogkey_data.page54.fcode);
      expect(recogkey_data.page54.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page54.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page54.fcode = defalut;
      print(recogkey_data.page54.fcode);
      expect(recogkey_data.page54.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page54.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00184_element_check_00161 **********\n\n");
    });

    test('00185_element_check_00162', () async {
      print("\n********** テスト実行：00185_element_check_00162 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page54.qcjc_type;
      print(recogkey_data.page54.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page54.qcjc_type = testData1s;
      print(recogkey_data.page54.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page54.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page54.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page54.qcjc_type = testData2s;
      print(recogkey_data.page54.qcjc_type);
      expect(recogkey_data.page54.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page54.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page54.qcjc_type = defalut;
      print(recogkey_data.page54.qcjc_type);
      expect(recogkey_data.page54.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page54.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00185_element_check_00162 **********\n\n");
    });

    test('00186_element_check_00163', () async {
      print("\n********** テスト実行：00186_element_check_00163 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page55.password;
      print(recogkey_data.page55.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page55.password = testData1s;
      print(recogkey_data.page55.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page55.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page55.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page55.password = testData2s;
      print(recogkey_data.page55.password);
      expect(recogkey_data.page55.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page55.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page55.password = defalut;
      print(recogkey_data.page55.password);
      expect(recogkey_data.page55.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page55.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00186_element_check_00163 **********\n\n");
    });

    test('00187_element_check_00164', () async {
      print("\n********** テスト実行：00187_element_check_00164 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page55.fcode;
      print(recogkey_data.page55.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page55.fcode = testData1s;
      print(recogkey_data.page55.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page55.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page55.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page55.fcode = testData2s;
      print(recogkey_data.page55.fcode);
      expect(recogkey_data.page55.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page55.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page55.fcode = defalut;
      print(recogkey_data.page55.fcode);
      expect(recogkey_data.page55.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page55.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00187_element_check_00164 **********\n\n");
    });

    test('00188_element_check_00165', () async {
      print("\n********** テスト実行：00188_element_check_00165 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page55.qcjc_type;
      print(recogkey_data.page55.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page55.qcjc_type = testData1s;
      print(recogkey_data.page55.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page55.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page55.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page55.qcjc_type = testData2s;
      print(recogkey_data.page55.qcjc_type);
      expect(recogkey_data.page55.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page55.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page55.qcjc_type = defalut;
      print(recogkey_data.page55.qcjc_type);
      expect(recogkey_data.page55.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page55.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00188_element_check_00165 **********\n\n");
    });

    test('00189_element_check_00166', () async {
      print("\n********** テスト実行：00189_element_check_00166 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page56.password;
      print(recogkey_data.page56.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page56.password = testData1s;
      print(recogkey_data.page56.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page56.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page56.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page56.password = testData2s;
      print(recogkey_data.page56.password);
      expect(recogkey_data.page56.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page56.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page56.password = defalut;
      print(recogkey_data.page56.password);
      expect(recogkey_data.page56.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page56.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00189_element_check_00166 **********\n\n");
    });

    test('00190_element_check_00167', () async {
      print("\n********** テスト実行：00190_element_check_00167 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page56.fcode;
      print(recogkey_data.page56.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page56.fcode = testData1s;
      print(recogkey_data.page56.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page56.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page56.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page56.fcode = testData2s;
      print(recogkey_data.page56.fcode);
      expect(recogkey_data.page56.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page56.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page56.fcode = defalut;
      print(recogkey_data.page56.fcode);
      expect(recogkey_data.page56.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page56.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00190_element_check_00167 **********\n\n");
    });

    test('00191_element_check_00168', () async {
      print("\n********** テスト実行：00191_element_check_00168 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page56.qcjc_type;
      print(recogkey_data.page56.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page56.qcjc_type = testData1s;
      print(recogkey_data.page56.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page56.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page56.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page56.qcjc_type = testData2s;
      print(recogkey_data.page56.qcjc_type);
      expect(recogkey_data.page56.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page56.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page56.qcjc_type = defalut;
      print(recogkey_data.page56.qcjc_type);
      expect(recogkey_data.page56.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page56.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00191_element_check_00168 **********\n\n");
    });

    test('00192_element_check_00169', () async {
      print("\n********** テスト実行：00192_element_check_00169 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page57.password;
      print(recogkey_data.page57.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page57.password = testData1s;
      print(recogkey_data.page57.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page57.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page57.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page57.password = testData2s;
      print(recogkey_data.page57.password);
      expect(recogkey_data.page57.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page57.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page57.password = defalut;
      print(recogkey_data.page57.password);
      expect(recogkey_data.page57.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page57.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00192_element_check_00169 **********\n\n");
    });

    test('00193_element_check_00170', () async {
      print("\n********** テスト実行：00193_element_check_00170 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page57.fcode;
      print(recogkey_data.page57.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page57.fcode = testData1s;
      print(recogkey_data.page57.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page57.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page57.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page57.fcode = testData2s;
      print(recogkey_data.page57.fcode);
      expect(recogkey_data.page57.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page57.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page57.fcode = defalut;
      print(recogkey_data.page57.fcode);
      expect(recogkey_data.page57.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page57.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00193_element_check_00170 **********\n\n");
    });

    test('00194_element_check_00171', () async {
      print("\n********** テスト実行：00194_element_check_00171 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page57.qcjc_type;
      print(recogkey_data.page57.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page57.qcjc_type = testData1s;
      print(recogkey_data.page57.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page57.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page57.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page57.qcjc_type = testData2s;
      print(recogkey_data.page57.qcjc_type);
      expect(recogkey_data.page57.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page57.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page57.qcjc_type = defalut;
      print(recogkey_data.page57.qcjc_type);
      expect(recogkey_data.page57.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page57.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00194_element_check_00171 **********\n\n");
    });

    test('00195_element_check_00172', () async {
      print("\n********** テスト実行：00195_element_check_00172 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page58.password;
      print(recogkey_data.page58.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page58.password = testData1s;
      print(recogkey_data.page58.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page58.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page58.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page58.password = testData2s;
      print(recogkey_data.page58.password);
      expect(recogkey_data.page58.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page58.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page58.password = defalut;
      print(recogkey_data.page58.password);
      expect(recogkey_data.page58.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page58.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00195_element_check_00172 **********\n\n");
    });

    test('00196_element_check_00173', () async {
      print("\n********** テスト実行：00196_element_check_00173 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page58.fcode;
      print(recogkey_data.page58.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page58.fcode = testData1s;
      print(recogkey_data.page58.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page58.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page58.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page58.fcode = testData2s;
      print(recogkey_data.page58.fcode);
      expect(recogkey_data.page58.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page58.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page58.fcode = defalut;
      print(recogkey_data.page58.fcode);
      expect(recogkey_data.page58.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page58.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00196_element_check_00173 **********\n\n");
    });

    test('00197_element_check_00174', () async {
      print("\n********** テスト実行：00197_element_check_00174 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page58.qcjc_type;
      print(recogkey_data.page58.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page58.qcjc_type = testData1s;
      print(recogkey_data.page58.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page58.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page58.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page58.qcjc_type = testData2s;
      print(recogkey_data.page58.qcjc_type);
      expect(recogkey_data.page58.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page58.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page58.qcjc_type = defalut;
      print(recogkey_data.page58.qcjc_type);
      expect(recogkey_data.page58.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page58.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00197_element_check_00174 **********\n\n");
    });

    test('00198_element_check_00175', () async {
      print("\n********** テスト実行：00198_element_check_00175 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page59.password;
      print(recogkey_data.page59.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page59.password = testData1s;
      print(recogkey_data.page59.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page59.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page59.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page59.password = testData2s;
      print(recogkey_data.page59.password);
      expect(recogkey_data.page59.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page59.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page59.password = defalut;
      print(recogkey_data.page59.password);
      expect(recogkey_data.page59.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page59.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00198_element_check_00175 **********\n\n");
    });

    test('00199_element_check_00176', () async {
      print("\n********** テスト実行：00199_element_check_00176 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page59.fcode;
      print(recogkey_data.page59.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page59.fcode = testData1s;
      print(recogkey_data.page59.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page59.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page59.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page59.fcode = testData2s;
      print(recogkey_data.page59.fcode);
      expect(recogkey_data.page59.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page59.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page59.fcode = defalut;
      print(recogkey_data.page59.fcode);
      expect(recogkey_data.page59.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page59.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00199_element_check_00176 **********\n\n");
    });

    test('00200_element_check_00177', () async {
      print("\n********** テスト実行：00200_element_check_00177 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page59.qcjc_type;
      print(recogkey_data.page59.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page59.qcjc_type = testData1s;
      print(recogkey_data.page59.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page59.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page59.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page59.qcjc_type = testData2s;
      print(recogkey_data.page59.qcjc_type);
      expect(recogkey_data.page59.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page59.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page59.qcjc_type = defalut;
      print(recogkey_data.page59.qcjc_type);
      expect(recogkey_data.page59.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page59.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00200_element_check_00177 **********\n\n");
    });

    test('00201_element_check_00178', () async {
      print("\n********** テスト実行：00201_element_check_00178 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page60.password;
      print(recogkey_data.page60.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page60.password = testData1s;
      print(recogkey_data.page60.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page60.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page60.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page60.password = testData2s;
      print(recogkey_data.page60.password);
      expect(recogkey_data.page60.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page60.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page60.password = defalut;
      print(recogkey_data.page60.password);
      expect(recogkey_data.page60.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page60.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00201_element_check_00178 **********\n\n");
    });

    test('00202_element_check_00179', () async {
      print("\n********** テスト実行：00202_element_check_00179 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page60.fcode;
      print(recogkey_data.page60.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page60.fcode = testData1s;
      print(recogkey_data.page60.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page60.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page60.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page60.fcode = testData2s;
      print(recogkey_data.page60.fcode);
      expect(recogkey_data.page60.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page60.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page60.fcode = defalut;
      print(recogkey_data.page60.fcode);
      expect(recogkey_data.page60.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page60.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00202_element_check_00179 **********\n\n");
    });

    test('00203_element_check_00180', () async {
      print("\n********** テスト実行：00203_element_check_00180 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page60.qcjc_type;
      print(recogkey_data.page60.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page60.qcjc_type = testData1s;
      print(recogkey_data.page60.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page60.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page60.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page60.qcjc_type = testData2s;
      print(recogkey_data.page60.qcjc_type);
      expect(recogkey_data.page60.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page60.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page60.qcjc_type = defalut;
      print(recogkey_data.page60.qcjc_type);
      expect(recogkey_data.page60.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page60.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00203_element_check_00180 **********\n\n");
    });

    test('00204_element_check_00181', () async {
      print("\n********** テスト実行：00204_element_check_00181 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page61.password;
      print(recogkey_data.page61.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page61.password = testData1s;
      print(recogkey_data.page61.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page61.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page61.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page61.password = testData2s;
      print(recogkey_data.page61.password);
      expect(recogkey_data.page61.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page61.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page61.password = defalut;
      print(recogkey_data.page61.password);
      expect(recogkey_data.page61.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page61.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00204_element_check_00181 **********\n\n");
    });

    test('00205_element_check_00182', () async {
      print("\n********** テスト実行：00205_element_check_00182 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page61.fcode;
      print(recogkey_data.page61.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page61.fcode = testData1s;
      print(recogkey_data.page61.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page61.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page61.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page61.fcode = testData2s;
      print(recogkey_data.page61.fcode);
      expect(recogkey_data.page61.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page61.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page61.fcode = defalut;
      print(recogkey_data.page61.fcode);
      expect(recogkey_data.page61.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page61.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00205_element_check_00182 **********\n\n");
    });

    test('00206_element_check_00183', () async {
      print("\n********** テスト実行：00206_element_check_00183 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page61.qcjc_type;
      print(recogkey_data.page61.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page61.qcjc_type = testData1s;
      print(recogkey_data.page61.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page61.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page61.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page61.qcjc_type = testData2s;
      print(recogkey_data.page61.qcjc_type);
      expect(recogkey_data.page61.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page61.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page61.qcjc_type = defalut;
      print(recogkey_data.page61.qcjc_type);
      expect(recogkey_data.page61.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page61.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00206_element_check_00183 **********\n\n");
    });

    test('00207_element_check_00184', () async {
      print("\n********** テスト実行：00207_element_check_00184 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page62.password;
      print(recogkey_data.page62.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page62.password = testData1s;
      print(recogkey_data.page62.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page62.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page62.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page62.password = testData2s;
      print(recogkey_data.page62.password);
      expect(recogkey_data.page62.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page62.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page62.password = defalut;
      print(recogkey_data.page62.password);
      expect(recogkey_data.page62.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page62.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00207_element_check_00184 **********\n\n");
    });

    test('00208_element_check_00185', () async {
      print("\n********** テスト実行：00208_element_check_00185 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page62.fcode;
      print(recogkey_data.page62.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page62.fcode = testData1s;
      print(recogkey_data.page62.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page62.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page62.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page62.fcode = testData2s;
      print(recogkey_data.page62.fcode);
      expect(recogkey_data.page62.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page62.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page62.fcode = defalut;
      print(recogkey_data.page62.fcode);
      expect(recogkey_data.page62.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page62.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00208_element_check_00185 **********\n\n");
    });

    test('00209_element_check_00186', () async {
      print("\n********** テスト実行：00209_element_check_00186 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page62.qcjc_type;
      print(recogkey_data.page62.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page62.qcjc_type = testData1s;
      print(recogkey_data.page62.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page62.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page62.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page62.qcjc_type = testData2s;
      print(recogkey_data.page62.qcjc_type);
      expect(recogkey_data.page62.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page62.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page62.qcjc_type = defalut;
      print(recogkey_data.page62.qcjc_type);
      expect(recogkey_data.page62.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page62.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00209_element_check_00186 **********\n\n");
    });

    test('00210_element_check_00187', () async {
      print("\n********** テスト実行：00210_element_check_00187 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page63.password;
      print(recogkey_data.page63.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page63.password = testData1s;
      print(recogkey_data.page63.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page63.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page63.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page63.password = testData2s;
      print(recogkey_data.page63.password);
      expect(recogkey_data.page63.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page63.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page63.password = defalut;
      print(recogkey_data.page63.password);
      expect(recogkey_data.page63.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page63.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00210_element_check_00187 **********\n\n");
    });

    test('00211_element_check_00188', () async {
      print("\n********** テスト実行：00211_element_check_00188 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page63.fcode;
      print(recogkey_data.page63.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page63.fcode = testData1s;
      print(recogkey_data.page63.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page63.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page63.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page63.fcode = testData2s;
      print(recogkey_data.page63.fcode);
      expect(recogkey_data.page63.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page63.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page63.fcode = defalut;
      print(recogkey_data.page63.fcode);
      expect(recogkey_data.page63.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page63.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00211_element_check_00188 **********\n\n");
    });

    test('00212_element_check_00189', () async {
      print("\n********** テスト実行：00212_element_check_00189 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page63.qcjc_type;
      print(recogkey_data.page63.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page63.qcjc_type = testData1s;
      print(recogkey_data.page63.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page63.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page63.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page63.qcjc_type = testData2s;
      print(recogkey_data.page63.qcjc_type);
      expect(recogkey_data.page63.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page63.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page63.qcjc_type = defalut;
      print(recogkey_data.page63.qcjc_type);
      expect(recogkey_data.page63.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page63.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00212_element_check_00189 **********\n\n");
    });

    test('00213_element_check_00190', () async {
      print("\n********** テスト実行：00213_element_check_00190 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page64.password;
      print(recogkey_data.page64.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page64.password = testData1s;
      print(recogkey_data.page64.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page64.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page64.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page64.password = testData2s;
      print(recogkey_data.page64.password);
      expect(recogkey_data.page64.password == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page64.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page64.password = defalut;
      print(recogkey_data.page64.password);
      expect(recogkey_data.page64.password == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page64.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00213_element_check_00190 **********\n\n");
    });

    test('00214_element_check_00191', () async {
      print("\n********** テスト実行：00214_element_check_00191 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page64.fcode;
      print(recogkey_data.page64.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page64.fcode = testData1s;
      print(recogkey_data.page64.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page64.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page64.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page64.fcode = testData2s;
      print(recogkey_data.page64.fcode);
      expect(recogkey_data.page64.fcode == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page64.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page64.fcode = defalut;
      print(recogkey_data.page64.fcode);
      expect(recogkey_data.page64.fcode == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page64.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00214_element_check_00191 **********\n\n");
    });

    test('00215_element_check_00192', () async {
      print("\n********** テスト実行：00215_element_check_00192 **********");

      recogkey_data = Recogkey_dataJsonFile();
      allPropatyCheckInit(recogkey_data);

      // ①loadを実行する。
      await recogkey_data.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_data.page64.qcjc_type;
      print(recogkey_data.page64.qcjc_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_data.page64.qcjc_type = testData1s;
      print(recogkey_data.page64.qcjc_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_data.page64.qcjc_type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_data.save();
      await recogkey_data.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_data.page64.qcjc_type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_data.page64.qcjc_type = testData2s;
      print(recogkey_data.page64.qcjc_type);
      expect(recogkey_data.page64.qcjc_type == testData2s, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page64.qcjc_type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_data.page64.qcjc_type = defalut;
      print(recogkey_data.page64.qcjc_type);
      expect(recogkey_data.page64.qcjc_type == defalut, true);
      await recogkey_data.save();
      await recogkey_data.load();
      expect(recogkey_data.page64.qcjc_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_data, true);

      print("********** テスト終了：00215_element_check_00192 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Recogkey_dataJsonFile test)
{
  expect(test.page1.password, "");
  expect(test.page1.fcode, "");
  expect(test.page1.qcjc_type, "");
  expect(test.page2.password, "");
  expect(test.page2.fcode, "");
  expect(test.page2.qcjc_type, "");
  expect(test.page3.password, "");
  expect(test.page3.fcode, "");
  expect(test.page3.qcjc_type, "");
  expect(test.page4.password, "");
  expect(test.page4.fcode, "");
  expect(test.page4.qcjc_type, "");
  expect(test.page5.password, "");
  expect(test.page5.fcode, "");
  expect(test.page5.qcjc_type, "");
  expect(test.page6.password, "");
  expect(test.page6.fcode, "");
  expect(test.page6.qcjc_type, "");
  expect(test.page7.password, "");
  expect(test.page7.fcode, "");
  expect(test.page7.qcjc_type, "");
  expect(test.page8.password, "");
  expect(test.page8.fcode, "");
  expect(test.page8.qcjc_type, "");
  expect(test.page9.password, "");
  expect(test.page9.fcode, "");
  expect(test.page9.qcjc_type, "");
  expect(test.page10.password, "");
  expect(test.page10.fcode, "");
  expect(test.page10.qcjc_type, "");
  expect(test.page11.password, "");
  expect(test.page11.fcode, "");
  expect(test.page11.qcjc_type, "");
  expect(test.page12.password, "");
  expect(test.page12.fcode, "");
  expect(test.page12.qcjc_type, "");
  expect(test.page13.password, "");
  expect(test.page13.fcode, "");
  expect(test.page13.qcjc_type, "");
  expect(test.page14.password, "");
  expect(test.page14.fcode, "");
  expect(test.page14.qcjc_type, "");
  expect(test.page15.password, "");
  expect(test.page15.fcode, "");
  expect(test.page15.qcjc_type, "");
  expect(test.page16.password, "");
  expect(test.page16.fcode, "");
  expect(test.page16.qcjc_type, "");
  expect(test.page17.password, "");
  expect(test.page17.fcode, "");
  expect(test.page17.qcjc_type, "");
  expect(test.page18.password, "");
  expect(test.page18.fcode, "");
  expect(test.page18.qcjc_type, "");
  expect(test.page19.password, "");
  expect(test.page19.fcode, "");
  expect(test.page19.qcjc_type, "");
  expect(test.page20.password, "");
  expect(test.page20.fcode, "");
  expect(test.page20.qcjc_type, "");
  expect(test.page21.password, "");
  expect(test.page21.fcode, "");
  expect(test.page21.qcjc_type, "");
  expect(test.page22.password, "");
  expect(test.page22.fcode, "");
  expect(test.page22.qcjc_type, "");
  expect(test.page23.password, "");
  expect(test.page23.fcode, "");
  expect(test.page23.qcjc_type, "");
  expect(test.page24.password, "");
  expect(test.page24.fcode, "");
  expect(test.page24.qcjc_type, "");
  expect(test.page25.password, "");
  expect(test.page25.fcode, "");
  expect(test.page25.qcjc_type, "");
  expect(test.page26.password, "");
  expect(test.page26.fcode, "");
  expect(test.page26.qcjc_type, "");
  expect(test.page27.password, "");
  expect(test.page27.fcode, "");
  expect(test.page27.qcjc_type, "");
  expect(test.page28.password, "");
  expect(test.page28.fcode, "");
  expect(test.page28.qcjc_type, "");
  expect(test.page29.password, "");
  expect(test.page29.fcode, "");
  expect(test.page29.qcjc_type, "");
  expect(test.page30.password, "");
  expect(test.page30.fcode, "");
  expect(test.page30.qcjc_type, "");
  expect(test.page31.password, "");
  expect(test.page31.fcode, "");
  expect(test.page31.qcjc_type, "");
  expect(test.page32.password, "");
  expect(test.page32.fcode, "");
  expect(test.page32.qcjc_type, "");
  expect(test.page33.password, "");
  expect(test.page33.fcode, "");
  expect(test.page33.qcjc_type, "");
  expect(test.page34.password, "");
  expect(test.page34.fcode, "");
  expect(test.page34.qcjc_type, "");
  expect(test.page35.password, "");
  expect(test.page35.fcode, "");
  expect(test.page35.qcjc_type, "");
  expect(test.page36.password, "");
  expect(test.page36.fcode, "");
  expect(test.page36.qcjc_type, "");
  expect(test.page37.password, "");
  expect(test.page37.fcode, "");
  expect(test.page37.qcjc_type, "");
  expect(test.page38.password, "");
  expect(test.page38.fcode, "");
  expect(test.page38.qcjc_type, "");
  expect(test.page39.password, "");
  expect(test.page39.fcode, "");
  expect(test.page39.qcjc_type, "");
  expect(test.page40.password, "");
  expect(test.page40.fcode, "");
  expect(test.page40.qcjc_type, "");
  expect(test.page41.password, "");
  expect(test.page41.fcode, "");
  expect(test.page41.qcjc_type, "");
  expect(test.page42.password, "");
  expect(test.page42.fcode, "");
  expect(test.page42.qcjc_type, "");
  expect(test.page43.password, "");
  expect(test.page43.fcode, "");
  expect(test.page43.qcjc_type, "");
  expect(test.page44.password, "");
  expect(test.page44.fcode, "");
  expect(test.page44.qcjc_type, "");
  expect(test.page45.password, "");
  expect(test.page45.fcode, "");
  expect(test.page45.qcjc_type, "");
  expect(test.page46.password, "");
  expect(test.page46.fcode, "");
  expect(test.page46.qcjc_type, "");
  expect(test.page47.password, "");
  expect(test.page47.fcode, "");
  expect(test.page47.qcjc_type, "");
  expect(test.page48.password, "");
  expect(test.page48.fcode, "");
  expect(test.page48.qcjc_type, "");
  expect(test.page49.password, "");
  expect(test.page49.fcode, "");
  expect(test.page49.qcjc_type, "");
  expect(test.page50.password, "");
  expect(test.page50.fcode, "");
  expect(test.page50.qcjc_type, "");
  expect(test.page51.password, "");
  expect(test.page51.fcode, "");
  expect(test.page51.qcjc_type, "");
  expect(test.page52.password, "");
  expect(test.page52.fcode, "");
  expect(test.page52.qcjc_type, "");
  expect(test.page53.password, "");
  expect(test.page53.fcode, "");
  expect(test.page53.qcjc_type, "");
  expect(test.page54.password, "");
  expect(test.page54.fcode, "");
  expect(test.page54.qcjc_type, "");
  expect(test.page55.password, "");
  expect(test.page55.fcode, "");
  expect(test.page55.qcjc_type, "");
  expect(test.page56.password, "");
  expect(test.page56.fcode, "");
  expect(test.page56.qcjc_type, "");
  expect(test.page57.password, "");
  expect(test.page57.fcode, "");
  expect(test.page57.qcjc_type, "");
  expect(test.page58.password, "");
  expect(test.page58.fcode, "");
  expect(test.page58.qcjc_type, "");
  expect(test.page59.password, "");
  expect(test.page59.fcode, "");
  expect(test.page59.qcjc_type, "");
  expect(test.page60.password, "");
  expect(test.page60.fcode, "");
  expect(test.page60.qcjc_type, "");
  expect(test.page61.password, "");
  expect(test.page61.fcode, "");
  expect(test.page61.qcjc_type, "");
  expect(test.page62.password, "");
  expect(test.page62.fcode, "");
  expect(test.page62.qcjc_type, "");
  expect(test.page63.password, "");
  expect(test.page63.fcode, "");
  expect(test.page63.qcjc_type, "");
  expect(test.page64.password, "");
  expect(test.page64.fcode, "");
  expect(test.page64.qcjc_type, "");
}

void allPropatyCheck(Recogkey_dataJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.page1.password, "");
  }
  expect(test.page1.fcode, "");
  expect(test.page1.qcjc_type, "000000000000000000");
  expect(test.page2.password, "");
  expect(test.page2.fcode, "");
  expect(test.page2.qcjc_type, "000000000000000000");
  expect(test.page3.password, "");
  expect(test.page3.fcode, "");
  expect(test.page3.qcjc_type, "000000000000000000");
  expect(test.page4.password, "");
  expect(test.page4.fcode, "");
  expect(test.page4.qcjc_type, "000000000000000000");
  expect(test.page5.password, "");
  expect(test.page5.fcode, "");
  expect(test.page5.qcjc_type, "000000000000000000");
  expect(test.page6.password, "");
  expect(test.page6.fcode, "");
  expect(test.page6.qcjc_type, "000000000012000000");
  expect(test.page7.password, "");
  expect(test.page7.fcode, "");
  expect(test.page7.qcjc_type, "000000000000000000");
  expect(test.page8.password, "");
  expect(test.page8.fcode, "");
  expect(test.page8.qcjc_type, "000000000000000000");
  expect(test.page9.password, "");
  expect(test.page9.fcode, "");
  expect(test.page9.qcjc_type, "000000000000000000");
  expect(test.page10.password, "");
  expect(test.page10.fcode, "");
  expect(test.page10.qcjc_type, "000000000000000000");
  expect(test.page11.password, "");
  expect(test.page11.fcode, "");
  expect(test.page11.qcjc_type, "000000000000000000");
  expect(test.page12.password, "");
  expect(test.page12.fcode, "");
  expect(test.page12.qcjc_type, "000000000000000000");
  expect(test.page13.password, "");
  expect(test.page13.fcode, "");
  expect(test.page13.qcjc_type, "000000000000000000");
  expect(test.page14.password, "");
  expect(test.page14.fcode, "");
  expect(test.page14.qcjc_type, "000000000000000000");
  expect(test.page15.password, "");
  expect(test.page15.fcode, "");
  expect(test.page15.qcjc_type, "000000000000000000");
  expect(test.page16.password, "");
  expect(test.page16.fcode, "");
  expect(test.page16.qcjc_type, "000000000000000000");
  expect(test.page17.password, "");
  expect(test.page17.fcode, "");
  expect(test.page17.qcjc_type, "000000000000000000");
  expect(test.page18.password, "");
  expect(test.page18.fcode, "");
  expect(test.page18.qcjc_type, "000000000000000000");
  expect(test.page19.password, "");
  expect(test.page19.fcode, "");
  expect(test.page19.qcjc_type, "000000000000000000");
  expect(test.page20.password, "");
  expect(test.page20.fcode, "");
  expect(test.page20.qcjc_type, "000000000000000000");
  expect(test.page21.password, "");
  expect(test.page21.fcode, "");
  expect(test.page21.qcjc_type, "000000000000000000");
  expect(test.page22.password, "");
  expect(test.page22.fcode, "");
  expect(test.page22.qcjc_type, "000000000000000000");
  expect(test.page23.password, "");
  expect(test.page23.fcode, "");
  expect(test.page23.qcjc_type, "000000000000000000");
  expect(test.page24.password, "");
  expect(test.page24.fcode, "");
  expect(test.page24.qcjc_type, "000000000000000000");
  expect(test.page25.password, "");
  expect(test.page25.fcode, "");
  expect(test.page25.qcjc_type, "000000000000000000");
  expect(test.page26.password, "");
  expect(test.page26.fcode, "");
  expect(test.page26.qcjc_type, "000000000000000000");
  expect(test.page27.password, "");
  expect(test.page27.fcode, "");
  expect(test.page27.qcjc_type, "000000000000000000");
  expect(test.page28.password, "");
  expect(test.page28.fcode, "");
  expect(test.page28.qcjc_type, "000000000000000000");
  expect(test.page29.password, "");
  expect(test.page29.fcode, "");
  expect(test.page29.qcjc_type, "000000000000000000");
  expect(test.page30.password, "");
  expect(test.page30.fcode, "");
  expect(test.page30.qcjc_type, "000000000000000000");
  expect(test.page31.password, "");
  expect(test.page31.fcode, "");
  expect(test.page31.qcjc_type, "000000000000000000");
  expect(test.page32.password, "");
  expect(test.page32.fcode, "");
  expect(test.page32.qcjc_type, "000000000000000000");
  expect(test.page33.password, "");
  expect(test.page33.fcode, "");
  expect(test.page33.qcjc_type, "000000000000000000");
  expect(test.page34.password, "");
  expect(test.page34.fcode, "");
  expect(test.page34.qcjc_type, "000000000000000000");
  expect(test.page35.password, "");
  expect(test.page35.fcode, "");
  expect(test.page35.qcjc_type, "000000000000000000");
  expect(test.page36.password, "");
  expect(test.page36.fcode, "");
  expect(test.page36.qcjc_type, "000000000000000000");
  expect(test.page37.password, "");
  expect(test.page37.fcode, "");
  expect(test.page37.qcjc_type, "000000000000000000");
  expect(test.page38.password, "");
  expect(test.page38.fcode, "");
  expect(test.page38.qcjc_type, "000000000000000000");
  expect(test.page39.password, "");
  expect(test.page39.fcode, "");
  expect(test.page39.qcjc_type, "000000000000000000");
  expect(test.page40.password, "");
  expect(test.page40.fcode, "");
  expect(test.page40.qcjc_type, "000000000000000000");
  expect(test.page41.password, "");
  expect(test.page41.fcode, "");
  expect(test.page41.qcjc_type, "000000000000000000");
  expect(test.page42.password, "");
  expect(test.page42.fcode, "");
  expect(test.page42.qcjc_type, "000000000000000000");
  expect(test.page43.password, "");
  expect(test.page43.fcode, "");
  expect(test.page43.qcjc_type, "000000000000000000");
  expect(test.page44.password, "");
  expect(test.page44.fcode, "");
  expect(test.page44.qcjc_type, "000000000000000000");
  expect(test.page45.password, "");
  expect(test.page45.fcode, "");
  expect(test.page45.qcjc_type, "000000000000000000");
  expect(test.page46.password, "");
  expect(test.page46.fcode, "");
  expect(test.page46.qcjc_type, "000000000000000000");
  expect(test.page47.password, "");
  expect(test.page47.fcode, "");
  expect(test.page47.qcjc_type, "000000000000000000");
  expect(test.page48.password, "");
  expect(test.page48.fcode, "");
  expect(test.page48.qcjc_type, "000000000000000000");
  expect(test.page49.password, "");
  expect(test.page49.fcode, "");
  expect(test.page49.qcjc_type, "000000000000000000");
  expect(test.page50.password, "");
  expect(test.page50.fcode, "");
  expect(test.page50.qcjc_type, "000000000000000000");
  expect(test.page51.password, "");
  expect(test.page51.fcode, "");
  expect(test.page51.qcjc_type, "000000000000000000");
  expect(test.page52.password, "");
  expect(test.page52.fcode, "");
  expect(test.page52.qcjc_type, "000000000000000000");
  expect(test.page53.password, "");
  expect(test.page53.fcode, "");
  expect(test.page53.qcjc_type, "000000000000000000");
  expect(test.page54.password, "");
  expect(test.page54.fcode, "");
  expect(test.page54.qcjc_type, "000000000000000000");
  expect(test.page55.password, "");
  expect(test.page55.fcode, "");
  expect(test.page55.qcjc_type, "000000000000000000");
  expect(test.page56.password, "");
  expect(test.page56.fcode, "");
  expect(test.page56.qcjc_type, "000000000000000000");
  expect(test.page57.password, "");
  expect(test.page57.fcode, "");
  expect(test.page57.qcjc_type, "000000000000000000");
  expect(test.page58.password, "");
  expect(test.page58.fcode, "");
  expect(test.page58.qcjc_type, "000000000000000000");
  expect(test.page59.password, "");
  expect(test.page59.fcode, "");
  expect(test.page59.qcjc_type, "000000000000000000");
  expect(test.page60.password, "");
  expect(test.page60.fcode, "");
  expect(test.page60.qcjc_type, "000000000000000000");
  expect(test.page61.password, "");
  expect(test.page61.fcode, "");
  expect(test.page61.qcjc_type, "000000000000000000");
  expect(test.page62.password, "");
  expect(test.page62.fcode, "");
  expect(test.page62.qcjc_type, "000000000000000000");
  expect(test.page63.password, "");
  expect(test.page63.fcode, "");
  expect(test.page63.qcjc_type, "000000000000000000");
  expect(test.page64.password, "");
  expect(test.page64.fcode, "");
  expect(test.page64.qcjc_type, "000000000000000000");
}

