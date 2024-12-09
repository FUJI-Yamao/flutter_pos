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
import '../../../../lib/app/common/cls_conf/pmouse_2800_3JsonFile.dart';

late Pmouse_2800_3JsonFile pmouse_2800_3;

void main(){
  pmouse_2800_3JsonFile_test();
}

void pmouse_2800_3JsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "pmouse_2800_3.json";
  const String section = "settings";
  const String key = "dmcno";
  const defaultData = 2;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Pmouse_2800_3JsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Pmouse_2800_3JsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Pmouse_2800_3JsonFile().setDefault();
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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await pmouse_2800_3.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(pmouse_2800_3,true);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        pmouse_2800_3.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await pmouse_2800_3.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(pmouse_2800_3,true);

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
      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①：loadを実行する。
      await pmouse_2800_3.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = pmouse_2800_3.settings.dmcno;
      pmouse_2800_3.settings.dmcno = testData1;
      expect(pmouse_2800_3.settings.dmcno == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.dmcno != testData1, true);
      expect(pmouse_2800_3.settings.dmcno == prefixData, true);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = pmouse_2800_3.settings.dmcno;
      pmouse_2800_3.settings.dmcno = testData1;
      expect(pmouse_2800_3.settings.dmcno, testData1);

      // ③saveを実行する。
      await pmouse_2800_3.save();

      // ④loadを実行する。
      await pmouse_2800_3.load();

      expect(pmouse_2800_3.settings.dmcno != prefixData, true);
      expect(pmouse_2800_3.settings.dmcno == testData1, true);
      allPropatyCheck(pmouse_2800_3,false);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await pmouse_2800_3.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await pmouse_2800_3.save();

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await pmouse_2800_3.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(pmouse_2800_3.settings.dmcno, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = pmouse_2800_3.settings.dmcno;
      pmouse_2800_3.settings.dmcno = testData1;

      // ③ saveを実行する。
      await pmouse_2800_3.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(pmouse_2800_3.settings.dmcno, testData1);

      // ④ loadを実行する。
      await pmouse_2800_3.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(pmouse_2800_3.settings.dmcno == testData1, true);
      allPropatyCheck(pmouse_2800_3,false);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await pmouse_2800_3.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(pmouse_2800_3,true);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②任意のプロパティの値を変更する。
      pmouse_2800_3.settings.dmcno = testData1;
      expect(pmouse_2800_3.settings.dmcno, testData1);

      // ③saveを実行する。
      await pmouse_2800_3.save();
      expect(pmouse_2800_3.settings.dmcno, testData1);

      // ④loadを実行する。
      await pmouse_2800_3.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(pmouse_2800_3,true);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await pmouse_2800_3.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await pmouse_2800_3.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(pmouse_2800_3.settings.dmcno == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await pmouse_2800_3.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await pmouse_2800_3.setValueWithName(section, "test_key", testData1);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②任意のプロパティを変更する。
      pmouse_2800_3.settings.dmcno = testData1;

      // ③saveを実行する。
      await pmouse_2800_3.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await pmouse_2800_3.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②任意のプロパティを変更する。
      pmouse_2800_3.settings.dmcno = testData1;

      // ③saveを実行する。
      await pmouse_2800_3.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await pmouse_2800_3.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②任意のプロパティを変更する。
      pmouse_2800_3.settings.dmcno = testData1;

      // ③saveを実行する。
      await pmouse_2800_3.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await pmouse_2800_3.getValueWithName(section, "test_key");
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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await pmouse_2800_3.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      pmouse_2800_3.settings.dmcno = testData1;
      expect(pmouse_2800_3.settings.dmcno, testData1);

      // ④saveを実行する。
      await pmouse_2800_3.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(pmouse_2800_3.settings.dmcno, testData1);
      
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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await pmouse_2800_3.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + pmouse_2800_3.settings.dmcno.toString());
      expect(pmouse_2800_3.settings.dmcno == testData1, true);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await pmouse_2800_3.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + pmouse_2800_3.settings.dmcno.toString());
      expect(pmouse_2800_3.settings.dmcno == testData2, true);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await pmouse_2800_3.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + pmouse_2800_3.settings.dmcno.toString());
      expect(pmouse_2800_3.settings.dmcno == testData1, true);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await pmouse_2800_3.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + pmouse_2800_3.settings.dmcno.toString());
      expect(pmouse_2800_3.settings.dmcno == testData2, true);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await pmouse_2800_3.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + pmouse_2800_3.settings.dmcno.toString());
      expect(pmouse_2800_3.settings.dmcno == testData1, true);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await pmouse_2800_3.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + pmouse_2800_3.settings.dmcno.toString());
      expect(pmouse_2800_3.settings.dmcno == testData1, true);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await pmouse_2800_3.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + pmouse_2800_3.settings.dmcno.toString());
      allPropatyCheck(pmouse_2800_3,true);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await pmouse_2800_3.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + pmouse_2800_3.settings.dmcno.toString());
      allPropatyCheck(pmouse_2800_3,true);

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

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pmouse_2800_3.settings.dmcno;
      print(pmouse_2800_3.settings.dmcno);

      // ②指定したプロパティにテストデータ1を書き込む。
      pmouse_2800_3.settings.dmcno = testData1;
      print(pmouse_2800_3.settings.dmcno);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pmouse_2800_3.settings.dmcno == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pmouse_2800_3.settings.dmcno == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pmouse_2800_3.settings.dmcno = testData2;
      print(pmouse_2800_3.settings.dmcno);
      expect(pmouse_2800_3.settings.dmcno == testData2, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.dmcno == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pmouse_2800_3.settings.dmcno = defalut;
      print(pmouse_2800_3.settings.dmcno);
      expect(pmouse_2800_3.settings.dmcno == defalut, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.dmcno == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pmouse_2800_3, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pmouse_2800_3.settings.reso_x;
      print(pmouse_2800_3.settings.reso_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      pmouse_2800_3.settings.reso_x = testData1;
      print(pmouse_2800_3.settings.reso_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pmouse_2800_3.settings.reso_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pmouse_2800_3.settings.reso_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pmouse_2800_3.settings.reso_x = testData2;
      print(pmouse_2800_3.settings.reso_x);
      expect(pmouse_2800_3.settings.reso_x == testData2, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.reso_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pmouse_2800_3.settings.reso_x = defalut;
      print(pmouse_2800_3.settings.reso_x);
      expect(pmouse_2800_3.settings.reso_x == defalut, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.reso_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pmouse_2800_3, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pmouse_2800_3.settings.reso_y;
      print(pmouse_2800_3.settings.reso_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      pmouse_2800_3.settings.reso_y = testData1;
      print(pmouse_2800_3.settings.reso_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pmouse_2800_3.settings.reso_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pmouse_2800_3.settings.reso_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pmouse_2800_3.settings.reso_y = testData2;
      print(pmouse_2800_3.settings.reso_y);
      expect(pmouse_2800_3.settings.reso_y == testData2, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.reso_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pmouse_2800_3.settings.reso_y = defalut;
      print(pmouse_2800_3.settings.reso_y);
      expect(pmouse_2800_3.settings.reso_y == defalut, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.reso_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pmouse_2800_3, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pmouse_2800_3.settings.x1;
      print(pmouse_2800_3.settings.x1);

      // ②指定したプロパティにテストデータ1を書き込む。
      pmouse_2800_3.settings.x1 = testData1;
      print(pmouse_2800_3.settings.x1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pmouse_2800_3.settings.x1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pmouse_2800_3.settings.x1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pmouse_2800_3.settings.x1 = testData2;
      print(pmouse_2800_3.settings.x1);
      expect(pmouse_2800_3.settings.x1 == testData2, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.x1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pmouse_2800_3.settings.x1 = defalut;
      print(pmouse_2800_3.settings.x1);
      expect(pmouse_2800_3.settings.x1 == defalut, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.x1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pmouse_2800_3, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pmouse_2800_3.settings.y1;
      print(pmouse_2800_3.settings.y1);

      // ②指定したプロパティにテストデータ1を書き込む。
      pmouse_2800_3.settings.y1 = testData1;
      print(pmouse_2800_3.settings.y1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pmouse_2800_3.settings.y1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pmouse_2800_3.settings.y1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pmouse_2800_3.settings.y1 = testData2;
      print(pmouse_2800_3.settings.y1);
      expect(pmouse_2800_3.settings.y1 == testData2, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.y1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pmouse_2800_3.settings.y1 = defalut;
      print(pmouse_2800_3.settings.y1);
      expect(pmouse_2800_3.settings.y1 == defalut, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.y1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pmouse_2800_3, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pmouse_2800_3.settings.x2;
      print(pmouse_2800_3.settings.x2);

      // ②指定したプロパティにテストデータ1を書き込む。
      pmouse_2800_3.settings.x2 = testData1;
      print(pmouse_2800_3.settings.x2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pmouse_2800_3.settings.x2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pmouse_2800_3.settings.x2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pmouse_2800_3.settings.x2 = testData2;
      print(pmouse_2800_3.settings.x2);
      expect(pmouse_2800_3.settings.x2 == testData2, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.x2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pmouse_2800_3.settings.x2 = defalut;
      print(pmouse_2800_3.settings.x2);
      expect(pmouse_2800_3.settings.x2 == defalut, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.x2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pmouse_2800_3, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pmouse_2800_3.settings.y2;
      print(pmouse_2800_3.settings.y2);

      // ②指定したプロパティにテストデータ1を書き込む。
      pmouse_2800_3.settings.y2 = testData1;
      print(pmouse_2800_3.settings.y2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pmouse_2800_3.settings.y2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pmouse_2800_3.settings.y2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pmouse_2800_3.settings.y2 = testData2;
      print(pmouse_2800_3.settings.y2);
      expect(pmouse_2800_3.settings.y2 == testData2, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.y2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pmouse_2800_3.settings.y2 = defalut;
      print(pmouse_2800_3.settings.y2);
      expect(pmouse_2800_3.settings.y2 == defalut, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.y2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pmouse_2800_3, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pmouse_2800_3.settings.x3;
      print(pmouse_2800_3.settings.x3);

      // ②指定したプロパティにテストデータ1を書き込む。
      pmouse_2800_3.settings.x3 = testData1;
      print(pmouse_2800_3.settings.x3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pmouse_2800_3.settings.x3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pmouse_2800_3.settings.x3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pmouse_2800_3.settings.x3 = testData2;
      print(pmouse_2800_3.settings.x3);
      expect(pmouse_2800_3.settings.x3 == testData2, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.x3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pmouse_2800_3.settings.x3 = defalut;
      print(pmouse_2800_3.settings.x3);
      expect(pmouse_2800_3.settings.x3 == defalut, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.x3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pmouse_2800_3, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pmouse_2800_3.settings.y3;
      print(pmouse_2800_3.settings.y3);

      // ②指定したプロパティにテストデータ1を書き込む。
      pmouse_2800_3.settings.y3 = testData1;
      print(pmouse_2800_3.settings.y3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pmouse_2800_3.settings.y3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pmouse_2800_3.settings.y3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pmouse_2800_3.settings.y3 = testData2;
      print(pmouse_2800_3.settings.y3);
      expect(pmouse_2800_3.settings.y3 == testData2, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.y3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pmouse_2800_3.settings.y3 = defalut;
      print(pmouse_2800_3.settings.y3);
      expect(pmouse_2800_3.settings.y3 == defalut, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.y3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pmouse_2800_3, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pmouse_2800_3.settings.x4;
      print(pmouse_2800_3.settings.x4);

      // ②指定したプロパティにテストデータ1を書き込む。
      pmouse_2800_3.settings.x4 = testData1;
      print(pmouse_2800_3.settings.x4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pmouse_2800_3.settings.x4 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pmouse_2800_3.settings.x4 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pmouse_2800_3.settings.x4 = testData2;
      print(pmouse_2800_3.settings.x4);
      expect(pmouse_2800_3.settings.x4 == testData2, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.x4 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pmouse_2800_3.settings.x4 = defalut;
      print(pmouse_2800_3.settings.x4);
      expect(pmouse_2800_3.settings.x4 == defalut, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.x4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pmouse_2800_3, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      pmouse_2800_3 = Pmouse_2800_3JsonFile();
      allPropatyCheckInit(pmouse_2800_3);

      // ①loadを実行する。
      await pmouse_2800_3.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pmouse_2800_3.settings.y4;
      print(pmouse_2800_3.settings.y4);

      // ②指定したプロパティにテストデータ1を書き込む。
      pmouse_2800_3.settings.y4 = testData1;
      print(pmouse_2800_3.settings.y4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pmouse_2800_3.settings.y4 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pmouse_2800_3.settings.y4 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pmouse_2800_3.settings.y4 = testData2;
      print(pmouse_2800_3.settings.y4);
      expect(pmouse_2800_3.settings.y4 == testData2, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.y4 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pmouse_2800_3.settings.y4 = defalut;
      print(pmouse_2800_3.settings.y4);
      expect(pmouse_2800_3.settings.y4 == defalut, true);
      await pmouse_2800_3.save();
      await pmouse_2800_3.load();
      expect(pmouse_2800_3.settings.y4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pmouse_2800_3, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Pmouse_2800_3JsonFile test)
{
  expect(test.settings.dmcno, 0);
  expect(test.settings.reso_x, 0);
  expect(test.settings.reso_y, 0);
  expect(test.settings.x1, 0);
  expect(test.settings.y1, 0);
  expect(test.settings.x2, 0);
  expect(test.settings.y2, 0);
  expect(test.settings.x3, 0);
  expect(test.settings.y3, 0);
  expect(test.settings.x4, 0);
  expect(test.settings.y4, 0);
}

void allPropatyCheck(Pmouse_2800_3JsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.settings.dmcno, 2);
  }
  expect(test.settings.reso_x, 800);
  expect(test.settings.reso_y, 480);
  expect(test.settings.x1, 90);
  expect(test.settings.y1, 29);
  expect(test.settings.x2, 952);
  expect(test.settings.y2, 43);
  expect(test.settings.x3, 71);
  expect(test.settings.y3, 983);
  expect(test.settings.x4, 955);
  expect(test.settings.y4, 975);
}

