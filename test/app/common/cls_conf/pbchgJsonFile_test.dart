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
import '../../../../lib/app/common/cls_conf/pbchgJsonFile.dart';

late PbchgJsonFile pbchg;

void main(){
  pbchgJsonFile_test();
}

void pbchgJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "pbchg.json";
  const String section = "system";
  const String key = "termcd";
  const defaultData = 0;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('PbchgJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await PbchgJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await PbchgJsonFile().setDefault();
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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await pbchg.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(pbchg,true);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        pbchg.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await pbchg.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(pbchg,true);

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
      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①：loadを実行する。
      await pbchg.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = pbchg.system.termcd;
      pbchg.system.termcd = testData1;
      expect(pbchg.system.termcd == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await pbchg.load();
      expect(pbchg.system.termcd != testData1, true);
      expect(pbchg.system.termcd == prefixData, true);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = pbchg.system.termcd;
      pbchg.system.termcd = testData1;
      expect(pbchg.system.termcd, testData1);

      // ③saveを実行する。
      await pbchg.save();

      // ④loadを実行する。
      await pbchg.load();

      expect(pbchg.system.termcd != prefixData, true);
      expect(pbchg.system.termcd == testData1, true);
      allPropatyCheck(pbchg,false);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await pbchg.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await pbchg.save();

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await pbchg.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(pbchg.system.termcd, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = pbchg.system.termcd;
      pbchg.system.termcd = testData1;

      // ③ saveを実行する。
      await pbchg.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(pbchg.system.termcd, testData1);

      // ④ loadを実行する。
      await pbchg.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(pbchg.system.termcd == testData1, true);
      allPropatyCheck(pbchg,false);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await pbchg.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(pbchg,true);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②任意のプロパティの値を変更する。
      pbchg.system.termcd = testData1;
      expect(pbchg.system.termcd, testData1);

      // ③saveを実行する。
      await pbchg.save();
      expect(pbchg.system.termcd, testData1);

      // ④loadを実行する。
      await pbchg.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(pbchg,true);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await pbchg.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await pbchg.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(pbchg.system.termcd == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await pbchg.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await pbchg.setValueWithName(section, "test_key", testData1);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②任意のプロパティを変更する。
      pbchg.system.termcd = testData1;

      // ③saveを実行する。
      await pbchg.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await pbchg.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②任意のプロパティを変更する。
      pbchg.system.termcd = testData1;

      // ③saveを実行する。
      await pbchg.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await pbchg.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②任意のプロパティを変更する。
      pbchg.system.termcd = testData1;

      // ③saveを実行する。
      await pbchg.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await pbchg.getValueWithName(section, "test_key");
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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await pbchg.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      pbchg.system.termcd = testData1;
      expect(pbchg.system.termcd, testData1);

      // ④saveを実行する。
      await pbchg.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(pbchg.system.termcd, testData1);
      
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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await pbchg.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + pbchg.system.termcd.toString());
      expect(pbchg.system.termcd == testData1, true);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await pbchg.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + pbchg.system.termcd.toString());
      expect(pbchg.system.termcd == testData2, true);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await pbchg.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + pbchg.system.termcd.toString());
      expect(pbchg.system.termcd == testData1, true);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await pbchg.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + pbchg.system.termcd.toString());
      expect(pbchg.system.termcd == testData2, true);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await pbchg.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + pbchg.system.termcd.toString());
      expect(pbchg.system.termcd == testData1, true);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await pbchg.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + pbchg.system.termcd.toString());
      expect(pbchg.system.termcd == testData1, true);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await pbchg.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + pbchg.system.termcd.toString());
      allPropatyCheck(pbchg,true);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await pbchg.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + pbchg.system.termcd.toString());
      allPropatyCheck(pbchg,true);

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

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.system.termcd;
      print(pbchg.system.termcd);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.system.termcd = testData1;
      print(pbchg.system.termcd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.system.termcd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.system.termcd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.system.termcd = testData2;
      print(pbchg.system.termcd);
      expect(pbchg.system.termcd == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.system.termcd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.system.termcd = defalut;
      print(pbchg.system.termcd);
      expect(pbchg.system.termcd == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.system.termcd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.system.groupcd;
      print(pbchg.system.groupcd);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.system.groupcd = testData1;
      print(pbchg.system.groupcd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.system.groupcd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.system.groupcd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.system.groupcd = testData2;
      print(pbchg.system.groupcd);
      expect(pbchg.system.groupcd == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.system.groupcd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.system.groupcd = defalut;
      print(pbchg.system.groupcd);
      expect(pbchg.system.groupcd == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.system.groupcd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.system.officecd;
      print(pbchg.system.officecd);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.system.officecd = testData1;
      print(pbchg.system.officecd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.system.officecd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.system.officecd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.system.officecd = testData2;
      print(pbchg.system.officecd);
      expect(pbchg.system.officecd == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.system.officecd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.system.officecd = defalut;
      print(pbchg.system.officecd);
      expect(pbchg.system.officecd == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.system.officecd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.system.strecd;
      print(pbchg.system.strecd);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.system.strecd = testData1;
      print(pbchg.system.strecd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.system.strecd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.system.strecd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.system.strecd = testData2;
      print(pbchg.system.strecd);
      expect(pbchg.system.strecd == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.system.strecd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.system.strecd = defalut;
      print(pbchg.system.strecd);
      expect(pbchg.system.strecd == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.system.strecd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.count.dealseqno;
      print(pbchg.count.dealseqno);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.count.dealseqno = testData1;
      print(pbchg.count.dealseqno);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.count.dealseqno == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.count.dealseqno == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.count.dealseqno = testData2;
      print(pbchg.count.dealseqno);
      expect(pbchg.count.dealseqno == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.count.dealseqno == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.count.dealseqno = defalut;
      print(pbchg.count.dealseqno);
      expect(pbchg.count.dealseqno == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.count.dealseqno == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.count.serviceseqno;
      print(pbchg.count.serviceseqno);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.count.serviceseqno = testData1;
      print(pbchg.count.serviceseqno);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.count.serviceseqno == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.count.serviceseqno == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.count.serviceseqno = testData2;
      print(pbchg.count.serviceseqno);
      expect(pbchg.count.serviceseqno == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.count.serviceseqno == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.count.serviceseqno = defalut;
      print(pbchg.count.serviceseqno);
      expect(pbchg.count.serviceseqno == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.count.serviceseqno == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.tran.steps;
      print(pbchg.tran.steps);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.tran.steps = testData1;
      print(pbchg.tran.steps);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.tran.steps == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.tran.steps == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.tran.steps = testData2;
      print(pbchg.tran.steps);
      expect(pbchg.tran.steps == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.tran.steps == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.tran.steps = defalut;
      print(pbchg.tran.steps);
      expect(pbchg.tran.steps == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.tran.steps == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.tran.res_sel;
      print(pbchg.tran.res_sel);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.tran.res_sel = testData1;
      print(pbchg.tran.res_sel);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.tran.res_sel == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.tran.res_sel == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.tran.res_sel = testData2;
      print(pbchg.tran.res_sel);
      expect(pbchg.tran.res_sel == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.tran.res_sel == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.tran.res_sel = defalut;
      print(pbchg.tran.res_sel);
      expect(pbchg.tran.res_sel == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.tran.res_sel == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.tran.fee1_sel;
      print(pbchg.tran.fee1_sel);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.tran.fee1_sel = testData1;
      print(pbchg.tran.fee1_sel);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.tran.fee1_sel == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.tran.fee1_sel == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.tran.fee1_sel = testData2;
      print(pbchg.tran.fee1_sel);
      expect(pbchg.tran.fee1_sel == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.tran.fee1_sel == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.tran.fee1_sel = defalut;
      print(pbchg.tran.fee1_sel);
      expect(pbchg.tran.fee1_sel == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.tran.fee1_sel == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.tran.fee2_sel;
      print(pbchg.tran.fee2_sel);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.tran.fee2_sel = testData1;
      print(pbchg.tran.fee2_sel);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.tran.fee2_sel == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.tran.fee2_sel == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.tran.fee2_sel = testData2;
      print(pbchg.tran.fee2_sel);
      expect(pbchg.tran.fee2_sel == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.tran.fee2_sel == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.tran.fee2_sel = defalut;
      print(pbchg.tran.fee2_sel);
      expect(pbchg.tran.fee2_sel == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.tran.fee2_sel == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.retry.cnct;
      print(pbchg.retry.cnct);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.retry.cnct = testData1;
      print(pbchg.retry.cnct);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.retry.cnct == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.retry.cnct == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.retry.cnct = testData2;
      print(pbchg.retry.cnct);
      expect(pbchg.retry.cnct == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.retry.cnct == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.retry.cnct = defalut;
      print(pbchg.retry.cnct);
      expect(pbchg.retry.cnct == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.retry.cnct == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.retry.interval;
      print(pbchg.retry.interval);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.retry.interval = testData1;
      print(pbchg.retry.interval);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.retry.interval == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.retry.interval == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.retry.interval = testData2;
      print(pbchg.retry.interval);
      expect(pbchg.retry.interval == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.retry.interval == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.retry.interval = defalut;
      print(pbchg.retry.interval);
      expect(pbchg.retry.interval == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.retry.interval == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.retry.cnt;
      print(pbchg.retry.cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.retry.cnt = testData1;
      print(pbchg.retry.cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.retry.cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.retry.cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.retry.cnt = testData2;
      print(pbchg.retry.cnt);
      expect(pbchg.retry.cnt == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.retry.cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.retry.cnt = defalut;
      print(pbchg.retry.cnt);
      expect(pbchg.retry.cnt == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.retry.cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.retry.rd_timeout;
      print(pbchg.retry.rd_timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.retry.rd_timeout = testData1;
      print(pbchg.retry.rd_timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.retry.rd_timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.retry.rd_timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.retry.rd_timeout = testData2;
      print(pbchg.retry.rd_timeout);
      expect(pbchg.retry.rd_timeout == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.retry.rd_timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.retry.rd_timeout = defalut;
      print(pbchg.retry.rd_timeout);
      expect(pbchg.retry.rd_timeout == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.retry.rd_timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.retry.wt_timeout;
      print(pbchg.retry.wt_timeout);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.retry.wt_timeout = testData1;
      print(pbchg.retry.wt_timeout);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.retry.wt_timeout == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.retry.wt_timeout == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.retry.wt_timeout = testData2;
      print(pbchg.retry.wt_timeout);
      expect(pbchg.retry.wt_timeout == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.retry.wt_timeout == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.retry.wt_timeout = defalut;
      print(pbchg.retry.wt_timeout);
      expect(pbchg.retry.wt_timeout == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.retry.wt_timeout == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.save_.month;
      print(pbchg.save_.month);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.save_.month = testData1;
      print(pbchg.save_.month);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.save_.month == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.save_.month == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.save_.month = testData2;
      print(pbchg.save_.month);
      expect(pbchg.save_.month == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.save_.month == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.save_.month = defalut;
      print(pbchg.save_.month);
      expect(pbchg.save_.month == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.save_.month == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.download.date;
      print(pbchg.download.date);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.download.date = testData1s;
      print(pbchg.download.date);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.download.date == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.download.date == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.download.date = testData2s;
      print(pbchg.download.date);
      expect(pbchg.download.date == testData2s, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.download.date == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.download.date = defalut;
      print(pbchg.download.date);
      expect(pbchg.download.date == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.download.date == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.download.result;
      print(pbchg.download.result);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.download.result = testData1;
      print(pbchg.download.result);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.download.result == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.download.result == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.download.result = testData2;
      print(pbchg.download.result);
      expect(pbchg.download.result == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.download.result == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.download.result = defalut;
      print(pbchg.download.result);
      expect(pbchg.download.result == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.download.result == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      pbchg = PbchgJsonFile();
      allPropatyCheckInit(pbchg);

      // ①loadを実行する。
      await pbchg.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pbchg.util.exec;
      print(pbchg.util.exec);

      // ②指定したプロパティにテストデータ1を書き込む。
      pbchg.util.exec = testData1;
      print(pbchg.util.exec);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pbchg.util.exec == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pbchg.save();
      await pbchg.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pbchg.util.exec == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pbchg.util.exec = testData2;
      print(pbchg.util.exec);
      expect(pbchg.util.exec == testData2, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.util.exec == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pbchg.util.exec = defalut;
      print(pbchg.util.exec);
      expect(pbchg.util.exec == defalut, true);
      await pbchg.save();
      await pbchg.load();
      expect(pbchg.util.exec == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pbchg, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

  });
}

void allPropatyCheckInit(PbchgJsonFile test)
{
  expect(test.system.termcd, 0);
  expect(test.system.groupcd, 0);
  expect(test.system.officecd, 0);
  expect(test.system.strecd, 0);
  expect(test.count.dealseqno, 0);
  expect(test.count.serviceseqno, 0);
  expect(test.tran.steps, 0);
  expect(test.tran.res_sel, 0);
  expect(test.tran.fee1_sel, 0);
  expect(test.tran.fee2_sel, 0);
  expect(test.retry.cnct, 0);
  expect(test.retry.interval, 0);
  expect(test.retry.cnt, 0);
  expect(test.retry.rd_timeout, 0);
  expect(test.retry.wt_timeout, 0);
  expect(test.save_.month, 0);
  expect(test.download.date, "");
  expect(test.download.result, 0);
  expect(test.util.exec, 0);
}

void allPropatyCheck(PbchgJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.system.termcd, 0);
  }
  expect(test.system.groupcd, 0);
  expect(test.system.officecd, 0);
  expect(test.system.strecd, 0);
  expect(test.count.dealseqno, 1);
  expect(test.count.serviceseqno, 1);
  expect(test.tran.steps, 95);
  expect(test.tran.res_sel, 5);
  expect(test.tran.fee1_sel, 6);
  expect(test.tran.fee2_sel, 7);
  expect(test.retry.cnct, 20);
  expect(test.retry.interval, 30);
  expect(test.retry.cnt, 4);
  expect(test.retry.rd_timeout, 60);
  expect(test.retry.wt_timeout, 60);
  expect(test.save_.month, 13);
  expect(test.download.date, "00000000000000");
  expect(test.download.result, 0);
  expect(test.util.exec, 0);
}

