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
import '../../../../lib/app/common/cls_conf/mergeJsonFile.dart';

late MergeJsonFile merge;

void main(){
  mergeJsonFile_test();
}

void mergeJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "merge.json";
  const String section = "merge";
  const String key = "file01";
  const defaultData = "changer.json";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('MergeJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await MergeJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await MergeJsonFile().setDefault();
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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await merge.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(merge,true);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        merge.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await merge.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(merge,true);

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
      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①：loadを実行する。
      await merge.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = merge.merge.file01;
      merge.merge.file01 = testData1s;
      expect(merge.merge.file01 == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await merge.load();
      expect(merge.merge.file01 != testData1s, true);
      expect(merge.merge.file01 == prefixData, true);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = merge.merge.file01;
      merge.merge.file01 = testData1s;
      expect(merge.merge.file01, testData1s);

      // ③saveを実行する。
      await merge.save();

      // ④loadを実行する。
      await merge.load();

      expect(merge.merge.file01 != prefixData, true);
      expect(merge.merge.file01 == testData1s, true);
      allPropatyCheck(merge,false);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await merge.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await merge.save();

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await merge.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(merge.merge.file01, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = merge.merge.file01;
      merge.merge.file01 = testData1s;

      // ③ saveを実行する。
      await merge.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(merge.merge.file01, testData1s);

      // ④ loadを実行する。
      await merge.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(merge.merge.file01 == testData1s, true);
      allPropatyCheck(merge,false);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await merge.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(merge,true);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②任意のプロパティの値を変更する。
      merge.merge.file01 = testData1s;
      expect(merge.merge.file01, testData1s);

      // ③saveを実行する。
      await merge.save();
      expect(merge.merge.file01, testData1s);

      // ④loadを実行する。
      await merge.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(merge,true);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await merge.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await merge.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(merge.merge.file01 == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await merge.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await merge.setValueWithName(section, "test_key", testData1s);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②任意のプロパティを変更する。
      merge.merge.file01 = testData1s;

      // ③saveを実行する。
      await merge.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await merge.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②任意のプロパティを変更する。
      merge.merge.file01 = testData1s;

      // ③saveを実行する。
      await merge.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await merge.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②任意のプロパティを変更する。
      merge.merge.file01 = testData1s;

      // ③saveを実行する。
      await merge.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await merge.getValueWithName(section, "test_key");
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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await merge.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      merge.merge.file01 = testData1s;
      expect(merge.merge.file01, testData1s);

      // ④saveを実行する。
      await merge.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(merge.merge.file01, testData1s);
      
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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await merge.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + merge.merge.file01.toString());
      expect(merge.merge.file01 == testData1s, true);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await merge.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + merge.merge.file01.toString());
      expect(merge.merge.file01 == testData2s, true);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await merge.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + merge.merge.file01.toString());
      expect(merge.merge.file01 == testData1s, true);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await merge.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + merge.merge.file01.toString());
      expect(merge.merge.file01 == testData2s, true);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await merge.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + merge.merge.file01.toString());
      expect(merge.merge.file01 == testData1s, true);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await merge.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + merge.merge.file01.toString());
      expect(merge.merge.file01 == testData1s, true);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await merge.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + merge.merge.file01.toString());
      allPropatyCheck(merge,true);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await merge.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + merge.merge.file01.toString());
      allPropatyCheck(merge,true);

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

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file01;
      print(merge.merge.file01);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file01 = testData1s;
      print(merge.merge.file01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file01 = testData2s;
      print(merge.merge.file01);
      expect(merge.merge.file01 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file01 = defalut;
      print(merge.merge.file01);
      expect(merge.merge.file01 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file02;
      print(merge.merge.file02);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file02 = testData1s;
      print(merge.merge.file02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file02 = testData2s;
      print(merge.merge.file02);
      expect(merge.merge.file02 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file02 = defalut;
      print(merge.merge.file02);
      expect(merge.merge.file02 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file03;
      print(merge.merge.file03);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file03 = testData1s;
      print(merge.merge.file03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file03 = testData2s;
      print(merge.merge.file03);
      expect(merge.merge.file03 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file03 = defalut;
      print(merge.merge.file03);
      expect(merge.merge.file03 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file04;
      print(merge.merge.file04);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file04 = testData1s;
      print(merge.merge.file04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file04 = testData2s;
      print(merge.merge.file04);
      expect(merge.merge.file04 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file04 = defalut;
      print(merge.merge.file04);
      expect(merge.merge.file04 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file05;
      print(merge.merge.file05);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file05 = testData1s;
      print(merge.merge.file05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file05 = testData2s;
      print(merge.merge.file05);
      expect(merge.merge.file05 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file05 = defalut;
      print(merge.merge.file05);
      expect(merge.merge.file05 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file06;
      print(merge.merge.file06);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file06 = testData1s;
      print(merge.merge.file06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file06 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file06 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file06 = testData2s;
      print(merge.merge.file06);
      expect(merge.merge.file06 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file06 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file06 = defalut;
      print(merge.merge.file06);
      expect(merge.merge.file06 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file07;
      print(merge.merge.file07);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file07 = testData1s;
      print(merge.merge.file07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file07 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file07 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file07 = testData2s;
      print(merge.merge.file07);
      expect(merge.merge.file07 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file07 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file07 = defalut;
      print(merge.merge.file07);
      expect(merge.merge.file07 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file08;
      print(merge.merge.file08);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file08 = testData1s;
      print(merge.merge.file08);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file08 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file08 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file08 = testData2s;
      print(merge.merge.file08);
      expect(merge.merge.file08 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file08 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file08 = defalut;
      print(merge.merge.file08);
      expect(merge.merge.file08 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file08 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file09;
      print(merge.merge.file09);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file09 = testData1s;
      print(merge.merge.file09);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file09 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file09 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file09 = testData2s;
      print(merge.merge.file09);
      expect(merge.merge.file09 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file09 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file09 = defalut;
      print(merge.merge.file09);
      expect(merge.merge.file09 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file09 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file10;
      print(merge.merge.file10);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file10 = testData1s;
      print(merge.merge.file10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file10 = testData2s;
      print(merge.merge.file10);
      expect(merge.merge.file10 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file10 = defalut;
      print(merge.merge.file10);
      expect(merge.merge.file10 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file11;
      print(merge.merge.file11);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file11 = testData1s;
      print(merge.merge.file11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file11 = testData2s;
      print(merge.merge.file11);
      expect(merge.merge.file11 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file11 = defalut;
      print(merge.merge.file11);
      expect(merge.merge.file11 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file12;
      print(merge.merge.file12);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file12 = testData1s;
      print(merge.merge.file12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file12 = testData2s;
      print(merge.merge.file12);
      expect(merge.merge.file12 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file12 = defalut;
      print(merge.merge.file12);
      expect(merge.merge.file12 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file13;
      print(merge.merge.file13);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file13 = testData1s;
      print(merge.merge.file13);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file13 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file13 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file13 = testData2s;
      print(merge.merge.file13);
      expect(merge.merge.file13 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file13 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file13 = defalut;
      print(merge.merge.file13);
      expect(merge.merge.file13 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file13 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file14;
      print(merge.merge.file14);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file14 = testData1s;
      print(merge.merge.file14);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file14 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file14 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file14 = testData2s;
      print(merge.merge.file14);
      expect(merge.merge.file14 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file14 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file14 = defalut;
      print(merge.merge.file14);
      expect(merge.merge.file14 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file14 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file15;
      print(merge.merge.file15);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file15 = testData1s;
      print(merge.merge.file15);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file15 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file15 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file15 = testData2s;
      print(merge.merge.file15);
      expect(merge.merge.file15 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file15 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file15 = defalut;
      print(merge.merge.file15);
      expect(merge.merge.file15 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file15 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file16;
      print(merge.merge.file16);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file16 = testData1s;
      print(merge.merge.file16);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file16 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file16 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file16 = testData2s;
      print(merge.merge.file16);
      expect(merge.merge.file16 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file16 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file16 = defalut;
      print(merge.merge.file16);
      expect(merge.merge.file16 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file16 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file17;
      print(merge.merge.file17);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file17 = testData1s;
      print(merge.merge.file17);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file17 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file17 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file17 = testData2s;
      print(merge.merge.file17);
      expect(merge.merge.file17 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file17 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file17 = defalut;
      print(merge.merge.file17);
      expect(merge.merge.file17 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file17 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file18;
      print(merge.merge.file18);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file18 = testData1s;
      print(merge.merge.file18);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file18 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file18 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file18 = testData2s;
      print(merge.merge.file18);
      expect(merge.merge.file18 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file18 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file18 = defalut;
      print(merge.merge.file18);
      expect(merge.merge.file18 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file18 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file19;
      print(merge.merge.file19);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file19 = testData1s;
      print(merge.merge.file19);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file19 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file19 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file19 = testData2s;
      print(merge.merge.file19);
      expect(merge.merge.file19 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file19 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file19 = defalut;
      print(merge.merge.file19);
      expect(merge.merge.file19 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file19 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file20;
      print(merge.merge.file20);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file20 = testData1s;
      print(merge.merge.file20);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file20 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file20 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file20 = testData2s;
      print(merge.merge.file20);
      expect(merge.merge.file20 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file20 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file20 = defalut;
      print(merge.merge.file20);
      expect(merge.merge.file20 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file20 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file21;
      print(merge.merge.file21);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file21 = testData1s;
      print(merge.merge.file21);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file21 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file21 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file21 = testData2s;
      print(merge.merge.file21);
      expect(merge.merge.file21 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file21 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file21 = defalut;
      print(merge.merge.file21);
      expect(merge.merge.file21 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file21 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file22;
      print(merge.merge.file22);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file22 = testData1s;
      print(merge.merge.file22);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file22 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file22 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file22 = testData2s;
      print(merge.merge.file22);
      expect(merge.merge.file22 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file22 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file22 = defalut;
      print(merge.merge.file22);
      expect(merge.merge.file22 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file22 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file23;
      print(merge.merge.file23);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file23 = testData1s;
      print(merge.merge.file23);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file23 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file23 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file23 = testData2s;
      print(merge.merge.file23);
      expect(merge.merge.file23 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file23 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file23 = defalut;
      print(merge.merge.file23);
      expect(merge.merge.file23 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file23 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file24;
      print(merge.merge.file24);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file24 = testData1s;
      print(merge.merge.file24);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file24 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file24 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file24 = testData2s;
      print(merge.merge.file24);
      expect(merge.merge.file24 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file24 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file24 = defalut;
      print(merge.merge.file24);
      expect(merge.merge.file24 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file24 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file25;
      print(merge.merge.file25);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file25 = testData1s;
      print(merge.merge.file25);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file25 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file25 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file25 = testData2s;
      print(merge.merge.file25);
      expect(merge.merge.file25 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file25 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file25 = defalut;
      print(merge.merge.file25);
      expect(merge.merge.file25 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file25 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file26;
      print(merge.merge.file26);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file26 = testData1s;
      print(merge.merge.file26);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file26 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file26 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file26 = testData2s;
      print(merge.merge.file26);
      expect(merge.merge.file26 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file26 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file26 = defalut;
      print(merge.merge.file26);
      expect(merge.merge.file26 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file26 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file27;
      print(merge.merge.file27);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file27 = testData1s;
      print(merge.merge.file27);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file27 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file27 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file27 = testData2s;
      print(merge.merge.file27);
      expect(merge.merge.file27 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file27 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file27 = defalut;
      print(merge.merge.file27);
      expect(merge.merge.file27 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file27 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file28;
      print(merge.merge.file28);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file28 = testData1s;
      print(merge.merge.file28);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file28 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file28 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file28 = testData2s;
      print(merge.merge.file28);
      expect(merge.merge.file28 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file28 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file28 = defalut;
      print(merge.merge.file28);
      expect(merge.merge.file28 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file28 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file29;
      print(merge.merge.file29);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file29 = testData1s;
      print(merge.merge.file29);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file29 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file29 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file29 = testData2s;
      print(merge.merge.file29);
      expect(merge.merge.file29 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file29 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file29 = defalut;
      print(merge.merge.file29);
      expect(merge.merge.file29 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file29 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file30;
      print(merge.merge.file30);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file30 = testData1s;
      print(merge.merge.file30);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file30 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file30 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file30 = testData2s;
      print(merge.merge.file30);
      expect(merge.merge.file30 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file30 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file30 = defalut;
      print(merge.merge.file30);
      expect(merge.merge.file30 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file30 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file31;
      print(merge.merge.file31);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file31 = testData1s;
      print(merge.merge.file31);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file31 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file31 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file31 = testData2s;
      print(merge.merge.file31);
      expect(merge.merge.file31 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file31 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file31 = defalut;
      print(merge.merge.file31);
      expect(merge.merge.file31 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file31 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file32;
      print(merge.merge.file32);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file32 = testData1s;
      print(merge.merge.file32);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file32 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file32 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file32 = testData2s;
      print(merge.merge.file32);
      expect(merge.merge.file32 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file32 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file32 = defalut;
      print(merge.merge.file32);
      expect(merge.merge.file32 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file32 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file33;
      print(merge.merge.file33);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file33 = testData1s;
      print(merge.merge.file33);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file33 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file33 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file33 = testData2s;
      print(merge.merge.file33);
      expect(merge.merge.file33 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file33 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file33 = defalut;
      print(merge.merge.file33);
      expect(merge.merge.file33 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file33 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file34;
      print(merge.merge.file34);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file34 = testData1s;
      print(merge.merge.file34);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file34 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file34 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file34 = testData2s;
      print(merge.merge.file34);
      expect(merge.merge.file34 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file34 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file34 = defalut;
      print(merge.merge.file34);
      expect(merge.merge.file34 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file34 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file35;
      print(merge.merge.file35);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file35 = testData1s;
      print(merge.merge.file35);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file35 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file35 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file35 = testData2s;
      print(merge.merge.file35);
      expect(merge.merge.file35 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file35 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file35 = defalut;
      print(merge.merge.file35);
      expect(merge.merge.file35 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file35 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file36;
      print(merge.merge.file36);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file36 = testData1s;
      print(merge.merge.file36);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file36 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file36 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file36 = testData2s;
      print(merge.merge.file36);
      expect(merge.merge.file36 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file36 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file36 = defalut;
      print(merge.merge.file36);
      expect(merge.merge.file36 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file36 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file37;
      print(merge.merge.file37);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file37 = testData1s;
      print(merge.merge.file37);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file37 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file37 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file37 = testData2s;
      print(merge.merge.file37);
      expect(merge.merge.file37 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file37 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file37 = defalut;
      print(merge.merge.file37);
      expect(merge.merge.file37 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file37 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file38;
      print(merge.merge.file38);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file38 = testData1s;
      print(merge.merge.file38);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file38 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file38 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file38 = testData2s;
      print(merge.merge.file38);
      expect(merge.merge.file38 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file38 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file38 = defalut;
      print(merge.merge.file38);
      expect(merge.merge.file38 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file38 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file39;
      print(merge.merge.file39);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file39 = testData1s;
      print(merge.merge.file39);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file39 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file39 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file39 = testData2s;
      print(merge.merge.file39);
      expect(merge.merge.file39 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file39 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file39 = defalut;
      print(merge.merge.file39);
      expect(merge.merge.file39 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file39 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file40;
      print(merge.merge.file40);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file40 = testData1s;
      print(merge.merge.file40);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file40 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file40 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file40 = testData2s;
      print(merge.merge.file40);
      expect(merge.merge.file40 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file40 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file40 = defalut;
      print(merge.merge.file40);
      expect(merge.merge.file40 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file40 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file41;
      print(merge.merge.file41);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file41 = testData1s;
      print(merge.merge.file41);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file41 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file41 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file41 = testData2s;
      print(merge.merge.file41);
      expect(merge.merge.file41 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file41 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file41 = defalut;
      print(merge.merge.file41);
      expect(merge.merge.file41 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file41 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file42;
      print(merge.merge.file42);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file42 = testData1s;
      print(merge.merge.file42);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file42 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file42 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file42 = testData2s;
      print(merge.merge.file42);
      expect(merge.merge.file42 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file42 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file42 = defalut;
      print(merge.merge.file42);
      expect(merge.merge.file42 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file42 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file43;
      print(merge.merge.file43);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file43 = testData1s;
      print(merge.merge.file43);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file43 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file43 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file43 = testData2s;
      print(merge.merge.file43);
      expect(merge.merge.file43 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file43 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file43 = defalut;
      print(merge.merge.file43);
      expect(merge.merge.file43 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file43 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file44;
      print(merge.merge.file44);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file44 = testData1s;
      print(merge.merge.file44);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file44 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file44 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file44 = testData2s;
      print(merge.merge.file44);
      expect(merge.merge.file44 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file44 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file44 = defalut;
      print(merge.merge.file44);
      expect(merge.merge.file44 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file44 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file45;
      print(merge.merge.file45);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file45 = testData1s;
      print(merge.merge.file45);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file45 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file45 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file45 = testData2s;
      print(merge.merge.file45);
      expect(merge.merge.file45 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file45 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file45 = defalut;
      print(merge.merge.file45);
      expect(merge.merge.file45 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file45 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file46;
      print(merge.merge.file46);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file46 = testData1s;
      print(merge.merge.file46);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file46 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file46 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file46 = testData2s;
      print(merge.merge.file46);
      expect(merge.merge.file46 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file46 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file46 = defalut;
      print(merge.merge.file46);
      expect(merge.merge.file46 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file46 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file47;
      print(merge.merge.file47);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file47 = testData1s;
      print(merge.merge.file47);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file47 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file47 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file47 = testData2s;
      print(merge.merge.file47);
      expect(merge.merge.file47 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file47 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file47 = defalut;
      print(merge.merge.file47);
      expect(merge.merge.file47 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file47 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file50;
      print(merge.merge.file50);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file50 = testData1s;
      print(merge.merge.file50);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file50 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file50 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file50 = testData2s;
      print(merge.merge.file50);
      expect(merge.merge.file50 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file50 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file50 = defalut;
      print(merge.merge.file50);
      expect(merge.merge.file50 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file50 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file51;
      print(merge.merge.file51);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file51 = testData1s;
      print(merge.merge.file51);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file51 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file51 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file51 = testData2s;
      print(merge.merge.file51);
      expect(merge.merge.file51 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file51 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file51 = defalut;
      print(merge.merge.file51);
      expect(merge.merge.file51 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file51 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file52;
      print(merge.merge.file52);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file52 = testData1s;
      print(merge.merge.file52);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file52 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file52 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file52 = testData2s;
      print(merge.merge.file52);
      expect(merge.merge.file52 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file52 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file52 = defalut;
      print(merge.merge.file52);
      expect(merge.merge.file52 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file52 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file53;
      print(merge.merge.file53);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file53 = testData1s;
      print(merge.merge.file53);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file53 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file53 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file53 = testData2s;
      print(merge.merge.file53);
      expect(merge.merge.file53 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file53 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file53 = defalut;
      print(merge.merge.file53);
      expect(merge.merge.file53 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file53 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file54;
      print(merge.merge.file54);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file54 = testData1s;
      print(merge.merge.file54);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file54 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file54 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file54 = testData2s;
      print(merge.merge.file54);
      expect(merge.merge.file54 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file54 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file54 = defalut;
      print(merge.merge.file54);
      expect(merge.merge.file54 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file54 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file55;
      print(merge.merge.file55);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file55 = testData1s;
      print(merge.merge.file55);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file55 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file55 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file55 = testData2s;
      print(merge.merge.file55);
      expect(merge.merge.file55 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file55 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file55 = defalut;
      print(merge.merge.file55);
      expect(merge.merge.file55 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file55 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file56;
      print(merge.merge.file56);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file56 = testData1s;
      print(merge.merge.file56);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file56 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file56 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file56 = testData2s;
      print(merge.merge.file56);
      expect(merge.merge.file56 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file56 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file56 = defalut;
      print(merge.merge.file56);
      expect(merge.merge.file56 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file56 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file57;
      print(merge.merge.file57);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file57 = testData1s;
      print(merge.merge.file57);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file57 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file57 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file57 = testData2s;
      print(merge.merge.file57);
      expect(merge.merge.file57 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file57 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file57 = defalut;
      print(merge.merge.file57);
      expect(merge.merge.file57 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file57 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file58;
      print(merge.merge.file58);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file58 = testData1s;
      print(merge.merge.file58);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file58 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file58 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file58 = testData2s;
      print(merge.merge.file58);
      expect(merge.merge.file58 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file58 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file58 = defalut;
      print(merge.merge.file58);
      expect(merge.merge.file58 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file58 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file59;
      print(merge.merge.file59);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file59 = testData1s;
      print(merge.merge.file59);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file59 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file59 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file59 = testData2s;
      print(merge.merge.file59);
      expect(merge.merge.file59 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file59 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file59 = defalut;
      print(merge.merge.file59);
      expect(merge.merge.file59 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file59 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file60;
      print(merge.merge.file60);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file60 = testData1s;
      print(merge.merge.file60);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file60 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file60 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file60 = testData2s;
      print(merge.merge.file60);
      expect(merge.merge.file60 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file60 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file60 = defalut;
      print(merge.merge.file60);
      expect(merge.merge.file60 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file60 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file61;
      print(merge.merge.file61);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file61 = testData1s;
      print(merge.merge.file61);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file61 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file61 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file61 = testData2s;
      print(merge.merge.file61);
      expect(merge.merge.file61 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file61 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file61 = defalut;
      print(merge.merge.file61);
      expect(merge.merge.file61 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file61 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file62;
      print(merge.merge.file62);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file62 = testData1s;
      print(merge.merge.file62);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file62 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file62 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file62 = testData2s;
      print(merge.merge.file62);
      expect(merge.merge.file62 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file62 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file62 = defalut;
      print(merge.merge.file62);
      expect(merge.merge.file62 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file62 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file63;
      print(merge.merge.file63);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file63 = testData1s;
      print(merge.merge.file63);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file63 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file63 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file63 = testData2s;
      print(merge.merge.file63);
      expect(merge.merge.file63 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file63 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file63 = defalut;
      print(merge.merge.file63);
      expect(merge.merge.file63 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file63 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file64;
      print(merge.merge.file64);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file64 = testData1s;
      print(merge.merge.file64);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file64 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file64 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file64 = testData2s;
      print(merge.merge.file64);
      expect(merge.merge.file64 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file64 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file64 = defalut;
      print(merge.merge.file64);
      expect(merge.merge.file64 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file64 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file65;
      print(merge.merge.file65);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file65 = testData1s;
      print(merge.merge.file65);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file65 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file65 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file65 = testData2s;
      print(merge.merge.file65);
      expect(merge.merge.file65 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file65 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file65 = defalut;
      print(merge.merge.file65);
      expect(merge.merge.file65 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file65 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file66;
      print(merge.merge.file66);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file66 = testData1s;
      print(merge.merge.file66);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file66 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file66 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file66 = testData2s;
      print(merge.merge.file66);
      expect(merge.merge.file66 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file66 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file66 = defalut;
      print(merge.merge.file66);
      expect(merge.merge.file66 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file66 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file67;
      print(merge.merge.file67);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file67 = testData1s;
      print(merge.merge.file67);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file67 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file67 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file67 = testData2s;
      print(merge.merge.file67);
      expect(merge.merge.file67 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file67 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file67 = defalut;
      print(merge.merge.file67);
      expect(merge.merge.file67 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file67 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file68;
      print(merge.merge.file68);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file68 = testData1s;
      print(merge.merge.file68);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file68 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file68 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file68 = testData2s;
      print(merge.merge.file68);
      expect(merge.merge.file68 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file68 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file68 = defalut;
      print(merge.merge.file68);
      expect(merge.merge.file68 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file68 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file69;
      print(merge.merge.file69);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file69 = testData1s;
      print(merge.merge.file69);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file69 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file69 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file69 = testData2s;
      print(merge.merge.file69);
      expect(merge.merge.file69 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file69 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file69 = defalut;
      print(merge.merge.file69);
      expect(merge.merge.file69 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file69 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file70;
      print(merge.merge.file70);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file70 = testData1s;
      print(merge.merge.file70);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file70 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file70 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file70 = testData2s;
      print(merge.merge.file70);
      expect(merge.merge.file70 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file70 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file70 = defalut;
      print(merge.merge.file70);
      expect(merge.merge.file70 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file70 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file71;
      print(merge.merge.file71);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file71 = testData1s;
      print(merge.merge.file71);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file71 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file71 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file71 = testData2s;
      print(merge.merge.file71);
      expect(merge.merge.file71 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file71 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file71 = defalut;
      print(merge.merge.file71);
      expect(merge.merge.file71 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file71 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file72;
      print(merge.merge.file72);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file72 = testData1s;
      print(merge.merge.file72);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file72 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file72 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file72 = testData2s;
      print(merge.merge.file72);
      expect(merge.merge.file72 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file72 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file72 = defalut;
      print(merge.merge.file72);
      expect(merge.merge.file72 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file72 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file73;
      print(merge.merge.file73);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file73 = testData1s;
      print(merge.merge.file73);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file73 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file73 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file73 = testData2s;
      print(merge.merge.file73);
      expect(merge.merge.file73 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file73 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file73 = defalut;
      print(merge.merge.file73);
      expect(merge.merge.file73 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file73 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file74;
      print(merge.merge.file74);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file74 = testData1s;
      print(merge.merge.file74);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file74 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file74 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file74 = testData2s;
      print(merge.merge.file74);
      expect(merge.merge.file74 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file74 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file74 = defalut;
      print(merge.merge.file74);
      expect(merge.merge.file74 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file74 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file75;
      print(merge.merge.file75);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file75 = testData1s;
      print(merge.merge.file75);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file75 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file75 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file75 = testData2s;
      print(merge.merge.file75);
      expect(merge.merge.file75 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file75 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file75 = defalut;
      print(merge.merge.file75);
      expect(merge.merge.file75 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file75 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file76;
      print(merge.merge.file76);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file76 = testData1s;
      print(merge.merge.file76);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file76 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file76 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file76 = testData2s;
      print(merge.merge.file76);
      expect(merge.merge.file76 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file76 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file76 = defalut;
      print(merge.merge.file76);
      expect(merge.merge.file76 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file76 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file77;
      print(merge.merge.file77);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file77 = testData1s;
      print(merge.merge.file77);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file77 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file77 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file77 = testData2s;
      print(merge.merge.file77);
      expect(merge.merge.file77 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file77 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file77 = defalut;
      print(merge.merge.file77);
      expect(merge.merge.file77 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file77 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file78;
      print(merge.merge.file78);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file78 = testData1s;
      print(merge.merge.file78);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file78 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file78 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file78 = testData2s;
      print(merge.merge.file78);
      expect(merge.merge.file78 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file78 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file78 = defalut;
      print(merge.merge.file78);
      expect(merge.merge.file78 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file78 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file79;
      print(merge.merge.file79);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file79 = testData1s;
      print(merge.merge.file79);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file79 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file79 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file79 = testData2s;
      print(merge.merge.file79);
      expect(merge.merge.file79 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file79 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file79 = defalut;
      print(merge.merge.file79);
      expect(merge.merge.file79 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file79 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file80;
      print(merge.merge.file80);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file80 = testData1s;
      print(merge.merge.file80);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file80 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file80 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file80 = testData2s;
      print(merge.merge.file80);
      expect(merge.merge.file80 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file80 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file80 = defalut;
      print(merge.merge.file80);
      expect(merge.merge.file80 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file80 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file81;
      print(merge.merge.file81);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file81 = testData1s;
      print(merge.merge.file81);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file81 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file81 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file81 = testData2s;
      print(merge.merge.file81);
      expect(merge.merge.file81 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file81 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file81 = defalut;
      print(merge.merge.file81);
      expect(merge.merge.file81 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file81 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file82;
      print(merge.merge.file82);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file82 = testData1s;
      print(merge.merge.file82);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file82 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file82 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file82 = testData2s;
      print(merge.merge.file82);
      expect(merge.merge.file82 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file82 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file82 = defalut;
      print(merge.merge.file82);
      expect(merge.merge.file82 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file82 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file83;
      print(merge.merge.file83);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file83 = testData1s;
      print(merge.merge.file83);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file83 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file83 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file83 = testData2s;
      print(merge.merge.file83);
      expect(merge.merge.file83 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file83 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file83 = defalut;
      print(merge.merge.file83);
      expect(merge.merge.file83 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file83 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file84;
      print(merge.merge.file84);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file84 = testData1s;
      print(merge.merge.file84);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file84 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file84 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file84 = testData2s;
      print(merge.merge.file84);
      expect(merge.merge.file84 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file84 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file84 = defalut;
      print(merge.merge.file84);
      expect(merge.merge.file84 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file84 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file85;
      print(merge.merge.file85);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file85 = testData1s;
      print(merge.merge.file85);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file85 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file85 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file85 = testData2s;
      print(merge.merge.file85);
      expect(merge.merge.file85 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file85 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file85 = defalut;
      print(merge.merge.file85);
      expect(merge.merge.file85 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file85 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file86;
      print(merge.merge.file86);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file86 = testData1s;
      print(merge.merge.file86);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file86 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file86 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file86 = testData2s;
      print(merge.merge.file86);
      expect(merge.merge.file86 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file86 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file86 = defalut;
      print(merge.merge.file86);
      expect(merge.merge.file86 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file86 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file87;
      print(merge.merge.file87);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file87 = testData1s;
      print(merge.merge.file87);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file87 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file87 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file87 = testData2s;
      print(merge.merge.file87);
      expect(merge.merge.file87 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file87 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file87 = defalut;
      print(merge.merge.file87);
      expect(merge.merge.file87 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file87 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file88;
      print(merge.merge.file88);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file88 = testData1s;
      print(merge.merge.file88);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file88 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file88 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file88 = testData2s;
      print(merge.merge.file88);
      expect(merge.merge.file88 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file88 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file88 = defalut;
      print(merge.merge.file88);
      expect(merge.merge.file88 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file88 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file89;
      print(merge.merge.file89);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file89 = testData1s;
      print(merge.merge.file89);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file89 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file89 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file89 = testData2s;
      print(merge.merge.file89);
      expect(merge.merge.file89 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file89 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file89 = defalut;
      print(merge.merge.file89);
      expect(merge.merge.file89 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file89 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file90;
      print(merge.merge.file90);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file90 = testData1s;
      print(merge.merge.file90);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file90 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file90 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file90 = testData2s;
      print(merge.merge.file90);
      expect(merge.merge.file90 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file90 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file90 = defalut;
      print(merge.merge.file90);
      expect(merge.merge.file90 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file90 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file91;
      print(merge.merge.file91);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file91 = testData1s;
      print(merge.merge.file91);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file91 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file91 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file91 = testData2s;
      print(merge.merge.file91);
      expect(merge.merge.file91 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file91 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file91 = defalut;
      print(merge.merge.file91);
      expect(merge.merge.file91 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file91 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file92;
      print(merge.merge.file92);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file92 = testData1s;
      print(merge.merge.file92);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file92 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file92 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file92 = testData2s;
      print(merge.merge.file92);
      expect(merge.merge.file92 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file92 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file92 = defalut;
      print(merge.merge.file92);
      expect(merge.merge.file92 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file92 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file93;
      print(merge.merge.file93);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file93 = testData1s;
      print(merge.merge.file93);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file93 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file93 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file93 = testData2s;
      print(merge.merge.file93);
      expect(merge.merge.file93 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file93 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file93 = defalut;
      print(merge.merge.file93);
      expect(merge.merge.file93 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file93 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file94;
      print(merge.merge.file94);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file94 = testData1s;
      print(merge.merge.file94);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file94 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file94 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file94 = testData2s;
      print(merge.merge.file94);
      expect(merge.merge.file94 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file94 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file94 = defalut;
      print(merge.merge.file94);
      expect(merge.merge.file94 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file94 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file95;
      print(merge.merge.file95);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file95 = testData1s;
      print(merge.merge.file95);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file95 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file95 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file95 = testData2s;
      print(merge.merge.file95);
      expect(merge.merge.file95 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file95 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file95 = defalut;
      print(merge.merge.file95);
      expect(merge.merge.file95 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file95 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file96;
      print(merge.merge.file96);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file96 = testData1s;
      print(merge.merge.file96);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file96 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file96 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file96 = testData2s;
      print(merge.merge.file96);
      expect(merge.merge.file96 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file96 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file96 = defalut;
      print(merge.merge.file96);
      expect(merge.merge.file96 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file96 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file97;
      print(merge.merge.file97);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file97 = testData1s;
      print(merge.merge.file97);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file97 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file97 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file97 = testData2s;
      print(merge.merge.file97);
      expect(merge.merge.file97 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file97 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file97 = defalut;
      print(merge.merge.file97);
      expect(merge.merge.file97 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file97 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file98;
      print(merge.merge.file98);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file98 = testData1s;
      print(merge.merge.file98);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file98 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file98 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file98 = testData2s;
      print(merge.merge.file98);
      expect(merge.merge.file98 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file98 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file98 = defalut;
      print(merge.merge.file98);
      expect(merge.merge.file98 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file98 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file99;
      print(merge.merge.file99);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file99 = testData1s;
      print(merge.merge.file99);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file99 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file99 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file99 = testData2s;
      print(merge.merge.file99);
      expect(merge.merge.file99 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file99 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file99 = defalut;
      print(merge.merge.file99);
      expect(merge.merge.file99 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file99 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file100;
      print(merge.merge.file100);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file100 = testData1s;
      print(merge.merge.file100);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file100 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file100 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file100 = testData2s;
      print(merge.merge.file100);
      expect(merge.merge.file100 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file100 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file100 = defalut;
      print(merge.merge.file100);
      expect(merge.merge.file100 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file100 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file101;
      print(merge.merge.file101);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file101 = testData1s;
      print(merge.merge.file101);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file101 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file101 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file101 = testData2s;
      print(merge.merge.file101);
      expect(merge.merge.file101 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file101 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file101 = defalut;
      print(merge.merge.file101);
      expect(merge.merge.file101 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file101 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.merge.file_cnt;
      print(merge.merge.file_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.merge.file_cnt = testData1;
      print(merge.merge.file_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.merge.file_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.merge.file_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.merge.file_cnt = testData2;
      print(merge.merge.file_cnt);
      expect(merge.merge.file_cnt == testData2, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.merge.file_cnt = defalut;
      print(merge.merge.file_cnt);
      expect(merge.merge.file_cnt == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.merge.file_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file_cnt;
      print(merge.quick_data.file_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file_cnt = testData1;
      print(merge.quick_data.file_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file_cnt = testData2;
      print(merge.quick_data.file_cnt);
      expect(merge.quick_data.file_cnt == testData2, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file_cnt = defalut;
      print(merge.quick_data.file_cnt);
      expect(merge.quick_data.file_cnt == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file01;
      print(merge.quick_data.file01);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file01 = testData1s;
      print(merge.quick_data.file01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file01 = testData2s;
      print(merge.quick_data.file01);
      expect(merge.quick_data.file01 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file01 = defalut;
      print(merge.quick_data.file01);
      expect(merge.quick_data.file01 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file02;
      print(merge.quick_data.file02);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file02 = testData1s;
      print(merge.quick_data.file02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file02 = testData2s;
      print(merge.quick_data.file02);
      expect(merge.quick_data.file02 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file02 = defalut;
      print(merge.quick_data.file02);
      expect(merge.quick_data.file02 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file03;
      print(merge.quick_data.file03);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file03 = testData1s;
      print(merge.quick_data.file03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file03 = testData2s;
      print(merge.quick_data.file03);
      expect(merge.quick_data.file03 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file03 = defalut;
      print(merge.quick_data.file03);
      expect(merge.quick_data.file03 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file04;
      print(merge.quick_data.file04);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file04 = testData1s;
      print(merge.quick_data.file04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file04 = testData2s;
      print(merge.quick_data.file04);
      expect(merge.quick_data.file04 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file04 = defalut;
      print(merge.quick_data.file04);
      expect(merge.quick_data.file04 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file05;
      print(merge.quick_data.file05);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file05 = testData1s;
      print(merge.quick_data.file05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file05 = testData2s;
      print(merge.quick_data.file05);
      expect(merge.quick_data.file05 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file05 = defalut;
      print(merge.quick_data.file05);
      expect(merge.quick_data.file05 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file06;
      print(merge.quick_data.file06);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file06 = testData1s;
      print(merge.quick_data.file06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file06 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file06 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file06 = testData2s;
      print(merge.quick_data.file06);
      expect(merge.quick_data.file06 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file06 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file06 = defalut;
      print(merge.quick_data.file06);
      expect(merge.quick_data.file06 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file07;
      print(merge.quick_data.file07);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file07 = testData1s;
      print(merge.quick_data.file07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file07 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file07 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file07 = testData2s;
      print(merge.quick_data.file07);
      expect(merge.quick_data.file07 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file07 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file07 = defalut;
      print(merge.quick_data.file07);
      expect(merge.quick_data.file07 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file08;
      print(merge.quick_data.file08);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file08 = testData1s;
      print(merge.quick_data.file08);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file08 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file08 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file08 = testData2s;
      print(merge.quick_data.file08);
      expect(merge.quick_data.file08 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file08 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file08 = defalut;
      print(merge.quick_data.file08);
      expect(merge.quick_data.file08 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file08 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file09;
      print(merge.quick_data.file09);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file09 = testData1s;
      print(merge.quick_data.file09);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file09 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file09 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file09 = testData2s;
      print(merge.quick_data.file09);
      expect(merge.quick_data.file09 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file09 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file09 = defalut;
      print(merge.quick_data.file09);
      expect(merge.quick_data.file09 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file09 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file10;
      print(merge.quick_data.file10);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file10 = testData1s;
      print(merge.quick_data.file10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file10 = testData2s;
      print(merge.quick_data.file10);
      expect(merge.quick_data.file10 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file10 = defalut;
      print(merge.quick_data.file10);
      expect(merge.quick_data.file10 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file11;
      print(merge.quick_data.file11);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file11 = testData1s;
      print(merge.quick_data.file11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file11 = testData2s;
      print(merge.quick_data.file11);
      expect(merge.quick_data.file11 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file11 = defalut;
      print(merge.quick_data.file11);
      expect(merge.quick_data.file11 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file12;
      print(merge.quick_data.file12);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file12 = testData1s;
      print(merge.quick_data.file12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file12 = testData2s;
      print(merge.quick_data.file12);
      expect(merge.quick_data.file12 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file12 = defalut;
      print(merge.quick_data.file12);
      expect(merge.quick_data.file12 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file13;
      print(merge.quick_data.file13);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file13 = testData1s;
      print(merge.quick_data.file13);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file13 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file13 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file13 = testData2s;
      print(merge.quick_data.file13);
      expect(merge.quick_data.file13 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file13 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file13 = defalut;
      print(merge.quick_data.file13);
      expect(merge.quick_data.file13 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file13 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

    test('00138_element_check_00115', () async {
      print("\n********** テスト実行：00138_element_check_00115 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file14;
      print(merge.quick_data.file14);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file14 = testData1s;
      print(merge.quick_data.file14);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file14 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file14 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file14 = testData2s;
      print(merge.quick_data.file14);
      expect(merge.quick_data.file14 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file14 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file14 = defalut;
      print(merge.quick_data.file14);
      expect(merge.quick_data.file14 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file14 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00138_element_check_00115 **********\n\n");
    });

    test('00139_element_check_00116', () async {
      print("\n********** テスト実行：00139_element_check_00116 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file15;
      print(merge.quick_data.file15);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file15 = testData1s;
      print(merge.quick_data.file15);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file15 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file15 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file15 = testData2s;
      print(merge.quick_data.file15);
      expect(merge.quick_data.file15 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file15 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file15 = defalut;
      print(merge.quick_data.file15);
      expect(merge.quick_data.file15 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file15 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00139_element_check_00116 **********\n\n");
    });

    test('00140_element_check_00117', () async {
      print("\n********** テスト実行：00140_element_check_00117 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file16;
      print(merge.quick_data.file16);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file16 = testData1s;
      print(merge.quick_data.file16);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file16 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file16 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file16 = testData2s;
      print(merge.quick_data.file16);
      expect(merge.quick_data.file16 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file16 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file16 = defalut;
      print(merge.quick_data.file16);
      expect(merge.quick_data.file16 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file16 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00140_element_check_00117 **********\n\n");
    });

    test('00141_element_check_00118', () async {
      print("\n********** テスト実行：00141_element_check_00118 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file17;
      print(merge.quick_data.file17);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file17 = testData1s;
      print(merge.quick_data.file17);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file17 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file17 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file17 = testData2s;
      print(merge.quick_data.file17);
      expect(merge.quick_data.file17 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file17 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file17 = defalut;
      print(merge.quick_data.file17);
      expect(merge.quick_data.file17 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file17 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00141_element_check_00118 **********\n\n");
    });

    test('00142_element_check_00119', () async {
      print("\n********** テスト実行：00142_element_check_00119 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file18;
      print(merge.quick_data.file18);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file18 = testData1s;
      print(merge.quick_data.file18);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file18 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file18 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file18 = testData2s;
      print(merge.quick_data.file18);
      expect(merge.quick_data.file18 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file18 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file18 = defalut;
      print(merge.quick_data.file18);
      expect(merge.quick_data.file18 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file18 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00142_element_check_00119 **********\n\n");
    });

    test('00143_element_check_00120', () async {
      print("\n********** テスト実行：00143_element_check_00120 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file19;
      print(merge.quick_data.file19);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file19 = testData1s;
      print(merge.quick_data.file19);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file19 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file19 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file19 = testData2s;
      print(merge.quick_data.file19);
      expect(merge.quick_data.file19 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file19 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file19 = defalut;
      print(merge.quick_data.file19);
      expect(merge.quick_data.file19 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file19 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00143_element_check_00120 **********\n\n");
    });

    test('00144_element_check_00121', () async {
      print("\n********** テスト実行：00144_element_check_00121 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file20;
      print(merge.quick_data.file20);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file20 = testData1s;
      print(merge.quick_data.file20);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file20 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file20 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file20 = testData2s;
      print(merge.quick_data.file20);
      expect(merge.quick_data.file20 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file20 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file20 = defalut;
      print(merge.quick_data.file20);
      expect(merge.quick_data.file20 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file20 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00144_element_check_00121 **********\n\n");
    });

    test('00145_element_check_00122', () async {
      print("\n********** テスト実行：00145_element_check_00122 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file21;
      print(merge.quick_data.file21);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file21 = testData1s;
      print(merge.quick_data.file21);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file21 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file21 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file21 = testData2s;
      print(merge.quick_data.file21);
      expect(merge.quick_data.file21 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file21 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file21 = defalut;
      print(merge.quick_data.file21);
      expect(merge.quick_data.file21 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file21 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00145_element_check_00122 **********\n\n");
    });

    test('00146_element_check_00123', () async {
      print("\n********** テスト実行：00146_element_check_00123 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file22;
      print(merge.quick_data.file22);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file22 = testData1s;
      print(merge.quick_data.file22);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file22 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file22 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file22 = testData2s;
      print(merge.quick_data.file22);
      expect(merge.quick_data.file22 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file22 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file22 = defalut;
      print(merge.quick_data.file22);
      expect(merge.quick_data.file22 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file22 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00146_element_check_00123 **********\n\n");
    });

    test('00147_element_check_00124', () async {
      print("\n********** テスト実行：00147_element_check_00124 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file23;
      print(merge.quick_data.file23);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file23 = testData1s;
      print(merge.quick_data.file23);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file23 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file23 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file23 = testData2s;
      print(merge.quick_data.file23);
      expect(merge.quick_data.file23 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file23 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file23 = defalut;
      print(merge.quick_data.file23);
      expect(merge.quick_data.file23 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file23 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00147_element_check_00124 **********\n\n");
    });

    test('00148_element_check_00125', () async {
      print("\n********** テスト実行：00148_element_check_00125 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file24;
      print(merge.quick_data.file24);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file24 = testData1s;
      print(merge.quick_data.file24);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file24 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file24 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file24 = testData2s;
      print(merge.quick_data.file24);
      expect(merge.quick_data.file24 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file24 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file24 = defalut;
      print(merge.quick_data.file24);
      expect(merge.quick_data.file24 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file24 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00148_element_check_00125 **********\n\n");
    });

    test('00149_element_check_00126', () async {
      print("\n********** テスト実行：00149_element_check_00126 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file25;
      print(merge.quick_data.file25);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file25 = testData1s;
      print(merge.quick_data.file25);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file25 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file25 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file25 = testData2s;
      print(merge.quick_data.file25);
      expect(merge.quick_data.file25 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file25 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file25 = defalut;
      print(merge.quick_data.file25);
      expect(merge.quick_data.file25 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file25 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00149_element_check_00126 **********\n\n");
    });

    test('00150_element_check_00127', () async {
      print("\n********** テスト実行：00150_element_check_00127 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file26;
      print(merge.quick_data.file26);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file26 = testData1s;
      print(merge.quick_data.file26);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file26 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file26 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file26 = testData2s;
      print(merge.quick_data.file26);
      expect(merge.quick_data.file26 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file26 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file26 = defalut;
      print(merge.quick_data.file26);
      expect(merge.quick_data.file26 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file26 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00150_element_check_00127 **********\n\n");
    });

    test('00151_element_check_00128', () async {
      print("\n********** テスト実行：00151_element_check_00128 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file27;
      print(merge.quick_data.file27);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file27 = testData1s;
      print(merge.quick_data.file27);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file27 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file27 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file27 = testData2s;
      print(merge.quick_data.file27);
      expect(merge.quick_data.file27 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file27 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file27 = defalut;
      print(merge.quick_data.file27);
      expect(merge.quick_data.file27 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file27 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00151_element_check_00128 **********\n\n");
    });

    test('00152_element_check_00129', () async {
      print("\n********** テスト実行：00152_element_check_00129 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file28;
      print(merge.quick_data.file28);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file28 = testData1s;
      print(merge.quick_data.file28);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file28 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file28 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file28 = testData2s;
      print(merge.quick_data.file28);
      expect(merge.quick_data.file28 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file28 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file28 = defalut;
      print(merge.quick_data.file28);
      expect(merge.quick_data.file28 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file28 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00152_element_check_00129 **********\n\n");
    });

    test('00153_element_check_00130', () async {
      print("\n********** テスト実行：00153_element_check_00130 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file29;
      print(merge.quick_data.file29);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file29 = testData1s;
      print(merge.quick_data.file29);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file29 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file29 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file29 = testData2s;
      print(merge.quick_data.file29);
      expect(merge.quick_data.file29 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file29 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file29 = defalut;
      print(merge.quick_data.file29);
      expect(merge.quick_data.file29 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file29 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00153_element_check_00130 **********\n\n");
    });

    test('00154_element_check_00131', () async {
      print("\n********** テスト実行：00154_element_check_00131 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file30;
      print(merge.quick_data.file30);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file30 = testData1s;
      print(merge.quick_data.file30);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file30 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file30 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file30 = testData2s;
      print(merge.quick_data.file30);
      expect(merge.quick_data.file30 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file30 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file30 = defalut;
      print(merge.quick_data.file30);
      expect(merge.quick_data.file30 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file30 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00154_element_check_00131 **********\n\n");
    });

    test('00155_element_check_00132', () async {
      print("\n********** テスト実行：00155_element_check_00132 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.quick_data.file31;
      print(merge.quick_data.file31);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.quick_data.file31 = testData1s;
      print(merge.quick_data.file31);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.quick_data.file31 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.quick_data.file31 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.quick_data.file31 = testData2s;
      print(merge.quick_data.file31);
      expect(merge.quick_data.file31 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file31 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.quick_data.file31 = defalut;
      print(merge.quick_data.file31);
      expect(merge.quick_data.file31 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.quick_data.file31 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00155_element_check_00132 **********\n\n");
    });

    test('00156_element_check_00133', () async {
      print("\n********** テスト実行：00156_element_check_00133 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file_cnt;
      print(merge.resetup_data.file_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file_cnt = testData1;
      print(merge.resetup_data.file_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file_cnt = testData2;
      print(merge.resetup_data.file_cnt);
      expect(merge.resetup_data.file_cnt == testData2, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file_cnt = defalut;
      print(merge.resetup_data.file_cnt);
      expect(merge.resetup_data.file_cnt == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00156_element_check_00133 **********\n\n");
    });

    test('00157_element_check_00134', () async {
      print("\n********** テスト実行：00157_element_check_00134 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file01;
      print(merge.resetup_data.file01);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file01 = testData1s;
      print(merge.resetup_data.file01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file01 = testData2s;
      print(merge.resetup_data.file01);
      expect(merge.resetup_data.file01 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file01 = defalut;
      print(merge.resetup_data.file01);
      expect(merge.resetup_data.file01 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00157_element_check_00134 **********\n\n");
    });

    test('00158_element_check_00135', () async {
      print("\n********** テスト実行：00158_element_check_00135 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file02;
      print(merge.resetup_data.file02);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file02 = testData1s;
      print(merge.resetup_data.file02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file02 = testData2s;
      print(merge.resetup_data.file02);
      expect(merge.resetup_data.file02 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file02 = defalut;
      print(merge.resetup_data.file02);
      expect(merge.resetup_data.file02 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00158_element_check_00135 **********\n\n");
    });

    test('00159_element_check_00136', () async {
      print("\n********** テスト実行：00159_element_check_00136 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file03;
      print(merge.resetup_data.file03);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file03 = testData1s;
      print(merge.resetup_data.file03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file03 = testData2s;
      print(merge.resetup_data.file03);
      expect(merge.resetup_data.file03 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file03 = defalut;
      print(merge.resetup_data.file03);
      expect(merge.resetup_data.file03 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00159_element_check_00136 **********\n\n");
    });

    test('00160_element_check_00137', () async {
      print("\n********** テスト実行：00160_element_check_00137 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file04;
      print(merge.resetup_data.file04);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file04 = testData1s;
      print(merge.resetup_data.file04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file04 = testData2s;
      print(merge.resetup_data.file04);
      expect(merge.resetup_data.file04 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file04 = defalut;
      print(merge.resetup_data.file04);
      expect(merge.resetup_data.file04 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00160_element_check_00137 **********\n\n");
    });

    test('00161_element_check_00138', () async {
      print("\n********** テスト実行：00161_element_check_00138 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file05;
      print(merge.resetup_data.file05);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file05 = testData1s;
      print(merge.resetup_data.file05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file05 = testData2s;
      print(merge.resetup_data.file05);
      expect(merge.resetup_data.file05 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file05 = defalut;
      print(merge.resetup_data.file05);
      expect(merge.resetup_data.file05 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00161_element_check_00138 **********\n\n");
    });

    test('00162_element_check_00139', () async {
      print("\n********** テスト実行：00162_element_check_00139 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file06;
      print(merge.resetup_data.file06);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file06 = testData1s;
      print(merge.resetup_data.file06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file06 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file06 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file06 = testData2s;
      print(merge.resetup_data.file06);
      expect(merge.resetup_data.file06 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file06 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file06 = defalut;
      print(merge.resetup_data.file06);
      expect(merge.resetup_data.file06 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00162_element_check_00139 **********\n\n");
    });

    test('00163_element_check_00140', () async {
      print("\n********** テスト実行：00163_element_check_00140 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file07;
      print(merge.resetup_data.file07);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file07 = testData1s;
      print(merge.resetup_data.file07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file07 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file07 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file07 = testData2s;
      print(merge.resetup_data.file07);
      expect(merge.resetup_data.file07 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file07 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file07 = defalut;
      print(merge.resetup_data.file07);
      expect(merge.resetup_data.file07 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00163_element_check_00140 **********\n\n");
    });

    test('00164_element_check_00141', () async {
      print("\n********** テスト実行：00164_element_check_00141 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file08;
      print(merge.resetup_data.file08);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file08 = testData1s;
      print(merge.resetup_data.file08);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file08 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file08 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file08 = testData2s;
      print(merge.resetup_data.file08);
      expect(merge.resetup_data.file08 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file08 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file08 = defalut;
      print(merge.resetup_data.file08);
      expect(merge.resetup_data.file08 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file08 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00164_element_check_00141 **********\n\n");
    });

    test('00165_element_check_00142', () async {
      print("\n********** テスト実行：00165_element_check_00142 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file09;
      print(merge.resetup_data.file09);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file09 = testData1s;
      print(merge.resetup_data.file09);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file09 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file09 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file09 = testData2s;
      print(merge.resetup_data.file09);
      expect(merge.resetup_data.file09 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file09 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file09 = defalut;
      print(merge.resetup_data.file09);
      expect(merge.resetup_data.file09 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file09 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00165_element_check_00142 **********\n\n");
    });

    test('00166_element_check_00143', () async {
      print("\n********** テスト実行：00166_element_check_00143 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file10;
      print(merge.resetup_data.file10);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file10 = testData1s;
      print(merge.resetup_data.file10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file10 = testData2s;
      print(merge.resetup_data.file10);
      expect(merge.resetup_data.file10 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file10 = defalut;
      print(merge.resetup_data.file10);
      expect(merge.resetup_data.file10 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00166_element_check_00143 **********\n\n");
    });

    test('00167_element_check_00144', () async {
      print("\n********** テスト実行：00167_element_check_00144 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file11;
      print(merge.resetup_data.file11);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file11 = testData1s;
      print(merge.resetup_data.file11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file11 = testData2s;
      print(merge.resetup_data.file11);
      expect(merge.resetup_data.file11 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file11 = defalut;
      print(merge.resetup_data.file11);
      expect(merge.resetup_data.file11 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00167_element_check_00144 **********\n\n");
    });

    test('00168_element_check_00145', () async {
      print("\n********** テスト実行：00168_element_check_00145 **********");

      merge = MergeJsonFile();
      allPropatyCheckInit(merge);

      // ①loadを実行する。
      await merge.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = merge.resetup_data.file12;
      print(merge.resetup_data.file12);

      // ②指定したプロパティにテストデータ1を書き込む。
      merge.resetup_data.file12 = testData1s;
      print(merge.resetup_data.file12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(merge.resetup_data.file12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await merge.save();
      await merge.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(merge.resetup_data.file12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      merge.resetup_data.file12 = testData2s;
      print(merge.resetup_data.file12);
      expect(merge.resetup_data.file12 == testData2s, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      merge.resetup_data.file12 = defalut;
      print(merge.resetup_data.file12);
      expect(merge.resetup_data.file12 == defalut, true);
      await merge.save();
      await merge.load();
      expect(merge.resetup_data.file12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(merge, true);

      print("********** テスト終了：00168_element_check_00145 **********\n\n");
    });

  });
}

void allPropatyCheckInit(MergeJsonFile test)
{
  expect(test.merge.file01, "");
  expect(test.merge.file02, "");
  expect(test.merge.file03, "");
  expect(test.merge.file04, "");
  expect(test.merge.file05, "");
  expect(test.merge.file06, "");
  expect(test.merge.file07, "");
  expect(test.merge.file08, "");
  expect(test.merge.file09, "");
  expect(test.merge.file10, "");
  expect(test.merge.file11, "");
  expect(test.merge.file12, "");
  expect(test.merge.file13, "");
  expect(test.merge.file14, "");
  expect(test.merge.file15, "");
  expect(test.merge.file16, "");
  expect(test.merge.file17, "");
  expect(test.merge.file18, "");
  expect(test.merge.file19, "");
  expect(test.merge.file20, "");
  expect(test.merge.file21, "");
  expect(test.merge.file22, "");
  expect(test.merge.file23, "");
  expect(test.merge.file24, "");
  expect(test.merge.file25, "");
  expect(test.merge.file26, "");
  expect(test.merge.file27, "");
  expect(test.merge.file28, "");
  expect(test.merge.file29, "");
  expect(test.merge.file30, "");
  expect(test.merge.file31, "");
  expect(test.merge.file32, "");
  expect(test.merge.file33, "");
  expect(test.merge.file34, "");
  expect(test.merge.file35, "");
  expect(test.merge.file36, "");
  expect(test.merge.file37, "");
  expect(test.merge.file38, "");
  expect(test.merge.file39, "");
  expect(test.merge.file40, "");
  expect(test.merge.file41, "");
  expect(test.merge.file42, "");
  expect(test.merge.file43, "");
  expect(test.merge.file44, "");
  expect(test.merge.file45, "");
  expect(test.merge.file46, "");
  expect(test.merge.file47, "");
  expect(test.merge.file50, "");
  expect(test.merge.file51, "");
  expect(test.merge.file52, "");
  expect(test.merge.file53, "");
  expect(test.merge.file54, "");
  expect(test.merge.file55, "");
  expect(test.merge.file56, "");
  expect(test.merge.file57, "");
  expect(test.merge.file58, "");
  expect(test.merge.file59, "");
  expect(test.merge.file60, "");
  expect(test.merge.file61, "");
  expect(test.merge.file62, "");
  expect(test.merge.file63, "");
  expect(test.merge.file64, "");
  expect(test.merge.file65, "");
  expect(test.merge.file66, "");
  expect(test.merge.file67, "");
  expect(test.merge.file68, "");
  expect(test.merge.file69, "");
  expect(test.merge.file70, "");
  expect(test.merge.file71, "");
  expect(test.merge.file72, "");
  expect(test.merge.file73, "");
  expect(test.merge.file74, "");
  expect(test.merge.file75, "");
  expect(test.merge.file76, "");
  expect(test.merge.file77, "");
  expect(test.merge.file78, "");
  expect(test.merge.file79, "");
  expect(test.merge.file80, "");
  expect(test.merge.file81, "");
  expect(test.merge.file82, "");
  expect(test.merge.file83, "");
  expect(test.merge.file84, "");
  expect(test.merge.file85, "");
  expect(test.merge.file86, "");
  expect(test.merge.file87, "");
  expect(test.merge.file88, "");
  expect(test.merge.file89, "");
  expect(test.merge.file90, "");
  expect(test.merge.file91, "");
  expect(test.merge.file92, "");
  expect(test.merge.file93, "");
  expect(test.merge.file94, "");
  expect(test.merge.file95, "");
  expect(test.merge.file96, "");
  expect(test.merge.file97, "");
  expect(test.merge.file98, "");
  expect(test.merge.file99, "");
  expect(test.merge.file100, "");
  expect(test.merge.file101, "");
  expect(test.merge.file_cnt, 0);
  expect(test.quick_data.file_cnt, 0);
  expect(test.quick_data.file01, "");
  expect(test.quick_data.file02, "");
  expect(test.quick_data.file03, "");
  expect(test.quick_data.file04, "");
  expect(test.quick_data.file05, "");
  expect(test.quick_data.file06, "");
  expect(test.quick_data.file07, "");
  expect(test.quick_data.file08, "");
  expect(test.quick_data.file09, "");
  expect(test.quick_data.file10, "");
  expect(test.quick_data.file11, "");
  expect(test.quick_data.file12, "");
  expect(test.quick_data.file13, "");
  expect(test.quick_data.file14, "");
  expect(test.quick_data.file15, "");
  expect(test.quick_data.file16, "");
  expect(test.quick_data.file17, "");
  expect(test.quick_data.file18, "");
  expect(test.quick_data.file19, "");
  expect(test.quick_data.file20, "");
  expect(test.quick_data.file21, "");
  expect(test.quick_data.file22, "");
  expect(test.quick_data.file23, "");
  expect(test.quick_data.file24, "");
  expect(test.quick_data.file25, "");
  expect(test.quick_data.file26, "");
  expect(test.quick_data.file27, "");
  expect(test.quick_data.file28, "");
  expect(test.quick_data.file29, "");
  expect(test.quick_data.file30, "");
  expect(test.quick_data.file31, "");
  expect(test.resetup_data.file_cnt, 0);
  expect(test.resetup_data.file01, "");
  expect(test.resetup_data.file02, "");
  expect(test.resetup_data.file03, "");
  expect(test.resetup_data.file04, "");
  expect(test.resetup_data.file05, "");
  expect(test.resetup_data.file06, "");
  expect(test.resetup_data.file07, "");
  expect(test.resetup_data.file08, "");
  expect(test.resetup_data.file09, "");
  expect(test.resetup_data.file10, "");
  expect(test.resetup_data.file11, "");
  expect(test.resetup_data.file12, "");
}

void allPropatyCheck(MergeJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.merge.file01, "changer.json");
  }
  expect(test.merge.file02, "counter.json");
  expect(test.merge.file03, "gcat.json");
  expect(test.merge.file04, "mac_info.json");
  expect(test.merge.file05, "pana_gcat.json");
  expect(test.merge.file06, "sprt.json");
  expect(test.merge.file07, "sys.json");
  expect(test.merge.file08, "sys_param.json");
  expect(test.merge.file09, "recogkey_data.json");
  expect(test.merge.file10, "hqftp.json");
  expect(test.merge.file11, "hqhist.json");
  expect(test.merge.file12, "mupdate_counter.json");
  expect(test.merge.file13, "update_counter.json");
  expect(test.merge.file14, "fjss.json");
  expect(test.merge.file15, "eat_in.json");
  expect(test.merge.file16, "backupdata.json");
  expect(test.merge.file17, "sound.json");
  expect(test.merge.file18, "specificftp.json");
  expect(test.merge.file19, "suica.json");
  expect(test.merge.file20, "sm_scalesc_scl.json");
  expect(test.merge.file21, "sm_scalesc_signp.json");
  expect(test.merge.file22, "mm_abj.json");
  expect(test.merge.file23, "scan_plus_1.json");
  expect(test.merge.file24, "rsvsetup_SAPPORO.json");
  expect(test.merge.file25, "movie_info.json");
  expect(test.merge.file26, "qs_movie_start_dsp.json");
  expect(test.merge.file27, "reserv.json");
  expect(test.merge.file28, "pmouse_2800_1.json");
  expect(test.merge.file29, "pmouse_2800_2.json");
  expect(test.merge.file30, "image.json");
  expect(test.merge.file31, "pmouse_2500_1.json");
  expect(test.merge.file32, "pmouse_2500_2.json");
  expect(test.merge.file33, "pbchg.json");
  expect(test.merge.file34, "rsv_custreal.json");
  expect(test.merge.file35, "wiz_cnct.json");
  expect(test.merge.file36, "qcashier.json");
  expect(test.merge.file37, "pmouse_plus2_1.json");
  expect(test.merge.file38, "mbrreal.json");
  expect(test.merge.file39, "chkr_save.json");
  expect(test.merge.file40, "SystemCheck.json");
  expect(test.merge.file41, "scan_2800ip_2.json");
  expect(test.merge.file42, "speeza.json");
  expect(test.merge.file43, "scan_plus_2.json");
  expect(test.merge.file44, "masr.json");
  expect(test.merge.file45, "qc_start_dsp.json");
  expect(test.merge.file46, "speeza_com.json");
  expect(test.merge.file47, "custreal_nec.json");
  expect(test.merge.file50, "nttd_preca.json");
  expect(test.merge.file51, "mc_param.json");
  expect(test.merge.file52, "wol.json");
  expect(test.merge.file53, "counter_JC_C.json");
  expect(test.merge.file54, "mac_info_JC_C.json");
  expect(test.merge.file55, "TccUts.json");
  expect(test.merge.file56, "main_menu.json");
  expect(test.merge.file57, "add_parts.json");
  expect(test.merge.file58, "cnct_sio.json");
  expect(test.merge.file59, "hq_set.json");
  expect(test.merge.file60, "fal2_spec.json");
  expect(test.merge.file61, "msr_chk.json");
  expect(test.merge.file62, "mm_rept_taxchg.json");
  expect(test.merge.file63, "set_option.json");
  expect(test.merge.file64, "fal2_spec.json");
  expect(test.merge.file65, "battery.json");
  expect(test.merge.file66, "f_self_content.json");
  expect(test.merge.file67, "pmouse_2800_3.json");
  expect(test.merge.file68, "f_self_img.json");
  expect(test.merge.file69, "trk_preca.json");
  expect(test.merge.file70, "repica.json");
  expect(test.merge.file71, "lottery.json");
  expect(test.merge.file72, "cogca.json");
  expect(test.merge.file73, "auto_update.json");
  expect(test.merge.file74, "tprtim_counter.json");
  expect(test.merge.file75, "devread.json");
  expect(test.merge.file76, "ecs_spec.json");
  expect(test.merge.file77, "recogkey_activate.json");
  expect(test.merge.file78, "msr_int_1.json");
  expect(test.merge.file79, "f_self_hp_img.json");
  expect(test.merge.file80, "vacuum_date.json");
  expect(test.merge.file81, "pmouse_2800_4.json");
  expect(test.merge.file82, "barcode_pay.json");
  expect(test.merge.file83, "powli.json");
  expect(test.merge.file84, "webapi_key.json");
  expect(test.merge.file85, "custreal_ajs.json");
  expect(test.merge.file86, "ecs_fw.json");
  expect(test.merge.file87, "pmouse_5900_1.json");
  expect(test.merge.file88, "taxfree.json");
  expect(test.merge.file89, "mail_sender.json");
  expect(test.merge.file90, "pmouse_2800_5.json");
  expect(test.merge.file91, "f_self_vfhd_hp_img.json");
  expect(test.merge.file92, "valuecard.json");
  expect(test.merge.file93, "pmouse_2800_6.json");
  expect(test.merge.file94, "pmouse_2800_7.json");
  expect(test.merge.file95, "rpoint.json");
  expect(test.merge.file96, "tpoint.json");
  expect(test.merge.file97, "net_receipt.json");
  expect(test.merge.file98, "tomoIF.json");
  expect(test.merge.file99, "acttrigger.json");
  expect(test.merge.file100, "cust_fresta.json");
  expect(test.merge.file101, "cust_istyle.json");
  expect(test.merge.file_cnt, 101);
  expect(test.quick_data.file_cnt, 31);
  expect(test.quick_data.file01, "version.json");
  expect(test.quick_data.file02, "counter.json");
  expect(test.quick_data.file03, "recogkey_data.json");
  expect(test.quick_data.file04, "mupdate_counter.json");
  expect(test.quick_data.file05, "update_counter.json");
  expect(test.quick_data.file06, "eat_in.json");
  expect(test.quick_data.file07, "suica.json");
  expect(test.quick_data.file08, "mm_abj.json");
  expect(test.quick_data.file09, "pmouse_2800_1.json");
  expect(test.quick_data.file10, "pmouse_2800_2.json");
  expect(test.quick_data.file11, "pmouse_2500_1.json");
  expect(test.quick_data.file12, "pmouse_2500_2.json");
  expect(test.quick_data.file13, "pbchg.json");
  expect(test.quick_data.file14, "pmouse_plus2_1.json");
  expect(test.quick_data.file15, "counter_JC_C.json");
  expect(test.quick_data.file16, "battery.json");
  expect(test.quick_data.file17, "pmouse_2800_3.json");
  expect(test.quick_data.file18, "repica.json");
  expect(test.quick_data.file19, "auto_update.json");
  expect(test.quick_data.file20, "tprtim_counter.json");
  expect(test.quick_data.file21, "devread.json");
  expect(test.quick_data.file22, "vacuum_date.json");
  expect(test.quick_data.file23, "pmouse_2800_4.json");
  expect(test.quick_data.file24, "ecs_fw.json");
  expect(test.quick_data.file25, "pmouse_5900_1.json");
  expect(test.quick_data.file26, "pmouse_2800_5.json");
  expect(test.quick_data.file27, "pmouse_2800_6.json");
  expect(test.quick_data.file28, "pmouse_2800_7.json");
  expect(test.quick_data.file29, "taxfree.json");
  expect(test.quick_data.file30, "auto_strcls_tran.json");
  expect(test.quick_data.file31, "acttrigger.json");
  expect(test.resetup_data.file_cnt, 12);
  expect(test.resetup_data.file01, "pmouse_2800_1.json");
  expect(test.resetup_data.file02, "pmouse_2800_2.json");
  expect(test.resetup_data.file03, "pmouse_2500_1.json");
  expect(test.resetup_data.file04, "pmouse_2500_2.json");
  expect(test.resetup_data.file05, "pmouse_plus2_1.json");
  expect(test.resetup_data.file06, "pmouse_2800_3.json");
  expect(test.resetup_data.file07, "pmouse_2800_4.json");
  expect(test.resetup_data.file08, "pmouse_2800_5.json");
  expect(test.resetup_data.file09, "ecs_fw.json");
  expect(test.resetup_data.file10, "pmouse_5900_1.json");
  expect(test.resetup_data.file11, "pmouse_2800_6.json");
  expect(test.resetup_data.file12, "pmouse_2800_7.json");
}

