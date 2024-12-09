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
import '../../../../lib/app/common/cls_conf/specificftpJsonFile.dart';

late SpecificftpJsonFile specificftp;

void main(){
  specificftpJsonFile_test();
}

void specificftpJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/aa/";
  const String testDir = "test_assets";
  const String fileName = "specificftp.json";
  const String section = "ja_system";
  const String key = "jano";
  const defaultData = 1;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('SpecificftpJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await SpecificftpJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await SpecificftpJsonFile().setDefault();
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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await specificftp.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(specificftp,true);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        specificftp.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await specificftp.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(specificftp,true);

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
      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①：loadを実行する。
      await specificftp.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = specificftp.ja_system.jano;
      specificftp.ja_system.jano = testData1;
      expect(specificftp.ja_system.jano == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await specificftp.load();
      expect(specificftp.ja_system.jano != testData1, true);
      expect(specificftp.ja_system.jano == prefixData, true);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = specificftp.ja_system.jano;
      specificftp.ja_system.jano = testData1;
      expect(specificftp.ja_system.jano, testData1);

      // ③saveを実行する。
      await specificftp.save();

      // ④loadを実行する。
      await specificftp.load();

      expect(specificftp.ja_system.jano != prefixData, true);
      expect(specificftp.ja_system.jano == testData1, true);
      allPropatyCheck(specificftp,false);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await specificftp.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await specificftp.save();

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await specificftp.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(specificftp.ja_system.jano, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = specificftp.ja_system.jano;
      specificftp.ja_system.jano = testData1;

      // ③ saveを実行する。
      await specificftp.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(specificftp.ja_system.jano, testData1);

      // ④ loadを実行する。
      await specificftp.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(specificftp.ja_system.jano == testData1, true);
      allPropatyCheck(specificftp,false);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await specificftp.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(specificftp,true);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②任意のプロパティの値を変更する。
      specificftp.ja_system.jano = testData1;
      expect(specificftp.ja_system.jano, testData1);

      // ③saveを実行する。
      await specificftp.save();
      expect(specificftp.ja_system.jano, testData1);

      // ④loadを実行する。
      await specificftp.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(specificftp,true);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await specificftp.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await specificftp.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(specificftp.ja_system.jano == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await specificftp.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await specificftp.setValueWithName(section, "test_key", testData1);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②任意のプロパティを変更する。
      specificftp.ja_system.jano = testData1;

      // ③saveを実行する。
      await specificftp.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await specificftp.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②任意のプロパティを変更する。
      specificftp.ja_system.jano = testData1;

      // ③saveを実行する。
      await specificftp.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await specificftp.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②任意のプロパティを変更する。
      specificftp.ja_system.jano = testData1;

      // ③saveを実行する。
      await specificftp.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await specificftp.getValueWithName(section, "test_key");
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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await specificftp.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      specificftp.ja_system.jano = testData1;
      expect(specificftp.ja_system.jano, testData1);

      // ④saveを実行する。
      await specificftp.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(specificftp.ja_system.jano, testData1);
      
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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await specificftp.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + specificftp.ja_system.jano.toString());
      expect(specificftp.ja_system.jano == testData1, true);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await specificftp.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + specificftp.ja_system.jano.toString());
      expect(specificftp.ja_system.jano == testData2, true);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await specificftp.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + specificftp.ja_system.jano.toString());
      expect(specificftp.ja_system.jano == testData1, true);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await specificftp.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + specificftp.ja_system.jano.toString());
      expect(specificftp.ja_system.jano == testData2, true);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await specificftp.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + specificftp.ja_system.jano.toString());
      expect(specificftp.ja_system.jano == testData1, true);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await specificftp.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + specificftp.ja_system.jano.toString());
      expect(specificftp.ja_system.jano == testData1, true);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await specificftp.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + specificftp.ja_system.jano.toString());
      allPropatyCheck(specificftp,true);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await specificftp.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + specificftp.ja_system.jano.toString());
      allPropatyCheck(specificftp,true);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①当該フォルダと同階層にex、cn、twのフォルダを作成する。
      // ②任意のプロパティ値を変更し、①の各フォルダにJSONのコピーを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern9, section, key, testData1, testData2, testData3);
      await getTestDate(confPath, fileName, testFunc.getPattern9);

      // ③changeLanguageを実行し、exフォルダに切り替える。
      // ④loadを実行する。
      specificftp.changeLanguage(JsonLanguage.ex);
      await specificftp.load();
      print("check:" + specificftp.ja_system.jano.toString());
      expect(specificftp.ja_system.jano == testData1, true);
      allPropatyCheck(specificftp,false);
      // ⑤changeLanguageを実行し、cnフォルダに切り替える。
      // ⑥loadを実行する。
      specificftp.changeLanguage(JsonLanguage.cn);
      await specificftp.load();
      print("check:" + specificftp.ja_system.jano.toString());
      expect(specificftp.ja_system.jano == testData2, true);
      allPropatyCheck(specificftp,false);
      // ⑦changeLanguageを実行し、twフォルダに切り替える。
      // ⑧loadを実行する。
      specificftp.changeLanguage(JsonLanguage.tw);
      await specificftp.load();
      print("check:" + specificftp.ja_system.jano.toString());
      expect(specificftp.ja_system.jano == testData3, true);
      allPropatyCheck(specificftp,false);
      // ⑨changeLanguageを実行し、aaフォルダに切り替える。
      // ⑩loadを実行する。
      specificftp.changeLanguage(JsonLanguage.aa);
      await specificftp.load();
      print("check:" + specificftp.ja_system.jano.toString());
      expect(specificftp.ja_system.jano == defaultData, true);
      allPropatyCheck(specificftp,false);

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

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.ja_system.jano;
      print(specificftp.ja_system.jano);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.ja_system.jano = testData1;
      print(specificftp.ja_system.jano);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.ja_system.jano == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.ja_system.jano == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.ja_system.jano = testData2;
      print(specificftp.ja_system.jano);
      expect(specificftp.ja_system.jano == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.ja_system.jano == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.ja_system.jano = defalut;
      print(specificftp.ja_system.jano);
      expect(specificftp.ja_system.jano == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.ja_system.jano == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00025_element_check_00001 **********\n\n");
    });

    test('00026_element_check_00002', () async {
      print("\n********** テスト実行：00026_element_check_00002 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.ja_system.clientno;
      print(specificftp.ja_system.clientno);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.ja_system.clientno = testData1;
      print(specificftp.ja_system.clientno);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.ja_system.clientno == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.ja_system.clientno == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.ja_system.clientno = testData2;
      print(specificftp.ja_system.clientno);
      expect(specificftp.ja_system.clientno == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.ja_system.clientno == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.ja_system.clientno = defalut;
      print(specificftp.ja_system.clientno);
      expect(specificftp.ja_system.clientno == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.ja_system.clientno == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00026_element_check_00002 **********\n\n");
    });

    test('00027_element_check_00003', () async {
      print("\n********** テスト実行：00027_element_check_00003 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.ja_system.sendcnt;
      print(specificftp.ja_system.sendcnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.ja_system.sendcnt = testData1;
      print(specificftp.ja_system.sendcnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.ja_system.sendcnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.ja_system.sendcnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.ja_system.sendcnt = testData2;
      print(specificftp.ja_system.sendcnt);
      expect(specificftp.ja_system.sendcnt == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.ja_system.sendcnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.ja_system.sendcnt = defalut;
      print(specificftp.ja_system.sendcnt);
      expect(specificftp.ja_system.sendcnt == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.ja_system.sendcnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00027_element_check_00003 **********\n\n");
    });

    test('00028_element_check_00004', () async {
      print("\n********** テスト実行：00028_element_check_00004 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.ja_system.senditemcnt;
      print(specificftp.ja_system.senditemcnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.ja_system.senditemcnt = testData1;
      print(specificftp.ja_system.senditemcnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.ja_system.senditemcnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.ja_system.senditemcnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.ja_system.senditemcnt = testData2;
      print(specificftp.ja_system.senditemcnt);
      expect(specificftp.ja_system.senditemcnt == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.ja_system.senditemcnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.ja_system.senditemcnt = defalut;
      print(specificftp.ja_system.senditemcnt);
      expect(specificftp.ja_system.senditemcnt == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.ja_system.senditemcnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00028_element_check_00004 **********\n\n");
    });

    test('00029_element_check_00005', () async {
      print("\n********** テスト実行：00029_element_check_00005 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.producer.cdlen;
      print(specificftp.producer.cdlen);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.producer.cdlen = testData1;
      print(specificftp.producer.cdlen);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.producer.cdlen == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.producer.cdlen == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.producer.cdlen = testData2;
      print(specificftp.producer.cdlen);
      expect(specificftp.producer.cdlen == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.producer.cdlen == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.producer.cdlen = defalut;
      print(specificftp.producer.cdlen);
      expect(specificftp.producer.cdlen == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.producer.cdlen == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00029_element_check_00005 **********\n\n");
    });

    test('00030_element_check_00006', () async {
      print("\n********** テスト実行：00030_element_check_00006 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.producer.startcd;
      print(specificftp.producer.startcd);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.producer.startcd = testData1;
      print(specificftp.producer.startcd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.producer.startcd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.producer.startcd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.producer.startcd = testData2;
      print(specificftp.producer.startcd);
      expect(specificftp.producer.startcd == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.producer.startcd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.producer.startcd = defalut;
      print(specificftp.producer.startcd);
      expect(specificftp.producer.startcd == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.producer.startcd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00030_element_check_00006 **********\n\n");
    });

    test('00031_element_check_00007', () async {
      print("\n********** テスト実行：00031_element_check_00007 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.producer.endcd;
      print(specificftp.producer.endcd);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.producer.endcd = testData1;
      print(specificftp.producer.endcd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.producer.endcd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.producer.endcd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.producer.endcd = testData2;
      print(specificftp.producer.endcd);
      expect(specificftp.producer.endcd == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.producer.endcd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.producer.endcd = defalut;
      print(specificftp.producer.endcd);
      expect(specificftp.producer.endcd == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.producer.endcd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00031_element_check_00007 **********\n\n");
    });

    test('00032_element_check_00008', () async {
      print("\n********** テスト実行：00032_element_check_00008 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.producer.endcd2;
      print(specificftp.producer.endcd2);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.producer.endcd2 = testData1;
      print(specificftp.producer.endcd2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.producer.endcd2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.producer.endcd2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.producer.endcd2 = testData2;
      print(specificftp.producer.endcd2);
      expect(specificftp.producer.endcd2 == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.producer.endcd2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.producer.endcd2 = defalut;
      print(specificftp.producer.endcd2);
      expect(specificftp.producer.endcd2 == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.producer.endcd2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00032_element_check_00008 **********\n\n");
    });

    test('00033_element_check_00009', () async {
      print("\n********** テスト実行：00033_element_check_00009 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.items.startcd;
      print(specificftp.items.startcd);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.items.startcd = testData1;
      print(specificftp.items.startcd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.items.startcd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.items.startcd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.items.startcd = testData2;
      print(specificftp.items.startcd);
      expect(specificftp.items.startcd == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.items.startcd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.items.startcd = defalut;
      print(specificftp.items.startcd);
      expect(specificftp.items.startcd == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.items.startcd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00033_element_check_00009 **********\n\n");
    });

    test('00034_element_check_00010', () async {
      print("\n********** テスト実行：00034_element_check_00010 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.items.endcd;
      print(specificftp.items.endcd);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.items.endcd = testData1;
      print(specificftp.items.endcd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.items.endcd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.items.endcd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.items.endcd = testData2;
      print(specificftp.items.endcd);
      expect(specificftp.items.endcd == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.items.endcd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.items.endcd = defalut;
      print(specificftp.items.endcd);
      expect(specificftp.items.endcd == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.items.endcd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00034_element_check_00010 **********\n\n");
    });

    test('00035_element_check_00011', () async {
      print("\n********** テスト実行：00035_element_check_00011 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.items.instre_flg;
      print(specificftp.items.instre_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.items.instre_flg = testData1s;
      print(specificftp.items.instre_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.items.instre_flg == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.items.instre_flg == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.items.instre_flg = testData2s;
      print(specificftp.items.instre_flg);
      expect(specificftp.items.instre_flg == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.items.instre_flg == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.items.instre_flg = defalut;
      print(specificftp.items.instre_flg);
      expect(specificftp.items.instre_flg == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.items.instre_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00035_element_check_00011 **********\n\n");
    });

    test('00036_element_check_00012', () async {
      print("\n********** テスト実行：00036_element_check_00012 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.items.endcd2;
      print(specificftp.items.endcd2);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.items.endcd2 = testData1;
      print(specificftp.items.endcd2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.items.endcd2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.items.endcd2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.items.endcd2 = testData2;
      print(specificftp.items.endcd2);
      expect(specificftp.items.endcd2 == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.items.endcd2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.items.endcd2 = defalut;
      print(specificftp.items.endcd2);
      expect(specificftp.items.endcd2 == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.items.endcd2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00036_element_check_00012 **********\n\n");
    });

    test('00037_element_check_00013', () async {
      print("\n********** テスト実行：00037_element_check_00013 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.csv_dly.dly_nouchoku;
      print(specificftp.csv_dly.dly_nouchoku);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.csv_dly.dly_nouchoku = testData1;
      print(specificftp.csv_dly.dly_nouchoku);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.csv_dly.dly_nouchoku == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.csv_dly.dly_nouchoku == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.csv_dly.dly_nouchoku = testData2;
      print(specificftp.csv_dly.dly_nouchoku);
      expect(specificftp.csv_dly.dly_nouchoku == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dly_nouchoku == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.csv_dly.dly_nouchoku = defalut;
      print(specificftp.csv_dly.dly_nouchoku);
      expect(specificftp.csv_dly.dly_nouchoku == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dly_nouchoku == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00037_element_check_00013 **********\n\n");
    });

    test('00038_element_check_00014', () async {
      print("\n********** テスト実行：00038_element_check_00014 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.csv_dly.dlynouchoku_week;
      print(specificftp.csv_dly.dlynouchoku_week);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.csv_dly.dlynouchoku_week = testData1;
      print(specificftp.csv_dly.dlynouchoku_week);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.csv_dly.dlynouchoku_week == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.csv_dly.dlynouchoku_week == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.csv_dly.dlynouchoku_week = testData2;
      print(specificftp.csv_dly.dlynouchoku_week);
      expect(specificftp.csv_dly.dlynouchoku_week == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dlynouchoku_week == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.csv_dly.dlynouchoku_week = defalut;
      print(specificftp.csv_dly.dlynouchoku_week);
      expect(specificftp.csv_dly.dlynouchoku_week == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dlynouchoku_week == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00038_element_check_00014 **********\n\n");
    });

    test('00039_element_check_00015', () async {
      print("\n********** テスト実行：00039_element_check_00015 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.csv_dly.dlynouchoku_day;
      print(specificftp.csv_dly.dlynouchoku_day);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.csv_dly.dlynouchoku_day = testData1;
      print(specificftp.csv_dly.dlynouchoku_day);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.csv_dly.dlynouchoku_day == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.csv_dly.dlynouchoku_day == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.csv_dly.dlynouchoku_day = testData2;
      print(specificftp.csv_dly.dlynouchoku_day);
      expect(specificftp.csv_dly.dlynouchoku_day == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dlynouchoku_day == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.csv_dly.dlynouchoku_day = defalut;
      print(specificftp.csv_dly.dlynouchoku_day);
      expect(specificftp.csv_dly.dlynouchoku_day == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dlynouchoku_day == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00039_element_check_00015 **********\n\n");
    });

    test('00040_element_check_00016', () async {
      print("\n********** テスト実行：00040_element_check_00016 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.csv_dly.dly_urihdr;
      print(specificftp.csv_dly.dly_urihdr);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.csv_dly.dly_urihdr = testData1;
      print(specificftp.csv_dly.dly_urihdr);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.csv_dly.dly_urihdr == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.csv_dly.dly_urihdr == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.csv_dly.dly_urihdr = testData2;
      print(specificftp.csv_dly.dly_urihdr);
      expect(specificftp.csv_dly.dly_urihdr == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dly_urihdr == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.csv_dly.dly_urihdr = defalut;
      print(specificftp.csv_dly.dly_urihdr);
      expect(specificftp.csv_dly.dly_urihdr == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dly_urihdr == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00040_element_check_00016 **********\n\n");
    });

    test('00041_element_check_00017', () async {
      print("\n********** テスト実行：00041_element_check_00017 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.csv_dly.dlyurihdr_week;
      print(specificftp.csv_dly.dlyurihdr_week);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.csv_dly.dlyurihdr_week = testData1;
      print(specificftp.csv_dly.dlyurihdr_week);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.csv_dly.dlyurihdr_week == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.csv_dly.dlyurihdr_week == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.csv_dly.dlyurihdr_week = testData2;
      print(specificftp.csv_dly.dlyurihdr_week);
      expect(specificftp.csv_dly.dlyurihdr_week == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dlyurihdr_week == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.csv_dly.dlyurihdr_week = defalut;
      print(specificftp.csv_dly.dlyurihdr_week);
      expect(specificftp.csv_dly.dlyurihdr_week == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dlyurihdr_week == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00041_element_check_00017 **********\n\n");
    });

    test('00042_element_check_00018', () async {
      print("\n********** テスト実行：00042_element_check_00018 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.csv_dly.dlyurihdr_day;
      print(specificftp.csv_dly.dlyurihdr_day);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.csv_dly.dlyurihdr_day = testData1;
      print(specificftp.csv_dly.dlyurihdr_day);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.csv_dly.dlyurihdr_day == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.csv_dly.dlyurihdr_day == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.csv_dly.dlyurihdr_day = testData2;
      print(specificftp.csv_dly.dlyurihdr_day);
      expect(specificftp.csv_dly.dlyurihdr_day == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dlyurihdr_day == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.csv_dly.dlyurihdr_day = defalut;
      print(specificftp.csv_dly.dlyurihdr_day);
      expect(specificftp.csv_dly.dlyurihdr_day == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dlyurihdr_day == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00042_element_check_00018 **********\n\n");
    });

    test('00043_element_check_00019', () async {
      print("\n********** テスト実行：00043_element_check_00019 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.csv_dly.dly_urimei;
      print(specificftp.csv_dly.dly_urimei);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.csv_dly.dly_urimei = testData1;
      print(specificftp.csv_dly.dly_urimei);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.csv_dly.dly_urimei == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.csv_dly.dly_urimei == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.csv_dly.dly_urimei = testData2;
      print(specificftp.csv_dly.dly_urimei);
      expect(specificftp.csv_dly.dly_urimei == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dly_urimei == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.csv_dly.dly_urimei = defalut;
      print(specificftp.csv_dly.dly_urimei);
      expect(specificftp.csv_dly.dly_urimei == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dly_urimei == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00043_element_check_00019 **********\n\n");
    });

    test('00044_element_check_00020', () async {
      print("\n********** テスト実行：00044_element_check_00020 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.csv_dly.dlyurimei_week;
      print(specificftp.csv_dly.dlyurimei_week);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.csv_dly.dlyurimei_week = testData1;
      print(specificftp.csv_dly.dlyurimei_week);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.csv_dly.dlyurimei_week == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.csv_dly.dlyurimei_week == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.csv_dly.dlyurimei_week = testData2;
      print(specificftp.csv_dly.dlyurimei_week);
      expect(specificftp.csv_dly.dlyurimei_week == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dlyurimei_week == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.csv_dly.dlyurimei_week = defalut;
      print(specificftp.csv_dly.dlyurimei_week);
      expect(specificftp.csv_dly.dlyurimei_week == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dlyurimei_week == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00044_element_check_00020 **********\n\n");
    });

    test('00045_element_check_00021', () async {
      print("\n********** テスト実行：00045_element_check_00021 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.csv_dly.dlyurimei_day;
      print(specificftp.csv_dly.dlyurimei_day);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.csv_dly.dlyurimei_day = testData1;
      print(specificftp.csv_dly.dlyurimei_day);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.csv_dly.dlyurimei_day == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.csv_dly.dlyurimei_day == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.csv_dly.dlyurimei_day = testData2;
      print(specificftp.csv_dly.dlyurimei_day);
      expect(specificftp.csv_dly.dlyurimei_day == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dlyurimei_day == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.csv_dly.dlyurimei_day = defalut;
      print(specificftp.csv_dly.dlyurimei_day);
      expect(specificftp.csv_dly.dlyurimei_day == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.csv_dly.dlyurimei_day == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00045_element_check_00021 **********\n\n");
    });

    test('00046_element_check_00022', () async {
      print("\n********** テスト実行：00046_element_check_00022 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.max_item.total_item;
      print(specificftp.max_item.total_item);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.max_item.total_item = testData1;
      print(specificftp.max_item.total_item);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.max_item.total_item == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.max_item.total_item == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.max_item.total_item = testData2;
      print(specificftp.max_item.total_item);
      expect(specificftp.max_item.total_item == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.max_item.total_item == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.max_item.total_item = defalut;
      print(specificftp.max_item.total_item);
      expect(specificftp.max_item.total_item == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.max_item.total_item == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00046_element_check_00022 **********\n\n");
    });

    test('00047_element_check_00023', () async {
      print("\n********** テスト実行：00047_element_check_00023 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.page.total_page;
      print(specificftp.page.total_page);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.page.total_page = testData1;
      print(specificftp.page.total_page);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.page.total_page == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.page.total_page == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.page.total_page = testData2;
      print(specificftp.page.total_page);
      expect(specificftp.page.total_page == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.page.total_page == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.page.total_page = defalut;
      print(specificftp.page.total_page);
      expect(specificftp.page.total_page == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.page.total_page == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00047_element_check_00023 **********\n\n");
    });

    test('00048_element_check_00024', () async {
      print("\n********** テスト実行：00048_element_check_00024 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.page.onoff0;
      print(specificftp.page.onoff0);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.page.onoff0 = testData1;
      print(specificftp.page.onoff0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.page.onoff0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.page.onoff0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.page.onoff0 = testData2;
      print(specificftp.page.onoff0);
      expect(specificftp.page.onoff0 == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.page.onoff0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.page.onoff0 = defalut;
      print(specificftp.page.onoff0);
      expect(specificftp.page.onoff0 == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.page.onoff0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00048_element_check_00024 **********\n\n");
    });

    test('00049_element_check_00025', () async {
      print("\n********** テスト実行：00049_element_check_00025 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item0.onoff;
      print(specificftp.item0.onoff);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item0.onoff = testData1;
      print(specificftp.item0.onoff);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item0.onoff == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item0.onoff == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item0.onoff = testData2;
      print(specificftp.item0.onoff);
      expect(specificftp.item0.onoff == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.onoff == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item0.onoff = defalut;
      print(specificftp.item0.onoff);
      expect(specificftp.item0.onoff == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.onoff == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00049_element_check_00025 **********\n\n");
    });

    test('00050_element_check_00026', () async {
      print("\n********** テスト実行：00050_element_check_00026 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item0.page;
      print(specificftp.item0.page);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item0.page = testData1;
      print(specificftp.item0.page);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item0.page == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item0.page == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item0.page = testData2;
      print(specificftp.item0.page);
      expect(specificftp.item0.page == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.page == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item0.page = defalut;
      print(specificftp.item0.page);
      expect(specificftp.item0.page == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.page == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00050_element_check_00026 **********\n\n");
    });

    test('00051_element_check_00027', () async {
      print("\n********** テスト実行：00051_element_check_00027 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item0.position;
      print(specificftp.item0.position);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item0.position = testData1;
      print(specificftp.item0.position);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item0.position == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item0.position == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item0.position = testData2;
      print(specificftp.item0.position);
      expect(specificftp.item0.position == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.position == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item0.position = defalut;
      print(specificftp.item0.position);
      expect(specificftp.item0.position == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.position == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00051_element_check_00027 **********\n\n");
    });

    test('00052_element_check_00028', () async {
      print("\n********** テスト実行：00052_element_check_00028 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item0.table1;
      print(specificftp.item0.table1);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item0.table1 = testData1s;
      print(specificftp.item0.table1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item0.table1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item0.table1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item0.table1 = testData2s;
      print(specificftp.item0.table1);
      expect(specificftp.item0.table1 == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.table1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item0.table1 = defalut;
      print(specificftp.item0.table1);
      expect(specificftp.item0.table1 == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.table1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00052_element_check_00028 **********\n\n");
    });

    test('00053_element_check_00029', () async {
      print("\n********** テスト実行：00053_element_check_00029 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item0.total;
      print(specificftp.item0.total);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item0.total = testData1;
      print(specificftp.item0.total);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item0.total == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item0.total == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item0.total = testData2;
      print(specificftp.item0.total);
      expect(specificftp.item0.total == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.total == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item0.total = defalut;
      print(specificftp.item0.total);
      expect(specificftp.item0.total == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.total == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00053_element_check_00029 **********\n\n");
    });

    test('00054_element_check_00030', () async {
      print("\n********** テスト実行：00054_element_check_00030 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item0.t_exe1;
      print(specificftp.item0.t_exe1);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item0.t_exe1 = testData1s;
      print(specificftp.item0.t_exe1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item0.t_exe1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item0.t_exe1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item0.t_exe1 = testData2s;
      print(specificftp.item0.t_exe1);
      expect(specificftp.item0.t_exe1 == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.t_exe1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item0.t_exe1 = defalut;
      print(specificftp.item0.t_exe1);
      expect(specificftp.item0.t_exe1 == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.t_exe1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00054_element_check_00030 **********\n\n");
    });

    test('00055_element_check_00031', () async {
      print("\n********** テスト実行：00055_element_check_00031 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item0.section;
      print(specificftp.item0.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item0.section = testData1s;
      print(specificftp.item0.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item0.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item0.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item0.section = testData2s;
      print(specificftp.item0.section);
      expect(specificftp.item0.section == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item0.section = defalut;
      print(specificftp.item0.section);
      expect(specificftp.item0.section == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00055_element_check_00031 **********\n\n");
    });

    test('00056_element_check_00032', () async {
      print("\n********** テスト実行：00056_element_check_00032 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item0.keyword;
      print(specificftp.item0.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item0.keyword = testData1s;
      print(specificftp.item0.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item0.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item0.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item0.keyword = testData2s;
      print(specificftp.item0.keyword);
      expect(specificftp.item0.keyword == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item0.keyword = defalut;
      print(specificftp.item0.keyword);
      expect(specificftp.item0.keyword == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00056_element_check_00032 **********\n\n");
    });

    test('00057_element_check_00033', () async {
      print("\n********** テスト実行：00057_element_check_00033 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item0.backup_day;
      print(specificftp.item0.backup_day);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item0.backup_day = testData1s;
      print(specificftp.item0.backup_day);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item0.backup_day == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item0.backup_day == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item0.backup_day = testData2s;
      print(specificftp.item0.backup_day);
      expect(specificftp.item0.backup_day == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.backup_day == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item0.backup_day = defalut;
      print(specificftp.item0.backup_day);
      expect(specificftp.item0.backup_day == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.backup_day == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00057_element_check_00033 **********\n\n");
    });

    test('00058_element_check_00034', () async {
      print("\n********** テスト実行：00058_element_check_00034 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item0.select_dsp;
      print(specificftp.item0.select_dsp);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item0.select_dsp = testData1;
      print(specificftp.item0.select_dsp);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item0.select_dsp == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item0.select_dsp == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item0.select_dsp = testData2;
      print(specificftp.item0.select_dsp);
      expect(specificftp.item0.select_dsp == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.select_dsp == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item0.select_dsp = defalut;
      print(specificftp.item0.select_dsp);
      expect(specificftp.item0.select_dsp == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item0.select_dsp == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00058_element_check_00034 **********\n\n");
    });

    test('00059_element_check_00035', () async {
      print("\n********** テスト実行：00059_element_check_00035 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item1.onoff;
      print(specificftp.item1.onoff);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item1.onoff = testData1;
      print(specificftp.item1.onoff);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item1.onoff == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item1.onoff == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item1.onoff = testData2;
      print(specificftp.item1.onoff);
      expect(specificftp.item1.onoff == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.onoff == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item1.onoff = defalut;
      print(specificftp.item1.onoff);
      expect(specificftp.item1.onoff == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.onoff == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00059_element_check_00035 **********\n\n");
    });

    test('00060_element_check_00036', () async {
      print("\n********** テスト実行：00060_element_check_00036 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item1.page;
      print(specificftp.item1.page);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item1.page = testData1;
      print(specificftp.item1.page);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item1.page == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item1.page == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item1.page = testData2;
      print(specificftp.item1.page);
      expect(specificftp.item1.page == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.page == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item1.page = defalut;
      print(specificftp.item1.page);
      expect(specificftp.item1.page == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.page == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00060_element_check_00036 **********\n\n");
    });

    test('00061_element_check_00037', () async {
      print("\n********** テスト実行：00061_element_check_00037 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item1.position;
      print(specificftp.item1.position);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item1.position = testData1;
      print(specificftp.item1.position);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item1.position == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item1.position == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item1.position = testData2;
      print(specificftp.item1.position);
      expect(specificftp.item1.position == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.position == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item1.position = defalut;
      print(specificftp.item1.position);
      expect(specificftp.item1.position == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.position == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00061_element_check_00037 **********\n\n");
    });

    test('00062_element_check_00038', () async {
      print("\n********** テスト実行：00062_element_check_00038 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item1.table1;
      print(specificftp.item1.table1);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item1.table1 = testData1s;
      print(specificftp.item1.table1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item1.table1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item1.table1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item1.table1 = testData2s;
      print(specificftp.item1.table1);
      expect(specificftp.item1.table1 == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.table1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item1.table1 = defalut;
      print(specificftp.item1.table1);
      expect(specificftp.item1.table1 == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.table1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00062_element_check_00038 **********\n\n");
    });

    test('00063_element_check_00039', () async {
      print("\n********** テスト実行：00063_element_check_00039 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item1.total;
      print(specificftp.item1.total);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item1.total = testData1;
      print(specificftp.item1.total);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item1.total == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item1.total == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item1.total = testData2;
      print(specificftp.item1.total);
      expect(specificftp.item1.total == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.total == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item1.total = defalut;
      print(specificftp.item1.total);
      expect(specificftp.item1.total == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.total == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00063_element_check_00039 **********\n\n");
    });

    test('00064_element_check_00040', () async {
      print("\n********** テスト実行：00064_element_check_00040 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item1.t_exe1;
      print(specificftp.item1.t_exe1);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item1.t_exe1 = testData1s;
      print(specificftp.item1.t_exe1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item1.t_exe1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item1.t_exe1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item1.t_exe1 = testData2s;
      print(specificftp.item1.t_exe1);
      expect(specificftp.item1.t_exe1 == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.t_exe1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item1.t_exe1 = defalut;
      print(specificftp.item1.t_exe1);
      expect(specificftp.item1.t_exe1 == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.t_exe1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00064_element_check_00040 **********\n\n");
    });

    test('00065_element_check_00041', () async {
      print("\n********** テスト実行：00065_element_check_00041 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item1.section;
      print(specificftp.item1.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item1.section = testData1s;
      print(specificftp.item1.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item1.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item1.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item1.section = testData2s;
      print(specificftp.item1.section);
      expect(specificftp.item1.section == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item1.section = defalut;
      print(specificftp.item1.section);
      expect(specificftp.item1.section == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00065_element_check_00041 **********\n\n");
    });

    test('00066_element_check_00042', () async {
      print("\n********** テスト実行：00066_element_check_00042 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item1.keyword;
      print(specificftp.item1.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item1.keyword = testData1s;
      print(specificftp.item1.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item1.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item1.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item1.keyword = testData2s;
      print(specificftp.item1.keyword);
      expect(specificftp.item1.keyword == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item1.keyword = defalut;
      print(specificftp.item1.keyword);
      expect(specificftp.item1.keyword == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00066_element_check_00042 **********\n\n");
    });

    test('00067_element_check_00043', () async {
      print("\n********** テスト実行：00067_element_check_00043 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item1.backup_day;
      print(specificftp.item1.backup_day);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item1.backup_day = testData1s;
      print(specificftp.item1.backup_day);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item1.backup_day == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item1.backup_day == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item1.backup_day = testData2s;
      print(specificftp.item1.backup_day);
      expect(specificftp.item1.backup_day == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.backup_day == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item1.backup_day = defalut;
      print(specificftp.item1.backup_day);
      expect(specificftp.item1.backup_day == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.backup_day == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00067_element_check_00043 **********\n\n");
    });

    test('00068_element_check_00044', () async {
      print("\n********** テスト実行：00068_element_check_00044 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item1.select_dsp;
      print(specificftp.item1.select_dsp);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item1.select_dsp = testData1;
      print(specificftp.item1.select_dsp);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item1.select_dsp == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item1.select_dsp == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item1.select_dsp = testData2;
      print(specificftp.item1.select_dsp);
      expect(specificftp.item1.select_dsp == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.select_dsp == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item1.select_dsp = defalut;
      print(specificftp.item1.select_dsp);
      expect(specificftp.item1.select_dsp == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item1.select_dsp == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00068_element_check_00044 **********\n\n");
    });

    test('00069_element_check_00045', () async {
      print("\n********** テスト実行：00069_element_check_00045 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item2.onoff;
      print(specificftp.item2.onoff);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item2.onoff = testData1;
      print(specificftp.item2.onoff);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item2.onoff == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item2.onoff == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item2.onoff = testData2;
      print(specificftp.item2.onoff);
      expect(specificftp.item2.onoff == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.onoff == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item2.onoff = defalut;
      print(specificftp.item2.onoff);
      expect(specificftp.item2.onoff == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.onoff == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00069_element_check_00045 **********\n\n");
    });

    test('00070_element_check_00046', () async {
      print("\n********** テスト実行：00070_element_check_00046 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item2.page;
      print(specificftp.item2.page);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item2.page = testData1;
      print(specificftp.item2.page);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item2.page == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item2.page == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item2.page = testData2;
      print(specificftp.item2.page);
      expect(specificftp.item2.page == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.page == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item2.page = defalut;
      print(specificftp.item2.page);
      expect(specificftp.item2.page == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.page == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00070_element_check_00046 **********\n\n");
    });

    test('00071_element_check_00047', () async {
      print("\n********** テスト実行：00071_element_check_00047 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item2.position;
      print(specificftp.item2.position);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item2.position = testData1;
      print(specificftp.item2.position);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item2.position == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item2.position == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item2.position = testData2;
      print(specificftp.item2.position);
      expect(specificftp.item2.position == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.position == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item2.position = defalut;
      print(specificftp.item2.position);
      expect(specificftp.item2.position == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.position == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00071_element_check_00047 **********\n\n");
    });

    test('00072_element_check_00048', () async {
      print("\n********** テスト実行：00072_element_check_00048 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item2.table1;
      print(specificftp.item2.table1);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item2.table1 = testData1s;
      print(specificftp.item2.table1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item2.table1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item2.table1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item2.table1 = testData2s;
      print(specificftp.item2.table1);
      expect(specificftp.item2.table1 == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.table1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item2.table1 = defalut;
      print(specificftp.item2.table1);
      expect(specificftp.item2.table1 == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.table1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00072_element_check_00048 **********\n\n");
    });

    test('00073_element_check_00049', () async {
      print("\n********** テスト実行：00073_element_check_00049 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item2.total;
      print(specificftp.item2.total);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item2.total = testData1;
      print(specificftp.item2.total);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item2.total == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item2.total == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item2.total = testData2;
      print(specificftp.item2.total);
      expect(specificftp.item2.total == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.total == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item2.total = defalut;
      print(specificftp.item2.total);
      expect(specificftp.item2.total == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.total == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00073_element_check_00049 **********\n\n");
    });

    test('00074_element_check_00050', () async {
      print("\n********** テスト実行：00074_element_check_00050 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item2.t_exe1;
      print(specificftp.item2.t_exe1);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item2.t_exe1 = testData1s;
      print(specificftp.item2.t_exe1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item2.t_exe1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item2.t_exe1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item2.t_exe1 = testData2s;
      print(specificftp.item2.t_exe1);
      expect(specificftp.item2.t_exe1 == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.t_exe1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item2.t_exe1 = defalut;
      print(specificftp.item2.t_exe1);
      expect(specificftp.item2.t_exe1 == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.t_exe1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00074_element_check_00050 **********\n\n");
    });

    test('00075_element_check_00051', () async {
      print("\n********** テスト実行：00075_element_check_00051 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item2.section;
      print(specificftp.item2.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item2.section = testData1s;
      print(specificftp.item2.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item2.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item2.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item2.section = testData2s;
      print(specificftp.item2.section);
      expect(specificftp.item2.section == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item2.section = defalut;
      print(specificftp.item2.section);
      expect(specificftp.item2.section == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00075_element_check_00051 **********\n\n");
    });

    test('00076_element_check_00052', () async {
      print("\n********** テスト実行：00076_element_check_00052 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item2.keyword;
      print(specificftp.item2.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item2.keyword = testData1s;
      print(specificftp.item2.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item2.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item2.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item2.keyword = testData2s;
      print(specificftp.item2.keyword);
      expect(specificftp.item2.keyword == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item2.keyword = defalut;
      print(specificftp.item2.keyword);
      expect(specificftp.item2.keyword == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00076_element_check_00052 **********\n\n");
    });

    test('00077_element_check_00053', () async {
      print("\n********** テスト実行：00077_element_check_00053 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item2.backup_day;
      print(specificftp.item2.backup_day);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item2.backup_day = testData1s;
      print(specificftp.item2.backup_day);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item2.backup_day == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item2.backup_day == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item2.backup_day = testData2s;
      print(specificftp.item2.backup_day);
      expect(specificftp.item2.backup_day == testData2s, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.backup_day == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item2.backup_day = defalut;
      print(specificftp.item2.backup_day);
      expect(specificftp.item2.backup_day == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.backup_day == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00077_element_check_00053 **********\n\n");
    });

    test('00078_element_check_00054', () async {
      print("\n********** テスト実行：00078_element_check_00054 **********");

      specificftp = SpecificftpJsonFile();
      allPropatyCheckInit(specificftp);

      // ①loadを実行する。
      await specificftp.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = specificftp.item2.select_dsp;
      print(specificftp.item2.select_dsp);

      // ②指定したプロパティにテストデータ1を書き込む。
      specificftp.item2.select_dsp = testData1;
      print(specificftp.item2.select_dsp);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(specificftp.item2.select_dsp == testData1, true);

      // ④saveを実行後、loadを実行する。
      await specificftp.save();
      await specificftp.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(specificftp.item2.select_dsp == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      specificftp.item2.select_dsp = testData2;
      print(specificftp.item2.select_dsp);
      expect(specificftp.item2.select_dsp == testData2, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.select_dsp == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      specificftp.item2.select_dsp = defalut;
      print(specificftp.item2.select_dsp);
      expect(specificftp.item2.select_dsp == defalut, true);
      await specificftp.save();
      await specificftp.load();
      expect(specificftp.item2.select_dsp == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(specificftp, true);

      print("********** テスト終了：00078_element_check_00054 **********\n\n");
    });

  });
}

void allPropatyCheckInit(SpecificftpJsonFile test)
{
  expect(test.ja_system.jano, 0);
  expect(test.ja_system.clientno, 0);
  expect(test.ja_system.sendcnt, 0);
  expect(test.ja_system.senditemcnt, 0);
  expect(test.producer.cdlen, 0);
  expect(test.producer.startcd, 0);
  expect(test.producer.endcd, 0);
  expect(test.producer.endcd2, 0);
  expect(test.items.startcd, 0);
  expect(test.items.endcd, 0);
  expect(test.items.instre_flg, "");
  expect(test.items.endcd2, 0);
  expect(test.csv_dly.dly_nouchoku, 0);
  expect(test.csv_dly.dlynouchoku_week, 0);
  expect(test.csv_dly.dlynouchoku_day, 0);
  expect(test.csv_dly.dly_urihdr, 0);
  expect(test.csv_dly.dlyurihdr_week, 0);
  expect(test.csv_dly.dlyurihdr_day, 0);
  expect(test.csv_dly.dly_urimei, 0);
  expect(test.csv_dly.dlyurimei_week, 0);
  expect(test.csv_dly.dlyurimei_day, 0);
  expect(test.max_item.total_item, 0);
  expect(test.page.total_page, 0);
  expect(test.page.onoff0, 0);
  expect(test.item0.onoff, 0);
  expect(test.item0.page, 0);
  expect(test.item0.position, 0);
  expect(test.item0.table1, "");
  expect(test.item0.total, 0);
  expect(test.item0.t_exe1, "");
  expect(test.item0.section, "");
  expect(test.item0.keyword, "");
  expect(test.item0.backup_day, "");
  expect(test.item0.select_dsp, 0);
  expect(test.item1.onoff, 0);
  expect(test.item1.page, 0);
  expect(test.item1.position, 0);
  expect(test.item1.table1, "");
  expect(test.item1.total, 0);
  expect(test.item1.t_exe1, "");
  expect(test.item1.section, "");
  expect(test.item1.keyword, "");
  expect(test.item1.backup_day, "");
  expect(test.item1.select_dsp, 0);
  expect(test.item2.onoff, 0);
  expect(test.item2.page, 0);
  expect(test.item2.position, 0);
  expect(test.item2.table1, "");
  expect(test.item2.total, 0);
  expect(test.item2.t_exe1, "");
  expect(test.item2.section, "");
  expect(test.item2.keyword, "");
  expect(test.item2.backup_day, "");
  expect(test.item2.select_dsp, 0);
}

void allPropatyCheck(SpecificftpJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.ja_system.jano, 1);
  }
  expect(test.ja_system.clientno, 1);
  expect(test.ja_system.sendcnt, 0);
  expect(test.ja_system.senditemcnt, 0);
  expect(test.producer.cdlen, 0);
  expect(test.producer.startcd, 1);
  expect(test.producer.endcd, 999);
  expect(test.producer.endcd2, 99999);
  expect(test.items.startcd, 1);
  expect(test.items.endcd, 999);
  expect(test.items.instre_flg, "00");
  expect(test.items.endcd2, 99999);
  expect(test.csv_dly.dly_nouchoku, 0);
  expect(test.csv_dly.dlynouchoku_week, 0);
  expect(test.csv_dly.dlynouchoku_day, 1);
  expect(test.csv_dly.dly_urihdr, 0);
  expect(test.csv_dly.dlyurihdr_week, 0);
  expect(test.csv_dly.dlyurihdr_day, 1);
  expect(test.csv_dly.dly_urimei, 0);
  expect(test.csv_dly.dlyurimei_week, 0);
  expect(test.csv_dly.dlyurimei_day, 1);
  expect(test.max_item.total_item, 3);
  expect(test.page.total_page, 1);
  expect(test.page.onoff0, 0);
  expect(test.item0.onoff, 0);
  expect(test.item0.page, 1);
  expect(test.item0.position, 1);
  expect(test.item0.table1, "農直品");
  expect(test.item0.total, 1);
  expect(test.item0.t_exe1, "NOUCHOKU");
  expect(test.item0.section, "csv_dly");
  expect(test.item0.keyword, "dly_nouchoku");
  expect(test.item0.backup_day, "0000-00-00");
  expect(test.item0.select_dsp, 0);
  expect(test.item1.onoff, 0);
  expect(test.item1.page, 1);
  expect(test.item1.position, 2);
  expect(test.item1.table1, "売上伝票");
  expect(test.item1.total, 1);
  expect(test.item1.t_exe1, "URIHDR");
  expect(test.item1.section, "csv_dly");
  expect(test.item1.keyword, "dly_urihdr");
  expect(test.item1.backup_day, "0000-00-00");
  expect(test.item1.select_dsp, 0);
  expect(test.item2.onoff, 0);
  expect(test.item2.page, 1);
  expect(test.item2.position, 3);
  expect(test.item2.table1, "売上明細");
  expect(test.item2.total, 1);
  expect(test.item2.t_exe1, "URIMEI");
  expect(test.item2.section, "csv_dly");
  expect(test.item2.keyword, "dly_urimei");
  expect(test.item2.backup_day, "0000-00-00");
  expect(test.item2.select_dsp, 0);
}

