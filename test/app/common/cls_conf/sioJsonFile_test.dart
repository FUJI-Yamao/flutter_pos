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
import '../../../../lib/app/common/cls_conf/sioJsonFile.dart';

late SioJsonFile sio;

void main(){
  sioJsonFile_test();
}

void sioJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/aa/";
  const String testDir = "test_assets";
  const String fileName = "sio.json";
  const String section = "global";
  const String key = "title";
  const defaultData = "接続機器一覧";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('SioJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await SioJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await SioJsonFile().setDefault();
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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await sio.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(sio,true);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        sio.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await sio.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(sio,true);

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
      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①：loadを実行する。
      await sio.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = sio.global.title;
      sio.global.title = testData1s;
      expect(sio.global.title == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await sio.load();
      expect(sio.global.title != testData1s, true);
      expect(sio.global.title == prefixData, true);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = sio.global.title;
      sio.global.title = testData1s;
      expect(sio.global.title, testData1s);

      // ③saveを実行する。
      await sio.save();

      // ④loadを実行する。
      await sio.load();

      expect(sio.global.title != prefixData, true);
      expect(sio.global.title == testData1s, true);
      allPropatyCheck(sio,false);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await sio.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await sio.save();

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await sio.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(sio.global.title, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = sio.global.title;
      sio.global.title = testData1s;

      // ③ saveを実行する。
      await sio.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(sio.global.title, testData1s);

      // ④ loadを実行する。
      await sio.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(sio.global.title == testData1s, true);
      allPropatyCheck(sio,false);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await sio.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(sio,true);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②任意のプロパティの値を変更する。
      sio.global.title = testData1s;
      expect(sio.global.title, testData1s);

      // ③saveを実行する。
      await sio.save();
      expect(sio.global.title, testData1s);

      // ④loadを実行する。
      await sio.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(sio,true);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await sio.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await sio.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(sio.global.title == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await sio.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await sio.setValueWithName(section, "test_key", testData1s);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②任意のプロパティを変更する。
      sio.global.title = testData1s;

      // ③saveを実行する。
      await sio.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await sio.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②任意のプロパティを変更する。
      sio.global.title = testData1s;

      // ③saveを実行する。
      await sio.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await sio.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②任意のプロパティを変更する。
      sio.global.title = testData1s;

      // ③saveを実行する。
      await sio.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await sio.getValueWithName(section, "test_key");
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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await sio.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      sio.global.title = testData1s;
      expect(sio.global.title, testData1s);

      // ④saveを実行する。
      await sio.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(sio.global.title, testData1s);
      
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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await sio.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + sio.global.title.toString());
      expect(sio.global.title == testData1s, true);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await sio.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + sio.global.title.toString());
      expect(sio.global.title == testData2s, true);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await sio.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + sio.global.title.toString());
      expect(sio.global.title == testData1s, true);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await sio.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + sio.global.title.toString());
      expect(sio.global.title == testData2s, true);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await sio.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + sio.global.title.toString());
      expect(sio.global.title == testData1s, true);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await sio.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + sio.global.title.toString());
      expect(sio.global.title == testData1s, true);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await sio.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + sio.global.title.toString());
      allPropatyCheck(sio,true);

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

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await sio.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + sio.global.title.toString());
      allPropatyCheck(sio,true);

      print("********** テスト終了：00023_restoreJson_08 **********\n\n");
    });

    // ********************************************************
    // テスト00020 : 言語切換（changeLanguage）
    // 事前条件：assets/confに対象JSONファイルが存在すること。
    // 試験手順：①当該フォルダと同階層にex、cn、twのフォルダを作成する。
    //         ②任意のプロパティ値を変更し、①の各フォルダにJSONのコピーを作成する。
    //         ③changeLanguageを実行し、exフォルダに切り替える。
    //         ④loadを実行する。
    //         ⑤changeLanguageを実行し、cnフォルダに切り替える。
    //         ⑥loadを実行する。
    //         ⑦changeLanguageを実行し、twフォルダに切り替える。
    //         ⑧loadを実行する。
    // 期待結果：手順④、⑥、⑧実行後、手順①で作成したJSONファイルのプロパティ値を読み込むこと。
    // ********************************************************
    test('00020_changeLanguage', () async {
      print("\n********** テスト実行：00020_changeLanguage_01 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①当該フォルダと同階層にex、cn、twのフォルダを作成する。
      // ②任意のプロパティ値を変更し、①の各フォルダにJSONのコピーを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern9, section, key, testData1s, testData2s, testData3s);
      await getTestDate(confPath, fileName, testFunc.getPattern9);

      // ③changeLanguageを実行し、exフォルダに切り替える。
      // ④loadを実行する。
      sio.changeLanguage(JsonLanguage.ex);
      await sio.load();
      print("check:" + sio.global.title.toString());
      expect(sio.global.title == testData1s, true);
      allPropatyCheck(sio,false);
      // ⑤changeLanguageを実行し、cnフォルダに切り替える。
      // ⑥loadを実行する。
      sio.changeLanguage(JsonLanguage.cn);
      await sio.load();
      print("check:" + sio.global.title.toString());
      expect(sio.global.title == testData2s, true);
      allPropatyCheck(sio,false);
      // ⑦changeLanguageを実行し、twフォルダに切り替える。
      // ⑧loadを実行する。
      sio.changeLanguage(JsonLanguage.tw);
      await sio.load();
      print("check:" + sio.global.title.toString());
      expect(sio.global.title == testData3s, true);
      allPropatyCheck(sio,false);
      // ⑨changeLanguageを実行し、aaフォルダに切り替える。
      // ⑩loadを実行する。
      sio.changeLanguage(JsonLanguage.aa);
      await sio.load();
      print("check:" + sio.global.title.toString());
      expect(sio.global.title == defaultData, true);
      allPropatyCheck(sio,false);

      print("********** テスト終了：00020_changeLanguage_01 **********\n\n");
    });

    // ********************************************************
    // テスト00025 ～ : 要素取得・設定
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
     test('00025_element_check_00001', () async {
      print("\n********** テスト実行：00025_element_check_00001 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.global.title;
      print(sio.global.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.global.title = testData1s;
      print(sio.global.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.global.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.global.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.global.title = testData2s;
      print(sio.global.title);
      expect(sio.global.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.global.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.global.title = defalut;
      print(sio.global.title);
      expect(sio.global.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.global.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00025_element_check_00001 **********\n\n");
    });

    test('00026_element_check_00002', () async {
      print("\n********** テスト実行：00026_element_check_00002 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button01.title;
      print(sio.button01.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button01.title = testData1s;
      print(sio.button01.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button01.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button01.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button01.title = testData2s;
      print(sio.button01.title);
      expect(sio.button01.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button01.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button01.title = defalut;
      print(sio.button01.title);
      expect(sio.button01.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button01.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00026_element_check_00002 **********\n\n");
    });

    test('00027_element_check_00003', () async {
      print("\n********** テスト実行：00027_element_check_00003 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button01.kind;
      print(sio.button01.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button01.kind = testData1s;
      print(sio.button01.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button01.kind == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button01.kind == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button01.kind = testData2s;
      print(sio.button01.kind);
      expect(sio.button01.kind == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button01.kind == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button01.kind = defalut;
      print(sio.button01.kind);
      expect(sio.button01.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button01.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00027_element_check_00003 **********\n\n");
    });

    test('00028_element_check_00004', () async {
      print("\n********** テスト実行：00028_element_check_00004 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button01.section;
      print(sio.button01.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button01.section = testData1s;
      print(sio.button01.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button01.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button01.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button01.section = testData2s;
      print(sio.button01.section);
      expect(sio.button01.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button01.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button01.section = defalut;
      print(sio.button01.section);
      expect(sio.button01.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button01.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00028_element_check_00004 **********\n\n");
    });

    test('00029_element_check_00005', () async {
      print("\n********** テスト実行：00029_element_check_00005 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button01.type;
      print(sio.button01.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button01.type = testData1s;
      print(sio.button01.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button01.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button01.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button01.type = testData2s;
      print(sio.button01.type);
      expect(sio.button01.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button01.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button01.type = defalut;
      print(sio.button01.type);
      expect(sio.button01.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button01.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00029_element_check_00005 **********\n\n");
    });

    test('00030_element_check_00006', () async {
      print("\n********** テスト実行：00030_element_check_00006 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button02.title;
      print(sio.button02.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button02.title = testData1s;
      print(sio.button02.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button02.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button02.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button02.title = testData2s;
      print(sio.button02.title);
      expect(sio.button02.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button02.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button02.title = defalut;
      print(sio.button02.title);
      expect(sio.button02.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button02.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00030_element_check_00006 **********\n\n");
    });

    test('00031_element_check_00007', () async {
      print("\n********** テスト実行：00031_element_check_00007 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button02.kind;
      print(sio.button02.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button02.kind = testData1;
      print(sio.button02.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button02.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button02.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button02.kind = testData2;
      print(sio.button02.kind);
      expect(sio.button02.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button02.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button02.kind = defalut;
      print(sio.button02.kind);
      expect(sio.button02.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button02.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00031_element_check_00007 **********\n\n");
    });

    test('00032_element_check_00008', () async {
      print("\n********** テスト実行：00032_element_check_00008 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button02.section;
      print(sio.button02.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button02.section = testData1s;
      print(sio.button02.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button02.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button02.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button02.section = testData2s;
      print(sio.button02.section);
      expect(sio.button02.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button02.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button02.section = defalut;
      print(sio.button02.section);
      expect(sio.button02.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button02.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00032_element_check_00008 **********\n\n");
    });

    test('00033_element_check_00009', () async {
      print("\n********** テスト実行：00033_element_check_00009 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button02.type;
      print(sio.button02.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button02.type = testData1s;
      print(sio.button02.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button02.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button02.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button02.type = testData2s;
      print(sio.button02.type);
      expect(sio.button02.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button02.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button02.type = defalut;
      print(sio.button02.type);
      expect(sio.button02.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button02.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00033_element_check_00009 **********\n\n");
    });

    test('00034_element_check_00010', () async {
      print("\n********** テスト実行：00034_element_check_00010 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button03.title;
      print(sio.button03.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button03.title = testData1s;
      print(sio.button03.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button03.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button03.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button03.title = testData2s;
      print(sio.button03.title);
      expect(sio.button03.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button03.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button03.title = defalut;
      print(sio.button03.title);
      expect(sio.button03.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button03.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00034_element_check_00010 **********\n\n");
    });

    test('00035_element_check_00011', () async {
      print("\n********** テスト実行：00035_element_check_00011 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button03.kind;
      print(sio.button03.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button03.kind = testData1;
      print(sio.button03.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button03.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button03.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button03.kind = testData2;
      print(sio.button03.kind);
      expect(sio.button03.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button03.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button03.kind = defalut;
      print(sio.button03.kind);
      expect(sio.button03.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button03.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00035_element_check_00011 **********\n\n");
    });

    test('00036_element_check_00012', () async {
      print("\n********** テスト実行：00036_element_check_00012 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button03.section;
      print(sio.button03.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button03.section = testData1s;
      print(sio.button03.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button03.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button03.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button03.section = testData2s;
      print(sio.button03.section);
      expect(sio.button03.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button03.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button03.section = defalut;
      print(sio.button03.section);
      expect(sio.button03.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button03.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00036_element_check_00012 **********\n\n");
    });

    test('00037_element_check_00013', () async {
      print("\n********** テスト実行：00037_element_check_00013 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button03.type;
      print(sio.button03.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button03.type = testData1s;
      print(sio.button03.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button03.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button03.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button03.type = testData2s;
      print(sio.button03.type);
      expect(sio.button03.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button03.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button03.type = defalut;
      print(sio.button03.type);
      expect(sio.button03.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button03.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00037_element_check_00013 **********\n\n");
    });

    test('00038_element_check_00014', () async {
      print("\n********** テスト実行：00038_element_check_00014 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button04.title;
      print(sio.button04.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button04.title = testData1s;
      print(sio.button04.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button04.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button04.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button04.title = testData2s;
      print(sio.button04.title);
      expect(sio.button04.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button04.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button04.title = defalut;
      print(sio.button04.title);
      expect(sio.button04.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button04.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00038_element_check_00014 **********\n\n");
    });

    test('00039_element_check_00015', () async {
      print("\n********** テスト実行：00039_element_check_00015 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button04.kind;
      print(sio.button04.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button04.kind = testData1;
      print(sio.button04.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button04.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button04.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button04.kind = testData2;
      print(sio.button04.kind);
      expect(sio.button04.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button04.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button04.kind = defalut;
      print(sio.button04.kind);
      expect(sio.button04.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button04.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00039_element_check_00015 **********\n\n");
    });

    test('00040_element_check_00016', () async {
      print("\n********** テスト実行：00040_element_check_00016 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button04.section;
      print(sio.button04.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button04.section = testData1s;
      print(sio.button04.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button04.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button04.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button04.section = testData2s;
      print(sio.button04.section);
      expect(sio.button04.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button04.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button04.section = defalut;
      print(sio.button04.section);
      expect(sio.button04.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button04.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00040_element_check_00016 **********\n\n");
    });

    test('00041_element_check_00017', () async {
      print("\n********** テスト実行：00041_element_check_00017 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button04.type;
      print(sio.button04.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button04.type = testData1s;
      print(sio.button04.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button04.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button04.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button04.type = testData2s;
      print(sio.button04.type);
      expect(sio.button04.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button04.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button04.type = defalut;
      print(sio.button04.type);
      expect(sio.button04.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button04.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00041_element_check_00017 **********\n\n");
    });

    test('00042_element_check_00018', () async {
      print("\n********** テスト実行：00042_element_check_00018 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button05.title;
      print(sio.button05.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button05.title = testData1s;
      print(sio.button05.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button05.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button05.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button05.title = testData2s;
      print(sio.button05.title);
      expect(sio.button05.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button05.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button05.title = defalut;
      print(sio.button05.title);
      expect(sio.button05.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button05.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00042_element_check_00018 **********\n\n");
    });

    test('00043_element_check_00019', () async {
      print("\n********** テスト実行：00043_element_check_00019 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button05.kind;
      print(sio.button05.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button05.kind = testData1;
      print(sio.button05.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button05.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button05.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button05.kind = testData2;
      print(sio.button05.kind);
      expect(sio.button05.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button05.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button05.kind = defalut;
      print(sio.button05.kind);
      expect(sio.button05.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button05.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00043_element_check_00019 **********\n\n");
    });

    test('00044_element_check_00020', () async {
      print("\n********** テスト実行：00044_element_check_00020 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button05.section;
      print(sio.button05.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button05.section = testData1s;
      print(sio.button05.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button05.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button05.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button05.section = testData2s;
      print(sio.button05.section);
      expect(sio.button05.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button05.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button05.section = defalut;
      print(sio.button05.section);
      expect(sio.button05.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button05.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00044_element_check_00020 **********\n\n");
    });

    test('00045_element_check_00021', () async {
      print("\n********** テスト実行：00045_element_check_00021 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button05.type;
      print(sio.button05.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button05.type = testData1s;
      print(sio.button05.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button05.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button05.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button05.type = testData2s;
      print(sio.button05.type);
      expect(sio.button05.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button05.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button05.type = defalut;
      print(sio.button05.type);
      expect(sio.button05.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button05.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00045_element_check_00021 **********\n\n");
    });

    test('00046_element_check_00022', () async {
      print("\n********** テスト実行：00046_element_check_00022 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button06.title;
      print(sio.button06.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button06.title = testData1s;
      print(sio.button06.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button06.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button06.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button06.title = testData2s;
      print(sio.button06.title);
      expect(sio.button06.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button06.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button06.title = defalut;
      print(sio.button06.title);
      expect(sio.button06.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button06.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00046_element_check_00022 **********\n\n");
    });

    test('00047_element_check_00023', () async {
      print("\n********** テスト実行：00047_element_check_00023 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button06.kind;
      print(sio.button06.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button06.kind = testData1;
      print(sio.button06.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button06.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button06.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button06.kind = testData2;
      print(sio.button06.kind);
      expect(sio.button06.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button06.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button06.kind = defalut;
      print(sio.button06.kind);
      expect(sio.button06.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button06.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00047_element_check_00023 **********\n\n");
    });

    test('00048_element_check_00024', () async {
      print("\n********** テスト実行：00048_element_check_00024 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button06.section;
      print(sio.button06.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button06.section = testData1s;
      print(sio.button06.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button06.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button06.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button06.section = testData2s;
      print(sio.button06.section);
      expect(sio.button06.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button06.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button06.section = defalut;
      print(sio.button06.section);
      expect(sio.button06.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button06.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00048_element_check_00024 **********\n\n");
    });

    test('00049_element_check_00025', () async {
      print("\n********** テスト実行：00049_element_check_00025 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button06.type;
      print(sio.button06.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button06.type = testData1s;
      print(sio.button06.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button06.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button06.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button06.type = testData2s;
      print(sio.button06.type);
      expect(sio.button06.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button06.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button06.type = defalut;
      print(sio.button06.type);
      expect(sio.button06.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button06.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00049_element_check_00025 **********\n\n");
    });

    test('00050_element_check_00026', () async {
      print("\n********** テスト実行：00050_element_check_00026 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button07.title;
      print(sio.button07.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button07.title = testData1s;
      print(sio.button07.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button07.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button07.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button07.title = testData2s;
      print(sio.button07.title);
      expect(sio.button07.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button07.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button07.title = defalut;
      print(sio.button07.title);
      expect(sio.button07.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button07.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00050_element_check_00026 **********\n\n");
    });

    test('00051_element_check_00027', () async {
      print("\n********** テスト実行：00051_element_check_00027 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button07.kind;
      print(sio.button07.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button07.kind = testData1;
      print(sio.button07.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button07.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button07.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button07.kind = testData2;
      print(sio.button07.kind);
      expect(sio.button07.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button07.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button07.kind = defalut;
      print(sio.button07.kind);
      expect(sio.button07.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button07.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00051_element_check_00027 **********\n\n");
    });

    test('00052_element_check_00028', () async {
      print("\n********** テスト実行：00052_element_check_00028 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button07.section;
      print(sio.button07.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button07.section = testData1s;
      print(sio.button07.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button07.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button07.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button07.section = testData2s;
      print(sio.button07.section);
      expect(sio.button07.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button07.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button07.section = defalut;
      print(sio.button07.section);
      expect(sio.button07.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button07.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00052_element_check_00028 **********\n\n");
    });

    test('00053_element_check_00029', () async {
      print("\n********** テスト実行：00053_element_check_00029 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button07.type;
      print(sio.button07.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button07.type = testData1s;
      print(sio.button07.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button07.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button07.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button07.type = testData2s;
      print(sio.button07.type);
      expect(sio.button07.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button07.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button07.type = defalut;
      print(sio.button07.type);
      expect(sio.button07.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button07.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00053_element_check_00029 **********\n\n");
    });

    test('00054_element_check_00030', () async {
      print("\n********** テスト実行：00054_element_check_00030 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button08.title;
      print(sio.button08.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button08.title = testData1s;
      print(sio.button08.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button08.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button08.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button08.title = testData2s;
      print(sio.button08.title);
      expect(sio.button08.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button08.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button08.title = defalut;
      print(sio.button08.title);
      expect(sio.button08.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button08.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00054_element_check_00030 **********\n\n");
    });

    test('00055_element_check_00031', () async {
      print("\n********** テスト実行：00055_element_check_00031 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button08.kind;
      print(sio.button08.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button08.kind = testData1;
      print(sio.button08.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button08.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button08.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button08.kind = testData2;
      print(sio.button08.kind);
      expect(sio.button08.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button08.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button08.kind = defalut;
      print(sio.button08.kind);
      expect(sio.button08.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button08.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00055_element_check_00031 **********\n\n");
    });

    test('00056_element_check_00032', () async {
      print("\n********** テスト実行：00056_element_check_00032 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button08.section;
      print(sio.button08.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button08.section = testData1s;
      print(sio.button08.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button08.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button08.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button08.section = testData2s;
      print(sio.button08.section);
      expect(sio.button08.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button08.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button08.section = defalut;
      print(sio.button08.section);
      expect(sio.button08.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button08.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00056_element_check_00032 **********\n\n");
    });

    test('00057_element_check_00033', () async {
      print("\n********** テスト実行：00057_element_check_00033 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button08.type;
      print(sio.button08.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button08.type = testData1s;
      print(sio.button08.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button08.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button08.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button08.type = testData2s;
      print(sio.button08.type);
      expect(sio.button08.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button08.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button08.type = defalut;
      print(sio.button08.type);
      expect(sio.button08.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button08.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00057_element_check_00033 **********\n\n");
    });

    test('00058_element_check_00034', () async {
      print("\n********** テスト実行：00058_element_check_00034 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button09.title;
      print(sio.button09.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button09.title = testData1s;
      print(sio.button09.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button09.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button09.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button09.title = testData2s;
      print(sio.button09.title);
      expect(sio.button09.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button09.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button09.title = defalut;
      print(sio.button09.title);
      expect(sio.button09.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button09.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00058_element_check_00034 **********\n\n");
    });

    test('00059_element_check_00035', () async {
      print("\n********** テスト実行：00059_element_check_00035 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button09.kind;
      print(sio.button09.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button09.kind = testData1;
      print(sio.button09.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button09.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button09.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button09.kind = testData2;
      print(sio.button09.kind);
      expect(sio.button09.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button09.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button09.kind = defalut;
      print(sio.button09.kind);
      expect(sio.button09.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button09.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00059_element_check_00035 **********\n\n");
    });

    test('00060_element_check_00036', () async {
      print("\n********** テスト実行：00060_element_check_00036 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button09.section;
      print(sio.button09.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button09.section = testData1s;
      print(sio.button09.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button09.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button09.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button09.section = testData2s;
      print(sio.button09.section);
      expect(sio.button09.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button09.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button09.section = defalut;
      print(sio.button09.section);
      expect(sio.button09.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button09.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00060_element_check_00036 **********\n\n");
    });

    test('00061_element_check_00037', () async {
      print("\n********** テスト実行：00061_element_check_00037 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button09.type;
      print(sio.button09.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button09.type = testData1s;
      print(sio.button09.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button09.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button09.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button09.type = testData2s;
      print(sio.button09.type);
      expect(sio.button09.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button09.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button09.type = defalut;
      print(sio.button09.type);
      expect(sio.button09.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button09.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00061_element_check_00037 **********\n\n");
    });

    test('00062_element_check_00038', () async {
      print("\n********** テスト実行：00062_element_check_00038 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button10.title;
      print(sio.button10.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button10.title = testData1s;
      print(sio.button10.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button10.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button10.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button10.title = testData2s;
      print(sio.button10.title);
      expect(sio.button10.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button10.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button10.title = defalut;
      print(sio.button10.title);
      expect(sio.button10.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button10.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00062_element_check_00038 **********\n\n");
    });

    test('00063_element_check_00039', () async {
      print("\n********** テスト実行：00063_element_check_00039 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button10.kind;
      print(sio.button10.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button10.kind = testData1;
      print(sio.button10.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button10.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button10.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button10.kind = testData2;
      print(sio.button10.kind);
      expect(sio.button10.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button10.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button10.kind = defalut;
      print(sio.button10.kind);
      expect(sio.button10.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button10.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00063_element_check_00039 **********\n\n");
    });

    test('00064_element_check_00040', () async {
      print("\n********** テスト実行：00064_element_check_00040 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button10.section;
      print(sio.button10.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button10.section = testData1s;
      print(sio.button10.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button10.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button10.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button10.section = testData2s;
      print(sio.button10.section);
      expect(sio.button10.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button10.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button10.section = defalut;
      print(sio.button10.section);
      expect(sio.button10.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button10.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00064_element_check_00040 **********\n\n");
    });

    test('00065_element_check_00041', () async {
      print("\n********** テスト実行：00065_element_check_00041 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button10.type;
      print(sio.button10.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button10.type = testData1s;
      print(sio.button10.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button10.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button10.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button10.type = testData2s;
      print(sio.button10.type);
      expect(sio.button10.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button10.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button10.type = defalut;
      print(sio.button10.type);
      expect(sio.button10.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button10.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00065_element_check_00041 **********\n\n");
    });

    test('00066_element_check_00042', () async {
      print("\n********** テスト実行：00066_element_check_00042 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button11.title;
      print(sio.button11.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button11.title = testData1s;
      print(sio.button11.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button11.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button11.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button11.title = testData2s;
      print(sio.button11.title);
      expect(sio.button11.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button11.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button11.title = defalut;
      print(sio.button11.title);
      expect(sio.button11.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button11.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00066_element_check_00042 **********\n\n");
    });

    test('00067_element_check_00043', () async {
      print("\n********** テスト実行：00067_element_check_00043 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button11.kind;
      print(sio.button11.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button11.kind = testData1;
      print(sio.button11.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button11.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button11.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button11.kind = testData2;
      print(sio.button11.kind);
      expect(sio.button11.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button11.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button11.kind = defalut;
      print(sio.button11.kind);
      expect(sio.button11.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button11.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00067_element_check_00043 **********\n\n");
    });

    test('00068_element_check_00044', () async {
      print("\n********** テスト実行：00068_element_check_00044 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button11.section;
      print(sio.button11.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button11.section = testData1s;
      print(sio.button11.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button11.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button11.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button11.section = testData2s;
      print(sio.button11.section);
      expect(sio.button11.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button11.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button11.section = defalut;
      print(sio.button11.section);
      expect(sio.button11.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button11.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00068_element_check_00044 **********\n\n");
    });

    test('00069_element_check_00045', () async {
      print("\n********** テスト実行：00069_element_check_00045 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button11.type;
      print(sio.button11.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button11.type = testData1s;
      print(sio.button11.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button11.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button11.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button11.type = testData2s;
      print(sio.button11.type);
      expect(sio.button11.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button11.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button11.type = defalut;
      print(sio.button11.type);
      expect(sio.button11.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button11.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00069_element_check_00045 **********\n\n");
    });

    test('00070_element_check_00046', () async {
      print("\n********** テスト実行：00070_element_check_00046 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button12.title;
      print(sio.button12.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button12.title = testData1s;
      print(sio.button12.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button12.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button12.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button12.title = testData2s;
      print(sio.button12.title);
      expect(sio.button12.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button12.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button12.title = defalut;
      print(sio.button12.title);
      expect(sio.button12.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button12.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00070_element_check_00046 **********\n\n");
    });

    test('00071_element_check_00047', () async {
      print("\n********** テスト実行：00071_element_check_00047 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button12.kind;
      print(sio.button12.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button12.kind = testData1;
      print(sio.button12.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button12.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button12.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button12.kind = testData2;
      print(sio.button12.kind);
      expect(sio.button12.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button12.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button12.kind = defalut;
      print(sio.button12.kind);
      expect(sio.button12.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button12.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00071_element_check_00047 **********\n\n");
    });

    test('00072_element_check_00048', () async {
      print("\n********** テスト実行：00072_element_check_00048 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button12.section;
      print(sio.button12.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button12.section = testData1s;
      print(sio.button12.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button12.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button12.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button12.section = testData2s;
      print(sio.button12.section);
      expect(sio.button12.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button12.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button12.section = defalut;
      print(sio.button12.section);
      expect(sio.button12.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button12.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00072_element_check_00048 **********\n\n");
    });

    test('00073_element_check_00049', () async {
      print("\n********** テスト実行：00073_element_check_00049 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button12.type;
      print(sio.button12.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button12.type = testData1s;
      print(sio.button12.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button12.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button12.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button12.type = testData2s;
      print(sio.button12.type);
      expect(sio.button12.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button12.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button12.type = defalut;
      print(sio.button12.type);
      expect(sio.button12.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button12.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00073_element_check_00049 **********\n\n");
    });

    test('00074_element_check_00050', () async {
      print("\n********** テスト実行：00074_element_check_00050 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button13.title;
      print(sio.button13.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button13.title = testData1s;
      print(sio.button13.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button13.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button13.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button13.title = testData2s;
      print(sio.button13.title);
      expect(sio.button13.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button13.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button13.title = defalut;
      print(sio.button13.title);
      expect(sio.button13.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button13.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00074_element_check_00050 **********\n\n");
    });

    test('00075_element_check_00051', () async {
      print("\n********** テスト実行：00075_element_check_00051 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button13.kind;
      print(sio.button13.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button13.kind = testData1;
      print(sio.button13.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button13.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button13.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button13.kind = testData2;
      print(sio.button13.kind);
      expect(sio.button13.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button13.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button13.kind = defalut;
      print(sio.button13.kind);
      expect(sio.button13.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button13.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00075_element_check_00051 **********\n\n");
    });

    test('00076_element_check_00052', () async {
      print("\n********** テスト実行：00076_element_check_00052 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button13.section;
      print(sio.button13.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button13.section = testData1s;
      print(sio.button13.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button13.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button13.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button13.section = testData2s;
      print(sio.button13.section);
      expect(sio.button13.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button13.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button13.section = defalut;
      print(sio.button13.section);
      expect(sio.button13.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button13.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00076_element_check_00052 **********\n\n");
    });

    test('00077_element_check_00053', () async {
      print("\n********** テスト実行：00077_element_check_00053 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button13.type;
      print(sio.button13.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button13.type = testData1s;
      print(sio.button13.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button13.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button13.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button13.type = testData2s;
      print(sio.button13.type);
      expect(sio.button13.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button13.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button13.type = defalut;
      print(sio.button13.type);
      expect(sio.button13.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button13.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00077_element_check_00053 **********\n\n");
    });

    test('00078_element_check_00054', () async {
      print("\n********** テスト実行：00078_element_check_00054 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button14.title;
      print(sio.button14.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button14.title = testData1s;
      print(sio.button14.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button14.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button14.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button14.title = testData2s;
      print(sio.button14.title);
      expect(sio.button14.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button14.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button14.title = defalut;
      print(sio.button14.title);
      expect(sio.button14.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button14.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00078_element_check_00054 **********\n\n");
    });

    test('00079_element_check_00055', () async {
      print("\n********** テスト実行：00079_element_check_00055 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button14.kind;
      print(sio.button14.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button14.kind = testData1;
      print(sio.button14.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button14.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button14.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button14.kind = testData2;
      print(sio.button14.kind);
      expect(sio.button14.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button14.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button14.kind = defalut;
      print(sio.button14.kind);
      expect(sio.button14.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button14.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00079_element_check_00055 **********\n\n");
    });

    test('00080_element_check_00056', () async {
      print("\n********** テスト実行：00080_element_check_00056 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button14.section;
      print(sio.button14.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button14.section = testData1s;
      print(sio.button14.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button14.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button14.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button14.section = testData2s;
      print(sio.button14.section);
      expect(sio.button14.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button14.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button14.section = defalut;
      print(sio.button14.section);
      expect(sio.button14.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button14.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00080_element_check_00056 **********\n\n");
    });

    test('00081_element_check_00057', () async {
      print("\n********** テスト実行：00081_element_check_00057 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button14.type;
      print(sio.button14.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button14.type = testData1s;
      print(sio.button14.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button14.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button14.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button14.type = testData2s;
      print(sio.button14.type);
      expect(sio.button14.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button14.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button14.type = defalut;
      print(sio.button14.type);
      expect(sio.button14.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button14.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00081_element_check_00057 **********\n\n");
    });

    test('00082_element_check_00058', () async {
      print("\n********** テスト実行：00082_element_check_00058 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button15.title;
      print(sio.button15.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button15.title = testData1s;
      print(sio.button15.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button15.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button15.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button15.title = testData2s;
      print(sio.button15.title);
      expect(sio.button15.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button15.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button15.title = defalut;
      print(sio.button15.title);
      expect(sio.button15.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button15.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00082_element_check_00058 **********\n\n");
    });

    test('00083_element_check_00059', () async {
      print("\n********** テスト実行：00083_element_check_00059 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button15.kind;
      print(sio.button15.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button15.kind = testData1;
      print(sio.button15.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button15.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button15.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button15.kind = testData2;
      print(sio.button15.kind);
      expect(sio.button15.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button15.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button15.kind = defalut;
      print(sio.button15.kind);
      expect(sio.button15.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button15.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00083_element_check_00059 **********\n\n");
    });

    test('00084_element_check_00060', () async {
      print("\n********** テスト実行：00084_element_check_00060 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button15.section;
      print(sio.button15.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button15.section = testData1s;
      print(sio.button15.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button15.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button15.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button15.section = testData2s;
      print(sio.button15.section);
      expect(sio.button15.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button15.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button15.section = defalut;
      print(sio.button15.section);
      expect(sio.button15.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button15.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00084_element_check_00060 **********\n\n");
    });

    test('00085_element_check_00061', () async {
      print("\n********** テスト実行：00085_element_check_00061 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button15.type;
      print(sio.button15.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button15.type = testData1s;
      print(sio.button15.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button15.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button15.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button15.type = testData2s;
      print(sio.button15.type);
      expect(sio.button15.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button15.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button15.type = defalut;
      print(sio.button15.type);
      expect(sio.button15.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button15.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00085_element_check_00061 **********\n\n");
    });

    test('00086_element_check_00062', () async {
      print("\n********** テスト実行：00086_element_check_00062 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button16.title;
      print(sio.button16.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button16.title = testData1s;
      print(sio.button16.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button16.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button16.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button16.title = testData2s;
      print(sio.button16.title);
      expect(sio.button16.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button16.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button16.title = defalut;
      print(sio.button16.title);
      expect(sio.button16.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button16.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00086_element_check_00062 **********\n\n");
    });

    test('00087_element_check_00063', () async {
      print("\n********** テスト実行：00087_element_check_00063 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button16.kind;
      print(sio.button16.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button16.kind = testData1;
      print(sio.button16.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button16.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button16.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button16.kind = testData2;
      print(sio.button16.kind);
      expect(sio.button16.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button16.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button16.kind = defalut;
      print(sio.button16.kind);
      expect(sio.button16.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button16.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00087_element_check_00063 **********\n\n");
    });

    test('00088_element_check_00064', () async {
      print("\n********** テスト実行：00088_element_check_00064 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button16.section;
      print(sio.button16.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button16.section = testData1s;
      print(sio.button16.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button16.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button16.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button16.section = testData2s;
      print(sio.button16.section);
      expect(sio.button16.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button16.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button16.section = defalut;
      print(sio.button16.section);
      expect(sio.button16.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button16.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00088_element_check_00064 **********\n\n");
    });

    test('00089_element_check_00065', () async {
      print("\n********** テスト実行：00089_element_check_00065 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button16.type;
      print(sio.button16.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button16.type = testData1s;
      print(sio.button16.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button16.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button16.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button16.type = testData2s;
      print(sio.button16.type);
      expect(sio.button16.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button16.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button16.type = defalut;
      print(sio.button16.type);
      expect(sio.button16.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button16.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00089_element_check_00065 **********\n\n");
    });

    test('00090_element_check_00066', () async {
      print("\n********** テスト実行：00090_element_check_00066 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button17.title;
      print(sio.button17.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button17.title = testData1s;
      print(sio.button17.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button17.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button17.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button17.title = testData2s;
      print(sio.button17.title);
      expect(sio.button17.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button17.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button17.title = defalut;
      print(sio.button17.title);
      expect(sio.button17.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button17.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00090_element_check_00066 **********\n\n");
    });

    test('00091_element_check_00067', () async {
      print("\n********** テスト実行：00091_element_check_00067 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button17.kind;
      print(sio.button17.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button17.kind = testData1;
      print(sio.button17.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button17.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button17.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button17.kind = testData2;
      print(sio.button17.kind);
      expect(sio.button17.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button17.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button17.kind = defalut;
      print(sio.button17.kind);
      expect(sio.button17.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button17.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00091_element_check_00067 **********\n\n");
    });

    test('00092_element_check_00068', () async {
      print("\n********** テスト実行：00092_element_check_00068 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button17.section;
      print(sio.button17.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button17.section = testData1s;
      print(sio.button17.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button17.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button17.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button17.section = testData2s;
      print(sio.button17.section);
      expect(sio.button17.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button17.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button17.section = defalut;
      print(sio.button17.section);
      expect(sio.button17.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button17.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00092_element_check_00068 **********\n\n");
    });

    test('00093_element_check_00069', () async {
      print("\n********** テスト実行：00093_element_check_00069 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button17.type;
      print(sio.button17.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button17.type = testData1s;
      print(sio.button17.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button17.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button17.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button17.type = testData2s;
      print(sio.button17.type);
      expect(sio.button17.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button17.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button17.type = defalut;
      print(sio.button17.type);
      expect(sio.button17.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button17.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00093_element_check_00069 **********\n\n");
    });

    test('00094_element_check_00070', () async {
      print("\n********** テスト実行：00094_element_check_00070 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button18.title;
      print(sio.button18.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button18.title = testData1s;
      print(sio.button18.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button18.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button18.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button18.title = testData2s;
      print(sio.button18.title);
      expect(sio.button18.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button18.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button18.title = defalut;
      print(sio.button18.title);
      expect(sio.button18.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button18.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00094_element_check_00070 **********\n\n");
    });

    test('00095_element_check_00071', () async {
      print("\n********** テスト実行：00095_element_check_00071 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button18.kind;
      print(sio.button18.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button18.kind = testData1;
      print(sio.button18.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button18.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button18.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button18.kind = testData2;
      print(sio.button18.kind);
      expect(sio.button18.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button18.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button18.kind = defalut;
      print(sio.button18.kind);
      expect(sio.button18.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button18.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00095_element_check_00071 **********\n\n");
    });

    test('00096_element_check_00072', () async {
      print("\n********** テスト実行：00096_element_check_00072 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button18.section;
      print(sio.button18.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button18.section = testData1s;
      print(sio.button18.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button18.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button18.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button18.section = testData2s;
      print(sio.button18.section);
      expect(sio.button18.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button18.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button18.section = defalut;
      print(sio.button18.section);
      expect(sio.button18.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button18.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00096_element_check_00072 **********\n\n");
    });

    test('00097_element_check_00073', () async {
      print("\n********** テスト実行：00097_element_check_00073 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button18.type;
      print(sio.button18.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button18.type = testData1s;
      print(sio.button18.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button18.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button18.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button18.type = testData2s;
      print(sio.button18.type);
      expect(sio.button18.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button18.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button18.type = defalut;
      print(sio.button18.type);
      expect(sio.button18.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button18.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00097_element_check_00073 **********\n\n");
    });

    test('00098_element_check_00074', () async {
      print("\n********** テスト実行：00098_element_check_00074 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button19.title;
      print(sio.button19.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button19.title = testData1s;
      print(sio.button19.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button19.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button19.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button19.title = testData2s;
      print(sio.button19.title);
      expect(sio.button19.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button19.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button19.title = defalut;
      print(sio.button19.title);
      expect(sio.button19.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button19.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00098_element_check_00074 **********\n\n");
    });

    test('00099_element_check_00075', () async {
      print("\n********** テスト実行：00099_element_check_00075 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button19.kind;
      print(sio.button19.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button19.kind = testData1;
      print(sio.button19.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button19.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button19.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button19.kind = testData2;
      print(sio.button19.kind);
      expect(sio.button19.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button19.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button19.kind = defalut;
      print(sio.button19.kind);
      expect(sio.button19.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button19.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00099_element_check_00075 **********\n\n");
    });

    test('00100_element_check_00076', () async {
      print("\n********** テスト実行：00100_element_check_00076 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button19.section;
      print(sio.button19.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button19.section = testData1s;
      print(sio.button19.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button19.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button19.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button19.section = testData2s;
      print(sio.button19.section);
      expect(sio.button19.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button19.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button19.section = defalut;
      print(sio.button19.section);
      expect(sio.button19.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button19.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00100_element_check_00076 **********\n\n");
    });

    test('00101_element_check_00077', () async {
      print("\n********** テスト実行：00101_element_check_00077 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button19.type;
      print(sio.button19.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button19.type = testData1s;
      print(sio.button19.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button19.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button19.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button19.type = testData2s;
      print(sio.button19.type);
      expect(sio.button19.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button19.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button19.type = defalut;
      print(sio.button19.type);
      expect(sio.button19.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button19.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00101_element_check_00077 **********\n\n");
    });

    test('00102_element_check_00078', () async {
      print("\n********** テスト実行：00102_element_check_00078 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button20.title;
      print(sio.button20.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button20.title = testData1s;
      print(sio.button20.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button20.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button20.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button20.title = testData2s;
      print(sio.button20.title);
      expect(sio.button20.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button20.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button20.title = defalut;
      print(sio.button20.title);
      expect(sio.button20.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button20.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00102_element_check_00078 **********\n\n");
    });

    test('00103_element_check_00079', () async {
      print("\n********** テスト実行：00103_element_check_00079 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button20.kind;
      print(sio.button20.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button20.kind = testData1;
      print(sio.button20.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button20.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button20.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button20.kind = testData2;
      print(sio.button20.kind);
      expect(sio.button20.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button20.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button20.kind = defalut;
      print(sio.button20.kind);
      expect(sio.button20.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button20.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00103_element_check_00079 **********\n\n");
    });

    test('00104_element_check_00080', () async {
      print("\n********** テスト実行：00104_element_check_00080 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button20.section;
      print(sio.button20.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button20.section = testData1s;
      print(sio.button20.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button20.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button20.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button20.section = testData2s;
      print(sio.button20.section);
      expect(sio.button20.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button20.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button20.section = defalut;
      print(sio.button20.section);
      expect(sio.button20.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button20.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00104_element_check_00080 **********\n\n");
    });

    test('00105_element_check_00081', () async {
      print("\n********** テスト実行：00105_element_check_00081 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button20.type;
      print(sio.button20.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button20.type = testData1s;
      print(sio.button20.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button20.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button20.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button20.type = testData2s;
      print(sio.button20.type);
      expect(sio.button20.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button20.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button20.type = defalut;
      print(sio.button20.type);
      expect(sio.button20.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button20.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00105_element_check_00081 **********\n\n");
    });

    test('00106_element_check_00082', () async {
      print("\n********** テスト実行：00106_element_check_00082 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button21.title;
      print(sio.button21.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button21.title = testData1s;
      print(sio.button21.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button21.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button21.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button21.title = testData2s;
      print(sio.button21.title);
      expect(sio.button21.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button21.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button21.title = defalut;
      print(sio.button21.title);
      expect(sio.button21.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button21.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00106_element_check_00082 **********\n\n");
    });

    test('00107_element_check_00083', () async {
      print("\n********** テスト実行：00107_element_check_00083 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button21.kind;
      print(sio.button21.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button21.kind = testData1;
      print(sio.button21.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button21.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button21.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button21.kind = testData2;
      print(sio.button21.kind);
      expect(sio.button21.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button21.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button21.kind = defalut;
      print(sio.button21.kind);
      expect(sio.button21.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button21.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00107_element_check_00083 **********\n\n");
    });

    test('00108_element_check_00084', () async {
      print("\n********** テスト実行：00108_element_check_00084 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button21.section;
      print(sio.button21.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button21.section = testData1s;
      print(sio.button21.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button21.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button21.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button21.section = testData2s;
      print(sio.button21.section);
      expect(sio.button21.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button21.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button21.section = defalut;
      print(sio.button21.section);
      expect(sio.button21.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button21.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00108_element_check_00084 **********\n\n");
    });

    test('00109_element_check_00085', () async {
      print("\n********** テスト実行：00109_element_check_00085 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button21.type;
      print(sio.button21.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button21.type = testData1s;
      print(sio.button21.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button21.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button21.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button21.type = testData2s;
      print(sio.button21.type);
      expect(sio.button21.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button21.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button21.type = defalut;
      print(sio.button21.type);
      expect(sio.button21.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button21.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00109_element_check_00085 **********\n\n");
    });

    test('00110_element_check_00086', () async {
      print("\n********** テスト実行：00110_element_check_00086 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button22.title;
      print(sio.button22.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button22.title = testData1s;
      print(sio.button22.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button22.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button22.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button22.title = testData2s;
      print(sio.button22.title);
      expect(sio.button22.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button22.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button22.title = defalut;
      print(sio.button22.title);
      expect(sio.button22.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button22.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00110_element_check_00086 **********\n\n");
    });

    test('00111_element_check_00087', () async {
      print("\n********** テスト実行：00111_element_check_00087 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button22.kind;
      print(sio.button22.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button22.kind = testData1;
      print(sio.button22.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button22.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button22.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button22.kind = testData2;
      print(sio.button22.kind);
      expect(sio.button22.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button22.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button22.kind = defalut;
      print(sio.button22.kind);
      expect(sio.button22.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button22.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00111_element_check_00087 **********\n\n");
    });

    test('00112_element_check_00088', () async {
      print("\n********** テスト実行：00112_element_check_00088 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button22.section;
      print(sio.button22.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button22.section = testData1s;
      print(sio.button22.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button22.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button22.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button22.section = testData2s;
      print(sio.button22.section);
      expect(sio.button22.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button22.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button22.section = defalut;
      print(sio.button22.section);
      expect(sio.button22.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button22.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00112_element_check_00088 **********\n\n");
    });

    test('00113_element_check_00089', () async {
      print("\n********** テスト実行：00113_element_check_00089 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button22.type;
      print(sio.button22.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button22.type = testData1s;
      print(sio.button22.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button22.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button22.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button22.type = testData2s;
      print(sio.button22.type);
      expect(sio.button22.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button22.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button22.type = defalut;
      print(sio.button22.type);
      expect(sio.button22.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button22.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00113_element_check_00089 **********\n\n");
    });

    test('00114_element_check_00090', () async {
      print("\n********** テスト実行：00114_element_check_00090 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button23.title;
      print(sio.button23.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button23.title = testData1s;
      print(sio.button23.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button23.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button23.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button23.title = testData2s;
      print(sio.button23.title);
      expect(sio.button23.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button23.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button23.title = defalut;
      print(sio.button23.title);
      expect(sio.button23.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button23.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00114_element_check_00090 **********\n\n");
    });

    test('00115_element_check_00091', () async {
      print("\n********** テスト実行：00115_element_check_00091 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button23.kind;
      print(sio.button23.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button23.kind = testData1;
      print(sio.button23.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button23.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button23.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button23.kind = testData2;
      print(sio.button23.kind);
      expect(sio.button23.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button23.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button23.kind = defalut;
      print(sio.button23.kind);
      expect(sio.button23.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button23.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00115_element_check_00091 **********\n\n");
    });

    test('00116_element_check_00092', () async {
      print("\n********** テスト実行：00116_element_check_00092 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button23.section;
      print(sio.button23.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button23.section = testData1s;
      print(sio.button23.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button23.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button23.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button23.section = testData2s;
      print(sio.button23.section);
      expect(sio.button23.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button23.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button23.section = defalut;
      print(sio.button23.section);
      expect(sio.button23.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button23.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00116_element_check_00092 **********\n\n");
    });

    test('00117_element_check_00093', () async {
      print("\n********** テスト実行：00117_element_check_00093 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button23.type;
      print(sio.button23.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button23.type = testData1s;
      print(sio.button23.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button23.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button23.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button23.type = testData2s;
      print(sio.button23.type);
      expect(sio.button23.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button23.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button23.type = defalut;
      print(sio.button23.type);
      expect(sio.button23.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button23.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00117_element_check_00093 **********\n\n");
    });

    test('00118_element_check_00094', () async {
      print("\n********** テスト実行：00118_element_check_00094 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button24.title;
      print(sio.button24.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button24.title = testData1s;
      print(sio.button24.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button24.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button24.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button24.title = testData2s;
      print(sio.button24.title);
      expect(sio.button24.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button24.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button24.title = defalut;
      print(sio.button24.title);
      expect(sio.button24.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button24.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00118_element_check_00094 **********\n\n");
    });

    test('00119_element_check_00095', () async {
      print("\n********** テスト実行：00119_element_check_00095 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button24.kind;
      print(sio.button24.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button24.kind = testData1;
      print(sio.button24.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button24.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button24.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button24.kind = testData2;
      print(sio.button24.kind);
      expect(sio.button24.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button24.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button24.kind = defalut;
      print(sio.button24.kind);
      expect(sio.button24.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button24.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00119_element_check_00095 **********\n\n");
    });

    test('00120_element_check_00096', () async {
      print("\n********** テスト実行：00120_element_check_00096 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button24.section;
      print(sio.button24.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button24.section = testData1s;
      print(sio.button24.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button24.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button24.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button24.section = testData2s;
      print(sio.button24.section);
      expect(sio.button24.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button24.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button24.section = defalut;
      print(sio.button24.section);
      expect(sio.button24.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button24.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00120_element_check_00096 **********\n\n");
    });

    test('00121_element_check_00097', () async {
      print("\n********** テスト実行：00121_element_check_00097 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button24.type;
      print(sio.button24.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button24.type = testData1s;
      print(sio.button24.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button24.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button24.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button24.type = testData2s;
      print(sio.button24.type);
      expect(sio.button24.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button24.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button24.type = defalut;
      print(sio.button24.type);
      expect(sio.button24.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button24.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00121_element_check_00097 **********\n\n");
    });

    test('00122_element_check_00098', () async {
      print("\n********** テスト実行：00122_element_check_00098 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button25.title;
      print(sio.button25.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button25.title = testData1s;
      print(sio.button25.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button25.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button25.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button25.title = testData2s;
      print(sio.button25.title);
      expect(sio.button25.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button25.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button25.title = defalut;
      print(sio.button25.title);
      expect(sio.button25.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button25.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00122_element_check_00098 **********\n\n");
    });

    test('00123_element_check_00099', () async {
      print("\n********** テスト実行：00123_element_check_00099 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button25.kind;
      print(sio.button25.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button25.kind = testData1;
      print(sio.button25.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button25.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button25.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button25.kind = testData2;
      print(sio.button25.kind);
      expect(sio.button25.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button25.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button25.kind = defalut;
      print(sio.button25.kind);
      expect(sio.button25.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button25.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00123_element_check_00099 **********\n\n");
    });

    test('00124_element_check_00100', () async {
      print("\n********** テスト実行：00124_element_check_00100 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button25.section;
      print(sio.button25.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button25.section = testData1s;
      print(sio.button25.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button25.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button25.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button25.section = testData2s;
      print(sio.button25.section);
      expect(sio.button25.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button25.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button25.section = defalut;
      print(sio.button25.section);
      expect(sio.button25.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button25.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00124_element_check_00100 **********\n\n");
    });

    test('00125_element_check_00101', () async {
      print("\n********** テスト実行：00125_element_check_00101 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button25.type;
      print(sio.button25.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button25.type = testData1s;
      print(sio.button25.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button25.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button25.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button25.type = testData2s;
      print(sio.button25.type);
      expect(sio.button25.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button25.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button25.type = defalut;
      print(sio.button25.type);
      expect(sio.button25.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button25.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00125_element_check_00101 **********\n\n");
    });

    test('00126_element_check_00102', () async {
      print("\n********** テスト実行：00126_element_check_00102 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button26.title;
      print(sio.button26.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button26.title = testData1s;
      print(sio.button26.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button26.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button26.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button26.title = testData2s;
      print(sio.button26.title);
      expect(sio.button26.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button26.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button26.title = defalut;
      print(sio.button26.title);
      expect(sio.button26.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button26.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00126_element_check_00102 **********\n\n");
    });

    test('00127_element_check_00103', () async {
      print("\n********** テスト実行：00127_element_check_00103 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button26.kind;
      print(sio.button26.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button26.kind = testData1;
      print(sio.button26.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button26.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button26.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button26.kind = testData2;
      print(sio.button26.kind);
      expect(sio.button26.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button26.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button26.kind = defalut;
      print(sio.button26.kind);
      expect(sio.button26.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button26.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00127_element_check_00103 **********\n\n");
    });

    test('00128_element_check_00104', () async {
      print("\n********** テスト実行：00128_element_check_00104 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button26.section;
      print(sio.button26.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button26.section = testData1s;
      print(sio.button26.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button26.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button26.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button26.section = testData2s;
      print(sio.button26.section);
      expect(sio.button26.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button26.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button26.section = defalut;
      print(sio.button26.section);
      expect(sio.button26.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button26.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00128_element_check_00104 **********\n\n");
    });

    test('00129_element_check_00105', () async {
      print("\n********** テスト実行：00129_element_check_00105 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button26.type;
      print(sio.button26.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button26.type = testData1s;
      print(sio.button26.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button26.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button26.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button26.type = testData2s;
      print(sio.button26.type);
      expect(sio.button26.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button26.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button26.type = defalut;
      print(sio.button26.type);
      expect(sio.button26.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button26.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00129_element_check_00105 **********\n\n");
    });

    test('00130_element_check_00106', () async {
      print("\n********** テスト実行：00130_element_check_00106 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button27.title;
      print(sio.button27.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button27.title = testData1s;
      print(sio.button27.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button27.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button27.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button27.title = testData2s;
      print(sio.button27.title);
      expect(sio.button27.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button27.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button27.title = defalut;
      print(sio.button27.title);
      expect(sio.button27.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button27.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00130_element_check_00106 **********\n\n");
    });

    test('00131_element_check_00107', () async {
      print("\n********** テスト実行：00131_element_check_00107 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button27.kind;
      print(sio.button27.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button27.kind = testData1;
      print(sio.button27.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button27.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button27.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button27.kind = testData2;
      print(sio.button27.kind);
      expect(sio.button27.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button27.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button27.kind = defalut;
      print(sio.button27.kind);
      expect(sio.button27.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button27.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00131_element_check_00107 **********\n\n");
    });

    test('00132_element_check_00108', () async {
      print("\n********** テスト実行：00132_element_check_00108 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button27.section;
      print(sio.button27.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button27.section = testData1s;
      print(sio.button27.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button27.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button27.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button27.section = testData2s;
      print(sio.button27.section);
      expect(sio.button27.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button27.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button27.section = defalut;
      print(sio.button27.section);
      expect(sio.button27.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button27.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00132_element_check_00108 **********\n\n");
    });

    test('00133_element_check_00109', () async {
      print("\n********** テスト実行：00133_element_check_00109 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button27.type;
      print(sio.button27.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button27.type = testData1s;
      print(sio.button27.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button27.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button27.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button27.type = testData2s;
      print(sio.button27.type);
      expect(sio.button27.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button27.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button27.type = defalut;
      print(sio.button27.type);
      expect(sio.button27.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button27.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00133_element_check_00109 **********\n\n");
    });

    test('00134_element_check_00110', () async {
      print("\n********** テスト実行：00134_element_check_00110 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button28.title;
      print(sio.button28.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button28.title = testData1s;
      print(sio.button28.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button28.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button28.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button28.title = testData2s;
      print(sio.button28.title);
      expect(sio.button28.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button28.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button28.title = defalut;
      print(sio.button28.title);
      expect(sio.button28.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button28.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00134_element_check_00110 **********\n\n");
    });

    test('00135_element_check_00111', () async {
      print("\n********** テスト実行：00135_element_check_00111 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button28.kind;
      print(sio.button28.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button28.kind = testData1;
      print(sio.button28.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button28.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button28.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button28.kind = testData2;
      print(sio.button28.kind);
      expect(sio.button28.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button28.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button28.kind = defalut;
      print(sio.button28.kind);
      expect(sio.button28.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button28.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00135_element_check_00111 **********\n\n");
    });

    test('00136_element_check_00112', () async {
      print("\n********** テスト実行：00136_element_check_00112 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button28.section;
      print(sio.button28.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button28.section = testData1s;
      print(sio.button28.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button28.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button28.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button28.section = testData2s;
      print(sio.button28.section);
      expect(sio.button28.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button28.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button28.section = defalut;
      print(sio.button28.section);
      expect(sio.button28.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button28.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00136_element_check_00112 **********\n\n");
    });

    test('00137_element_check_00113', () async {
      print("\n********** テスト実行：00137_element_check_00113 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button28.type;
      print(sio.button28.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button28.type = testData1s;
      print(sio.button28.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button28.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button28.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button28.type = testData2s;
      print(sio.button28.type);
      expect(sio.button28.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button28.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button28.type = defalut;
      print(sio.button28.type);
      expect(sio.button28.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button28.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00137_element_check_00113 **********\n\n");
    });

    test('00138_element_check_00114', () async {
      print("\n********** テスト実行：00138_element_check_00114 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button29.title;
      print(sio.button29.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button29.title = testData1s;
      print(sio.button29.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button29.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button29.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button29.title = testData2s;
      print(sio.button29.title);
      expect(sio.button29.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button29.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button29.title = defalut;
      print(sio.button29.title);
      expect(sio.button29.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button29.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00138_element_check_00114 **********\n\n");
    });

    test('00139_element_check_00115', () async {
      print("\n********** テスト実行：00139_element_check_00115 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button29.kind;
      print(sio.button29.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button29.kind = testData1;
      print(sio.button29.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button29.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button29.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button29.kind = testData2;
      print(sio.button29.kind);
      expect(sio.button29.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button29.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button29.kind = defalut;
      print(sio.button29.kind);
      expect(sio.button29.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button29.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00139_element_check_00115 **********\n\n");
    });

    test('00140_element_check_00116', () async {
      print("\n********** テスト実行：00140_element_check_00116 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button29.section;
      print(sio.button29.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button29.section = testData1s;
      print(sio.button29.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button29.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button29.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button29.section = testData2s;
      print(sio.button29.section);
      expect(sio.button29.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button29.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button29.section = defalut;
      print(sio.button29.section);
      expect(sio.button29.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button29.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00140_element_check_00116 **********\n\n");
    });

    test('00141_element_check_00117', () async {
      print("\n********** テスト実行：00141_element_check_00117 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button29.type;
      print(sio.button29.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button29.type = testData1s;
      print(sio.button29.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button29.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button29.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button29.type = testData2s;
      print(sio.button29.type);
      expect(sio.button29.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button29.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button29.type = defalut;
      print(sio.button29.type);
      expect(sio.button29.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button29.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00141_element_check_00117 **********\n\n");
    });

    test('00142_element_check_00118', () async {
      print("\n********** テスト実行：00142_element_check_00118 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button30.title;
      print(sio.button30.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button30.title = testData1s;
      print(sio.button30.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button30.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button30.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button30.title = testData2s;
      print(sio.button30.title);
      expect(sio.button30.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button30.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button30.title = defalut;
      print(sio.button30.title);
      expect(sio.button30.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button30.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00142_element_check_00118 **********\n\n");
    });

    test('00143_element_check_00119', () async {
      print("\n********** テスト実行：00143_element_check_00119 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button30.kind;
      print(sio.button30.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button30.kind = testData1;
      print(sio.button30.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button30.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button30.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button30.kind = testData2;
      print(sio.button30.kind);
      expect(sio.button30.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button30.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button30.kind = defalut;
      print(sio.button30.kind);
      expect(sio.button30.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button30.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00143_element_check_00119 **********\n\n");
    });

    test('00144_element_check_00120', () async {
      print("\n********** テスト実行：00144_element_check_00120 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button30.section;
      print(sio.button30.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button30.section = testData1s;
      print(sio.button30.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button30.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button30.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button30.section = testData2s;
      print(sio.button30.section);
      expect(sio.button30.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button30.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button30.section = defalut;
      print(sio.button30.section);
      expect(sio.button30.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button30.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00144_element_check_00120 **********\n\n");
    });

    test('00145_element_check_00121', () async {
      print("\n********** テスト実行：00145_element_check_00121 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button30.type;
      print(sio.button30.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button30.type = testData1s;
      print(sio.button30.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button30.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button30.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button30.type = testData2s;
      print(sio.button30.type);
      expect(sio.button30.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button30.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button30.type = defalut;
      print(sio.button30.type);
      expect(sio.button30.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button30.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00145_element_check_00121 **********\n\n");
    });

    test('00146_element_check_00122', () async {
      print("\n********** テスト実行：00146_element_check_00122 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button31.title;
      print(sio.button31.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button31.title = testData1s;
      print(sio.button31.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button31.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button31.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button31.title = testData2s;
      print(sio.button31.title);
      expect(sio.button31.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button31.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button31.title = defalut;
      print(sio.button31.title);
      expect(sio.button31.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button31.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00146_element_check_00122 **********\n\n");
    });

    test('00147_element_check_00123', () async {
      print("\n********** テスト実行：00147_element_check_00123 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button31.kind;
      print(sio.button31.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button31.kind = testData1;
      print(sio.button31.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button31.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button31.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button31.kind = testData2;
      print(sio.button31.kind);
      expect(sio.button31.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button31.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button31.kind = defalut;
      print(sio.button31.kind);
      expect(sio.button31.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button31.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00147_element_check_00123 **********\n\n");
    });

    test('00148_element_check_00124', () async {
      print("\n********** テスト実行：00148_element_check_00124 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button31.section;
      print(sio.button31.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button31.section = testData1s;
      print(sio.button31.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button31.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button31.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button31.section = testData2s;
      print(sio.button31.section);
      expect(sio.button31.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button31.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button31.section = defalut;
      print(sio.button31.section);
      expect(sio.button31.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button31.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00148_element_check_00124 **********\n\n");
    });

    test('00149_element_check_00125', () async {
      print("\n********** テスト実行：00149_element_check_00125 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button31.type;
      print(sio.button31.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button31.type = testData1s;
      print(sio.button31.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button31.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button31.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button31.type = testData2s;
      print(sio.button31.type);
      expect(sio.button31.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button31.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button31.type = defalut;
      print(sio.button31.type);
      expect(sio.button31.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button31.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00149_element_check_00125 **********\n\n");
    });

    test('00150_element_check_00126', () async {
      print("\n********** テスト実行：00150_element_check_00126 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button32.title;
      print(sio.button32.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button32.title = testData1s;
      print(sio.button32.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button32.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button32.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button32.title = testData2s;
      print(sio.button32.title);
      expect(sio.button32.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button32.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button32.title = defalut;
      print(sio.button32.title);
      expect(sio.button32.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button32.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00150_element_check_00126 **********\n\n");
    });

    test('00151_element_check_00127', () async {
      print("\n********** テスト実行：00151_element_check_00127 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button32.kind;
      print(sio.button32.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button32.kind = testData1;
      print(sio.button32.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button32.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button32.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button32.kind = testData2;
      print(sio.button32.kind);
      expect(sio.button32.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button32.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button32.kind = defalut;
      print(sio.button32.kind);
      expect(sio.button32.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button32.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00151_element_check_00127 **********\n\n");
    });

    test('00152_element_check_00128', () async {
      print("\n********** テスト実行：00152_element_check_00128 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button32.section;
      print(sio.button32.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button32.section = testData1s;
      print(sio.button32.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button32.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button32.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button32.section = testData2s;
      print(sio.button32.section);
      expect(sio.button32.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button32.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button32.section = defalut;
      print(sio.button32.section);
      expect(sio.button32.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button32.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00152_element_check_00128 **********\n\n");
    });

    test('00153_element_check_00129', () async {
      print("\n********** テスト実行：00153_element_check_00129 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button32.type;
      print(sio.button32.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button32.type = testData1s;
      print(sio.button32.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button32.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button32.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button32.type = testData2s;
      print(sio.button32.type);
      expect(sio.button32.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button32.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button32.type = defalut;
      print(sio.button32.type);
      expect(sio.button32.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button32.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00153_element_check_00129 **********\n\n");
    });

    test('00154_element_check_00130', () async {
      print("\n********** テスト実行：00154_element_check_00130 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button33.title;
      print(sio.button33.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button33.title = testData1s;
      print(sio.button33.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button33.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button33.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button33.title = testData2s;
      print(sio.button33.title);
      expect(sio.button33.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button33.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button33.title = defalut;
      print(sio.button33.title);
      expect(sio.button33.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button33.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00154_element_check_00130 **********\n\n");
    });

    test('00155_element_check_00131', () async {
      print("\n********** テスト実行：00155_element_check_00131 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button33.kind;
      print(sio.button33.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button33.kind = testData1s;
      print(sio.button33.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button33.kind == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button33.kind == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button33.kind = testData2s;
      print(sio.button33.kind);
      expect(sio.button33.kind == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button33.kind == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button33.kind = defalut;
      print(sio.button33.kind);
      expect(sio.button33.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button33.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00155_element_check_00131 **********\n\n");
    });

    test('00156_element_check_00132', () async {
      print("\n********** テスト実行：00156_element_check_00132 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button33.section;
      print(sio.button33.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button33.section = testData1s;
      print(sio.button33.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button33.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button33.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button33.section = testData2s;
      print(sio.button33.section);
      expect(sio.button33.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button33.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button33.section = defalut;
      print(sio.button33.section);
      expect(sio.button33.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button33.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00156_element_check_00132 **********\n\n");
    });

    test('00157_element_check_00133', () async {
      print("\n********** テスト実行：00157_element_check_00133 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button33.type;
      print(sio.button33.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button33.type = testData1s;
      print(sio.button33.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button33.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button33.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button33.type = testData2s;
      print(sio.button33.type);
      expect(sio.button33.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button33.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button33.type = defalut;
      print(sio.button33.type);
      expect(sio.button33.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button33.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00157_element_check_00133 **********\n\n");
    });

    test('00158_element_check_00134', () async {
      print("\n********** テスト実行：00158_element_check_00134 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button34.title;
      print(sio.button34.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button34.title = testData1s;
      print(sio.button34.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button34.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button34.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button34.title = testData2s;
      print(sio.button34.title);
      expect(sio.button34.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button34.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button34.title = defalut;
      print(sio.button34.title);
      expect(sio.button34.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button34.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00158_element_check_00134 **********\n\n");
    });

    test('00159_element_check_00135', () async {
      print("\n********** テスト実行：00159_element_check_00135 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button34.kind;
      print(sio.button34.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button34.kind = testData1;
      print(sio.button34.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button34.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button34.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button34.kind = testData2;
      print(sio.button34.kind);
      expect(sio.button34.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button34.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button34.kind = defalut;
      print(sio.button34.kind);
      expect(sio.button34.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button34.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00159_element_check_00135 **********\n\n");
    });

    test('00160_element_check_00136', () async {
      print("\n********** テスト実行：00160_element_check_00136 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button34.section;
      print(sio.button34.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button34.section = testData1s;
      print(sio.button34.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button34.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button34.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button34.section = testData2s;
      print(sio.button34.section);
      expect(sio.button34.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button34.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button34.section = defalut;
      print(sio.button34.section);
      expect(sio.button34.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button34.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00160_element_check_00136 **********\n\n");
    });

    test('00161_element_check_00137', () async {
      print("\n********** テスト実行：00161_element_check_00137 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button34.type;
      print(sio.button34.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button34.type = testData1s;
      print(sio.button34.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button34.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button34.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button34.type = testData2s;
      print(sio.button34.type);
      expect(sio.button34.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button34.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button34.type = defalut;
      print(sio.button34.type);
      expect(sio.button34.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button34.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00161_element_check_00137 **********\n\n");
    });

    test('00162_element_check_00138', () async {
      print("\n********** テスト実行：00162_element_check_00138 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button35.title;
      print(sio.button35.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button35.title = testData1s;
      print(sio.button35.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button35.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button35.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button35.title = testData2s;
      print(sio.button35.title);
      expect(sio.button35.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button35.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button35.title = defalut;
      print(sio.button35.title);
      expect(sio.button35.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button35.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00162_element_check_00138 **********\n\n");
    });

    test('00163_element_check_00139', () async {
      print("\n********** テスト実行：00163_element_check_00139 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button35.kind;
      print(sio.button35.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button35.kind = testData1;
      print(sio.button35.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button35.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button35.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button35.kind = testData2;
      print(sio.button35.kind);
      expect(sio.button35.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button35.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button35.kind = defalut;
      print(sio.button35.kind);
      expect(sio.button35.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button35.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00163_element_check_00139 **********\n\n");
    });

    test('00164_element_check_00140', () async {
      print("\n********** テスト実行：00164_element_check_00140 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button35.section;
      print(sio.button35.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button35.section = testData1s;
      print(sio.button35.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button35.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button35.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button35.section = testData2s;
      print(sio.button35.section);
      expect(sio.button35.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button35.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button35.section = defalut;
      print(sio.button35.section);
      expect(sio.button35.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button35.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00164_element_check_00140 **********\n\n");
    });

    test('00165_element_check_00141', () async {
      print("\n********** テスト実行：00165_element_check_00141 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button35.type;
      print(sio.button35.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button35.type = testData1s;
      print(sio.button35.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button35.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button35.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button35.type = testData2s;
      print(sio.button35.type);
      expect(sio.button35.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button35.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button35.type = defalut;
      print(sio.button35.type);
      expect(sio.button35.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button35.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00165_element_check_00141 **********\n\n");
    });

    test('00166_element_check_00142', () async {
      print("\n********** テスト実行：00166_element_check_00142 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button36.title;
      print(sio.button36.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button36.title = testData1s;
      print(sio.button36.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button36.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button36.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button36.title = testData2s;
      print(sio.button36.title);
      expect(sio.button36.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button36.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button36.title = defalut;
      print(sio.button36.title);
      expect(sio.button36.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button36.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00166_element_check_00142 **********\n\n");
    });

    test('00167_element_check_00143', () async {
      print("\n********** テスト実行：00167_element_check_00143 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button36.kind;
      print(sio.button36.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button36.kind = testData1;
      print(sio.button36.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button36.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button36.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button36.kind = testData2;
      print(sio.button36.kind);
      expect(sio.button36.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button36.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button36.kind = defalut;
      print(sio.button36.kind);
      expect(sio.button36.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button36.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00167_element_check_00143 **********\n\n");
    });

    test('00168_element_check_00144', () async {
      print("\n********** テスト実行：00168_element_check_00144 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button36.section;
      print(sio.button36.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button36.section = testData1s;
      print(sio.button36.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button36.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button36.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button36.section = testData2s;
      print(sio.button36.section);
      expect(sio.button36.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button36.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button36.section = defalut;
      print(sio.button36.section);
      expect(sio.button36.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button36.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00168_element_check_00144 **********\n\n");
    });

    test('00169_element_check_00145', () async {
      print("\n********** テスト実行：00169_element_check_00145 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button36.type;
      print(sio.button36.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button36.type = testData1s;
      print(sio.button36.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button36.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button36.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button36.type = testData2s;
      print(sio.button36.type);
      expect(sio.button36.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button36.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button36.type = defalut;
      print(sio.button36.type);
      expect(sio.button36.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button36.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00169_element_check_00145 **********\n\n");
    });

    test('00170_element_check_00146', () async {
      print("\n********** テスト実行：00170_element_check_00146 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button37.title;
      print(sio.button37.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button37.title = testData1s;
      print(sio.button37.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button37.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button37.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button37.title = testData2s;
      print(sio.button37.title);
      expect(sio.button37.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button37.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button37.title = defalut;
      print(sio.button37.title);
      expect(sio.button37.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button37.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00170_element_check_00146 **********\n\n");
    });

    test('00171_element_check_00147', () async {
      print("\n********** テスト実行：00171_element_check_00147 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button37.kind;
      print(sio.button37.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button37.kind = testData1;
      print(sio.button37.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button37.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button37.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button37.kind = testData2;
      print(sio.button37.kind);
      expect(sio.button37.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button37.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button37.kind = defalut;
      print(sio.button37.kind);
      expect(sio.button37.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button37.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00171_element_check_00147 **********\n\n");
    });

    test('00172_element_check_00148', () async {
      print("\n********** テスト実行：00172_element_check_00148 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button37.section;
      print(sio.button37.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button37.section = testData1s;
      print(sio.button37.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button37.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button37.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button37.section = testData2s;
      print(sio.button37.section);
      expect(sio.button37.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button37.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button37.section = defalut;
      print(sio.button37.section);
      expect(sio.button37.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button37.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00172_element_check_00148 **********\n\n");
    });

    test('00173_element_check_00149', () async {
      print("\n********** テスト実行：00173_element_check_00149 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button37.type;
      print(sio.button37.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button37.type = testData1s;
      print(sio.button37.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button37.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button37.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button37.type = testData2s;
      print(sio.button37.type);
      expect(sio.button37.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button37.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button37.type = defalut;
      print(sio.button37.type);
      expect(sio.button37.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button37.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00173_element_check_00149 **********\n\n");
    });

    test('00174_element_check_00150', () async {
      print("\n********** テスト実行：00174_element_check_00150 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button38.title;
      print(sio.button38.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button38.title = testData1s;
      print(sio.button38.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button38.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button38.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button38.title = testData2s;
      print(sio.button38.title);
      expect(sio.button38.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button38.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button38.title = defalut;
      print(sio.button38.title);
      expect(sio.button38.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button38.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00174_element_check_00150 **********\n\n");
    });

    test('00175_element_check_00151', () async {
      print("\n********** テスト実行：00175_element_check_00151 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button38.kind;
      print(sio.button38.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button38.kind = testData1;
      print(sio.button38.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button38.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button38.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button38.kind = testData2;
      print(sio.button38.kind);
      expect(sio.button38.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button38.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button38.kind = defalut;
      print(sio.button38.kind);
      expect(sio.button38.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button38.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00175_element_check_00151 **********\n\n");
    });

    test('00176_element_check_00152', () async {
      print("\n********** テスト実行：00176_element_check_00152 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button38.section;
      print(sio.button38.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button38.section = testData1s;
      print(sio.button38.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button38.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button38.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button38.section = testData2s;
      print(sio.button38.section);
      expect(sio.button38.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button38.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button38.section = defalut;
      print(sio.button38.section);
      expect(sio.button38.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button38.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00176_element_check_00152 **********\n\n");
    });

    test('00177_element_check_00153', () async {
      print("\n********** テスト実行：00177_element_check_00153 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button38.type;
      print(sio.button38.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button38.type = testData1s;
      print(sio.button38.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button38.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button38.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button38.type = testData2s;
      print(sio.button38.type);
      expect(sio.button38.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button38.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button38.type = defalut;
      print(sio.button38.type);
      expect(sio.button38.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button38.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00177_element_check_00153 **********\n\n");
    });

    test('00178_element_check_00154', () async {
      print("\n********** テスト実行：00178_element_check_00154 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button39.title;
      print(sio.button39.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button39.title = testData1s;
      print(sio.button39.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button39.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button39.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button39.title = testData2s;
      print(sio.button39.title);
      expect(sio.button39.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button39.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button39.title = defalut;
      print(sio.button39.title);
      expect(sio.button39.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button39.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00178_element_check_00154 **********\n\n");
    });

    test('00179_element_check_00155', () async {
      print("\n********** テスト実行：00179_element_check_00155 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button39.kind;
      print(sio.button39.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button39.kind = testData1;
      print(sio.button39.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button39.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button39.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button39.kind = testData2;
      print(sio.button39.kind);
      expect(sio.button39.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button39.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button39.kind = defalut;
      print(sio.button39.kind);
      expect(sio.button39.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button39.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00179_element_check_00155 **********\n\n");
    });

    test('00180_element_check_00156', () async {
      print("\n********** テスト実行：00180_element_check_00156 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button39.section;
      print(sio.button39.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button39.section = testData1s;
      print(sio.button39.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button39.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button39.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button39.section = testData2s;
      print(sio.button39.section);
      expect(sio.button39.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button39.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button39.section = defalut;
      print(sio.button39.section);
      expect(sio.button39.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button39.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00180_element_check_00156 **********\n\n");
    });

    test('00181_element_check_00157', () async {
      print("\n********** テスト実行：00181_element_check_00157 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button39.type;
      print(sio.button39.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button39.type = testData1s;
      print(sio.button39.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button39.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button39.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button39.type = testData2s;
      print(sio.button39.type);
      expect(sio.button39.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button39.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button39.type = defalut;
      print(sio.button39.type);
      expect(sio.button39.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button39.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00181_element_check_00157 **********\n\n");
    });

    test('00182_element_check_00158', () async {
      print("\n********** テスト実行：00182_element_check_00158 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button40.title;
      print(sio.button40.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button40.title = testData1s;
      print(sio.button40.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button40.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button40.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button40.title = testData2s;
      print(sio.button40.title);
      expect(sio.button40.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button40.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button40.title = defalut;
      print(sio.button40.title);
      expect(sio.button40.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button40.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00182_element_check_00158 **********\n\n");
    });

    test('00183_element_check_00159', () async {
      print("\n********** テスト実行：00183_element_check_00159 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button40.kind;
      print(sio.button40.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button40.kind = testData1;
      print(sio.button40.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button40.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button40.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button40.kind = testData2;
      print(sio.button40.kind);
      expect(sio.button40.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button40.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button40.kind = defalut;
      print(sio.button40.kind);
      expect(sio.button40.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button40.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00183_element_check_00159 **********\n\n");
    });

    test('00184_element_check_00160', () async {
      print("\n********** テスト実行：00184_element_check_00160 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button40.section;
      print(sio.button40.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button40.section = testData1s;
      print(sio.button40.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button40.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button40.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button40.section = testData2s;
      print(sio.button40.section);
      expect(sio.button40.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button40.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button40.section = defalut;
      print(sio.button40.section);
      expect(sio.button40.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button40.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00184_element_check_00160 **********\n\n");
    });

    test('00185_element_check_00161', () async {
      print("\n********** テスト実行：00185_element_check_00161 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button40.type;
      print(sio.button40.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button40.type = testData1s;
      print(sio.button40.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button40.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button40.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button40.type = testData2s;
      print(sio.button40.type);
      expect(sio.button40.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button40.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button40.type = defalut;
      print(sio.button40.type);
      expect(sio.button40.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button40.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00185_element_check_00161 **********\n\n");
    });

    test('00186_element_check_00162', () async {
      print("\n********** テスト実行：00186_element_check_00162 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button41.title;
      print(sio.button41.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button41.title = testData1s;
      print(sio.button41.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button41.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button41.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button41.title = testData2s;
      print(sio.button41.title);
      expect(sio.button41.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button41.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button41.title = defalut;
      print(sio.button41.title);
      expect(sio.button41.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button41.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00186_element_check_00162 **********\n\n");
    });

    test('00187_element_check_00163', () async {
      print("\n********** テスト実行：00187_element_check_00163 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button41.kind;
      print(sio.button41.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button41.kind = testData1;
      print(sio.button41.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button41.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button41.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button41.kind = testData2;
      print(sio.button41.kind);
      expect(sio.button41.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button41.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button41.kind = defalut;
      print(sio.button41.kind);
      expect(sio.button41.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button41.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00187_element_check_00163 **********\n\n");
    });

    test('00188_element_check_00164', () async {
      print("\n********** テスト実行：00188_element_check_00164 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button41.section;
      print(sio.button41.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button41.section = testData1s;
      print(sio.button41.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button41.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button41.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button41.section = testData2s;
      print(sio.button41.section);
      expect(sio.button41.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button41.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button41.section = defalut;
      print(sio.button41.section);
      expect(sio.button41.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button41.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00188_element_check_00164 **********\n\n");
    });

    test('00189_element_check_00165', () async {
      print("\n********** テスト実行：00189_element_check_00165 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button41.type;
      print(sio.button41.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button41.type = testData1s;
      print(sio.button41.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button41.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button41.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button41.type = testData2s;
      print(sio.button41.type);
      expect(sio.button41.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button41.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button41.type = defalut;
      print(sio.button41.type);
      expect(sio.button41.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button41.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00189_element_check_00165 **********\n\n");
    });

    test('00190_element_check_00166', () async {
      print("\n********** テスト実行：00190_element_check_00166 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button42.title;
      print(sio.button42.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button42.title = testData1s;
      print(sio.button42.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button42.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button42.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button42.title = testData2s;
      print(sio.button42.title);
      expect(sio.button42.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button42.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button42.title = defalut;
      print(sio.button42.title);
      expect(sio.button42.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button42.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00190_element_check_00166 **********\n\n");
    });

    test('00191_element_check_00167', () async {
      print("\n********** テスト実行：00191_element_check_00167 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button42.kind;
      print(sio.button42.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button42.kind = testData1;
      print(sio.button42.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button42.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button42.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button42.kind = testData2;
      print(sio.button42.kind);
      expect(sio.button42.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button42.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button42.kind = defalut;
      print(sio.button42.kind);
      expect(sio.button42.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button42.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00191_element_check_00167 **********\n\n");
    });

    test('00192_element_check_00168', () async {
      print("\n********** テスト実行：00192_element_check_00168 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button42.section;
      print(sio.button42.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button42.section = testData1s;
      print(sio.button42.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button42.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button42.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button42.section = testData2s;
      print(sio.button42.section);
      expect(sio.button42.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button42.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button42.section = defalut;
      print(sio.button42.section);
      expect(sio.button42.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button42.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00192_element_check_00168 **********\n\n");
    });

    test('00193_element_check_00169', () async {
      print("\n********** テスト実行：00193_element_check_00169 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button42.type;
      print(sio.button42.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button42.type = testData1s;
      print(sio.button42.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button42.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button42.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button42.type = testData2s;
      print(sio.button42.type);
      expect(sio.button42.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button42.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button42.type = defalut;
      print(sio.button42.type);
      expect(sio.button42.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button42.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00193_element_check_00169 **********\n\n");
    });

    test('00194_element_check_00170', () async {
      print("\n********** テスト実行：00194_element_check_00170 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button43.title;
      print(sio.button43.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button43.title = testData1s;
      print(sio.button43.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button43.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button43.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button43.title = testData2s;
      print(sio.button43.title);
      expect(sio.button43.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button43.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button43.title = defalut;
      print(sio.button43.title);
      expect(sio.button43.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button43.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00194_element_check_00170 **********\n\n");
    });

    test('00195_element_check_00171', () async {
      print("\n********** テスト実行：00195_element_check_00171 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button43.kind;
      print(sio.button43.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button43.kind = testData1;
      print(sio.button43.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button43.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button43.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button43.kind = testData2;
      print(sio.button43.kind);
      expect(sio.button43.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button43.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button43.kind = defalut;
      print(sio.button43.kind);
      expect(sio.button43.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button43.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00195_element_check_00171 **********\n\n");
    });

    test('00196_element_check_00172', () async {
      print("\n********** テスト実行：00196_element_check_00172 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button43.section;
      print(sio.button43.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button43.section = testData1s;
      print(sio.button43.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button43.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button43.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button43.section = testData2s;
      print(sio.button43.section);
      expect(sio.button43.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button43.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button43.section = defalut;
      print(sio.button43.section);
      expect(sio.button43.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button43.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00196_element_check_00172 **********\n\n");
    });

    test('00197_element_check_00173', () async {
      print("\n********** テスト実行：00197_element_check_00173 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button43.type;
      print(sio.button43.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button43.type = testData1s;
      print(sio.button43.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button43.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button43.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button43.type = testData2s;
      print(sio.button43.type);
      expect(sio.button43.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button43.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button43.type = defalut;
      print(sio.button43.type);
      expect(sio.button43.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button43.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00197_element_check_00173 **********\n\n");
    });

    test('00198_element_check_00174', () async {
      print("\n********** テスト実行：00198_element_check_00174 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button44.title;
      print(sio.button44.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button44.title = testData1s;
      print(sio.button44.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button44.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button44.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button44.title = testData2s;
      print(sio.button44.title);
      expect(sio.button44.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button44.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button44.title = defalut;
      print(sio.button44.title);
      expect(sio.button44.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button44.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00198_element_check_00174 **********\n\n");
    });

    test('00199_element_check_00175', () async {
      print("\n********** テスト実行：00199_element_check_00175 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button44.kind;
      print(sio.button44.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button44.kind = testData1;
      print(sio.button44.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button44.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button44.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button44.kind = testData2;
      print(sio.button44.kind);
      expect(sio.button44.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button44.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button44.kind = defalut;
      print(sio.button44.kind);
      expect(sio.button44.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button44.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00199_element_check_00175 **********\n\n");
    });

    test('00200_element_check_00176', () async {
      print("\n********** テスト実行：00200_element_check_00176 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button44.section;
      print(sio.button44.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button44.section = testData1s;
      print(sio.button44.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button44.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button44.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button44.section = testData2s;
      print(sio.button44.section);
      expect(sio.button44.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button44.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button44.section = defalut;
      print(sio.button44.section);
      expect(sio.button44.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button44.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00200_element_check_00176 **********\n\n");
    });

    test('00201_element_check_00177', () async {
      print("\n********** テスト実行：00201_element_check_00177 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button44.type;
      print(sio.button44.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button44.type = testData1s;
      print(sio.button44.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button44.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button44.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button44.type = testData2s;
      print(sio.button44.type);
      expect(sio.button44.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button44.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button44.type = defalut;
      print(sio.button44.type);
      expect(sio.button44.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button44.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00201_element_check_00177 **********\n\n");
    });

    test('00202_element_check_00178', () async {
      print("\n********** テスト実行：00202_element_check_00178 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button45.title;
      print(sio.button45.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button45.title = testData1s;
      print(sio.button45.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button45.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button45.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button45.title = testData2s;
      print(sio.button45.title);
      expect(sio.button45.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button45.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button45.title = defalut;
      print(sio.button45.title);
      expect(sio.button45.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button45.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00202_element_check_00178 **********\n\n");
    });

    test('00203_element_check_00179', () async {
      print("\n********** テスト実行：00203_element_check_00179 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button45.kind;
      print(sio.button45.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button45.kind = testData1;
      print(sio.button45.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button45.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button45.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button45.kind = testData2;
      print(sio.button45.kind);
      expect(sio.button45.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button45.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button45.kind = defalut;
      print(sio.button45.kind);
      expect(sio.button45.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button45.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00203_element_check_00179 **********\n\n");
    });

    test('00204_element_check_00180', () async {
      print("\n********** テスト実行：00204_element_check_00180 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button45.section;
      print(sio.button45.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button45.section = testData1s;
      print(sio.button45.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button45.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button45.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button45.section = testData2s;
      print(sio.button45.section);
      expect(sio.button45.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button45.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button45.section = defalut;
      print(sio.button45.section);
      expect(sio.button45.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button45.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00204_element_check_00180 **********\n\n");
    });

    test('00205_element_check_00181', () async {
      print("\n********** テスト実行：00205_element_check_00181 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button45.type;
      print(sio.button45.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button45.type = testData1s;
      print(sio.button45.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button45.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button45.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button45.type = testData2s;
      print(sio.button45.type);
      expect(sio.button45.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button45.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button45.type = defalut;
      print(sio.button45.type);
      expect(sio.button45.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button45.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00205_element_check_00181 **********\n\n");
    });

    test('00206_element_check_00182', () async {
      print("\n********** テスト実行：00206_element_check_00182 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button46.title;
      print(sio.button46.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button46.title = testData1s;
      print(sio.button46.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button46.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button46.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button46.title = testData2s;
      print(sio.button46.title);
      expect(sio.button46.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button46.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button46.title = defalut;
      print(sio.button46.title);
      expect(sio.button46.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button46.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00206_element_check_00182 **********\n\n");
    });

    test('00207_element_check_00183', () async {
      print("\n********** テスト実行：00207_element_check_00183 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button46.kind;
      print(sio.button46.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button46.kind = testData1;
      print(sio.button46.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button46.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button46.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button46.kind = testData2;
      print(sio.button46.kind);
      expect(sio.button46.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button46.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button46.kind = defalut;
      print(sio.button46.kind);
      expect(sio.button46.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button46.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00207_element_check_00183 **********\n\n");
    });

    test('00208_element_check_00184', () async {
      print("\n********** テスト実行：00208_element_check_00184 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button46.section;
      print(sio.button46.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button46.section = testData1s;
      print(sio.button46.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button46.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button46.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button46.section = testData2s;
      print(sio.button46.section);
      expect(sio.button46.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button46.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button46.section = defalut;
      print(sio.button46.section);
      expect(sio.button46.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button46.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00208_element_check_00184 **********\n\n");
    });

    test('00209_element_check_00185', () async {
      print("\n********** テスト実行：00209_element_check_00185 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button46.type;
      print(sio.button46.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button46.type = testData1s;
      print(sio.button46.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button46.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button46.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button46.type = testData2s;
      print(sio.button46.type);
      expect(sio.button46.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button46.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button46.type = defalut;
      print(sio.button46.type);
      expect(sio.button46.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button46.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00209_element_check_00185 **********\n\n");
    });

    test('00210_element_check_00186', () async {
      print("\n********** テスト実行：00210_element_check_00186 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button47.title;
      print(sio.button47.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button47.title = testData1s;
      print(sio.button47.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button47.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button47.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button47.title = testData2s;
      print(sio.button47.title);
      expect(sio.button47.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button47.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button47.title = defalut;
      print(sio.button47.title);
      expect(sio.button47.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button47.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00210_element_check_00186 **********\n\n");
    });

    test('00211_element_check_00187', () async {
      print("\n********** テスト実行：00211_element_check_00187 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button47.kind;
      print(sio.button47.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button47.kind = testData1;
      print(sio.button47.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button47.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button47.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button47.kind = testData2;
      print(sio.button47.kind);
      expect(sio.button47.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button47.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button47.kind = defalut;
      print(sio.button47.kind);
      expect(sio.button47.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button47.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00211_element_check_00187 **********\n\n");
    });

    test('00212_element_check_00188', () async {
      print("\n********** テスト実行：00212_element_check_00188 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button47.section;
      print(sio.button47.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button47.section = testData1s;
      print(sio.button47.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button47.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button47.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button47.section = testData2s;
      print(sio.button47.section);
      expect(sio.button47.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button47.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button47.section = defalut;
      print(sio.button47.section);
      expect(sio.button47.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button47.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00212_element_check_00188 **********\n\n");
    });

    test('00213_element_check_00189', () async {
      print("\n********** テスト実行：00213_element_check_00189 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button47.type;
      print(sio.button47.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button47.type = testData1s;
      print(sio.button47.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button47.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button47.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button47.type = testData2s;
      print(sio.button47.type);
      expect(sio.button47.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button47.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button47.type = defalut;
      print(sio.button47.type);
      expect(sio.button47.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button47.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00213_element_check_00189 **********\n\n");
    });

    test('00214_element_check_00190', () async {
      print("\n********** テスト実行：00214_element_check_00190 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button48.title;
      print(sio.button48.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button48.title = testData1s;
      print(sio.button48.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button48.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button48.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button48.title = testData2s;
      print(sio.button48.title);
      expect(sio.button48.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button48.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button48.title = defalut;
      print(sio.button48.title);
      expect(sio.button48.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button48.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00214_element_check_00190 **********\n\n");
    });

    test('00215_element_check_00191', () async {
      print("\n********** テスト実行：00215_element_check_00191 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button48.kind;
      print(sio.button48.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button48.kind = testData1;
      print(sio.button48.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button48.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button48.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button48.kind = testData2;
      print(sio.button48.kind);
      expect(sio.button48.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button48.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button48.kind = defalut;
      print(sio.button48.kind);
      expect(sio.button48.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button48.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00215_element_check_00191 **********\n\n");
    });

    test('00216_element_check_00192', () async {
      print("\n********** テスト実行：00216_element_check_00192 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button48.section;
      print(sio.button48.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button48.section = testData1s;
      print(sio.button48.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button48.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button48.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button48.section = testData2s;
      print(sio.button48.section);
      expect(sio.button48.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button48.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button48.section = defalut;
      print(sio.button48.section);
      expect(sio.button48.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button48.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00216_element_check_00192 **********\n\n");
    });

    test('00217_element_check_00193', () async {
      print("\n********** テスト実行：00217_element_check_00193 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button48.type;
      print(sio.button48.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button48.type = testData1s;
      print(sio.button48.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button48.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button48.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button48.type = testData2s;
      print(sio.button48.type);
      expect(sio.button48.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button48.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button48.type = defalut;
      print(sio.button48.type);
      expect(sio.button48.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button48.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00217_element_check_00193 **********\n\n");
    });

    test('00218_element_check_00194', () async {
      print("\n********** テスト実行：00218_element_check_00194 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button49.title;
      print(sio.button49.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button49.title = testData1s;
      print(sio.button49.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button49.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button49.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button49.title = testData2s;
      print(sio.button49.title);
      expect(sio.button49.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button49.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button49.title = defalut;
      print(sio.button49.title);
      expect(sio.button49.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button49.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00218_element_check_00194 **********\n\n");
    });

    test('00219_element_check_00195', () async {
      print("\n********** テスト実行：00219_element_check_00195 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button49.kind;
      print(sio.button49.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button49.kind = testData1;
      print(sio.button49.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button49.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button49.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button49.kind = testData2;
      print(sio.button49.kind);
      expect(sio.button49.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button49.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button49.kind = defalut;
      print(sio.button49.kind);
      expect(sio.button49.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button49.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00219_element_check_00195 **********\n\n");
    });

    test('00220_element_check_00196', () async {
      print("\n********** テスト実行：00220_element_check_00196 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button49.section;
      print(sio.button49.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button49.section = testData1s;
      print(sio.button49.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button49.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button49.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button49.section = testData2s;
      print(sio.button49.section);
      expect(sio.button49.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button49.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button49.section = defalut;
      print(sio.button49.section);
      expect(sio.button49.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button49.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00220_element_check_00196 **********\n\n");
    });

    test('00221_element_check_00197', () async {
      print("\n********** テスト実行：00221_element_check_00197 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button49.type;
      print(sio.button49.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button49.type = testData1s;
      print(sio.button49.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button49.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button49.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button49.type = testData2s;
      print(sio.button49.type);
      expect(sio.button49.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button49.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button49.type = defalut;
      print(sio.button49.type);
      expect(sio.button49.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button49.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00221_element_check_00197 **********\n\n");
    });

    test('00222_element_check_00198', () async {
      print("\n********** テスト実行：00222_element_check_00198 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button50.title;
      print(sio.button50.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button50.title = testData1s;
      print(sio.button50.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button50.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button50.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button50.title = testData2s;
      print(sio.button50.title);
      expect(sio.button50.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button50.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button50.title = defalut;
      print(sio.button50.title);
      expect(sio.button50.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button50.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00222_element_check_00198 **********\n\n");
    });

    test('00223_element_check_00199', () async {
      print("\n********** テスト実行：00223_element_check_00199 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button50.kind;
      print(sio.button50.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button50.kind = testData1;
      print(sio.button50.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button50.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button50.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button50.kind = testData2;
      print(sio.button50.kind);
      expect(sio.button50.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button50.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button50.kind = defalut;
      print(sio.button50.kind);
      expect(sio.button50.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button50.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00223_element_check_00199 **********\n\n");
    });

    test('00224_element_check_00200', () async {
      print("\n********** テスト実行：00224_element_check_00200 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button50.section;
      print(sio.button50.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button50.section = testData1s;
      print(sio.button50.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button50.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button50.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button50.section = testData2s;
      print(sio.button50.section);
      expect(sio.button50.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button50.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button50.section = defalut;
      print(sio.button50.section);
      expect(sio.button50.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button50.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00224_element_check_00200 **********\n\n");
    });

    test('00225_element_check_00201', () async {
      print("\n********** テスト実行：00225_element_check_00201 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button50.type;
      print(sio.button50.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button50.type = testData1s;
      print(sio.button50.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button50.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button50.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button50.type = testData2s;
      print(sio.button50.type);
      expect(sio.button50.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button50.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button50.type = defalut;
      print(sio.button50.type);
      expect(sio.button50.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button50.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00225_element_check_00201 **********\n\n");
    });

    test('00226_element_check_00202', () async {
      print("\n********** テスト実行：00226_element_check_00202 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button51.title;
      print(sio.button51.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button51.title = testData1s;
      print(sio.button51.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button51.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button51.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button51.title = testData2s;
      print(sio.button51.title);
      expect(sio.button51.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button51.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button51.title = defalut;
      print(sio.button51.title);
      expect(sio.button51.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button51.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00226_element_check_00202 **********\n\n");
    });

    test('00227_element_check_00203', () async {
      print("\n********** テスト実行：00227_element_check_00203 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button51.kind;
      print(sio.button51.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button51.kind = testData1;
      print(sio.button51.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button51.kind == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button51.kind == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button51.kind = testData2;
      print(sio.button51.kind);
      expect(sio.button51.kind == testData2, true);
      await sio.save();
      await sio.load();
      expect(sio.button51.kind == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button51.kind = defalut;
      print(sio.button51.kind);
      expect(sio.button51.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button51.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00227_element_check_00203 **********\n\n");
    });

    test('00228_element_check_00204', () async {
      print("\n********** テスト実行：00228_element_check_00204 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button51.section;
      print(sio.button51.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button51.section = testData1s;
      print(sio.button51.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button51.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button51.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button51.section = testData2s;
      print(sio.button51.section);
      expect(sio.button51.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button51.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button51.section = defalut;
      print(sio.button51.section);
      expect(sio.button51.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button51.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00228_element_check_00204 **********\n\n");
    });

    test('00229_element_check_00205', () async {
      print("\n********** テスト実行：00229_element_check_00205 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button51.type;
      print(sio.button51.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button51.type = testData1s;
      print(sio.button51.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button51.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button51.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button51.type = testData2s;
      print(sio.button51.type);
      expect(sio.button51.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button51.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button51.type = defalut;
      print(sio.button51.type);
      expect(sio.button51.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button51.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00229_element_check_00205 **********\n\n");
    });

    test('00230_element_check_00206', () async {
      print("\n********** テスト実行：00230_element_check_00206 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button52.title;
      print(sio.button52.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button52.title = testData1s;
      print(sio.button52.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button52.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button52.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button52.title = testData2s;
      print(sio.button52.title);
      expect(sio.button52.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button52.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button52.title = defalut;
      print(sio.button52.title);
      expect(sio.button52.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button52.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00230_element_check_00206 **********\n\n");
    });

    test('00231_element_check_00207', () async {
      print("\n********** テスト実行：00231_element_check_00207 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button52.kind;
      print(sio.button52.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button52.kind = testData1s;
      print(sio.button52.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button52.kind == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button52.kind == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button52.kind = testData2s;
      print(sio.button52.kind);
      expect(sio.button52.kind == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button52.kind == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button52.kind = defalut;
      print(sio.button52.kind);
      expect(sio.button52.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button52.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00231_element_check_00207 **********\n\n");
    });

    test('00232_element_check_00208', () async {
      print("\n********** テスト実行：00232_element_check_00208 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button52.section;
      print(sio.button52.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button52.section = testData1s;
      print(sio.button52.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button52.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button52.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button52.section = testData2s;
      print(sio.button52.section);
      expect(sio.button52.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button52.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button52.section = defalut;
      print(sio.button52.section);
      expect(sio.button52.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button52.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00232_element_check_00208 **********\n\n");
    });

    test('00233_element_check_00209', () async {
      print("\n********** テスト実行：00233_element_check_00209 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button52.type;
      print(sio.button52.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button52.type = testData1s;
      print(sio.button52.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button52.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button52.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button52.type = testData2s;
      print(sio.button52.type);
      expect(sio.button52.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button52.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button52.type = defalut;
      print(sio.button52.type);
      expect(sio.button52.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button52.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00233_element_check_00209 **********\n\n");
    });

    test('00234_element_check_00210', () async {
      print("\n********** テスト実行：00234_element_check_00210 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button53.title;
      print(sio.button53.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button53.title = testData1s;
      print(sio.button53.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button53.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button53.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button53.title = testData2s;
      print(sio.button53.title);
      expect(sio.button53.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button53.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button53.title = defalut;
      print(sio.button53.title);
      expect(sio.button53.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button53.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00234_element_check_00210 **********\n\n");
    });

    test('00235_element_check_00211', () async {
      print("\n********** テスト実行：00235_element_check_00211 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button53.kind;
      print(sio.button53.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button53.kind = testData1s;
      print(sio.button53.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button53.kind == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button53.kind == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button53.kind = testData2s;
      print(sio.button53.kind);
      expect(sio.button53.kind == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button53.kind == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button53.kind = defalut;
      print(sio.button53.kind);
      expect(sio.button53.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button53.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00235_element_check_00211 **********\n\n");
    });

    test('00236_element_check_00212', () async {
      print("\n********** テスト実行：00236_element_check_00212 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button53.section;
      print(sio.button53.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button53.section = testData1s;
      print(sio.button53.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button53.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button53.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button53.section = testData2s;
      print(sio.button53.section);
      expect(sio.button53.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button53.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button53.section = defalut;
      print(sio.button53.section);
      expect(sio.button53.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button53.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00236_element_check_00212 **********\n\n");
    });

    test('00237_element_check_00213', () async {
      print("\n********** テスト実行：00237_element_check_00213 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button53.type;
      print(sio.button53.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button53.type = testData1s;
      print(sio.button53.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button53.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button53.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button53.type = testData2s;
      print(sio.button53.type);
      expect(sio.button53.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button53.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button53.type = defalut;
      print(sio.button53.type);
      expect(sio.button53.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button53.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00237_element_check_00213 **********\n\n");
    });

    test('00238_element_check_00214', () async {
      print("\n********** テスト実行：00238_element_check_00214 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button54.title;
      print(sio.button54.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button54.title = testData1s;
      print(sio.button54.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button54.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button54.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button54.title = testData2s;
      print(sio.button54.title);
      expect(sio.button54.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button54.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button54.title = defalut;
      print(sio.button54.title);
      expect(sio.button54.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button54.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00238_element_check_00214 **********\n\n");
    });

    test('00239_element_check_00215', () async {
      print("\n********** テスト実行：00239_element_check_00215 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button54.kind;
      print(sio.button54.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button54.kind = testData1s;
      print(sio.button54.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button54.kind == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button54.kind == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button54.kind = testData2s;
      print(sio.button54.kind);
      expect(sio.button54.kind == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button54.kind == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button54.kind = defalut;
      print(sio.button54.kind);
      expect(sio.button54.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button54.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00239_element_check_00215 **********\n\n");
    });

    test('00240_element_check_00216', () async {
      print("\n********** テスト実行：00240_element_check_00216 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button54.section;
      print(sio.button54.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button54.section = testData1s;
      print(sio.button54.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button54.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button54.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button54.section = testData2s;
      print(sio.button54.section);
      expect(sio.button54.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button54.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button54.section = defalut;
      print(sio.button54.section);
      expect(sio.button54.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button54.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00240_element_check_00216 **********\n\n");
    });

    test('00241_element_check_00217', () async {
      print("\n********** テスト実行：00241_element_check_00217 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button54.type;
      print(sio.button54.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button54.type = testData1s;
      print(sio.button54.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button54.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button54.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button54.type = testData2s;
      print(sio.button54.type);
      expect(sio.button54.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button54.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button54.type = defalut;
      print(sio.button54.type);
      expect(sio.button54.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button54.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00241_element_check_00217 **********\n\n");
    });

    test('00242_element_check_00218', () async {
      print("\n********** テスト実行：00242_element_check_00218 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button_END.title;
      print(sio.button_END.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button_END.title = testData1s;
      print(sio.button_END.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button_END.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button_END.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button_END.title = testData2s;
      print(sio.button_END.title);
      expect(sio.button_END.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button_END.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button_END.title = defalut;
      print(sio.button_END.title);
      expect(sio.button_END.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button_END.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00242_element_check_00218 **********\n\n");
    });

    test('00243_element_check_00219', () async {
      print("\n********** テスト実行：00243_element_check_00219 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button_END.kind;
      print(sio.button_END.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button_END.kind = testData1s;
      print(sio.button_END.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button_END.kind == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button_END.kind == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button_END.kind = testData2s;
      print(sio.button_END.kind);
      expect(sio.button_END.kind == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button_END.kind == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button_END.kind = defalut;
      print(sio.button_END.kind);
      expect(sio.button_END.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button_END.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00243_element_check_00219 **********\n\n");
    });

    test('00244_element_check_00220', () async {
      print("\n********** テスト実行：00244_element_check_00220 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button_END.section;
      print(sio.button_END.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button_END.section = testData1s;
      print(sio.button_END.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button_END.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button_END.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button_END.section = testData2s;
      print(sio.button_END.section);
      expect(sio.button_END.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button_END.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button_END.section = defalut;
      print(sio.button_END.section);
      expect(sio.button_END.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button_END.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00244_element_check_00220 **********\n\n");
    });

    test('00245_element_check_00221', () async {
      print("\n********** テスト実行：00245_element_check_00221 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button_END.type;
      print(sio.button_END.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button_END.type = testData1s;
      print(sio.button_END.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button_END.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button_END.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button_END.type = testData2s;
      print(sio.button_END.type);
      expect(sio.button_END.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button_END.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button_END.type = defalut;
      print(sio.button_END.type);
      expect(sio.button_END.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button_END.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00245_element_check_00221 **********\n\n");
    });

    test('00246_element_check_00222', () async {
      print("\n********** テスト実行：00246_element_check_00222 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button_NEXT.title;
      print(sio.button_NEXT.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button_NEXT.title = testData1s;
      print(sio.button_NEXT.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button_NEXT.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button_NEXT.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button_NEXT.title = testData2s;
      print(sio.button_NEXT.title);
      expect(sio.button_NEXT.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button_NEXT.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button_NEXT.title = defalut;
      print(sio.button_NEXT.title);
      expect(sio.button_NEXT.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button_NEXT.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00246_element_check_00222 **********\n\n");
    });

    test('00247_element_check_00223', () async {
      print("\n********** テスト実行：00247_element_check_00223 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button_NEXT.kind;
      print(sio.button_NEXT.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button_NEXT.kind = testData1s;
      print(sio.button_NEXT.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button_NEXT.kind == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button_NEXT.kind == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button_NEXT.kind = testData2s;
      print(sio.button_NEXT.kind);
      expect(sio.button_NEXT.kind == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button_NEXT.kind == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button_NEXT.kind = defalut;
      print(sio.button_NEXT.kind);
      expect(sio.button_NEXT.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button_NEXT.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00247_element_check_00223 **********\n\n");
    });

    test('00248_element_check_00224', () async {
      print("\n********** テスト実行：00248_element_check_00224 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button_NEXT.section;
      print(sio.button_NEXT.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button_NEXT.section = testData1s;
      print(sio.button_NEXT.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button_NEXT.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button_NEXT.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button_NEXT.section = testData2s;
      print(sio.button_NEXT.section);
      expect(sio.button_NEXT.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button_NEXT.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button_NEXT.section = defalut;
      print(sio.button_NEXT.section);
      expect(sio.button_NEXT.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button_NEXT.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00248_element_check_00224 **********\n\n");
    });

    test('00249_element_check_00225', () async {
      print("\n********** テスト実行：00249_element_check_00225 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button_NEXT.type;
      print(sio.button_NEXT.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button_NEXT.type = testData1s;
      print(sio.button_NEXT.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button_NEXT.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button_NEXT.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button_NEXT.type = testData2s;
      print(sio.button_NEXT.type);
      expect(sio.button_NEXT.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button_NEXT.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button_NEXT.type = defalut;
      print(sio.button_NEXT.type);
      expect(sio.button_NEXT.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button_NEXT.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00249_element_check_00225 **********\n\n");
    });

    test('00250_element_check_00226', () async {
      print("\n********** テスト実行：00250_element_check_00226 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button_PREV.title;
      print(sio.button_PREV.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button_PREV.title = testData1s;
      print(sio.button_PREV.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button_PREV.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button_PREV.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button_PREV.title = testData2s;
      print(sio.button_PREV.title);
      expect(sio.button_PREV.title == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button_PREV.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button_PREV.title = defalut;
      print(sio.button_PREV.title);
      expect(sio.button_PREV.title == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button_PREV.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00250_element_check_00226 **********\n\n");
    });

    test('00251_element_check_00227', () async {
      print("\n********** テスト実行：00251_element_check_00227 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button_PREV.kind;
      print(sio.button_PREV.kind);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button_PREV.kind = testData1s;
      print(sio.button_PREV.kind);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button_PREV.kind == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button_PREV.kind == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button_PREV.kind = testData2s;
      print(sio.button_PREV.kind);
      expect(sio.button_PREV.kind == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button_PREV.kind == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button_PREV.kind = defalut;
      print(sio.button_PREV.kind);
      expect(sio.button_PREV.kind == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button_PREV.kind == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00251_element_check_00227 **********\n\n");
    });

    test('00252_element_check_00228', () async {
      print("\n********** テスト実行：00252_element_check_00228 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button_PREV.section;
      print(sio.button_PREV.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button_PREV.section = testData1s;
      print(sio.button_PREV.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button_PREV.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button_PREV.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button_PREV.section = testData2s;
      print(sio.button_PREV.section);
      expect(sio.button_PREV.section == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button_PREV.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button_PREV.section = defalut;
      print(sio.button_PREV.section);
      expect(sio.button_PREV.section == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button_PREV.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00252_element_check_00228 **********\n\n");
    });

    test('00253_element_check_00229', () async {
      print("\n********** テスト実行：00253_element_check_00229 **********");

      sio = SioJsonFile();
      allPropatyCheckInit(sio);

      // ①loadを実行する。
      await sio.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sio.button_PREV.type;
      print(sio.button_PREV.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      sio.button_PREV.type = testData1s;
      print(sio.button_PREV.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sio.button_PREV.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await sio.save();
      await sio.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sio.button_PREV.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sio.button_PREV.type = testData2s;
      print(sio.button_PREV.type);
      expect(sio.button_PREV.type == testData2s, true);
      await sio.save();
      await sio.load();
      expect(sio.button_PREV.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sio.button_PREV.type = defalut;
      print(sio.button_PREV.type);
      expect(sio.button_PREV.type == defalut, true);
      await sio.save();
      await sio.load();
      expect(sio.button_PREV.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sio, true);

      print("********** テスト終了：00253_element_check_00229 **********\n\n");
    });

  });
}

void allPropatyCheckInit(SioJsonFile test)
{
  expect(test.global.title, "");
  expect(test.button01.title, "");
  expect(test.button01.kind, "");
  expect(test.button01.section, "");
  expect(test.button01.type, "");
  expect(test.button02.title, "");
  expect(test.button02.kind, 0);
  expect(test.button02.section, "");
  expect(test.button02.type, "");
  expect(test.button03.title, "");
  expect(test.button03.kind, 0);
  expect(test.button03.section, "");
  expect(test.button03.type, "");
  expect(test.button04.title, "");
  expect(test.button04.kind, 0);
  expect(test.button04.section, "");
  expect(test.button04.type, "");
  expect(test.button05.title, "");
  expect(test.button05.kind, 0);
  expect(test.button05.section, "");
  expect(test.button05.type, "");
  expect(test.button06.title, "");
  expect(test.button06.kind, 0);
  expect(test.button06.section, "");
  expect(test.button06.type, "");
  expect(test.button07.title, "");
  expect(test.button07.kind, 0);
  expect(test.button07.section, "");
  expect(test.button07.type, "");
  expect(test.button08.title, "");
  expect(test.button08.kind, 0);
  expect(test.button08.section, "");
  expect(test.button08.type, "");
  expect(test.button09.title, "");
  expect(test.button09.kind, 0);
  expect(test.button09.section, "");
  expect(test.button09.type, "");
  expect(test.button10.title, "");
  expect(test.button10.kind, 0);
  expect(test.button10.section, "");
  expect(test.button10.type, "");
  expect(test.button11.title, "");
  expect(test.button11.kind, 0);
  expect(test.button11.section, "");
  expect(test.button11.type, "");
  expect(test.button12.title, "");
  expect(test.button12.kind, 0);
  expect(test.button12.section, "");
  expect(test.button12.type, "");
  expect(test.button13.title, "");
  expect(test.button13.kind, 0);
  expect(test.button13.section, "");
  expect(test.button13.type, "");
  expect(test.button14.title, "");
  expect(test.button14.kind, 0);
  expect(test.button14.section, "");
  expect(test.button14.type, "");
  expect(test.button15.title, "");
  expect(test.button15.kind, 0);
  expect(test.button15.section, "");
  expect(test.button15.type, "");
  expect(test.button16.title, "");
  expect(test.button16.kind, 0);
  expect(test.button16.section, "");
  expect(test.button16.type, "");
  expect(test.button17.title, "");
  expect(test.button17.kind, 0);
  expect(test.button17.section, "");
  expect(test.button17.type, "");
  expect(test.button18.title, "");
  expect(test.button18.kind, 0);
  expect(test.button18.section, "");
  expect(test.button18.type, "");
  expect(test.button19.title, "");
  expect(test.button19.kind, 0);
  expect(test.button19.section, "");
  expect(test.button19.type, "");
  expect(test.button20.title, "");
  expect(test.button20.kind, 0);
  expect(test.button20.section, "");
  expect(test.button20.type, "");
  expect(test.button21.title, "");
  expect(test.button21.kind, 0);
  expect(test.button21.section, "");
  expect(test.button21.type, "");
  expect(test.button22.title, "");
  expect(test.button22.kind, 0);
  expect(test.button22.section, "");
  expect(test.button22.type, "");
  expect(test.button23.title, "");
  expect(test.button23.kind, 0);
  expect(test.button23.section, "");
  expect(test.button23.type, "");
  expect(test.button24.title, "");
  expect(test.button24.kind, 0);
  expect(test.button24.section, "");
  expect(test.button24.type, "");
  expect(test.button25.title, "");
  expect(test.button25.kind, 0);
  expect(test.button25.section, "");
  expect(test.button25.type, "");
  expect(test.button26.title, "");
  expect(test.button26.kind, 0);
  expect(test.button26.section, "");
  expect(test.button26.type, "");
  expect(test.button27.title, "");
  expect(test.button27.kind, 0);
  expect(test.button27.section, "");
  expect(test.button27.type, "");
  expect(test.button28.title, "");
  expect(test.button28.kind, 0);
  expect(test.button28.section, "");
  expect(test.button28.type, "");
  expect(test.button29.title, "");
  expect(test.button29.kind, 0);
  expect(test.button29.section, "");
  expect(test.button29.type, "");
  expect(test.button30.title, "");
  expect(test.button30.kind, 0);
  expect(test.button30.section, "");
  expect(test.button30.type, "");
  expect(test.button31.title, "");
  expect(test.button31.kind, 0);
  expect(test.button31.section, "");
  expect(test.button31.type, "");
  expect(test.button32.title, "");
  expect(test.button32.kind, 0);
  expect(test.button32.section, "");
  expect(test.button32.type, "");
  expect(test.button33.title, "");
  expect(test.button33.kind, "");
  expect(test.button33.section, "");
  expect(test.button33.type, "");
  expect(test.button34.title, "");
  expect(test.button34.kind, 0);
  expect(test.button34.section, "");
  expect(test.button34.type, "");
  expect(test.button35.title, "");
  expect(test.button35.kind, 0);
  expect(test.button35.section, "");
  expect(test.button35.type, "");
  expect(test.button36.title, "");
  expect(test.button36.kind, 0);
  expect(test.button36.section, "");
  expect(test.button36.type, "");
  expect(test.button37.title, "");
  expect(test.button37.kind, 0);
  expect(test.button37.section, "");
  expect(test.button37.type, "");
  expect(test.button38.title, "");
  expect(test.button38.kind, 0);
  expect(test.button38.section, "");
  expect(test.button38.type, "");
  expect(test.button39.title, "");
  expect(test.button39.kind, 0);
  expect(test.button39.section, "");
  expect(test.button39.type, "");
  expect(test.button40.title, "");
  expect(test.button40.kind, 0);
  expect(test.button40.section, "");
  expect(test.button40.type, "");
  expect(test.button41.title, "");
  expect(test.button41.kind, 0);
  expect(test.button41.section, "");
  expect(test.button41.type, "");
  expect(test.button42.title, "");
  expect(test.button42.kind, 0);
  expect(test.button42.section, "");
  expect(test.button42.type, "");
  expect(test.button43.title, "");
  expect(test.button43.kind, 0);
  expect(test.button43.section, "");
  expect(test.button43.type, "");
  expect(test.button44.title, "");
  expect(test.button44.kind, 0);
  expect(test.button44.section, "");
  expect(test.button44.type, "");
  expect(test.button45.title, "");
  expect(test.button45.kind, 0);
  expect(test.button45.section, "");
  expect(test.button45.type, "");
  expect(test.button46.title, "");
  expect(test.button46.kind, 0);
  expect(test.button46.section, "");
  expect(test.button46.type, "");
  expect(test.button47.title, "");
  expect(test.button47.kind, 0);
  expect(test.button47.section, "");
  expect(test.button47.type, "");
  expect(test.button48.title, "");
  expect(test.button48.kind, 0);
  expect(test.button48.section, "");
  expect(test.button48.type, "");
  expect(test.button49.title, "");
  expect(test.button49.kind, 0);
  expect(test.button49.section, "");
  expect(test.button49.type, "");
  expect(test.button50.title, "");
  expect(test.button50.kind, 0);
  expect(test.button50.section, "");
  expect(test.button50.type, "");
  expect(test.button51.title, "");
  expect(test.button51.kind, 0);
  expect(test.button51.section, "");
  expect(test.button51.type, "");
  expect(test.button52.title, "");
  expect(test.button52.kind, "");
  expect(test.button52.section, "");
  expect(test.button52.type, "");
  expect(test.button53.title, "");
  expect(test.button53.kind, "");
  expect(test.button53.section, "");
  expect(test.button53.type, "");
  expect(test.button54.title, "");
  expect(test.button54.kind, "");
  expect(test.button54.section, "");
  expect(test.button54.type, "");
  expect(test.button_END.title, "");
  expect(test.button_END.kind, "");
  expect(test.button_END.section, "");
  expect(test.button_END.type, "");
  expect(test.button_NEXT.title, "");
  expect(test.button_NEXT.kind, "");
  expect(test.button_NEXT.section, "");
  expect(test.button_NEXT.type, "");
  expect(test.button_PREV.title, "");
  expect(test.button_PREV.kind, "");
  expect(test.button_PREV.section, "");
  expect(test.button_PREV.type, "");
}

void allPropatyCheck(SioJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.global.title, "接続機器一覧");
  }
  expect(test.button01.title, "使用せず");
  expect(test.button01.kind, "");
  expect(test.button01.section, "");
  expect(test.button01.type, "NORMAL");
  expect(test.button02.title, "音声合成装置(HD AIVoice)");
  expect(test.button02.kind, 14);
  expect(test.button02.section, "aiv");
  expect(test.button02.type, "NORMAL");
  expect(test.button03.title, "皿勘定(DENSO)");
  expect(test.button03.kind, 13);
  expect(test.button03.section, "dish");
  expect(test.button03.type, "NORMAL");
  expect(test.button04.title, "伝票プリンタ(TM-U210B)");
  expect(test.button04.kind, 8);
  expect(test.button04.section, "stpr");
  expect(test.button04.type, "NORMAL");
  expect(test.button05.title, "秤");
  expect(test.button05.kind, 5);
  expect(test.button05.section, "scale");
  expect(test.button05.type, "NORMAL");
  expect(test.button06.title, "2ｽﾃｰｼｮﾝﾌﾟﾘﾝﾀ");
  expect(test.button06.kind, 11);
  expect(test.button06.section, "s2pr");
  expect(test.button06.type, "NORMAL");
  expect(test.button07.title, "GP-460RC");
  expect(test.button07.kind, 9);
  expect(test.button07.section, "gp");
  expect(test.button07.type, "NORMAL");
  expect(test.button08.title, "無線LAN再起動");
  expect(test.button08.kind, 12);
  expect(test.button08.section, "pwrctrl");
  expect(test.button08.type, "NORMAL");
  expect(test.button09.title, "Yomoca");
  expect(test.button09.kind, 17);
  expect(test.button09.section, "yomoca");
  expect(test.button09.type, "NORMAL");
  expect(test.button10.title, "自動釣銭機");
  expect(test.button10.kind, 2);
  expect(test.button10.section, "acr");
  expect(test.button10.type, "NORMAL");
  expect(test.button11.title, "釣銭釣札機");
  expect(test.button11.kind, 2);
  expect(test.button11.section, "acb");
  expect(test.button11.type, "NORMAL");
  expect(test.button12.title, "ACR-40+RAD-S1 or ACB-20");
  expect(test.button12.kind, 2);
  expect(test.button12.section, "acb20");
  expect(test.button12.type, "NORMAL");
  expect(test.button13.title, "釣銭釣札機(ACB-50)");
  expect(test.button13.kind, 2);
  expect(test.button13.section, "acb50");
  expect(test.button13.type, "NORMAL");
  expect(test.button14.title, "カード決済機");
  expect(test.button14.kind, 15);
  expect(test.button14.section, "gcat_cnct");
  expect(test.button14.type, "NORMAL");
  expect(test.button15.title, "ｸﾞﾛｰﾘｰPSP-70C");
  expect(test.button15.kind, 3);
  expect(test.button15.section, "psp70");
  expect(test.button15.type, "NORMAL");
  expect(test.button16.title, "ﾘﾗｲﾄｶｰﾄﾞ  R/W");
  expect(test.button16.kind, 3);
  expect(test.button16.section, "rewrite");
  expect(test.button16.type, "NORMAL");
  expect(test.button17.title, "ﾋﾞｽﾏｯｸ");
  expect(test.button17.kind, 3);
  expect(test.button17.section, "vismac");
  expect(test.button17.type, "NORMAL");
  expect(test.button18.title, "沖製ﾘﾗｲﾄｶｰﾄﾞ");
  expect(test.button18.kind, 3);
  expect(test.button18.section, "orc");
  expect(test.button18.type, "NORMAL");
  expect(test.button19.title, "ｸﾞﾛｰﾘｰPSP-60P");
  expect(test.button19.kind, 3);
  expect(test.button19.section, "psp60");
  expect(test.button19.type, "NORMAL");
  expect(test.button20.title, "ﾊﾟﾅｺｰﾄﾞ R/W");
  expect(test.button20.kind, 3);
  expect(test.button20.section, "pana");
  expect(test.button20.type, "NORMAL");
  expect(test.button21.title, "ＰＷ４１０");
  expect(test.button21.kind, 3);
  expect(test.button21.section, "pw410");
  expect(test.button21.type, "NORMAL");
  expect(test.button22.title, "ﾊﾟﾅｿﾆｯｸG-CAT");
  expect(test.button22.kind, 15);
  expect(test.button22.section, "gcat");
  expect(test.button22.type, "NORMAL");
  expect(test.button23.title, "Edy(SIPｼﾘｰｽﾞ)");
  expect(test.button23.kind, 4);
  expect(test.button23.section, "sip60");
  expect(test.button23.type, "NORMAL");
  expect(test.button24.title, "CCR");
  expect(test.button24.kind, 4);
  expect(test.button24.section, "ccr");
  expect(test.button24.type, "NORMAL");
  expect(test.button25.title, "ｾﾙﾌｼｽﾃﾑ秤1");
  expect(test.button25.kind, 6);
  expect(test.button25.section, "sm_scale1");
  expect(test.button25.type, "NORMAL");
  expect(test.button26.title, "ｾﾙﾌｼｽﾃﾑ秤2");
  expect(test.button26.kind, 7);
  expect(test.button26.section, "sm_scale2");
  expect(test.button26.type, "NORMAL");
  expect(test.button27.title, "ｾﾙﾌｼｽﾃﾑ秤");
  expect(test.button27.kind, 10);
  expect(test.button27.section, "sm_scalesc");
  expect(test.button27.type, "NORMAL");
  expect(test.button28.title, "スキャナ");
  expect(test.button28.kind, 16);
  expect(test.button28.section, "scan_plus_1");
  expect(test.button28.type, "NORMAL");
  expect(test.button29.title, "RFIDﾀｸﾞﾘｰﾀﾞﾗｲﾀ");
  expect(test.button29.kind, 19);
  expect(test.button29.section, "rfid");
  expect(test.button29.type, "NORMAL");
  expect(test.button30.title, "音声合成装置(AR-STTS-01)");
  expect(test.button30.kind, 14);
  expect(test.button30.section, "ar_stts_01");
  expect(test.button30.type, "NORMAL");
  expect(test.button31.title, "MCP200");
  expect(test.button31.kind, 3);
  expect(test.button31.section, "MCP200");
  expect(test.button31.type, "NORMAL");
  expect(test.button32.title, "スキャナ2");
  expect(test.button32.kind, 21);
  expect(test.button32.section, "scan_plus_2");
  expect(test.button32.type, "NORMAL");
  expect(test.button33.title, "");
  expect(test.button33.kind, "");
  expect(test.button33.section, "");
  expect(test.button33.type, "NORMAL");
  expect(test.button34.title, "Smartplus");
  expect(test.button34.kind, 15);
  expect(test.button34.section, "smtplus");
  expect(test.button34.type, "NORMAL");
  expect(test.button35.title, "FCLｼﾘｰｽﾞ");
  expect(test.button35.kind, 20);
  expect(test.button35.section, "fcl");
  expect(test.button35.type, "NORMAL");
  expect(test.button36.title, "JREM(NCRｼﾘｰｽﾞ)");
  expect(test.button36.kind, 22);
  expect(test.button36.section, "jrw_multi");
  expect(test.button36.type, "NORMAL");
  expect(test.button37.title, "Suica");
  expect(test.button37.kind, 18);
  expect(test.button37.section, "suica");
  expect(test.button37.type, "NORMAL");
  expect(test.button38.title, "皿勘定(ﾀｶﾔ)");
  expect(test.button38.kind, 13);
  expect(test.button38.section, "disht");
  expect(test.button38.type, "NORMAL");
  expect(test.button39.title, "日立ブルーチップ");
  expect(test.button39.kind, 3);
  expect(test.button39.section, "ht2980");
  expect(test.button39.type, "NORMAL");
  expect(test.button40.title, "ABS-V31");
  expect(test.button40.kind, 3);
  expect(test.button40.section, "absv31");
  expect(test.button40.type, "NORMAL");
  expect(test.button41.title, "スキャナ2");
  expect(test.button41.kind, 21);
  expect(test.button41.section, "scan_2800ip_2");
  expect(test.button41.type, "NORMAL");
  expect(test.button42.title, "ﾔﾏﾄ電子ﾏﾈｰ端末");
  expect(test.button42.kind, 4);
  expect(test.button42.section, "yamato");
  expect(test.button42.type, "NORMAL");
  expect(test.button43.title, "CCT決済端末");
  expect(test.button43.kind, 15);
  expect(test.button43.section, "cct");
  expect(test.button43.type, "NORMAL");
  expect(test.button44.title, "自走式磁気カードリーダー");
  expect(test.button44.kind, 23);
  expect(test.button44.section, "masr");
  expect(test.button44.type, "NORMAL");
  expect(test.button45.title, "J-Mups決済端末");
  expect(test.button45.kind, 15);
  expect(test.button45.section, "jmups");
  expect(test.button45.type, "NORMAL");
  expect(test.button46.title, "釣銭釣札機(FAL2)");
  expect(test.button46.kind, 2);
  expect(test.button46.section, "fal2");
  expect(test.button46.type, "NORMAL");
  expect(test.button47.title, "MST決済端末");
  expect(test.button47.kind, 4);
  expect(test.button47.section, "mst");
  expect(test.button47.type, "NORMAL");
  expect(test.button48.title, "VEGA");
  expect(test.button48.kind, 24);
  expect(test.button48.section, "vega3000");
  expect(test.button48.type, "NORMAL");
  expect(test.button49.title, "CASTLES");
  expect(test.button49.kind, 15);
  expect(test.button49.section, "castles");
  expect(test.button49.type, "NORMAL");
  expect(test.button50.title, "PCT決済端末");
  expect(test.button50.kind, 25);
  expect(test.button50.section, "pct");
  expect(test.button50.type, "NORMAL");
  expect(test.button51.title, "重量センサー");
  expect(test.button51.kind, 26);
  expect(test.button51.section, "scale_sks");
  expect(test.button51.type, "NORMAL");
  expect(test.button52.title, "");
  expect(test.button52.kind, "");
  expect(test.button52.section, "");
  expect(test.button52.type, "NORMAL");
  expect(test.button53.title, "");
  expect(test.button53.kind, "");
  expect(test.button53.section, "");
  expect(test.button53.type, "NORMAL");
  expect(test.button54.title, "");
  expect(test.button54.kind, "");
  expect(test.button54.section, "");
  expect(test.button54.type, "NORMAL");
  expect(test.button_END.title, "終了");
  expect(test.button_END.kind, "");
  expect(test.button_END.section, "");
  expect(test.button_END.type, "END");
  expect(test.button_NEXT.title, "次頁");
  expect(test.button_NEXT.kind, "");
  expect(test.button_NEXT.section, "");
  expect(test.button_NEXT.type, "NEXTP");
  expect(test.button_PREV.title, "前頁");
  expect(test.button_PREV.kind, "");
  expect(test.button_PREV.section, "");
  expect(test.button_PREV.type, "PREVP");
}

