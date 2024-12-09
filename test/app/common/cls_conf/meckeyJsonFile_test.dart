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
import '../../../../lib/app/common/cls_conf/meckeyJsonFile.dart';

late MeckeyJsonFile meckey;

void main(){
  meckeyJsonFile_test();
}

void meckeyJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "meckey.json";
  const String section = "meckey1";
  const String key = "key0";
  const defaultData = "0x1640";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('MeckeyJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await MeckeyJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await MeckeyJsonFile().setDefault();
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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await meckey.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(meckey,true);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        meckey.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await meckey.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(meckey,true);

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
      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①：loadを実行する。
      await meckey.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = meckey.meckey1.key0;
      meckey.meckey1.key0 = testData1s;
      expect(meckey.meckey1.key0 == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await meckey.load();
      expect(meckey.meckey1.key0 != testData1s, true);
      expect(meckey.meckey1.key0 == prefixData, true);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = meckey.meckey1.key0;
      meckey.meckey1.key0 = testData1s;
      expect(meckey.meckey1.key0, testData1s);

      // ③saveを実行する。
      await meckey.save();

      // ④loadを実行する。
      await meckey.load();

      expect(meckey.meckey1.key0 != prefixData, true);
      expect(meckey.meckey1.key0 == testData1s, true);
      allPropatyCheck(meckey,false);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await meckey.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await meckey.save();

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await meckey.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(meckey.meckey1.key0, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = meckey.meckey1.key0;
      meckey.meckey1.key0 = testData1s;

      // ③ saveを実行する。
      await meckey.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(meckey.meckey1.key0, testData1s);

      // ④ loadを実行する。
      await meckey.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(meckey.meckey1.key0 == testData1s, true);
      allPropatyCheck(meckey,false);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await meckey.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(meckey,true);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②任意のプロパティの値を変更する。
      meckey.meckey1.key0 = testData1s;
      expect(meckey.meckey1.key0, testData1s);

      // ③saveを実行する。
      await meckey.save();
      expect(meckey.meckey1.key0, testData1s);

      // ④loadを実行する。
      await meckey.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(meckey,true);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await meckey.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await meckey.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(meckey.meckey1.key0 == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await meckey.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await meckey.setValueWithName(section, "test_key", testData1s);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②任意のプロパティを変更する。
      meckey.meckey1.key0 = testData1s;

      // ③saveを実行する。
      await meckey.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await meckey.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②任意のプロパティを変更する。
      meckey.meckey1.key0 = testData1s;

      // ③saveを実行する。
      await meckey.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await meckey.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②任意のプロパティを変更する。
      meckey.meckey1.key0 = testData1s;

      // ③saveを実行する。
      await meckey.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await meckey.getValueWithName(section, "test_key");
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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await meckey.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      meckey.meckey1.key0 = testData1s;
      expect(meckey.meckey1.key0, testData1s);

      // ④saveを実行する。
      await meckey.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(meckey.meckey1.key0, testData1s);
      
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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await meckey.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + meckey.meckey1.key0.toString());
      expect(meckey.meckey1.key0 == testData1s, true);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await meckey.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + meckey.meckey1.key0.toString());
      expect(meckey.meckey1.key0 == testData2s, true);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await meckey.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + meckey.meckey1.key0.toString());
      expect(meckey.meckey1.key0 == testData1s, true);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await meckey.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + meckey.meckey1.key0.toString());
      expect(meckey.meckey1.key0 == testData2s, true);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await meckey.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + meckey.meckey1.key0.toString());
      expect(meckey.meckey1.key0 == testData1s, true);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await meckey.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + meckey.meckey1.key0.toString());
      expect(meckey.meckey1.key0 == testData1s, true);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await meckey.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + meckey.meckey1.key0.toString());
      allPropatyCheck(meckey,true);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await meckey.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + meckey.meckey1.key0.toString());
      allPropatyCheck(meckey,true);

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

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.key0;
      print(meckey.meckey1.key0);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.key0 = testData1s;
      print(meckey.meckey1.key0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.key0 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.key0 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.key0 = testData2s;
      print(meckey.meckey1.key0);
      expect(meckey.meckey1.key0 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key0 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.key0 = defalut;
      print(meckey.meckey1.key0);
      expect(meckey.meckey1.key0 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.key1;
      print(meckey.meckey1.key1);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.key1 = testData1s;
      print(meckey.meckey1.key1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.key1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.key1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.key1 = testData2s;
      print(meckey.meckey1.key1);
      expect(meckey.meckey1.key1 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.key1 = defalut;
      print(meckey.meckey1.key1);
      expect(meckey.meckey1.key1 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.key2;
      print(meckey.meckey1.key2);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.key2 = testData1s;
      print(meckey.meckey1.key2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.key2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.key2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.key2 = testData2s;
      print(meckey.meckey1.key2);
      expect(meckey.meckey1.key2 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.key2 = defalut;
      print(meckey.meckey1.key2);
      expect(meckey.meckey1.key2 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.key3;
      print(meckey.meckey1.key3);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.key3 = testData1s;
      print(meckey.meckey1.key3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.key3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.key3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.key3 = testData2s;
      print(meckey.meckey1.key3);
      expect(meckey.meckey1.key3 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.key3 = defalut;
      print(meckey.meckey1.key3);
      expect(meckey.meckey1.key3 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.key4;
      print(meckey.meckey1.key4);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.key4 = testData1s;
      print(meckey.meckey1.key4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.key4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.key4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.key4 = testData2s;
      print(meckey.meckey1.key4);
      expect(meckey.meckey1.key4 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.key4 = defalut;
      print(meckey.meckey1.key4);
      expect(meckey.meckey1.key4 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.key5;
      print(meckey.meckey1.key5);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.key5 = testData1s;
      print(meckey.meckey1.key5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.key5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.key5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.key5 = testData2s;
      print(meckey.meckey1.key5);
      expect(meckey.meckey1.key5 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.key5 = defalut;
      print(meckey.meckey1.key5);
      expect(meckey.meckey1.key5 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.key6;
      print(meckey.meckey1.key6);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.key6 = testData1s;
      print(meckey.meckey1.key6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.key6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.key6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.key6 = testData2s;
      print(meckey.meckey1.key6);
      expect(meckey.meckey1.key6 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.key6 = defalut;
      print(meckey.meckey1.key6);
      expect(meckey.meckey1.key6 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.key7;
      print(meckey.meckey1.key7);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.key7 = testData1s;
      print(meckey.meckey1.key7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.key7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.key7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.key7 = testData2s;
      print(meckey.meckey1.key7);
      expect(meckey.meckey1.key7 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.key7 = defalut;
      print(meckey.meckey1.key7);
      expect(meckey.meckey1.key7 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.key8;
      print(meckey.meckey1.key8);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.key8 = testData1s;
      print(meckey.meckey1.key8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.key8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.key8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.key8 = testData2s;
      print(meckey.meckey1.key8);
      expect(meckey.meckey1.key8 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.key8 = defalut;
      print(meckey.meckey1.key8);
      expect(meckey.meckey1.key8 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.key9;
      print(meckey.meckey1.key9);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.key9 = testData1s;
      print(meckey.meckey1.key9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.key9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.key9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.key9 = testData2s;
      print(meckey.meckey1.key9);
      expect(meckey.meckey1.key9 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.key9 = defalut;
      print(meckey.meckey1.key9);
      expect(meckey.meckey1.key9 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.key00;
      print(meckey.meckey1.key00);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.key00 = testData1s;
      print(meckey.meckey1.key00);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.key00 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.key00 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.key00 = testData2s;
      print(meckey.meckey1.key00);
      expect(meckey.meckey1.key00 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key00 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.key00 = defalut;
      print(meckey.meckey1.key00);
      expect(meckey.meckey1.key00 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key00 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.key000;
      print(meckey.meckey1.key000);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.key000 = testData1s;
      print(meckey.meckey1.key000);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.key000 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.key000 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.key000 = testData2s;
      print(meckey.meckey1.key000);
      expect(meckey.meckey1.key000 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key000 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.key000 = defalut;
      print(meckey.meckey1.key000);
      expect(meckey.meckey1.key000 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.key000 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.RET;
      print(meckey.meckey1.RET);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.RET = testData1s;
      print(meckey.meckey1.RET);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.RET == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.RET == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.RET = testData2s;
      print(meckey.meckey1.RET);
      expect(meckey.meckey1.RET == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.RET == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.RET = defalut;
      print(meckey.meckey1.RET);
      expect(meckey.meckey1.RET == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.RET == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.CLS;
      print(meckey.meckey1.CLS);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.CLS = testData1s;
      print(meckey.meckey1.CLS);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.CLS == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.CLS == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.CLS = testData2s;
      print(meckey.meckey1.CLS);
      expect(meckey.meckey1.CLS == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.CLS == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.CLS = defalut;
      print(meckey.meckey1.CLS);
      expect(meckey.meckey1.CLS == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.CLS == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.FEED;
      print(meckey.meckey1.FEED);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.FEED = testData1s;
      print(meckey.meckey1.FEED);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.FEED == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.FEED == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.FEED = testData2s;
      print(meckey.meckey1.FEED);
      expect(meckey.meckey1.FEED == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.FEED == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.FEED = defalut;
      print(meckey.meckey1.FEED);
      expect(meckey.meckey1.FEED == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.FEED == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.PLU;
      print(meckey.meckey1.PLU);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.PLU = testData1s;
      print(meckey.meckey1.PLU);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.PLU == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.PLU == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.PLU = testData2s;
      print(meckey.meckey1.PLU);
      expect(meckey.meckey1.PLU == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.PLU == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.PLU = defalut;
      print(meckey.meckey1.PLU);
      expect(meckey.meckey1.PLU == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.PLU == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey1.STL;
      print(meckey.meckey1.STL);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey1.STL = testData1s;
      print(meckey.meckey1.STL);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey1.STL == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey1.STL == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey1.STL = testData2s;
      print(meckey.meckey1.STL);
      expect(meckey.meckey1.STL == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.STL == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey1.STL = defalut;
      print(meckey.meckey1.STL);
      expect(meckey.meckey1.STL == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey1.STL == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.key0;
      print(meckey.meckey2.key0);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.key0 = testData1s;
      print(meckey.meckey2.key0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.key0 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.key0 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.key0 = testData2s;
      print(meckey.meckey2.key0);
      expect(meckey.meckey2.key0 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key0 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.key0 = defalut;
      print(meckey.meckey2.key0);
      expect(meckey.meckey2.key0 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.key1;
      print(meckey.meckey2.key1);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.key1 = testData1s;
      print(meckey.meckey2.key1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.key1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.key1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.key1 = testData2s;
      print(meckey.meckey2.key1);
      expect(meckey.meckey2.key1 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.key1 = defalut;
      print(meckey.meckey2.key1);
      expect(meckey.meckey2.key1 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.key2;
      print(meckey.meckey2.key2);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.key2 = testData1s;
      print(meckey.meckey2.key2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.key2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.key2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.key2 = testData2s;
      print(meckey.meckey2.key2);
      expect(meckey.meckey2.key2 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.key2 = defalut;
      print(meckey.meckey2.key2);
      expect(meckey.meckey2.key2 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.key3;
      print(meckey.meckey2.key3);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.key3 = testData1s;
      print(meckey.meckey2.key3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.key3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.key3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.key3 = testData2s;
      print(meckey.meckey2.key3);
      expect(meckey.meckey2.key3 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.key3 = defalut;
      print(meckey.meckey2.key3);
      expect(meckey.meckey2.key3 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.key4;
      print(meckey.meckey2.key4);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.key4 = testData1s;
      print(meckey.meckey2.key4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.key4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.key4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.key4 = testData2s;
      print(meckey.meckey2.key4);
      expect(meckey.meckey2.key4 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.key4 = defalut;
      print(meckey.meckey2.key4);
      expect(meckey.meckey2.key4 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.key5;
      print(meckey.meckey2.key5);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.key5 = testData1s;
      print(meckey.meckey2.key5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.key5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.key5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.key5 = testData2s;
      print(meckey.meckey2.key5);
      expect(meckey.meckey2.key5 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.key5 = defalut;
      print(meckey.meckey2.key5);
      expect(meckey.meckey2.key5 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.key6;
      print(meckey.meckey2.key6);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.key6 = testData1s;
      print(meckey.meckey2.key6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.key6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.key6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.key6 = testData2s;
      print(meckey.meckey2.key6);
      expect(meckey.meckey2.key6 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.key6 = defalut;
      print(meckey.meckey2.key6);
      expect(meckey.meckey2.key6 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.key7;
      print(meckey.meckey2.key7);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.key7 = testData1s;
      print(meckey.meckey2.key7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.key7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.key7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.key7 = testData2s;
      print(meckey.meckey2.key7);
      expect(meckey.meckey2.key7 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.key7 = defalut;
      print(meckey.meckey2.key7);
      expect(meckey.meckey2.key7 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.key8;
      print(meckey.meckey2.key8);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.key8 = testData1s;
      print(meckey.meckey2.key8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.key8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.key8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.key8 = testData2s;
      print(meckey.meckey2.key8);
      expect(meckey.meckey2.key8 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.key8 = defalut;
      print(meckey.meckey2.key8);
      expect(meckey.meckey2.key8 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.key9;
      print(meckey.meckey2.key9);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.key9 = testData1s;
      print(meckey.meckey2.key9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.key9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.key9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.key9 = testData2s;
      print(meckey.meckey2.key9);
      expect(meckey.meckey2.key9 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.key9 = defalut;
      print(meckey.meckey2.key9);
      expect(meckey.meckey2.key9 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.key00;
      print(meckey.meckey2.key00);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.key00 = testData1s;
      print(meckey.meckey2.key00);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.key00 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.key00 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.key00 = testData2s;
      print(meckey.meckey2.key00);
      expect(meckey.meckey2.key00 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key00 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.key00 = defalut;
      print(meckey.meckey2.key00);
      expect(meckey.meckey2.key00 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key00 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.key000;
      print(meckey.meckey2.key000);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.key000 = testData1s;
      print(meckey.meckey2.key000);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.key000 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.key000 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.key000 = testData2s;
      print(meckey.meckey2.key000);
      expect(meckey.meckey2.key000 == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key000 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.key000 = defalut;
      print(meckey.meckey2.key000);
      expect(meckey.meckey2.key000 == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.key000 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.RET;
      print(meckey.meckey2.RET);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.RET = testData1s;
      print(meckey.meckey2.RET);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.RET == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.RET == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.RET = testData2s;
      print(meckey.meckey2.RET);
      expect(meckey.meckey2.RET == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.RET == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.RET = defalut;
      print(meckey.meckey2.RET);
      expect(meckey.meckey2.RET == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.RET == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.CLS;
      print(meckey.meckey2.CLS);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.CLS = testData1s;
      print(meckey.meckey2.CLS);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.CLS == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.CLS == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.CLS = testData2s;
      print(meckey.meckey2.CLS);
      expect(meckey.meckey2.CLS == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.CLS == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.CLS = defalut;
      print(meckey.meckey2.CLS);
      expect(meckey.meckey2.CLS == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.CLS == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.FEED;
      print(meckey.meckey2.FEED);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.FEED = testData1s;
      print(meckey.meckey2.FEED);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.FEED == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.FEED == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.FEED = testData2s;
      print(meckey.meckey2.FEED);
      expect(meckey.meckey2.FEED == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.FEED == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.FEED = defalut;
      print(meckey.meckey2.FEED);
      expect(meckey.meckey2.FEED == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.FEED == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.PLU;
      print(meckey.meckey2.PLU);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.PLU = testData1s;
      print(meckey.meckey2.PLU);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.PLU == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.PLU == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.PLU = testData2s;
      print(meckey.meckey2.PLU);
      expect(meckey.meckey2.PLU == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.PLU == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.PLU = defalut;
      print(meckey.meckey2.PLU);
      expect(meckey.meckey2.PLU == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.PLU == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      meckey = MeckeyJsonFile();
      allPropatyCheckInit(meckey);

      // ①loadを実行する。
      await meckey.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = meckey.meckey2.STL;
      print(meckey.meckey2.STL);

      // ②指定したプロパティにテストデータ1を書き込む。
      meckey.meckey2.STL = testData1s;
      print(meckey.meckey2.STL);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(meckey.meckey2.STL == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await meckey.save();
      await meckey.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(meckey.meckey2.STL == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      meckey.meckey2.STL = testData2s;
      print(meckey.meckey2.STL);
      expect(meckey.meckey2.STL == testData2s, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.STL == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      meckey.meckey2.STL = defalut;
      print(meckey.meckey2.STL);
      expect(meckey.meckey2.STL == defalut, true);
      await meckey.save();
      await meckey.load();
      expect(meckey.meckey2.STL == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(meckey, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

  });
}

void allPropatyCheckInit(MeckeyJsonFile test)
{
  expect(test.meckey1.key0, "");
  expect(test.meckey1.key1, "");
  expect(test.meckey1.key2, "");
  expect(test.meckey1.key3, "");
  expect(test.meckey1.key4, "");
  expect(test.meckey1.key5, "");
  expect(test.meckey1.key6, "");
  expect(test.meckey1.key7, "");
  expect(test.meckey1.key8, "");
  expect(test.meckey1.key9, "");
  expect(test.meckey1.key00, "");
  expect(test.meckey1.key000, "");
  expect(test.meckey1.RET, "");
  expect(test.meckey1.CLS, "");
  expect(test.meckey1.FEED, "");
  expect(test.meckey1.PLU, "");
  expect(test.meckey1.STL, "");
  expect(test.meckey2.key0, "");
  expect(test.meckey2.key1, "");
  expect(test.meckey2.key2, "");
  expect(test.meckey2.key3, "");
  expect(test.meckey2.key4, "");
  expect(test.meckey2.key5, "");
  expect(test.meckey2.key6, "");
  expect(test.meckey2.key7, "");
  expect(test.meckey2.key8, "");
  expect(test.meckey2.key9, "");
  expect(test.meckey2.key00, "");
  expect(test.meckey2.key000, "");
  expect(test.meckey2.RET, "");
  expect(test.meckey2.CLS, "");
  expect(test.meckey2.FEED, "");
  expect(test.meckey2.PLU, "");
  expect(test.meckey2.STL, "");
}

void allPropatyCheck(MeckeyJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.meckey1.key0, "0x1640");
  }
  expect(test.meckey1.key1, "0x1610");
  expect(test.meckey1.key2, "0x1020");
  expect(test.meckey1.key3, "0x1120");
  expect(test.meckey1.key4, "0x1604");
  expect(test.meckey1.key5, "0x1008");
  expect(test.meckey1.key6, "0x1108");
  expect(test.meckey1.key7, "0x1601");
  expect(test.meckey1.key8, "0x1002");
  expect(test.meckey1.key9, "0x1102");
  expect(test.meckey1.key00, "0x1180");
  expect(test.meckey1.key000, "");
  expect(test.meckey1.RET, "0x1580");
  expect(test.meckey1.CLS, "0x1440");
  expect(test.meckey1.FEED, "0x1004");
  expect(test.meckey1.PLU, "0x1320");
  expect(test.meckey1.STL, "0x1380");
  expect(test.meckey2.key0, "0x1004");
  expect(test.meckey2.key1, "0x1002");
  expect(test.meckey2.key2, "0x1102");
  expect(test.meckey2.key3, "0x1202");
  expect(test.meckey2.key4, "0x1001");
  expect(test.meckey2.key5, "0x1101");
  expect(test.meckey2.key6, "0x1201");
  expect(test.meckey2.key7, "0x1020");
  expect(test.meckey2.key8, "0x1120");
  expect(test.meckey2.key9, "0x1220");
  expect(test.meckey2.key00, "0x1204");
  expect(test.meckey2.key000, "");
  expect(test.meckey2.RET, "0x1304");
  expect(test.meckey2.CLS, "0x1040");
  expect(test.meckey2.FEED, "");
  expect(test.meckey2.PLU, "0x1320");
  expect(test.meckey2.STL, "0x1302");
}

