﻿/*
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
import '../../../../lib/app/common/cls_conf/vup_infoJsonFile.dart';

late Vup_infoJsonFile vup_info;

void main(){
  vup_infoJsonFile_test();
}

void vup_infoJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "vup_info.json";
  const String section = "vup_info";
  const String key = "vup_exe";
  const defaultData = 0;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Vup_infoJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Vup_infoJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Vup_infoJsonFile().setDefault();
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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await vup_info.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(vup_info,true);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        vup_info.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await vup_info.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(vup_info,true);

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
      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①：loadを実行する。
      await vup_info.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = vup_info.vup_info.vup_exe;
      vup_info.vup_info.vup_exe = testData1;
      expect(vup_info.vup_info.vup_exe == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await vup_info.load();
      expect(vup_info.vup_info.vup_exe != testData1, true);
      expect(vup_info.vup_info.vup_exe == prefixData, true);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①loadを実行する。
      await vup_info.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = vup_info.vup_info.vup_exe;
      vup_info.vup_info.vup_exe = testData1;
      expect(vup_info.vup_info.vup_exe, testData1);

      // ③saveを実行する。
      await vup_info.save();

      // ④loadを実行する。
      await vup_info.load();

      expect(vup_info.vup_info.vup_exe != prefixData, true);
      expect(vup_info.vup_info.vup_exe == testData1, true);
      allPropatyCheck(vup_info,false);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await vup_info.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await vup_info.save();

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await vup_info.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(vup_info.vup_info.vup_exe, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = vup_info.vup_info.vup_exe;
      vup_info.vup_info.vup_exe = testData1;

      // ③ saveを実行する。
      await vup_info.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(vup_info.vup_info.vup_exe, testData1);

      // ④ loadを実行する。
      await vup_info.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(vup_info.vup_info.vup_exe == testData1, true);
      allPropatyCheck(vup_info,false);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await vup_info.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(vup_info,true);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①loadを実行する。
      await vup_info.load();

      // ②任意のプロパティの値を変更する。
      vup_info.vup_info.vup_exe = testData1;
      expect(vup_info.vup_info.vup_exe, testData1);

      // ③saveを実行する。
      await vup_info.save();
      expect(vup_info.vup_info.vup_exe, testData1);

      // ④loadを実行する。
      await vup_info.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(vup_info,true);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await vup_info.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await vup_info.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(vup_info.vup_info.vup_exe == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await vup_info.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await vup_info.setValueWithName(section, "test_key", testData1);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①loadを実行する。
      await vup_info.load();

      // ②任意のプロパティを変更する。
      vup_info.vup_info.vup_exe = testData1;

      // ③saveを実行する。
      await vup_info.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await vup_info.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①loadを実行する。
      await vup_info.load();

      // ②任意のプロパティを変更する。
      vup_info.vup_info.vup_exe = testData1;

      // ③saveを実行する。
      await vup_info.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await vup_info.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①loadを実行する。
      await vup_info.load();

      // ②任意のプロパティを変更する。
      vup_info.vup_info.vup_exe = testData1;

      // ③saveを実行する。
      await vup_info.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await vup_info.getValueWithName(section, "test_key");
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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await vup_info.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      vup_info.vup_info.vup_exe = testData1;
      expect(vup_info.vup_info.vup_exe, testData1);

      // ④saveを実行する。
      await vup_info.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(vup_info.vup_info.vup_exe, testData1);
      
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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await vup_info.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + vup_info.vup_info.vup_exe.toString());
      expect(vup_info.vup_info.vup_exe == testData1, true);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await vup_info.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + vup_info.vup_info.vup_exe.toString());
      expect(vup_info.vup_info.vup_exe == testData2, true);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await vup_info.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + vup_info.vup_info.vup_exe.toString());
      expect(vup_info.vup_info.vup_exe == testData1, true);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await vup_info.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + vup_info.vup_info.vup_exe.toString());
      expect(vup_info.vup_info.vup_exe == testData2, true);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await vup_info.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + vup_info.vup_info.vup_exe.toString());
      expect(vup_info.vup_info.vup_exe == testData1, true);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await vup_info.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + vup_info.vup_info.vup_exe.toString());
      expect(vup_info.vup_info.vup_exe == testData1, true);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await vup_info.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + vup_info.vup_info.vup_exe.toString());
      allPropatyCheck(vup_info,true);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await vup_info.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + vup_info.vup_info.vup_exe.toString());
      allPropatyCheck(vup_info,true);

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

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①loadを実行する。
      await vup_info.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = vup_info.vup_info.vup_exe;
      print(vup_info.vup_info.vup_exe);

      // ②指定したプロパティにテストデータ1を書き込む。
      vup_info.vup_info.vup_exe = testData1;
      print(vup_info.vup_info.vup_exe);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(vup_info.vup_info.vup_exe == testData1, true);

      // ④saveを実行後、loadを実行する。
      await vup_info.save();
      await vup_info.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(vup_info.vup_info.vup_exe == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      vup_info.vup_info.vup_exe = testData2;
      print(vup_info.vup_info.vup_exe);
      expect(vup_info.vup_info.vup_exe == testData2, true);
      await vup_info.save();
      await vup_info.load();
      expect(vup_info.vup_info.vup_exe == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      vup_info.vup_info.vup_exe = defalut;
      print(vup_info.vup_info.vup_exe);
      expect(vup_info.vup_info.vup_exe == defalut, true);
      await vup_info.save();
      await vup_info.load();
      expect(vup_info.vup_info.vup_exe == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(vup_info, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      vup_info = Vup_infoJsonFile();
      allPropatyCheckInit(vup_info);

      // ①loadを実行する。
      await vup_info.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = vup_info.vup_info.reboot;
      print(vup_info.vup_info.reboot);

      // ②指定したプロパティにテストデータ1を書き込む。
      vup_info.vup_info.reboot = testData1;
      print(vup_info.vup_info.reboot);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(vup_info.vup_info.reboot == testData1, true);

      // ④saveを実行後、loadを実行する。
      await vup_info.save();
      await vup_info.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(vup_info.vup_info.reboot == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      vup_info.vup_info.reboot = testData2;
      print(vup_info.vup_info.reboot);
      expect(vup_info.vup_info.reboot == testData2, true);
      await vup_info.save();
      await vup_info.load();
      expect(vup_info.vup_info.reboot == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      vup_info.vup_info.reboot = defalut;
      print(vup_info.vup_info.reboot);
      expect(vup_info.vup_info.reboot == defalut, true);
      await vup_info.save();
      await vup_info.load();
      expect(vup_info.vup_info.reboot == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(vup_info, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Vup_infoJsonFile test)
{
  expect(test.vup_info.vup_exe, 0);
  expect(test.vup_info.reboot, 0);
}

void allPropatyCheck(Vup_infoJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.vup_info.vup_exe, 0);
  }
  expect(test.vup_info.reboot, 0);
}
