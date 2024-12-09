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
import '../../../../lib/app/common/cls_conf/data_restor2JsonFile.dart';

late Data_restor2JsonFile data_restor2;

void main(){
  data_restor2JsonFile_test();
}

void data_restor2JsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "data_restor2.json";
  const String section = "file01";
  const String key = "typ";
  const defaultData = 40;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Data_restor2JsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Data_restor2JsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Data_restor2JsonFile().setDefault();
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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await data_restor2.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(data_restor2,true);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        data_restor2.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await data_restor2.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(data_restor2,true);

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
      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①：loadを実行する。
      await data_restor2.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = data_restor2.file01.typ;
      data_restor2.file01.typ = testData1;
      expect(data_restor2.file01.typ == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await data_restor2.load();
      expect(data_restor2.file01.typ != testData1, true);
      expect(data_restor2.file01.typ == prefixData, true);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = data_restor2.file01.typ;
      data_restor2.file01.typ = testData1;
      expect(data_restor2.file01.typ, testData1);

      // ③saveを実行する。
      await data_restor2.save();

      // ④loadを実行する。
      await data_restor2.load();

      expect(data_restor2.file01.typ != prefixData, true);
      expect(data_restor2.file01.typ == testData1, true);
      allPropatyCheck(data_restor2,false);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await data_restor2.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await data_restor2.save();

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await data_restor2.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(data_restor2.file01.typ, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = data_restor2.file01.typ;
      data_restor2.file01.typ = testData1;

      // ③ saveを実行する。
      await data_restor2.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(data_restor2.file01.typ, testData1);

      // ④ loadを実行する。
      await data_restor2.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(data_restor2.file01.typ == testData1, true);
      allPropatyCheck(data_restor2,false);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await data_restor2.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(data_restor2,true);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②任意のプロパティの値を変更する。
      data_restor2.file01.typ = testData1;
      expect(data_restor2.file01.typ, testData1);

      // ③saveを実行する。
      await data_restor2.save();
      expect(data_restor2.file01.typ, testData1);

      // ④loadを実行する。
      await data_restor2.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(data_restor2,true);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await data_restor2.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await data_restor2.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(data_restor2.file01.typ == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await data_restor2.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await data_restor2.setValueWithName(section, "test_key", testData1);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②任意のプロパティを変更する。
      data_restor2.file01.typ = testData1;

      // ③saveを実行する。
      await data_restor2.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await data_restor2.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②任意のプロパティを変更する。
      data_restor2.file01.typ = testData1;

      // ③saveを実行する。
      await data_restor2.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await data_restor2.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②任意のプロパティを変更する。
      data_restor2.file01.typ = testData1;

      // ③saveを実行する。
      await data_restor2.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await data_restor2.getValueWithName(section, "test_key");
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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await data_restor2.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      data_restor2.file01.typ = testData1;
      expect(data_restor2.file01.typ, testData1);

      // ④saveを実行する。
      await data_restor2.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(data_restor2.file01.typ, testData1);
      
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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await data_restor2.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + data_restor2.file01.typ.toString());
      expect(data_restor2.file01.typ == testData1, true);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await data_restor2.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + data_restor2.file01.typ.toString());
      expect(data_restor2.file01.typ == testData2, true);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await data_restor2.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + data_restor2.file01.typ.toString());
      expect(data_restor2.file01.typ == testData1, true);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await data_restor2.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + data_restor2.file01.typ.toString());
      expect(data_restor2.file01.typ == testData2, true);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await data_restor2.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + data_restor2.file01.typ.toString());
      expect(data_restor2.file01.typ == testData1, true);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await data_restor2.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + data_restor2.file01.typ.toString());
      expect(data_restor2.file01.typ == testData1, true);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await data_restor2.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + data_restor2.file01.typ.toString());
      allPropatyCheck(data_restor2,true);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await data_restor2.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + data_restor2.file01.typ.toString());
      allPropatyCheck(data_restor2,true);

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

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file01.typ;
      print(data_restor2.file01.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file01.typ = testData1;
      print(data_restor2.file01.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file01.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file01.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file01.typ = testData2;
      print(data_restor2.file01.typ);
      expect(data_restor2.file01.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file01.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file01.typ = defalut;
      print(data_restor2.file01.typ);
      expect(data_restor2.file01.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file01.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file01.name;
      print(data_restor2.file01.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file01.name = testData1s;
      print(data_restor2.file01.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file01.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file01.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file01.name = testData2s;
      print(data_restor2.file01.name);
      expect(data_restor2.file01.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file01.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file01.name = defalut;
      print(data_restor2.file01.name);
      expect(data_restor2.file01.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file01.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file01.src;
      print(data_restor2.file01.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file01.src = testData1s;
      print(data_restor2.file01.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file01.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file01.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file01.src = testData2s;
      print(data_restor2.file01.src);
      expect(data_restor2.file01.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file01.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file01.src = defalut;
      print(data_restor2.file01.src);
      expect(data_restor2.file01.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file01.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file02.typ;
      print(data_restor2.file02.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file02.typ = testData1;
      print(data_restor2.file02.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file02.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file02.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file02.typ = testData2;
      print(data_restor2.file02.typ);
      expect(data_restor2.file02.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file02.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file02.typ = defalut;
      print(data_restor2.file02.typ);
      expect(data_restor2.file02.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file02.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file02.name;
      print(data_restor2.file02.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file02.name = testData1s;
      print(data_restor2.file02.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file02.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file02.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file02.name = testData2s;
      print(data_restor2.file02.name);
      expect(data_restor2.file02.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file02.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file02.name = defalut;
      print(data_restor2.file02.name);
      expect(data_restor2.file02.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file02.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file02.src;
      print(data_restor2.file02.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file02.src = testData1s;
      print(data_restor2.file02.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file02.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file02.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file02.src = testData2s;
      print(data_restor2.file02.src);
      expect(data_restor2.file02.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file02.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file02.src = defalut;
      print(data_restor2.file02.src);
      expect(data_restor2.file02.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file02.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file03.typ;
      print(data_restor2.file03.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file03.typ = testData1;
      print(data_restor2.file03.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file03.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file03.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file03.typ = testData2;
      print(data_restor2.file03.typ);
      expect(data_restor2.file03.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file03.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file03.typ = defalut;
      print(data_restor2.file03.typ);
      expect(data_restor2.file03.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file03.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file03.name;
      print(data_restor2.file03.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file03.name = testData1s;
      print(data_restor2.file03.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file03.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file03.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file03.name = testData2s;
      print(data_restor2.file03.name);
      expect(data_restor2.file03.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file03.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file03.name = defalut;
      print(data_restor2.file03.name);
      expect(data_restor2.file03.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file03.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file03.src;
      print(data_restor2.file03.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file03.src = testData1s;
      print(data_restor2.file03.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file03.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file03.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file03.src = testData2s;
      print(data_restor2.file03.src);
      expect(data_restor2.file03.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file03.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file03.src = defalut;
      print(data_restor2.file03.src);
      expect(data_restor2.file03.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file03.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file04.typ;
      print(data_restor2.file04.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file04.typ = testData1;
      print(data_restor2.file04.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file04.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file04.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file04.typ = testData2;
      print(data_restor2.file04.typ);
      expect(data_restor2.file04.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file04.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file04.typ = defalut;
      print(data_restor2.file04.typ);
      expect(data_restor2.file04.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file04.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file04.name;
      print(data_restor2.file04.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file04.name = testData1s;
      print(data_restor2.file04.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file04.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file04.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file04.name = testData2s;
      print(data_restor2.file04.name);
      expect(data_restor2.file04.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file04.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file04.name = defalut;
      print(data_restor2.file04.name);
      expect(data_restor2.file04.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file04.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file04.src;
      print(data_restor2.file04.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file04.src = testData1s;
      print(data_restor2.file04.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file04.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file04.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file04.src = testData2s;
      print(data_restor2.file04.src);
      expect(data_restor2.file04.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file04.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file04.src = defalut;
      print(data_restor2.file04.src);
      expect(data_restor2.file04.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file04.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file05.typ;
      print(data_restor2.file05.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file05.typ = testData1;
      print(data_restor2.file05.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file05.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file05.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file05.typ = testData2;
      print(data_restor2.file05.typ);
      expect(data_restor2.file05.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file05.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file05.typ = defalut;
      print(data_restor2.file05.typ);
      expect(data_restor2.file05.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file05.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file05.name;
      print(data_restor2.file05.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file05.name = testData1s;
      print(data_restor2.file05.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file05.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file05.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file05.name = testData2s;
      print(data_restor2.file05.name);
      expect(data_restor2.file05.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file05.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file05.name = defalut;
      print(data_restor2.file05.name);
      expect(data_restor2.file05.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file05.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file05.src;
      print(data_restor2.file05.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file05.src = testData1s;
      print(data_restor2.file05.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file05.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file05.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file05.src = testData2s;
      print(data_restor2.file05.src);
      expect(data_restor2.file05.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file05.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file05.src = defalut;
      print(data_restor2.file05.src);
      expect(data_restor2.file05.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file05.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file06.typ;
      print(data_restor2.file06.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file06.typ = testData1;
      print(data_restor2.file06.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file06.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file06.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file06.typ = testData2;
      print(data_restor2.file06.typ);
      expect(data_restor2.file06.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file06.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file06.typ = defalut;
      print(data_restor2.file06.typ);
      expect(data_restor2.file06.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file06.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file06.name;
      print(data_restor2.file06.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file06.name = testData1s;
      print(data_restor2.file06.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file06.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file06.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file06.name = testData2s;
      print(data_restor2.file06.name);
      expect(data_restor2.file06.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file06.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file06.name = defalut;
      print(data_restor2.file06.name);
      expect(data_restor2.file06.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file06.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file06.src;
      print(data_restor2.file06.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file06.src = testData1s;
      print(data_restor2.file06.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file06.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file06.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file06.src = testData2s;
      print(data_restor2.file06.src);
      expect(data_restor2.file06.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file06.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file06.src = defalut;
      print(data_restor2.file06.src);
      expect(data_restor2.file06.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file06.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file07.typ;
      print(data_restor2.file07.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file07.typ = testData1;
      print(data_restor2.file07.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file07.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file07.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file07.typ = testData2;
      print(data_restor2.file07.typ);
      expect(data_restor2.file07.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file07.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file07.typ = defalut;
      print(data_restor2.file07.typ);
      expect(data_restor2.file07.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file07.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file07.name;
      print(data_restor2.file07.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file07.name = testData1s;
      print(data_restor2.file07.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file07.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file07.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file07.name = testData2s;
      print(data_restor2.file07.name);
      expect(data_restor2.file07.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file07.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file07.name = defalut;
      print(data_restor2.file07.name);
      expect(data_restor2.file07.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file07.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file07.src;
      print(data_restor2.file07.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file07.src = testData1s;
      print(data_restor2.file07.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file07.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file07.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file07.src = testData2s;
      print(data_restor2.file07.src);
      expect(data_restor2.file07.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file07.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file07.src = defalut;
      print(data_restor2.file07.src);
      expect(data_restor2.file07.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file07.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file08.typ;
      print(data_restor2.file08.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file08.typ = testData1;
      print(data_restor2.file08.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file08.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file08.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file08.typ = testData2;
      print(data_restor2.file08.typ);
      expect(data_restor2.file08.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file08.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file08.typ = defalut;
      print(data_restor2.file08.typ);
      expect(data_restor2.file08.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file08.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file08.name;
      print(data_restor2.file08.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file08.name = testData1s;
      print(data_restor2.file08.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file08.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file08.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file08.name = testData2s;
      print(data_restor2.file08.name);
      expect(data_restor2.file08.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file08.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file08.name = defalut;
      print(data_restor2.file08.name);
      expect(data_restor2.file08.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file08.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file08.src;
      print(data_restor2.file08.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file08.src = testData1s;
      print(data_restor2.file08.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file08.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file08.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file08.src = testData2s;
      print(data_restor2.file08.src);
      expect(data_restor2.file08.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file08.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file08.src = defalut;
      print(data_restor2.file08.src);
      expect(data_restor2.file08.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file08.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file09.typ;
      print(data_restor2.file09.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file09.typ = testData1;
      print(data_restor2.file09.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file09.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file09.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file09.typ = testData2;
      print(data_restor2.file09.typ);
      expect(data_restor2.file09.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file09.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file09.typ = defalut;
      print(data_restor2.file09.typ);
      expect(data_restor2.file09.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file09.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file09.name;
      print(data_restor2.file09.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file09.name = testData1s;
      print(data_restor2.file09.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file09.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file09.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file09.name = testData2s;
      print(data_restor2.file09.name);
      expect(data_restor2.file09.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file09.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file09.name = defalut;
      print(data_restor2.file09.name);
      expect(data_restor2.file09.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file09.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file09.src;
      print(data_restor2.file09.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file09.src = testData1s;
      print(data_restor2.file09.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file09.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file09.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file09.src = testData2s;
      print(data_restor2.file09.src);
      expect(data_restor2.file09.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file09.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file09.src = defalut;
      print(data_restor2.file09.src);
      expect(data_restor2.file09.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file09.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file10.typ;
      print(data_restor2.file10.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file10.typ = testData1;
      print(data_restor2.file10.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file10.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file10.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file10.typ = testData2;
      print(data_restor2.file10.typ);
      expect(data_restor2.file10.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file10.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file10.typ = defalut;
      print(data_restor2.file10.typ);
      expect(data_restor2.file10.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file10.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file10.name;
      print(data_restor2.file10.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file10.name = testData1s;
      print(data_restor2.file10.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file10.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file10.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file10.name = testData2s;
      print(data_restor2.file10.name);
      expect(data_restor2.file10.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file10.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file10.name = defalut;
      print(data_restor2.file10.name);
      expect(data_restor2.file10.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file10.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file10.src;
      print(data_restor2.file10.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file10.src = testData1s;
      print(data_restor2.file10.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file10.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file10.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file10.src = testData2s;
      print(data_restor2.file10.src);
      expect(data_restor2.file10.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file10.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file10.src = defalut;
      print(data_restor2.file10.src);
      expect(data_restor2.file10.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file10.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file11.typ;
      print(data_restor2.file11.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file11.typ = testData1;
      print(data_restor2.file11.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file11.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file11.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file11.typ = testData2;
      print(data_restor2.file11.typ);
      expect(data_restor2.file11.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file11.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file11.typ = defalut;
      print(data_restor2.file11.typ);
      expect(data_restor2.file11.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file11.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file11.name;
      print(data_restor2.file11.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file11.name = testData1s;
      print(data_restor2.file11.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file11.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file11.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file11.name = testData2s;
      print(data_restor2.file11.name);
      expect(data_restor2.file11.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file11.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file11.name = defalut;
      print(data_restor2.file11.name);
      expect(data_restor2.file11.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file11.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file11.src;
      print(data_restor2.file11.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file11.src = testData1s;
      print(data_restor2.file11.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file11.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file11.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file11.src = testData2s;
      print(data_restor2.file11.src);
      expect(data_restor2.file11.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file11.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file11.src = defalut;
      print(data_restor2.file11.src);
      expect(data_restor2.file11.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file11.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file12.typ;
      print(data_restor2.file12.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file12.typ = testData1;
      print(data_restor2.file12.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file12.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file12.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file12.typ = testData2;
      print(data_restor2.file12.typ);
      expect(data_restor2.file12.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file12.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file12.typ = defalut;
      print(data_restor2.file12.typ);
      expect(data_restor2.file12.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file12.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file12.name;
      print(data_restor2.file12.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file12.name = testData1s;
      print(data_restor2.file12.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file12.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file12.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file12.name = testData2s;
      print(data_restor2.file12.name);
      expect(data_restor2.file12.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file12.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file12.name = defalut;
      print(data_restor2.file12.name);
      expect(data_restor2.file12.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file12.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file12.src;
      print(data_restor2.file12.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file12.src = testData1s;
      print(data_restor2.file12.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file12.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file12.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file12.src = testData2s;
      print(data_restor2.file12.src);
      expect(data_restor2.file12.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file12.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file12.src = defalut;
      print(data_restor2.file12.src);
      expect(data_restor2.file12.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file12.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file13.typ;
      print(data_restor2.file13.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file13.typ = testData1;
      print(data_restor2.file13.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file13.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file13.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file13.typ = testData2;
      print(data_restor2.file13.typ);
      expect(data_restor2.file13.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file13.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file13.typ = defalut;
      print(data_restor2.file13.typ);
      expect(data_restor2.file13.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file13.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file13.name;
      print(data_restor2.file13.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file13.name = testData1s;
      print(data_restor2.file13.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file13.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file13.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file13.name = testData2s;
      print(data_restor2.file13.name);
      expect(data_restor2.file13.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file13.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file13.name = defalut;
      print(data_restor2.file13.name);
      expect(data_restor2.file13.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file13.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file13.src;
      print(data_restor2.file13.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file13.src = testData1s;
      print(data_restor2.file13.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file13.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file13.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file13.src = testData2s;
      print(data_restor2.file13.src);
      expect(data_restor2.file13.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file13.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file13.src = defalut;
      print(data_restor2.file13.src);
      expect(data_restor2.file13.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file13.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file14.typ;
      print(data_restor2.file14.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file14.typ = testData1;
      print(data_restor2.file14.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file14.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file14.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file14.typ = testData2;
      print(data_restor2.file14.typ);
      expect(data_restor2.file14.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file14.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file14.typ = defalut;
      print(data_restor2.file14.typ);
      expect(data_restor2.file14.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file14.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file14.name;
      print(data_restor2.file14.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file14.name = testData1s;
      print(data_restor2.file14.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file14.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file14.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file14.name = testData2s;
      print(data_restor2.file14.name);
      expect(data_restor2.file14.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file14.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file14.name = defalut;
      print(data_restor2.file14.name);
      expect(data_restor2.file14.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file14.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file14.src;
      print(data_restor2.file14.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file14.src = testData1s;
      print(data_restor2.file14.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file14.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file14.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file14.src = testData2s;
      print(data_restor2.file14.src);
      expect(data_restor2.file14.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file14.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file14.src = defalut;
      print(data_restor2.file14.src);
      expect(data_restor2.file14.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file14.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file15.typ;
      print(data_restor2.file15.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file15.typ = testData1;
      print(data_restor2.file15.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file15.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file15.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file15.typ = testData2;
      print(data_restor2.file15.typ);
      expect(data_restor2.file15.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file15.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file15.typ = defalut;
      print(data_restor2.file15.typ);
      expect(data_restor2.file15.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file15.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file15.name;
      print(data_restor2.file15.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file15.name = testData1s;
      print(data_restor2.file15.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file15.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file15.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file15.name = testData2s;
      print(data_restor2.file15.name);
      expect(data_restor2.file15.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file15.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file15.name = defalut;
      print(data_restor2.file15.name);
      expect(data_restor2.file15.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file15.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file15.src;
      print(data_restor2.file15.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file15.src = testData1s;
      print(data_restor2.file15.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file15.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file15.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file15.src = testData2s;
      print(data_restor2.file15.src);
      expect(data_restor2.file15.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file15.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file15.src = defalut;
      print(data_restor2.file15.src);
      expect(data_restor2.file15.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file15.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file16.typ;
      print(data_restor2.file16.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file16.typ = testData1;
      print(data_restor2.file16.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file16.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file16.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file16.typ = testData2;
      print(data_restor2.file16.typ);
      expect(data_restor2.file16.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file16.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file16.typ = defalut;
      print(data_restor2.file16.typ);
      expect(data_restor2.file16.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file16.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file16.name;
      print(data_restor2.file16.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file16.name = testData1s;
      print(data_restor2.file16.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file16.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file16.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file16.name = testData2s;
      print(data_restor2.file16.name);
      expect(data_restor2.file16.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file16.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file16.name = defalut;
      print(data_restor2.file16.name);
      expect(data_restor2.file16.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file16.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file16.src;
      print(data_restor2.file16.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file16.src = testData1s;
      print(data_restor2.file16.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file16.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file16.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file16.src = testData2s;
      print(data_restor2.file16.src);
      expect(data_restor2.file16.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file16.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file16.src = defalut;
      print(data_restor2.file16.src);
      expect(data_restor2.file16.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file16.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file17.typ;
      print(data_restor2.file17.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file17.typ = testData1;
      print(data_restor2.file17.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file17.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file17.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file17.typ = testData2;
      print(data_restor2.file17.typ);
      expect(data_restor2.file17.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file17.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file17.typ = defalut;
      print(data_restor2.file17.typ);
      expect(data_restor2.file17.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file17.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file17.name;
      print(data_restor2.file17.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file17.name = testData1s;
      print(data_restor2.file17.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file17.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file17.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file17.name = testData2s;
      print(data_restor2.file17.name);
      expect(data_restor2.file17.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file17.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file17.name = defalut;
      print(data_restor2.file17.name);
      expect(data_restor2.file17.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file17.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file17.src;
      print(data_restor2.file17.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file17.src = testData1s;
      print(data_restor2.file17.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file17.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file17.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file17.src = testData2s;
      print(data_restor2.file17.src);
      expect(data_restor2.file17.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file17.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file17.src = defalut;
      print(data_restor2.file17.src);
      expect(data_restor2.file17.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file17.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file18.typ;
      print(data_restor2.file18.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file18.typ = testData1;
      print(data_restor2.file18.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file18.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file18.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file18.typ = testData2;
      print(data_restor2.file18.typ);
      expect(data_restor2.file18.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file18.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file18.typ = defalut;
      print(data_restor2.file18.typ);
      expect(data_restor2.file18.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file18.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file18.name;
      print(data_restor2.file18.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file18.name = testData1s;
      print(data_restor2.file18.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file18.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file18.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file18.name = testData2s;
      print(data_restor2.file18.name);
      expect(data_restor2.file18.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file18.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file18.name = defalut;
      print(data_restor2.file18.name);
      expect(data_restor2.file18.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file18.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file18.src;
      print(data_restor2.file18.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file18.src = testData1s;
      print(data_restor2.file18.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file18.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file18.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file18.src = testData2s;
      print(data_restor2.file18.src);
      expect(data_restor2.file18.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file18.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file18.src = defalut;
      print(data_restor2.file18.src);
      expect(data_restor2.file18.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file18.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file19.typ;
      print(data_restor2.file19.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file19.typ = testData1;
      print(data_restor2.file19.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file19.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file19.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file19.typ = testData2;
      print(data_restor2.file19.typ);
      expect(data_restor2.file19.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file19.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file19.typ = defalut;
      print(data_restor2.file19.typ);
      expect(data_restor2.file19.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file19.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file19.name;
      print(data_restor2.file19.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file19.name = testData1s;
      print(data_restor2.file19.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file19.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file19.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file19.name = testData2s;
      print(data_restor2.file19.name);
      expect(data_restor2.file19.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file19.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file19.name = defalut;
      print(data_restor2.file19.name);
      expect(data_restor2.file19.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file19.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file19.src;
      print(data_restor2.file19.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file19.src = testData1s;
      print(data_restor2.file19.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file19.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file19.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file19.src = testData2s;
      print(data_restor2.file19.src);
      expect(data_restor2.file19.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file19.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file19.src = defalut;
      print(data_restor2.file19.src);
      expect(data_restor2.file19.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file19.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file20.typ;
      print(data_restor2.file20.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file20.typ = testData1;
      print(data_restor2.file20.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file20.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file20.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file20.typ = testData2;
      print(data_restor2.file20.typ);
      expect(data_restor2.file20.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file20.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file20.typ = defalut;
      print(data_restor2.file20.typ);
      expect(data_restor2.file20.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file20.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file20.name;
      print(data_restor2.file20.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file20.name = testData1s;
      print(data_restor2.file20.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file20.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file20.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file20.name = testData2s;
      print(data_restor2.file20.name);
      expect(data_restor2.file20.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file20.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file20.name = defalut;
      print(data_restor2.file20.name);
      expect(data_restor2.file20.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file20.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file20.src;
      print(data_restor2.file20.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file20.src = testData1s;
      print(data_restor2.file20.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file20.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file20.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file20.src = testData2s;
      print(data_restor2.file20.src);
      expect(data_restor2.file20.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file20.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file20.src = defalut;
      print(data_restor2.file20.src);
      expect(data_restor2.file20.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file20.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file21.typ;
      print(data_restor2.file21.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file21.typ = testData1;
      print(data_restor2.file21.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file21.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file21.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file21.typ = testData2;
      print(data_restor2.file21.typ);
      expect(data_restor2.file21.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file21.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file21.typ = defalut;
      print(data_restor2.file21.typ);
      expect(data_restor2.file21.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file21.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file21.name;
      print(data_restor2.file21.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file21.name = testData1s;
      print(data_restor2.file21.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file21.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file21.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file21.name = testData2s;
      print(data_restor2.file21.name);
      expect(data_restor2.file21.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file21.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file21.name = defalut;
      print(data_restor2.file21.name);
      expect(data_restor2.file21.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file21.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file21.src;
      print(data_restor2.file21.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file21.src = testData1s;
      print(data_restor2.file21.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file21.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file21.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file21.src = testData2s;
      print(data_restor2.file21.src);
      expect(data_restor2.file21.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file21.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file21.src = defalut;
      print(data_restor2.file21.src);
      expect(data_restor2.file21.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file21.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file22.typ;
      print(data_restor2.file22.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file22.typ = testData1;
      print(data_restor2.file22.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file22.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file22.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file22.typ = testData2;
      print(data_restor2.file22.typ);
      expect(data_restor2.file22.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file22.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file22.typ = defalut;
      print(data_restor2.file22.typ);
      expect(data_restor2.file22.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file22.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file22.name;
      print(data_restor2.file22.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file22.name = testData1s;
      print(data_restor2.file22.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file22.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file22.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file22.name = testData2s;
      print(data_restor2.file22.name);
      expect(data_restor2.file22.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file22.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file22.name = defalut;
      print(data_restor2.file22.name);
      expect(data_restor2.file22.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file22.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file22.src;
      print(data_restor2.file22.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file22.src = testData1s;
      print(data_restor2.file22.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file22.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file22.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file22.src = testData2s;
      print(data_restor2.file22.src);
      expect(data_restor2.file22.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file22.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file22.src = defalut;
      print(data_restor2.file22.src);
      expect(data_restor2.file22.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file22.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file23.typ;
      print(data_restor2.file23.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file23.typ = testData1;
      print(data_restor2.file23.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file23.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file23.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file23.typ = testData2;
      print(data_restor2.file23.typ);
      expect(data_restor2.file23.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file23.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file23.typ = defalut;
      print(data_restor2.file23.typ);
      expect(data_restor2.file23.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file23.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file23.name;
      print(data_restor2.file23.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file23.name = testData1s;
      print(data_restor2.file23.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file23.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file23.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file23.name = testData2s;
      print(data_restor2.file23.name);
      expect(data_restor2.file23.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file23.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file23.name = defalut;
      print(data_restor2.file23.name);
      expect(data_restor2.file23.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file23.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file23.src;
      print(data_restor2.file23.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file23.src = testData1s;
      print(data_restor2.file23.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file23.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file23.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file23.src = testData2s;
      print(data_restor2.file23.src);
      expect(data_restor2.file23.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file23.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file23.src = defalut;
      print(data_restor2.file23.src);
      expect(data_restor2.file23.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file23.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file24.typ;
      print(data_restor2.file24.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file24.typ = testData1;
      print(data_restor2.file24.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file24.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file24.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file24.typ = testData2;
      print(data_restor2.file24.typ);
      expect(data_restor2.file24.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file24.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file24.typ = defalut;
      print(data_restor2.file24.typ);
      expect(data_restor2.file24.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file24.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file24.name;
      print(data_restor2.file24.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file24.name = testData1s;
      print(data_restor2.file24.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file24.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file24.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file24.name = testData2s;
      print(data_restor2.file24.name);
      expect(data_restor2.file24.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file24.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file24.name = defalut;
      print(data_restor2.file24.name);
      expect(data_restor2.file24.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file24.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file24.src;
      print(data_restor2.file24.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file24.src = testData1s;
      print(data_restor2.file24.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file24.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file24.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file24.src = testData2s;
      print(data_restor2.file24.src);
      expect(data_restor2.file24.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file24.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file24.src = defalut;
      print(data_restor2.file24.src);
      expect(data_restor2.file24.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file24.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file25.typ;
      print(data_restor2.file25.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file25.typ = testData1;
      print(data_restor2.file25.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file25.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file25.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file25.typ = testData2;
      print(data_restor2.file25.typ);
      expect(data_restor2.file25.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file25.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file25.typ = defalut;
      print(data_restor2.file25.typ);
      expect(data_restor2.file25.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file25.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file25.name;
      print(data_restor2.file25.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file25.name = testData1s;
      print(data_restor2.file25.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file25.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file25.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file25.name = testData2s;
      print(data_restor2.file25.name);
      expect(data_restor2.file25.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file25.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file25.name = defalut;
      print(data_restor2.file25.name);
      expect(data_restor2.file25.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file25.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file25.src;
      print(data_restor2.file25.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file25.src = testData1s;
      print(data_restor2.file25.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file25.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file25.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file25.src = testData2s;
      print(data_restor2.file25.src);
      expect(data_restor2.file25.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file25.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file25.src = defalut;
      print(data_restor2.file25.src);
      expect(data_restor2.file25.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file25.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file26.typ;
      print(data_restor2.file26.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file26.typ = testData1;
      print(data_restor2.file26.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file26.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file26.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file26.typ = testData2;
      print(data_restor2.file26.typ);
      expect(data_restor2.file26.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file26.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file26.typ = defalut;
      print(data_restor2.file26.typ);
      expect(data_restor2.file26.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file26.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file26.name;
      print(data_restor2.file26.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file26.name = testData1s;
      print(data_restor2.file26.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file26.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file26.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file26.name = testData2s;
      print(data_restor2.file26.name);
      expect(data_restor2.file26.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file26.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file26.name = defalut;
      print(data_restor2.file26.name);
      expect(data_restor2.file26.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file26.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file26.src;
      print(data_restor2.file26.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file26.src = testData1s;
      print(data_restor2.file26.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file26.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file26.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file26.src = testData2s;
      print(data_restor2.file26.src);
      expect(data_restor2.file26.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file26.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file26.src = defalut;
      print(data_restor2.file26.src);
      expect(data_restor2.file26.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file26.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file27.typ;
      print(data_restor2.file27.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file27.typ = testData1;
      print(data_restor2.file27.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file27.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file27.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file27.typ = testData2;
      print(data_restor2.file27.typ);
      expect(data_restor2.file27.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file27.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file27.typ = defalut;
      print(data_restor2.file27.typ);
      expect(data_restor2.file27.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file27.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file27.name;
      print(data_restor2.file27.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file27.name = testData1s;
      print(data_restor2.file27.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file27.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file27.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file27.name = testData2s;
      print(data_restor2.file27.name);
      expect(data_restor2.file27.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file27.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file27.name = defalut;
      print(data_restor2.file27.name);
      expect(data_restor2.file27.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file27.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file27.src;
      print(data_restor2.file27.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file27.src = testData1s;
      print(data_restor2.file27.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file27.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file27.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file27.src = testData2s;
      print(data_restor2.file27.src);
      expect(data_restor2.file27.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file27.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file27.src = defalut;
      print(data_restor2.file27.src);
      expect(data_restor2.file27.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file27.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file28.typ;
      print(data_restor2.file28.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file28.typ = testData1;
      print(data_restor2.file28.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file28.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file28.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file28.typ = testData2;
      print(data_restor2.file28.typ);
      expect(data_restor2.file28.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file28.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file28.typ = defalut;
      print(data_restor2.file28.typ);
      expect(data_restor2.file28.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file28.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file28.name;
      print(data_restor2.file28.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file28.name = testData1s;
      print(data_restor2.file28.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file28.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file28.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file28.name = testData2s;
      print(data_restor2.file28.name);
      expect(data_restor2.file28.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file28.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file28.name = defalut;
      print(data_restor2.file28.name);
      expect(data_restor2.file28.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file28.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file28.src;
      print(data_restor2.file28.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file28.src = testData1s;
      print(data_restor2.file28.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file28.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file28.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file28.src = testData2s;
      print(data_restor2.file28.src);
      expect(data_restor2.file28.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file28.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file28.src = defalut;
      print(data_restor2.file28.src);
      expect(data_restor2.file28.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file28.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file29.typ;
      print(data_restor2.file29.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file29.typ = testData1;
      print(data_restor2.file29.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file29.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file29.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file29.typ = testData2;
      print(data_restor2.file29.typ);
      expect(data_restor2.file29.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file29.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file29.typ = defalut;
      print(data_restor2.file29.typ);
      expect(data_restor2.file29.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file29.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file29.name;
      print(data_restor2.file29.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file29.name = testData1s;
      print(data_restor2.file29.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file29.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file29.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file29.name = testData2s;
      print(data_restor2.file29.name);
      expect(data_restor2.file29.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file29.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file29.name = defalut;
      print(data_restor2.file29.name);
      expect(data_restor2.file29.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file29.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file29.src;
      print(data_restor2.file29.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file29.src = testData1s;
      print(data_restor2.file29.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file29.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file29.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file29.src = testData2s;
      print(data_restor2.file29.src);
      expect(data_restor2.file29.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file29.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file29.src = defalut;
      print(data_restor2.file29.src);
      expect(data_restor2.file29.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file29.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file30.typ;
      print(data_restor2.file30.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file30.typ = testData1;
      print(data_restor2.file30.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file30.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file30.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file30.typ = testData2;
      print(data_restor2.file30.typ);
      expect(data_restor2.file30.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file30.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file30.typ = defalut;
      print(data_restor2.file30.typ);
      expect(data_restor2.file30.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file30.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file30.name;
      print(data_restor2.file30.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file30.name = testData1s;
      print(data_restor2.file30.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file30.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file30.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file30.name = testData2s;
      print(data_restor2.file30.name);
      expect(data_restor2.file30.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file30.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file30.name = defalut;
      print(data_restor2.file30.name);
      expect(data_restor2.file30.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file30.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file30.src;
      print(data_restor2.file30.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file30.src = testData1s;
      print(data_restor2.file30.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file30.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file30.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file30.src = testData2s;
      print(data_restor2.file30.src);
      expect(data_restor2.file30.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file30.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file30.src = defalut;
      print(data_restor2.file30.src);
      expect(data_restor2.file30.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file30.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file31.typ;
      print(data_restor2.file31.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file31.typ = testData1;
      print(data_restor2.file31.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file31.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file31.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file31.typ = testData2;
      print(data_restor2.file31.typ);
      expect(data_restor2.file31.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file31.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file31.typ = defalut;
      print(data_restor2.file31.typ);
      expect(data_restor2.file31.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file31.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file31.name;
      print(data_restor2.file31.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file31.name = testData1s;
      print(data_restor2.file31.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file31.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file31.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file31.name = testData2s;
      print(data_restor2.file31.name);
      expect(data_restor2.file31.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file31.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file31.name = defalut;
      print(data_restor2.file31.name);
      expect(data_restor2.file31.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file31.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file31.src;
      print(data_restor2.file31.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file31.src = testData1s;
      print(data_restor2.file31.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file31.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file31.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file31.src = testData2s;
      print(data_restor2.file31.src);
      expect(data_restor2.file31.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file31.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file31.src = defalut;
      print(data_restor2.file31.src);
      expect(data_restor2.file31.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file31.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file32.typ;
      print(data_restor2.file32.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file32.typ = testData1;
      print(data_restor2.file32.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file32.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file32.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file32.typ = testData2;
      print(data_restor2.file32.typ);
      expect(data_restor2.file32.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file32.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file32.typ = defalut;
      print(data_restor2.file32.typ);
      expect(data_restor2.file32.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file32.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file32.name;
      print(data_restor2.file32.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file32.name = testData1s;
      print(data_restor2.file32.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file32.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file32.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file32.name = testData2s;
      print(data_restor2.file32.name);
      expect(data_restor2.file32.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file32.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file32.name = defalut;
      print(data_restor2.file32.name);
      expect(data_restor2.file32.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file32.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file32.src;
      print(data_restor2.file32.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file32.src = testData1s;
      print(data_restor2.file32.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file32.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file32.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file32.src = testData2s;
      print(data_restor2.file32.src);
      expect(data_restor2.file32.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file32.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file32.src = defalut;
      print(data_restor2.file32.src);
      expect(data_restor2.file32.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file32.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file33.typ;
      print(data_restor2.file33.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file33.typ = testData1;
      print(data_restor2.file33.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file33.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file33.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file33.typ = testData2;
      print(data_restor2.file33.typ);
      expect(data_restor2.file33.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file33.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file33.typ = defalut;
      print(data_restor2.file33.typ);
      expect(data_restor2.file33.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file33.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file33.name;
      print(data_restor2.file33.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file33.name = testData1s;
      print(data_restor2.file33.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file33.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file33.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file33.name = testData2s;
      print(data_restor2.file33.name);
      expect(data_restor2.file33.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file33.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file33.name = defalut;
      print(data_restor2.file33.name);
      expect(data_restor2.file33.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file33.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file33.src;
      print(data_restor2.file33.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file33.src = testData1s;
      print(data_restor2.file33.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file33.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file33.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file33.src = testData2s;
      print(data_restor2.file33.src);
      expect(data_restor2.file33.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file33.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file33.src = defalut;
      print(data_restor2.file33.src);
      expect(data_restor2.file33.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file33.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file34.typ;
      print(data_restor2.file34.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file34.typ = testData1;
      print(data_restor2.file34.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file34.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file34.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file34.typ = testData2;
      print(data_restor2.file34.typ);
      expect(data_restor2.file34.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file34.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file34.typ = defalut;
      print(data_restor2.file34.typ);
      expect(data_restor2.file34.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file34.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file34.name;
      print(data_restor2.file34.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file34.name = testData1s;
      print(data_restor2.file34.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file34.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file34.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file34.name = testData2s;
      print(data_restor2.file34.name);
      expect(data_restor2.file34.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file34.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file34.name = defalut;
      print(data_restor2.file34.name);
      expect(data_restor2.file34.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file34.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file34.src;
      print(data_restor2.file34.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file34.src = testData1s;
      print(data_restor2.file34.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file34.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file34.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file34.src = testData2s;
      print(data_restor2.file34.src);
      expect(data_restor2.file34.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file34.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file34.src = defalut;
      print(data_restor2.file34.src);
      expect(data_restor2.file34.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file34.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file35.typ;
      print(data_restor2.file35.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file35.typ = testData1;
      print(data_restor2.file35.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file35.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file35.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file35.typ = testData2;
      print(data_restor2.file35.typ);
      expect(data_restor2.file35.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file35.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file35.typ = defalut;
      print(data_restor2.file35.typ);
      expect(data_restor2.file35.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file35.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file35.name;
      print(data_restor2.file35.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file35.name = testData1s;
      print(data_restor2.file35.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file35.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file35.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file35.name = testData2s;
      print(data_restor2.file35.name);
      expect(data_restor2.file35.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file35.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file35.name = defalut;
      print(data_restor2.file35.name);
      expect(data_restor2.file35.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file35.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file35.src;
      print(data_restor2.file35.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file35.src = testData1s;
      print(data_restor2.file35.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file35.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file35.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file35.src = testData2s;
      print(data_restor2.file35.src);
      expect(data_restor2.file35.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file35.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file35.src = defalut;
      print(data_restor2.file35.src);
      expect(data_restor2.file35.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file35.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file36.typ;
      print(data_restor2.file36.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file36.typ = testData1;
      print(data_restor2.file36.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file36.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file36.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file36.typ = testData2;
      print(data_restor2.file36.typ);
      expect(data_restor2.file36.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file36.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file36.typ = defalut;
      print(data_restor2.file36.typ);
      expect(data_restor2.file36.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file36.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file36.name;
      print(data_restor2.file36.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file36.name = testData1s;
      print(data_restor2.file36.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file36.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file36.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file36.name = testData2s;
      print(data_restor2.file36.name);
      expect(data_restor2.file36.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file36.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file36.name = defalut;
      print(data_restor2.file36.name);
      expect(data_restor2.file36.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file36.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file36.src;
      print(data_restor2.file36.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file36.src = testData1s;
      print(data_restor2.file36.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file36.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file36.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file36.src = testData2s;
      print(data_restor2.file36.src);
      expect(data_restor2.file36.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file36.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file36.src = defalut;
      print(data_restor2.file36.src);
      expect(data_restor2.file36.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file36.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file37.typ;
      print(data_restor2.file37.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file37.typ = testData1;
      print(data_restor2.file37.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file37.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file37.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file37.typ = testData2;
      print(data_restor2.file37.typ);
      expect(data_restor2.file37.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file37.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file37.typ = defalut;
      print(data_restor2.file37.typ);
      expect(data_restor2.file37.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file37.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file37.name;
      print(data_restor2.file37.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file37.name = testData1s;
      print(data_restor2.file37.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file37.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file37.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file37.name = testData2s;
      print(data_restor2.file37.name);
      expect(data_restor2.file37.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file37.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file37.name = defalut;
      print(data_restor2.file37.name);
      expect(data_restor2.file37.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file37.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file37.src;
      print(data_restor2.file37.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file37.src = testData1s;
      print(data_restor2.file37.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file37.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file37.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file37.src = testData2s;
      print(data_restor2.file37.src);
      expect(data_restor2.file37.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file37.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file37.src = defalut;
      print(data_restor2.file37.src);
      expect(data_restor2.file37.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file37.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file38.typ;
      print(data_restor2.file38.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file38.typ = testData1;
      print(data_restor2.file38.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file38.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file38.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file38.typ = testData2;
      print(data_restor2.file38.typ);
      expect(data_restor2.file38.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file38.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file38.typ = defalut;
      print(data_restor2.file38.typ);
      expect(data_restor2.file38.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file38.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file38.name;
      print(data_restor2.file38.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file38.name = testData1s;
      print(data_restor2.file38.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file38.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file38.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file38.name = testData2s;
      print(data_restor2.file38.name);
      expect(data_restor2.file38.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file38.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file38.name = defalut;
      print(data_restor2.file38.name);
      expect(data_restor2.file38.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file38.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file38.src;
      print(data_restor2.file38.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file38.src = testData1s;
      print(data_restor2.file38.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file38.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file38.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file38.src = testData2s;
      print(data_restor2.file38.src);
      expect(data_restor2.file38.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file38.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file38.src = defalut;
      print(data_restor2.file38.src);
      expect(data_restor2.file38.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file38.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

    test('00138_element_check_00115', () async {
      print("\n********** テスト実行：00138_element_check_00115 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file39.typ;
      print(data_restor2.file39.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file39.typ = testData1;
      print(data_restor2.file39.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file39.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file39.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file39.typ = testData2;
      print(data_restor2.file39.typ);
      expect(data_restor2.file39.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file39.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file39.typ = defalut;
      print(data_restor2.file39.typ);
      expect(data_restor2.file39.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file39.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00138_element_check_00115 **********\n\n");
    });

    test('00139_element_check_00116', () async {
      print("\n********** テスト実行：00139_element_check_00116 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file39.name;
      print(data_restor2.file39.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file39.name = testData1s;
      print(data_restor2.file39.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file39.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file39.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file39.name = testData2s;
      print(data_restor2.file39.name);
      expect(data_restor2.file39.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file39.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file39.name = defalut;
      print(data_restor2.file39.name);
      expect(data_restor2.file39.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file39.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00139_element_check_00116 **********\n\n");
    });

    test('00140_element_check_00117', () async {
      print("\n********** テスト実行：00140_element_check_00117 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file39.src;
      print(data_restor2.file39.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file39.src = testData1s;
      print(data_restor2.file39.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file39.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file39.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file39.src = testData2s;
      print(data_restor2.file39.src);
      expect(data_restor2.file39.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file39.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file39.src = defalut;
      print(data_restor2.file39.src);
      expect(data_restor2.file39.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file39.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00140_element_check_00117 **********\n\n");
    });

    test('00141_element_check_00118', () async {
      print("\n********** テスト実行：00141_element_check_00118 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file40.typ;
      print(data_restor2.file40.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file40.typ = testData1;
      print(data_restor2.file40.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file40.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file40.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file40.typ = testData2;
      print(data_restor2.file40.typ);
      expect(data_restor2.file40.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file40.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file40.typ = defalut;
      print(data_restor2.file40.typ);
      expect(data_restor2.file40.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file40.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00141_element_check_00118 **********\n\n");
    });

    test('00142_element_check_00119', () async {
      print("\n********** テスト実行：00142_element_check_00119 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file40.name;
      print(data_restor2.file40.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file40.name = testData1s;
      print(data_restor2.file40.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file40.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file40.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file40.name = testData2s;
      print(data_restor2.file40.name);
      expect(data_restor2.file40.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file40.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file40.name = defalut;
      print(data_restor2.file40.name);
      expect(data_restor2.file40.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file40.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00142_element_check_00119 **********\n\n");
    });

    test('00143_element_check_00120', () async {
      print("\n********** テスト実行：00143_element_check_00120 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file40.src;
      print(data_restor2.file40.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file40.src = testData1s;
      print(data_restor2.file40.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file40.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file40.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file40.src = testData2s;
      print(data_restor2.file40.src);
      expect(data_restor2.file40.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file40.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file40.src = defalut;
      print(data_restor2.file40.src);
      expect(data_restor2.file40.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file40.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00143_element_check_00120 **********\n\n");
    });

    test('00144_element_check_00121', () async {
      print("\n********** テスト実行：00144_element_check_00121 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file41.typ;
      print(data_restor2.file41.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file41.typ = testData1;
      print(data_restor2.file41.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file41.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file41.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file41.typ = testData2;
      print(data_restor2.file41.typ);
      expect(data_restor2.file41.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file41.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file41.typ = defalut;
      print(data_restor2.file41.typ);
      expect(data_restor2.file41.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file41.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00144_element_check_00121 **********\n\n");
    });

    test('00145_element_check_00122', () async {
      print("\n********** テスト実行：00145_element_check_00122 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file41.name;
      print(data_restor2.file41.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file41.name = testData1s;
      print(data_restor2.file41.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file41.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file41.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file41.name = testData2s;
      print(data_restor2.file41.name);
      expect(data_restor2.file41.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file41.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file41.name = defalut;
      print(data_restor2.file41.name);
      expect(data_restor2.file41.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file41.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00145_element_check_00122 **********\n\n");
    });

    test('00146_element_check_00123', () async {
      print("\n********** テスト実行：00146_element_check_00123 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file41.src;
      print(data_restor2.file41.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file41.src = testData1s;
      print(data_restor2.file41.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file41.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file41.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file41.src = testData2s;
      print(data_restor2.file41.src);
      expect(data_restor2.file41.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file41.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file41.src = defalut;
      print(data_restor2.file41.src);
      expect(data_restor2.file41.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file41.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00146_element_check_00123 **********\n\n");
    });

    test('00147_element_check_00124', () async {
      print("\n********** テスト実行：00147_element_check_00124 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file42.typ;
      print(data_restor2.file42.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file42.typ = testData1;
      print(data_restor2.file42.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file42.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file42.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file42.typ = testData2;
      print(data_restor2.file42.typ);
      expect(data_restor2.file42.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file42.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file42.typ = defalut;
      print(data_restor2.file42.typ);
      expect(data_restor2.file42.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file42.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00147_element_check_00124 **********\n\n");
    });

    test('00148_element_check_00125', () async {
      print("\n********** テスト実行：00148_element_check_00125 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file42.name;
      print(data_restor2.file42.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file42.name = testData1s;
      print(data_restor2.file42.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file42.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file42.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file42.name = testData2s;
      print(data_restor2.file42.name);
      expect(data_restor2.file42.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file42.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file42.name = defalut;
      print(data_restor2.file42.name);
      expect(data_restor2.file42.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file42.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00148_element_check_00125 **********\n\n");
    });

    test('00149_element_check_00126', () async {
      print("\n********** テスト実行：00149_element_check_00126 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file42.src;
      print(data_restor2.file42.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file42.src = testData1s;
      print(data_restor2.file42.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file42.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file42.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file42.src = testData2s;
      print(data_restor2.file42.src);
      expect(data_restor2.file42.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file42.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file42.src = defalut;
      print(data_restor2.file42.src);
      expect(data_restor2.file42.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file42.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00149_element_check_00126 **********\n\n");
    });

    test('00150_element_check_00127', () async {
      print("\n********** テスト実行：00150_element_check_00127 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file43.typ;
      print(data_restor2.file43.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file43.typ = testData1;
      print(data_restor2.file43.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file43.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file43.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file43.typ = testData2;
      print(data_restor2.file43.typ);
      expect(data_restor2.file43.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file43.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file43.typ = defalut;
      print(data_restor2.file43.typ);
      expect(data_restor2.file43.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file43.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00150_element_check_00127 **********\n\n");
    });

    test('00151_element_check_00128', () async {
      print("\n********** テスト実行：00151_element_check_00128 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file43.name;
      print(data_restor2.file43.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file43.name = testData1s;
      print(data_restor2.file43.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file43.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file43.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file43.name = testData2s;
      print(data_restor2.file43.name);
      expect(data_restor2.file43.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file43.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file43.name = defalut;
      print(data_restor2.file43.name);
      expect(data_restor2.file43.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file43.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00151_element_check_00128 **********\n\n");
    });

    test('00152_element_check_00129', () async {
      print("\n********** テスト実行：00152_element_check_00129 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file43.src;
      print(data_restor2.file43.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file43.src = testData1s;
      print(data_restor2.file43.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file43.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file43.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file43.src = testData2s;
      print(data_restor2.file43.src);
      expect(data_restor2.file43.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file43.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file43.src = defalut;
      print(data_restor2.file43.src);
      expect(data_restor2.file43.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file43.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00152_element_check_00129 **********\n\n");
    });

    test('00153_element_check_00130', () async {
      print("\n********** テスト実行：00153_element_check_00130 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file44.typ;
      print(data_restor2.file44.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file44.typ = testData1;
      print(data_restor2.file44.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file44.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file44.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file44.typ = testData2;
      print(data_restor2.file44.typ);
      expect(data_restor2.file44.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file44.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file44.typ = defalut;
      print(data_restor2.file44.typ);
      expect(data_restor2.file44.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file44.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00153_element_check_00130 **********\n\n");
    });

    test('00154_element_check_00131', () async {
      print("\n********** テスト実行：00154_element_check_00131 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file44.name;
      print(data_restor2.file44.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file44.name = testData1s;
      print(data_restor2.file44.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file44.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file44.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file44.name = testData2s;
      print(data_restor2.file44.name);
      expect(data_restor2.file44.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file44.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file44.name = defalut;
      print(data_restor2.file44.name);
      expect(data_restor2.file44.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file44.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00154_element_check_00131 **********\n\n");
    });

    test('00155_element_check_00132', () async {
      print("\n********** テスト実行：00155_element_check_00132 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file44.src;
      print(data_restor2.file44.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file44.src = testData1s;
      print(data_restor2.file44.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file44.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file44.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file44.src = testData2s;
      print(data_restor2.file44.src);
      expect(data_restor2.file44.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file44.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file44.src = defalut;
      print(data_restor2.file44.src);
      expect(data_restor2.file44.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file44.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00155_element_check_00132 **********\n\n");
    });

    test('00156_element_check_00133', () async {
      print("\n********** テスト実行：00156_element_check_00133 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file45.typ;
      print(data_restor2.file45.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file45.typ = testData1;
      print(data_restor2.file45.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file45.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file45.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file45.typ = testData2;
      print(data_restor2.file45.typ);
      expect(data_restor2.file45.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file45.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file45.typ = defalut;
      print(data_restor2.file45.typ);
      expect(data_restor2.file45.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file45.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00156_element_check_00133 **********\n\n");
    });

    test('00157_element_check_00134', () async {
      print("\n********** テスト実行：00157_element_check_00134 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file45.name;
      print(data_restor2.file45.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file45.name = testData1s;
      print(data_restor2.file45.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file45.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file45.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file45.name = testData2s;
      print(data_restor2.file45.name);
      expect(data_restor2.file45.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file45.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file45.name = defalut;
      print(data_restor2.file45.name);
      expect(data_restor2.file45.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file45.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00157_element_check_00134 **********\n\n");
    });

    test('00158_element_check_00135', () async {
      print("\n********** テスト実行：00158_element_check_00135 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file45.src;
      print(data_restor2.file45.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file45.src = testData1s;
      print(data_restor2.file45.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file45.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file45.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file45.src = testData2s;
      print(data_restor2.file45.src);
      expect(data_restor2.file45.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file45.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file45.src = defalut;
      print(data_restor2.file45.src);
      expect(data_restor2.file45.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file45.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00158_element_check_00135 **********\n\n");
    });

    test('00159_element_check_00136', () async {
      print("\n********** テスト実行：00159_element_check_00136 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file46.typ;
      print(data_restor2.file46.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file46.typ = testData1;
      print(data_restor2.file46.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file46.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file46.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file46.typ = testData2;
      print(data_restor2.file46.typ);
      expect(data_restor2.file46.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file46.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file46.typ = defalut;
      print(data_restor2.file46.typ);
      expect(data_restor2.file46.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file46.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00159_element_check_00136 **********\n\n");
    });

    test('00160_element_check_00137', () async {
      print("\n********** テスト実行：00160_element_check_00137 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file46.name;
      print(data_restor2.file46.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file46.name = testData1s;
      print(data_restor2.file46.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file46.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file46.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file46.name = testData2s;
      print(data_restor2.file46.name);
      expect(data_restor2.file46.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file46.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file46.name = defalut;
      print(data_restor2.file46.name);
      expect(data_restor2.file46.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file46.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00160_element_check_00137 **********\n\n");
    });

    test('00161_element_check_00138', () async {
      print("\n********** テスト実行：00161_element_check_00138 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file46.src;
      print(data_restor2.file46.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file46.src = testData1s;
      print(data_restor2.file46.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file46.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file46.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file46.src = testData2s;
      print(data_restor2.file46.src);
      expect(data_restor2.file46.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file46.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file46.src = defalut;
      print(data_restor2.file46.src);
      expect(data_restor2.file46.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file46.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00161_element_check_00138 **********\n\n");
    });

    test('00162_element_check_00139', () async {
      print("\n********** テスト実行：00162_element_check_00139 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file47.typ;
      print(data_restor2.file47.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file47.typ = testData1;
      print(data_restor2.file47.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file47.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file47.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file47.typ = testData2;
      print(data_restor2.file47.typ);
      expect(data_restor2.file47.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file47.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file47.typ = defalut;
      print(data_restor2.file47.typ);
      expect(data_restor2.file47.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file47.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00162_element_check_00139 **********\n\n");
    });

    test('00163_element_check_00140', () async {
      print("\n********** テスト実行：00163_element_check_00140 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file47.name;
      print(data_restor2.file47.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file47.name = testData1s;
      print(data_restor2.file47.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file47.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file47.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file47.name = testData2s;
      print(data_restor2.file47.name);
      expect(data_restor2.file47.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file47.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file47.name = defalut;
      print(data_restor2.file47.name);
      expect(data_restor2.file47.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file47.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00163_element_check_00140 **********\n\n");
    });

    test('00164_element_check_00141', () async {
      print("\n********** テスト実行：00164_element_check_00141 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file47.src;
      print(data_restor2.file47.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file47.src = testData1s;
      print(data_restor2.file47.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file47.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file47.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file47.src = testData2s;
      print(data_restor2.file47.src);
      expect(data_restor2.file47.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file47.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file47.src = defalut;
      print(data_restor2.file47.src);
      expect(data_restor2.file47.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file47.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00164_element_check_00141 **********\n\n");
    });

    test('00165_element_check_00142', () async {
      print("\n********** テスト実行：00165_element_check_00142 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file48.typ;
      print(data_restor2.file48.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file48.typ = testData1;
      print(data_restor2.file48.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file48.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file48.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file48.typ = testData2;
      print(data_restor2.file48.typ);
      expect(data_restor2.file48.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file48.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file48.typ = defalut;
      print(data_restor2.file48.typ);
      expect(data_restor2.file48.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file48.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00165_element_check_00142 **********\n\n");
    });

    test('00166_element_check_00143', () async {
      print("\n********** テスト実行：00166_element_check_00143 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file48.name;
      print(data_restor2.file48.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file48.name = testData1s;
      print(data_restor2.file48.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file48.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file48.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file48.name = testData2s;
      print(data_restor2.file48.name);
      expect(data_restor2.file48.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file48.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file48.name = defalut;
      print(data_restor2.file48.name);
      expect(data_restor2.file48.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file48.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00166_element_check_00143 **********\n\n");
    });

    test('00167_element_check_00144', () async {
      print("\n********** テスト実行：00167_element_check_00144 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file48.src;
      print(data_restor2.file48.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file48.src = testData1s;
      print(data_restor2.file48.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file48.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file48.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file48.src = testData2s;
      print(data_restor2.file48.src);
      expect(data_restor2.file48.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file48.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file48.src = defalut;
      print(data_restor2.file48.src);
      expect(data_restor2.file48.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file48.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00167_element_check_00144 **********\n\n");
    });

    test('00168_element_check_00145', () async {
      print("\n********** テスト実行：00168_element_check_00145 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file49.typ;
      print(data_restor2.file49.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file49.typ = testData1;
      print(data_restor2.file49.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file49.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file49.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file49.typ = testData2;
      print(data_restor2.file49.typ);
      expect(data_restor2.file49.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file49.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file49.typ = defalut;
      print(data_restor2.file49.typ);
      expect(data_restor2.file49.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file49.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00168_element_check_00145 **********\n\n");
    });

    test('00169_element_check_00146', () async {
      print("\n********** テスト実行：00169_element_check_00146 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file49.name;
      print(data_restor2.file49.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file49.name = testData1s;
      print(data_restor2.file49.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file49.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file49.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file49.name = testData2s;
      print(data_restor2.file49.name);
      expect(data_restor2.file49.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file49.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file49.name = defalut;
      print(data_restor2.file49.name);
      expect(data_restor2.file49.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file49.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00169_element_check_00146 **********\n\n");
    });

    test('00170_element_check_00147', () async {
      print("\n********** テスト実行：00170_element_check_00147 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file49.src;
      print(data_restor2.file49.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file49.src = testData1s;
      print(data_restor2.file49.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file49.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file49.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file49.src = testData2s;
      print(data_restor2.file49.src);
      expect(data_restor2.file49.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file49.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file49.src = defalut;
      print(data_restor2.file49.src);
      expect(data_restor2.file49.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file49.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00170_element_check_00147 **********\n\n");
    });

    test('00171_element_check_00148', () async {
      print("\n********** テスト実行：00171_element_check_00148 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file50.typ;
      print(data_restor2.file50.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file50.typ = testData1;
      print(data_restor2.file50.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file50.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file50.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file50.typ = testData2;
      print(data_restor2.file50.typ);
      expect(data_restor2.file50.typ == testData2, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file50.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file50.typ = defalut;
      print(data_restor2.file50.typ);
      expect(data_restor2.file50.typ == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file50.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00171_element_check_00148 **********\n\n");
    });

    test('00172_element_check_00149', () async {
      print("\n********** テスト実行：00172_element_check_00149 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file50.name;
      print(data_restor2.file50.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file50.name = testData1s;
      print(data_restor2.file50.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file50.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file50.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file50.name = testData2s;
      print(data_restor2.file50.name);
      expect(data_restor2.file50.name == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file50.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file50.name = defalut;
      print(data_restor2.file50.name);
      expect(data_restor2.file50.name == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file50.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00172_element_check_00149 **********\n\n");
    });

    test('00173_element_check_00150', () async {
      print("\n********** テスト実行：00173_element_check_00150 **********");

      data_restor2 = Data_restor2JsonFile();
      allPropatyCheckInit(data_restor2);

      // ①loadを実行する。
      await data_restor2.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor2.file50.src;
      print(data_restor2.file50.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor2.file50.src = testData1s;
      print(data_restor2.file50.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor2.file50.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor2.save();
      await data_restor2.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor2.file50.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor2.file50.src = testData2s;
      print(data_restor2.file50.src);
      expect(data_restor2.file50.src == testData2s, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file50.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor2.file50.src = defalut;
      print(data_restor2.file50.src);
      expect(data_restor2.file50.src == defalut, true);
      await data_restor2.save();
      await data_restor2.load();
      expect(data_restor2.file50.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor2, true);

      print("********** テスト終了：00173_element_check_00150 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Data_restor2JsonFile test)
{
  expect(test.file01.typ, 0);
  expect(test.file01.name, "");
  expect(test.file01.src, "");
  expect(test.file02.typ, 0);
  expect(test.file02.name, "");
  expect(test.file02.src, "");
  expect(test.file03.typ, 0);
  expect(test.file03.name, "");
  expect(test.file03.src, "");
  expect(test.file04.typ, 0);
  expect(test.file04.name, "");
  expect(test.file04.src, "");
  expect(test.file05.typ, 0);
  expect(test.file05.name, "");
  expect(test.file05.src, "");
  expect(test.file06.typ, 0);
  expect(test.file06.name, "");
  expect(test.file06.src, "");
  expect(test.file07.typ, 0);
  expect(test.file07.name, "");
  expect(test.file07.src, "");
  expect(test.file08.typ, 0);
  expect(test.file08.name, "");
  expect(test.file08.src, "");
  expect(test.file09.typ, 0);
  expect(test.file09.name, "");
  expect(test.file09.src, "");
  expect(test.file10.typ, 0);
  expect(test.file10.name, "");
  expect(test.file10.src, "");
  expect(test.file11.typ, 0);
  expect(test.file11.name, "");
  expect(test.file11.src, "");
  expect(test.file12.typ, 0);
  expect(test.file12.name, "");
  expect(test.file12.src, "");
  expect(test.file13.typ, 0);
  expect(test.file13.name, "");
  expect(test.file13.src, "");
  expect(test.file14.typ, 0);
  expect(test.file14.name, "");
  expect(test.file14.src, "");
  expect(test.file15.typ, 0);
  expect(test.file15.name, "");
  expect(test.file15.src, "");
  expect(test.file16.typ, 0);
  expect(test.file16.name, "");
  expect(test.file16.src, "");
  expect(test.file17.typ, 0);
  expect(test.file17.name, "");
  expect(test.file17.src, "");
  expect(test.file18.typ, 0);
  expect(test.file18.name, "");
  expect(test.file18.src, "");
  expect(test.file19.typ, 0);
  expect(test.file19.name, "");
  expect(test.file19.src, "");
  expect(test.file20.typ, 0);
  expect(test.file20.name, "");
  expect(test.file20.src, "");
  expect(test.file21.typ, 0);
  expect(test.file21.name, "");
  expect(test.file21.src, "");
  expect(test.file22.typ, 0);
  expect(test.file22.name, "");
  expect(test.file22.src, "");
  expect(test.file23.typ, 0);
  expect(test.file23.name, "");
  expect(test.file23.src, "");
  expect(test.file24.typ, 0);
  expect(test.file24.name, "");
  expect(test.file24.src, "");
  expect(test.file25.typ, 0);
  expect(test.file25.name, "");
  expect(test.file25.src, "");
  expect(test.file26.typ, 0);
  expect(test.file26.name, "");
  expect(test.file26.src, "");
  expect(test.file27.typ, 0);
  expect(test.file27.name, "");
  expect(test.file27.src, "");
  expect(test.file28.typ, 0);
  expect(test.file28.name, "");
  expect(test.file28.src, "");
  expect(test.file29.typ, 0);
  expect(test.file29.name, "");
  expect(test.file29.src, "");
  expect(test.file30.typ, 0);
  expect(test.file30.name, "");
  expect(test.file30.src, "");
  expect(test.file31.typ, 0);
  expect(test.file31.name, "");
  expect(test.file31.src, "");
  expect(test.file32.typ, 0);
  expect(test.file32.name, "");
  expect(test.file32.src, "");
  expect(test.file33.typ, 0);
  expect(test.file33.name, "");
  expect(test.file33.src, "");
  expect(test.file34.typ, 0);
  expect(test.file34.name, "");
  expect(test.file34.src, "");
  expect(test.file35.typ, 0);
  expect(test.file35.name, "");
  expect(test.file35.src, "");
  expect(test.file36.typ, 0);
  expect(test.file36.name, "");
  expect(test.file36.src, "");
  expect(test.file37.typ, 0);
  expect(test.file37.name, "");
  expect(test.file37.src, "");
  expect(test.file38.typ, 0);
  expect(test.file38.name, "");
  expect(test.file38.src, "");
  expect(test.file39.typ, 0);
  expect(test.file39.name, "");
  expect(test.file39.src, "");
  expect(test.file40.typ, 0);
  expect(test.file40.name, "");
  expect(test.file40.src, "");
  expect(test.file41.typ, 0);
  expect(test.file41.name, "");
  expect(test.file41.src, "");
  expect(test.file42.typ, 0);
  expect(test.file42.name, "");
  expect(test.file42.src, "");
  expect(test.file43.typ, 0);
  expect(test.file43.name, "");
  expect(test.file43.src, "");
  expect(test.file44.typ, 0);
  expect(test.file44.name, "");
  expect(test.file44.src, "");
  expect(test.file45.typ, 0);
  expect(test.file45.name, "");
  expect(test.file45.src, "");
  expect(test.file46.typ, 0);
  expect(test.file46.name, "");
  expect(test.file46.src, "");
  expect(test.file47.typ, 0);
  expect(test.file47.name, "");
  expect(test.file47.src, "");
  expect(test.file48.typ, 0);
  expect(test.file48.name, "");
  expect(test.file48.src, "");
  expect(test.file49.typ, 0);
  expect(test.file49.name, "");
  expect(test.file49.src, "");
  expect(test.file50.typ, 0);
  expect(test.file50.name, "");
  expect(test.file50.src, "");
}

void allPropatyCheck(Data_restor2JsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.file01.typ, 40);
  }
  expect(test.file01.name, "absv31.json");
  expect(test.file01.src, "conf/absv31.json");
  expect(test.file02.typ, 40);
  expect(test.file02.name, "acb.json");
  expect(test.file02.src, "conf/acb.json");
  expect(test.file03.typ, 40);
  expect(test.file03.name, "acb20.json");
  expect(test.file03.src, "conf/acb20.json");
  expect(test.file04.typ, 40);
  expect(test.file04.name, "acb50.json");
  expect(test.file04.src, "conf/acb50.json");
  expect(test.file05.typ, 40);
  expect(test.file05.name, "acr.json");
  expect(test.file05.src, "conf/acr.json");
  expect(test.file06.typ, 40);
  expect(test.file06.name, "aiv.json");
  expect(test.file06.src, "conf/aiv.json");
  expect(test.file07.typ, 40);
  expect(test.file07.name, "ar_stts_01.json");
  expect(test.file07.src, "conf/ar_stts_01.json");
  expect(test.file08.typ, 40);
  expect(test.file08.name, "ccr.json");
  expect(test.file08.src, "conf/ccr.json");
  expect(test.file09.typ, 40);
  expect(test.file09.name, "cct.json");
  expect(test.file09.src, "conf/cct.json");
  expect(test.file10.typ, 40);
  expect(test.file10.name, "dish.json");
  expect(test.file10.src, "conf/dish.json");
  expect(test.file11.typ, 40);
  expect(test.file11.name, "disht.json");
  expect(test.file11.src, "conf/disht.json");
  expect(test.file12.typ, 40);
  expect(test.file12.name, "fal2.json");
  expect(test.file12.src, "conf/fal2.json");
  expect(test.file13.typ, 40);
  expect(test.file13.name, "fcl.json");
  expect(test.file13.src, "conf/fcl.json");
  expect(test.file14.typ, 40);
  expect(test.file14.name, "gcat_cnct.json");
  expect(test.file14.src, "conf/gcat_cnct.json");
  expect(test.file15.typ, 40);
  expect(test.file15.name, "gp.json");
  expect(test.file15.src, "conf/gp.json");
  expect(test.file16.typ, 40);
  expect(test.file16.name, "ht2980.json");
  expect(test.file16.src, "conf/ht2980.json");
  expect(test.file17.typ, 40);
  expect(test.file17.name, "iccard.json");
  expect(test.file17.src, "conf/iccard.json");
  expect(test.file18.typ, 40);
  expect(test.file18.name, "j_debit.json");
  expect(test.file18.src, "conf/j_debit.json");
  expect(test.file19.typ, 40);
  expect(test.file19.name, "jmups.json");
  expect(test.file19.src, "conf/jmups.json");
  expect(test.file20.typ, 40);
  expect(test.file20.name, "jrw_multi.json");
  expect(test.file20.src, "conf/jrw_multi.json");
  expect(test.file21.typ, 40);
  expect(test.file21.name, "masr.json");
  expect(test.file21.src, "conf/masr.json");
  expect(test.file22.typ, 40);
  expect(test.file22.name, "mcp200.json");
  expect(test.file22.src, "conf/mcp200.json");
  expect(test.file23.typ, 40);
  expect(test.file23.name, "orc.json");
  expect(test.file23.src, "conf/orc.json");
  expect(test.file24.typ, 40);
  expect(test.file24.name, "pana.json");
  expect(test.file24.src, "conf/pana.json");
  expect(test.file25.typ, 40);
  expect(test.file25.name, "pana_gcat.json");
  expect(test.file25.src, "conf/pana_gcat.json");
  expect(test.file26.typ, 40);
  expect(test.file26.name, "psp60.json");
  expect(test.file26.src, "conf/psp60.json");
  expect(test.file27.typ, 40);
  expect(test.file27.name, "psp70.json");
  expect(test.file27.src, "conf/psp70.json");
  expect(test.file28.typ, 40);
  expect(test.file28.name, "pw410.json");
  expect(test.file28.src, "conf/pw410.json");
  expect(test.file29.typ, 40);
  expect(test.file29.name, "pwrctrl.json");
  expect(test.file29.src, "conf/pwrctrl.json");
  expect(test.file30.typ, 40);
  expect(test.file30.name, "rewrite_card.json");
  expect(test.file30.src, "conf/rewrite_card.json");
  expect(test.file31.typ, 40);
  expect(test.file31.name, "rfid.json");
  expect(test.file31.src, "conf/rfid.json");
  expect(test.file32.typ, 40);
  expect(test.file32.name, "s2pr.json");
  expect(test.file32.src, "conf/s2pr.json");
  expect(test.file33.typ, 40);
  expect(test.file33.name, "scale.json");
  expect(test.file33.src, "conf/scale.json");
  expect(test.file34.typ, 40);
  expect(test.file34.name, "sg_scale1.json");
  expect(test.file34.src, "conf/sg_scale1.json");
  expect(test.file35.typ, 40);
  expect(test.file35.name, "sg_scale2.json");
  expect(test.file35.src, "conf/sg_scale2.json");
  expect(test.file36.typ, 40);
  expect(test.file36.name, "sip60.json");
  expect(test.file36.src, "conf/sip60.json");
  expect(test.file37.typ, 40);
  expect(test.file37.name, "sm_scale1.json");
  expect(test.file37.src, "conf/sm_scale1.json");
  expect(test.file38.typ, 40);
  expect(test.file38.name, "sm_scale2.json");
  expect(test.file38.src, "conf/sm_scale2.json");
  expect(test.file39.typ, 40);
  expect(test.file39.name, "sm_scalesc.json");
  expect(test.file39.src, "conf/sm_scalesc.json");
  expect(test.file40.typ, 40);
  expect(test.file40.name, "sm_scalesc_scl.json");
  expect(test.file40.src, "conf/sm_scalesc_scl.json");
  expect(test.file41.typ, 40);
  expect(test.file41.name, "sm_scalesc_signp.json");
  expect(test.file41.src, "conf/sm_scalesc_signp.json");
  expect(test.file42.typ, 40);
  expect(test.file42.name, "smtplus.json");
  expect(test.file42.src, "conf/smtplus.json");
  expect(test.file43.typ, 40);
  expect(test.file43.name, "sprocket_prn.json");
  expect(test.file43.src, "conf/sprocket_prn.json");
  expect(test.file44.typ, 40);
  expect(test.file44.name, "sqrc_spec.json");
  expect(test.file44.src, "conf/sqrc_spec.json");
  expect(test.file45.typ, 40);
  expect(test.file45.name, "stpr.json");
  expect(test.file45.src, "conf/stpr.json");
  expect(test.file46.typ, 40);
  expect(test.file46.name, "suica_cnct.json");
  expect(test.file46.src, "conf/suica_cnct.json");
  expect(test.file47.typ, 40);
  expect(test.file47.name, "vismac.json");
  expect(test.file47.src, "conf/vismac.json");
  expect(test.file48.typ, 40);
  expect(test.file48.name, "yamato.json");
  expect(test.file48.src, "conf/yamato.json");
  expect(test.file49.typ, 40);
  expect(test.file49.name, "yomoca.json");
  expect(test.file49.src, "conf/yomoca.json");
  expect(test.file50.typ, 40);
  expect(test.file50.name, "rfid_utr.json");
  expect(test.file50.src, "conf/rfid_utr.json");
}

