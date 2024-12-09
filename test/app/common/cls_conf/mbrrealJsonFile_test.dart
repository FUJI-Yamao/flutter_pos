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
import '../../../../lib/app/common/cls_conf/mbrrealJsonFile.dart';

late MbrrealJsonFile mbrreal;

void main(){
  mbrrealJsonFile_test();
}

void mbrrealJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "mbrreal.json";
  const String section = "JA";
  const String key = "KEN_CD";
  const defaultData = 11;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('MbrrealJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await MbrrealJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await MbrrealJsonFile().setDefault();
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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await mbrreal.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(mbrreal,true);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        mbrreal.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await mbrreal.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(mbrreal,true);

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
      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①：loadを実行する。
      await mbrreal.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = mbrreal.JA.KEN_CD;
      mbrreal.JA.KEN_CD = testData1;
      expect(mbrreal.JA.KEN_CD == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await mbrreal.load();
      expect(mbrreal.JA.KEN_CD != testData1, true);
      expect(mbrreal.JA.KEN_CD == prefixData, true);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = mbrreal.JA.KEN_CD;
      mbrreal.JA.KEN_CD = testData1;
      expect(mbrreal.JA.KEN_CD, testData1);

      // ③saveを実行する。
      await mbrreal.save();

      // ④loadを実行する。
      await mbrreal.load();

      expect(mbrreal.JA.KEN_CD != prefixData, true);
      expect(mbrreal.JA.KEN_CD == testData1, true);
      allPropatyCheck(mbrreal,false);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await mbrreal.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await mbrreal.save();

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await mbrreal.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(mbrreal.JA.KEN_CD, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = mbrreal.JA.KEN_CD;
      mbrreal.JA.KEN_CD = testData1;

      // ③ saveを実行する。
      await mbrreal.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(mbrreal.JA.KEN_CD, testData1);

      // ④ loadを実行する。
      await mbrreal.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(mbrreal.JA.KEN_CD == testData1, true);
      allPropatyCheck(mbrreal,false);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await mbrreal.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(mbrreal,true);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②任意のプロパティの値を変更する。
      mbrreal.JA.KEN_CD = testData1;
      expect(mbrreal.JA.KEN_CD, testData1);

      // ③saveを実行する。
      await mbrreal.save();
      expect(mbrreal.JA.KEN_CD, testData1);

      // ④loadを実行する。
      await mbrreal.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(mbrreal,true);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await mbrreal.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await mbrreal.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(mbrreal.JA.KEN_CD == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await mbrreal.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await mbrreal.setValueWithName(section, "test_key", testData1);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②任意のプロパティを変更する。
      mbrreal.JA.KEN_CD = testData1;

      // ③saveを実行する。
      await mbrreal.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await mbrreal.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②任意のプロパティを変更する。
      mbrreal.JA.KEN_CD = testData1;

      // ③saveを実行する。
      await mbrreal.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await mbrreal.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②任意のプロパティを変更する。
      mbrreal.JA.KEN_CD = testData1;

      // ③saveを実行する。
      await mbrreal.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await mbrreal.getValueWithName(section, "test_key");
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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await mbrreal.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      mbrreal.JA.KEN_CD = testData1;
      expect(mbrreal.JA.KEN_CD, testData1);

      // ④saveを実行する。
      await mbrreal.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(mbrreal.JA.KEN_CD, testData1);
      
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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await mbrreal.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + mbrreal.JA.KEN_CD.toString());
      expect(mbrreal.JA.KEN_CD == testData1, true);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await mbrreal.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + mbrreal.JA.KEN_CD.toString());
      expect(mbrreal.JA.KEN_CD == testData2, true);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await mbrreal.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + mbrreal.JA.KEN_CD.toString());
      expect(mbrreal.JA.KEN_CD == testData1, true);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await mbrreal.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + mbrreal.JA.KEN_CD.toString());
      expect(mbrreal.JA.KEN_CD == testData2, true);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await mbrreal.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + mbrreal.JA.KEN_CD.toString());
      expect(mbrreal.JA.KEN_CD == testData1, true);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await mbrreal.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + mbrreal.JA.KEN_CD.toString());
      expect(mbrreal.JA.KEN_CD == testData1, true);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await mbrreal.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + mbrreal.JA.KEN_CD.toString());
      allPropatyCheck(mbrreal,true);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await mbrreal.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + mbrreal.JA.KEN_CD.toString());
      allPropatyCheck(mbrreal,true);

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

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = mbrreal.JA.KEN_CD;
      print(mbrreal.JA.KEN_CD);

      // ②指定したプロパティにテストデータ1を書き込む。
      mbrreal.JA.KEN_CD = testData1;
      print(mbrreal.JA.KEN_CD);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(mbrreal.JA.KEN_CD == testData1, true);

      // ④saveを実行後、loadを実行する。
      await mbrreal.save();
      await mbrreal.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(mbrreal.JA.KEN_CD == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      mbrreal.JA.KEN_CD = testData2;
      print(mbrreal.JA.KEN_CD);
      expect(mbrreal.JA.KEN_CD == testData2, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.KEN_CD == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      mbrreal.JA.KEN_CD = defalut;
      print(mbrreal.JA.KEN_CD);
      expect(mbrreal.JA.KEN_CD == defalut, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.KEN_CD == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(mbrreal, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = mbrreal.JA.JA_CD;
      print(mbrreal.JA.JA_CD);

      // ②指定したプロパティにテストデータ1を書き込む。
      mbrreal.JA.JA_CD = testData1;
      print(mbrreal.JA.JA_CD);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(mbrreal.JA.JA_CD == testData1, true);

      // ④saveを実行後、loadを実行する。
      await mbrreal.save();
      await mbrreal.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(mbrreal.JA.JA_CD == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      mbrreal.JA.JA_CD = testData2;
      print(mbrreal.JA.JA_CD);
      expect(mbrreal.JA.JA_CD == testData2, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.JA_CD == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      mbrreal.JA.JA_CD = defalut;
      print(mbrreal.JA.JA_CD);
      expect(mbrreal.JA.JA_CD == defalut, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.JA_CD == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(mbrreal, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = mbrreal.JA.HND_BRCH_CD;
      print(mbrreal.JA.HND_BRCH_CD);

      // ②指定したプロパティにテストデータ1を書き込む。
      mbrreal.JA.HND_BRCH_CD = testData1s;
      print(mbrreal.JA.HND_BRCH_CD);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(mbrreal.JA.HND_BRCH_CD == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await mbrreal.save();
      await mbrreal.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(mbrreal.JA.HND_BRCH_CD == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      mbrreal.JA.HND_BRCH_CD = testData2s;
      print(mbrreal.JA.HND_BRCH_CD);
      expect(mbrreal.JA.HND_BRCH_CD == testData2s, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.HND_BRCH_CD == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      mbrreal.JA.HND_BRCH_CD = defalut;
      print(mbrreal.JA.HND_BRCH_CD);
      expect(mbrreal.JA.HND_BRCH_CD == defalut, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.HND_BRCH_CD == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(mbrreal, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = mbrreal.JA.KANGEN_KBN;
      print(mbrreal.JA.KANGEN_KBN);

      // ②指定したプロパティにテストデータ1を書き込む。
      mbrreal.JA.KANGEN_KBN = testData1;
      print(mbrreal.JA.KANGEN_KBN);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(mbrreal.JA.KANGEN_KBN == testData1, true);

      // ④saveを実行後、loadを実行する。
      await mbrreal.save();
      await mbrreal.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(mbrreal.JA.KANGEN_KBN == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      mbrreal.JA.KANGEN_KBN = testData2;
      print(mbrreal.JA.KANGEN_KBN);
      expect(mbrreal.JA.KANGEN_KBN == testData2, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.KANGEN_KBN == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      mbrreal.JA.KANGEN_KBN = defalut;
      print(mbrreal.JA.KANGEN_KBN);
      expect(mbrreal.JA.KANGEN_KBN == defalut, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.KANGEN_KBN == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(mbrreal, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = mbrreal.JA.KANGEN_CD;
      print(mbrreal.JA.KANGEN_CD);

      // ②指定したプロパティにテストデータ1を書き込む。
      mbrreal.JA.KANGEN_CD = testData1s;
      print(mbrreal.JA.KANGEN_CD);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(mbrreal.JA.KANGEN_CD == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await mbrreal.save();
      await mbrreal.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(mbrreal.JA.KANGEN_CD == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      mbrreal.JA.KANGEN_CD = testData2s;
      print(mbrreal.JA.KANGEN_CD);
      expect(mbrreal.JA.KANGEN_CD == testData2s, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.KANGEN_CD == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      mbrreal.JA.KANGEN_CD = defalut;
      print(mbrreal.JA.KANGEN_CD);
      expect(mbrreal.JA.KANGEN_CD == defalut, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.KANGEN_CD == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(mbrreal, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = mbrreal.JA.DTL_CD;
      print(mbrreal.JA.DTL_CD);

      // ②指定したプロパティにテストデータ1を書き込む。
      mbrreal.JA.DTL_CD = testData1s;
      print(mbrreal.JA.DTL_CD);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(mbrreal.JA.DTL_CD == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await mbrreal.save();
      await mbrreal.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(mbrreal.JA.DTL_CD == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      mbrreal.JA.DTL_CD = testData2s;
      print(mbrreal.JA.DTL_CD);
      expect(mbrreal.JA.DTL_CD == testData2s, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.DTL_CD == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      mbrreal.JA.DTL_CD = defalut;
      print(mbrreal.JA.DTL_CD);
      expect(mbrreal.JA.DTL_CD == defalut, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.DTL_CD == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(mbrreal, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = mbrreal.JA.BUSINESS_CD;
      print(mbrreal.JA.BUSINESS_CD);

      // ②指定したプロパティにテストデータ1を書き込む。
      mbrreal.JA.BUSINESS_CD = testData1;
      print(mbrreal.JA.BUSINESS_CD);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(mbrreal.JA.BUSINESS_CD == testData1, true);

      // ④saveを実行後、loadを実行する。
      await mbrreal.save();
      await mbrreal.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(mbrreal.JA.BUSINESS_CD == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      mbrreal.JA.BUSINESS_CD = testData2;
      print(mbrreal.JA.BUSINESS_CD);
      expect(mbrreal.JA.BUSINESS_CD == testData2, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.BUSINESS_CD == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      mbrreal.JA.BUSINESS_CD = defalut;
      print(mbrreal.JA.BUSINESS_CD);
      expect(mbrreal.JA.BUSINESS_CD == defalut, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.BUSINESS_CD == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(mbrreal, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = mbrreal.JA.DEAL_CD;
      print(mbrreal.JA.DEAL_CD);

      // ②指定したプロパティにテストデータ1を書き込む。
      mbrreal.JA.DEAL_CD = testData1;
      print(mbrreal.JA.DEAL_CD);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(mbrreal.JA.DEAL_CD == testData1, true);

      // ④saveを実行後、loadを実行する。
      await mbrreal.save();
      await mbrreal.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(mbrreal.JA.DEAL_CD == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      mbrreal.JA.DEAL_CD = testData2;
      print(mbrreal.JA.DEAL_CD);
      expect(mbrreal.JA.DEAL_CD == testData2, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.DEAL_CD == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      mbrreal.JA.DEAL_CD = defalut;
      print(mbrreal.JA.DEAL_CD);
      expect(mbrreal.JA.DEAL_CD == defalut, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.DEAL_CD == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(mbrreal, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = mbrreal.JA.CND_CD;
      print(mbrreal.JA.CND_CD);

      // ②指定したプロパティにテストデータ1を書き込む。
      mbrreal.JA.CND_CD = testData1s;
      print(mbrreal.JA.CND_CD);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(mbrreal.JA.CND_CD == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await mbrreal.save();
      await mbrreal.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(mbrreal.JA.CND_CD == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      mbrreal.JA.CND_CD = testData2s;
      print(mbrreal.JA.CND_CD);
      expect(mbrreal.JA.CND_CD == testData2s, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.CND_CD == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      mbrreal.JA.CND_CD = defalut;
      print(mbrreal.JA.CND_CD);
      expect(mbrreal.JA.CND_CD == defalut, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.CND_CD == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(mbrreal, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = mbrreal.JA.POINT_PT_CD;
      print(mbrreal.JA.POINT_PT_CD);

      // ②指定したプロパティにテストデータ1を書き込む。
      mbrreal.JA.POINT_PT_CD = testData1;
      print(mbrreal.JA.POINT_PT_CD);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(mbrreal.JA.POINT_PT_CD == testData1, true);

      // ④saveを実行後、loadを実行する。
      await mbrreal.save();
      await mbrreal.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(mbrreal.JA.POINT_PT_CD == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      mbrreal.JA.POINT_PT_CD = testData2;
      print(mbrreal.JA.POINT_PT_CD);
      expect(mbrreal.JA.POINT_PT_CD == testData2, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.POINT_PT_CD == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      mbrreal.JA.POINT_PT_CD = defalut;
      print(mbrreal.JA.POINT_PT_CD);
      expect(mbrreal.JA.POINT_PT_CD == defalut, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.POINT_PT_CD == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(mbrreal, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = mbrreal.JA.USER_ID;
      print(mbrreal.JA.USER_ID);

      // ②指定したプロパティにテストデータ1を書き込む。
      mbrreal.JA.USER_ID = testData1s;
      print(mbrreal.JA.USER_ID);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(mbrreal.JA.USER_ID == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await mbrreal.save();
      await mbrreal.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(mbrreal.JA.USER_ID == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      mbrreal.JA.USER_ID = testData2s;
      print(mbrreal.JA.USER_ID);
      expect(mbrreal.JA.USER_ID == testData2s, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.USER_ID == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      mbrreal.JA.USER_ID = defalut;
      print(mbrreal.JA.USER_ID);
      expect(mbrreal.JA.USER_ID == defalut, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.USER_ID == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(mbrreal, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      mbrreal = MbrrealJsonFile();
      allPropatyCheckInit(mbrreal);

      // ①loadを実行する。
      await mbrreal.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = mbrreal.JA.PASSWORD;
      print(mbrreal.JA.PASSWORD);

      // ②指定したプロパティにテストデータ1を書き込む。
      mbrreal.JA.PASSWORD = testData1s;
      print(mbrreal.JA.PASSWORD);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(mbrreal.JA.PASSWORD == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await mbrreal.save();
      await mbrreal.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(mbrreal.JA.PASSWORD == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      mbrreal.JA.PASSWORD = testData2s;
      print(mbrreal.JA.PASSWORD);
      expect(mbrreal.JA.PASSWORD == testData2s, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.PASSWORD == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      mbrreal.JA.PASSWORD = defalut;
      print(mbrreal.JA.PASSWORD);
      expect(mbrreal.JA.PASSWORD == defalut, true);
      await mbrreal.save();
      await mbrreal.load();
      expect(mbrreal.JA.PASSWORD == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(mbrreal, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

  });
}

void allPropatyCheckInit(MbrrealJsonFile test)
{
  expect(test.JA.KEN_CD, 0);
  expect(test.JA.JA_CD, 0);
  expect(test.JA.HND_BRCH_CD, "");
  expect(test.JA.KANGEN_KBN, 0);
  expect(test.JA.KANGEN_CD, "");
  expect(test.JA.DTL_CD, "");
  expect(test.JA.BUSINESS_CD, 0);
  expect(test.JA.DEAL_CD, 0);
  expect(test.JA.CND_CD, "");
  expect(test.JA.POINT_PT_CD, 0);
  expect(test.JA.USER_ID, "");
  expect(test.JA.PASSWORD, "");
}

void allPropatyCheck(MbrrealJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.JA.KEN_CD, 11);
  }
  expect(test.JA.JA_CD, 4735);
  expect(test.JA.HND_BRCH_CD, "0000");
  expect(test.JA.KANGEN_KBN, 5);
  expect(test.JA.KANGEN_CD, "001");
  expect(test.JA.DTL_CD, "00001");
  expect(test.JA.BUSINESS_CD, 3);
  expect(test.JA.DEAL_CD, 101);
  expect(test.JA.CND_CD, "000001");
  expect(test.JA.POINT_PT_CD, 2);
  expect(test.JA.USER_ID, "");
  expect(test.JA.PASSWORD, "");
}

