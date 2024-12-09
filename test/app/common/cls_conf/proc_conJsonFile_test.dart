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
import '../../../../lib/app/common/cls_conf/proc_conJsonFile.dart';

late Proc_conJsonFile proc_con;

void main(){
  proc_conJsonFile_test();
}

void proc_conJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "proc_con.json";
  const String section = "regs";
  const String key = "entry01";
  const defaultData = "print";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Proc_conJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Proc_conJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Proc_conJsonFile().setDefault();
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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await proc_con.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(proc_con,true);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        proc_con.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await proc_con.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(proc_con,true);

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
      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①：loadを実行する。
      await proc_con.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = proc_con.regs.entry01;
      proc_con.regs.entry01 = testData1s;
      expect(proc_con.regs.entry01 == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await proc_con.load();
      expect(proc_con.regs.entry01 != testData1s, true);
      expect(proc_con.regs.entry01 == prefixData, true);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = proc_con.regs.entry01;
      proc_con.regs.entry01 = testData1s;
      expect(proc_con.regs.entry01, testData1s);

      // ③saveを実行する。
      await proc_con.save();

      // ④loadを実行する。
      await proc_con.load();

      expect(proc_con.regs.entry01 != prefixData, true);
      expect(proc_con.regs.entry01 == testData1s, true);
      allPropatyCheck(proc_con,false);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await proc_con.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await proc_con.save();

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await proc_con.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(proc_con.regs.entry01, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = proc_con.regs.entry01;
      proc_con.regs.entry01 = testData1s;

      // ③ saveを実行する。
      await proc_con.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(proc_con.regs.entry01, testData1s);

      // ④ loadを実行する。
      await proc_con.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(proc_con.regs.entry01 == testData1s, true);
      allPropatyCheck(proc_con,false);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await proc_con.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(proc_con,true);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②任意のプロパティの値を変更する。
      proc_con.regs.entry01 = testData1s;
      expect(proc_con.regs.entry01, testData1s);

      // ③saveを実行する。
      await proc_con.save();
      expect(proc_con.regs.entry01, testData1s);

      // ④loadを実行する。
      await proc_con.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(proc_con,true);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await proc_con.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await proc_con.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(proc_con.regs.entry01 == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await proc_con.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await proc_con.setValueWithName(section, "test_key", testData1s);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②任意のプロパティを変更する。
      proc_con.regs.entry01 = testData1s;

      // ③saveを実行する。
      await proc_con.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await proc_con.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②任意のプロパティを変更する。
      proc_con.regs.entry01 = testData1s;

      // ③saveを実行する。
      await proc_con.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await proc_con.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②任意のプロパティを変更する。
      proc_con.regs.entry01 = testData1s;

      // ③saveを実行する。
      await proc_con.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await proc_con.getValueWithName(section, "test_key");
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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await proc_con.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      proc_con.regs.entry01 = testData1s;
      expect(proc_con.regs.entry01, testData1s);

      // ④saveを実行する。
      await proc_con.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(proc_con.regs.entry01, testData1s);
      
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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await proc_con.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + proc_con.regs.entry01.toString());
      expect(proc_con.regs.entry01 == testData1s, true);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await proc_con.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + proc_con.regs.entry01.toString());
      expect(proc_con.regs.entry01 == testData2s, true);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await proc_con.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + proc_con.regs.entry01.toString());
      expect(proc_con.regs.entry01 == testData1s, true);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await proc_con.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + proc_con.regs.entry01.toString());
      expect(proc_con.regs.entry01 == testData2s, true);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await proc_con.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + proc_con.regs.entry01.toString());
      expect(proc_con.regs.entry01 == testData1s, true);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await proc_con.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + proc_con.regs.entry01.toString());
      expect(proc_con.regs.entry01 == testData1s, true);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await proc_con.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + proc_con.regs.entry01.toString());
      allPropatyCheck(proc_con,true);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await proc_con.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + proc_con.regs.entry01.toString());
      allPropatyCheck(proc_con,true);

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

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs.entry01;
      print(proc_con.regs.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs.entry01 = testData1s;
      print(proc_con.regs.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs.entry01 = testData2s;
      print(proc_con.regs.entry01);
      expect(proc_con.regs.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs.entry01 = defalut;
      print(proc_con.regs.entry01);
      expect(proc_con.regs.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs.entry02;
      print(proc_con.regs.entry02);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs.entry02 = testData1s;
      print(proc_con.regs.entry02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs.entry02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs.entry02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs.entry02 = testData2s;
      print(proc_con.regs.entry02);
      expect(proc_con.regs.entry02 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs.entry02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs.entry02 = defalut;
      print(proc_con.regs.entry02);
      expect(proc_con.regs.entry02 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs.entry02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs.entry03;
      print(proc_con.regs.entry03);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs.entry03 = testData1s;
      print(proc_con.regs.entry03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs.entry03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs.entry03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs.entry03 = testData2s;
      print(proc_con.regs.entry03);
      expect(proc_con.regs.entry03 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs.entry03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs.entry03 = defalut;
      print(proc_con.regs.entry03);
      expect(proc_con.regs.entry03 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs.entry03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs.entry04;
      print(proc_con.regs.entry04);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs.entry04 = testData1s;
      print(proc_con.regs.entry04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs.entry04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs.entry04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs.entry04 = testData2s;
      print(proc_con.regs.entry04);
      expect(proc_con.regs.entry04 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs.entry04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs.entry04 = defalut;
      print(proc_con.regs.entry04);
      expect(proc_con.regs.entry04 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs.entry04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs.entry05;
      print(proc_con.regs.entry05);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs.entry05 = testData1s;
      print(proc_con.regs.entry05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs.entry05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs.entry05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs.entry05 = testData2s;
      print(proc_con.regs.entry05);
      expect(proc_con.regs.entry05 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs.entry05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs.entry05 = defalut;
      print(proc_con.regs.entry05);
      expect(proc_con.regs.entry05 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs.entry05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry01;
      print(proc_con.regs_opt.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry01 = testData1s;
      print(proc_con.regs_opt.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry01 = testData2s;
      print(proc_con.regs_opt.entry01);
      expect(proc_con.regs_opt.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry01 = defalut;
      print(proc_con.regs_opt.entry01);
      expect(proc_con.regs_opt.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry02;
      print(proc_con.regs_opt.entry02);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry02 = testData1s;
      print(proc_con.regs_opt.entry02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry02 = testData2s;
      print(proc_con.regs_opt.entry02);
      expect(proc_con.regs_opt.entry02 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry02 = defalut;
      print(proc_con.regs_opt.entry02);
      expect(proc_con.regs_opt.entry02 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry03;
      print(proc_con.regs_opt.entry03);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry03 = testData1s;
      print(proc_con.regs_opt.entry03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry03 = testData2s;
      print(proc_con.regs_opt.entry03);
      expect(proc_con.regs_opt.entry03 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry03 = defalut;
      print(proc_con.regs_opt.entry03);
      expect(proc_con.regs_opt.entry03 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry04;
      print(proc_con.regs_opt.entry04);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry04 = testData1s;
      print(proc_con.regs_opt.entry04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry04 = testData2s;
      print(proc_con.regs_opt.entry04);
      expect(proc_con.regs_opt.entry04 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry04 = defalut;
      print(proc_con.regs_opt.entry04);
      expect(proc_con.regs_opt.entry04 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry05;
      print(proc_con.regs_opt.entry05);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry05 = testData1s;
      print(proc_con.regs_opt.entry05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry05 = testData2s;
      print(proc_con.regs_opt.entry05);
      expect(proc_con.regs_opt.entry05 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry05 = defalut;
      print(proc_con.regs_opt.entry05);
      expect(proc_con.regs_opt.entry05 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry06;
      print(proc_con.regs_opt.entry06);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry06 = testData1s;
      print(proc_con.regs_opt.entry06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry06 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry06 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry06 = testData2s;
      print(proc_con.regs_opt.entry06);
      expect(proc_con.regs_opt.entry06 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry06 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry06 = defalut;
      print(proc_con.regs_opt.entry06);
      expect(proc_con.regs_opt.entry06 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry07;
      print(proc_con.regs_opt.entry07);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry07 = testData1s;
      print(proc_con.regs_opt.entry07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry07 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry07 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry07 = testData2s;
      print(proc_con.regs_opt.entry07);
      expect(proc_con.regs_opt.entry07 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry07 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry07 = defalut;
      print(proc_con.regs_opt.entry07);
      expect(proc_con.regs_opt.entry07 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry08;
      print(proc_con.regs_opt.entry08);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry08 = testData1s;
      print(proc_con.regs_opt.entry08);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry08 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry08 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry08 = testData2s;
      print(proc_con.regs_opt.entry08);
      expect(proc_con.regs_opt.entry08 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry08 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry08 = defalut;
      print(proc_con.regs_opt.entry08);
      expect(proc_con.regs_opt.entry08 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry08 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry09;
      print(proc_con.regs_opt.entry09);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry09 = testData1s;
      print(proc_con.regs_opt.entry09);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry09 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry09 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry09 = testData2s;
      print(proc_con.regs_opt.entry09);
      expect(proc_con.regs_opt.entry09 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry09 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry09 = defalut;
      print(proc_con.regs_opt.entry09);
      expect(proc_con.regs_opt.entry09 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry09 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry10;
      print(proc_con.regs_opt.entry10);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry10 = testData1s;
      print(proc_con.regs_opt.entry10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry10 = testData2s;
      print(proc_con.regs_opt.entry10);
      expect(proc_con.regs_opt.entry10 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry10 = defalut;
      print(proc_con.regs_opt.entry10);
      expect(proc_con.regs_opt.entry10 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry11;
      print(proc_con.regs_opt.entry11);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry11 = testData1s;
      print(proc_con.regs_opt.entry11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry11 = testData2s;
      print(proc_con.regs_opt.entry11);
      expect(proc_con.regs_opt.entry11 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry11 = defalut;
      print(proc_con.regs_opt.entry11);
      expect(proc_con.regs_opt.entry11 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry12;
      print(proc_con.regs_opt.entry12);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry12 = testData1s;
      print(proc_con.regs_opt.entry12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry12 = testData2s;
      print(proc_con.regs_opt.entry12);
      expect(proc_con.regs_opt.entry12 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry12 = defalut;
      print(proc_con.regs_opt.entry12);
      expect(proc_con.regs_opt.entry12 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry13;
      print(proc_con.regs_opt.entry13);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry13 = testData1s;
      print(proc_con.regs_opt.entry13);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry13 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry13 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry13 = testData2s;
      print(proc_con.regs_opt.entry13);
      expect(proc_con.regs_opt.entry13 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry13 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry13 = defalut;
      print(proc_con.regs_opt.entry13);
      expect(proc_con.regs_opt.entry13 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry13 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry14;
      print(proc_con.regs_opt.entry14);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry14 = testData1s;
      print(proc_con.regs_opt.entry14);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry14 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry14 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry14 = testData2s;
      print(proc_con.regs_opt.entry14);
      expect(proc_con.regs_opt.entry14 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry14 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry14 = defalut;
      print(proc_con.regs_opt.entry14);
      expect(proc_con.regs_opt.entry14 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry14 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt.entry15;
      print(proc_con.regs_opt.entry15);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt.entry15 = testData1s;
      print(proc_con.regs_opt.entry15);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt.entry15 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt.entry15 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt.entry15 = testData2s;
      print(proc_con.regs_opt.entry15);
      expect(proc_con.regs_opt.entry15 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry15 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt.entry15 = defalut;
      print(proc_con.regs_opt.entry15);
      expect(proc_con.regs_opt.entry15 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt.entry15 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry01;
      print(proc_con.regs_opt_dual.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry01 = testData1s;
      print(proc_con.regs_opt_dual.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry01 = testData2s;
      print(proc_con.regs_opt_dual.entry01);
      expect(proc_con.regs_opt_dual.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry01 = defalut;
      print(proc_con.regs_opt_dual.entry01);
      expect(proc_con.regs_opt_dual.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry02;
      print(proc_con.regs_opt_dual.entry02);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry02 = testData1s;
      print(proc_con.regs_opt_dual.entry02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry02 = testData2s;
      print(proc_con.regs_opt_dual.entry02);
      expect(proc_con.regs_opt_dual.entry02 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry02 = defalut;
      print(proc_con.regs_opt_dual.entry02);
      expect(proc_con.regs_opt_dual.entry02 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry03;
      print(proc_con.regs_opt_dual.entry03);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry03 = testData1s;
      print(proc_con.regs_opt_dual.entry03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry03 = testData2s;
      print(proc_con.regs_opt_dual.entry03);
      expect(proc_con.regs_opt_dual.entry03 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry03 = defalut;
      print(proc_con.regs_opt_dual.entry03);
      expect(proc_con.regs_opt_dual.entry03 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry04;
      print(proc_con.regs_opt_dual.entry04);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry04 = testData1s;
      print(proc_con.regs_opt_dual.entry04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry04 = testData2s;
      print(proc_con.regs_opt_dual.entry04);
      expect(proc_con.regs_opt_dual.entry04 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry04 = defalut;
      print(proc_con.regs_opt_dual.entry04);
      expect(proc_con.regs_opt_dual.entry04 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry05;
      print(proc_con.regs_opt_dual.entry05);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry05 = testData1s;
      print(proc_con.regs_opt_dual.entry05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry05 = testData2s;
      print(proc_con.regs_opt_dual.entry05);
      expect(proc_con.regs_opt_dual.entry05 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry05 = defalut;
      print(proc_con.regs_opt_dual.entry05);
      expect(proc_con.regs_opt_dual.entry05 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry06;
      print(proc_con.regs_opt_dual.entry06);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry06 = testData1s;
      print(proc_con.regs_opt_dual.entry06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry06 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry06 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry06 = testData2s;
      print(proc_con.regs_opt_dual.entry06);
      expect(proc_con.regs_opt_dual.entry06 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry06 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry06 = defalut;
      print(proc_con.regs_opt_dual.entry06);
      expect(proc_con.regs_opt_dual.entry06 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry07;
      print(proc_con.regs_opt_dual.entry07);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry07 = testData1s;
      print(proc_con.regs_opt_dual.entry07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry07 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry07 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry07 = testData2s;
      print(proc_con.regs_opt_dual.entry07);
      expect(proc_con.regs_opt_dual.entry07 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry07 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry07 = defalut;
      print(proc_con.regs_opt_dual.entry07);
      expect(proc_con.regs_opt_dual.entry07 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry08;
      print(proc_con.regs_opt_dual.entry08);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry08 = testData1s;
      print(proc_con.regs_opt_dual.entry08);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry08 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry08 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry08 = testData2s;
      print(proc_con.regs_opt_dual.entry08);
      expect(proc_con.regs_opt_dual.entry08 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry08 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry08 = defalut;
      print(proc_con.regs_opt_dual.entry08);
      expect(proc_con.regs_opt_dual.entry08 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry08 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry09;
      print(proc_con.regs_opt_dual.entry09);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry09 = testData1s;
      print(proc_con.regs_opt_dual.entry09);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry09 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry09 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry09 = testData2s;
      print(proc_con.regs_opt_dual.entry09);
      expect(proc_con.regs_opt_dual.entry09 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry09 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry09 = defalut;
      print(proc_con.regs_opt_dual.entry09);
      expect(proc_con.regs_opt_dual.entry09 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry09 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry10;
      print(proc_con.regs_opt_dual.entry10);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry10 = testData1s;
      print(proc_con.regs_opt_dual.entry10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry10 = testData2s;
      print(proc_con.regs_opt_dual.entry10);
      expect(proc_con.regs_opt_dual.entry10 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry10 = defalut;
      print(proc_con.regs_opt_dual.entry10);
      expect(proc_con.regs_opt_dual.entry10 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry11;
      print(proc_con.regs_opt_dual.entry11);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry11 = testData1s;
      print(proc_con.regs_opt_dual.entry11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry11 = testData2s;
      print(proc_con.regs_opt_dual.entry11);
      expect(proc_con.regs_opt_dual.entry11 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry11 = defalut;
      print(proc_con.regs_opt_dual.entry11);
      expect(proc_con.regs_opt_dual.entry11 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry12;
      print(proc_con.regs_opt_dual.entry12);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry12 = testData1s;
      print(proc_con.regs_opt_dual.entry12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry12 = testData2s;
      print(proc_con.regs_opt_dual.entry12);
      expect(proc_con.regs_opt_dual.entry12 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry12 = defalut;
      print(proc_con.regs_opt_dual.entry12);
      expect(proc_con.regs_opt_dual.entry12 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry13;
      print(proc_con.regs_opt_dual.entry13);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry13 = testData1s;
      print(proc_con.regs_opt_dual.entry13);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry13 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry13 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry13 = testData2s;
      print(proc_con.regs_opt_dual.entry13);
      expect(proc_con.regs_opt_dual.entry13 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry13 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry13 = defalut;
      print(proc_con.regs_opt_dual.entry13);
      expect(proc_con.regs_opt_dual.entry13 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry13 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry14;
      print(proc_con.regs_opt_dual.entry14);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry14 = testData1s;
      print(proc_con.regs_opt_dual.entry14);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry14 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry14 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry14 = testData2s;
      print(proc_con.regs_opt_dual.entry14);
      expect(proc_con.regs_opt_dual.entry14 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry14 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry14 = defalut;
      print(proc_con.regs_opt_dual.entry14);
      expect(proc_con.regs_opt_dual.entry14 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry14 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry15;
      print(proc_con.regs_opt_dual.entry15);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry15 = testData1s;
      print(proc_con.regs_opt_dual.entry15);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry15 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry15 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry15 = testData2s;
      print(proc_con.regs_opt_dual.entry15);
      expect(proc_con.regs_opt_dual.entry15 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry15 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry15 = defalut;
      print(proc_con.regs_opt_dual.entry15);
      expect(proc_con.regs_opt_dual.entry15 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry15 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry16;
      print(proc_con.regs_opt_dual.entry16);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry16 = testData1s;
      print(proc_con.regs_opt_dual.entry16);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry16 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry16 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry16 = testData2s;
      print(proc_con.regs_opt_dual.entry16);
      expect(proc_con.regs_opt_dual.entry16 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry16 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry16 = defalut;
      print(proc_con.regs_opt_dual.entry16);
      expect(proc_con.regs_opt_dual.entry16 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry16 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry17;
      print(proc_con.regs_opt_dual.entry17);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry17 = testData1s;
      print(proc_con.regs_opt_dual.entry17);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry17 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry17 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry17 = testData2s;
      print(proc_con.regs_opt_dual.entry17);
      expect(proc_con.regs_opt_dual.entry17 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry17 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry17 = defalut;
      print(proc_con.regs_opt_dual.entry17);
      expect(proc_con.regs_opt_dual.entry17 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry17 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry18;
      print(proc_con.regs_opt_dual.entry18);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry18 = testData1s;
      print(proc_con.regs_opt_dual.entry18);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry18 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry18 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry18 = testData2s;
      print(proc_con.regs_opt_dual.entry18);
      expect(proc_con.regs_opt_dual.entry18 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry18 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry18 = defalut;
      print(proc_con.regs_opt_dual.entry18);
      expect(proc_con.regs_opt_dual.entry18 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry18 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry19;
      print(proc_con.regs_opt_dual.entry19);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry19 = testData1s;
      print(proc_con.regs_opt_dual.entry19);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry19 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry19 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry19 = testData2s;
      print(proc_con.regs_opt_dual.entry19);
      expect(proc_con.regs_opt_dual.entry19 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry19 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry19 = defalut;
      print(proc_con.regs_opt_dual.entry19);
      expect(proc_con.regs_opt_dual.entry19 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry19 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry20;
      print(proc_con.regs_opt_dual.entry20);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry20 = testData1s;
      print(proc_con.regs_opt_dual.entry20);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry20 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry20 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry20 = testData2s;
      print(proc_con.regs_opt_dual.entry20);
      expect(proc_con.regs_opt_dual.entry20 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry20 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry20 = defalut;
      print(proc_con.regs_opt_dual.entry20);
      expect(proc_con.regs_opt_dual.entry20 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry20 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry21;
      print(proc_con.regs_opt_dual.entry21);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry21 = testData1s;
      print(proc_con.regs_opt_dual.entry21);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry21 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry21 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry21 = testData2s;
      print(proc_con.regs_opt_dual.entry21);
      expect(proc_con.regs_opt_dual.entry21 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry21 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry21 = defalut;
      print(proc_con.regs_opt_dual.entry21);
      expect(proc_con.regs_opt_dual.entry21 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry21 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry22;
      print(proc_con.regs_opt_dual.entry22);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry22 = testData1s;
      print(proc_con.regs_opt_dual.entry22);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry22 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry22 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry22 = testData2s;
      print(proc_con.regs_opt_dual.entry22);
      expect(proc_con.regs_opt_dual.entry22 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry22 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry22 = defalut;
      print(proc_con.regs_opt_dual.entry22);
      expect(proc_con.regs_opt_dual.entry22 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry22 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry23;
      print(proc_con.regs_opt_dual.entry23);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry23 = testData1s;
      print(proc_con.regs_opt_dual.entry23);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry23 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry23 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry23 = testData2s;
      print(proc_con.regs_opt_dual.entry23);
      expect(proc_con.regs_opt_dual.entry23 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry23 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry23 = defalut;
      print(proc_con.regs_opt_dual.entry23);
      expect(proc_con.regs_opt_dual.entry23 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry23 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry24;
      print(proc_con.regs_opt_dual.entry24);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry24 = testData1s;
      print(proc_con.regs_opt_dual.entry24);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry24 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry24 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry24 = testData2s;
      print(proc_con.regs_opt_dual.entry24);
      expect(proc_con.regs_opt_dual.entry24 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry24 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry24 = defalut;
      print(proc_con.regs_opt_dual.entry24);
      expect(proc_con.regs_opt_dual.entry24 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry24 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry25;
      print(proc_con.regs_opt_dual.entry25);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry25 = testData1s;
      print(proc_con.regs_opt_dual.entry25);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry25 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry25 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry25 = testData2s;
      print(proc_con.regs_opt_dual.entry25);
      expect(proc_con.regs_opt_dual.entry25 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry25 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry25 = defalut;
      print(proc_con.regs_opt_dual.entry25);
      expect(proc_con.regs_opt_dual.entry25 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry25 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry26;
      print(proc_con.regs_opt_dual.entry26);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry26 = testData1s;
      print(proc_con.regs_opt_dual.entry26);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry26 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry26 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry26 = testData2s;
      print(proc_con.regs_opt_dual.entry26);
      expect(proc_con.regs_opt_dual.entry26 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry26 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry26 = defalut;
      print(proc_con.regs_opt_dual.entry26);
      expect(proc_con.regs_opt_dual.entry26 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry26 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry27;
      print(proc_con.regs_opt_dual.entry27);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry27 = testData1s;
      print(proc_con.regs_opt_dual.entry27);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry27 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry27 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry27 = testData2s;
      print(proc_con.regs_opt_dual.entry27);
      expect(proc_con.regs_opt_dual.entry27 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry27 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry27 = defalut;
      print(proc_con.regs_opt_dual.entry27);
      expect(proc_con.regs_opt_dual.entry27 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry27 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry28;
      print(proc_con.regs_opt_dual.entry28);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry28 = testData1s;
      print(proc_con.regs_opt_dual.entry28);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry28 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry28 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry28 = testData2s;
      print(proc_con.regs_opt_dual.entry28);
      expect(proc_con.regs_opt_dual.entry28 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry28 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry28 = defalut;
      print(proc_con.regs_opt_dual.entry28);
      expect(proc_con.regs_opt_dual.entry28 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry28 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry29;
      print(proc_con.regs_opt_dual.entry29);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry29 = testData1s;
      print(proc_con.regs_opt_dual.entry29);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry29 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry29 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry29 = testData2s;
      print(proc_con.regs_opt_dual.entry29);
      expect(proc_con.regs_opt_dual.entry29 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry29 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry29 = defalut;
      print(proc_con.regs_opt_dual.entry29);
      expect(proc_con.regs_opt_dual.entry29 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry29 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry30;
      print(proc_con.regs_opt_dual.entry30);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry30 = testData1s;
      print(proc_con.regs_opt_dual.entry30);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry30 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry30 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry30 = testData2s;
      print(proc_con.regs_opt_dual.entry30);
      expect(proc_con.regs_opt_dual.entry30 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry30 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry30 = defalut;
      print(proc_con.regs_opt_dual.entry30);
      expect(proc_con.regs_opt_dual.entry30 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry30 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry31;
      print(proc_con.regs_opt_dual.entry31);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry31 = testData1s;
      print(proc_con.regs_opt_dual.entry31);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry31 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry31 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry31 = testData2s;
      print(proc_con.regs_opt_dual.entry31);
      expect(proc_con.regs_opt_dual.entry31 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry31 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry31 = defalut;
      print(proc_con.regs_opt_dual.entry31);
      expect(proc_con.regs_opt_dual.entry31 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry31 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.regs_opt_dual.entry32;
      print(proc_con.regs_opt_dual.entry32);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.regs_opt_dual.entry32 = testData1s;
      print(proc_con.regs_opt_dual.entry32);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.regs_opt_dual.entry32 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.regs_opt_dual.entry32 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.regs_opt_dual.entry32 = testData2s;
      print(proc_con.regs_opt_dual.entry32);
      expect(proc_con.regs_opt_dual.entry32 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry32 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.regs_opt_dual.entry32 = defalut;
      print(proc_con.regs_opt_dual.entry32);
      expect(proc_con.regs_opt_dual.entry32 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.regs_opt_dual.entry32 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.streopncls.entry01;
      print(proc_con.streopncls.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.streopncls.entry01 = testData1s;
      print(proc_con.streopncls.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.streopncls.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.streopncls.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.streopncls.entry01 = testData2s;
      print(proc_con.streopncls.entry01);
      expect(proc_con.streopncls.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.streopncls.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.streopncls.entry01 = defalut;
      print(proc_con.streopncls.entry01);
      expect(proc_con.streopncls.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.streopncls.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.streopncls.entry02;
      print(proc_con.streopncls.entry02);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.streopncls.entry02 = testData1s;
      print(proc_con.streopncls.entry02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.streopncls.entry02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.streopncls.entry02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.streopncls.entry02 = testData2s;
      print(proc_con.streopncls.entry02);
      expect(proc_con.streopncls.entry02 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.streopncls.entry02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.streopncls.entry02 = defalut;
      print(proc_con.streopncls.entry02);
      expect(proc_con.streopncls.entry02 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.streopncls.entry02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.menu.entry01;
      print(proc_con.menu.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.menu.entry01 = testData1s;
      print(proc_con.menu.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.menu.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.menu.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.menu.entry01 = testData2s;
      print(proc_con.menu.entry01);
      expect(proc_con.menu.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.menu.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.menu.entry01 = defalut;
      print(proc_con.menu.entry01);
      expect(proc_con.menu.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.menu.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry01;
      print(proc_con.startup.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry01 = testData1s;
      print(proc_con.startup.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry01 = testData2s;
      print(proc_con.startup.entry01);
      expect(proc_con.startup.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry01 = defalut;
      print(proc_con.startup.entry01);
      expect(proc_con.startup.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry02;
      print(proc_con.startup.entry02);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry02 = testData1s;
      print(proc_con.startup.entry02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry02 = testData2s;
      print(proc_con.startup.entry02);
      expect(proc_con.startup.entry02 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry02 = defalut;
      print(proc_con.startup.entry02);
      expect(proc_con.startup.entry02 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry03;
      print(proc_con.startup.entry03);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry03 = testData1s;
      print(proc_con.startup.entry03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry03 = testData2s;
      print(proc_con.startup.entry03);
      expect(proc_con.startup.entry03 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry03 = defalut;
      print(proc_con.startup.entry03);
      expect(proc_con.startup.entry03 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry04;
      print(proc_con.startup.entry04);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry04 = testData1s;
      print(proc_con.startup.entry04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry04 = testData2s;
      print(proc_con.startup.entry04);
      expect(proc_con.startup.entry04 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry04 = defalut;
      print(proc_con.startup.entry04);
      expect(proc_con.startup.entry04 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry05;
      print(proc_con.startup.entry05);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry05 = testData1s;
      print(proc_con.startup.entry05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry05 = testData2s;
      print(proc_con.startup.entry05);
      expect(proc_con.startup.entry05 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry05 = defalut;
      print(proc_con.startup.entry05);
      expect(proc_con.startup.entry05 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry06;
      print(proc_con.startup.entry06);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry06 = testData1s;
      print(proc_con.startup.entry06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry06 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry06 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry06 = testData2s;
      print(proc_con.startup.entry06);
      expect(proc_con.startup.entry06 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry06 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry06 = defalut;
      print(proc_con.startup.entry06);
      expect(proc_con.startup.entry06 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry07;
      print(proc_con.startup.entry07);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry07 = testData1s;
      print(proc_con.startup.entry07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry07 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry07 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry07 = testData2s;
      print(proc_con.startup.entry07);
      expect(proc_con.startup.entry07 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry07 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry07 = defalut;
      print(proc_con.startup.entry07);
      expect(proc_con.startup.entry07 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry08;
      print(proc_con.startup.entry08);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry08 = testData1s;
      print(proc_con.startup.entry08);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry08 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry08 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry08 = testData2s;
      print(proc_con.startup.entry08);
      expect(proc_con.startup.entry08 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry08 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry08 = defalut;
      print(proc_con.startup.entry08);
      expect(proc_con.startup.entry08 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry08 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry09;
      print(proc_con.startup.entry09);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry09 = testData1s;
      print(proc_con.startup.entry09);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry09 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry09 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry09 = testData2s;
      print(proc_con.startup.entry09);
      expect(proc_con.startup.entry09 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry09 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry09 = defalut;
      print(proc_con.startup.entry09);
      expect(proc_con.startup.entry09 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry09 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry10;
      print(proc_con.startup.entry10);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry10 = testData1s;
      print(proc_con.startup.entry10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry10 = testData2s;
      print(proc_con.startup.entry10);
      expect(proc_con.startup.entry10 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry10 = defalut;
      print(proc_con.startup.entry10);
      expect(proc_con.startup.entry10 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry11;
      print(proc_con.startup.entry11);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry11 = testData1s;
      print(proc_con.startup.entry11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry11 = testData2s;
      print(proc_con.startup.entry11);
      expect(proc_con.startup.entry11 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry11 = defalut;
      print(proc_con.startup.entry11);
      expect(proc_con.startup.entry11 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry12;
      print(proc_con.startup.entry12);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry12 = testData1s;
      print(proc_con.startup.entry12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry12 = testData2s;
      print(proc_con.startup.entry12);
      expect(proc_con.startup.entry12 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry12 = defalut;
      print(proc_con.startup.entry12);
      expect(proc_con.startup.entry12 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry13;
      print(proc_con.startup.entry13);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry13 = testData1s;
      print(proc_con.startup.entry13);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry13 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry13 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry13 = testData2s;
      print(proc_con.startup.entry13);
      expect(proc_con.startup.entry13 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry13 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry13 = defalut;
      print(proc_con.startup.entry13);
      expect(proc_con.startup.entry13 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry13 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry14;
      print(proc_con.startup.entry14);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry14 = testData1s;
      print(proc_con.startup.entry14);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry14 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry14 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry14 = testData2s;
      print(proc_con.startup.entry14);
      expect(proc_con.startup.entry14 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry14 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry14 = defalut;
      print(proc_con.startup.entry14);
      expect(proc_con.startup.entry14 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry14 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry15;
      print(proc_con.startup.entry15);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry15 = testData1s;
      print(proc_con.startup.entry15);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry15 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry15 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry15 = testData2s;
      print(proc_con.startup.entry15);
      expect(proc_con.startup.entry15 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry15 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry15 = defalut;
      print(proc_con.startup.entry15);
      expect(proc_con.startup.entry15 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry15 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry16;
      print(proc_con.startup.entry16);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry16 = testData1s;
      print(proc_con.startup.entry16);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry16 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry16 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry16 = testData2s;
      print(proc_con.startup.entry16);
      expect(proc_con.startup.entry16 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry16 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry16 = defalut;
      print(proc_con.startup.entry16);
      expect(proc_con.startup.entry16 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry16 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry17;
      print(proc_con.startup.entry17);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry17 = testData1s;
      print(proc_con.startup.entry17);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry17 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry17 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry17 = testData2s;
      print(proc_con.startup.entry17);
      expect(proc_con.startup.entry17 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry17 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry17 = defalut;
      print(proc_con.startup.entry17);
      expect(proc_con.startup.entry17 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry17 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry18;
      print(proc_con.startup.entry18);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry18 = testData1s;
      print(proc_con.startup.entry18);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry18 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry18 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry18 = testData2s;
      print(proc_con.startup.entry18);
      expect(proc_con.startup.entry18 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry18 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry18 = defalut;
      print(proc_con.startup.entry18);
      expect(proc_con.startup.entry18 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry18 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry19;
      print(proc_con.startup.entry19);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry19 = testData1s;
      print(proc_con.startup.entry19);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry19 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry19 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry19 = testData2s;
      print(proc_con.startup.entry19);
      expect(proc_con.startup.entry19 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry19 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry19 = defalut;
      print(proc_con.startup.entry19);
      expect(proc_con.startup.entry19 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry19 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry20;
      print(proc_con.startup.entry20);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry20 = testData1s;
      print(proc_con.startup.entry20);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry20 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry20 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry20 = testData2s;
      print(proc_con.startup.entry20);
      expect(proc_con.startup.entry20 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry20 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry20 = defalut;
      print(proc_con.startup.entry20);
      expect(proc_con.startup.entry20 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry20 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry21;
      print(proc_con.startup.entry21);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry21 = testData1s;
      print(proc_con.startup.entry21);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry21 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry21 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry21 = testData2s;
      print(proc_con.startup.entry21);
      expect(proc_con.startup.entry21 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry21 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry21 = defalut;
      print(proc_con.startup.entry21);
      expect(proc_con.startup.entry21 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry21 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry22;
      print(proc_con.startup.entry22);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry22 = testData1s;
      print(proc_con.startup.entry22);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry22 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry22 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry22 = testData2s;
      print(proc_con.startup.entry22);
      expect(proc_con.startup.entry22 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry22 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry22 = defalut;
      print(proc_con.startup.entry22);
      expect(proc_con.startup.entry22 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry22 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry23;
      print(proc_con.startup.entry23);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry23 = testData1s;
      print(proc_con.startup.entry23);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry23 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry23 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry23 = testData2s;
      print(proc_con.startup.entry23);
      expect(proc_con.startup.entry23 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry23 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry23 = defalut;
      print(proc_con.startup.entry23);
      expect(proc_con.startup.entry23 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry23 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry24;
      print(proc_con.startup.entry24);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry24 = testData1s;
      print(proc_con.startup.entry24);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry24 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry24 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry24 = testData2s;
      print(proc_con.startup.entry24);
      expect(proc_con.startup.entry24 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry24 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry24 = defalut;
      print(proc_con.startup.entry24);
      expect(proc_con.startup.entry24 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry24 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry25;
      print(proc_con.startup.entry25);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry25 = testData1s;
      print(proc_con.startup.entry25);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry25 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry25 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry25 = testData2s;
      print(proc_con.startup.entry25);
      expect(proc_con.startup.entry25 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry25 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry25 = defalut;
      print(proc_con.startup.entry25);
      expect(proc_con.startup.entry25 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry25 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry26;
      print(proc_con.startup.entry26);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry26 = testData1s;
      print(proc_con.startup.entry26);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry26 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry26 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry26 = testData2s;
      print(proc_con.startup.entry26);
      expect(proc_con.startup.entry26 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry26 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry26 = defalut;
      print(proc_con.startup.entry26);
      expect(proc_con.startup.entry26 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry26 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry27;
      print(proc_con.startup.entry27);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry27 = testData1s;
      print(proc_con.startup.entry27);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry27 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry27 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry27 = testData2s;
      print(proc_con.startup.entry27);
      expect(proc_con.startup.entry27 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry27 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry27 = defalut;
      print(proc_con.startup.entry27);
      expect(proc_con.startup.entry27 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry27 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry28;
      print(proc_con.startup.entry28);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry28 = testData1s;
      print(proc_con.startup.entry28);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry28 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry28 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry28 = testData2s;
      print(proc_con.startup.entry28);
      expect(proc_con.startup.entry28 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry28 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry28 = defalut;
      print(proc_con.startup.entry28);
      expect(proc_con.startup.entry28 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry28 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry29;
      print(proc_con.startup.entry29);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry29 = testData1s;
      print(proc_con.startup.entry29);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry29 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry29 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry29 = testData2s;
      print(proc_con.startup.entry29);
      expect(proc_con.startup.entry29 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry29 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry29 = defalut;
      print(proc_con.startup.entry29);
      expect(proc_con.startup.entry29 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry29 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry30;
      print(proc_con.startup.entry30);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry30 = testData1s;
      print(proc_con.startup.entry30);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry30 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry30 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry30 = testData2s;
      print(proc_con.startup.entry30);
      expect(proc_con.startup.entry30 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry30 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry30 = defalut;
      print(proc_con.startup.entry30);
      expect(proc_con.startup.entry30 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry30 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry31;
      print(proc_con.startup.entry31);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry31 = testData1s;
      print(proc_con.startup.entry31);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry31 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry31 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry31 = testData2s;
      print(proc_con.startup.entry31);
      expect(proc_con.startup.entry31 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry31 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry31 = defalut;
      print(proc_con.startup.entry31);
      expect(proc_con.startup.entry31 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry31 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry32;
      print(proc_con.startup.entry32);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry32 = testData1s;
      print(proc_con.startup.entry32);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry32 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry32 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry32 = testData2s;
      print(proc_con.startup.entry32);
      expect(proc_con.startup.entry32 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry32 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry32 = defalut;
      print(proc_con.startup.entry32);
      expect(proc_con.startup.entry32 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry32 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry33;
      print(proc_con.startup.entry33);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry33 = testData1s;
      print(proc_con.startup.entry33);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry33 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry33 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry33 = testData2s;
      print(proc_con.startup.entry33);
      expect(proc_con.startup.entry33 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry33 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry33 = defalut;
      print(proc_con.startup.entry33);
      expect(proc_con.startup.entry33 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry33 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry34;
      print(proc_con.startup.entry34);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry34 = testData1s;
      print(proc_con.startup.entry34);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry34 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry34 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry34 = testData2s;
      print(proc_con.startup.entry34);
      expect(proc_con.startup.entry34 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry34 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry34 = defalut;
      print(proc_con.startup.entry34);
      expect(proc_con.startup.entry34 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry34 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry35;
      print(proc_con.startup.entry35);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry35 = testData1s;
      print(proc_con.startup.entry35);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry35 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry35 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry35 = testData2s;
      print(proc_con.startup.entry35);
      expect(proc_con.startup.entry35 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry35 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry35 = defalut;
      print(proc_con.startup.entry35);
      expect(proc_con.startup.entry35 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry35 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry36;
      print(proc_con.startup.entry36);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry36 = testData1s;
      print(proc_con.startup.entry36);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry36 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry36 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry36 = testData2s;
      print(proc_con.startup.entry36);
      expect(proc_con.startup.entry36 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry36 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry36 = defalut;
      print(proc_con.startup.entry36);
      expect(proc_con.startup.entry36 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry36 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry37;
      print(proc_con.startup.entry37);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry37 = testData1s;
      print(proc_con.startup.entry37);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry37 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry37 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry37 = testData2s;
      print(proc_con.startup.entry37);
      expect(proc_con.startup.entry37 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry37 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry37 = defalut;
      print(proc_con.startup.entry37);
      expect(proc_con.startup.entry37 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry37 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry38;
      print(proc_con.startup.entry38);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry38 = testData1s;
      print(proc_con.startup.entry38);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry38 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry38 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry38 = testData2s;
      print(proc_con.startup.entry38);
      expect(proc_con.startup.entry38 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry38 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry38 = defalut;
      print(proc_con.startup.entry38);
      expect(proc_con.startup.entry38 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry38 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry39;
      print(proc_con.startup.entry39);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry39 = testData1s;
      print(proc_con.startup.entry39);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry39 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry39 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry39 = testData2s;
      print(proc_con.startup.entry39);
      expect(proc_con.startup.entry39 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry39 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry39 = defalut;
      print(proc_con.startup.entry39);
      expect(proc_con.startup.entry39 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry39 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry40;
      print(proc_con.startup.entry40);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry40 = testData1s;
      print(proc_con.startup.entry40);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry40 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry40 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry40 = testData2s;
      print(proc_con.startup.entry40);
      expect(proc_con.startup.entry40 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry40 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry40 = defalut;
      print(proc_con.startup.entry40);
      expect(proc_con.startup.entry40 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry40 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.startup.entry41;
      print(proc_con.startup.entry41);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.startup.entry41 = testData1s;
      print(proc_con.startup.entry41);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.startup.entry41 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.startup.entry41 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.startup.entry41 = testData2s;
      print(proc_con.startup.entry41);
      expect(proc_con.startup.entry41 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry41 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.startup.entry41 = defalut;
      print(proc_con.startup.entry41);
      expect(proc_con.startup.entry41 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.startup.entry41 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.another1.entry01;
      print(proc_con.another1.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.another1.entry01 = testData1s;
      print(proc_con.another1.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.another1.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.another1.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.another1.entry01 = testData2s;
      print(proc_con.another1.entry01);
      expect(proc_con.another1.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another1.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.another1.entry01 = defalut;
      print(proc_con.another1.entry01);
      expect(proc_con.another1.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another1.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.another1.entry02;
      print(proc_con.another1.entry02);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.another1.entry02 = testData1s;
      print(proc_con.another1.entry02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.another1.entry02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.another1.entry02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.another1.entry02 = testData2s;
      print(proc_con.another1.entry02);
      expect(proc_con.another1.entry02 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another1.entry02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.another1.entry02 = defalut;
      print(proc_con.another1.entry02);
      expect(proc_con.another1.entry02 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another1.entry02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.another1.entry03;
      print(proc_con.another1.entry03);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.another1.entry03 = testData1s;
      print(proc_con.another1.entry03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.another1.entry03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.another1.entry03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.another1.entry03 = testData2s;
      print(proc_con.another1.entry03);
      expect(proc_con.another1.entry03 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another1.entry03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.another1.entry03 = defalut;
      print(proc_con.another1.entry03);
      expect(proc_con.another1.entry03 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another1.entry03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.another2.entry01;
      print(proc_con.another2.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.another2.entry01 = testData1s;
      print(proc_con.another2.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.another2.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.another2.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.another2.entry01 = testData2s;
      print(proc_con.another2.entry01);
      expect(proc_con.another2.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.another2.entry01 = defalut;
      print(proc_con.another2.entry01);
      expect(proc_con.another2.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.another2.entry02;
      print(proc_con.another2.entry02);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.another2.entry02 = testData1s;
      print(proc_con.another2.entry02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.another2.entry02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.another2.entry02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.another2.entry02 = testData2s;
      print(proc_con.another2.entry02);
      expect(proc_con.another2.entry02 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.another2.entry02 = defalut;
      print(proc_con.another2.entry02);
      expect(proc_con.another2.entry02 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.another2.entry03;
      print(proc_con.another2.entry03);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.another2.entry03 = testData1s;
      print(proc_con.another2.entry03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.another2.entry03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.another2.entry03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.another2.entry03 = testData2s;
      print(proc_con.another2.entry03);
      expect(proc_con.another2.entry03 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.another2.entry03 = defalut;
      print(proc_con.another2.entry03);
      expect(proc_con.another2.entry03 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.another2.entry04;
      print(proc_con.another2.entry04);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.another2.entry04 = testData1s;
      print(proc_con.another2.entry04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.another2.entry04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.another2.entry04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.another2.entry04 = testData2s;
      print(proc_con.another2.entry04);
      expect(proc_con.another2.entry04 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.another2.entry04 = defalut;
      print(proc_con.another2.entry04);
      expect(proc_con.another2.entry04 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.another2.entry05;
      print(proc_con.another2.entry05);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.another2.entry05 = testData1s;
      print(proc_con.another2.entry05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.another2.entry05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.another2.entry05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.another2.entry05 = testData2s;
      print(proc_con.another2.entry05);
      expect(proc_con.another2.entry05 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.another2.entry05 = defalut;
      print(proc_con.another2.entry05);
      expect(proc_con.another2.entry05 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.another2.entry06;
      print(proc_con.another2.entry06);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.another2.entry06 = testData1s;
      print(proc_con.another2.entry06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.another2.entry06 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.another2.entry06 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.another2.entry06 = testData2s;
      print(proc_con.another2.entry06);
      expect(proc_con.another2.entry06 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry06 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.another2.entry06 = defalut;
      print(proc_con.another2.entry06);
      expect(proc_con.another2.entry06 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.another2.entry07;
      print(proc_con.another2.entry07);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.another2.entry07 = testData1s;
      print(proc_con.another2.entry07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.another2.entry07 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.another2.entry07 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.another2.entry07 = testData2s;
      print(proc_con.another2.entry07);
      expect(proc_con.another2.entry07 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry07 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.another2.entry07 = defalut;
      print(proc_con.another2.entry07);
      expect(proc_con.another2.entry07 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.another2.entry07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.simple2stf.entry01;
      print(proc_con.simple2stf.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.simple2stf.entry01 = testData1s;
      print(proc_con.simple2stf.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.simple2stf.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.simple2stf.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.simple2stf.entry01 = testData2s;
      print(proc_con.simple2stf.entry01);
      expect(proc_con.simple2stf.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.simple2stf.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.simple2stf.entry01 = defalut;
      print(proc_con.simple2stf.entry01);
      expect(proc_con.simple2stf.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.simple2stf.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.simple2stf.entry02;
      print(proc_con.simple2stf.entry02);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.simple2stf.entry02 = testData1s;
      print(proc_con.simple2stf.entry02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.simple2stf.entry02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.simple2stf.entry02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.simple2stf.entry02 = testData2s;
      print(proc_con.simple2stf.entry02);
      expect(proc_con.simple2stf.entry02 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.simple2stf.entry02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.simple2stf.entry02 = defalut;
      print(proc_con.simple2stf.entry02);
      expect(proc_con.simple2stf.entry02 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.simple2stf.entry02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.simple2stf_dual.entry01;
      print(proc_con.simple2stf_dual.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.simple2stf_dual.entry01 = testData1s;
      print(proc_con.simple2stf_dual.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.simple2stf_dual.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.simple2stf_dual.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.simple2stf_dual.entry01 = testData2s;
      print(proc_con.simple2stf_dual.entry01);
      expect(proc_con.simple2stf_dual.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.simple2stf_dual.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.simple2stf_dual.entry01 = defalut;
      print(proc_con.simple2stf_dual.entry01);
      expect(proc_con.simple2stf_dual.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.simple2stf_dual.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.bank_prg.entry01;
      print(proc_con.bank_prg.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.bank_prg.entry01 = testData1s;
      print(proc_con.bank_prg.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.bank_prg.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.bank_prg.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.bank_prg.entry01 = testData2s;
      print(proc_con.bank_prg.entry01);
      expect(proc_con.bank_prg.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.bank_prg.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.bank_prg.entry01 = defalut;
      print(proc_con.bank_prg.entry01);
      expect(proc_con.bank_prg.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.bank_prg.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.proc_id.sound;
      print(proc_con.proc_id.sound);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.proc_id.sound = testData1;
      print(proc_con.proc_id.sound);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.proc_id.sound == testData1, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.proc_id.sound == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.proc_id.sound = testData2;
      print(proc_con.proc_id.sound);
      expect(proc_con.proc_id.sound == testData2, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.proc_id.sound == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.proc_id.sound = defalut;
      print(proc_con.proc_id.sound);
      expect(proc_con.proc_id.sound == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.proc_id.sound == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.proc_id.sound2;
      print(proc_con.proc_id.sound2);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.proc_id.sound2 = testData1;
      print(proc_con.proc_id.sound2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.proc_id.sound2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.proc_id.sound2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.proc_id.sound2 = testData2;
      print(proc_con.proc_id.sound2);
      expect(proc_con.proc_id.sound2 == testData2, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.proc_id.sound2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.proc_id.sound2 = defalut;
      print(proc_con.proc_id.sound2);
      expect(proc_con.proc_id.sound2 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.proc_id.sound2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry01;
      print(proc_con.FenceOver.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry01 = testData1s;
      print(proc_con.FenceOver.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry01 = testData2s;
      print(proc_con.FenceOver.entry01);
      expect(proc_con.FenceOver.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry01 = defalut;
      print(proc_con.FenceOver.entry01);
      expect(proc_con.FenceOver.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry02;
      print(proc_con.FenceOver.entry02);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry02 = testData1s;
      print(proc_con.FenceOver.entry02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry02 = testData2s;
      print(proc_con.FenceOver.entry02);
      expect(proc_con.FenceOver.entry02 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry02 = defalut;
      print(proc_con.FenceOver.entry02);
      expect(proc_con.FenceOver.entry02 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

    test('00138_element_check_00115', () async {
      print("\n********** テスト実行：00138_element_check_00115 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry03;
      print(proc_con.FenceOver.entry03);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry03 = testData1s;
      print(proc_con.FenceOver.entry03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry03 = testData2s;
      print(proc_con.FenceOver.entry03);
      expect(proc_con.FenceOver.entry03 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry03 = defalut;
      print(proc_con.FenceOver.entry03);
      expect(proc_con.FenceOver.entry03 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00138_element_check_00115 **********\n\n");
    });

    test('00139_element_check_00116', () async {
      print("\n********** テスト実行：00139_element_check_00116 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry04;
      print(proc_con.FenceOver.entry04);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry04 = testData1s;
      print(proc_con.FenceOver.entry04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry04 = testData2s;
      print(proc_con.FenceOver.entry04);
      expect(proc_con.FenceOver.entry04 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry04 = defalut;
      print(proc_con.FenceOver.entry04);
      expect(proc_con.FenceOver.entry04 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00139_element_check_00116 **********\n\n");
    });

    test('00140_element_check_00117', () async {
      print("\n********** テスト実行：00140_element_check_00117 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry05;
      print(proc_con.FenceOver.entry05);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry05 = testData1s;
      print(proc_con.FenceOver.entry05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry05 = testData2s;
      print(proc_con.FenceOver.entry05);
      expect(proc_con.FenceOver.entry05 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry05 = defalut;
      print(proc_con.FenceOver.entry05);
      expect(proc_con.FenceOver.entry05 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00140_element_check_00117 **********\n\n");
    });

    test('00141_element_check_00118', () async {
      print("\n********** テスト実行：00141_element_check_00118 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry06;
      print(proc_con.FenceOver.entry06);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry06 = testData1s;
      print(proc_con.FenceOver.entry06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry06 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry06 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry06 = testData2s;
      print(proc_con.FenceOver.entry06);
      expect(proc_con.FenceOver.entry06 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry06 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry06 = defalut;
      print(proc_con.FenceOver.entry06);
      expect(proc_con.FenceOver.entry06 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00141_element_check_00118 **********\n\n");
    });

    test('00142_element_check_00119', () async {
      print("\n********** テスト実行：00142_element_check_00119 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry07;
      print(proc_con.FenceOver.entry07);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry07 = testData1s;
      print(proc_con.FenceOver.entry07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry07 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry07 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry07 = testData2s;
      print(proc_con.FenceOver.entry07);
      expect(proc_con.FenceOver.entry07 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry07 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry07 = defalut;
      print(proc_con.FenceOver.entry07);
      expect(proc_con.FenceOver.entry07 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00142_element_check_00119 **********\n\n");
    });

    test('00143_element_check_00120', () async {
      print("\n********** テスト実行：00143_element_check_00120 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry08;
      print(proc_con.FenceOver.entry08);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry08 = testData1s;
      print(proc_con.FenceOver.entry08);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry08 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry08 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry08 = testData2s;
      print(proc_con.FenceOver.entry08);
      expect(proc_con.FenceOver.entry08 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry08 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry08 = defalut;
      print(proc_con.FenceOver.entry08);
      expect(proc_con.FenceOver.entry08 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry08 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00143_element_check_00120 **********\n\n");
    });

    test('00144_element_check_00121', () async {
      print("\n********** テスト実行：00144_element_check_00121 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry09;
      print(proc_con.FenceOver.entry09);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry09 = testData1s;
      print(proc_con.FenceOver.entry09);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry09 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry09 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry09 = testData2s;
      print(proc_con.FenceOver.entry09);
      expect(proc_con.FenceOver.entry09 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry09 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry09 = defalut;
      print(proc_con.FenceOver.entry09);
      expect(proc_con.FenceOver.entry09 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry09 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00144_element_check_00121 **********\n\n");
    });

    test('00145_element_check_00122', () async {
      print("\n********** テスト実行：00145_element_check_00122 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry10;
      print(proc_con.FenceOver.entry10);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry10 = testData1s;
      print(proc_con.FenceOver.entry10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry10 = testData2s;
      print(proc_con.FenceOver.entry10);
      expect(proc_con.FenceOver.entry10 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry10 = defalut;
      print(proc_con.FenceOver.entry10);
      expect(proc_con.FenceOver.entry10 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00145_element_check_00122 **********\n\n");
    });

    test('00146_element_check_00123', () async {
      print("\n********** テスト実行：00146_element_check_00123 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry11;
      print(proc_con.FenceOver.entry11);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry11 = testData1s;
      print(proc_con.FenceOver.entry11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry11 = testData2s;
      print(proc_con.FenceOver.entry11);
      expect(proc_con.FenceOver.entry11 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry11 = defalut;
      print(proc_con.FenceOver.entry11);
      expect(proc_con.FenceOver.entry11 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00146_element_check_00123 **********\n\n");
    });

    test('00147_element_check_00124', () async {
      print("\n********** テスト実行：00147_element_check_00124 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry12;
      print(proc_con.FenceOver.entry12);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry12 = testData1s;
      print(proc_con.FenceOver.entry12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry12 = testData2s;
      print(proc_con.FenceOver.entry12);
      expect(proc_con.FenceOver.entry12 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry12 = defalut;
      print(proc_con.FenceOver.entry12);
      expect(proc_con.FenceOver.entry12 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00147_element_check_00124 **********\n\n");
    });

    test('00148_element_check_00125', () async {
      print("\n********** テスト実行：00148_element_check_00125 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry13;
      print(proc_con.FenceOver.entry13);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry13 = testData1s;
      print(proc_con.FenceOver.entry13);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry13 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry13 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry13 = testData2s;
      print(proc_con.FenceOver.entry13);
      expect(proc_con.FenceOver.entry13 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry13 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry13 = defalut;
      print(proc_con.FenceOver.entry13);
      expect(proc_con.FenceOver.entry13 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry13 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00148_element_check_00125 **********\n\n");
    });

    test('00149_element_check_00126', () async {
      print("\n********** テスト実行：00149_element_check_00126 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.FenceOver.entry14;
      print(proc_con.FenceOver.entry14);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.FenceOver.entry14 = testData1s;
      print(proc_con.FenceOver.entry14);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.FenceOver.entry14 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.FenceOver.entry14 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.FenceOver.entry14 = testData2s;
      print(proc_con.FenceOver.entry14);
      expect(proc_con.FenceOver.entry14 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry14 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.FenceOver.entry14 = defalut;
      print(proc_con.FenceOver.entry14);
      expect(proc_con.FenceOver.entry14 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.FenceOver.entry14 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00149_element_check_00126 **********\n\n");
    });

    test('00150_element_check_00127', () async {
      print("\n********** テスト実行：00150_element_check_00127 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.EjConf.entry01;
      print(proc_con.EjConf.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.EjConf.entry01 = testData1s;
      print(proc_con.EjConf.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.EjConf.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.EjConf.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.EjConf.entry01 = testData2s;
      print(proc_con.EjConf.entry01);
      expect(proc_con.EjConf.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.EjConf.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.EjConf.entry01 = defalut;
      print(proc_con.EjConf.entry01);
      expect(proc_con.EjConf.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.EjConf.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00150_element_check_00127 **********\n\n");
    });

    test('00151_element_check_00128', () async {
      print("\n********** テスト実行：00151_element_check_00128 **********");

      proc_con = Proc_conJsonFile();
      allPropatyCheckInit(proc_con);

      // ①loadを実行する。
      await proc_con.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = proc_con.CashRecycle.entry01;
      print(proc_con.CashRecycle.entry01);

      // ②指定したプロパティにテストデータ1を書き込む。
      proc_con.CashRecycle.entry01 = testData1s;
      print(proc_con.CashRecycle.entry01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(proc_con.CashRecycle.entry01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await proc_con.save();
      await proc_con.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(proc_con.CashRecycle.entry01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      proc_con.CashRecycle.entry01 = testData2s;
      print(proc_con.CashRecycle.entry01);
      expect(proc_con.CashRecycle.entry01 == testData2s, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.CashRecycle.entry01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      proc_con.CashRecycle.entry01 = defalut;
      print(proc_con.CashRecycle.entry01);
      expect(proc_con.CashRecycle.entry01 == defalut, true);
      await proc_con.save();
      await proc_con.load();
      expect(proc_con.CashRecycle.entry01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(proc_con, true);

      print("********** テスト終了：00151_element_check_00128 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Proc_conJsonFile test)
{
  expect(test.regs.entry01, "");
  expect(test.regs.entry02, "");
  expect(test.regs.entry03, "");
  expect(test.regs.entry04, "");
  expect(test.regs.entry05, "");
  expect(test.regs_opt.entry01, "");
  expect(test.regs_opt.entry02, "");
  expect(test.regs_opt.entry03, "");
  expect(test.regs_opt.entry04, "");
  expect(test.regs_opt.entry05, "");
  expect(test.regs_opt.entry06, "");
  expect(test.regs_opt.entry07, "");
  expect(test.regs_opt.entry08, "");
  expect(test.regs_opt.entry09, "");
  expect(test.regs_opt.entry10, "");
  expect(test.regs_opt.entry11, "");
  expect(test.regs_opt.entry12, "");
  expect(test.regs_opt.entry13, "");
  expect(test.regs_opt.entry14, "");
  expect(test.regs_opt.entry15, "");
  expect(test.regs_opt_dual.entry01, "");
  expect(test.regs_opt_dual.entry02, "");
  expect(test.regs_opt_dual.entry03, "");
  expect(test.regs_opt_dual.entry04, "");
  expect(test.regs_opt_dual.entry05, "");
  expect(test.regs_opt_dual.entry06, "");
  expect(test.regs_opt_dual.entry07, "");
  expect(test.regs_opt_dual.entry08, "");
  expect(test.regs_opt_dual.entry09, "");
  expect(test.regs_opt_dual.entry10, "");
  expect(test.regs_opt_dual.entry11, "");
  expect(test.regs_opt_dual.entry12, "");
  expect(test.regs_opt_dual.entry13, "");
  expect(test.regs_opt_dual.entry14, "");
  expect(test.regs_opt_dual.entry15, "");
  expect(test.regs_opt_dual.entry16, "");
  expect(test.regs_opt_dual.entry17, "");
  expect(test.regs_opt_dual.entry18, "");
  expect(test.regs_opt_dual.entry19, "");
  expect(test.regs_opt_dual.entry20, "");
  expect(test.regs_opt_dual.entry21, "");
  expect(test.regs_opt_dual.entry22, "");
  expect(test.regs_opt_dual.entry23, "");
  expect(test.regs_opt_dual.entry24, "");
  expect(test.regs_opt_dual.entry25, "");
  expect(test.regs_opt_dual.entry26, "");
  expect(test.regs_opt_dual.entry27, "");
  expect(test.regs_opt_dual.entry28, "");
  expect(test.regs_opt_dual.entry29, "");
  expect(test.regs_opt_dual.entry30, "");
  expect(test.regs_opt_dual.entry31, "");
  expect(test.regs_opt_dual.entry32, "");
  expect(test.streopncls.entry01, "");
  expect(test.streopncls.entry02, "");
  expect(test.menu.entry01, "");
  expect(test.startup.entry01, "");
  expect(test.startup.entry02, "");
  expect(test.startup.entry03, "");
  expect(test.startup.entry04, "");
  expect(test.startup.entry05, "");
  expect(test.startup.entry06, "");
  expect(test.startup.entry07, "");
  expect(test.startup.entry08, "");
  expect(test.startup.entry09, "");
  expect(test.startup.entry10, "");
  expect(test.startup.entry11, "");
  expect(test.startup.entry12, "");
  expect(test.startup.entry13, "");
  expect(test.startup.entry14, "");
  expect(test.startup.entry15, "");
  expect(test.startup.entry16, "");
  expect(test.startup.entry17, "");
  expect(test.startup.entry18, "");
  expect(test.startup.entry19, "");
  expect(test.startup.entry20, "");
  expect(test.startup.entry21, "");
  expect(test.startup.entry22, "");
  expect(test.startup.entry23, "");
  expect(test.startup.entry24, "");
  expect(test.startup.entry25, "");
  expect(test.startup.entry26, "");
  expect(test.startup.entry27, "");
  expect(test.startup.entry28, "");
  expect(test.startup.entry29, "");
  expect(test.startup.entry30, "");
  expect(test.startup.entry31, "");
  expect(test.startup.entry32, "");
  expect(test.startup.entry33, "");
  expect(test.startup.entry34, "");
  expect(test.startup.entry35, "");
  expect(test.startup.entry36, "");
  expect(test.startup.entry37, "");
  expect(test.startup.entry38, "");
  expect(test.startup.entry39, "");
  expect(test.startup.entry40, "");
  expect(test.startup.entry41, "");
  expect(test.another1.entry01, "");
  expect(test.another1.entry02, "");
  expect(test.another1.entry03, "");
  expect(test.another2.entry01, "");
  expect(test.another2.entry02, "");
  expect(test.another2.entry03, "");
  expect(test.another2.entry04, "");
  expect(test.another2.entry05, "");
  expect(test.another2.entry06, "");
  expect(test.another2.entry07, "");
  expect(test.simple2stf.entry01, "");
  expect(test.simple2stf.entry02, "");
  expect(test.simple2stf_dual.entry01, "");
  expect(test.bank_prg.entry01, "");
  expect(test.proc_id.sound, 0);
  expect(test.proc_id.sound2, 0);
  expect(test.FenceOver.entry01, "");
  expect(test.FenceOver.entry02, "");
  expect(test.FenceOver.entry03, "");
  expect(test.FenceOver.entry04, "");
  expect(test.FenceOver.entry05, "");
  expect(test.FenceOver.entry06, "");
  expect(test.FenceOver.entry07, "");
  expect(test.FenceOver.entry08, "");
  expect(test.FenceOver.entry09, "");
  expect(test.FenceOver.entry10, "");
  expect(test.FenceOver.entry11, "");
  expect(test.FenceOver.entry12, "");
  expect(test.FenceOver.entry13, "");
  expect(test.FenceOver.entry14, "");
  expect(test.EjConf.entry01, "");
  expect(test.CashRecycle.entry01, "");
}

void allPropatyCheck(Proc_conJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.regs.entry01, "print");
  }
  expect(test.regs.entry02, "drw");
  expect(test.regs.entry03, "print_jc_c");
  expect(test.regs.entry04, "print_kitchen1");
  expect(test.regs.entry05, "print_kitchen2");
  expect(test.regs_opt.entry01, "spool");
  expect(test.regs_opt.entry02, "acx");
  expect(test.regs_opt.entry03, "jpo");
  expect(test.regs_opt.entry04, "scl");
  expect(test.regs_opt.entry05, "rwc");
  expect(test.regs_opt.entry06, "sgscl1");
  expect(test.regs_opt.entry07, "sgscl2");
  expect(test.regs_opt.entry08, "s2pr");
  expect(test.regs_opt.entry09, "cashier");
  expect(test.regs_opt.entry10, "stpr2");
  expect(test.regs_opt.entry11, "mp1");
  expect(test.regs_opt.entry12, "multi");
  expect(test.regs_opt.entry13, "custreal");
  expect(test.regs_opt.entry14, "custreal2");
  expect(test.regs_opt.entry15, "custreal_netdoa");
  expect(test.regs_opt_dual.entry01, "spool");
  expect(test.regs_opt_dual.entry02, "acx");
  expect(test.regs_opt_dual.entry03, "jpo");
  expect(test.regs_opt_dual.entry04, "scl");
  expect(test.regs_opt_dual.entry05, "rwc");
  expect(test.regs_opt_dual.entry06, "sgscl1");
  expect(test.regs_opt_dual.entry07, "sgscl2");
  expect(test.regs_opt_dual.entry08, "s2pr");
  expect(test.regs_opt_dual.entry09, "stpr2");
  expect(test.regs_opt_dual.entry10, "fb_SelfMovie");
  expect(test.regs_opt_dual.entry11, "mp1");
  expect(test.regs_opt_dual.entry12, "multi");
  expect(test.regs_opt_dual.entry13, "fb_Movie");
  expect(test.regs_opt_dual.entry14, "custreal");
  expect(test.regs_opt_dual.entry15, "custreal2");
  expect(test.regs_opt_dual.entry16, "custreal_netdoa");
  expect(test.regs_opt_dual.entry17, "qcConnect");
  expect(test.regs_opt_dual.entry18, "credit");
  expect(test.regs_opt_dual.entry19, "nttd_preca");
  expect(test.regs_opt_dual.entry20, "sqrc");
  expect(test.regs_opt_dual.entry21, "trk_preca");
  expect(test.regs_opt_dual.entry22, "repica");
  expect(test.regs_opt_dual.entry23, "custreal2_pa");
  expect(test.regs_opt_dual.entry24, "custreal_odbc");
  expect(test.regs_opt_dual.entry25, "cogca");
  expect(test.regs_opt_dual.entry26, "basket_server");
  expect(test.regs_opt_dual.entry27, "vega3000");
  expect(test.regs_opt_dual.entry28, "dpoint");
  expect(test.regs_opt_dual.entry29, "ajs_emoney");
  expect(test.regs_opt_dual.entry30, "valuecard");
  expect(test.regs_opt_dual.entry31, "rpoint");
  expect(test.regs_opt_dual.entry32, "tpoint");
  expect(test.streopncls.entry01, "stropncls");
  expect(test.streopncls.entry02, "jpo");
  expect(test.menu.entry01, "acxreal");
  expect(test.startup.entry01, "csvsend");
  expect(test.startup.entry02, "iis");
  expect(test.startup.entry03, "tprapl_reglog");
  expect(test.startup.entry04, "mobile");
  expect(test.startup.entry05, "stpr");
  expect(test.startup.entry06, "pmod");
  expect(test.startup.entry07, "sale_com_mm");
  expect(test.startup.entry08, "menteserver");
  expect(test.startup.entry09, "menteclient");
  expect(test.startup.entry10, "sound_con");
  expect(test.startup.entry11, "mcftp");
  expect(test.startup.entry12, "upd_con");
  expect(test.startup.entry13, "ecoaserver");
  expect(test.startup.entry14, "kill_proc");
  expect(test.startup.entry15, "keyb");
  expect(test.startup.entry16, "multi");
  expect(test.startup.entry17, "icc");
  expect(test.startup.entry18, "drugrevs");
  expect(test.startup.entry19, "tprapl_tprt");
  expect(test.startup.entry20, "jpo");
  expect(test.startup.entry21, "pbchg_log_send");
  expect(test.startup.entry22, "ftp");
  expect(test.startup.entry23, "spqcs");
  expect(test.startup.entry24, "spqcc");
  expect(test.startup.entry25, "pbchg_test_server");
  expect(test.startup.entry26, "WizS");
  expect(test.startup.entry27, "qcSelectServer");
  expect(test.startup.entry28, "moviesend");
  expect(test.startup.entry29, "credit");
  expect(test.startup.entry30, "qcConnectServer");
  expect(test.startup.entry31, "custreal_nec");
  expect(test.startup.entry32, "masr");
  expect(test.startup.entry33, "multi_tmn");
  expect(test.startup.entry34, "multi_glory");
  expect(test.startup.entry35, "suica");
  expect(test.startup.entry36, "netdoa_pqs");
  expect(test.startup.entry37, "tpoint_ftp");
  expect(test.startup.entry38, "taxfree");
  expect(test.startup.entry39, "multi_tmn_vega3000");
  expect(test.startup.entry40, "basket_server");
  expect(test.startup.entry41, "acttrigger");
  expect(test.another1.entry01, "mente");
  expect(test.another1.entry02, "usetup");
  expect(test.another1.entry03, "history_get");
  expect(test.another2.entry01, "tcount");
  expect(test.another2.entry02, "fcon");
  expect(test.another2.entry03, "freq");
  expect(test.another2.entry04, "pmod_regctrl");
  expect(test.another2.entry05, "retotal");
  expect(test.another2.entry06, "cust_enq_clr");
  expect(test.another2.entry07, "resimslog");
  expect(test.simple2stf.entry01, "spool");
  expect(test.simple2stf.entry02, "cashier");
  expect(test.simple2stf_dual.entry01, "spool");
  expect(test.bank_prg.entry01, "bankprg");
  expect(test.proc_id.sound, 0);
  expect(test.proc_id.sound2, 0);
  expect(test.FenceOver.entry01, "custd_srch");
  expect(test.FenceOver.entry02, "custd_hist");
  expect(test.FenceOver.entry03, "custd_mtg");
  expect(test.FenceOver.entry04, "prg_cust_popup");
  expect(test.FenceOver.entry05, "cd_contents");
  expect(test.FenceOver.entry06, "reserv_conf");
  expect(test.FenceOver.entry07, "chprice");
  expect(test.FenceOver.entry08, "autotest");
  expect(test.FenceOver.entry09, "pbchg_util");
  expect(test.FenceOver.entry10, "Cons");
  expect(test.FenceOver.entry11, "DSft");
  expect(test.FenceOver.entry12, "FMente");
  expect(test.FenceOver.entry13, "acx_recalc_g");
  expect(test.FenceOver.entry14, "acx_recalc");
  expect(test.EjConf.entry01, "fb_Movie");
  expect(test.CashRecycle.entry01, "cash_recycle");
}

