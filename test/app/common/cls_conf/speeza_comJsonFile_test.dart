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
import '../../../../lib/app/common/cls_conf/speeza_comJsonFile.dart';

late Speeza_comJsonFile speeza_com;

void main(){
  speeza_comJsonFile_test();
}

void speeza_comJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "speeza_com.json";
  const String section = "QcSelect";
  const String key = "ChangeAmountType";
  const defaultData = 0;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Speeza_comJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Speeza_comJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Speeza_comJsonFile().setDefault();
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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await speeza_com.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(speeza_com,true);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        speeza_com.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await speeza_com.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(speeza_com,true);

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
      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①：loadを実行する。
      await speeza_com.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = speeza_com.QcSelect.ChangeAmountType;
      speeza_com.QcSelect.ChangeAmountType = testData1;
      expect(speeza_com.QcSelect.ChangeAmountType == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await speeza_com.load();
      expect(speeza_com.QcSelect.ChangeAmountType != testData1, true);
      expect(speeza_com.QcSelect.ChangeAmountType == prefixData, true);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = speeza_com.QcSelect.ChangeAmountType;
      speeza_com.QcSelect.ChangeAmountType = testData1;
      expect(speeza_com.QcSelect.ChangeAmountType, testData1);

      // ③saveを実行する。
      await speeza_com.save();

      // ④loadを実行する。
      await speeza_com.load();

      expect(speeza_com.QcSelect.ChangeAmountType != prefixData, true);
      expect(speeza_com.QcSelect.ChangeAmountType == testData1, true);
      allPropatyCheck(speeza_com,false);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await speeza_com.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await speeza_com.save();

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await speeza_com.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(speeza_com.QcSelect.ChangeAmountType, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = speeza_com.QcSelect.ChangeAmountType;
      speeza_com.QcSelect.ChangeAmountType = testData1;

      // ③ saveを実行する。
      await speeza_com.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(speeza_com.QcSelect.ChangeAmountType, testData1);

      // ④ loadを実行する。
      await speeza_com.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(speeza_com.QcSelect.ChangeAmountType == testData1, true);
      allPropatyCheck(speeza_com,false);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await speeza_com.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(speeza_com,true);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②任意のプロパティの値を変更する。
      speeza_com.QcSelect.ChangeAmountType = testData1;
      expect(speeza_com.QcSelect.ChangeAmountType, testData1);

      // ③saveを実行する。
      await speeza_com.save();
      expect(speeza_com.QcSelect.ChangeAmountType, testData1);

      // ④loadを実行する。
      await speeza_com.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(speeza_com,true);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await speeza_com.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await speeza_com.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(speeza_com.QcSelect.ChangeAmountType == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await speeza_com.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await speeza_com.setValueWithName(section, "test_key", testData1);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②任意のプロパティを変更する。
      speeza_com.QcSelect.ChangeAmountType = testData1;

      // ③saveを実行する。
      await speeza_com.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await speeza_com.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②任意のプロパティを変更する。
      speeza_com.QcSelect.ChangeAmountType = testData1;

      // ③saveを実行する。
      await speeza_com.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await speeza_com.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②任意のプロパティを変更する。
      speeza_com.QcSelect.ChangeAmountType = testData1;

      // ③saveを実行する。
      await speeza_com.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await speeza_com.getValueWithName(section, "test_key");
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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await speeza_com.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      speeza_com.QcSelect.ChangeAmountType = testData1;
      expect(speeza_com.QcSelect.ChangeAmountType, testData1);

      // ④saveを実行する。
      await speeza_com.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(speeza_com.QcSelect.ChangeAmountType, testData1);
      
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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await speeza_com.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + speeza_com.QcSelect.ChangeAmountType.toString());
      expect(speeza_com.QcSelect.ChangeAmountType == testData1, true);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await speeza_com.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + speeza_com.QcSelect.ChangeAmountType.toString());
      expect(speeza_com.QcSelect.ChangeAmountType == testData2, true);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await speeza_com.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + speeza_com.QcSelect.ChangeAmountType.toString());
      expect(speeza_com.QcSelect.ChangeAmountType == testData1, true);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await speeza_com.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + speeza_com.QcSelect.ChangeAmountType.toString());
      expect(speeza_com.QcSelect.ChangeAmountType == testData2, true);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await speeza_com.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + speeza_com.QcSelect.ChangeAmountType.toString());
      expect(speeza_com.QcSelect.ChangeAmountType == testData1, true);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await speeza_com.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + speeza_com.QcSelect.ChangeAmountType.toString());
      expect(speeza_com.QcSelect.ChangeAmountType == testData1, true);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await speeza_com.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + speeza_com.QcSelect.ChangeAmountType.toString());
      allPropatyCheck(speeza_com,true);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await speeza_com.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + speeza_com.QcSelect.ChangeAmountType.toString());
      allPropatyCheck(speeza_com,true);

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

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.QcSelect.ChangeAmountType;
      print(speeza_com.QcSelect.ChangeAmountType);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.QcSelect.ChangeAmountType = testData1;
      print(speeza_com.QcSelect.ChangeAmountType);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.QcSelect.ChangeAmountType == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.QcSelect.ChangeAmountType == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.QcSelect.ChangeAmountType = testData2;
      print(speeza_com.QcSelect.ChangeAmountType);
      expect(speeza_com.QcSelect.ChangeAmountType == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.ChangeAmountType == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.QcSelect.ChangeAmountType = defalut;
      print(speeza_com.QcSelect.ChangeAmountType);
      expect(speeza_com.QcSelect.ChangeAmountType == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.ChangeAmountType == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.QcSelect.PopUpType;
      print(speeza_com.QcSelect.PopUpType);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.QcSelect.PopUpType = testData1;
      print(speeza_com.QcSelect.PopUpType);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.QcSelect.PopUpType == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.QcSelect.PopUpType == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.QcSelect.PopUpType = testData2;
      print(speeza_com.QcSelect.PopUpType);
      expect(speeza_com.QcSelect.PopUpType == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.PopUpType == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.QcSelect.PopUpType = defalut;
      print(speeza_com.QcSelect.PopUpType);
      expect(speeza_com.QcSelect.PopUpType == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.PopUpType == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.QcSelect.CautionType;
      print(speeza_com.QcSelect.CautionType);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.QcSelect.CautionType = testData1;
      print(speeza_com.QcSelect.CautionType);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.QcSelect.CautionType == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.QcSelect.CautionType == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.QcSelect.CautionType = testData2;
      print(speeza_com.QcSelect.CautionType);
      expect(speeza_com.QcSelect.CautionType == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.CautionType == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.QcSelect.CautionType = defalut;
      print(speeza_com.QcSelect.CautionType);
      expect(speeza_com.QcSelect.CautionType == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.CautionType == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.QcSelect.QCSel_Rpr_ItemPrn;
      print(speeza_com.QcSelect.QCSel_Rpr_ItemPrn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.QcSelect.QCSel_Rpr_ItemPrn = testData1;
      print(speeza_com.QcSelect.QCSel_Rpr_ItemPrn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.QcSelect.QCSel_Rpr_ItemPrn == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.QcSelect.QCSel_Rpr_ItemPrn == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.QcSelect.QCSel_Rpr_ItemPrn = testData2;
      print(speeza_com.QcSelect.QCSel_Rpr_ItemPrn);
      expect(speeza_com.QcSelect.QCSel_Rpr_ItemPrn == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.QCSel_Rpr_ItemPrn == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.QcSelect.QCSel_Rpr_ItemPrn = defalut;
      print(speeza_com.QcSelect.QCSel_Rpr_ItemPrn);
      expect(speeza_com.QcSelect.QCSel_Rpr_ItemPrn == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.QCSel_Rpr_ItemPrn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.QcSelect.Stl_Pushed_Expand;
      print(speeza_com.QcSelect.Stl_Pushed_Expand);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.QcSelect.Stl_Pushed_Expand = testData1;
      print(speeza_com.QcSelect.Stl_Pushed_Expand);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.QcSelect.Stl_Pushed_Expand == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.QcSelect.Stl_Pushed_Expand == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.QcSelect.Stl_Pushed_Expand = testData2;
      print(speeza_com.QcSelect.Stl_Pushed_Expand);
      expect(speeza_com.QcSelect.Stl_Pushed_Expand == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.Stl_Pushed_Expand == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.QcSelect.Stl_Pushed_Expand = defalut;
      print(speeza_com.QcSelect.Stl_Pushed_Expand);
      expect(speeza_com.QcSelect.Stl_Pushed_Expand == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.Stl_Pushed_Expand == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.QcSelect.ChaTranSpeezaUpd;
      print(speeza_com.QcSelect.ChaTranSpeezaUpd);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.QcSelect.ChaTranSpeezaUpd = testData1;
      print(speeza_com.QcSelect.ChaTranSpeezaUpd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.QcSelect.ChaTranSpeezaUpd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.QcSelect.ChaTranSpeezaUpd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.QcSelect.ChaTranSpeezaUpd = testData2;
      print(speeza_com.QcSelect.ChaTranSpeezaUpd);
      expect(speeza_com.QcSelect.ChaTranSpeezaUpd == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.ChaTranSpeezaUpd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.QcSelect.ChaTranSpeezaUpd = defalut;
      print(speeza_com.QcSelect.ChaTranSpeezaUpd);
      expect(speeza_com.QcSelect.ChaTranSpeezaUpd == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.ChaTranSpeezaUpd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.QcSelect.Disp_Preca_Bal_Sht;
      print(speeza_com.QcSelect.Disp_Preca_Bal_Sht);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.QcSelect.Disp_Preca_Bal_Sht = testData1;
      print(speeza_com.QcSelect.Disp_Preca_Bal_Sht);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.QcSelect.Disp_Preca_Bal_Sht == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.QcSelect.Disp_Preca_Bal_Sht == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.QcSelect.Disp_Preca_Bal_Sht = testData2;
      print(speeza_com.QcSelect.Disp_Preca_Bal_Sht);
      expect(speeza_com.QcSelect.Disp_Preca_Bal_Sht == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.Disp_Preca_Bal_Sht == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.QcSelect.Disp_Preca_Bal_Sht = defalut;
      print(speeza_com.QcSelect.Disp_Preca_Bal_Sht);
      expect(speeza_com.QcSelect.Disp_Preca_Bal_Sht == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.QcSelect.Disp_Preca_Bal_Sht == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusMenu.Message;
      print(speeza_com.StatusMenu.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusMenu.Message = testData1s;
      print(speeza_com.StatusMenu.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusMenu.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusMenu.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusMenu.Message = testData2s;
      print(speeza_com.StatusMenu.Message);
      expect(speeza_com.StatusMenu.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusMenu.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusMenu.Message = defalut;
      print(speeza_com.StatusMenu.Message);
      expect(speeza_com.StatusMenu.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusMenu.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusMenu.BackColor;
      print(speeza_com.StatusMenu.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusMenu.BackColor = testData1;
      print(speeza_com.StatusMenu.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusMenu.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusMenu.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusMenu.BackColor = testData2;
      print(speeza_com.StatusMenu.BackColor);
      expect(speeza_com.StatusMenu.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusMenu.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusMenu.BackColor = defalut;
      print(speeza_com.StatusMenu.BackColor);
      expect(speeza_com.StatusMenu.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusMenu.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusMenu.TextColor;
      print(speeza_com.StatusMenu.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusMenu.TextColor = testData1;
      print(speeza_com.StatusMenu.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusMenu.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusMenu.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusMenu.TextColor = testData2;
      print(speeza_com.StatusMenu.TextColor);
      expect(speeza_com.StatusMenu.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusMenu.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusMenu.TextColor = defalut;
      print(speeza_com.StatusMenu.TextColor);
      expect(speeza_com.StatusMenu.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusMenu.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusWait.Message;
      print(speeza_com.StatusWait.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusWait.Message = testData1s;
      print(speeza_com.StatusWait.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusWait.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusWait.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusWait.Message = testData2s;
      print(speeza_com.StatusWait.Message);
      expect(speeza_com.StatusWait.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusWait.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusWait.Message = defalut;
      print(speeza_com.StatusWait.Message);
      expect(speeza_com.StatusWait.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusWait.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusWait.BackColor;
      print(speeza_com.StatusWait.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusWait.BackColor = testData1;
      print(speeza_com.StatusWait.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusWait.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusWait.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusWait.BackColor = testData2;
      print(speeza_com.StatusWait.BackColor);
      expect(speeza_com.StatusWait.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusWait.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusWait.BackColor = defalut;
      print(speeza_com.StatusWait.BackColor);
      expect(speeza_com.StatusWait.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusWait.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusWait.TextColor;
      print(speeza_com.StatusWait.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusWait.TextColor = testData1;
      print(speeza_com.StatusWait.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusWait.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusWait.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusWait.TextColor = testData2;
      print(speeza_com.StatusWait.TextColor);
      expect(speeza_com.StatusWait.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusWait.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusWait.TextColor = defalut;
      print(speeza_com.StatusWait.TextColor);
      expect(speeza_com.StatusWait.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusWait.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusActive.Message;
      print(speeza_com.StatusActive.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusActive.Message = testData1s;
      print(speeza_com.StatusActive.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusActive.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusActive.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusActive.Message = testData2s;
      print(speeza_com.StatusActive.Message);
      expect(speeza_com.StatusActive.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusActive.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusActive.Message = defalut;
      print(speeza_com.StatusActive.Message);
      expect(speeza_com.StatusActive.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusActive.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusActive.BackColor;
      print(speeza_com.StatusActive.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusActive.BackColor = testData1;
      print(speeza_com.StatusActive.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusActive.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusActive.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusActive.BackColor = testData2;
      print(speeza_com.StatusActive.BackColor);
      expect(speeza_com.StatusActive.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusActive.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusActive.BackColor = defalut;
      print(speeza_com.StatusActive.BackColor);
      expect(speeza_com.StatusActive.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusActive.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusActive.TextColor;
      print(speeza_com.StatusActive.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusActive.TextColor = testData1;
      print(speeza_com.StatusActive.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusActive.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusActive.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusActive.TextColor = testData2;
      print(speeza_com.StatusActive.TextColor);
      expect(speeza_com.StatusActive.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusActive.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusActive.TextColor = defalut;
      print(speeza_com.StatusActive.TextColor);
      expect(speeza_com.StatusActive.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusActive.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusCall.Message;
      print(speeza_com.StatusCall.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusCall.Message = testData1s;
      print(speeza_com.StatusCall.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusCall.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusCall.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusCall.Message = testData2s;
      print(speeza_com.StatusCall.Message);
      expect(speeza_com.StatusCall.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCall.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusCall.Message = defalut;
      print(speeza_com.StatusCall.Message);
      expect(speeza_com.StatusCall.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCall.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusCall.BackColor;
      print(speeza_com.StatusCall.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusCall.BackColor = testData1;
      print(speeza_com.StatusCall.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusCall.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusCall.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusCall.BackColor = testData2;
      print(speeza_com.StatusCall.BackColor);
      expect(speeza_com.StatusCall.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCall.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusCall.BackColor = defalut;
      print(speeza_com.StatusCall.BackColor);
      expect(speeza_com.StatusCall.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCall.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusCall.TextColor;
      print(speeza_com.StatusCall.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusCall.TextColor = testData1;
      print(speeza_com.StatusCall.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusCall.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusCall.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusCall.TextColor = testData2;
      print(speeza_com.StatusCall.TextColor);
      expect(speeza_com.StatusCall.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCall.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusCall.TextColor = defalut;
      print(speeza_com.StatusCall.TextColor);
      expect(speeza_com.StatusCall.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCall.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusOffline.Message;
      print(speeza_com.StatusOffline.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusOffline.Message = testData1s;
      print(speeza_com.StatusOffline.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusOffline.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusOffline.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusOffline.Message = testData2s;
      print(speeza_com.StatusOffline.Message);
      expect(speeza_com.StatusOffline.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusOffline.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusOffline.Message = defalut;
      print(speeza_com.StatusOffline.Message);
      expect(speeza_com.StatusOffline.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusOffline.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusOffline.BackColor;
      print(speeza_com.StatusOffline.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusOffline.BackColor = testData1;
      print(speeza_com.StatusOffline.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusOffline.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusOffline.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusOffline.BackColor = testData2;
      print(speeza_com.StatusOffline.BackColor);
      expect(speeza_com.StatusOffline.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusOffline.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusOffline.BackColor = defalut;
      print(speeza_com.StatusOffline.BackColor);
      expect(speeza_com.StatusOffline.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusOffline.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusOffline.TextColor;
      print(speeza_com.StatusOffline.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusOffline.TextColor = testData1;
      print(speeza_com.StatusOffline.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusOffline.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusOffline.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusOffline.TextColor = testData2;
      print(speeza_com.StatusOffline.TextColor);
      expect(speeza_com.StatusOffline.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusOffline.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusOffline.TextColor = defalut;
      print(speeza_com.StatusOffline.TextColor);
      expect(speeza_com.StatusOffline.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusOffline.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusAnotherActive.Message;
      print(speeza_com.StatusAnotherActive.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusAnotherActive.Message = testData1s;
      print(speeza_com.StatusAnotherActive.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusAnotherActive.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusAnotherActive.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusAnotherActive.Message = testData2s;
      print(speeza_com.StatusAnotherActive.Message);
      expect(speeza_com.StatusAnotherActive.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusAnotherActive.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusAnotherActive.Message = defalut;
      print(speeza_com.StatusAnotherActive.Message);
      expect(speeza_com.StatusAnotherActive.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusAnotherActive.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusAnotherActive.BackColor;
      print(speeza_com.StatusAnotherActive.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusAnotherActive.BackColor = testData1;
      print(speeza_com.StatusAnotherActive.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusAnotherActive.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusAnotherActive.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusAnotherActive.BackColor = testData2;
      print(speeza_com.StatusAnotherActive.BackColor);
      expect(speeza_com.StatusAnotherActive.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusAnotherActive.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusAnotherActive.BackColor = defalut;
      print(speeza_com.StatusAnotherActive.BackColor);
      expect(speeza_com.StatusAnotherActive.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusAnotherActive.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusAnotherActive.TextColor;
      print(speeza_com.StatusAnotherActive.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusAnotherActive.TextColor = testData1;
      print(speeza_com.StatusAnotherActive.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusAnotherActive.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusAnotherActive.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusAnotherActive.TextColor = testData2;
      print(speeza_com.StatusAnotherActive.TextColor);
      expect(speeza_com.StatusAnotherActive.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusAnotherActive.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusAnotherActive.TextColor = defalut;
      print(speeza_com.StatusAnotherActive.TextColor);
      expect(speeza_com.StatusAnotherActive.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusAnotherActive.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusMente.Message;
      print(speeza_com.StatusMente.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusMente.Message = testData1s;
      print(speeza_com.StatusMente.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusMente.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusMente.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusMente.Message = testData2s;
      print(speeza_com.StatusMente.Message);
      expect(speeza_com.StatusMente.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusMente.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusMente.Message = defalut;
      print(speeza_com.StatusMente.Message);
      expect(speeza_com.StatusMente.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusMente.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusMente.BackColor;
      print(speeza_com.StatusMente.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusMente.BackColor = testData1;
      print(speeza_com.StatusMente.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusMente.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusMente.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusMente.BackColor = testData2;
      print(speeza_com.StatusMente.BackColor);
      expect(speeza_com.StatusMente.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusMente.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusMente.BackColor = defalut;
      print(speeza_com.StatusMente.BackColor);
      expect(speeza_com.StatusMente.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusMente.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusMente.TextColor;
      print(speeza_com.StatusMente.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusMente.TextColor = testData1;
      print(speeza_com.StatusMente.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusMente.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusMente.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusMente.TextColor = testData2;
      print(speeza_com.StatusMente.TextColor);
      expect(speeza_com.StatusMente.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusMente.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusMente.TextColor = defalut;
      print(speeza_com.StatusMente.TextColor);
      expect(speeza_com.StatusMente.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusMente.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusCreateMax.Message;
      print(speeza_com.StatusCreateMax.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusCreateMax.Message = testData1s;
      print(speeza_com.StatusCreateMax.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusCreateMax.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusCreateMax.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusCreateMax.Message = testData2s;
      print(speeza_com.StatusCreateMax.Message);
      expect(speeza_com.StatusCreateMax.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCreateMax.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusCreateMax.Message = defalut;
      print(speeza_com.StatusCreateMax.Message);
      expect(speeza_com.StatusCreateMax.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCreateMax.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusCreateMax.BackColor;
      print(speeza_com.StatusCreateMax.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusCreateMax.BackColor = testData1;
      print(speeza_com.StatusCreateMax.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusCreateMax.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusCreateMax.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusCreateMax.BackColor = testData2;
      print(speeza_com.StatusCreateMax.BackColor);
      expect(speeza_com.StatusCreateMax.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCreateMax.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusCreateMax.BackColor = defalut;
      print(speeza_com.StatusCreateMax.BackColor);
      expect(speeza_com.StatusCreateMax.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCreateMax.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusCreateMax.TextColor;
      print(speeza_com.StatusCreateMax.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusCreateMax.TextColor = testData1;
      print(speeza_com.StatusCreateMax.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusCreateMax.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusCreateMax.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusCreateMax.TextColor = testData2;
      print(speeza_com.StatusCreateMax.TextColor);
      expect(speeza_com.StatusCreateMax.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCreateMax.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusCreateMax.TextColor = defalut;
      print(speeza_com.StatusCreateMax.TextColor);
      expect(speeza_com.StatusCreateMax.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCreateMax.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusPause.Message;
      print(speeza_com.StatusPause.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusPause.Message = testData1s;
      print(speeza_com.StatusPause.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusPause.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusPause.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusPause.Message = testData2s;
      print(speeza_com.StatusPause.Message);
      expect(speeza_com.StatusPause.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPause.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusPause.Message = defalut;
      print(speeza_com.StatusPause.Message);
      expect(speeza_com.StatusPause.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPause.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusPause.BackColor;
      print(speeza_com.StatusPause.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusPause.BackColor = testData1;
      print(speeza_com.StatusPause.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusPause.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusPause.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusPause.BackColor = testData2;
      print(speeza_com.StatusPause.BackColor);
      expect(speeza_com.StatusPause.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPause.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusPause.BackColor = defalut;
      print(speeza_com.StatusPause.BackColor);
      expect(speeza_com.StatusPause.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPause.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusPause.TextColor;
      print(speeza_com.StatusPause.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusPause.TextColor = testData1;
      print(speeza_com.StatusPause.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusPause.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusPause.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusPause.TextColor = testData2;
      print(speeza_com.StatusPause.TextColor);
      expect(speeza_com.StatusPause.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPause.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusPause.TextColor = defalut;
      print(speeza_com.StatusPause.TextColor);
      expect(speeza_com.StatusPause.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPause.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusPrecaBalSht.Message;
      print(speeza_com.StatusPrecaBalSht.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusPrecaBalSht.Message = testData1s;
      print(speeza_com.StatusPrecaBalSht.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusPrecaBalSht.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusPrecaBalSht.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusPrecaBalSht.Message = testData2s;
      print(speeza_com.StatusPrecaBalSht.Message);
      expect(speeza_com.StatusPrecaBalSht.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPrecaBalSht.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusPrecaBalSht.Message = defalut;
      print(speeza_com.StatusPrecaBalSht.Message);
      expect(speeza_com.StatusPrecaBalSht.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPrecaBalSht.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusPrecaBalSht.BackColor;
      print(speeza_com.StatusPrecaBalSht.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusPrecaBalSht.BackColor = testData1;
      print(speeza_com.StatusPrecaBalSht.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusPrecaBalSht.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusPrecaBalSht.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusPrecaBalSht.BackColor = testData2;
      print(speeza_com.StatusPrecaBalSht.BackColor);
      expect(speeza_com.StatusPrecaBalSht.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPrecaBalSht.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusPrecaBalSht.BackColor = defalut;
      print(speeza_com.StatusPrecaBalSht.BackColor);
      expect(speeza_com.StatusPrecaBalSht.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPrecaBalSht.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusPrecaBalSht.TextColor;
      print(speeza_com.StatusPrecaBalSht.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusPrecaBalSht.TextColor = testData1;
      print(speeza_com.StatusPrecaBalSht.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusPrecaBalSht.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusPrecaBalSht.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusPrecaBalSht.TextColor = testData2;
      print(speeza_com.StatusPrecaBalSht.TextColor);
      expect(speeza_com.StatusPrecaBalSht.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPrecaBalSht.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusPrecaBalSht.TextColor = defalut;
      print(speeza_com.StatusPrecaBalSht.TextColor);
      expect(speeza_com.StatusPrecaBalSht.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPrecaBalSht.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusPrecaChg.Message;
      print(speeza_com.StatusPrecaChg.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusPrecaChg.Message = testData1s;
      print(speeza_com.StatusPrecaChg.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusPrecaChg.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusPrecaChg.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusPrecaChg.Message = testData2s;
      print(speeza_com.StatusPrecaChg.Message);
      expect(speeza_com.StatusPrecaChg.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPrecaChg.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusPrecaChg.Message = defalut;
      print(speeza_com.StatusPrecaChg.Message);
      expect(speeza_com.StatusPrecaChg.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPrecaChg.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusPrecaChg.BackColor;
      print(speeza_com.StatusPrecaChg.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusPrecaChg.BackColor = testData1;
      print(speeza_com.StatusPrecaChg.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusPrecaChg.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusPrecaChg.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusPrecaChg.BackColor = testData2;
      print(speeza_com.StatusPrecaChg.BackColor);
      expect(speeza_com.StatusPrecaChg.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPrecaChg.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusPrecaChg.BackColor = defalut;
      print(speeza_com.StatusPrecaChg.BackColor);
      expect(speeza_com.StatusPrecaChg.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPrecaChg.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusPrecaChg.TextColor;
      print(speeza_com.StatusPrecaChg.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusPrecaChg.TextColor = testData1;
      print(speeza_com.StatusPrecaChg.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusPrecaChg.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusPrecaChg.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusPrecaChg.TextColor = testData2;
      print(speeza_com.StatusPrecaChg.TextColor);
      expect(speeza_com.StatusPrecaChg.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPrecaChg.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusPrecaChg.TextColor = defalut;
      print(speeza_com.StatusPrecaChg.TextColor);
      expect(speeza_com.StatusPrecaChg.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusPrecaChg.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusCoinFullRecover.Message;
      print(speeza_com.StatusCoinFullRecover.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusCoinFullRecover.Message = testData1s;
      print(speeza_com.StatusCoinFullRecover.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusCoinFullRecover.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusCoinFullRecover.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusCoinFullRecover.Message = testData2s;
      print(speeza_com.StatusCoinFullRecover.Message);
      expect(speeza_com.StatusCoinFullRecover.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCoinFullRecover.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusCoinFullRecover.Message = defalut;
      print(speeza_com.StatusCoinFullRecover.Message);
      expect(speeza_com.StatusCoinFullRecover.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCoinFullRecover.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusCoinFullRecover.BackColor;
      print(speeza_com.StatusCoinFullRecover.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusCoinFullRecover.BackColor = testData1;
      print(speeza_com.StatusCoinFullRecover.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusCoinFullRecover.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusCoinFullRecover.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusCoinFullRecover.BackColor = testData2;
      print(speeza_com.StatusCoinFullRecover.BackColor);
      expect(speeza_com.StatusCoinFullRecover.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCoinFullRecover.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusCoinFullRecover.BackColor = defalut;
      print(speeza_com.StatusCoinFullRecover.BackColor);
      expect(speeza_com.StatusCoinFullRecover.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCoinFullRecover.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusCoinFullRecover.TextColor;
      print(speeza_com.StatusCoinFullRecover.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusCoinFullRecover.TextColor = testData1;
      print(speeza_com.StatusCoinFullRecover.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusCoinFullRecover.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusCoinFullRecover.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusCoinFullRecover.TextColor = testData2;
      print(speeza_com.StatusCoinFullRecover.TextColor);
      expect(speeza_com.StatusCoinFullRecover.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCoinFullRecover.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusCoinFullRecover.TextColor = defalut;
      print(speeza_com.StatusCoinFullRecover.TextColor);
      expect(speeza_com.StatusCoinFullRecover.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusCoinFullRecover.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.StatusTerminal.return_time;
      print(speeza_com.StatusTerminal.return_time);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.StatusTerminal.return_time = testData1;
      print(speeza_com.StatusTerminal.return_time);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.StatusTerminal.return_time == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.StatusTerminal.return_time == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.StatusTerminal.return_time = testData2;
      print(speeza_com.StatusTerminal.return_time);
      expect(speeza_com.StatusTerminal.return_time == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusTerminal.return_time == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.StatusTerminal.return_time = defalut;
      print(speeza_com.StatusTerminal.return_time);
      expect(speeza_com.StatusTerminal.return_time == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.StatusTerminal.return_time == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionNormal.Message;
      print(speeza_com.CautionNormal.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionNormal.Message = testData1s;
      print(speeza_com.CautionNormal.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionNormal.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionNormal.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionNormal.Message = testData2s;
      print(speeza_com.CautionNormal.Message);
      expect(speeza_com.CautionNormal.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionNormal.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionNormal.Message = defalut;
      print(speeza_com.CautionNormal.Message);
      expect(speeza_com.CautionNormal.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionNormal.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionNormal.BackColor;
      print(speeza_com.CautionNormal.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionNormal.BackColor = testData1;
      print(speeza_com.CautionNormal.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionNormal.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionNormal.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionNormal.BackColor = testData2;
      print(speeza_com.CautionNormal.BackColor);
      expect(speeza_com.CautionNormal.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionNormal.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionNormal.BackColor = defalut;
      print(speeza_com.CautionNormal.BackColor);
      expect(speeza_com.CautionNormal.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionNormal.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionNormal.TextColor;
      print(speeza_com.CautionNormal.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionNormal.TextColor = testData1;
      print(speeza_com.CautionNormal.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionNormal.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionNormal.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionNormal.TextColor = testData2;
      print(speeza_com.CautionNormal.TextColor);
      expect(speeza_com.CautionNormal.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionNormal.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionNormal.TextColor = defalut;
      print(speeza_com.CautionNormal.TextColor);
      expect(speeza_com.CautionNormal.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionNormal.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionAcxErr.Message;
      print(speeza_com.CautionAcxErr.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionAcxErr.Message = testData1s;
      print(speeza_com.CautionAcxErr.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionAcxErr.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionAcxErr.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionAcxErr.Message = testData2s;
      print(speeza_com.CautionAcxErr.Message);
      expect(speeza_com.CautionAcxErr.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxErr.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionAcxErr.Message = defalut;
      print(speeza_com.CautionAcxErr.Message);
      expect(speeza_com.CautionAcxErr.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxErr.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionAcxErr.BackColor;
      print(speeza_com.CautionAcxErr.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionAcxErr.BackColor = testData1;
      print(speeza_com.CautionAcxErr.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionAcxErr.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionAcxErr.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionAcxErr.BackColor = testData2;
      print(speeza_com.CautionAcxErr.BackColor);
      expect(speeza_com.CautionAcxErr.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxErr.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionAcxErr.BackColor = defalut;
      print(speeza_com.CautionAcxErr.BackColor);
      expect(speeza_com.CautionAcxErr.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxErr.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionAcxErr.TextColor;
      print(speeza_com.CautionAcxErr.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionAcxErr.TextColor = testData1;
      print(speeza_com.CautionAcxErr.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionAcxErr.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionAcxErr.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionAcxErr.TextColor = testData2;
      print(speeza_com.CautionAcxErr.TextColor);
      expect(speeza_com.CautionAcxErr.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxErr.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionAcxErr.TextColor = defalut;
      print(speeza_com.CautionAcxErr.TextColor);
      expect(speeza_com.CautionAcxErr.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxErr.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionAcxEnd.Message;
      print(speeza_com.CautionAcxEnd.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionAcxEnd.Message = testData1s;
      print(speeza_com.CautionAcxEnd.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionAcxEnd.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionAcxEnd.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionAcxEnd.Message = testData2s;
      print(speeza_com.CautionAcxEnd.Message);
      expect(speeza_com.CautionAcxEnd.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxEnd.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionAcxEnd.Message = defalut;
      print(speeza_com.CautionAcxEnd.Message);
      expect(speeza_com.CautionAcxEnd.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxEnd.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionAcxEnd.BackColor;
      print(speeza_com.CautionAcxEnd.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionAcxEnd.BackColor = testData1;
      print(speeza_com.CautionAcxEnd.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionAcxEnd.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionAcxEnd.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionAcxEnd.BackColor = testData2;
      print(speeza_com.CautionAcxEnd.BackColor);
      expect(speeza_com.CautionAcxEnd.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxEnd.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionAcxEnd.BackColor = defalut;
      print(speeza_com.CautionAcxEnd.BackColor);
      expect(speeza_com.CautionAcxEnd.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxEnd.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionAcxEnd.TextColor;
      print(speeza_com.CautionAcxEnd.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionAcxEnd.TextColor = testData1;
      print(speeza_com.CautionAcxEnd.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionAcxEnd.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionAcxEnd.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionAcxEnd.TextColor = testData2;
      print(speeza_com.CautionAcxEnd.TextColor);
      expect(speeza_com.CautionAcxEnd.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxEnd.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionAcxEnd.TextColor = defalut;
      print(speeza_com.CautionAcxEnd.TextColor);
      expect(speeza_com.CautionAcxEnd.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxEnd.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionAcxFull.Message;
      print(speeza_com.CautionAcxFull.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionAcxFull.Message = testData1s;
      print(speeza_com.CautionAcxFull.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionAcxFull.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionAcxFull.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionAcxFull.Message = testData2s;
      print(speeza_com.CautionAcxFull.Message);
      expect(speeza_com.CautionAcxFull.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxFull.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionAcxFull.Message = defalut;
      print(speeza_com.CautionAcxFull.Message);
      expect(speeza_com.CautionAcxFull.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxFull.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionAcxFull.BackColor;
      print(speeza_com.CautionAcxFull.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionAcxFull.BackColor = testData1;
      print(speeza_com.CautionAcxFull.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionAcxFull.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionAcxFull.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionAcxFull.BackColor = testData2;
      print(speeza_com.CautionAcxFull.BackColor);
      expect(speeza_com.CautionAcxFull.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxFull.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionAcxFull.BackColor = defalut;
      print(speeza_com.CautionAcxFull.BackColor);
      expect(speeza_com.CautionAcxFull.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxFull.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionAcxFull.TextColor;
      print(speeza_com.CautionAcxFull.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionAcxFull.TextColor = testData1;
      print(speeza_com.CautionAcxFull.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionAcxFull.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionAcxFull.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionAcxFull.TextColor = testData2;
      print(speeza_com.CautionAcxFull.TextColor);
      expect(speeza_com.CautionAcxFull.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxFull.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionAcxFull.TextColor = defalut;
      print(speeza_com.CautionAcxFull.TextColor);
      expect(speeza_com.CautionAcxFull.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionAcxFull.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionRcptEnd.Message;
      print(speeza_com.CautionRcptEnd.Message);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionRcptEnd.Message = testData1s;
      print(speeza_com.CautionRcptEnd.Message);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionRcptEnd.Message == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionRcptEnd.Message == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionRcptEnd.Message = testData2s;
      print(speeza_com.CautionRcptEnd.Message);
      expect(speeza_com.CautionRcptEnd.Message == testData2s, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionRcptEnd.Message == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionRcptEnd.Message = defalut;
      print(speeza_com.CautionRcptEnd.Message);
      expect(speeza_com.CautionRcptEnd.Message == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionRcptEnd.Message == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionRcptEnd.BackColor;
      print(speeza_com.CautionRcptEnd.BackColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionRcptEnd.BackColor = testData1;
      print(speeza_com.CautionRcptEnd.BackColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionRcptEnd.BackColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionRcptEnd.BackColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionRcptEnd.BackColor = testData2;
      print(speeza_com.CautionRcptEnd.BackColor);
      expect(speeza_com.CautionRcptEnd.BackColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionRcptEnd.BackColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionRcptEnd.BackColor = defalut;
      print(speeza_com.CautionRcptEnd.BackColor);
      expect(speeza_com.CautionRcptEnd.BackColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionRcptEnd.BackColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      speeza_com = Speeza_comJsonFile();
      allPropatyCheckInit(speeza_com);

      // ①loadを実行する。
      await speeza_com.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_com.CautionRcptEnd.TextColor;
      print(speeza_com.CautionRcptEnd.TextColor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_com.CautionRcptEnd.TextColor = testData1;
      print(speeza_com.CautionRcptEnd.TextColor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_com.CautionRcptEnd.TextColor == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_com.save();
      await speeza_com.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_com.CautionRcptEnd.TextColor == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_com.CautionRcptEnd.TextColor = testData2;
      print(speeza_com.CautionRcptEnd.TextColor);
      expect(speeza_com.CautionRcptEnd.TextColor == testData2, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionRcptEnd.TextColor == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_com.CautionRcptEnd.TextColor = defalut;
      print(speeza_com.CautionRcptEnd.TextColor);
      expect(speeza_com.CautionRcptEnd.TextColor == defalut, true);
      await speeza_com.save();
      await speeza_com.load();
      expect(speeza_com.CautionRcptEnd.TextColor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_com, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Speeza_comJsonFile test)
{
  expect(test.QcSelect.ChangeAmountType, 0);
  expect(test.QcSelect.PopUpType, 0);
  expect(test.QcSelect.CautionType, 0);
  expect(test.QcSelect.QCSel_Rpr_ItemPrn, 0);
  expect(test.QcSelect.Stl_Pushed_Expand, 0);
  expect(test.QcSelect.ChaTranSpeezaUpd, 0);
  expect(test.QcSelect.Disp_Preca_Bal_Sht, 0);
  expect(test.StatusMenu.Message, "");
  expect(test.StatusMenu.BackColor, 0);
  expect(test.StatusMenu.TextColor, 0);
  expect(test.StatusWait.Message, "");
  expect(test.StatusWait.BackColor, 0);
  expect(test.StatusWait.TextColor, 0);
  expect(test.StatusActive.Message, "");
  expect(test.StatusActive.BackColor, 0);
  expect(test.StatusActive.TextColor, 0);
  expect(test.StatusCall.Message, "");
  expect(test.StatusCall.BackColor, 0);
  expect(test.StatusCall.TextColor, 0);
  expect(test.StatusOffline.Message, "");
  expect(test.StatusOffline.BackColor, 0);
  expect(test.StatusOffline.TextColor, 0);
  expect(test.StatusAnotherActive.Message, "");
  expect(test.StatusAnotherActive.BackColor, 0);
  expect(test.StatusAnotherActive.TextColor, 0);
  expect(test.StatusMente.Message, "");
  expect(test.StatusMente.BackColor, 0);
  expect(test.StatusMente.TextColor, 0);
  expect(test.StatusCreateMax.Message, "");
  expect(test.StatusCreateMax.BackColor, 0);
  expect(test.StatusCreateMax.TextColor, 0);
  expect(test.StatusPause.Message, "");
  expect(test.StatusPause.BackColor, 0);
  expect(test.StatusPause.TextColor, 0);
  expect(test.StatusPrecaBalSht.Message, "");
  expect(test.StatusPrecaBalSht.BackColor, 0);
  expect(test.StatusPrecaBalSht.TextColor, 0);
  expect(test.StatusPrecaChg.Message, "");
  expect(test.StatusPrecaChg.BackColor, 0);
  expect(test.StatusPrecaChg.TextColor, 0);
  expect(test.StatusCoinFullRecover.Message, "");
  expect(test.StatusCoinFullRecover.BackColor, 0);
  expect(test.StatusCoinFullRecover.TextColor, 0);
  expect(test.StatusTerminal.return_time, 0);
  expect(test.CautionNormal.Message, "");
  expect(test.CautionNormal.BackColor, 0);
  expect(test.CautionNormal.TextColor, 0);
  expect(test.CautionAcxErr.Message, "");
  expect(test.CautionAcxErr.BackColor, 0);
  expect(test.CautionAcxErr.TextColor, 0);
  expect(test.CautionAcxEnd.Message, "");
  expect(test.CautionAcxEnd.BackColor, 0);
  expect(test.CautionAcxEnd.TextColor, 0);
  expect(test.CautionAcxFull.Message, "");
  expect(test.CautionAcxFull.BackColor, 0);
  expect(test.CautionAcxFull.TextColor, 0);
  expect(test.CautionRcptEnd.Message, "");
  expect(test.CautionRcptEnd.BackColor, 0);
  expect(test.CautionRcptEnd.TextColor, 0);
}

void allPropatyCheck(Speeza_comJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.QcSelect.ChangeAmountType, 0);
  }
  expect(test.QcSelect.PopUpType, 0);
  expect(test.QcSelect.CautionType, 0);
  expect(test.QcSelect.QCSel_Rpr_ItemPrn, 0);
  expect(test.QcSelect.Stl_Pushed_Expand, 0);
  expect(test.QcSelect.ChaTranSpeezaUpd, 0);
  expect(test.QcSelect.Disp_Preca_Bal_Sht, 0);
  expect(test.StatusMenu.Message, "ﾒﾆｭｰ");
  expect(test.StatusMenu.BackColor, 44);
  expect(test.StatusMenu.TextColor, 23);
  expect(test.StatusWait.Message, "待機");
  expect(test.StatusWait.BackColor, 44);
  expect(test.StatusWait.TextColor, 23);
  expect(test.StatusActive.Message, "使用中");
  expect(test.StatusActive.BackColor, 44);
  expect(test.StatusActive.TextColor, 23);
  expect(test.StatusCall.Message, "CALL");
  expect(test.StatusCall.BackColor, 44);
  expect(test.StatusCall.TextColor, 23);
  expect(test.StatusOffline.Message, "ｵﾌﾗｲﾝ");
  expect(test.StatusOffline.BackColor, 44);
  expect(test.StatusOffline.TextColor, 23);
  expect(test.StatusAnotherActive.Message, "使用中");
  expect(test.StatusAnotherActive.BackColor, 44);
  expect(test.StatusAnotherActive.TextColor, 23);
  expect(test.StatusMente.Message, "ﾒﾝﾃﾅﾝｽ");
  expect(test.StatusMente.BackColor, 44);
  expect(test.StatusMente.TextColor, 23);
  expect(test.StatusCreateMax.Message, "使用中");
  expect(test.StatusCreateMax.BackColor, 44);
  expect(test.StatusCreateMax.TextColor, 23);
  expect(test.StatusPause.Message, "休止");
  expect(test.StatusPause.BackColor, 44);
  expect(test.StatusPause.TextColor, 23);
  expect(test.StatusPrecaBalSht.Message, "残高不足");
  expect(test.StatusPrecaBalSht.BackColor, 44);
  expect(test.StatusPrecaBalSht.TextColor, 23);
  expect(test.StatusPrecaChg.Message, "ﾁｬｰｼﾞ中");
  expect(test.StatusPrecaChg.BackColor, 44);
  expect(test.StatusPrecaChg.TextColor, 23);
  expect(test.StatusCoinFullRecover.Message, "ﾌﾙ解除");
  expect(test.StatusCoinFullRecover.BackColor, 44);
  expect(test.StatusCoinFullRecover.TextColor, 23);
  expect(test.StatusTerminal.return_time, 2);
  expect(test.CautionNormal.Message, "");
  expect(test.CautionNormal.BackColor, 35);
  expect(test.CautionNormal.TextColor, 15);
  expect(test.CautionAcxErr.Message, "釣機ｴﾗｰ");
  expect(test.CautionAcxErr.BackColor, 35);
  expect(test.CautionAcxErr.TextColor, 15);
  expect(test.CautionAcxEnd.Message, "お釣不足");
  expect(test.CautionAcxEnd.BackColor, 35);
  expect(test.CautionAcxEnd.TextColor, 15);
  expect(test.CautionAcxFull.Message, "お釣過剰");
  expect(test.CautionAcxFull.BackColor, 35);
  expect(test.CautionAcxFull.TextColor, 15);
  expect(test.CautionRcptEnd.Message, "ﾚｼｰﾄ交換");
  expect(test.CautionRcptEnd.BackColor, 35);
  expect(test.CautionRcptEnd.TextColor, 15);
}

