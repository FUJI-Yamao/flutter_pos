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
import '../../../../lib/app/common/cls_conf/sys_paramJsonFile.dart';

late Sys_paramJsonFile sys_param;

void main(){
  sys_paramJsonFile_test();
}

void sys_paramJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "sys_param.json";
  const String section = "db";
  const String key = "name";
  const defaultData = "ts21db";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Sys_paramJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Sys_paramJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Sys_paramJsonFile().setDefault();
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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await sys_param.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(sys_param,true);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        sys_param.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await sys_param.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(sys_param,true);

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
      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①：loadを実行する。
      await sys_param.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = sys_param.db.name;
      sys_param.db.name = testData1s;
      expect(sys_param.db.name == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await sys_param.load();
      expect(sys_param.db.name != testData1s, true);
      expect(sys_param.db.name == prefixData, true);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = sys_param.db.name;
      sys_param.db.name = testData1s;
      expect(sys_param.db.name, testData1s);

      // ③saveを実行する。
      await sys_param.save();

      // ④loadを実行する。
      await sys_param.load();

      expect(sys_param.db.name != prefixData, true);
      expect(sys_param.db.name == testData1s, true);
      allPropatyCheck(sys_param,false);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await sys_param.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await sys_param.save();

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await sys_param.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(sys_param.db.name, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = sys_param.db.name;
      sys_param.db.name = testData1s;

      // ③ saveを実行する。
      await sys_param.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(sys_param.db.name, testData1s);

      // ④ loadを実行する。
      await sys_param.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(sys_param.db.name == testData1s, true);
      allPropatyCheck(sys_param,false);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await sys_param.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(sys_param,true);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②任意のプロパティの値を変更する。
      sys_param.db.name = testData1s;
      expect(sys_param.db.name, testData1s);

      // ③saveを実行する。
      await sys_param.save();
      expect(sys_param.db.name, testData1s);

      // ④loadを実行する。
      await sys_param.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(sys_param,true);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await sys_param.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await sys_param.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(sys_param.db.name == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await sys_param.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await sys_param.setValueWithName(section, "test_key", testData1s);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②任意のプロパティを変更する。
      sys_param.db.name = testData1s;

      // ③saveを実行する。
      await sys_param.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await sys_param.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②任意のプロパティを変更する。
      sys_param.db.name = testData1s;

      // ③saveを実行する。
      await sys_param.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await sys_param.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②任意のプロパティを変更する。
      sys_param.db.name = testData1s;

      // ③saveを実行する。
      await sys_param.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await sys_param.getValueWithName(section, "test_key");
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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await sys_param.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      sys_param.db.name = testData1s;
      expect(sys_param.db.name, testData1s);

      // ④saveを実行する。
      await sys_param.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(sys_param.db.name, testData1s);
      
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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await sys_param.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + sys_param.db.name.toString());
      expect(sys_param.db.name == testData1s, true);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await sys_param.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + sys_param.db.name.toString());
      expect(sys_param.db.name == testData2s, true);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await sys_param.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + sys_param.db.name.toString());
      expect(sys_param.db.name == testData1s, true);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await sys_param.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + sys_param.db.name.toString());
      expect(sys_param.db.name == testData2s, true);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await sys_param.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + sys_param.db.name.toString());
      expect(sys_param.db.name == testData1s, true);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await sys_param.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + sys_param.db.name.toString());
      expect(sys_param.db.name == testData1s, true);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await sys_param.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + sys_param.db.name.toString());
      allPropatyCheck(sys_param,true);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await sys_param.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + sys_param.db.name.toString());
      allPropatyCheck(sys_param,true);

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

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.db.name;
      print(sys_param.db.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.db.name = testData1s;
      print(sys_param.db.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.db.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.db.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.db.name = testData2s;
      print(sys_param.db.name);
      expect(sys_param.db.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.db.name = defalut;
      print(sys_param.db.name);
      expect(sys_param.db.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.db.localdbname;
      print(sys_param.db.localdbname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.db.localdbname = testData1s;
      print(sys_param.db.localdbname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.db.localdbname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.db.localdbname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.db.localdbname = testData2s;
      print(sys_param.db.localdbname);
      expect(sys_param.db.localdbname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.localdbname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.db.localdbname = defalut;
      print(sys_param.db.localdbname);
      expect(sys_param.db.localdbname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.localdbname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.db.localdbuser;
      print(sys_param.db.localdbuser);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.db.localdbuser = testData1s;
      print(sys_param.db.localdbuser);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.db.localdbuser == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.db.localdbuser == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.db.localdbuser = testData2s;
      print(sys_param.db.localdbuser);
      expect(sys_param.db.localdbuser == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.localdbuser == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.db.localdbuser = defalut;
      print(sys_param.db.localdbuser);
      expect(sys_param.db.localdbuser == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.localdbuser == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.db.localdbpass;
      print(sys_param.db.localdbpass);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.db.localdbpass = testData1s;
      print(sys_param.db.localdbpass);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.db.localdbpass == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.db.localdbpass == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.db.localdbpass = testData2s;
      print(sys_param.db.localdbpass);
      expect(sys_param.db.localdbpass == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.localdbpass == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.db.localdbpass = defalut;
      print(sys_param.db.localdbpass);
      expect(sys_param.db.localdbpass == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.localdbpass == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.db.hostdbname;
      print(sys_param.db.hostdbname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.db.hostdbname = testData1s;
      print(sys_param.db.hostdbname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.db.hostdbname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.db.hostdbname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.db.hostdbname = testData2s;
      print(sys_param.db.hostdbname);
      expect(sys_param.db.hostdbname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.hostdbname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.db.hostdbname = defalut;
      print(sys_param.db.hostdbname);
      expect(sys_param.db.hostdbname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.hostdbname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.db.hostdbuser;
      print(sys_param.db.hostdbuser);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.db.hostdbuser = testData1s;
      print(sys_param.db.hostdbuser);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.db.hostdbuser == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.db.hostdbuser == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.db.hostdbuser = testData2s;
      print(sys_param.db.hostdbuser);
      expect(sys_param.db.hostdbuser == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.hostdbuser == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.db.hostdbuser = defalut;
      print(sys_param.db.hostdbuser);
      expect(sys_param.db.hostdbuser == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.hostdbuser == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.db.hostdbpass;
      print(sys_param.db.hostdbpass);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.db.hostdbpass = testData1s;
      print(sys_param.db.hostdbpass);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.db.hostdbpass == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.db.hostdbpass == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.db.hostdbpass = testData2s;
      print(sys_param.db.hostdbpass);
      expect(sys_param.db.hostdbpass == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.hostdbpass == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.db.hostdbpass = defalut;
      print(sys_param.db.hostdbpass);
      expect(sys_param.db.hostdbpass == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.hostdbpass == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.db.masterdbname;
      print(sys_param.db.masterdbname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.db.masterdbname = testData1s;
      print(sys_param.db.masterdbname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.db.masterdbname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.db.masterdbname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.db.masterdbname = testData2s;
      print(sys_param.db.masterdbname);
      expect(sys_param.db.masterdbname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.masterdbname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.db.masterdbname = defalut;
      print(sys_param.db.masterdbname);
      expect(sys_param.db.masterdbname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.masterdbname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.db.masterdbuser;
      print(sys_param.db.masterdbuser);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.db.masterdbuser = testData1s;
      print(sys_param.db.masterdbuser);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.db.masterdbuser == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.db.masterdbuser == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.db.masterdbuser = testData2s;
      print(sys_param.db.masterdbuser);
      expect(sys_param.db.masterdbuser == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.masterdbuser == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.db.masterdbuser = defalut;
      print(sys_param.db.masterdbuser);
      expect(sys_param.db.masterdbuser == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.masterdbuser == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.db.masterdbpass;
      print(sys_param.db.masterdbpass);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.db.masterdbpass = testData1s;
      print(sys_param.db.masterdbpass);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.db.masterdbpass == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.db.masterdbpass == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.db.masterdbpass = testData2s;
      print(sys_param.db.masterdbpass);
      expect(sys_param.db.masterdbpass == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.masterdbpass == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.db.masterdbpass = defalut;
      print(sys_param.db.masterdbpass);
      expect(sys_param.db.masterdbpass == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.masterdbpass == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.db.db_connect_timeout;
      print(sys_param.db.db_connect_timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.db.db_connect_timeout = testData1;
      print(sys_param.db.db_connect_timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.db.db_connect_timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.db.db_connect_timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.db.db_connect_timeout = testData2;
      print(sys_param.db.db_connect_timeout);
      expect(sys_param.db.db_connect_timeout == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.db_connect_timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.db.db_connect_timeout = defalut;
      print(sys_param.db.db_connect_timeout);
      expect(sys_param.db.db_connect_timeout == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.db_connect_timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.db.tswebsvrname;
      print(sys_param.db.tswebsvrname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.db.tswebsvrname = testData1s;
      print(sys_param.db.tswebsvrname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.db.tswebsvrname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.db.tswebsvrname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.db.tswebsvrname = testData2s;
      print(sys_param.db.tswebsvrname);
      expect(sys_param.db.tswebsvrname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.tswebsvrname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.db.tswebsvrname = defalut;
      print(sys_param.db.tswebsvrname);
      expect(sys_param.db.tswebsvrname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.db.tswebsvrname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.server.name;
      print(sys_param.server.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.server.name = testData1s;
      print(sys_param.server.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.server.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.server.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.server.name = testData2s;
      print(sys_param.server.name);
      expect(sys_param.server.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.server.name = defalut;
      print(sys_param.server.name);
      expect(sys_param.server.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.server.loginname;
      print(sys_param.server.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.server.loginname = testData1s;
      print(sys_param.server.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.server.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.server.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.server.loginname = testData2s;
      print(sys_param.server.loginname);
      expect(sys_param.server.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.server.loginname = defalut;
      print(sys_param.server.loginname);
      expect(sys_param.server.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.server.password;
      print(sys_param.server.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.server.password = testData1s;
      print(sys_param.server.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.server.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.server.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.server.password = testData2s;
      print(sys_param.server.password);
      expect(sys_param.server.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.server.password = defalut;
      print(sys_param.server.password);
      expect(sys_param.server.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.server.remotepath;
      print(sys_param.server.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.server.remotepath = testData1s;
      print(sys_param.server.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.server.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.server.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.server.remotepath = testData2s;
      print(sys_param.server.remotepath);
      expect(sys_param.server.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.server.remotepath = defalut;
      print(sys_param.server.remotepath);
      expect(sys_param.server.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.server.remoteverpath;
      print(sys_param.server.remoteverpath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.server.remoteverpath = testData1s;
      print(sys_param.server.remoteverpath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.server.remoteverpath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.server.remoteverpath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.server.remoteverpath = testData2s;
      print(sys_param.server.remoteverpath);
      expect(sys_param.server.remoteverpath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.remoteverpath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.server.remoteverpath = defalut;
      print(sys_param.server.remoteverpath);
      expect(sys_param.server.remoteverpath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.remoteverpath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.server.remotebmppath;
      print(sys_param.server.remotebmppath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.server.remotebmppath = testData1s;
      print(sys_param.server.remotebmppath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.server.remotebmppath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.server.remotebmppath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.server.remotebmppath = testData2s;
      print(sys_param.server.remotebmppath);
      expect(sys_param.server.remotebmppath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.remotebmppath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.server.remotebmppath = defalut;
      print(sys_param.server.remotebmppath);
      expect(sys_param.server.remotebmppath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.remotebmppath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.server.prggetpath;
      print(sys_param.server.prggetpath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.server.prggetpath = testData1s;
      print(sys_param.server.prggetpath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.server.prggetpath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.server.prggetpath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.server.prggetpath = testData2s;
      print(sys_param.server.prggetpath);
      expect(sys_param.server.prggetpath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.prggetpath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.server.prggetpath = defalut;
      print(sys_param.server.prggetpath);
      expect(sys_param.server.prggetpath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.prggetpath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.server.verupstsputpath;
      print(sys_param.server.verupstsputpath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.server.verupstsputpath = testData1s;
      print(sys_param.server.verupstsputpath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.server.verupstsputpath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.server.verupstsputpath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.server.verupstsputpath = testData2s;
      print(sys_param.server.verupstsputpath);
      expect(sys_param.server.verupstsputpath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.verupstsputpath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.server.verupstsputpath = defalut;
      print(sys_param.server.verupstsputpath);
      expect(sys_param.server.verupstsputpath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.verupstsputpath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.server.remotetranpath;
      print(sys_param.server.remotetranpath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.server.remotetranpath = testData1s;
      print(sys_param.server.remotetranpath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.server.remotetranpath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.server.remotetranpath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.server.remotetranpath = testData2s;
      print(sys_param.server.remotetranpath);
      expect(sys_param.server.remotetranpath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.remotetranpath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.server.remotetranpath = defalut;
      print(sys_param.server.remotetranpath);
      expect(sys_param.server.remotetranpath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.remotetranpath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.server.remotepath_webapi;
      print(sys_param.server.remotepath_webapi);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.server.remotepath_webapi = testData1s;
      print(sys_param.server.remotepath_webapi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.server.remotepath_webapi == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.server.remotepath_webapi == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.server.remotepath_webapi = testData2s;
      print(sys_param.server.remotepath_webapi);
      expect(sys_param.server.remotepath_webapi == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.remotepath_webapi == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.server.remotepath_webapi = defalut;
      print(sys_param.server.remotepath_webapi);
      expect(sys_param.server.remotepath_webapi == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.remotepath_webapi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.server.url;
      print(sys_param.server.url);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.server.url = testData1s;
      print(sys_param.server.url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.server.url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.server.url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.server.url = testData2s;
      print(sys_param.server.url);
      expect(sys_param.server.url == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.server.url = defalut;
      print(sys_param.server.url);
      expect(sys_param.server.url == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.server.url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.master.name;
      print(sys_param.master.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.master.name = testData1s;
      print(sys_param.master.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.master.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.master.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.master.name = testData2s;
      print(sys_param.master.name);
      expect(sys_param.master.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.master.name = defalut;
      print(sys_param.master.name);
      expect(sys_param.master.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.master.loginname;
      print(sys_param.master.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.master.loginname = testData1s;
      print(sys_param.master.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.master.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.master.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.master.loginname = testData2s;
      print(sys_param.master.loginname);
      expect(sys_param.master.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.master.loginname = defalut;
      print(sys_param.master.loginname);
      expect(sys_param.master.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.master.password;
      print(sys_param.master.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.master.password = testData1s;
      print(sys_param.master.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.master.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.master.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.master.password = testData2s;
      print(sys_param.master.password);
      expect(sys_param.master.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.master.password = defalut;
      print(sys_param.master.password);
      expect(sys_param.master.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.master.remotepath;
      print(sys_param.master.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.master.remotepath = testData1s;
      print(sys_param.master.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.master.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.master.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.master.remotepath = testData2s;
      print(sys_param.master.remotepath);
      expect(sys_param.master.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.master.remotepath = defalut;
      print(sys_param.master.remotepath);
      expect(sys_param.master.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.master.remoteverpath;
      print(sys_param.master.remoteverpath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.master.remoteverpath = testData1s;
      print(sys_param.master.remoteverpath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.master.remoteverpath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.master.remoteverpath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.master.remoteverpath = testData2s;
      print(sys_param.master.remoteverpath);
      expect(sys_param.master.remoteverpath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.remoteverpath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.master.remoteverpath = defalut;
      print(sys_param.master.remoteverpath);
      expect(sys_param.master.remoteverpath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.remoteverpath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.master.remotebmppath;
      print(sys_param.master.remotebmppath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.master.remotebmppath = testData1s;
      print(sys_param.master.remotebmppath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.master.remotebmppath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.master.remotebmppath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.master.remotebmppath = testData2s;
      print(sys_param.master.remotebmppath);
      expect(sys_param.master.remotebmppath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.remotebmppath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.master.remotebmppath = defalut;
      print(sys_param.master.remotebmppath);
      expect(sys_param.master.remotebmppath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.remotebmppath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.master.prggetpath;
      print(sys_param.master.prggetpath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.master.prggetpath = testData1s;
      print(sys_param.master.prggetpath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.master.prggetpath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.master.prggetpath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.master.prggetpath = testData2s;
      print(sys_param.master.prggetpath);
      expect(sys_param.master.prggetpath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.prggetpath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.master.prggetpath = defalut;
      print(sys_param.master.prggetpath);
      expect(sys_param.master.prggetpath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.prggetpath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.master.verupstsputpath;
      print(sys_param.master.verupstsputpath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.master.verupstsputpath = testData1s;
      print(sys_param.master.verupstsputpath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.master.verupstsputpath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.master.verupstsputpath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.master.verupstsputpath = testData2s;
      print(sys_param.master.verupstsputpath);
      expect(sys_param.master.verupstsputpath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.verupstsputpath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.master.verupstsputpath = defalut;
      print(sys_param.master.verupstsputpath);
      expect(sys_param.master.verupstsputpath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.verupstsputpath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.master.remotetranpath;
      print(sys_param.master.remotetranpath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.master.remotetranpath = testData1s;
      print(sys_param.master.remotetranpath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.master.remotetranpath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.master.remotetranpath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.master.remotetranpath = testData2s;
      print(sys_param.master.remotetranpath);
      expect(sys_param.master.remotetranpath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.remotetranpath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.master.remotetranpath = defalut;
      print(sys_param.master.remotetranpath);
      expect(sys_param.master.remotetranpath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.master.remotetranpath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.subserver.name;
      print(sys_param.subserver.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.subserver.name = testData1s;
      print(sys_param.subserver.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.subserver.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.subserver.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.subserver.name = testData2s;
      print(sys_param.subserver.name);
      expect(sys_param.subserver.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.subserver.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.subserver.name = defalut;
      print(sys_param.subserver.name);
      expect(sys_param.subserver.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.subserver.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.mm_system.max_connect;
      print(sys_param.mm_system.max_connect);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.mm_system.max_connect = testData1;
      print(sys_param.mm_system.max_connect);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.mm_system.max_connect == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.mm_system.max_connect == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.mm_system.max_connect = testData2;
      print(sys_param.mm_system.max_connect);
      expect(sys_param.mm_system.max_connect == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mm_system.max_connect == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.mm_system.max_connect = defalut;
      print(sys_param.mm_system.max_connect);
      expect(sys_param.mm_system.max_connect == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mm_system.max_connect == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.mm_system.maxBackends;
      print(sys_param.mm_system.maxBackends);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.mm_system.maxBackends = testData1;
      print(sys_param.mm_system.maxBackends);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.mm_system.maxBackends == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.mm_system.maxBackends == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.mm_system.maxBackends = testData2;
      print(sys_param.mm_system.maxBackends);
      expect(sys_param.mm_system.maxBackends == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mm_system.maxBackends == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.mm_system.maxBackends = defalut;
      print(sys_param.mm_system.maxBackends);
      expect(sys_param.mm_system.maxBackends == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mm_system.maxBackends == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.mm_system.nBuffers;
      print(sys_param.mm_system.nBuffers);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.mm_system.nBuffers = testData1;
      print(sys_param.mm_system.nBuffers);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.mm_system.nBuffers == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.mm_system.nBuffers == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.mm_system.nBuffers = testData2;
      print(sys_param.mm_system.nBuffers);
      expect(sys_param.mm_system.nBuffers == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mm_system.nBuffers == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.mm_system.nBuffers = defalut;
      print(sys_param.mm_system.nBuffers);
      expect(sys_param.mm_system.nBuffers == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mm_system.nBuffers == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.name;
      print(sys_param.hq.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.name = testData1s;
      print(sys_param.hq.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.name = testData2s;
      print(sys_param.hq.name);
      expect(sys_param.hq.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.name = defalut;
      print(sys_param.hq.name);
      expect(sys_param.hq.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.loginname;
      print(sys_param.hq.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.loginname = testData1s;
      print(sys_param.hq.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.loginname = testData2s;
      print(sys_param.hq.loginname);
      expect(sys_param.hq.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.loginname = defalut;
      print(sys_param.hq.loginname);
      expect(sys_param.hq.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.password;
      print(sys_param.hq.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.password = testData1s;
      print(sys_param.hq.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.password = testData2s;
      print(sys_param.hq.password);
      expect(sys_param.hq.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.password = defalut;
      print(sys_param.hq.password);
      expect(sys_param.hq.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.remotepath;
      print(sys_param.hq.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.remotepath = testData1s;
      print(sys_param.hq.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.remotepath = testData2s;
      print(sys_param.hq.remotepath);
      expect(sys_param.hq.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.remotepath = defalut;
      print(sys_param.hq.remotepath);
      expect(sys_param.hq.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.remotepath_rcv;
      print(sys_param.hq.remotepath_rcv);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.remotepath_rcv = testData1s;
      print(sys_param.hq.remotepath_rcv);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.remotepath_rcv == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.remotepath_rcv == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.remotepath_rcv = testData2s;
      print(sys_param.hq.remotepath_rcv);
      expect(sys_param.hq.remotepath_rcv == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.remotepath_rcv == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.remotepath_rcv = defalut;
      print(sys_param.hq.remotepath_rcv);
      expect(sys_param.hq.remotepath_rcv == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.remotepath_rcv == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.hostname;
      print(sys_param.hq.hostname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.hostname = testData1s;
      print(sys_param.hq.hostname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.hostname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.hostname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.hostname = testData2s;
      print(sys_param.hq.hostname);
      expect(sys_param.hq.hostname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.hostname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.hostname = defalut;
      print(sys_param.hq.hostname);
      expect(sys_param.hq.hostname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.hostname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.userid;
      print(sys_param.hq.userid);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.userid = testData1s;
      print(sys_param.hq.userid);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.userid == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.userid == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.userid = testData2s;
      print(sys_param.hq.userid);
      expect(sys_param.hq.userid == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.userid == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.userid = defalut;
      print(sys_param.hq.userid);
      expect(sys_param.hq.userid == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.userid == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.userpass;
      print(sys_param.hq.userpass);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.userpass = testData1s;
      print(sys_param.hq.userpass);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.userpass == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.userpass == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.userpass = testData2s;
      print(sys_param.hq.userpass);
      expect(sys_param.hq.userpass == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.userpass == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.userpass = defalut;
      print(sys_param.hq.userpass);
      expect(sys_param.hq.userpass == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.userpass == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.compcd;
      print(sys_param.hq.compcd);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.compcd = testData1;
      print(sys_param.hq.compcd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.compcd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.compcd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.compcd = testData2;
      print(sys_param.hq.compcd);
      expect(sys_param.hq.compcd == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.compcd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.compcd = defalut;
      print(sys_param.hq.compcd);
      expect(sys_param.hq.compcd == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.compcd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.url;
      print(sys_param.hq.url);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.url = testData1s;
      print(sys_param.hq.url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.url = testData2s;
      print(sys_param.hq.url);
      expect(sys_param.hq.url == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.url = defalut;
      print(sys_param.hq.url);
      expect(sys_param.hq.url == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.inq_retry_cnt;
      print(sys_param.hq.inq_retry_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.inq_retry_cnt = testData1;
      print(sys_param.hq.inq_retry_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.inq_retry_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.inq_retry_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.inq_retry_cnt = testData2;
      print(sys_param.hq.inq_retry_cnt);
      expect(sys_param.hq.inq_retry_cnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.inq_retry_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.inq_retry_cnt = defalut;
      print(sys_param.hq.inq_retry_cnt);
      expect(sys_param.hq.inq_retry_cnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.inq_retry_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.inq_retry_time;
      print(sys_param.hq.inq_retry_time);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.inq_retry_time = testData1;
      print(sys_param.hq.inq_retry_time);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.inq_retry_time == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.inq_retry_time == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.inq_retry_time = testData2;
      print(sys_param.hq.inq_retry_time);
      expect(sys_param.hq.inq_retry_time == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.inq_retry_time == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.inq_retry_time = defalut;
      print(sys_param.hq.inq_retry_time);
      expect(sys_param.hq.inq_retry_time == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.inq_retry_time == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.offsend_time;
      print(sys_param.hq.offsend_time);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.offsend_time = testData1;
      print(sys_param.hq.offsend_time);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.offsend_time == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.offsend_time == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.offsend_time = testData2;
      print(sys_param.hq.offsend_time);
      expect(sys_param.hq.offsend_time == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.offsend_time == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.offsend_time = defalut;
      print(sys_param.hq.offsend_time);
      expect(sys_param.hq.offsend_time == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.offsend_time == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.offlimit_cnt;
      print(sys_param.hq.offlimit_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.offlimit_cnt = testData1;
      print(sys_param.hq.offlimit_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.offlimit_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.offlimit_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.offlimit_cnt = testData2;
      print(sys_param.hq.offlimit_cnt);
      expect(sys_param.hq.offlimit_cnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.offlimit_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.offlimit_cnt = defalut;
      print(sys_param.hq.offlimit_cnt);
      expect(sys_param.hq.offlimit_cnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.offlimit_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.ftp_port;
      print(sys_param.hq.ftp_port);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.ftp_port = testData1;
      print(sys_param.hq.ftp_port);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.ftp_port == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.ftp_port == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.ftp_port = testData2;
      print(sys_param.hq.ftp_port);
      expect(sys_param.hq.ftp_port == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.ftp_port == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.ftp_port = defalut;
      print(sys_param.hq.ftp_port);
      expect(sys_param.hq.ftp_port == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.ftp_port == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.ftp_protocol;
      print(sys_param.hq.ftp_protocol);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.ftp_protocol = testData1;
      print(sys_param.hq.ftp_protocol);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.ftp_protocol == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.ftp_protocol == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.ftp_protocol = testData2;
      print(sys_param.hq.ftp_protocol);
      expect(sys_param.hq.ftp_protocol == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.ftp_protocol == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.ftp_protocol = defalut;
      print(sys_param.hq.ftp_protocol);
      expect(sys_param.hq.ftp_protocol == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.ftp_protocol == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.ftp_pasv;
      print(sys_param.hq.ftp_pasv);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.ftp_pasv = testData1;
      print(sys_param.hq.ftp_pasv);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.ftp_pasv == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.ftp_pasv == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.ftp_pasv = testData2;
      print(sys_param.hq.ftp_pasv);
      expect(sys_param.hq.ftp_pasv == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.ftp_pasv == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.ftp_pasv = defalut;
      print(sys_param.hq.ftp_pasv);
      expect(sys_param.hq.ftp_pasv == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.ftp_pasv == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.ftp_retrycnt;
      print(sys_param.hq.ftp_retrycnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.ftp_retrycnt = testData1;
      print(sys_param.hq.ftp_retrycnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.ftp_retrycnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.ftp_retrycnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.ftp_retrycnt = testData2;
      print(sys_param.hq.ftp_retrycnt);
      expect(sys_param.hq.ftp_retrycnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.ftp_retrycnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.ftp_retrycnt = defalut;
      print(sys_param.hq.ftp_retrycnt);
      expect(sys_param.hq.ftp_retrycnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.ftp_retrycnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq.daycls_time;
      print(sys_param.hq.daycls_time);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq.daycls_time = testData1;
      print(sys_param.hq.daycls_time);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq.daycls_time == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq.daycls_time == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq.daycls_time = testData2;
      print(sys_param.hq.daycls_time);
      expect(sys_param.hq.daycls_time == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.daycls_time == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq.daycls_time = defalut;
      print(sys_param.hq.daycls_time);
      expect(sys_param.hq.daycls_time == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq.daycls_time == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.netDoA.histup_url;
      print(sys_param.netDoA.histup_url);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.netDoA.histup_url = testData1s;
      print(sys_param.netDoA.histup_url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.netDoA.histup_url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.netDoA.histup_url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.netDoA.histup_url = testData2s;
      print(sys_param.netDoA.histup_url);
      expect(sys_param.netDoA.histup_url == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.histup_url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.netDoA.histup_url = defalut;
      print(sys_param.netDoA.histup_url);
      expect(sys_param.netDoA.histup_url == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.histup_url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.netDoA.histdown_url;
      print(sys_param.netDoA.histdown_url);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.netDoA.histdown_url = testData1s;
      print(sys_param.netDoA.histdown_url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.netDoA.histdown_url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.netDoA.histdown_url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.netDoA.histdown_url = testData2s;
      print(sys_param.netDoA.histdown_url);
      expect(sys_param.netDoA.histdown_url == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.histdown_url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.netDoA.histdown_url = defalut;
      print(sys_param.netDoA.histdown_url);
      expect(sys_param.netDoA.histdown_url == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.histdown_url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.netDoA.fileup_url;
      print(sys_param.netDoA.fileup_url);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.netDoA.fileup_url = testData1s;
      print(sys_param.netDoA.fileup_url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.netDoA.fileup_url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.netDoA.fileup_url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.netDoA.fileup_url = testData2s;
      print(sys_param.netDoA.fileup_url);
      expect(sys_param.netDoA.fileup_url == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.fileup_url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.netDoA.fileup_url = defalut;
      print(sys_param.netDoA.fileup_url);
      expect(sys_param.netDoA.fileup_url == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.fileup_url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.netDoA.filedown_url;
      print(sys_param.netDoA.filedown_url);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.netDoA.filedown_url = testData1s;
      print(sys_param.netDoA.filedown_url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.netDoA.filedown_url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.netDoA.filedown_url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.netDoA.filedown_url = testData2s;
      print(sys_param.netDoA.filedown_url);
      expect(sys_param.netDoA.filedown_url == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.filedown_url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.netDoA.filedown_url = defalut;
      print(sys_param.netDoA.filedown_url);
      expect(sys_param.netDoA.filedown_url == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.filedown_url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.netDoA.auth_user;
      print(sys_param.netDoA.auth_user);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.netDoA.auth_user = testData1s;
      print(sys_param.netDoA.auth_user);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.netDoA.auth_user == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.netDoA.auth_user == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.netDoA.auth_user = testData2s;
      print(sys_param.netDoA.auth_user);
      expect(sys_param.netDoA.auth_user == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.auth_user == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.netDoA.auth_user = defalut;
      print(sys_param.netDoA.auth_user);
      expect(sys_param.netDoA.auth_user == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.auth_user == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.netDoA.auth_pass;
      print(sys_param.netDoA.auth_pass);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.netDoA.auth_pass = testData1s;
      print(sys_param.netDoA.auth_pass);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.netDoA.auth_pass == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.netDoA.auth_pass == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.netDoA.auth_pass = testData2s;
      print(sys_param.netDoA.auth_pass);
      expect(sys_param.netDoA.auth_pass == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.auth_pass == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.netDoA.auth_pass = defalut;
      print(sys_param.netDoA.auth_pass);
      expect(sys_param.netDoA.auth_pass == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.auth_pass == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.netDoA.fileup_retry_cnt;
      print(sys_param.netDoA.fileup_retry_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.netDoA.fileup_retry_cnt = testData1;
      print(sys_param.netDoA.fileup_retry_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.netDoA.fileup_retry_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.netDoA.fileup_retry_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.netDoA.fileup_retry_cnt = testData2;
      print(sys_param.netDoA.fileup_retry_cnt);
      expect(sys_param.netDoA.fileup_retry_cnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.fileup_retry_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.netDoA.fileup_retry_cnt = defalut;
      print(sys_param.netDoA.fileup_retry_cnt);
      expect(sys_param.netDoA.fileup_retry_cnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.fileup_retry_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.netDoA.filedown_retry_cnt;
      print(sys_param.netDoA.filedown_retry_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.netDoA.filedown_retry_cnt = testData1;
      print(sys_param.netDoA.filedown_retry_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.netDoA.filedown_retry_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.netDoA.filedown_retry_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.netDoA.filedown_retry_cnt = testData2;
      print(sys_param.netDoA.filedown_retry_cnt);
      expect(sys_param.netDoA.filedown_retry_cnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.filedown_retry_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.netDoA.filedown_retry_cnt = defalut;
      print(sys_param.netDoA.filedown_retry_cnt);
      expect(sys_param.netDoA.filedown_retry_cnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.filedown_retry_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.netDoA.verify_check;
      print(sys_param.netDoA.verify_check);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.netDoA.verify_check = testData1;
      print(sys_param.netDoA.verify_check);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.netDoA.verify_check == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.netDoA.verify_check == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.netDoA.verify_check = testData2;
      print(sys_param.netDoA.verify_check);
      expect(sys_param.netDoA.verify_check == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.verify_check == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.netDoA.verify_check = defalut;
      print(sys_param.netDoA.verify_check);
      expect(sys_param.netDoA.verify_check == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.netDoA.verify_check == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ht_server.name;
      print(sys_param.ht_server.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ht_server.name = testData1s;
      print(sys_param.ht_server.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ht_server.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ht_server.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ht_server.name = testData2s;
      print(sys_param.ht_server.name);
      expect(sys_param.ht_server.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_server.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ht_server.name = defalut;
      print(sys_param.ht_server.name);
      expect(sys_param.ht_server.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_server.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ht_server.loginname;
      print(sys_param.ht_server.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ht_server.loginname = testData1s;
      print(sys_param.ht_server.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ht_server.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ht_server.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ht_server.loginname = testData2s;
      print(sys_param.ht_server.loginname);
      expect(sys_param.ht_server.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_server.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ht_server.loginname = defalut;
      print(sys_param.ht_server.loginname);
      expect(sys_param.ht_server.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_server.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ht_server.password;
      print(sys_param.ht_server.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ht_server.password = testData1s;
      print(sys_param.ht_server.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ht_server.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ht_server.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ht_server.password = testData2s;
      print(sys_param.ht_server.password);
      expect(sys_param.ht_server.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_server.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ht_server.password = defalut;
      print(sys_param.ht_server.password);
      expect(sys_param.ht_server.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_server.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ht_server.remotepath;
      print(sys_param.ht_server.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ht_server.remotepath = testData1s;
      print(sys_param.ht_server.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ht_server.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ht_server.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ht_server.remotepath = testData2s;
      print(sys_param.ht_server.remotepath);
      expect(sys_param.ht_server.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_server.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ht_server.remotepath = defalut;
      print(sys_param.ht_server.remotepath);
      expect(sys_param.ht_server.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_server.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ht_master.name;
      print(sys_param.ht_master.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ht_master.name = testData1s;
      print(sys_param.ht_master.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ht_master.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ht_master.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ht_master.name = testData2s;
      print(sys_param.ht_master.name);
      expect(sys_param.ht_master.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_master.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ht_master.name = defalut;
      print(sys_param.ht_master.name);
      expect(sys_param.ht_master.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_master.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ht_master.loginname;
      print(sys_param.ht_master.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ht_master.loginname = testData1s;
      print(sys_param.ht_master.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ht_master.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ht_master.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ht_master.loginname = testData2s;
      print(sys_param.ht_master.loginname);
      expect(sys_param.ht_master.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_master.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ht_master.loginname = defalut;
      print(sys_param.ht_master.loginname);
      expect(sys_param.ht_master.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_master.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ht_master.password;
      print(sys_param.ht_master.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ht_master.password = testData1s;
      print(sys_param.ht_master.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ht_master.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ht_master.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ht_master.password = testData2s;
      print(sys_param.ht_master.password);
      expect(sys_param.ht_master.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_master.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ht_master.password = defalut;
      print(sys_param.ht_master.password);
      expect(sys_param.ht_master.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_master.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ht_master.remotepath;
      print(sys_param.ht_master.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ht_master.remotepath = testData1s;
      print(sys_param.ht_master.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ht_master.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ht_master.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ht_master.remotepath = testData2s;
      print(sys_param.ht_master.remotepath);
      expect(sys_param.ht_master.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_master.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ht_master.remotepath = defalut;
      print(sys_param.ht_master.remotepath);
      expect(sys_param.ht_master.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ht_master.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ip_addr.manage_pc;
      print(sys_param.ip_addr.manage_pc);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ip_addr.manage_pc = testData1s;
      print(sys_param.ip_addr.manage_pc);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ip_addr.manage_pc == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ip_addr.manage_pc == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ip_addr.manage_pc = testData2s;
      print(sys_param.ip_addr.manage_pc);
      expect(sys_param.ip_addr.manage_pc == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ip_addr.manage_pc == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ip_addr.manage_pc = defalut;
      print(sys_param.ip_addr.manage_pc);
      expect(sys_param.ip_addr.manage_pc == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ip_addr.manage_pc == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ip_addr.name;
      print(sys_param.ip_addr.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ip_addr.name = testData1s;
      print(sys_param.ip_addr.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ip_addr.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ip_addr.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ip_addr.name = testData2s;
      print(sys_param.ip_addr.name);
      expect(sys_param.ip_addr.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ip_addr.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ip_addr.name = defalut;
      print(sys_param.ip_addr.name);
      expect(sys_param.ip_addr.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ip_addr.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ip_addr.loginname;
      print(sys_param.ip_addr.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ip_addr.loginname = testData1s;
      print(sys_param.ip_addr.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ip_addr.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ip_addr.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ip_addr.loginname = testData2s;
      print(sys_param.ip_addr.loginname);
      expect(sys_param.ip_addr.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ip_addr.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ip_addr.loginname = defalut;
      print(sys_param.ip_addr.loginname);
      expect(sys_param.ip_addr.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ip_addr.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ip_addr.password;
      print(sys_param.ip_addr.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ip_addr.password = testData1s;
      print(sys_param.ip_addr.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ip_addr.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ip_addr.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ip_addr.password = testData2s;
      print(sys_param.ip_addr.password);
      expect(sys_param.ip_addr.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ip_addr.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ip_addr.password = defalut;
      print(sys_param.ip_addr.password);
      expect(sys_param.ip_addr.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ip_addr.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ip_addr.remotepath;
      print(sys_param.ip_addr.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ip_addr.remotepath = testData1s;
      print(sys_param.ip_addr.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ip_addr.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ip_addr.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ip_addr.remotepath = testData2s;
      print(sys_param.ip_addr.remotepath);
      expect(sys_param.ip_addr.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ip_addr.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ip_addr.remotepath = defalut;
      print(sys_param.ip_addr.remotepath);
      expect(sys_param.ip_addr.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ip_addr.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ip_addr.remotebmppath;
      print(sys_param.ip_addr.remotebmppath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ip_addr.remotebmppath = testData1s;
      print(sys_param.ip_addr.remotebmppath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ip_addr.remotebmppath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ip_addr.remotebmppath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ip_addr.remotebmppath = testData2s;
      print(sys_param.ip_addr.remotebmppath);
      expect(sys_param.ip_addr.remotebmppath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ip_addr.remotebmppath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ip_addr.remotebmppath = defalut;
      print(sys_param.ip_addr.remotebmppath);
      expect(sys_param.ip_addr.remotebmppath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ip_addr.remotebmppath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.mobile.name;
      print(sys_param.mobile.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.mobile.name = testData1s;
      print(sys_param.mobile.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.mobile.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.mobile.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.mobile.name = testData2s;
      print(sys_param.mobile.name);
      expect(sys_param.mobile.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mobile.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.mobile.name = defalut;
      print(sys_param.mobile.name);
      expect(sys_param.mobile.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mobile.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.mobile.loginname;
      print(sys_param.mobile.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.mobile.loginname = testData1s;
      print(sys_param.mobile.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.mobile.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.mobile.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.mobile.loginname = testData2s;
      print(sys_param.mobile.loginname);
      expect(sys_param.mobile.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mobile.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.mobile.loginname = defalut;
      print(sys_param.mobile.loginname);
      expect(sys_param.mobile.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mobile.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.mobile.password;
      print(sys_param.mobile.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.mobile.password = testData1s;
      print(sys_param.mobile.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.mobile.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.mobile.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.mobile.password = testData2s;
      print(sys_param.mobile.password);
      expect(sys_param.mobile.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mobile.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.mobile.password = defalut;
      print(sys_param.mobile.password);
      expect(sys_param.mobile.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mobile.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.mobile.remotepath;
      print(sys_param.mobile.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.mobile.remotepath = testData1s;
      print(sys_param.mobile.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.mobile.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.mobile.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.mobile.remotepath = testData2s;
      print(sys_param.mobile.remotepath);
      expect(sys_param.mobile.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mobile.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.mobile.remotepath = defalut;
      print(sys_param.mobile.remotepath);
      expect(sys_param.mobile.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mobile.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.poppy.name;
      print(sys_param.poppy.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.poppy.name = testData1s;
      print(sys_param.poppy.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.poppy.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.poppy.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.poppy.name = testData2s;
      print(sys_param.poppy.name);
      expect(sys_param.poppy.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.poppy.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.poppy.name = defalut;
      print(sys_param.poppy.name);
      expect(sys_param.poppy.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.poppy.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.poppy.loginname;
      print(sys_param.poppy.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.poppy.loginname = testData1s;
      print(sys_param.poppy.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.poppy.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.poppy.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.poppy.loginname = testData2s;
      print(sys_param.poppy.loginname);
      expect(sys_param.poppy.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.poppy.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.poppy.loginname = defalut;
      print(sys_param.poppy.loginname);
      expect(sys_param.poppy.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.poppy.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.poppy.password;
      print(sys_param.poppy.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.poppy.password = testData1s;
      print(sys_param.poppy.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.poppy.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.poppy.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.poppy.password = testData2s;
      print(sys_param.poppy.password);
      expect(sys_param.poppy.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.poppy.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.poppy.password = defalut;
      print(sys_param.poppy.password);
      expect(sys_param.poppy.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.poppy.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.poppy.remotepath;
      print(sys_param.poppy.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.poppy.remotepath = testData1s;
      print(sys_param.poppy.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.poppy.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.poppy.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.poppy.remotepath = testData2s;
      print(sys_param.poppy.remotepath);
      expect(sys_param.poppy.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.poppy.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.poppy.remotepath = defalut;
      print(sys_param.poppy.remotepath);
      expect(sys_param.poppy.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.poppy.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.mclog.name;
      print(sys_param.mclog.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.mclog.name = testData1s;
      print(sys_param.mclog.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.mclog.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.mclog.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.mclog.name = testData2s;
      print(sys_param.mclog.name);
      expect(sys_param.mclog.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mclog.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.mclog.name = defalut;
      print(sys_param.mclog.name);
      expect(sys_param.mclog.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mclog.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.mclog.loginname;
      print(sys_param.mclog.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.mclog.loginname = testData1s;
      print(sys_param.mclog.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.mclog.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.mclog.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.mclog.loginname = testData2s;
      print(sys_param.mclog.loginname);
      expect(sys_param.mclog.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mclog.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.mclog.loginname = defalut;
      print(sys_param.mclog.loginname);
      expect(sys_param.mclog.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mclog.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.mclog.password;
      print(sys_param.mclog.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.mclog.password = testData1s;
      print(sys_param.mclog.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.mclog.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.mclog.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.mclog.password = testData2s;
      print(sys_param.mclog.password);
      expect(sys_param.mclog.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mclog.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.mclog.password = defalut;
      print(sys_param.mclog.password);
      expect(sys_param.mclog.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mclog.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.mclog.remotepath;
      print(sys_param.mclog.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.mclog.remotepath = testData1s;
      print(sys_param.mclog.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.mclog.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.mclog.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.mclog.remotepath = testData2s;
      print(sys_param.mclog.remotepath);
      expect(sys_param.mclog.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mclog.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.mclog.remotepath = defalut;
      print(sys_param.mclog.remotepath);
      expect(sys_param.mclog.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.mclog.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.catalina.ca_ipaddr;
      print(sys_param.catalina.ca_ipaddr);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.catalina.ca_ipaddr = testData1s;
      print(sys_param.catalina.ca_ipaddr);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.catalina.ca_ipaddr == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.catalina.ca_ipaddr == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.catalina.ca_ipaddr = testData2s;
      print(sys_param.catalina.ca_ipaddr);
      expect(sys_param.catalina.ca_ipaddr == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.catalina.ca_ipaddr == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.catalina.ca_ipaddr = defalut;
      print(sys_param.catalina.ca_ipaddr);
      expect(sys_param.catalina.ca_ipaddr == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.catalina.ca_ipaddr == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.catalina.ca_port;
      print(sys_param.catalina.ca_port);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.catalina.ca_port = testData1s;
      print(sys_param.catalina.ca_port);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.catalina.ca_port == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.catalina.ca_port == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.catalina.ca_port = testData2s;
      print(sys_param.catalina.ca_port);
      expect(sys_param.catalina.ca_port == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.catalina.ca_port == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.catalina.ca_port = defalut;
      print(sys_param.catalina.ca_port);
      expect(sys_param.catalina.ca_port == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.catalina.ca_port == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custrealsvr.timeout;
      print(sys_param.custrealsvr.timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custrealsvr.timeout = testData1;
      print(sys_param.custrealsvr.timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custrealsvr.timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custrealsvr.timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custrealsvr.timeout = testData2;
      print(sys_param.custrealsvr.timeout);
      expect(sys_param.custrealsvr.timeout == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custrealsvr.timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custrealsvr.timeout = defalut;
      print(sys_param.custrealsvr.timeout);
      expect(sys_param.custrealsvr.timeout == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custrealsvr.timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custrealsvr.retrywaittime;
      print(sys_param.custrealsvr.retrywaittime);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custrealsvr.retrywaittime = testData1;
      print(sys_param.custrealsvr.retrywaittime);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custrealsvr.retrywaittime == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custrealsvr.retrywaittime == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custrealsvr.retrywaittime = testData2;
      print(sys_param.custrealsvr.retrywaittime);
      expect(sys_param.custrealsvr.retrywaittime == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custrealsvr.retrywaittime == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custrealsvr.retrywaittime = defalut;
      print(sys_param.custrealsvr.retrywaittime);
      expect(sys_param.custrealsvr.retrywaittime == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custrealsvr.retrywaittime == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custrealsvr.retrycnt;
      print(sys_param.custrealsvr.retrycnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custrealsvr.retrycnt = testData1;
      print(sys_param.custrealsvr.retrycnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custrealsvr.retrycnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custrealsvr.retrycnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custrealsvr.retrycnt = testData2;
      print(sys_param.custrealsvr.retrycnt);
      expect(sys_param.custrealsvr.retrycnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custrealsvr.retrycnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custrealsvr.retrycnt = defalut;
      print(sys_param.custrealsvr.retrycnt);
      expect(sys_param.custrealsvr.retrycnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custrealsvr.retrycnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custrealsvr.url;
      print(sys_param.custrealsvr.url);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custrealsvr.url = testData1s;
      print(sys_param.custrealsvr.url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custrealsvr.url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custrealsvr.url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custrealsvr.url = testData2s;
      print(sys_param.custrealsvr.url);
      expect(sys_param.custrealsvr.url == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custrealsvr.url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custrealsvr.url = defalut;
      print(sys_param.custrealsvr.url);
      expect(sys_param.custrealsvr.url == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custrealsvr.url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.testmode.cnt_max;
      print(sys_param.testmode.cnt_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.testmode.cnt_max = testData1;
      print(sys_param.testmode.cnt_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.testmode.cnt_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.testmode.cnt_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.testmode.cnt_max = testData2;
      print(sys_param.testmode.cnt_max);
      expect(sys_param.testmode.cnt_max == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.testmode.cnt_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.testmode.cnt_max = defalut;
      print(sys_param.testmode.cnt_max);
      expect(sys_param.testmode.cnt_max == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.testmode.cnt_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.landisk.name;
      print(sys_param.landisk.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.landisk.name = testData1s;
      print(sys_param.landisk.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.landisk.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.landisk.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.landisk.name = testData2s;
      print(sys_param.landisk.name);
      expect(sys_param.landisk.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.landisk.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.landisk.name = defalut;
      print(sys_param.landisk.name);
      expect(sys_param.landisk.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.landisk.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.landisk.loginname;
      print(sys_param.landisk.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.landisk.loginname = testData1s;
      print(sys_param.landisk.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.landisk.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.landisk.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.landisk.loginname = testData2s;
      print(sys_param.landisk.loginname);
      expect(sys_param.landisk.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.landisk.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.landisk.loginname = defalut;
      print(sys_param.landisk.loginname);
      expect(sys_param.landisk.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.landisk.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.landisk.password;
      print(sys_param.landisk.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.landisk.password = testData1s;
      print(sys_param.landisk.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.landisk.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.landisk.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.landisk.password = testData2s;
      print(sys_param.landisk.password);
      expect(sys_param.landisk.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.landisk.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.landisk.password = defalut;
      print(sys_param.landisk.password);
      expect(sys_param.landisk.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.landisk.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.landisk.remotepath;
      print(sys_param.landisk.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.landisk.remotepath = testData1s;
      print(sys_param.landisk.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.landisk.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.landisk.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.landisk.remotepath = testData2s;
      print(sys_param.landisk.remotepath);
      expect(sys_param.landisk.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.landisk.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.landisk.remotepath = defalut;
      print(sys_param.landisk.remotepath);
      expect(sys_param.landisk.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.landisk.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq2.name;
      print(sys_param.hq2.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq2.name = testData1s;
      print(sys_param.hq2.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq2.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq2.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq2.name = testData2s;
      print(sys_param.hq2.name);
      expect(sys_param.hq2.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq2.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq2.name = defalut;
      print(sys_param.hq2.name);
      expect(sys_param.hq2.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq2.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq2.loginname;
      print(sys_param.hq2.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq2.loginname = testData1s;
      print(sys_param.hq2.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq2.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq2.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq2.loginname = testData2s;
      print(sys_param.hq2.loginname);
      expect(sys_param.hq2.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq2.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq2.loginname = defalut;
      print(sys_param.hq2.loginname);
      expect(sys_param.hq2.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq2.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq2.password;
      print(sys_param.hq2.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq2.password = testData1s;
      print(sys_param.hq2.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq2.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq2.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq2.password = testData2s;
      print(sys_param.hq2.password);
      expect(sys_param.hq2.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq2.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq2.password = defalut;
      print(sys_param.hq2.password);
      expect(sys_param.hq2.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq2.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq2.remotepath;
      print(sys_param.hq2.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq2.remotepath = testData1s;
      print(sys_param.hq2.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq2.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq2.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq2.remotepath = testData2s;
      print(sys_param.hq2.remotepath);
      expect(sys_param.hq2.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq2.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq2.remotepath = defalut;
      print(sys_param.hq2.remotepath);
      expect(sys_param.hq2.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq2.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq2.remotepath_rcv;
      print(sys_param.hq2.remotepath_rcv);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq2.remotepath_rcv = testData1s;
      print(sys_param.hq2.remotepath_rcv);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq2.remotepath_rcv == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq2.remotepath_rcv == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq2.remotepath_rcv = testData2s;
      print(sys_param.hq2.remotepath_rcv);
      expect(sys_param.hq2.remotepath_rcv == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq2.remotepath_rcv == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq2.remotepath_rcv = defalut;
      print(sys_param.hq2.remotepath_rcv);
      expect(sys_param.hq2.remotepath_rcv == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq2.remotepath_rcv == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq2.hostname;
      print(sys_param.hq2.hostname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq2.hostname = testData1s;
      print(sys_param.hq2.hostname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq2.hostname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq2.hostname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq2.hostname = testData2s;
      print(sys_param.hq2.hostname);
      expect(sys_param.hq2.hostname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq2.hostname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq2.hostname = defalut;
      print(sys_param.hq2.hostname);
      expect(sys_param.hq2.hostname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq2.hostname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hqimg.name;
      print(sys_param.hqimg.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hqimg.name = testData1s;
      print(sys_param.hqimg.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hqimg.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hqimg.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hqimg.name = testData2s;
      print(sys_param.hqimg.name);
      expect(sys_param.hqimg.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hqimg.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hqimg.name = defalut;
      print(sys_param.hqimg.name);
      expect(sys_param.hqimg.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hqimg.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hqimg.loginname;
      print(sys_param.hqimg.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hqimg.loginname = testData1s;
      print(sys_param.hqimg.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hqimg.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hqimg.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hqimg.loginname = testData2s;
      print(sys_param.hqimg.loginname);
      expect(sys_param.hqimg.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hqimg.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hqimg.loginname = defalut;
      print(sys_param.hqimg.loginname);
      expect(sys_param.hqimg.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hqimg.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hqimg.password;
      print(sys_param.hqimg.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hqimg.password = testData1s;
      print(sys_param.hqimg.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hqimg.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hqimg.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hqimg.password = testData2s;
      print(sys_param.hqimg.password);
      expect(sys_param.hqimg.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hqimg.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hqimg.password = defalut;
      print(sys_param.hqimg.password);
      expect(sys_param.hqimg.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hqimg.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hqimg.remotepath;
      print(sys_param.hqimg.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hqimg.remotepath = testData1s;
      print(sys_param.hqimg.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hqimg.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hqimg.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hqimg.remotepath = testData2s;
      print(sys_param.hqimg.remotepath);
      expect(sys_param.hqimg.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hqimg.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hqimg.remotepath = defalut;
      print(sys_param.hqimg.remotepath);
      expect(sys_param.hqimg.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hqimg.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.name;
      print(sys_param.sims2100.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.name = testData1s;
      print(sys_param.sims2100.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.name = testData2s;
      print(sys_param.sims2100.name);
      expect(sys_param.sims2100.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.name = defalut;
      print(sys_param.sims2100.name);
      expect(sys_param.sims2100.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.loginname;
      print(sys_param.sims2100.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.loginname = testData1s;
      print(sys_param.sims2100.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.loginname = testData2s;
      print(sys_param.sims2100.loginname);
      expect(sys_param.sims2100.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.loginname = defalut;
      print(sys_param.sims2100.loginname);
      expect(sys_param.sims2100.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.password;
      print(sys_param.sims2100.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.password = testData1s;
      print(sys_param.sims2100.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.password = testData2s;
      print(sys_param.sims2100.password);
      expect(sys_param.sims2100.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.password = defalut;
      print(sys_param.sims2100.password);
      expect(sys_param.sims2100.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

    test('00138_element_check_00115', () async {
      print("\n********** テスト実行：00138_element_check_00115 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.remotepath_xpm;
      print(sys_param.sims2100.remotepath_xpm);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.remotepath_xpm = testData1s;
      print(sys_param.sims2100.remotepath_xpm);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.remotepath_xpm == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.remotepath_xpm == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.remotepath_xpm = testData2s;
      print(sys_param.sims2100.remotepath_xpm);
      expect(sys_param.sims2100.remotepath_xpm == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_xpm == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.remotepath_xpm = defalut;
      print(sys_param.sims2100.remotepath_xpm);
      expect(sys_param.sims2100.remotepath_xpm == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_xpm == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00138_element_check_00115 **********\n\n");
    });

    test('00139_element_check_00116', () async {
      print("\n********** テスト実行：00139_element_check_00116 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.remotepath_ssps;
      print(sys_param.sims2100.remotepath_ssps);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.remotepath_ssps = testData1s;
      print(sys_param.sims2100.remotepath_ssps);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.remotepath_ssps == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.remotepath_ssps == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.remotepath_ssps = testData2s;
      print(sys_param.sims2100.remotepath_ssps);
      expect(sys_param.sims2100.remotepath_ssps == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_ssps == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.remotepath_ssps = defalut;
      print(sys_param.sims2100.remotepath_ssps);
      expect(sys_param.sims2100.remotepath_ssps == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_ssps == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00139_element_check_00116 **********\n\n");
    });

    test('00140_element_check_00117', () async {
      print("\n********** テスト実行：00140_element_check_00117 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.remotepath_acx;
      print(sys_param.sims2100.remotepath_acx);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.remotepath_acx = testData1s;
      print(sys_param.sims2100.remotepath_acx);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.remotepath_acx == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.remotepath_acx == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.remotepath_acx = testData2s;
      print(sys_param.sims2100.remotepath_acx);
      expect(sys_param.sims2100.remotepath_acx == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_acx == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.remotepath_acx = defalut;
      print(sys_param.sims2100.remotepath_acx);
      expect(sys_param.sims2100.remotepath_acx == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_acx == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00140_element_check_00117 **********\n\n");
    });

    test('00141_element_check_00118', () async {
      print("\n********** テスト実行：00141_element_check_00118 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.remotepath_bmp;
      print(sys_param.sims2100.remotepath_bmp);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.remotepath_bmp = testData1s;
      print(sys_param.sims2100.remotepath_bmp);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.remotepath_bmp == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.remotepath_bmp == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.remotepath_bmp = testData2s;
      print(sys_param.sims2100.remotepath_bmp);
      expect(sys_param.sims2100.remotepath_bmp == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_bmp == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.remotepath_bmp = defalut;
      print(sys_param.sims2100.remotepath_bmp);
      expect(sys_param.sims2100.remotepath_bmp == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_bmp == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00141_element_check_00118 **********\n\n");
    });

    test('00142_element_check_00119', () async {
      print("\n********** テスト実行：00142_element_check_00119 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.remotepath_cpy;
      print(sys_param.sims2100.remotepath_cpy);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.remotepath_cpy = testData1s;
      print(sys_param.sims2100.remotepath_cpy);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.remotepath_cpy == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.remotepath_cpy == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.remotepath_cpy = testData2s;
      print(sys_param.sims2100.remotepath_cpy);
      expect(sys_param.sims2100.remotepath_cpy == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_cpy == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.remotepath_cpy = defalut;
      print(sys_param.sims2100.remotepath_cpy);
      expect(sys_param.sims2100.remotepath_cpy == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_cpy == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00142_element_check_00119 **********\n\n");
    });

    test('00143_element_check_00120', () async {
      print("\n********** テスト実行：00143_element_check_00120 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.remotepath_tmp;
      print(sys_param.sims2100.remotepath_tmp);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.remotepath_tmp = testData1s;
      print(sys_param.sims2100.remotepath_tmp);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.remotepath_tmp == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.remotepath_tmp == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.remotepath_tmp = testData2s;
      print(sys_param.sims2100.remotepath_tmp);
      expect(sys_param.sims2100.remotepath_tmp == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_tmp == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.remotepath_tmp = defalut;
      print(sys_param.sims2100.remotepath_tmp);
      expect(sys_param.sims2100.remotepath_tmp == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_tmp == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00143_element_check_00120 **********\n\n");
    });

    test('00144_element_check_00121', () async {
      print("\n********** テスト実行：00144_element_check_00121 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.remotepath_webapi;
      print(sys_param.sims2100.remotepath_webapi);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.remotepath_webapi = testData1s;
      print(sys_param.sims2100.remotepath_webapi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.remotepath_webapi == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.remotepath_webapi == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.remotepath_webapi = testData2s;
      print(sys_param.sims2100.remotepath_webapi);
      expect(sys_param.sims2100.remotepath_webapi == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_webapi == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.remotepath_webapi = defalut;
      print(sys_param.sims2100.remotepath_webapi);
      expect(sys_param.sims2100.remotepath_webapi == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.remotepath_webapi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00144_element_check_00121 **********\n\n");
    });

    test('00145_element_check_00122', () async {
      print("\n********** テスト実行：00145_element_check_00122 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.res_cycle;
      print(sys_param.sims2100.res_cycle);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.res_cycle = testData1;
      print(sys_param.sims2100.res_cycle);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.res_cycle == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.res_cycle == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.res_cycle = testData2;
      print(sys_param.sims2100.res_cycle);
      expect(sys_param.sims2100.res_cycle == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.res_cycle == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.res_cycle = defalut;
      print(sys_param.sims2100.res_cycle);
      expect(sys_param.sims2100.res_cycle == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.res_cycle == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00145_element_check_00122 **********\n\n");
    });

    test('00146_element_check_00123', () async {
      print("\n********** テスト実行：00146_element_check_00123 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.ftp_retry_cnt;
      print(sys_param.sims2100.ftp_retry_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.ftp_retry_cnt = testData1;
      print(sys_param.sims2100.ftp_retry_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.ftp_retry_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.ftp_retry_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.ftp_retry_cnt = testData2;
      print(sys_param.sims2100.ftp_retry_cnt);
      expect(sys_param.sims2100.ftp_retry_cnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.ftp_retry_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.ftp_retry_cnt = defalut;
      print(sys_param.sims2100.ftp_retry_cnt);
      expect(sys_param.sims2100.ftp_retry_cnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.ftp_retry_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00146_element_check_00123 **********\n\n");
    });

    test('00147_element_check_00124', () async {
      print("\n********** テスト実行：00147_element_check_00124 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.sims2100.ftp_retry_time;
      print(sys_param.sims2100.ftp_retry_time);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.sims2100.ftp_retry_time = testData1;
      print(sys_param.sims2100.ftp_retry_time);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.sims2100.ftp_retry_time == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.sims2100.ftp_retry_time == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.sims2100.ftp_retry_time = testData2;
      print(sys_param.sims2100.ftp_retry_time);
      expect(sys_param.sims2100.ftp_retry_time == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.ftp_retry_time == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.sims2100.ftp_retry_time = defalut;
      print(sys_param.sims2100.ftp_retry_time);
      expect(sys_param.sims2100.ftp_retry_time == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.sims2100.ftp_retry_time == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00147_element_check_00124 **********\n\n");
    });

    test('00148_element_check_00125', () async {
      print("\n********** テスト実行：00148_element_check_00125 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.https_host.https;
      print(sys_param.https_host.https);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.https_host.https = testData1s;
      print(sys_param.https_host.https);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.https_host.https == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.https_host.https == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.https_host.https = testData2s;
      print(sys_param.https_host.https);
      expect(sys_param.https_host.https == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.https_host.https == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.https_host.https = defalut;
      print(sys_param.https_host.https);
      expect(sys_param.https_host.https == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.https_host.https == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00148_element_check_00125 **********\n\n");
    });

    test('00149_element_check_00126', () async {
      print("\n********** テスト実行：00149_element_check_00126 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.https_host.http;
      print(sys_param.https_host.http);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.https_host.http = testData1s;
      print(sys_param.https_host.http);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.https_host.http == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.https_host.http == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.https_host.http = testData2s;
      print(sys_param.https_host.http);
      expect(sys_param.https_host.http == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.https_host.http == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.https_host.http = defalut;
      print(sys_param.https_host.http);
      expect(sys_param.https_host.http == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.https_host.http == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00149_element_check_00126 **********\n\n");
    });

    test('00150_element_check_00127', () async {
      print("\n********** テスト実行：00150_element_check_00127 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.https_host.proxy;
      print(sys_param.https_host.proxy);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.https_host.proxy = testData1s;
      print(sys_param.https_host.proxy);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.https_host.proxy == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.https_host.proxy == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.https_host.proxy = testData2s;
      print(sys_param.https_host.proxy);
      expect(sys_param.https_host.proxy == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.https_host.proxy == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.https_host.proxy = defalut;
      print(sys_param.https_host.proxy);
      expect(sys_param.https_host.proxy == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.https_host.proxy == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00150_element_check_00127 **********\n\n");
    });

    test('00151_element_check_00128', () async {
      print("\n********** テスト実行：00151_element_check_00128 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.https_host.port;
      print(sys_param.https_host.port);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.https_host.port = testData1;
      print(sys_param.https_host.port);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.https_host.port == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.https_host.port == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.https_host.port = testData2;
      print(sys_param.https_host.port);
      expect(sys_param.https_host.port == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.https_host.port == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.https_host.port = defalut;
      print(sys_param.https_host.port);
      expect(sys_param.https_host.port == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.https_host.port == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00151_element_check_00128 **********\n\n");
    });

    test('00152_element_check_00129', () async {
      print("\n********** テスト実行：00152_element_check_00129 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.https_host.timeout;
      print(sys_param.https_host.timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.https_host.timeout = testData1;
      print(sys_param.https_host.timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.https_host.timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.https_host.timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.https_host.timeout = testData2;
      print(sys_param.https_host.timeout);
      expect(sys_param.https_host.timeout == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.https_host.timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.https_host.timeout = defalut;
      print(sys_param.https_host.timeout);
      expect(sys_param.https_host.timeout == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.https_host.timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00152_element_check_00129 **********\n\n");
    });

    test('00153_element_check_00130', () async {
      print("\n********** テスト実行：00153_element_check_00130 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.nttb_host.https;
      print(sys_param.nttb_host.https);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.nttb_host.https = testData1s;
      print(sys_param.nttb_host.https);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.nttb_host.https == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.nttb_host.https == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.nttb_host.https = testData2s;
      print(sys_param.nttb_host.https);
      expect(sys_param.nttb_host.https == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.nttb_host.https == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.nttb_host.https = defalut;
      print(sys_param.nttb_host.https);
      expect(sys_param.nttb_host.https == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.nttb_host.https == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00153_element_check_00130 **********\n\n");
    });

    test('00154_element_check_00131', () async {
      print("\n********** テスト実行：00154_element_check_00131 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.nttb_host.http;
      print(sys_param.nttb_host.http);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.nttb_host.http = testData1s;
      print(sys_param.nttb_host.http);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.nttb_host.http == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.nttb_host.http == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.nttb_host.http = testData2s;
      print(sys_param.nttb_host.http);
      expect(sys_param.nttb_host.http == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.nttb_host.http == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.nttb_host.http = defalut;
      print(sys_param.nttb_host.http);
      expect(sys_param.nttb_host.http == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.nttb_host.http == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00154_element_check_00131 **********\n\n");
    });

    test('00155_element_check_00132', () async {
      print("\n********** テスト実行：00155_element_check_00132 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custsvr2.hbtime;
      print(sys_param.custsvr2.hbtime);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custsvr2.hbtime = testData1;
      print(sys_param.custsvr2.hbtime);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custsvr2.hbtime == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custsvr2.hbtime == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custsvr2.hbtime = testData2;
      print(sys_param.custsvr2.hbtime);
      expect(sys_param.custsvr2.hbtime == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custsvr2.hbtime == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custsvr2.hbtime = defalut;
      print(sys_param.custsvr2.hbtime);
      expect(sys_param.custsvr2.hbtime == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custsvr2.hbtime == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00155_element_check_00132 **********\n\n");
    });

    test('00156_element_check_00133', () async {
      print("\n********** テスト実行：00156_element_check_00133 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custsvr2.offlinetime;
      print(sys_param.custsvr2.offlinetime);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custsvr2.offlinetime = testData1;
      print(sys_param.custsvr2.offlinetime);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custsvr2.offlinetime == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custsvr2.offlinetime == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custsvr2.offlinetime = testData2;
      print(sys_param.custsvr2.offlinetime);
      expect(sys_param.custsvr2.offlinetime == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custsvr2.offlinetime == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custsvr2.offlinetime = defalut;
      print(sys_param.custsvr2.offlinetime);
      expect(sys_param.custsvr2.offlinetime == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custsvr2.offlinetime == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00156_element_check_00133 **********\n\n");
    });

    test('00157_element_check_00134', () async {
      print("\n********** テスト実行：00157_element_check_00134 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.proxy.address;
      print(sys_param.proxy.address);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.proxy.address = testData1s;
      print(sys_param.proxy.address);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.proxy.address == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.proxy.address == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.proxy.address = testData2s;
      print(sys_param.proxy.address);
      expect(sys_param.proxy.address == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.proxy.address == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.proxy.address = defalut;
      print(sys_param.proxy.address);
      expect(sys_param.proxy.address == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.proxy.address == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00157_element_check_00134 **********\n\n");
    });

    test('00158_element_check_00135', () async {
      print("\n********** テスト実行：00158_element_check_00135 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.proxy.port;
      print(sys_param.proxy.port);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.proxy.port = testData1s;
      print(sys_param.proxy.port);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.proxy.port == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.proxy.port == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.proxy.port = testData2s;
      print(sys_param.proxy.port);
      expect(sys_param.proxy.port == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.proxy.port == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.proxy.port = defalut;
      print(sys_param.proxy.port);
      expect(sys_param.proxy.port == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.proxy.port == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00158_element_check_00135 **********\n\n");
    });

    test('00159_element_check_00136', () async {
      print("\n********** テスト実行：00159_element_check_00136 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hist_ftp.timeout;
      print(sys_param.hist_ftp.timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hist_ftp.timeout = testData1;
      print(sys_param.hist_ftp.timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hist_ftp.timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hist_ftp.timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hist_ftp.timeout = testData2;
      print(sys_param.hist_ftp.timeout);
      expect(sys_param.hist_ftp.timeout == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hist_ftp.timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hist_ftp.timeout = defalut;
      print(sys_param.hist_ftp.timeout);
      expect(sys_param.hist_ftp.timeout == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hist_ftp.timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00159_element_check_00136 **********\n\n");
    });

    test('00160_element_check_00137', () async {
      print("\n********** テスト実行：00160_element_check_00137 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hist_ftp.retrycnt;
      print(sys_param.hist_ftp.retrycnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hist_ftp.retrycnt = testData1;
      print(sys_param.hist_ftp.retrycnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hist_ftp.retrycnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hist_ftp.retrycnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hist_ftp.retrycnt = testData2;
      print(sys_param.hist_ftp.retrycnt);
      expect(sys_param.hist_ftp.retrycnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hist_ftp.retrycnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hist_ftp.retrycnt = defalut;
      print(sys_param.hist_ftp.retrycnt);
      expect(sys_param.hist_ftp.retrycnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hist_ftp.retrycnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00160_element_check_00137 **********\n\n");
    });

    test('00161_element_check_00138', () async {
      print("\n********** テスト実行：00161_element_check_00138 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ftp_time.freq_timeout;
      print(sys_param.ftp_time.freq_timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ftp_time.freq_timeout = testData1;
      print(sys_param.ftp_time.freq_timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ftp_time.freq_timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ftp_time.freq_timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ftp_time.freq_timeout = testData2;
      print(sys_param.ftp_time.freq_timeout);
      expect(sys_param.ftp_time.freq_timeout == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ftp_time.freq_timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ftp_time.freq_timeout = defalut;
      print(sys_param.ftp_time.freq_timeout);
      expect(sys_param.ftp_time.freq_timeout == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ftp_time.freq_timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00161_element_check_00138 **********\n\n");
    });

    test('00162_element_check_00139', () async {
      print("\n********** テスト実行：00162_element_check_00139 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ftp_time.freq_retrycnt;
      print(sys_param.ftp_time.freq_retrycnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ftp_time.freq_retrycnt = testData1;
      print(sys_param.ftp_time.freq_retrycnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ftp_time.freq_retrycnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ftp_time.freq_retrycnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ftp_time.freq_retrycnt = testData2;
      print(sys_param.ftp_time.freq_retrycnt);
      expect(sys_param.ftp_time.freq_retrycnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ftp_time.freq_retrycnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ftp_time.freq_retrycnt = defalut;
      print(sys_param.ftp_time.freq_retrycnt);
      expect(sys_param.ftp_time.freq_retrycnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ftp_time.freq_retrycnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00162_element_check_00139 **********\n\n");
    });

    test('00163_element_check_00140', () async {
      print("\n********** テスト実行：00163_element_check_00140 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.movie_server.name;
      print(sys_param.movie_server.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.movie_server.name = testData1s;
      print(sys_param.movie_server.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.movie_server.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.movie_server.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.movie_server.name = testData2s;
      print(sys_param.movie_server.name);
      expect(sys_param.movie_server.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.movie_server.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.movie_server.name = defalut;
      print(sys_param.movie_server.name);
      expect(sys_param.movie_server.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.movie_server.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00163_element_check_00140 **********\n\n");
    });

    test('00164_element_check_00141', () async {
      print("\n********** テスト実行：00164_element_check_00141 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.movie_server.loginname;
      print(sys_param.movie_server.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.movie_server.loginname = testData1s;
      print(sys_param.movie_server.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.movie_server.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.movie_server.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.movie_server.loginname = testData2s;
      print(sys_param.movie_server.loginname);
      expect(sys_param.movie_server.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.movie_server.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.movie_server.loginname = defalut;
      print(sys_param.movie_server.loginname);
      expect(sys_param.movie_server.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.movie_server.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00164_element_check_00141 **********\n\n");
    });

    test('00165_element_check_00142', () async {
      print("\n********** テスト実行：00165_element_check_00142 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.movie_server.password;
      print(sys_param.movie_server.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.movie_server.password = testData1s;
      print(sys_param.movie_server.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.movie_server.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.movie_server.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.movie_server.password = testData2s;
      print(sys_param.movie_server.password);
      expect(sys_param.movie_server.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.movie_server.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.movie_server.password = defalut;
      print(sys_param.movie_server.password);
      expect(sys_param.movie_server.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.movie_server.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00165_element_check_00142 **********\n\n");
    });

    test('00166_element_check_00143', () async {
      print("\n********** テスト実行：00166_element_check_00143 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.movie_server.remotepath;
      print(sys_param.movie_server.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.movie_server.remotepath = testData1s;
      print(sys_param.movie_server.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.movie_server.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.movie_server.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.movie_server.remotepath = testData2s;
      print(sys_param.movie_server.remotepath);
      expect(sys_param.movie_server.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.movie_server.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.movie_server.remotepath = defalut;
      print(sys_param.movie_server.remotepath);
      expect(sys_param.movie_server.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.movie_server.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00166_element_check_00143 **********\n\n");
    });

    test('00167_element_check_00144', () async {
      print("\n********** テスト実行：00167_element_check_00144 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq_2nd.name;
      print(sys_param.hq_2nd.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq_2nd.name = testData1s;
      print(sys_param.hq_2nd.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq_2nd.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq_2nd.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq_2nd.name = testData2s;
      print(sys_param.hq_2nd.name);
      expect(sys_param.hq_2nd.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq_2nd.name = defalut;
      print(sys_param.hq_2nd.name);
      expect(sys_param.hq_2nd.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00167_element_check_00144 **********\n\n");
    });

    test('00168_element_check_00145', () async {
      print("\n********** テスト実行：00168_element_check_00145 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq_2nd.loginname;
      print(sys_param.hq_2nd.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq_2nd.loginname = testData1s;
      print(sys_param.hq_2nd.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq_2nd.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq_2nd.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq_2nd.loginname = testData2s;
      print(sys_param.hq_2nd.loginname);
      expect(sys_param.hq_2nd.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq_2nd.loginname = defalut;
      print(sys_param.hq_2nd.loginname);
      expect(sys_param.hq_2nd.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00168_element_check_00145 **********\n\n");
    });

    test('00169_element_check_00146', () async {
      print("\n********** テスト実行：00169_element_check_00146 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq_2nd.password;
      print(sys_param.hq_2nd.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq_2nd.password = testData1s;
      print(sys_param.hq_2nd.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq_2nd.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq_2nd.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq_2nd.password = testData2s;
      print(sys_param.hq_2nd.password);
      expect(sys_param.hq_2nd.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq_2nd.password = defalut;
      print(sys_param.hq_2nd.password);
      expect(sys_param.hq_2nd.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00169_element_check_00146 **********\n\n");
    });

    test('00170_element_check_00147', () async {
      print("\n********** テスト実行：00170_element_check_00147 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq_2nd.remotepath;
      print(sys_param.hq_2nd.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq_2nd.remotepath = testData1s;
      print(sys_param.hq_2nd.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq_2nd.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq_2nd.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq_2nd.remotepath = testData2s;
      print(sys_param.hq_2nd.remotepath);
      expect(sys_param.hq_2nd.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq_2nd.remotepath = defalut;
      print(sys_param.hq_2nd.remotepath);
      expect(sys_param.hq_2nd.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00170_element_check_00147 **********\n\n");
    });

    test('00171_element_check_00148', () async {
      print("\n********** テスト実行：00171_element_check_00148 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq_2nd.remotepath_rcv;
      print(sys_param.hq_2nd.remotepath_rcv);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq_2nd.remotepath_rcv = testData1s;
      print(sys_param.hq_2nd.remotepath_rcv);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq_2nd.remotepath_rcv == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq_2nd.remotepath_rcv == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq_2nd.remotepath_rcv = testData2s;
      print(sys_param.hq_2nd.remotepath_rcv);
      expect(sys_param.hq_2nd.remotepath_rcv == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.remotepath_rcv == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq_2nd.remotepath_rcv = defalut;
      print(sys_param.hq_2nd.remotepath_rcv);
      expect(sys_param.hq_2nd.remotepath_rcv == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.remotepath_rcv == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00171_element_check_00148 **********\n\n");
    });

    test('00172_element_check_00149', () async {
      print("\n********** テスト実行：00172_element_check_00149 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq_2nd.ftp_port;
      print(sys_param.hq_2nd.ftp_port);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq_2nd.ftp_port = testData1;
      print(sys_param.hq_2nd.ftp_port);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq_2nd.ftp_port == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq_2nd.ftp_port == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq_2nd.ftp_port = testData2;
      print(sys_param.hq_2nd.ftp_port);
      expect(sys_param.hq_2nd.ftp_port == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.ftp_port == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq_2nd.ftp_port = defalut;
      print(sys_param.hq_2nd.ftp_port);
      expect(sys_param.hq_2nd.ftp_port == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.ftp_port == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00172_element_check_00149 **********\n\n");
    });

    test('00173_element_check_00150', () async {
      print("\n********** テスト実行：00173_element_check_00150 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq_2nd.ftp_protocol;
      print(sys_param.hq_2nd.ftp_protocol);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq_2nd.ftp_protocol = testData1;
      print(sys_param.hq_2nd.ftp_protocol);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq_2nd.ftp_protocol == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq_2nd.ftp_protocol == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq_2nd.ftp_protocol = testData2;
      print(sys_param.hq_2nd.ftp_protocol);
      expect(sys_param.hq_2nd.ftp_protocol == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.ftp_protocol == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq_2nd.ftp_protocol = defalut;
      print(sys_param.hq_2nd.ftp_protocol);
      expect(sys_param.hq_2nd.ftp_protocol == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.ftp_protocol == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00173_element_check_00150 **********\n\n");
    });

    test('00174_element_check_00151', () async {
      print("\n********** テスト実行：00174_element_check_00151 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq_2nd.ftp_pasv;
      print(sys_param.hq_2nd.ftp_pasv);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq_2nd.ftp_pasv = testData1;
      print(sys_param.hq_2nd.ftp_pasv);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq_2nd.ftp_pasv == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq_2nd.ftp_pasv == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq_2nd.ftp_pasv = testData2;
      print(sys_param.hq_2nd.ftp_pasv);
      expect(sys_param.hq_2nd.ftp_pasv == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.ftp_pasv == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq_2nd.ftp_pasv = defalut;
      print(sys_param.hq_2nd.ftp_pasv);
      expect(sys_param.hq_2nd.ftp_pasv == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.ftp_pasv == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00174_element_check_00151 **********\n\n");
    });

    test('00175_element_check_00152', () async {
      print("\n********** テスト実行：00175_element_check_00152 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq_2nd.ftp_timeout;
      print(sys_param.hq_2nd.ftp_timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq_2nd.ftp_timeout = testData1;
      print(sys_param.hq_2nd.ftp_timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq_2nd.ftp_timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq_2nd.ftp_timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq_2nd.ftp_timeout = testData2;
      print(sys_param.hq_2nd.ftp_timeout);
      expect(sys_param.hq_2nd.ftp_timeout == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.ftp_timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq_2nd.ftp_timeout = defalut;
      print(sys_param.hq_2nd.ftp_timeout);
      expect(sys_param.hq_2nd.ftp_timeout == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.ftp_timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00175_element_check_00152 **********\n\n");
    });

    test('00176_element_check_00153', () async {
      print("\n********** テスト実行：00176_element_check_00153 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq_2nd.ftp_retrycnt;
      print(sys_param.hq_2nd.ftp_retrycnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq_2nd.ftp_retrycnt = testData1;
      print(sys_param.hq_2nd.ftp_retrycnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq_2nd.ftp_retrycnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq_2nd.ftp_retrycnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq_2nd.ftp_retrycnt = testData2;
      print(sys_param.hq_2nd.ftp_retrycnt);
      expect(sys_param.hq_2nd.ftp_retrycnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.ftp_retrycnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq_2nd.ftp_retrycnt = defalut;
      print(sys_param.hq_2nd.ftp_retrycnt);
      expect(sys_param.hq_2nd.ftp_retrycnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.ftp_retrycnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00176_element_check_00153 **********\n\n");
    });

    test('00177_element_check_00154', () async {
      print("\n********** テスト実行：00177_element_check_00154 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.hq_2nd.ftp_retrywait;
      print(sys_param.hq_2nd.ftp_retrywait);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.hq_2nd.ftp_retrywait = testData1;
      print(sys_param.hq_2nd.ftp_retrywait);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.hq_2nd.ftp_retrywait == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.hq_2nd.ftp_retrywait == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.hq_2nd.ftp_retrywait = testData2;
      print(sys_param.hq_2nd.ftp_retrywait);
      expect(sys_param.hq_2nd.ftp_retrywait == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.ftp_retrywait == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.hq_2nd.ftp_retrywait = defalut;
      print(sys_param.hq_2nd.ftp_retrywait);
      expect(sys_param.hq_2nd.ftp_retrywait == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.hq_2nd.ftp_retrywait == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00177_element_check_00154 **********\n\n");
    });

    test('00178_element_check_00155', () async {
      print("\n********** テスト実行：00178_element_check_00155 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.verup_cnct.name;
      print(sys_param.verup_cnct.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.verup_cnct.name = testData1s;
      print(sys_param.verup_cnct.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.verup_cnct.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.verup_cnct.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.verup_cnct.name = testData2s;
      print(sys_param.verup_cnct.name);
      expect(sys_param.verup_cnct.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.verup_cnct.name = defalut;
      print(sys_param.verup_cnct.name);
      expect(sys_param.verup_cnct.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00178_element_check_00155 **********\n\n");
    });

    test('00179_element_check_00156', () async {
      print("\n********** テスト実行：00179_element_check_00156 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.verup_cnct.loginname;
      print(sys_param.verup_cnct.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.verup_cnct.loginname = testData1s;
      print(sys_param.verup_cnct.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.verup_cnct.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.verup_cnct.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.verup_cnct.loginname = testData2s;
      print(sys_param.verup_cnct.loginname);
      expect(sys_param.verup_cnct.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.verup_cnct.loginname = defalut;
      print(sys_param.verup_cnct.loginname);
      expect(sys_param.verup_cnct.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00179_element_check_00156 **********\n\n");
    });

    test('00180_element_check_00157', () async {
      print("\n********** テスト実行：00180_element_check_00157 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.verup_cnct.password;
      print(sys_param.verup_cnct.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.verup_cnct.password = testData1s;
      print(sys_param.verup_cnct.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.verup_cnct.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.verup_cnct.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.verup_cnct.password = testData2s;
      print(sys_param.verup_cnct.password);
      expect(sys_param.verup_cnct.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.verup_cnct.password = defalut;
      print(sys_param.verup_cnct.password);
      expect(sys_param.verup_cnct.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00180_element_check_00157 **********\n\n");
    });

    test('00181_element_check_00158', () async {
      print("\n********** テスト実行：00181_element_check_00158 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.verup_cnct.prggetpath;
      print(sys_param.verup_cnct.prggetpath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.verup_cnct.prggetpath = testData1s;
      print(sys_param.verup_cnct.prggetpath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.verup_cnct.prggetpath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.verup_cnct.prggetpath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.verup_cnct.prggetpath = testData2s;
      print(sys_param.verup_cnct.prggetpath);
      expect(sys_param.verup_cnct.prggetpath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.prggetpath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.verup_cnct.prggetpath = defalut;
      print(sys_param.verup_cnct.prggetpath);
      expect(sys_param.verup_cnct.prggetpath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.prggetpath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00181_element_check_00158 **********\n\n");
    });

    test('00182_element_check_00159', () async {
      print("\n********** テスト実行：00182_element_check_00159 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.verup_cnct.remotepath;
      print(sys_param.verup_cnct.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.verup_cnct.remotepath = testData1s;
      print(sys_param.verup_cnct.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.verup_cnct.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.verup_cnct.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.verup_cnct.remotepath = testData2s;
      print(sys_param.verup_cnct.remotepath);
      expect(sys_param.verup_cnct.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.verup_cnct.remotepath = defalut;
      print(sys_param.verup_cnct.remotepath);
      expect(sys_param.verup_cnct.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00182_element_check_00159 **********\n\n");
    });

    test('00183_element_check_00160', () async {
      print("\n********** テスト実行：00183_element_check_00160 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.verup_cnct.remoteverpath;
      print(sys_param.verup_cnct.remoteverpath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.verup_cnct.remoteverpath = testData1s;
      print(sys_param.verup_cnct.remoteverpath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.verup_cnct.remoteverpath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.verup_cnct.remoteverpath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.verup_cnct.remoteverpath = testData2s;
      print(sys_param.verup_cnct.remoteverpath);
      expect(sys_param.verup_cnct.remoteverpath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.remoteverpath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.verup_cnct.remoteverpath = defalut;
      print(sys_param.verup_cnct.remoteverpath);
      expect(sys_param.verup_cnct.remoteverpath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.remoteverpath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00183_element_check_00160 **********\n\n");
    });

    test('00184_element_check_00161', () async {
      print("\n********** テスト実行：00184_element_check_00161 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.verup_cnct.verupstsputpath;
      print(sys_param.verup_cnct.verupstsputpath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.verup_cnct.verupstsputpath = testData1s;
      print(sys_param.verup_cnct.verupstsputpath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.verup_cnct.verupstsputpath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.verup_cnct.verupstsputpath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.verup_cnct.verupstsputpath = testData2s;
      print(sys_param.verup_cnct.verupstsputpath);
      expect(sys_param.verup_cnct.verupstsputpath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.verupstsputpath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.verup_cnct.verupstsputpath = defalut;
      print(sys_param.verup_cnct.verupstsputpath);
      expect(sys_param.verup_cnct.verupstsputpath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.verupstsputpath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00184_element_check_00161 **********\n\n");
    });

    test('00185_element_check_00162', () async {
      print("\n********** テスト実行：00185_element_check_00162 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.verup_cnct.imagepath;
      print(sys_param.verup_cnct.imagepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.verup_cnct.imagepath = testData1s;
      print(sys_param.verup_cnct.imagepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.verup_cnct.imagepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.verup_cnct.imagepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.verup_cnct.imagepath = testData2s;
      print(sys_param.verup_cnct.imagepath);
      expect(sys_param.verup_cnct.imagepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.imagepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.verup_cnct.imagepath = defalut;
      print(sys_param.verup_cnct.imagepath);
      expect(sys_param.verup_cnct.imagepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.verup_cnct.imagepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00185_element_check_00162 **********\n\n");
    });

    test('00186_element_check_00163', () async {
      print("\n********** テスト実行：00186_element_check_00163 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.caps_cardnet_store.store_code;
      print(sys_param.caps_cardnet_store.store_code);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.caps_cardnet_store.store_code = testData1s;
      print(sys_param.caps_cardnet_store.store_code);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.caps_cardnet_store.store_code == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.caps_cardnet_store.store_code == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.caps_cardnet_store.store_code = testData2s;
      print(sys_param.caps_cardnet_store.store_code);
      expect(sys_param.caps_cardnet_store.store_code == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.caps_cardnet_store.store_code == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.caps_cardnet_store.store_code = defalut;
      print(sys_param.caps_cardnet_store.store_code);
      expect(sys_param.caps_cardnet_store.store_code == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.caps_cardnet_store.store_code == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00186_element_check_00163 **********\n\n");
    });

    test('00187_element_check_00164', () async {
      print("\n********** テスト実行：00187_element_check_00164 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.caps_cardnet_store.store_name;
      print(sys_param.caps_cardnet_store.store_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.caps_cardnet_store.store_name = testData1s;
      print(sys_param.caps_cardnet_store.store_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.caps_cardnet_store.store_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.caps_cardnet_store.store_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.caps_cardnet_store.store_name = testData2s;
      print(sys_param.caps_cardnet_store.store_name);
      expect(sys_param.caps_cardnet_store.store_name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.caps_cardnet_store.store_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.caps_cardnet_store.store_name = defalut;
      print(sys_param.caps_cardnet_store.store_name);
      expect(sys_param.caps_cardnet_store.store_name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.caps_cardnet_store.store_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00187_element_check_00164 **********\n\n");
    });

    test('00188_element_check_00165', () async {
      print("\n********** テスト実行：00188_element_check_00165 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.caps_cardnet_store.place;
      print(sys_param.caps_cardnet_store.place);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.caps_cardnet_store.place = testData1s;
      print(sys_param.caps_cardnet_store.place);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.caps_cardnet_store.place == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.caps_cardnet_store.place == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.caps_cardnet_store.place = testData2s;
      print(sys_param.caps_cardnet_store.place);
      expect(sys_param.caps_cardnet_store.place == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.caps_cardnet_store.place == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.caps_cardnet_store.place = defalut;
      print(sys_param.caps_cardnet_store.place);
      expect(sys_param.caps_cardnet_store.place == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.caps_cardnet_store.place == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00188_element_check_00165 **********\n\n");
    });

    test('00189_element_check_00166', () async {
      print("\n********** テスト実行：00189_element_check_00166 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custreal2_pa.timeout;
      print(sys_param.custreal2_pa.timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custreal2_pa.timeout = testData1;
      print(sys_param.custreal2_pa.timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custreal2_pa.timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custreal2_pa.timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custreal2_pa.timeout = testData2;
      print(sys_param.custreal2_pa.timeout);
      expect(sys_param.custreal2_pa.timeout == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal2_pa.timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custreal2_pa.timeout = defalut;
      print(sys_param.custreal2_pa.timeout);
      expect(sys_param.custreal2_pa.timeout == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal2_pa.timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00189_element_check_00166 **********\n\n");
    });

    test('00190_element_check_00167', () async {
      print("\n********** テスト実行：00190_element_check_00167 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custreal2_pa.retrywaittime;
      print(sys_param.custreal2_pa.retrywaittime);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custreal2_pa.retrywaittime = testData1;
      print(sys_param.custreal2_pa.retrywaittime);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custreal2_pa.retrywaittime == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custreal2_pa.retrywaittime == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custreal2_pa.retrywaittime = testData2;
      print(sys_param.custreal2_pa.retrywaittime);
      expect(sys_param.custreal2_pa.retrywaittime == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal2_pa.retrywaittime == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custreal2_pa.retrywaittime = defalut;
      print(sys_param.custreal2_pa.retrywaittime);
      expect(sys_param.custreal2_pa.retrywaittime == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal2_pa.retrywaittime == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00190_element_check_00167 **********\n\n");
    });

    test('00191_element_check_00168', () async {
      print("\n********** テスト実行：00191_element_check_00168 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custreal2_pa.retrycnt;
      print(sys_param.custreal2_pa.retrycnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custreal2_pa.retrycnt = testData1;
      print(sys_param.custreal2_pa.retrycnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custreal2_pa.retrycnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custreal2_pa.retrycnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custreal2_pa.retrycnt = testData2;
      print(sys_param.custreal2_pa.retrycnt);
      expect(sys_param.custreal2_pa.retrycnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal2_pa.retrycnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custreal2_pa.retrycnt = defalut;
      print(sys_param.custreal2_pa.retrycnt);
      expect(sys_param.custreal2_pa.retrycnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal2_pa.retrycnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00191_element_check_00168 **********\n\n");
    });

    test('00192_element_check_00169', () async {
      print("\n********** テスト実行：00192_element_check_00169 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custreal2_pa.conect_typ;
      print(sys_param.custreal2_pa.conect_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custreal2_pa.conect_typ = testData1;
      print(sys_param.custreal2_pa.conect_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custreal2_pa.conect_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custreal2_pa.conect_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custreal2_pa.conect_typ = testData2;
      print(sys_param.custreal2_pa.conect_typ);
      expect(sys_param.custreal2_pa.conect_typ == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal2_pa.conect_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custreal2_pa.conect_typ = defalut;
      print(sys_param.custreal2_pa.conect_typ);
      expect(sys_param.custreal2_pa.conect_typ == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal2_pa.conect_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00192_element_check_00169 **********\n\n");
    });

    test('00193_element_check_00170', () async {
      print("\n********** テスト実行：00193_element_check_00170 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.tsweb_sh.wait_time;
      print(sys_param.tsweb_sh.wait_time);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.tsweb_sh.wait_time = testData1;
      print(sys_param.tsweb_sh.wait_time);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.tsweb_sh.wait_time == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.tsweb_sh.wait_time == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.tsweb_sh.wait_time = testData2;
      print(sys_param.tsweb_sh.wait_time);
      expect(sys_param.tsweb_sh.wait_time == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.tsweb_sh.wait_time == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.tsweb_sh.wait_time = defalut;
      print(sys_param.tsweb_sh.wait_time);
      expect(sys_param.tsweb_sh.wait_time == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.tsweb_sh.wait_time == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00193_element_check_00170 **********\n\n");
    });

    test('00194_element_check_00171', () async {
      print("\n********** テスト実行：00194_element_check_00171 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.tsweb_sh.retry_count;
      print(sys_param.tsweb_sh.retry_count);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.tsweb_sh.retry_count = testData1;
      print(sys_param.tsweb_sh.retry_count);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.tsweb_sh.retry_count == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.tsweb_sh.retry_count == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.tsweb_sh.retry_count = testData2;
      print(sys_param.tsweb_sh.retry_count);
      expect(sys_param.tsweb_sh.retry_count == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.tsweb_sh.retry_count == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.tsweb_sh.retry_count = defalut;
      print(sys_param.tsweb_sh.retry_count);
      expect(sys_param.tsweb_sh.retry_count == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.tsweb_sh.retry_count == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00194_element_check_00171 **********\n\n");
    });

    test('00195_element_check_00172', () async {
      print("\n********** テスト実行：00195_element_check_00172 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.tsweb_sh.wait_ftp_beforetime;
      print(sys_param.tsweb_sh.wait_ftp_beforetime);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.tsweb_sh.wait_ftp_beforetime = testData1;
      print(sys_param.tsweb_sh.wait_ftp_beforetime);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.tsweb_sh.wait_ftp_beforetime == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.tsweb_sh.wait_ftp_beforetime == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.tsweb_sh.wait_ftp_beforetime = testData2;
      print(sys_param.tsweb_sh.wait_ftp_beforetime);
      expect(sys_param.tsweb_sh.wait_ftp_beforetime == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.tsweb_sh.wait_ftp_beforetime == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.tsweb_sh.wait_ftp_beforetime = defalut;
      print(sys_param.tsweb_sh.wait_ftp_beforetime);
      expect(sys_param.tsweb_sh.wait_ftp_beforetime == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.tsweb_sh.wait_ftp_beforetime == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00195_element_check_00172 **********\n\n");
    });

    test('00196_element_check_00173', () async {
      print("\n********** テスト実行：00196_element_check_00173 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.bkup_save.name;
      print(sys_param.bkup_save.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.bkup_save.name = testData1s;
      print(sys_param.bkup_save.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.bkup_save.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.bkup_save.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.bkup_save.name = testData2s;
      print(sys_param.bkup_save.name);
      expect(sys_param.bkup_save.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.bkup_save.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.bkup_save.name = defalut;
      print(sys_param.bkup_save.name);
      expect(sys_param.bkup_save.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.bkup_save.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00196_element_check_00173 **********\n\n");
    });

    test('00197_element_check_00174', () async {
      print("\n********** テスト実行：00197_element_check_00174 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.bkup_save.loginname;
      print(sys_param.bkup_save.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.bkup_save.loginname = testData1s;
      print(sys_param.bkup_save.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.bkup_save.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.bkup_save.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.bkup_save.loginname = testData2s;
      print(sys_param.bkup_save.loginname);
      expect(sys_param.bkup_save.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.bkup_save.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.bkup_save.loginname = defalut;
      print(sys_param.bkup_save.loginname);
      expect(sys_param.bkup_save.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.bkup_save.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00197_element_check_00174 **********\n\n");
    });

    test('00198_element_check_00175', () async {
      print("\n********** テスト実行：00198_element_check_00175 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.bkup_save.password;
      print(sys_param.bkup_save.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.bkup_save.password = testData1s;
      print(sys_param.bkup_save.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.bkup_save.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.bkup_save.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.bkup_save.password = testData2s;
      print(sys_param.bkup_save.password);
      expect(sys_param.bkup_save.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.bkup_save.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.bkup_save.password = defalut;
      print(sys_param.bkup_save.password);
      expect(sys_param.bkup_save.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.bkup_save.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00198_element_check_00175 **********\n\n");
    });

    test('00199_element_check_00176', () async {
      print("\n********** テスト実行：00199_element_check_00176 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.bkup_save.remotepath;
      print(sys_param.bkup_save.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.bkup_save.remotepath = testData1s;
      print(sys_param.bkup_save.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.bkup_save.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.bkup_save.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.bkup_save.remotepath = testData2s;
      print(sys_param.bkup_save.remotepath);
      expect(sys_param.bkup_save.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.bkup_save.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.bkup_save.remotepath = defalut;
      print(sys_param.bkup_save.remotepath);
      expect(sys_param.bkup_save.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.bkup_save.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00199_element_check_00176 **********\n\n");
    });

    test('00200_element_check_00177', () async {
      print("\n********** テスト実行：00200_element_check_00177 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.histlog_server.name;
      print(sys_param.histlog_server.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.histlog_server.name = testData1s;
      print(sys_param.histlog_server.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.histlog_server.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.histlog_server.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.histlog_server.name = testData2s;
      print(sys_param.histlog_server.name);
      expect(sys_param.histlog_server.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.histlog_server.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.histlog_server.name = defalut;
      print(sys_param.histlog_server.name);
      expect(sys_param.histlog_server.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.histlog_server.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00200_element_check_00177 **********\n\n");
    });

    test('00201_element_check_00178', () async {
      print("\n********** テスト実行：00201_element_check_00178 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.cashrecycle.soc_timeout;
      print(sys_param.cashrecycle.soc_timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.cashrecycle.soc_timeout = testData1;
      print(sys_param.cashrecycle.soc_timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.cashrecycle.soc_timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.cashrecycle.soc_timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.cashrecycle.soc_timeout = testData2;
      print(sys_param.cashrecycle.soc_timeout);
      expect(sys_param.cashrecycle.soc_timeout == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.cashrecycle.soc_timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.cashrecycle.soc_timeout = defalut;
      print(sys_param.cashrecycle.soc_timeout);
      expect(sys_param.cashrecycle.soc_timeout == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.cashrecycle.soc_timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00201_element_check_00178 **********\n\n");
    });

    test('00202_element_check_00179', () async {
      print("\n********** テスト実行：00202_element_check_00179 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.pack_on_time.name;
      print(sys_param.pack_on_time.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.pack_on_time.name = testData1s;
      print(sys_param.pack_on_time.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.pack_on_time.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.pack_on_time.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.pack_on_time.name = testData2s;
      print(sys_param.pack_on_time.name);
      expect(sys_param.pack_on_time.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.pack_on_time.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.pack_on_time.name = defalut;
      print(sys_param.pack_on_time.name);
      expect(sys_param.pack_on_time.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.pack_on_time.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00202_element_check_00179 **********\n\n");
    });

    test('00203_element_check_00180', () async {
      print("\n********** テスト実行：00203_element_check_00180 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.pack_on_time.loginname;
      print(sys_param.pack_on_time.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.pack_on_time.loginname = testData1s;
      print(sys_param.pack_on_time.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.pack_on_time.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.pack_on_time.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.pack_on_time.loginname = testData2s;
      print(sys_param.pack_on_time.loginname);
      expect(sys_param.pack_on_time.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.pack_on_time.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.pack_on_time.loginname = defalut;
      print(sys_param.pack_on_time.loginname);
      expect(sys_param.pack_on_time.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.pack_on_time.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00203_element_check_00180 **********\n\n");
    });

    test('00204_element_check_00181', () async {
      print("\n********** テスト実行：00204_element_check_00181 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.pack_on_time.password;
      print(sys_param.pack_on_time.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.pack_on_time.password = testData1s;
      print(sys_param.pack_on_time.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.pack_on_time.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.pack_on_time.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.pack_on_time.password = testData2s;
      print(sys_param.pack_on_time.password);
      expect(sys_param.pack_on_time.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.pack_on_time.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.pack_on_time.password = defalut;
      print(sys_param.pack_on_time.password);
      expect(sys_param.pack_on_time.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.pack_on_time.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00204_element_check_00181 **********\n\n");
    });

    test('00205_element_check_00182', () async {
      print("\n********** テスト実行：00205_element_check_00182 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.pack_on_time.remotepath;
      print(sys_param.pack_on_time.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.pack_on_time.remotepath = testData1s;
      print(sys_param.pack_on_time.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.pack_on_time.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.pack_on_time.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.pack_on_time.remotepath = testData2s;
      print(sys_param.pack_on_time.remotepath);
      expect(sys_param.pack_on_time.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.pack_on_time.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.pack_on_time.remotepath = defalut;
      print(sys_param.pack_on_time.remotepath);
      expect(sys_param.pack_on_time.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.pack_on_time.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00205_element_check_00182 **********\n\n");
    });

    test('00206_element_check_00183', () async {
      print("\n********** テスト実行：00206_element_check_00183 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.pack_on_time.remotepath_rcv;
      print(sys_param.pack_on_time.remotepath_rcv);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.pack_on_time.remotepath_rcv = testData1s;
      print(sys_param.pack_on_time.remotepath_rcv);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.pack_on_time.remotepath_rcv == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.pack_on_time.remotepath_rcv == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.pack_on_time.remotepath_rcv = testData2s;
      print(sys_param.pack_on_time.remotepath_rcv);
      expect(sys_param.pack_on_time.remotepath_rcv == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.pack_on_time.remotepath_rcv == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.pack_on_time.remotepath_rcv = defalut;
      print(sys_param.pack_on_time.remotepath_rcv);
      expect(sys_param.pack_on_time.remotepath_rcv == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.pack_on_time.remotepath_rcv == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00206_element_check_00183 **********\n\n");
    });

    test('00207_element_check_00184', () async {
      print("\n********** テスト実行：00207_element_check_00184 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.pack_on_time.interval;
      print(sys_param.pack_on_time.interval);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.pack_on_time.interval = testData1;
      print(sys_param.pack_on_time.interval);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.pack_on_time.interval == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.pack_on_time.interval == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.pack_on_time.interval = testData2;
      print(sys_param.pack_on_time.interval);
      expect(sys_param.pack_on_time.interval == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.pack_on_time.interval == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.pack_on_time.interval = defalut;
      print(sys_param.pack_on_time.interval);
      expect(sys_param.pack_on_time.interval == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.pack_on_time.interval == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00207_element_check_00184 **********\n\n");
    });

    test('00208_element_check_00185', () async {
      print("\n********** テスト実行：00208_element_check_00185 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ts_gyoumu.name;
      print(sys_param.ts_gyoumu.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ts_gyoumu.name = testData1s;
      print(sys_param.ts_gyoumu.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ts_gyoumu.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ts_gyoumu.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ts_gyoumu.name = testData2s;
      print(sys_param.ts_gyoumu.name);
      expect(sys_param.ts_gyoumu.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ts_gyoumu.name = defalut;
      print(sys_param.ts_gyoumu.name);
      expect(sys_param.ts_gyoumu.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00208_element_check_00185 **********\n\n");
    });

    test('00209_element_check_00186', () async {
      print("\n********** テスト実行：00209_element_check_00186 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ts_gyoumu.loginname;
      print(sys_param.ts_gyoumu.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ts_gyoumu.loginname = testData1s;
      print(sys_param.ts_gyoumu.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ts_gyoumu.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ts_gyoumu.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ts_gyoumu.loginname = testData2s;
      print(sys_param.ts_gyoumu.loginname);
      expect(sys_param.ts_gyoumu.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ts_gyoumu.loginname = defalut;
      print(sys_param.ts_gyoumu.loginname);
      expect(sys_param.ts_gyoumu.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00209_element_check_00186 **********\n\n");
    });

    test('00210_element_check_00187', () async {
      print("\n********** テスト実行：00210_element_check_00187 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ts_gyoumu.password;
      print(sys_param.ts_gyoumu.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ts_gyoumu.password = testData1s;
      print(sys_param.ts_gyoumu.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ts_gyoumu.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ts_gyoumu.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ts_gyoumu.password = testData2s;
      print(sys_param.ts_gyoumu.password);
      expect(sys_param.ts_gyoumu.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ts_gyoumu.password = defalut;
      print(sys_param.ts_gyoumu.password);
      expect(sys_param.ts_gyoumu.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00210_element_check_00187 **********\n\n");
    });

    test('00211_element_check_00188', () async {
      print("\n********** テスト実行：00211_element_check_00188 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ts_gyoumu.remotepath;
      print(sys_param.ts_gyoumu.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ts_gyoumu.remotepath = testData1s;
      print(sys_param.ts_gyoumu.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ts_gyoumu.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ts_gyoumu.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ts_gyoumu.remotepath = testData2s;
      print(sys_param.ts_gyoumu.remotepath);
      expect(sys_param.ts_gyoumu.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ts_gyoumu.remotepath = defalut;
      print(sys_param.ts_gyoumu.remotepath);
      expect(sys_param.ts_gyoumu.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00211_element_check_00188 **********\n\n");
    });

    test('00212_element_check_00189', () async {
      print("\n********** テスト実行：00212_element_check_00189 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ts_gyoumu.remotepath_rcv;
      print(sys_param.ts_gyoumu.remotepath_rcv);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ts_gyoumu.remotepath_rcv = testData1s;
      print(sys_param.ts_gyoumu.remotepath_rcv);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ts_gyoumu.remotepath_rcv == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ts_gyoumu.remotepath_rcv == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ts_gyoumu.remotepath_rcv = testData2s;
      print(sys_param.ts_gyoumu.remotepath_rcv);
      expect(sys_param.ts_gyoumu.remotepath_rcv == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.remotepath_rcv == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ts_gyoumu.remotepath_rcv = defalut;
      print(sys_param.ts_gyoumu.remotepath_rcv);
      expect(sys_param.ts_gyoumu.remotepath_rcv == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.remotepath_rcv == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00212_element_check_00189 **********\n\n");
    });

    test('00213_element_check_00190', () async {
      print("\n********** テスト実行：00213_element_check_00190 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ts_gyoumu.ftp_port;
      print(sys_param.ts_gyoumu.ftp_port);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ts_gyoumu.ftp_port = testData1;
      print(sys_param.ts_gyoumu.ftp_port);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ts_gyoumu.ftp_port == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ts_gyoumu.ftp_port == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ts_gyoumu.ftp_port = testData2;
      print(sys_param.ts_gyoumu.ftp_port);
      expect(sys_param.ts_gyoumu.ftp_port == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.ftp_port == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ts_gyoumu.ftp_port = defalut;
      print(sys_param.ts_gyoumu.ftp_port);
      expect(sys_param.ts_gyoumu.ftp_port == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.ftp_port == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00213_element_check_00190 **********\n\n");
    });

    test('00214_element_check_00191', () async {
      print("\n********** テスト実行：00214_element_check_00191 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ts_gyoumu.ftp_protocol;
      print(sys_param.ts_gyoumu.ftp_protocol);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ts_gyoumu.ftp_protocol = testData1;
      print(sys_param.ts_gyoumu.ftp_protocol);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ts_gyoumu.ftp_protocol == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ts_gyoumu.ftp_protocol == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ts_gyoumu.ftp_protocol = testData2;
      print(sys_param.ts_gyoumu.ftp_protocol);
      expect(sys_param.ts_gyoumu.ftp_protocol == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.ftp_protocol == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ts_gyoumu.ftp_protocol = defalut;
      print(sys_param.ts_gyoumu.ftp_protocol);
      expect(sys_param.ts_gyoumu.ftp_protocol == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.ftp_protocol == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00214_element_check_00191 **********\n\n");
    });

    test('00215_element_check_00192', () async {
      print("\n********** テスト実行：00215_element_check_00192 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ts_gyoumu.ftp_pasv;
      print(sys_param.ts_gyoumu.ftp_pasv);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ts_gyoumu.ftp_pasv = testData1;
      print(sys_param.ts_gyoumu.ftp_pasv);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ts_gyoumu.ftp_pasv == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ts_gyoumu.ftp_pasv == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ts_gyoumu.ftp_pasv = testData2;
      print(sys_param.ts_gyoumu.ftp_pasv);
      expect(sys_param.ts_gyoumu.ftp_pasv == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.ftp_pasv == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ts_gyoumu.ftp_pasv = defalut;
      print(sys_param.ts_gyoumu.ftp_pasv);
      expect(sys_param.ts_gyoumu.ftp_pasv == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.ftp_pasv == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00215_element_check_00192 **********\n\n");
    });

    test('00216_element_check_00193', () async {
      print("\n********** テスト実行：00216_element_check_00193 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ts_gyoumu.ftp_retrycnt;
      print(sys_param.ts_gyoumu.ftp_retrycnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ts_gyoumu.ftp_retrycnt = testData1;
      print(sys_param.ts_gyoumu.ftp_retrycnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ts_gyoumu.ftp_retrycnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ts_gyoumu.ftp_retrycnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ts_gyoumu.ftp_retrycnt = testData2;
      print(sys_param.ts_gyoumu.ftp_retrycnt);
      expect(sys_param.ts_gyoumu.ftp_retrycnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.ftp_retrycnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ts_gyoumu.ftp_retrycnt = defalut;
      print(sys_param.ts_gyoumu.ftp_retrycnt);
      expect(sys_param.ts_gyoumu.ftp_retrycnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ts_gyoumu.ftp_retrycnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00216_element_check_00193 **********\n\n");
    });

    test('00217_element_check_00194', () async {
      print("\n********** テスト実行：00217_element_check_00194 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.apl_curl_post_opt.connect_timeout;
      print(sys_param.apl_curl_post_opt.connect_timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.apl_curl_post_opt.connect_timeout = testData1;
      print(sys_param.apl_curl_post_opt.connect_timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.apl_curl_post_opt.connect_timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.apl_curl_post_opt.connect_timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.apl_curl_post_opt.connect_timeout = testData2;
      print(sys_param.apl_curl_post_opt.connect_timeout);
      expect(sys_param.apl_curl_post_opt.connect_timeout == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_post_opt.connect_timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.apl_curl_post_opt.connect_timeout = defalut;
      print(sys_param.apl_curl_post_opt.connect_timeout);
      expect(sys_param.apl_curl_post_opt.connect_timeout == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_post_opt.connect_timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00217_element_check_00194 **********\n\n");
    });

    test('00218_element_check_00195', () async {
      print("\n********** テスト実行：00218_element_check_00195 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.apl_curl_post_opt.low_speed_time;
      print(sys_param.apl_curl_post_opt.low_speed_time);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.apl_curl_post_opt.low_speed_time = testData1;
      print(sys_param.apl_curl_post_opt.low_speed_time);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.apl_curl_post_opt.low_speed_time == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.apl_curl_post_opt.low_speed_time == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.apl_curl_post_opt.low_speed_time = testData2;
      print(sys_param.apl_curl_post_opt.low_speed_time);
      expect(sys_param.apl_curl_post_opt.low_speed_time == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_post_opt.low_speed_time == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.apl_curl_post_opt.low_speed_time = defalut;
      print(sys_param.apl_curl_post_opt.low_speed_time);
      expect(sys_param.apl_curl_post_opt.low_speed_time == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_post_opt.low_speed_time == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00218_element_check_00195 **********\n\n");
    });

    test('00219_element_check_00196', () async {
      print("\n********** テスト実行：00219_element_check_00196 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.apl_curl_post_opt.low_speed_limit;
      print(sys_param.apl_curl_post_opt.low_speed_limit);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.apl_curl_post_opt.low_speed_limit = testData1;
      print(sys_param.apl_curl_post_opt.low_speed_limit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.apl_curl_post_opt.low_speed_limit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.apl_curl_post_opt.low_speed_limit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.apl_curl_post_opt.low_speed_limit = testData2;
      print(sys_param.apl_curl_post_opt.low_speed_limit);
      expect(sys_param.apl_curl_post_opt.low_speed_limit == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_post_opt.low_speed_limit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.apl_curl_post_opt.low_speed_limit = defalut;
      print(sys_param.apl_curl_post_opt.low_speed_limit);
      expect(sys_param.apl_curl_post_opt.low_speed_limit == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_post_opt.low_speed_limit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00219_element_check_00196 **********\n\n");
    });

    test('00220_element_check_00197', () async {
      print("\n********** テスト実行：00220_element_check_00197 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.apl_curl_post_opt.retry_wait;
      print(sys_param.apl_curl_post_opt.retry_wait);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.apl_curl_post_opt.retry_wait = testData1;
      print(sys_param.apl_curl_post_opt.retry_wait);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.apl_curl_post_opt.retry_wait == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.apl_curl_post_opt.retry_wait == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.apl_curl_post_opt.retry_wait = testData2;
      print(sys_param.apl_curl_post_opt.retry_wait);
      expect(sys_param.apl_curl_post_opt.retry_wait == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_post_opt.retry_wait == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.apl_curl_post_opt.retry_wait = defalut;
      print(sys_param.apl_curl_post_opt.retry_wait);
      expect(sys_param.apl_curl_post_opt.retry_wait == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_post_opt.retry_wait == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00220_element_check_00197 **********\n\n");
    });

    test('00221_element_check_00198', () async {
      print("\n********** テスト実行：00221_element_check_00198 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.apl_curl_ftp_opt.connect_timeout;
      print(sys_param.apl_curl_ftp_opt.connect_timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.apl_curl_ftp_opt.connect_timeout = testData1;
      print(sys_param.apl_curl_ftp_opt.connect_timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.apl_curl_ftp_opt.connect_timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.apl_curl_ftp_opt.connect_timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.apl_curl_ftp_opt.connect_timeout = testData2;
      print(sys_param.apl_curl_ftp_opt.connect_timeout);
      expect(sys_param.apl_curl_ftp_opt.connect_timeout == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_ftp_opt.connect_timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.apl_curl_ftp_opt.connect_timeout = defalut;
      print(sys_param.apl_curl_ftp_opt.connect_timeout);
      expect(sys_param.apl_curl_ftp_opt.connect_timeout == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_ftp_opt.connect_timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00221_element_check_00198 **********\n\n");
    });

    test('00222_element_check_00199', () async {
      print("\n********** テスト実行：00222_element_check_00199 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.apl_curl_ftp_opt.low_speed_time;
      print(sys_param.apl_curl_ftp_opt.low_speed_time);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.apl_curl_ftp_opt.low_speed_time = testData1;
      print(sys_param.apl_curl_ftp_opt.low_speed_time);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.apl_curl_ftp_opt.low_speed_time == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.apl_curl_ftp_opt.low_speed_time == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.apl_curl_ftp_opt.low_speed_time = testData2;
      print(sys_param.apl_curl_ftp_opt.low_speed_time);
      expect(sys_param.apl_curl_ftp_opt.low_speed_time == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_ftp_opt.low_speed_time == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.apl_curl_ftp_opt.low_speed_time = defalut;
      print(sys_param.apl_curl_ftp_opt.low_speed_time);
      expect(sys_param.apl_curl_ftp_opt.low_speed_time == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_ftp_opt.low_speed_time == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00222_element_check_00199 **********\n\n");
    });

    test('00223_element_check_00200', () async {
      print("\n********** テスト実行：00223_element_check_00200 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.apl_curl_ftp_opt.low_speed_limit;
      print(sys_param.apl_curl_ftp_opt.low_speed_limit);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.apl_curl_ftp_opt.low_speed_limit = testData1;
      print(sys_param.apl_curl_ftp_opt.low_speed_limit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.apl_curl_ftp_opt.low_speed_limit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.apl_curl_ftp_opt.low_speed_limit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.apl_curl_ftp_opt.low_speed_limit = testData2;
      print(sys_param.apl_curl_ftp_opt.low_speed_limit);
      expect(sys_param.apl_curl_ftp_opt.low_speed_limit == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_ftp_opt.low_speed_limit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.apl_curl_ftp_opt.low_speed_limit = defalut;
      print(sys_param.apl_curl_ftp_opt.low_speed_limit);
      expect(sys_param.apl_curl_ftp_opt.low_speed_limit == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_ftp_opt.low_speed_limit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00223_element_check_00200 **********\n\n");
    });

    test('00224_element_check_00201', () async {
      print("\n********** テスト実行：00224_element_check_00201 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.apl_curl_ftp_opt.retry_wait;
      print(sys_param.apl_curl_ftp_opt.retry_wait);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.apl_curl_ftp_opt.retry_wait = testData1;
      print(sys_param.apl_curl_ftp_opt.retry_wait);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.apl_curl_ftp_opt.retry_wait == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.apl_curl_ftp_opt.retry_wait == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.apl_curl_ftp_opt.retry_wait = testData2;
      print(sys_param.apl_curl_ftp_opt.retry_wait);
      expect(sys_param.apl_curl_ftp_opt.retry_wait == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_ftp_opt.retry_wait == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.apl_curl_ftp_opt.retry_wait = defalut;
      print(sys_param.apl_curl_ftp_opt.retry_wait);
      expect(sys_param.apl_curl_ftp_opt.retry_wait == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.apl_curl_ftp_opt.retry_wait == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00224_element_check_00201 **********\n\n");
    });

    test('00225_element_check_00202', () async {
      print("\n********** テスト実行：00225_element_check_00202 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.cust_reserve_db.hostdbname;
      print(sys_param.cust_reserve_db.hostdbname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.cust_reserve_db.hostdbname = testData1s;
      print(sys_param.cust_reserve_db.hostdbname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.cust_reserve_db.hostdbname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.cust_reserve_db.hostdbname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.cust_reserve_db.hostdbname = testData2s;
      print(sys_param.cust_reserve_db.hostdbname);
      expect(sys_param.cust_reserve_db.hostdbname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.cust_reserve_db.hostdbname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.cust_reserve_db.hostdbname = defalut;
      print(sys_param.cust_reserve_db.hostdbname);
      expect(sys_param.cust_reserve_db.hostdbname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.cust_reserve_db.hostdbname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00225_element_check_00202 **********\n\n");
    });

    test('00226_element_check_00203', () async {
      print("\n********** テスト実行：00226_element_check_00203 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.cust_reserve_db.hostdbuser;
      print(sys_param.cust_reserve_db.hostdbuser);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.cust_reserve_db.hostdbuser = testData1s;
      print(sys_param.cust_reserve_db.hostdbuser);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.cust_reserve_db.hostdbuser == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.cust_reserve_db.hostdbuser == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.cust_reserve_db.hostdbuser = testData2s;
      print(sys_param.cust_reserve_db.hostdbuser);
      expect(sys_param.cust_reserve_db.hostdbuser == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.cust_reserve_db.hostdbuser == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.cust_reserve_db.hostdbuser = defalut;
      print(sys_param.cust_reserve_db.hostdbuser);
      expect(sys_param.cust_reserve_db.hostdbuser == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.cust_reserve_db.hostdbuser == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00226_element_check_00203 **********\n\n");
    });

    test('00227_element_check_00204', () async {
      print("\n********** テスト実行：00227_element_check_00204 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.cust_reserve_db.hostdbpass;
      print(sys_param.cust_reserve_db.hostdbpass);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.cust_reserve_db.hostdbpass = testData1s;
      print(sys_param.cust_reserve_db.hostdbpass);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.cust_reserve_db.hostdbpass == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.cust_reserve_db.hostdbpass == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.cust_reserve_db.hostdbpass = testData2s;
      print(sys_param.cust_reserve_db.hostdbpass);
      expect(sys_param.cust_reserve_db.hostdbpass == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.cust_reserve_db.hostdbpass == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.cust_reserve_db.hostdbpass = defalut;
      print(sys_param.cust_reserve_db.hostdbpass);
      expect(sys_param.cust_reserve_db.hostdbpass == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.cust_reserve_db.hostdbpass == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00227_element_check_00204 **********\n\n");
    });

    test('00228_element_check_00205', () async {
      print("\n********** テスト実行：00228_element_check_00205 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.dpoint.name;
      print(sys_param.dpoint.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.dpoint.name = testData1s;
      print(sys_param.dpoint.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.dpoint.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.dpoint.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.dpoint.name = testData2s;
      print(sys_param.dpoint.name);
      expect(sys_param.dpoint.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.dpoint.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.dpoint.name = defalut;
      print(sys_param.dpoint.name);
      expect(sys_param.dpoint.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.dpoint.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00228_element_check_00205 **********\n\n");
    });

    test('00229_element_check_00206', () async {
      print("\n********** テスト実行：00229_element_check_00206 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.dpoint.timeout;
      print(sys_param.dpoint.timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.dpoint.timeout = testData1;
      print(sys_param.dpoint.timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.dpoint.timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.dpoint.timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.dpoint.timeout = testData2;
      print(sys_param.dpoint.timeout);
      expect(sys_param.dpoint.timeout == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.dpoint.timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.dpoint.timeout = defalut;
      print(sys_param.dpoint.timeout);
      expect(sys_param.dpoint.timeout == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.dpoint.timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00229_element_check_00206 **********\n\n");
    });

    test('00230_element_check_00207', () async {
      print("\n********** テスト実行：00230_element_check_00207 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.dpoint.sub_name;
      print(sys_param.dpoint.sub_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.dpoint.sub_name = testData1s;
      print(sys_param.dpoint.sub_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.dpoint.sub_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.dpoint.sub_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.dpoint.sub_name = testData2s;
      print(sys_param.dpoint.sub_name);
      expect(sys_param.dpoint.sub_name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.dpoint.sub_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.dpoint.sub_name = defalut;
      print(sys_param.dpoint.sub_name);
      expect(sys_param.dpoint.sub_name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.dpoint.sub_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00230_element_check_00207 **********\n\n");
    });

    test('00231_element_check_00208', () async {
      print("\n********** テスト実行：00231_element_check_00208 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.dpoint.username;
      print(sys_param.dpoint.username);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.dpoint.username = testData1s;
      print(sys_param.dpoint.username);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.dpoint.username == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.dpoint.username == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.dpoint.username = testData2s;
      print(sys_param.dpoint.username);
      expect(sys_param.dpoint.username == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.dpoint.username == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.dpoint.username = defalut;
      print(sys_param.dpoint.username);
      expect(sys_param.dpoint.username == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.dpoint.username == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00231_element_check_00208 **********\n\n");
    });

    test('00232_element_check_00209', () async {
      print("\n********** テスト実行：00232_element_check_00209 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.dpoint.password;
      print(sys_param.dpoint.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.dpoint.password = testData1s;
      print(sys_param.dpoint.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.dpoint.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.dpoint.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.dpoint.password = testData2s;
      print(sys_param.dpoint.password);
      expect(sys_param.dpoint.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.dpoint.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.dpoint.password = defalut;
      print(sys_param.dpoint.password);
      expect(sys_param.dpoint.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.dpoint.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00232_element_check_00209 **********\n\n");
    });

    test('00233_element_check_00210', () async {
      print("\n********** テスト実行：00233_element_check_00210 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.spec_bkup.timeout2;
      print(sys_param.spec_bkup.timeout2);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.spec_bkup.timeout2 = testData1;
      print(sys_param.spec_bkup.timeout2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.spec_bkup.timeout2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.spec_bkup.timeout2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.spec_bkup.timeout2 = testData2;
      print(sys_param.spec_bkup.timeout2);
      expect(sys_param.spec_bkup.timeout2 == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.spec_bkup.timeout2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.spec_bkup.timeout2 = defalut;
      print(sys_param.spec_bkup.timeout2);
      expect(sys_param.spec_bkup.timeout2 == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.spec_bkup.timeout2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00233_element_check_00210 **********\n\n");
    });

    test('00234_element_check_00211', () async {
      print("\n********** テスト実行：00234_element_check_00211 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.spec_bkup.retrycnt;
      print(sys_param.spec_bkup.retrycnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.spec_bkup.retrycnt = testData1;
      print(sys_param.spec_bkup.retrycnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.spec_bkup.retrycnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.spec_bkup.retrycnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.spec_bkup.retrycnt = testData2;
      print(sys_param.spec_bkup.retrycnt);
      expect(sys_param.spec_bkup.retrycnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.spec_bkup.retrycnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.spec_bkup.retrycnt = defalut;
      print(sys_param.spec_bkup.retrycnt);
      expect(sys_param.spec_bkup.retrycnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.spec_bkup.retrycnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00234_element_check_00211 **********\n\n");
    });

    test('00235_element_check_00212', () async {
      print("\n********** テスト実行：00235_element_check_00212 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.spec_bkup.sleep_time2;
      print(sys_param.spec_bkup.sleep_time2);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.spec_bkup.sleep_time2 = testData1;
      print(sys_param.spec_bkup.sleep_time2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.spec_bkup.sleep_time2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.spec_bkup.sleep_time2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.spec_bkup.sleep_time2 = testData2;
      print(sys_param.spec_bkup.sleep_time2);
      expect(sys_param.spec_bkup.sleep_time2 == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.spec_bkup.sleep_time2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.spec_bkup.sleep_time2 = defalut;
      print(sys_param.spec_bkup.sleep_time2);
      expect(sys_param.spec_bkup.sleep_time2 == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.spec_bkup.sleep_time2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00235_element_check_00212 **********\n\n");
    });

    test('00236_element_check_00213', () async {
      print("\n********** テスト実行：00236_element_check_00213 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.spec_bkup.sleep_cnt;
      print(sys_param.spec_bkup.sleep_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.spec_bkup.sleep_cnt = testData1;
      print(sys_param.spec_bkup.sleep_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.spec_bkup.sleep_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.spec_bkup.sleep_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.spec_bkup.sleep_cnt = testData2;
      print(sys_param.spec_bkup.sleep_cnt);
      expect(sys_param.spec_bkup.sleep_cnt == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.spec_bkup.sleep_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.spec_bkup.sleep_cnt = defalut;
      print(sys_param.spec_bkup.sleep_cnt);
      expect(sys_param.spec_bkup.sleep_cnt == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.spec_bkup.sleep_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00236_element_check_00213 **********\n\n");
    });

    test('00237_element_check_00214', () async {
      print("\n********** テスト実行：00237_element_check_00214 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.spec_bkup.path;
      print(sys_param.spec_bkup.path);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.spec_bkup.path = testData1s;
      print(sys_param.spec_bkup.path);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.spec_bkup.path == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.spec_bkup.path == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.spec_bkup.path = testData2s;
      print(sys_param.spec_bkup.path);
      expect(sys_param.spec_bkup.path == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.spec_bkup.path == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.spec_bkup.path = defalut;
      print(sys_param.spec_bkup.path);
      expect(sys_param.spec_bkup.path == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.spec_bkup.path == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00237_element_check_00214 **********\n\n");
    });

    test('00238_element_check_00215', () async {
      print("\n********** テスト実行：00238_element_check_00215 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.spec_bkup.generation2;
      print(sys_param.spec_bkup.generation2);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.spec_bkup.generation2 = testData1;
      print(sys_param.spec_bkup.generation2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.spec_bkup.generation2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.spec_bkup.generation2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.spec_bkup.generation2 = testData2;
      print(sys_param.spec_bkup.generation2);
      expect(sys_param.spec_bkup.generation2 == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.spec_bkup.generation2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.spec_bkup.generation2 = defalut;
      print(sys_param.spec_bkup.generation2);
      expect(sys_param.spec_bkup.generation2 == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.spec_bkup.generation2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00238_element_check_00215 **********\n\n");
    });

    test('00239_element_check_00216', () async {
      print("\n********** テスト実行：00239_element_check_00216 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custreal_hps.Username;
      print(sys_param.custreal_hps.Username);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custreal_hps.Username = testData1s;
      print(sys_param.custreal_hps.Username);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custreal_hps.Username == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custreal_hps.Username == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custreal_hps.Username = testData2s;
      print(sys_param.custreal_hps.Username);
      expect(sys_param.custreal_hps.Username == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal_hps.Username == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custreal_hps.Username = defalut;
      print(sys_param.custreal_hps.Username);
      expect(sys_param.custreal_hps.Username == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal_hps.Username == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00239_element_check_00216 **********\n\n");
    });

    test('00240_element_check_00217', () async {
      print("\n********** テスト実行：00240_element_check_00217 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custreal_hps.Password;
      print(sys_param.custreal_hps.Password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custreal_hps.Password = testData1s;
      print(sys_param.custreal_hps.Password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custreal_hps.Password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custreal_hps.Password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custreal_hps.Password = testData2s;
      print(sys_param.custreal_hps.Password);
      expect(sys_param.custreal_hps.Password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal_hps.Password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custreal_hps.Password = defalut;
      print(sys_param.custreal_hps.Password);
      expect(sys_param.custreal_hps.Password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal_hps.Password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00240_element_check_00217 **********\n\n");
    });

    test('00241_element_check_00218', () async {
      print("\n********** テスト実行：00241_element_check_00218 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custreal_hps.rtl_id;
      print(sys_param.custreal_hps.rtl_id);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custreal_hps.rtl_id = testData1;
      print(sys_param.custreal_hps.rtl_id);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custreal_hps.rtl_id == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custreal_hps.rtl_id == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custreal_hps.rtl_id = testData2;
      print(sys_param.custreal_hps.rtl_id);
      expect(sys_param.custreal_hps.rtl_id == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal_hps.rtl_id == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custreal_hps.rtl_id = defalut;
      print(sys_param.custreal_hps.rtl_id);
      expect(sys_param.custreal_hps.rtl_id == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal_hps.rtl_id == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00241_element_check_00218 **********\n\n");
    });

    test('00242_element_check_00219', () async {
      print("\n********** テスト実行：00242_element_check_00219 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custreal_hps.version;
      print(sys_param.custreal_hps.version);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custreal_hps.version = testData1;
      print(sys_param.custreal_hps.version);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custreal_hps.version == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custreal_hps.version == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custreal_hps.version = testData2;
      print(sys_param.custreal_hps.version);
      expect(sys_param.custreal_hps.version == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal_hps.version == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custreal_hps.version = defalut;
      print(sys_param.custreal_hps.version);
      expect(sys_param.custreal_hps.version == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal_hps.version == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00242_element_check_00219 **********\n\n");
    });

    test('00243_element_check_00220', () async {
      print("\n********** テスト実行：00243_element_check_00220 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.custreal_hps.device_div;
      print(sys_param.custreal_hps.device_div);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.custreal_hps.device_div = testData1;
      print(sys_param.custreal_hps.device_div);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.custreal_hps.device_div == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.custreal_hps.device_div == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.custreal_hps.device_div = testData2;
      print(sys_param.custreal_hps.device_div);
      expect(sys_param.custreal_hps.device_div == testData2, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal_hps.device_div == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.custreal_hps.device_div = defalut;
      print(sys_param.custreal_hps.device_div);
      expect(sys_param.custreal_hps.device_div == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.custreal_hps.device_div == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00243_element_check_00220 **********\n\n");
    });

    test('00244_element_check_00221', () async {
      print("\n********** テスト実行：00244_element_check_00221 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ws_hq.hostdbname;
      print(sys_param.ws_hq.hostdbname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ws_hq.hostdbname = testData1s;
      print(sys_param.ws_hq.hostdbname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ws_hq.hostdbname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ws_hq.hostdbname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ws_hq.hostdbname = testData2s;
      print(sys_param.ws_hq.hostdbname);
      expect(sys_param.ws_hq.hostdbname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ws_hq.hostdbname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ws_hq.hostdbname = defalut;
      print(sys_param.ws_hq.hostdbname);
      expect(sys_param.ws_hq.hostdbname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ws_hq.hostdbname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00244_element_check_00221 **********\n\n");
    });

    test('00245_element_check_00222', () async {
      print("\n********** テスト実行：00245_element_check_00222 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ws_hq.hostdbuser;
      print(sys_param.ws_hq.hostdbuser);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ws_hq.hostdbuser = testData1s;
      print(sys_param.ws_hq.hostdbuser);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ws_hq.hostdbuser == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ws_hq.hostdbuser == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ws_hq.hostdbuser = testData2s;
      print(sys_param.ws_hq.hostdbuser);
      expect(sys_param.ws_hq.hostdbuser == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ws_hq.hostdbuser == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ws_hq.hostdbuser = defalut;
      print(sys_param.ws_hq.hostdbuser);
      expect(sys_param.ws_hq.hostdbuser == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ws_hq.hostdbuser == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00245_element_check_00222 **********\n\n");
    });

    test('00246_element_check_00223', () async {
      print("\n********** テスト実行：00246_element_check_00223 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.ws_hq.hostdbpass;
      print(sys_param.ws_hq.hostdbpass);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.ws_hq.hostdbpass = testData1s;
      print(sys_param.ws_hq.hostdbpass);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.ws_hq.hostdbpass == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.ws_hq.hostdbpass == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.ws_hq.hostdbpass = testData2s;
      print(sys_param.ws_hq.hostdbpass);
      expect(sys_param.ws_hq.hostdbpass == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ws_hq.hostdbpass == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.ws_hq.hostdbpass = defalut;
      print(sys_param.ws_hq.hostdbpass);
      expect(sys_param.ws_hq.hostdbpass == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.ws_hq.hostdbpass == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00246_element_check_00223 **********\n\n");
    });

    test('00247_element_check_00224', () async {
      print("\n********** テスト実行：00247_element_check_00224 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.recovery_file.name;
      print(sys_param.recovery_file.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.recovery_file.name = testData1s;
      print(sys_param.recovery_file.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.recovery_file.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.recovery_file.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.recovery_file.name = testData2s;
      print(sys_param.recovery_file.name);
      expect(sys_param.recovery_file.name == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.recovery_file.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.recovery_file.name = defalut;
      print(sys_param.recovery_file.name);
      expect(sys_param.recovery_file.name == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.recovery_file.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00247_element_check_00224 **********\n\n");
    });

    test('00248_element_check_00225', () async {
      print("\n********** テスト実行：00248_element_check_00225 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.recovery_file.loginname;
      print(sys_param.recovery_file.loginname);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.recovery_file.loginname = testData1s;
      print(sys_param.recovery_file.loginname);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.recovery_file.loginname == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.recovery_file.loginname == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.recovery_file.loginname = testData2s;
      print(sys_param.recovery_file.loginname);
      expect(sys_param.recovery_file.loginname == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.recovery_file.loginname == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.recovery_file.loginname = defalut;
      print(sys_param.recovery_file.loginname);
      expect(sys_param.recovery_file.loginname == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.recovery_file.loginname == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00248_element_check_00225 **********\n\n");
    });

    test('00249_element_check_00226', () async {
      print("\n********** テスト実行：00249_element_check_00226 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.recovery_file.password;
      print(sys_param.recovery_file.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.recovery_file.password = testData1s;
      print(sys_param.recovery_file.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.recovery_file.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.recovery_file.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.recovery_file.password = testData2s;
      print(sys_param.recovery_file.password);
      expect(sys_param.recovery_file.password == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.recovery_file.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.recovery_file.password = defalut;
      print(sys_param.recovery_file.password);
      expect(sys_param.recovery_file.password == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.recovery_file.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00249_element_check_00226 **********\n\n");
    });

    test('00250_element_check_00227', () async {
      print("\n********** テスト実行：00250_element_check_00227 **********");

      sys_param = Sys_paramJsonFile();
      allPropatyCheckInit(sys_param);

      // ①loadを実行する。
      await sys_param.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sys_param.recovery_file.remotepath;
      print(sys_param.recovery_file.remotepath);

      // ②指定したプロパティにテストデータ1を書き込む。
      sys_param.recovery_file.remotepath = testData1s;
      print(sys_param.recovery_file.remotepath);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sys_param.recovery_file.remotepath == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sys_param.save();
      await sys_param.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sys_param.recovery_file.remotepath == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sys_param.recovery_file.remotepath = testData2s;
      print(sys_param.recovery_file.remotepath);
      expect(sys_param.recovery_file.remotepath == testData2s, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.recovery_file.remotepath == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sys_param.recovery_file.remotepath = defalut;
      print(sys_param.recovery_file.remotepath);
      expect(sys_param.recovery_file.remotepath == defalut, true);
      await sys_param.save();
      await sys_param.load();
      expect(sys_param.recovery_file.remotepath == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sys_param, true);

      print("********** テスト終了：00250_element_check_00227 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Sys_paramJsonFile test)
{
  expect(test.db.name, "");
  expect(test.db.localdbname, "");
  expect(test.db.localdbuser, "");
  expect(test.db.localdbpass, "");
  expect(test.db.hostdbname, "");
  expect(test.db.hostdbuser, "");
  expect(test.db.hostdbpass, "");
  expect(test.db.masterdbname, "");
  expect(test.db.masterdbuser, "");
  expect(test.db.masterdbpass, "");
  expect(test.db.db_connect_timeout, 0);
  expect(test.db.tswebsvrname, "");
  expect(test.server.name, "");
  expect(test.server.loginname, "");
  expect(test.server.password, "");
  expect(test.server.remotepath, "");
  expect(test.server.remoteverpath, "");
  expect(test.server.remotebmppath, "");
  expect(test.server.prggetpath, "");
  expect(test.server.verupstsputpath, "");
  expect(test.server.remotetranpath, "");
  expect(test.server.remotepath_webapi, "");
  expect(test.server.url, "");
  expect(test.master.name, "");
  expect(test.master.loginname, "");
  expect(test.master.password, "");
  expect(test.master.remotepath, "");
  expect(test.master.remoteverpath, "");
  expect(test.master.remotebmppath, "");
  expect(test.master.prggetpath, "");
  expect(test.master.verupstsputpath, "");
  expect(test.master.remotetranpath, "");
  expect(test.subserver.name, "");
  expect(test.mm_system.max_connect, 0);
  expect(test.mm_system.maxBackends, 0);
  expect(test.mm_system.nBuffers, 0);
  expect(test.hq.name, "");
  expect(test.hq.loginname, "");
  expect(test.hq.password, "");
  expect(test.hq.remotepath, "");
  expect(test.hq.remotepath_rcv, "");
  expect(test.hq.hostname, "");
  expect(test.hq.userid, "");
  expect(test.hq.userpass, "");
  expect(test.hq.compcd, 0);
  expect(test.hq.url, "");
  expect(test.hq.inq_retry_cnt, 0);
  expect(test.hq.inq_retry_time, 0);
  expect(test.hq.offsend_time, 0);
  expect(test.hq.offlimit_cnt, 0);
  expect(test.hq.ftp_port, 0);
  expect(test.hq.ftp_protocol, 0);
  expect(test.hq.ftp_pasv, 0);
  expect(test.hq.ftp_retrycnt, 0);
  expect(test.hq.daycls_time, 0);
  expect(test.netDoA.histup_url, "");
  expect(test.netDoA.histdown_url, "");
  expect(test.netDoA.fileup_url, "");
  expect(test.netDoA.filedown_url, "");
  expect(test.netDoA.auth_user, "");
  expect(test.netDoA.auth_pass, "");
  expect(test.netDoA.fileup_retry_cnt, 0);
  expect(test.netDoA.filedown_retry_cnt, 0);
  expect(test.netDoA.verify_check, 0);
  expect(test.ht_server.name, "");
  expect(test.ht_server.loginname, "");
  expect(test.ht_server.password, "");
  expect(test.ht_server.remotepath, "");
  expect(test.ht_master.name, "");
  expect(test.ht_master.loginname, "");
  expect(test.ht_master.password, "");
  expect(test.ht_master.remotepath, "");
  expect(test.ip_addr.manage_pc, "");
  expect(test.ip_addr.name, "");
  expect(test.ip_addr.loginname, "");
  expect(test.ip_addr.password, "");
  expect(test.ip_addr.remotepath, "");
  expect(test.ip_addr.remotebmppath, "");
  expect(test.mobile.name, "");
  expect(test.mobile.loginname, "");
  expect(test.mobile.password, "");
  expect(test.mobile.remotepath, "");
  expect(test.poppy.name, "");
  expect(test.poppy.loginname, "");
  expect(test.poppy.password, "");
  expect(test.poppy.remotepath, "");
  expect(test.mclog.name, "");
  expect(test.mclog.loginname, "");
  expect(test.mclog.password, "");
  expect(test.mclog.remotepath, "");
  expect(test.catalina.ca_ipaddr, "");
  expect(test.catalina.ca_port, "");
  expect(test.custrealsvr.timeout, 0);
  expect(test.custrealsvr.retrywaittime, 0);
  expect(test.custrealsvr.retrycnt, 0);
  expect(test.custrealsvr.url, "");
  expect(test.testmode.cnt_max, 0);
  expect(test.landisk.name, "");
  expect(test.landisk.loginname, "");
  expect(test.landisk.password, "");
  expect(test.landisk.remotepath, "");
  expect(test.hq2.name, "");
  expect(test.hq2.loginname, "");
  expect(test.hq2.password, "");
  expect(test.hq2.remotepath, "");
  expect(test.hq2.remotepath_rcv, "");
  expect(test.hq2.hostname, "");
  expect(test.hqimg.name, "");
  expect(test.hqimg.loginname, "");
  expect(test.hqimg.password, "");
  expect(test.hqimg.remotepath, "");
  expect(test.sims2100.name, "");
  expect(test.sims2100.loginname, "");
  expect(test.sims2100.password, "");
  expect(test.sims2100.remotepath_xpm, "");
  expect(test.sims2100.remotepath_ssps, "");
  expect(test.sims2100.remotepath_acx, "");
  expect(test.sims2100.remotepath_bmp, "");
  expect(test.sims2100.remotepath_cpy, "");
  expect(test.sims2100.remotepath_tmp, "");
  expect(test.sims2100.remotepath_webapi, "");
  expect(test.sims2100.res_cycle, 0);
  expect(test.sims2100.ftp_retry_cnt, 0);
  expect(test.sims2100.ftp_retry_time, 0);
  expect(test.https_host.https, "");
  expect(test.https_host.http, "");
  expect(test.https_host.proxy, "");
  expect(test.https_host.port, 0);
  expect(test.https_host.timeout, 0);
  expect(test.nttb_host.https, "");
  expect(test.nttb_host.http, "");
  expect(test.custsvr2.hbtime, 0);
  expect(test.custsvr2.offlinetime, 0);
  expect(test.proxy.address, "");
  expect(test.proxy.port, "");
  expect(test.hist_ftp.timeout, 0);
  expect(test.hist_ftp.retrycnt, 0);
  expect(test.ftp_time.freq_timeout, 0);
  expect(test.ftp_time.freq_retrycnt, 0);
  expect(test.movie_server.name, "");
  expect(test.movie_server.loginname, "");
  expect(test.movie_server.password, "");
  expect(test.movie_server.remotepath, "");
  expect(test.hq_2nd.name, "");
  expect(test.hq_2nd.loginname, "");
  expect(test.hq_2nd.password, "");
  expect(test.hq_2nd.remotepath, "");
  expect(test.hq_2nd.remotepath_rcv, "");
  expect(test.hq_2nd.ftp_port, 0);
  expect(test.hq_2nd.ftp_protocol, 0);
  expect(test.hq_2nd.ftp_pasv, 0);
  expect(test.hq_2nd.ftp_timeout, 0);
  expect(test.hq_2nd.ftp_retrycnt, 0);
  expect(test.hq_2nd.ftp_retrywait, 0);
  expect(test.verup_cnct.name, "");
  expect(test.verup_cnct.loginname, "");
  expect(test.verup_cnct.password, "");
  expect(test.verup_cnct.prggetpath, "");
  expect(test.verup_cnct.remotepath, "");
  expect(test.verup_cnct.remoteverpath, "");
  expect(test.verup_cnct.verupstsputpath, "");
  expect(test.verup_cnct.imagepath, "");
  expect(test.caps_cardnet_store.store_code, "");
  expect(test.caps_cardnet_store.store_name, "");
  expect(test.caps_cardnet_store.place, "");
  expect(test.custreal2_pa.timeout, 0);
  expect(test.custreal2_pa.retrywaittime, 0);
  expect(test.custreal2_pa.retrycnt, 0);
  expect(test.custreal2_pa.conect_typ, 0);
  expect(test.tsweb_sh.wait_time, 0);
  expect(test.tsweb_sh.retry_count, 0);
  expect(test.tsweb_sh.wait_ftp_beforetime, 0);
  expect(test.bkup_save.name, "");
  expect(test.bkup_save.loginname, "");
  expect(test.bkup_save.password, "");
  expect(test.bkup_save.remotepath, "");
  expect(test.histlog_server.name, "");
  expect(test.cashrecycle.soc_timeout, 0);
  expect(test.pack_on_time.name, "");
  expect(test.pack_on_time.loginname, "");
  expect(test.pack_on_time.password, "");
  expect(test.pack_on_time.remotepath, "");
  expect(test.pack_on_time.remotepath_rcv, "");
  expect(test.pack_on_time.interval, 0);
  expect(test.ts_gyoumu.name, "");
  expect(test.ts_gyoumu.loginname, "");
  expect(test.ts_gyoumu.password, "");
  expect(test.ts_gyoumu.remotepath, "");
  expect(test.ts_gyoumu.remotepath_rcv, "");
  expect(test.ts_gyoumu.ftp_port, 0);
  expect(test.ts_gyoumu.ftp_protocol, 0);
  expect(test.ts_gyoumu.ftp_pasv, 0);
  expect(test.ts_gyoumu.ftp_retrycnt, 0);
  expect(test.apl_curl_post_opt.connect_timeout, 0);
  expect(test.apl_curl_post_opt.low_speed_time, 0);
  expect(test.apl_curl_post_opt.low_speed_limit, 0);
  expect(test.apl_curl_post_opt.retry_wait, 0);
  expect(test.apl_curl_ftp_opt.connect_timeout, 0);
  expect(test.apl_curl_ftp_opt.low_speed_time, 0);
  expect(test.apl_curl_ftp_opt.low_speed_limit, 0);
  expect(test.apl_curl_ftp_opt.retry_wait, 0);
  expect(test.cust_reserve_db.hostdbname, "");
  expect(test.cust_reserve_db.hostdbuser, "");
  expect(test.cust_reserve_db.hostdbpass, "");
  expect(test.dpoint.name, "");
  expect(test.dpoint.timeout, 0);
  expect(test.dpoint.sub_name, "");
  expect(test.dpoint.username, "");
  expect(test.dpoint.password, "");
  expect(test.spec_bkup.timeout2, 0);
  expect(test.spec_bkup.retrycnt, 0);
  expect(test.spec_bkup.sleep_time2, 0);
  expect(test.spec_bkup.sleep_cnt, 0);
  expect(test.spec_bkup.path, "");
  expect(test.spec_bkup.generation2, 0);
  expect(test.custreal_hps.Username, "");
  expect(test.custreal_hps.Password, "");
  expect(test.custreal_hps.rtl_id, 0);
  expect(test.custreal_hps.version, 0);
  expect(test.custreal_hps.device_div, 0);
  expect(test.ws_hq.hostdbname, "");
  expect(test.ws_hq.hostdbuser, "");
  expect(test.ws_hq.hostdbpass, "");
  expect(test.recovery_file.name, "");
  expect(test.recovery_file.loginname, "");
  expect(test.recovery_file.password, "");
  expect(test.recovery_file.remotepath, "");
}

void allPropatyCheck(Sys_paramJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.db.name, "ts21db");
  }
  expect(test.db.localdbname, "tpr_db");
  expect(test.db.localdbuser, "postgres");
  expect(test.db.localdbpass, "postgres");
  expect(test.db.hostdbname, "tsdb");
  expect(test.db.hostdbuser, "ts21ecr");
  expect(test.db.hostdbpass, "0012st");
  expect(test.db.masterdbname, "tpr_db");
  expect(test.db.masterdbuser, "postgres");
  expect(test.db.masterdbpass, "postgres");
  expect(test.db.db_connect_timeout, 28);
  expect(test.db.tswebsvrname, "tswebsvr");
  expect(test.server.name, "ts2100");
  expect(test.server.loginname, "ts21ecr");
  expect(test.server.password, "0012st");
  expect(test.server.remotepath, "~/tmp/");
  expect(test.server.remoteverpath, "~/tmp/");
  expect(test.server.remotebmppath, "~/bmp/");
  expect(test.server.prggetpath, "~/ftp/");
  expect(test.server.verupstsputpath, "~/ftp/");
  expect(test.server.remotetranpath, "~/rcv/");
  expect(test.server.remotepath_webapi, "~/sng/");
  expect(test.server.url, "https://ar.digi-tip-stg.com");
  expect(test.master.name, "ts2100");
  expect(test.master.loginname, "web2100");
  expect(test.master.password, "web2100");
  expect(test.master.remotepath, "/web21ftp/tmp/");
  expect(test.master.remoteverpath, "/web21ftp/tmp/");
  expect(test.master.remotebmppath, "/web21ftp/bmp/");
  expect(test.master.prggetpath, "/web21ftp/vup/");
  expect(test.master.verupstsputpath, "/web21ftp/vup/");
  expect(test.master.remotetranpath, "/web21ftp/tmp/");
  expect(test.subserver.name, "subsrx");
  expect(test.mm_system.max_connect, 5);
  expect(test.mm_system.maxBackends, 64);
  expect(test.mm_system.nBuffers, 1024);
  expect(test.hq.name, "hqserver");
  expect(test.hq.loginname, "anonymous");
  expect(test.hq.password, "anonymous");
  expect(test.hq.remotepath, "./");
  expect(test.hq.remotepath_rcv, "./");
  expect(test.hq.hostname, "hostname");
  expect(test.hq.userid, "anonymous");
  expect(test.hq.userpass, "anonymous");
  expect(test.hq.compcd, 0);
  expect(test.hq.url, "https://www.netdoa-nx.jp:7070/DT/CUST/DTRC0010010.php");
  expect(test.hq.inq_retry_cnt, 2);
  expect(test.hq.inq_retry_time, 1);
  expect(test.hq.offsend_time, 60);
  expect(test.hq.offlimit_cnt, 100);
  expect(test.hq.ftp_port, 0);
  expect(test.hq.ftp_protocol, 0);
  expect(test.hq.ftp_pasv, 0);
  expect(test.hq.ftp_retrycnt, 0);
  expect(test.hq.daycls_time, 10);
  expect(test.netDoA.histup_url, "https://www.netdoa-nx.jp/api/histlog_up.php");
  expect(test.netDoA.histdown_url, "https://www.netdoa-nx.jp/api/histlog_down.php");
  expect(test.netDoA.fileup_url, "https://www.netdoa-nx.jp/api/file_upload.php");
  expect(test.netDoA.filedown_url, "https://www.netdoa-nx.jp/api/file_download.php");
  expect(test.netDoA.auth_user, "medi");
  expect(test.netDoA.auth_pass, "teraoka");
  expect(test.netDoA.fileup_retry_cnt, 1);
  expect(test.netDoA.filedown_retry_cnt, 1);
  expect(test.netDoA.verify_check, 1);
  expect(test.ht_server.name, "ts2100");
  expect(test.ht_server.loginname, "ts21ecr");
  expect(test.ht_server.password, "0012st");
  expect(test.ht_server.remotepath, "~/tmp/");
  expect(test.ht_master.name, "ts2100");
  expect(test.ht_master.loginname, "web2100");
  expect(test.ht_master.password, "web2100");
  expect(test.ht_master.remotepath, "/web21ftp/mobile");
  expect(test.ip_addr.manage_pc, "0.0.0.0");
  expect(test.ip_addr.name, "manage");
  expect(test.ip_addr.loginname, "DIGI");
  expect(test.ip_addr.password, "DIGI");
  expect(test.ip_addr.remotepath, "./tmp/QRSrv/Tran");
  expect(test.ip_addr.remotebmppath, "./tmp/QRSrv/bmp");
  expect(test.mobile.name, "mblsvr");
  expect(test.mobile.loginname, "web2100");
  expect(test.mobile.password, "web2100");
  expect(test.mobile.remotepath, "/web21ftp/mobile");
  expect(test.poppy.name, "poppy");
  expect(test.poppy.loginname, "web2100poppy");
  expect(test.poppy.password, "web2100poppy");
  expect(test.poppy.remotepath, "./");
  expect(test.mclog.name, "compc");
  expect(test.mclog.loginname, "ts21adm");
  expect(test.mclog.password, "teraoka");
  expect(test.mclog.remotepath, "/ts2100/home/port/imp");
  expect(test.catalina.ca_ipaddr, "0.0.0.0");
  expect(test.catalina.ca_port, "0000");
  expect(test.custrealsvr.timeout, 3);
  expect(test.custrealsvr.retrywaittime, 1);
  expect(test.custrealsvr.retrycnt, 1);
  expect(test.custrealsvr.url, "anonymous");
  expect(test.testmode.cnt_max, 100);
  expect(test.landisk.name, "landisk");
  expect(test.landisk.loginname, "web2100");
  expect(test.landisk.password, "web2100");
  expect(test.landisk.remotepath, "./");
  expect(test.hq2.name, "hq2server");
  expect(test.hq2.loginname, "anonymous");
  expect(test.hq2.password, "anonymous");
  expect(test.hq2.remotepath, "./");
  expect(test.hq2.remotepath_rcv, "./");
  expect(test.hq2.hostname, "hostname");
  expect(test.hqimg.name, "hqimg_server");
  expect(test.hqimg.loginname, "anonymous");
  expect(test.hqimg.password, "anonymous");
  expect(test.hqimg.remotepath, "./webimgrcv/");
  expect(test.sims2100.name, "sims2100");
  expect(test.sims2100.loginname, "web2100");
  expect(test.sims2100.password, "web2100");
  expect(test.sims2100.remotepath_xpm, "/web21ftp/xpm/");
  expect(test.sims2100.remotepath_ssps, "/web21ftp/ssps/");
  expect(test.sims2100.remotepath_acx, "/web21ftp/acx/");
  expect(test.sims2100.remotepath_bmp, "/web21ftp/bmp/");
  expect(test.sims2100.remotepath_cpy, "/web21ftp/cpy/");
  expect(test.sims2100.remotepath_tmp, "/web21ftp/tmp/");
  expect(test.sims2100.remotepath_webapi, "/web21ftp/webapi/");
  expect(test.sims2100.res_cycle, 20);
  expect(test.sims2100.ftp_retry_cnt, 1);
  expect(test.sims2100.ftp_retry_time, 30);
  expect(test.https_host.https, "sv1.tenpovisor.jp");
  expect(test.https_host.http, "211.12.230.57");
  expect(test.https_host.proxy, "default");
  expect(test.https_host.port, 0);
  expect(test.https_host.timeout, 60);
  expect(test.nttb_host.https, "sv1.tenpovisor.jp");
  expect(test.nttb_host.http, "211.12.230.57");
  expect(test.custsvr2.hbtime, 5);
  expect(test.custsvr2.offlinetime, 6);
  expect(test.proxy.address, "default");
  expect(test.proxy.port, "0000");
  expect(test.hist_ftp.timeout, 180);
  expect(test.hist_ftp.retrycnt, 1);
  expect(test.ftp_time.freq_timeout, 180);
  expect(test.ftp_time.freq_retrycnt, 1);
  expect(test.movie_server.name, "mvserver");
  expect(test.movie_server.loginname, "web2100");
  expect(test.movie_server.password, "web2100");
  expect(test.movie_server.remotepath, "./Movie/");
  expect(test.hq_2nd.name, "hq_2nd_server");
  expect(test.hq_2nd.loginname, "anonymous");
  expect(test.hq_2nd.password, "anonymous");
  expect(test.hq_2nd.remotepath, "./");
  expect(test.hq_2nd.remotepath_rcv, "./");
  expect(test.hq_2nd.ftp_port, 0);
  expect(test.hq_2nd.ftp_protocol, 0);
  expect(test.hq_2nd.ftp_pasv, 0);
  expect(test.hq_2nd.ftp_timeout, 30);
  expect(test.hq_2nd.ftp_retrycnt, 0);
  expect(test.hq_2nd.ftp_retrywait, 10);
  expect(test.verup_cnct.name, "verup_cnct");
  expect(test.verup_cnct.loginname, "web2100");
  expect(test.verup_cnct.password, "web2100");
  expect(test.verup_cnct.prggetpath, "/web21ftp/vup/");
  expect(test.verup_cnct.remotepath, "/web21ftp/tmp/");
  expect(test.verup_cnct.remoteverpath, "/web21ftp/tmp/");
  expect(test.verup_cnct.verupstsputpath, "/web21ftp/vup/");
  expect(test.verup_cnct.imagepath, "/web21ftp/ssps/");
  expect(test.caps_cardnet_store.store_code, "9M999990000");
  expect(test.caps_cardnet_store.store_name, "TERAOKA");
  expect(test.caps_cardnet_store.place, "TOKYO");
  expect(test.custreal2_pa.timeout, 3);
  expect(test.custreal2_pa.retrywaittime, 1);
  expect(test.custreal2_pa.retrycnt, 1);
  expect(test.custreal2_pa.conect_typ, 0);
  expect(test.tsweb_sh.wait_time, 1);
  expect(test.tsweb_sh.retry_count, 50);
  expect(test.tsweb_sh.wait_ftp_beforetime, 1);
  expect(test.bkup_save.name, "bkup_save");
  expect(test.bkup_save.loginname, "web2100");
  expect(test.bkup_save.password, "web2100");
  expect(test.bkup_save.remotepath, "/home/web2100/spec_bkup/");
  expect(test.histlog_server.name, "histlog_server");
  expect(test.cashrecycle.soc_timeout, 5);
  expect(test.pack_on_time.name, "pack_on_time_svr");
  expect(test.pack_on_time.loginname, "ftp");
  expect(test.pack_on_time.password, "ftp");
  expect(test.pack_on_time.remotepath, "./RCV/POT/");
  expect(test.pack_on_time.remotepath_rcv, "./");
  expect(test.pack_on_time.interval, 5);
  expect(test.ts_gyoumu.name, "ts2100");
  expect(test.ts_gyoumu.loginname, "ts21ecr");
  expect(test.ts_gyoumu.password, "0012st");
  expect(test.ts_gyoumu.remotepath, "/ts2100/home/ts21ecr/tmp/");
  expect(test.ts_gyoumu.remotepath_rcv, "./");
  expect(test.ts_gyoumu.ftp_port, 0);
  expect(test.ts_gyoumu.ftp_protocol, 1);
  expect(test.ts_gyoumu.ftp_pasv, 0);
  expect(test.ts_gyoumu.ftp_retrycnt, 1);
  expect(test.apl_curl_post_opt.connect_timeout, 30);
  expect(test.apl_curl_post_opt.low_speed_time, 10);
  expect(test.apl_curl_post_opt.low_speed_limit, 128);
  expect(test.apl_curl_post_opt.retry_wait, 30);
  expect(test.apl_curl_ftp_opt.connect_timeout, 10);
  expect(test.apl_curl_ftp_opt.low_speed_time, 10);
  expect(test.apl_curl_ftp_opt.low_speed_limit, 128);
  expect(test.apl_curl_ftp_opt.retry_wait, 30);
  expect(test.cust_reserve_db.hostdbname, "tsdb");
  expect(test.cust_reserve_db.hostdbuser, "ts21ecr");
  expect(test.cust_reserve_db.hostdbpass, "0012st");
  expect(test.dpoint.name, "dpoint");
  expect(test.dpoint.timeout, 5);
  expect(test.dpoint.sub_name, "dpoint_rela_svr");
  expect(test.dpoint.username, "anonymous");
  expect(test.dpoint.password, "anonymous");
  expect(test.spec_bkup.timeout2, 180);
  expect(test.spec_bkup.retrycnt, 3);
  expect(test.spec_bkup.sleep_time2, 3);
  expect(test.spec_bkup.sleep_cnt, 10);
  expect(test.spec_bkup.path, "/home/web2100");
  expect(test.spec_bkup.generation2, 3);
  expect(test.custreal_hps.Username, "sa");
  expect(test.custreal_hps.Password, "hsv-pm7836");
  expect(test.custreal_hps.rtl_id, 0);
  expect(test.custreal_hps.version, 0);
  expect(test.custreal_hps.device_div, 0);
  expect(test.ws_hq.hostdbname, "tsdb");
  expect(test.ws_hq.hostdbuser, "ts21ecr");
  expect(test.ws_hq.hostdbpass, "0012st");
  expect(test.recovery_file.name, "recovery_file");
  expect(test.recovery_file.loginname, "anonymous");
  expect(test.recovery_file.password, "anonymous");
  expect(test.recovery_file.remotepath, "./");
}

