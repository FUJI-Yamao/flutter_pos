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
import '../../../../lib/app/common/cls_conf/counterJsonFile.dart';

late CounterJsonFile counter;

void main(){
  counterJsonFile_test();
}

void counterJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "counter.json";
  const String section = "tran";
  const String key = "rcpt_no";
  const defaultData = 1;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('CounterJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await CounterJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await CounterJsonFile().setDefault();
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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await counter.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(counter,true);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        counter.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await counter.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(counter,true);

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
      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①：loadを実行する。
      await counter.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = counter.tran.rcpt_no;
      counter.tran.rcpt_no = testData1;
      expect(counter.tran.rcpt_no == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await counter.load();
      expect(counter.tran.rcpt_no != testData1, true);
      expect(counter.tran.rcpt_no == prefixData, true);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = counter.tran.rcpt_no;
      counter.tran.rcpt_no = testData1;
      expect(counter.tran.rcpt_no, testData1);

      // ③saveを実行する。
      await counter.save();

      // ④loadを実行する。
      await counter.load();

      expect(counter.tran.rcpt_no != prefixData, true);
      expect(counter.tran.rcpt_no == testData1, true);
      allPropatyCheck(counter,false);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await counter.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await counter.save();

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await counter.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(counter.tran.rcpt_no, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = counter.tran.rcpt_no;
      counter.tran.rcpt_no = testData1;

      // ③ saveを実行する。
      await counter.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(counter.tran.rcpt_no, testData1);

      // ④ loadを実行する。
      await counter.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(counter.tran.rcpt_no == testData1, true);
      allPropatyCheck(counter,false);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await counter.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(counter,true);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②任意のプロパティの値を変更する。
      counter.tran.rcpt_no = testData1;
      expect(counter.tran.rcpt_no, testData1);

      // ③saveを実行する。
      await counter.save();
      expect(counter.tran.rcpt_no, testData1);

      // ④loadを実行する。
      await counter.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(counter,true);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await counter.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await counter.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(counter.tran.rcpt_no == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await counter.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await counter.setValueWithName(section, "test_key", testData1);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②任意のプロパティを変更する。
      counter.tran.rcpt_no = testData1;

      // ③saveを実行する。
      await counter.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await counter.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②任意のプロパティを変更する。
      counter.tran.rcpt_no = testData1;

      // ③saveを実行する。
      await counter.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await counter.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②任意のプロパティを変更する。
      counter.tran.rcpt_no = testData1;

      // ③saveを実行する。
      await counter.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await counter.getValueWithName(section, "test_key");
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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await counter.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      counter.tran.rcpt_no = testData1;
      expect(counter.tran.rcpt_no, testData1);

      // ④saveを実行する。
      await counter.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(counter.tran.rcpt_no, testData1);
      
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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await counter.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + counter.tran.rcpt_no.toString());
      expect(counter.tran.rcpt_no == testData1, true);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await counter.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + counter.tran.rcpt_no.toString());
      expect(counter.tran.rcpt_no == testData2, true);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await counter.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + counter.tran.rcpt_no.toString());
      expect(counter.tran.rcpt_no == testData1, true);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await counter.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + counter.tran.rcpt_no.toString());
      expect(counter.tran.rcpt_no == testData2, true);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await counter.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + counter.tran.rcpt_no.toString());
      expect(counter.tran.rcpt_no == testData1, true);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await counter.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + counter.tran.rcpt_no.toString());
      expect(counter.tran.rcpt_no == testData1, true);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await counter.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + counter.tran.rcpt_no.toString());
      allPropatyCheck(counter,true);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await counter.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + counter.tran.rcpt_no.toString());
      allPropatyCheck(counter,true);

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

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.rcpt_no;
      print(counter.tran.rcpt_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.rcpt_no = testData1;
      print(counter.tran.rcpt_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.rcpt_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.rcpt_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.rcpt_no = testData2;
      print(counter.tran.rcpt_no);
      expect(counter.tran.rcpt_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.rcpt_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.rcpt_no = defalut;
      print(counter.tran.rcpt_no);
      expect(counter.tran.rcpt_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.rcpt_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.print_no;
      print(counter.tran.print_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.print_no = testData1;
      print(counter.tran.print_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.print_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.print_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.print_no = testData2;
      print(counter.tran.print_no);
      expect(counter.tran.print_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.print_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.print_no = defalut;
      print(counter.tran.print_no);
      expect(counter.tran.print_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.print_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.sale_date;
      print(counter.tran.sale_date);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.sale_date = testData1s;
      print(counter.tran.sale_date);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.sale_date == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.sale_date == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.sale_date = testData2s;
      print(counter.tran.sale_date);
      expect(counter.tran.sale_date == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.sale_date == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.sale_date = defalut;
      print(counter.tran.sale_date);
      expect(counter.tran.sale_date == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.sale_date == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.last_sale_date;
      print(counter.tran.last_sale_date);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.last_sale_date = testData1s;
      print(counter.tran.last_sale_date);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.last_sale_date == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.last_sale_date == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.last_sale_date = testData2s;
      print(counter.tran.last_sale_date);
      expect(counter.tran.last_sale_date == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.last_sale_date == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.last_sale_date = defalut;
      print(counter.tran.last_sale_date);
      expect(counter.tran.last_sale_date == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.last_sale_date == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.receipt_no;
      print(counter.tran.receipt_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.receipt_no = testData1;
      print(counter.tran.receipt_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.receipt_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.receipt_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.receipt_no = testData2;
      print(counter.tran.receipt_no);
      expect(counter.tran.receipt_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.receipt_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.receipt_no = defalut;
      print(counter.tran.receipt_no);
      expect(counter.tran.receipt_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.receipt_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.debit_no;
      print(counter.tran.debit_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.debit_no = testData1;
      print(counter.tran.debit_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.debit_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.debit_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.debit_no = testData2;
      print(counter.tran.debit_no);
      expect(counter.tran.debit_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.debit_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.debit_no = defalut;
      print(counter.tran.debit_no);
      expect(counter.tran.debit_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.debit_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.credit_no;
      print(counter.tran.credit_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.credit_no = testData1;
      print(counter.tran.credit_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.credit_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.credit_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.credit_no = testData2;
      print(counter.tran.credit_no);
      expect(counter.tran.credit_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.credit_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.credit_no = defalut;
      print(counter.tran.credit_no);
      expect(counter.tran.credit_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.credit_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.last_ej_bkup;
      print(counter.tran.last_ej_bkup);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.last_ej_bkup = testData1s;
      print(counter.tran.last_ej_bkup);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.last_ej_bkup == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.last_ej_bkup == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.last_ej_bkup = testData2s;
      print(counter.tran.last_ej_bkup);
      expect(counter.tran.last_ej_bkup == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.last_ej_bkup == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.last_ej_bkup = defalut;
      print(counter.tran.last_ej_bkup);
      expect(counter.tran.last_ej_bkup == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.last_ej_bkup == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.last_data_bkup;
      print(counter.tran.last_data_bkup);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.last_data_bkup = testData1s;
      print(counter.tran.last_data_bkup);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.last_data_bkup == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.last_data_bkup == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.last_data_bkup = testData2s;
      print(counter.tran.last_data_bkup);
      expect(counter.tran.last_data_bkup == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.last_data_bkup == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.last_data_bkup = defalut;
      print(counter.tran.last_data_bkup);
      expect(counter.tran.last_data_bkup == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.last_data_bkup == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.guarantee_no;
      print(counter.tran.guarantee_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.guarantee_no = testData1;
      print(counter.tran.guarantee_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.guarantee_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.guarantee_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.guarantee_no = testData2;
      print(counter.tran.guarantee_no);
      expect(counter.tran.guarantee_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.guarantee_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.guarantee_no = defalut;
      print(counter.tran.guarantee_no);
      expect(counter.tran.guarantee_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.guarantee_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.ttllog_all_cnt;
      print(counter.tran.ttllog_all_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.ttllog_all_cnt = testData1;
      print(counter.tran.ttllog_all_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.ttllog_all_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.ttllog_all_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.ttllog_all_cnt = testData2;
      print(counter.tran.ttllog_all_cnt);
      expect(counter.tran.ttllog_all_cnt == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.ttllog_all_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.ttllog_all_cnt = defalut;
      print(counter.tran.ttllog_all_cnt);
      expect(counter.tran.ttllog_all_cnt == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.ttllog_all_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.ttllog_m_cnt;
      print(counter.tran.ttllog_m_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.ttllog_m_cnt = testData1;
      print(counter.tran.ttllog_m_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.ttllog_m_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.ttllog_m_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.ttllog_m_cnt = testData2;
      print(counter.tran.ttllog_m_cnt);
      expect(counter.tran.ttllog_m_cnt == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.ttllog_m_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.ttllog_m_cnt = defalut;
      print(counter.tran.ttllog_m_cnt);
      expect(counter.tran.ttllog_m_cnt == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.ttllog_m_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.ttllog_bs_cnt;
      print(counter.tran.ttllog_bs_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.ttllog_bs_cnt = testData1;
      print(counter.tran.ttllog_bs_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.ttllog_bs_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.ttllog_bs_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.ttllog_bs_cnt = testData2;
      print(counter.tran.ttllog_bs_cnt);
      expect(counter.tran.ttllog_bs_cnt == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.ttllog_bs_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.ttllog_bs_cnt = defalut;
      print(counter.tran.ttllog_bs_cnt);
      expect(counter.tran.ttllog_bs_cnt == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.ttllog_bs_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.pos_no;
      print(counter.tran.pos_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.pos_no = testData1;
      print(counter.tran.pos_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.pos_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.pos_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.pos_no = testData2;
      print(counter.tran.pos_no);
      expect(counter.tran.pos_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.pos_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.pos_no = defalut;
      print(counter.tran.pos_no);
      expect(counter.tran.pos_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.pos_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.onetime_no;
      print(counter.tran.onetime_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.onetime_no = testData1;
      print(counter.tran.onetime_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.onetime_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.onetime_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.onetime_no = testData2;
      print(counter.tran.onetime_no);
      expect(counter.tran.onetime_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.onetime_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.onetime_no = defalut;
      print(counter.tran.onetime_no);
      expect(counter.tran.onetime_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.onetime_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.cardcash_no;
      print(counter.tran.cardcash_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.cardcash_no = testData1;
      print(counter.tran.cardcash_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.cardcash_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.cardcash_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.cardcash_no = testData2;
      print(counter.tran.cardcash_no);
      expect(counter.tran.cardcash_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.cardcash_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.cardcash_no = defalut;
      print(counter.tran.cardcash_no);
      expect(counter.tran.cardcash_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.cardcash_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.nocardcash_no;
      print(counter.tran.nocardcash_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.nocardcash_no = testData1;
      print(counter.tran.nocardcash_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.nocardcash_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.nocardcash_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.nocardcash_no = testData2;
      print(counter.tran.nocardcash_no);
      expect(counter.tran.nocardcash_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.nocardcash_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.nocardcash_no = defalut;
      print(counter.tran.nocardcash_no);
      expect(counter.tran.nocardcash_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.nocardcash_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.cardfee_no;
      print(counter.tran.cardfee_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.cardfee_no = testData1;
      print(counter.tran.cardfee_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.cardfee_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.cardfee_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.cardfee_no = testData2;
      print(counter.tran.cardfee_no);
      expect(counter.tran.cardfee_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.cardfee_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.cardfee_no = defalut;
      print(counter.tran.cardfee_no);
      expect(counter.tran.cardfee_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.cardfee_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.othcrdt_no;
      print(counter.tran.othcrdt_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.othcrdt_no = testData1;
      print(counter.tran.othcrdt_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.othcrdt_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.othcrdt_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.othcrdt_no = testData2;
      print(counter.tran.othcrdt_no);
      expect(counter.tran.othcrdt_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.othcrdt_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.othcrdt_no = defalut;
      print(counter.tran.othcrdt_no);
      expect(counter.tran.othcrdt_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.othcrdt_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.owncrdt_no;
      print(counter.tran.owncrdt_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.owncrdt_no = testData1;
      print(counter.tran.owncrdt_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.owncrdt_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.owncrdt_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.owncrdt_no = testData2;
      print(counter.tran.owncrdt_no);
      expect(counter.tran.owncrdt_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.owncrdt_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.owncrdt_no = defalut;
      print(counter.tran.owncrdt_no);
      expect(counter.tran.owncrdt_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.owncrdt_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.crdtcan_no;
      print(counter.tran.crdtcan_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.crdtcan_no = testData1;
      print(counter.tran.crdtcan_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.crdtcan_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.crdtcan_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.crdtcan_no = testData2;
      print(counter.tran.crdtcan_no);
      expect(counter.tran.crdtcan_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.crdtcan_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.crdtcan_no = defalut;
      print(counter.tran.crdtcan_no);
      expect(counter.tran.crdtcan_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.crdtcan_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.poppy_cnt;
      print(counter.tran.poppy_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.poppy_cnt = testData1;
      print(counter.tran.poppy_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.poppy_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.poppy_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.poppy_cnt = testData2;
      print(counter.tran.poppy_cnt);
      expect(counter.tran.poppy_cnt == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.poppy_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.poppy_cnt = defalut;
      print(counter.tran.poppy_cnt);
      expect(counter.tran.poppy_cnt == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.poppy_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.nttasp_credit_no;
      print(counter.tran.nttasp_credit_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.nttasp_credit_no = testData1;
      print(counter.tran.nttasp_credit_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.nttasp_credit_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.nttasp_credit_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.nttasp_credit_no = testData2;
      print(counter.tran.nttasp_credit_no);
      expect(counter.tran.nttasp_credit_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.nttasp_credit_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.nttasp_credit_no = defalut;
      print(counter.tran.nttasp_credit_no);
      expect(counter.tran.nttasp_credit_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.nttasp_credit_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.nttasp_corr_stat;
      print(counter.tran.nttasp_corr_stat);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.nttasp_corr_stat = testData1;
      print(counter.tran.nttasp_corr_stat);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.nttasp_corr_stat == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.nttasp_corr_stat == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.nttasp_corr_stat = testData2;
      print(counter.tran.nttasp_corr_stat);
      expect(counter.tran.nttasp_corr_stat == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.nttasp_corr_stat == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.nttasp_corr_stat = defalut;
      print(counter.tran.nttasp_corr_stat);
      expect(counter.tran.nttasp_corr_stat == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.nttasp_corr_stat == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.nttasp_corr_reno;
      print(counter.tran.nttasp_corr_reno);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.nttasp_corr_reno = testData1;
      print(counter.tran.nttasp_corr_reno);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.nttasp_corr_reno == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.nttasp_corr_reno == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.nttasp_corr_reno = testData2;
      print(counter.tran.nttasp_corr_reno);
      expect(counter.tran.nttasp_corr_reno == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.nttasp_corr_reno == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.nttasp_corr_reno = defalut;
      print(counter.tran.nttasp_corr_reno);
      expect(counter.tran.nttasp_corr_reno == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.nttasp_corr_reno == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.nttasp_corr_date;
      print(counter.tran.nttasp_corr_date);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.nttasp_corr_date = testData1s;
      print(counter.tran.nttasp_corr_date);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.nttasp_corr_date == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.nttasp_corr_date == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.nttasp_corr_date = testData2s;
      print(counter.tran.nttasp_corr_date);
      expect(counter.tran.nttasp_corr_date == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.nttasp_corr_date == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.nttasp_corr_date = defalut;
      print(counter.tran.nttasp_corr_date);
      expect(counter.tran.nttasp_corr_date == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.nttasp_corr_date == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.eat_in_now;
      print(counter.tran.eat_in_now);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.eat_in_now = testData1;
      print(counter.tran.eat_in_now);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.eat_in_now == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.eat_in_now == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.eat_in_now = testData2;
      print(counter.tran.eat_in_now);
      expect(counter.tran.eat_in_now == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.eat_in_now == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.eat_in_now = defalut;
      print(counter.tran.eat_in_now);
      expect(counter.tran.eat_in_now == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.eat_in_now == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.tw_no;
      print(counter.tran.tw_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.tw_no = testData1;
      print(counter.tran.tw_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.tw_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.tw_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.tw_no = testData2;
      print(counter.tran.tw_no);
      expect(counter.tran.tw_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.tw_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.tw_no = defalut;
      print(counter.tran.tw_no);
      expect(counter.tran.tw_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.tw_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.edy_pos_id;
      print(counter.tran.edy_pos_id);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.edy_pos_id = testData1;
      print(counter.tran.edy_pos_id);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.edy_pos_id == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.edy_pos_id == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.edy_pos_id = testData2;
      print(counter.tran.edy_pos_id);
      expect(counter.tran.edy_pos_id == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.edy_pos_id == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.edy_pos_id = defalut;
      print(counter.tran.edy_pos_id);
      expect(counter.tran.edy_pos_id == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.edy_pos_id == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.sip_pos_ky;
      print(counter.tran.sip_pos_ky);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.sip_pos_ky = testData1;
      print(counter.tran.sip_pos_ky);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.sip_pos_ky == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.sip_pos_ky == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.sip_pos_ky = testData2;
      print(counter.tran.sip_pos_ky);
      expect(counter.tran.sip_pos_ky == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.sip_pos_ky == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.sip_pos_ky = defalut;
      print(counter.tran.sip_pos_ky);
      expect(counter.tran.sip_pos_ky == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.sip_pos_ky == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.encrypt_PidNew;
      print(counter.tran.encrypt_PidNew);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.encrypt_PidNew = testData1s;
      print(counter.tran.encrypt_PidNew);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.encrypt_PidNew == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.encrypt_PidNew == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.encrypt_PidNew = testData2s;
      print(counter.tran.encrypt_PidNew);
      expect(counter.tran.encrypt_PidNew == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.encrypt_PidNew == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.encrypt_PidNew = defalut;
      print(counter.tran.encrypt_PidNew);
      expect(counter.tran.encrypt_PidNew == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.encrypt_PidNew == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.encrypt_ErK1di;
      print(counter.tran.encrypt_ErK1di);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.encrypt_ErK1di = testData1s;
      print(counter.tran.encrypt_ErK1di);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.encrypt_ErK1di == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.encrypt_ErK1di == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.encrypt_ErK1di = testData2s;
      print(counter.tran.encrypt_ErK1di);
      expect(counter.tran.encrypt_ErK1di == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.encrypt_ErK1di == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.encrypt_ErK1di = defalut;
      print(counter.tran.encrypt_ErK1di);
      expect(counter.tran.encrypt_ErK1di == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.encrypt_ErK1di == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.encrypt_send_date;
      print(counter.tran.encrypt_send_date);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.encrypt_send_date = testData1s;
      print(counter.tran.encrypt_send_date);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.encrypt_send_date == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.encrypt_send_date == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.encrypt_send_date = testData2s;
      print(counter.tran.encrypt_send_date);
      expect(counter.tran.encrypt_send_date == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.encrypt_send_date == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.encrypt_send_date = defalut;
      print(counter.tran.encrypt_send_date);
      expect(counter.tran.encrypt_send_date == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.encrypt_send_date == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.encrypt_credit_no;
      print(counter.tran.encrypt_credit_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.encrypt_credit_no = testData1s;
      print(counter.tran.encrypt_credit_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.encrypt_credit_no == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.encrypt_credit_no == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.encrypt_credit_no = testData2s;
      print(counter.tran.encrypt_credit_no);
      expect(counter.tran.encrypt_credit_no == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.encrypt_credit_no == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.encrypt_credit_no = defalut;
      print(counter.tran.encrypt_credit_no);
      expect(counter.tran.encrypt_credit_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.encrypt_credit_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.deliv_rct_no;
      print(counter.tran.deliv_rct_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.deliv_rct_no = testData1;
      print(counter.tran.deliv_rct_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.deliv_rct_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.deliv_rct_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.deliv_rct_no = testData2;
      print(counter.tran.deliv_rct_no);
      expect(counter.tran.deliv_rct_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.deliv_rct_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.deliv_rct_no = defalut;
      print(counter.tran.deliv_rct_no);
      expect(counter.tran.deliv_rct_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.deliv_rct_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.order_no;
      print(counter.tran.order_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.order_no = testData1;
      print(counter.tran.order_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.order_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.order_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.order_no = testData2;
      print(counter.tran.order_no);
      expect(counter.tran.order_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.order_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.order_no = defalut;
      print(counter.tran.order_no);
      expect(counter.tran.order_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.order_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.slip_no;
      print(counter.tran.slip_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.slip_no = testData1;
      print(counter.tran.slip_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.slip_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.slip_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.slip_no = testData2;
      print(counter.tran.slip_no);
      expect(counter.tran.slip_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.slip_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.slip_no = defalut;
      print(counter.tran.slip_no);
      expect(counter.tran.slip_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.slip_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.com_seq_no;
      print(counter.tran.com_seq_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.com_seq_no = testData1;
      print(counter.tran.com_seq_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.com_seq_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.com_seq_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.com_seq_no = testData2;
      print(counter.tran.com_seq_no);
      expect(counter.tran.com_seq_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.com_seq_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.com_seq_no = defalut;
      print(counter.tran.com_seq_no);
      expect(counter.tran.com_seq_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.com_seq_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.qs_at_clstime;
      print(counter.tran.qs_at_clstime);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.qs_at_clstime = testData1s;
      print(counter.tran.qs_at_clstime);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.qs_at_clstime == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.qs_at_clstime == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.qs_at_clstime = testData2s;
      print(counter.tran.qs_at_clstime);
      expect(counter.tran.qs_at_clstime == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.qs_at_clstime == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.qs_at_clstime = defalut;
      print(counter.tran.qs_at_clstime);
      expect(counter.tran.qs_at_clstime == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.qs_at_clstime == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.qs_at_waittimer;
      print(counter.tran.qs_at_waittimer);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.qs_at_waittimer = testData1;
      print(counter.tran.qs_at_waittimer);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.qs_at_waittimer == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.qs_at_waittimer == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.qs_at_waittimer = testData2;
      print(counter.tran.qs_at_waittimer);
      expect(counter.tran.qs_at_waittimer == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.qs_at_waittimer == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.qs_at_waittimer = defalut;
      print(counter.tran.qs_at_waittimer);
      expect(counter.tran.qs_at_waittimer == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.qs_at_waittimer == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.qs_at_opndatetime;
      print(counter.tran.qs_at_opndatetime);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.qs_at_opndatetime = testData1s;
      print(counter.tran.qs_at_opndatetime);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.qs_at_opndatetime == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.qs_at_opndatetime == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.qs_at_opndatetime = testData2s;
      print(counter.tran.qs_at_opndatetime);
      expect(counter.tran.qs_at_opndatetime == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.qs_at_opndatetime == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.qs_at_opndatetime = defalut;
      print(counter.tran.qs_at_opndatetime);
      expect(counter.tran.qs_at_opndatetime == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.qs_at_opndatetime == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.fcl_dll_fix_time;
      print(counter.tran.fcl_dll_fix_time);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.fcl_dll_fix_time = testData1s;
      print(counter.tran.fcl_dll_fix_time);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.fcl_dll_fix_time == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.fcl_dll_fix_time == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.fcl_dll_fix_time = testData2s;
      print(counter.tran.fcl_dll_fix_time);
      expect(counter.tran.fcl_dll_fix_time == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.fcl_dll_fix_time == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.fcl_dll_fix_time = defalut;
      print(counter.tran.fcl_dll_fix_time);
      expect(counter.tran.fcl_dll_fix_time == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.fcl_dll_fix_time == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.end_saletime;
      print(counter.tran.end_saletime);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.end_saletime = testData1s;
      print(counter.tran.end_saletime);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.end_saletime == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.end_saletime == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.end_saletime = testData2s;
      print(counter.tran.end_saletime);
      expect(counter.tran.end_saletime == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.end_saletime == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.end_saletime = defalut;
      print(counter.tran.end_saletime);
      expect(counter.tran.end_saletime == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.end_saletime == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.qs_at_cls;
      print(counter.tran.qs_at_cls);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.qs_at_cls = testData1;
      print(counter.tran.qs_at_cls);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.qs_at_cls == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.qs_at_cls == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.qs_at_cls = testData2;
      print(counter.tran.qs_at_cls);
      expect(counter.tran.qs_at_cls == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.qs_at_cls == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.qs_at_cls = defalut;
      print(counter.tran.qs_at_cls);
      expect(counter.tran.qs_at_cls == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.qs_at_cls == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.mbrdsctckt_no;
      print(counter.tran.mbrdsctckt_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.mbrdsctckt_no = testData1;
      print(counter.tran.mbrdsctckt_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.mbrdsctckt_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.mbrdsctckt_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.mbrdsctckt_no = testData2;
      print(counter.tran.mbrdsctckt_no);
      expect(counter.tran.mbrdsctckt_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.mbrdsctckt_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.mbrdsctckt_no = defalut;
      print(counter.tran.mbrdsctckt_no);
      expect(counter.tran.mbrdsctckt_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.mbrdsctckt_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.ht2980_seq_no;
      print(counter.tran.ht2980_seq_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.ht2980_seq_no = testData1;
      print(counter.tran.ht2980_seq_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.ht2980_seq_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.ht2980_seq_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.ht2980_seq_no = testData2;
      print(counter.tran.ht2980_seq_no);
      expect(counter.tran.ht2980_seq_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.ht2980_seq_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.ht2980_seq_no = defalut;
      print(counter.tran.ht2980_seq_no);
      expect(counter.tran.ht2980_seq_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.ht2980_seq_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.duty_ej_count;
      print(counter.tran.duty_ej_count);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.duty_ej_count = testData1;
      print(counter.tran.duty_ej_count);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.duty_ej_count == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.duty_ej_count == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.duty_ej_count = testData2;
      print(counter.tran.duty_ej_count);
      expect(counter.tran.duty_ej_count == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.duty_ej_count == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.duty_ej_count = defalut;
      print(counter.tran.duty_ej_count);
      expect(counter.tran.duty_ej_count == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.duty_ej_count == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.last_clr_total;
      print(counter.tran.last_clr_total);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.last_clr_total = testData1s;
      print(counter.tran.last_clr_total);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.last_clr_total == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.last_clr_total == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.last_clr_total = testData2s;
      print(counter.tran.last_clr_total);
      expect(counter.tran.last_clr_total == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.last_clr_total == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.last_clr_total = defalut;
      print(counter.tran.last_clr_total);
      expect(counter.tran.last_clr_total == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.last_clr_total == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.special_user_count;
      print(counter.tran.special_user_count);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.special_user_count = testData1;
      print(counter.tran.special_user_count);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.special_user_count == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.special_user_count == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.special_user_count = testData2;
      print(counter.tran.special_user_count);
      expect(counter.tran.special_user_count == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.special_user_count == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.special_user_count = defalut;
      print(counter.tran.special_user_count);
      expect(counter.tran.special_user_count == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.special_user_count == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.mbr_prize_counter;
      print(counter.tran.mbr_prize_counter);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.mbr_prize_counter = testData1;
      print(counter.tran.mbr_prize_counter);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.mbr_prize_counter == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.mbr_prize_counter == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.mbr_prize_counter = testData2;
      print(counter.tran.mbr_prize_counter);
      expect(counter.tran.mbr_prize_counter == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.mbr_prize_counter == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.mbr_prize_counter = defalut;
      print(counter.tran.mbr_prize_counter);
      expect(counter.tran.mbr_prize_counter == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.mbr_prize_counter == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.sqrc_tct_cnt;
      print(counter.tran.sqrc_tct_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.sqrc_tct_cnt = testData1;
      print(counter.tran.sqrc_tct_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.sqrc_tct_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.sqrc_tct_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.sqrc_tct_cnt = testData2;
      print(counter.tran.sqrc_tct_cnt);
      expect(counter.tran.sqrc_tct_cnt == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.sqrc_tct_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.sqrc_tct_cnt = defalut;
      print(counter.tran.sqrc_tct_cnt);
      expect(counter.tran.sqrc_tct_cnt == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.sqrc_tct_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.P11_prize_counter;
      print(counter.tran.P11_prize_counter);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.P11_prize_counter = testData1;
      print(counter.tran.P11_prize_counter);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.P11_prize_counter == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.P11_prize_counter == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.P11_prize_counter = testData2;
      print(counter.tran.P11_prize_counter);
      expect(counter.tran.P11_prize_counter == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.P11_prize_counter == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.P11_prize_counter = defalut;
      print(counter.tran.P11_prize_counter);
      expect(counter.tran.P11_prize_counter == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.P11_prize_counter == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.P7_prize_counter;
      print(counter.tran.P7_prize_counter);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.P7_prize_counter = testData1;
      print(counter.tran.P7_prize_counter);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.P7_prize_counter == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.P7_prize_counter == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.P7_prize_counter = testData2;
      print(counter.tran.P7_prize_counter);
      expect(counter.tran.P7_prize_counter == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.P7_prize_counter == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.P7_prize_counter = defalut;
      print(counter.tran.P7_prize_counter);
      expect(counter.tran.P7_prize_counter == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.P7_prize_counter == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.p11_prize_group_counter;
      print(counter.tran.p11_prize_group_counter);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.p11_prize_group_counter = testData1;
      print(counter.tran.p11_prize_group_counter);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.p11_prize_group_counter == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.p11_prize_group_counter == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.p11_prize_group_counter = testData2;
      print(counter.tran.p11_prize_group_counter);
      expect(counter.tran.p11_prize_group_counter == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.p11_prize_group_counter == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.p11_prize_group_counter = defalut;
      print(counter.tran.p11_prize_group_counter);
      expect(counter.tran.p11_prize_group_counter == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.p11_prize_group_counter == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.strcls_counter;
      print(counter.tran.strcls_counter);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.strcls_counter = testData1;
      print(counter.tran.strcls_counter);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.strcls_counter == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.strcls_counter == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.strcls_counter = testData2;
      print(counter.tran.strcls_counter);
      expect(counter.tran.strcls_counter == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.strcls_counter == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.strcls_counter = defalut;
      print(counter.tran.strcls_counter);
      expect(counter.tran.strcls_counter == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.strcls_counter == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.stropn_counter;
      print(counter.tran.stropn_counter);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.stropn_counter = testData1;
      print(counter.tran.stropn_counter);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.stropn_counter == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.stropn_counter == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.stropn_counter = testData2;
      print(counter.tran.stropn_counter);
      expect(counter.tran.stropn_counter == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.stropn_counter == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.stropn_counter = defalut;
      print(counter.tran.stropn_counter);
      expect(counter.tran.stropn_counter == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.stropn_counter == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.last_rdly_clear;
      print(counter.tran.last_rdly_clear);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.last_rdly_clear = testData1s;
      print(counter.tran.last_rdly_clear);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.last_rdly_clear == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.last_rdly_clear == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.last_rdly_clear = testData2s;
      print(counter.tran.last_rdly_clear);
      expect(counter.tran.last_rdly_clear == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.last_rdly_clear == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.last_rdly_clear = defalut;
      print(counter.tran.last_rdly_clear);
      expect(counter.tran.last_rdly_clear == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.last_rdly_clear == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.cr2_chgcin_no;
      print(counter.tran.cr2_chgcin_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.cr2_chgcin_no = testData1;
      print(counter.tran.cr2_chgcin_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.cr2_chgcin_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.cr2_chgcin_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.cr2_chgcin_no = testData2;
      print(counter.tran.cr2_chgcin_no);
      expect(counter.tran.cr2_chgcin_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.cr2_chgcin_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.cr2_chgcin_no = defalut;
      print(counter.tran.cr2_chgcin_no);
      expect(counter.tran.cr2_chgcin_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.cr2_chgcin_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.cr2_chgout_no;
      print(counter.tran.cr2_chgout_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.cr2_chgout_no = testData1;
      print(counter.tran.cr2_chgout_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.cr2_chgout_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.cr2_chgout_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.cr2_chgout_no = testData2;
      print(counter.tran.cr2_chgout_no);
      expect(counter.tran.cr2_chgout_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.cr2_chgout_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.cr2_chgout_no = defalut;
      print(counter.tran.cr2_chgout_no);
      expect(counter.tran.cr2_chgout_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.cr2_chgout_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.now_open_datetime;
      print(counter.tran.now_open_datetime);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.now_open_datetime = testData1s;
      print(counter.tran.now_open_datetime);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.now_open_datetime == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.now_open_datetime == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.now_open_datetime = testData2s;
      print(counter.tran.now_open_datetime);
      expect(counter.tran.now_open_datetime == testData2s, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.now_open_datetime == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.now_open_datetime = defalut;
      print(counter.tran.now_open_datetime);
      expect(counter.tran.now_open_datetime == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.now_open_datetime == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.certificate_no;
      print(counter.tran.certificate_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.certificate_no = testData1;
      print(counter.tran.certificate_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.certificate_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.certificate_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.certificate_no = testData2;
      print(counter.tran.certificate_no);
      expect(counter.tran.certificate_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.certificate_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.certificate_no = defalut;
      print(counter.tran.certificate_no);
      expect(counter.tran.certificate_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.certificate_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.cct_seq_no;
      print(counter.tran.cct_seq_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.cct_seq_no = testData1;
      print(counter.tran.cct_seq_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.cct_seq_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.cct_seq_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.cct_seq_no = testData2;
      print(counter.tran.cct_seq_no);
      expect(counter.tran.cct_seq_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.cct_seq_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.cct_seq_no = defalut;
      print(counter.tran.cct_seq_no);
      expect(counter.tran.cct_seq_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.cct_seq_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.dpoint_proc_no;
      print(counter.tran.dpoint_proc_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.dpoint_proc_no = testData1;
      print(counter.tran.dpoint_proc_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.dpoint_proc_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.dpoint_proc_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.dpoint_proc_no = testData2;
      print(counter.tran.dpoint_proc_no);
      expect(counter.tran.dpoint_proc_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.dpoint_proc_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.dpoint_proc_no = defalut;
      print(counter.tran.dpoint_proc_no);
      expect(counter.tran.dpoint_proc_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.dpoint_proc_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.fresta_slip_no;
      print(counter.tran.fresta_slip_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.fresta_slip_no = testData1;
      print(counter.tran.fresta_slip_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.fresta_slip_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.fresta_slip_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.fresta_slip_no = testData2;
      print(counter.tran.fresta_slip_no);
      expect(counter.tran.fresta_slip_no == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.fresta_slip_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.fresta_slip_no = defalut;
      print(counter.tran.fresta_slip_no);
      expect(counter.tran.fresta_slip_no == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.fresta_slip_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      counter = CounterJsonFile();
      allPropatyCheckInit(counter);

      // ①loadを実行する。
      await counter.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = counter.tran.credit_no_vega;
      print(counter.tran.credit_no_vega);

      // ②指定したプロパティにテストデータ1を書き込む。
      counter.tran.credit_no_vega = testData1;
      print(counter.tran.credit_no_vega);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(counter.tran.credit_no_vega == testData1, true);

      // ④saveを実行後、loadを実行する。
      await counter.save();
      await counter.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(counter.tran.credit_no_vega == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      counter.tran.credit_no_vega = testData2;
      print(counter.tran.credit_no_vega);
      expect(counter.tran.credit_no_vega == testData2, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.credit_no_vega == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      counter.tran.credit_no_vega = defalut;
      print(counter.tran.credit_no_vega);
      expect(counter.tran.credit_no_vega == defalut, true);
      await counter.save();
      await counter.load();
      expect(counter.tran.credit_no_vega == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(counter, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

  });
}

void allPropatyCheckInit(CounterJsonFile test)
{
  expect(test.tran.rcpt_no, 0);
  expect(test.tran.print_no, 0);
  expect(test.tran.sale_date, "");
  expect(test.tran.last_sale_date, "");
  expect(test.tran.receipt_no, 0);
  expect(test.tran.debit_no, 0);
  expect(test.tran.credit_no, 0);
  expect(test.tran.last_ej_bkup, "");
  expect(test.tran.last_data_bkup, "");
  expect(test.tran.guarantee_no, 0);
  expect(test.tran.ttllog_all_cnt, 0);
  expect(test.tran.ttllog_m_cnt, 0);
  expect(test.tran.ttllog_bs_cnt, 0);
  expect(test.tran.pos_no, 0);
  expect(test.tran.onetime_no, 0);
  expect(test.tran.cardcash_no, 0);
  expect(test.tran.nocardcash_no, 0);
  expect(test.tran.cardfee_no, 0);
  expect(test.tran.othcrdt_no, 0);
  expect(test.tran.owncrdt_no, 0);
  expect(test.tran.crdtcan_no, 0);
  expect(test.tran.poppy_cnt, 0);
  expect(test.tran.nttasp_credit_no, 0);
  expect(test.tran.nttasp_corr_stat, 0);
  expect(test.tran.nttasp_corr_reno, 0);
  expect(test.tran.nttasp_corr_date, "");
  expect(test.tran.eat_in_now, 0);
  expect(test.tran.tw_no, 0);
  expect(test.tran.edy_pos_id, 0);
  expect(test.tran.sip_pos_ky, 0);
  expect(test.tran.encrypt_PidNew, "");
  expect(test.tran.encrypt_ErK1di, "");
  expect(test.tran.encrypt_send_date, "");
  expect(test.tran.encrypt_credit_no, "");
  expect(test.tran.deliv_rct_no, 0);
  expect(test.tran.order_no, 0);
  expect(test.tran.slip_no, 0);
  expect(test.tran.com_seq_no, 0);
  expect(test.tran.qs_at_clstime, "");
  expect(test.tran.qs_at_waittimer, 0);
  expect(test.tran.qs_at_opndatetime, "");
  expect(test.tran.fcl_dll_fix_time, "");
  expect(test.tran.end_saletime, "");
  expect(test.tran.qs_at_cls, 0);
  expect(test.tran.mbrdsctckt_no, 0);
  expect(test.tran.ht2980_seq_no, 0);
  expect(test.tran.duty_ej_count, 0);
  expect(test.tran.last_clr_total, "");
  expect(test.tran.special_user_count, 0);
  expect(test.tran.mbr_prize_counter, 0);
  expect(test.tran.sqrc_tct_cnt, 0);
  expect(test.tran.P11_prize_counter, 0);
  expect(test.tran.P7_prize_counter, 0);
  expect(test.tran.p11_prize_group_counter, 0);
  expect(test.tran.strcls_counter, 0);
  expect(test.tran.stropn_counter, 0);
  expect(test.tran.last_rdly_clear, "");
  expect(test.tran.cr2_chgcin_no, 0);
  expect(test.tran.cr2_chgout_no, 0);
  expect(test.tran.now_open_datetime, "");
  expect(test.tran.certificate_no, 0);
  expect(test.tran.cct_seq_no, 0);
  expect(test.tran.dpoint_proc_no, 0);
  expect(test.tran.fresta_slip_no, 0);
  expect(test.tran.credit_no_vega, 0);
}

void allPropatyCheck(CounterJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.tran.rcpt_no, 1);
  }
  expect(test.tran.print_no, 1);
  expect(test.tran.sale_date, "0000-00-00");
  expect(test.tran.last_sale_date, "0000-00-00");
  expect(test.tran.receipt_no, 1);
  expect(test.tran.debit_no, 1);
  expect(test.tran.credit_no, 1);
  expect(test.tran.last_ej_bkup, "0000-00-00");
  expect(test.tran.last_data_bkup, "0000-00-00");
  expect(test.tran.guarantee_no, 1);
  expect(test.tran.ttllog_all_cnt, 0);
  expect(test.tran.ttllog_m_cnt, 0);
  expect(test.tran.ttllog_bs_cnt, 0);
  expect(test.tran.pos_no, 1);
  expect(test.tran.onetime_no, 500001);
  expect(test.tran.cardcash_no, 800001);
  expect(test.tran.nocardcash_no, 900001);
  expect(test.tran.cardfee_no, 1);
  expect(test.tran.othcrdt_no, 300001);
  expect(test.tran.owncrdt_no, 1);
  expect(test.tran.crdtcan_no, 1);
  expect(test.tran.poppy_cnt, 0);
  expect(test.tran.nttasp_credit_no, 1);
  expect(test.tran.nttasp_corr_stat, 0);
  expect(test.tran.nttasp_corr_reno, 0);
  expect(test.tran.nttasp_corr_date, "00-00 00:00:00");
  expect(test.tran.eat_in_now, 1);
  expect(test.tran.tw_no, 0);
  expect(test.tran.edy_pos_id, 0);
  expect(test.tran.sip_pos_ky, 0);
  expect(test.tran.encrypt_PidNew, "00000000");
  expect(test.tran.encrypt_ErK1di, "00000000");
  expect(test.tran.encrypt_send_date, "0000000000");
  expect(test.tran.encrypt_credit_no, "00000");
  expect(test.tran.deliv_rct_no, 1);
  expect(test.tran.order_no, 1);
  expect(test.tran.slip_no, 1);
  expect(test.tran.com_seq_no, 2);
  expect(test.tran.qs_at_clstime, "");
  expect(test.tran.qs_at_waittimer, 60);
  expect(test.tran.qs_at_opndatetime, "000000000000");
  expect(test.tran.fcl_dll_fix_time, "0000000000");
  expect(test.tran.end_saletime, "0000-00-00 00:00:00");
  expect(test.tran.qs_at_cls, 0);
  expect(test.tran.mbrdsctckt_no, 1);
  expect(test.tran.ht2980_seq_no, 1);
  expect(test.tran.duty_ej_count, 0);
  expect(test.tran.last_clr_total, "0000-00-00");
  expect(test.tran.special_user_count, 1);
  expect(test.tran.mbr_prize_counter, 1);
  expect(test.tran.sqrc_tct_cnt, 1);
  expect(test.tran.P11_prize_counter, 1);
  expect(test.tran.P7_prize_counter, 1);
  expect(test.tran.p11_prize_group_counter, 1);
  expect(test.tran.strcls_counter, 0);
  expect(test.tran.stropn_counter, 0);
  expect(test.tran.last_rdly_clear, "0000-00-00");
  expect(test.tran.cr2_chgcin_no, 1);
  expect(test.tran.cr2_chgout_no, 1);
  expect(test.tran.now_open_datetime, "00000000000000");
  expect(test.tran.certificate_no, 1);
  expect(test.tran.cct_seq_no, 1);
  expect(test.tran.dpoint_proc_no, 1);
  expect(test.tran.fresta_slip_no, 1);
  expect(test.tran.credit_no_vega, 1);
}

