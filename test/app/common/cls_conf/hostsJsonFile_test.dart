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
import '../../../../lib/app/common/cls_conf/hostsJsonFile.dart';

late HostsJsonFile hosts;

void main(){
  hostsJsonFile_test();
}

void hostsJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "hosts.json";
  const String section = "hosts1";
  const String key = "HostsName";
  const defaultData = "localhost";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('HostsJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await HostsJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await HostsJsonFile().setDefault();
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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await hosts.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(hosts,true);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        hosts.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await hosts.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(hosts,true);

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
      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①：loadを実行する。
      await hosts.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = hosts.hosts1.HostsName;
      hosts.hosts1.HostsName = testData1s;
      expect(hosts.hosts1.HostsName == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await hosts.load();
      expect(hosts.hosts1.HostsName != testData1s, true);
      expect(hosts.hosts1.HostsName == prefixData, true);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = hosts.hosts1.HostsName;
      hosts.hosts1.HostsName = testData1s;
      expect(hosts.hosts1.HostsName, testData1s);

      // ③saveを実行する。
      await hosts.save();

      // ④loadを実行する。
      await hosts.load();

      expect(hosts.hosts1.HostsName != prefixData, true);
      expect(hosts.hosts1.HostsName == testData1s, true);
      allPropatyCheck(hosts,false);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await hosts.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await hosts.save();

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await hosts.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(hosts.hosts1.HostsName, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = hosts.hosts1.HostsName;
      hosts.hosts1.HostsName = testData1s;

      // ③ saveを実行する。
      await hosts.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(hosts.hosts1.HostsName, testData1s);

      // ④ loadを実行する。
      await hosts.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(hosts.hosts1.HostsName == testData1s, true);
      allPropatyCheck(hosts,false);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await hosts.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(hosts,true);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②任意のプロパティの値を変更する。
      hosts.hosts1.HostsName = testData1s;
      expect(hosts.hosts1.HostsName, testData1s);

      // ③saveを実行する。
      await hosts.save();
      expect(hosts.hosts1.HostsName, testData1s);

      // ④loadを実行する。
      await hosts.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(hosts,true);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await hosts.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await hosts.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(hosts.hosts1.HostsName == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await hosts.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await hosts.setValueWithName(section, "test_key", testData1s);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②任意のプロパティを変更する。
      hosts.hosts1.HostsName = testData1s;

      // ③saveを実行する。
      await hosts.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await hosts.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②任意のプロパティを変更する。
      hosts.hosts1.HostsName = testData1s;

      // ③saveを実行する。
      await hosts.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await hosts.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②任意のプロパティを変更する。
      hosts.hosts1.HostsName = testData1s;

      // ③saveを実行する。
      await hosts.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await hosts.getValueWithName(section, "test_key");
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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await hosts.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      hosts.hosts1.HostsName = testData1s;
      expect(hosts.hosts1.HostsName, testData1s);

      // ④saveを実行する。
      await hosts.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(hosts.hosts1.HostsName, testData1s);
      
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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await hosts.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + hosts.hosts1.HostsName.toString());
      expect(hosts.hosts1.HostsName == testData1s, true);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await hosts.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + hosts.hosts1.HostsName.toString());
      expect(hosts.hosts1.HostsName == testData2s, true);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await hosts.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + hosts.hosts1.HostsName.toString());
      expect(hosts.hosts1.HostsName == testData1s, true);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await hosts.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + hosts.hosts1.HostsName.toString());
      expect(hosts.hosts1.HostsName == testData2s, true);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await hosts.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + hosts.hosts1.HostsName.toString());
      expect(hosts.hosts1.HostsName == testData1s, true);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await hosts.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + hosts.hosts1.HostsName.toString());
      expect(hosts.hosts1.HostsName == testData1s, true);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await hosts.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + hosts.hosts1.HostsName.toString());
      allPropatyCheck(hosts,true);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await hosts.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + hosts.hosts1.HostsName.toString());
      allPropatyCheck(hosts,true);

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

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts1.HostsName;
      print(hosts.hosts1.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts1.HostsName = testData1s;
      print(hosts.hosts1.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts1.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts1.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts1.HostsName = testData2s;
      print(hosts.hosts1.HostsName);
      expect(hosts.hosts1.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts1.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts1.HostsName = defalut;
      print(hosts.hosts1.HostsName);
      expect(hosts.hosts1.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts1.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts1.IpAddress;
      print(hosts.hosts1.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts1.IpAddress = testData1s;
      print(hosts.hosts1.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts1.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts1.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts1.IpAddress = testData2s;
      print(hosts.hosts1.IpAddress);
      expect(hosts.hosts1.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts1.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts1.IpAddress = defalut;
      print(hosts.hosts1.IpAddress);
      expect(hosts.hosts1.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts1.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts2.HostsName;
      print(hosts.hosts2.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts2.HostsName = testData1s;
      print(hosts.hosts2.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts2.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts2.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts2.HostsName = testData2s;
      print(hosts.hosts2.HostsName);
      expect(hosts.hosts2.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts2.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts2.HostsName = defalut;
      print(hosts.hosts2.HostsName);
      expect(hosts.hosts2.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts2.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts2.IpAddress;
      print(hosts.hosts2.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts2.IpAddress = testData1s;
      print(hosts.hosts2.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts2.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts2.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts2.IpAddress = testData2s;
      print(hosts.hosts2.IpAddress);
      expect(hosts.hosts2.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts2.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts2.IpAddress = defalut;
      print(hosts.hosts2.IpAddress);
      expect(hosts.hosts2.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts2.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts3.HostsName;
      print(hosts.hosts3.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts3.HostsName = testData1s;
      print(hosts.hosts3.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts3.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts3.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts3.HostsName = testData2s;
      print(hosts.hosts3.HostsName);
      expect(hosts.hosts3.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts3.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts3.HostsName = defalut;
      print(hosts.hosts3.HostsName);
      expect(hosts.hosts3.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts3.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts3.IpAddress;
      print(hosts.hosts3.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts3.IpAddress = testData1s;
      print(hosts.hosts3.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts3.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts3.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts3.IpAddress = testData2s;
      print(hosts.hosts3.IpAddress);
      expect(hosts.hosts3.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts3.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts3.IpAddress = defalut;
      print(hosts.hosts3.IpAddress);
      expect(hosts.hosts3.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts3.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts4.HostsName;
      print(hosts.hosts4.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts4.HostsName = testData1s;
      print(hosts.hosts4.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts4.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts4.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts4.HostsName = testData2s;
      print(hosts.hosts4.HostsName);
      expect(hosts.hosts4.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts4.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts4.HostsName = defalut;
      print(hosts.hosts4.HostsName);
      expect(hosts.hosts4.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts4.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts4.IpAddress;
      print(hosts.hosts4.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts4.IpAddress = testData1s;
      print(hosts.hosts4.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts4.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts4.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts4.IpAddress = testData2s;
      print(hosts.hosts4.IpAddress);
      expect(hosts.hosts4.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts4.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts4.IpAddress = defalut;
      print(hosts.hosts4.IpAddress);
      expect(hosts.hosts4.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts4.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts5.HostsName;
      print(hosts.hosts5.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts5.HostsName = testData1s;
      print(hosts.hosts5.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts5.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts5.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts5.HostsName = testData2s;
      print(hosts.hosts5.HostsName);
      expect(hosts.hosts5.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts5.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts5.HostsName = defalut;
      print(hosts.hosts5.HostsName);
      expect(hosts.hosts5.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts5.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts5.IpAddress;
      print(hosts.hosts5.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts5.IpAddress = testData1s;
      print(hosts.hosts5.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts5.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts5.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts5.IpAddress = testData2s;
      print(hosts.hosts5.IpAddress);
      expect(hosts.hosts5.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts5.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts5.IpAddress = defalut;
      print(hosts.hosts5.IpAddress);
      expect(hosts.hosts5.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts5.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts6.HostsName;
      print(hosts.hosts6.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts6.HostsName = testData1s;
      print(hosts.hosts6.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts6.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts6.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts6.HostsName = testData2s;
      print(hosts.hosts6.HostsName);
      expect(hosts.hosts6.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts6.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts6.HostsName = defalut;
      print(hosts.hosts6.HostsName);
      expect(hosts.hosts6.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts6.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts6.IpAddress;
      print(hosts.hosts6.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts6.IpAddress = testData1s;
      print(hosts.hosts6.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts6.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts6.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts6.IpAddress = testData2s;
      print(hosts.hosts6.IpAddress);
      expect(hosts.hosts6.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts6.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts6.IpAddress = defalut;
      print(hosts.hosts6.IpAddress);
      expect(hosts.hosts6.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts6.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts7.HostsName;
      print(hosts.hosts7.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts7.HostsName = testData1s;
      print(hosts.hosts7.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts7.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts7.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts7.HostsName = testData2s;
      print(hosts.hosts7.HostsName);
      expect(hosts.hosts7.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts7.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts7.HostsName = defalut;
      print(hosts.hosts7.HostsName);
      expect(hosts.hosts7.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts7.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts7.IpAddress;
      print(hosts.hosts7.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts7.IpAddress = testData1s;
      print(hosts.hosts7.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts7.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts7.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts7.IpAddress = testData2s;
      print(hosts.hosts7.IpAddress);
      expect(hosts.hosts7.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts7.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts7.IpAddress = defalut;
      print(hosts.hosts7.IpAddress);
      expect(hosts.hosts7.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts7.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts8.HostsName;
      print(hosts.hosts8.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts8.HostsName = testData1s;
      print(hosts.hosts8.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts8.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts8.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts8.HostsName = testData2s;
      print(hosts.hosts8.HostsName);
      expect(hosts.hosts8.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts8.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts8.HostsName = defalut;
      print(hosts.hosts8.HostsName);
      expect(hosts.hosts8.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts8.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts8.IpAddress;
      print(hosts.hosts8.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts8.IpAddress = testData1s;
      print(hosts.hosts8.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts8.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts8.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts8.IpAddress = testData2s;
      print(hosts.hosts8.IpAddress);
      expect(hosts.hosts8.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts8.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts8.IpAddress = defalut;
      print(hosts.hosts8.IpAddress);
      expect(hosts.hosts8.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts8.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts9.HostsName;
      print(hosts.hosts9.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts9.HostsName = testData1s;
      print(hosts.hosts9.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts9.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts9.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts9.HostsName = testData2s;
      print(hosts.hosts9.HostsName);
      expect(hosts.hosts9.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts9.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts9.HostsName = defalut;
      print(hosts.hosts9.HostsName);
      expect(hosts.hosts9.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts9.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts9.IpAddress;
      print(hosts.hosts9.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts9.IpAddress = testData1s;
      print(hosts.hosts9.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts9.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts9.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts9.IpAddress = testData2s;
      print(hosts.hosts9.IpAddress);
      expect(hosts.hosts9.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts9.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts9.IpAddress = defalut;
      print(hosts.hosts9.IpAddress);
      expect(hosts.hosts9.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts9.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts10.HostsName;
      print(hosts.hosts10.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts10.HostsName = testData1s;
      print(hosts.hosts10.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts10.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts10.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts10.HostsName = testData2s;
      print(hosts.hosts10.HostsName);
      expect(hosts.hosts10.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts10.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts10.HostsName = defalut;
      print(hosts.hosts10.HostsName);
      expect(hosts.hosts10.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts10.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts10.IpAddress;
      print(hosts.hosts10.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts10.IpAddress = testData1s;
      print(hosts.hosts10.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts10.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts10.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts10.IpAddress = testData2s;
      print(hosts.hosts10.IpAddress);
      expect(hosts.hosts10.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts10.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts10.IpAddress = defalut;
      print(hosts.hosts10.IpAddress);
      expect(hosts.hosts10.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts10.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts11.HostsName;
      print(hosts.hosts11.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts11.HostsName = testData1s;
      print(hosts.hosts11.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts11.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts11.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts11.HostsName = testData2s;
      print(hosts.hosts11.HostsName);
      expect(hosts.hosts11.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts11.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts11.HostsName = defalut;
      print(hosts.hosts11.HostsName);
      expect(hosts.hosts11.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts11.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts11.IpAddress;
      print(hosts.hosts11.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts11.IpAddress = testData1s;
      print(hosts.hosts11.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts11.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts11.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts11.IpAddress = testData2s;
      print(hosts.hosts11.IpAddress);
      expect(hosts.hosts11.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts11.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts11.IpAddress = defalut;
      print(hosts.hosts11.IpAddress);
      expect(hosts.hosts11.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts11.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts12.HostsName;
      print(hosts.hosts12.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts12.HostsName = testData1s;
      print(hosts.hosts12.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts12.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts12.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts12.HostsName = testData2s;
      print(hosts.hosts12.HostsName);
      expect(hosts.hosts12.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts12.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts12.HostsName = defalut;
      print(hosts.hosts12.HostsName);
      expect(hosts.hosts12.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts12.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts12.IpAddress;
      print(hosts.hosts12.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts12.IpAddress = testData1s;
      print(hosts.hosts12.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts12.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts12.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts12.IpAddress = testData2s;
      print(hosts.hosts12.IpAddress);
      expect(hosts.hosts12.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts12.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts12.IpAddress = defalut;
      print(hosts.hosts12.IpAddress);
      expect(hosts.hosts12.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts12.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts13.HostsName;
      print(hosts.hosts13.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts13.HostsName = testData1s;
      print(hosts.hosts13.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts13.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts13.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts13.HostsName = testData2s;
      print(hosts.hosts13.HostsName);
      expect(hosts.hosts13.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts13.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts13.HostsName = defalut;
      print(hosts.hosts13.HostsName);
      expect(hosts.hosts13.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts13.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts13.IpAddress;
      print(hosts.hosts13.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts13.IpAddress = testData1s;
      print(hosts.hosts13.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts13.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts13.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts13.IpAddress = testData2s;
      print(hosts.hosts13.IpAddress);
      expect(hosts.hosts13.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts13.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts13.IpAddress = defalut;
      print(hosts.hosts13.IpAddress);
      expect(hosts.hosts13.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts13.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts14.HostsName;
      print(hosts.hosts14.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts14.HostsName = testData1s;
      print(hosts.hosts14.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts14.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts14.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts14.HostsName = testData2s;
      print(hosts.hosts14.HostsName);
      expect(hosts.hosts14.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts14.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts14.HostsName = defalut;
      print(hosts.hosts14.HostsName);
      expect(hosts.hosts14.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts14.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts14.IpAddress;
      print(hosts.hosts14.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts14.IpAddress = testData1s;
      print(hosts.hosts14.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts14.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts14.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts14.IpAddress = testData2s;
      print(hosts.hosts14.IpAddress);
      expect(hosts.hosts14.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts14.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts14.IpAddress = defalut;
      print(hosts.hosts14.IpAddress);
      expect(hosts.hosts14.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts14.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts15.HostsName;
      print(hosts.hosts15.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts15.HostsName = testData1s;
      print(hosts.hosts15.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts15.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts15.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts15.HostsName = testData2s;
      print(hosts.hosts15.HostsName);
      expect(hosts.hosts15.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts15.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts15.HostsName = defalut;
      print(hosts.hosts15.HostsName);
      expect(hosts.hosts15.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts15.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts15.IpAddress;
      print(hosts.hosts15.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts15.IpAddress = testData1s;
      print(hosts.hosts15.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts15.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts15.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts15.IpAddress = testData2s;
      print(hosts.hosts15.IpAddress);
      expect(hosts.hosts15.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts15.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts15.IpAddress = defalut;
      print(hosts.hosts15.IpAddress);
      expect(hosts.hosts15.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts15.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts16.HostsName;
      print(hosts.hosts16.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts16.HostsName = testData1s;
      print(hosts.hosts16.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts16.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts16.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts16.HostsName = testData2s;
      print(hosts.hosts16.HostsName);
      expect(hosts.hosts16.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts16.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts16.HostsName = defalut;
      print(hosts.hosts16.HostsName);
      expect(hosts.hosts16.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts16.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts16.IpAddress;
      print(hosts.hosts16.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts16.IpAddress = testData1s;
      print(hosts.hosts16.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts16.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts16.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts16.IpAddress = testData2s;
      print(hosts.hosts16.IpAddress);
      expect(hosts.hosts16.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts16.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts16.IpAddress = defalut;
      print(hosts.hosts16.IpAddress);
      expect(hosts.hosts16.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts16.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts17.HostsName;
      print(hosts.hosts17.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts17.HostsName = testData1s;
      print(hosts.hosts17.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts17.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts17.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts17.HostsName = testData2s;
      print(hosts.hosts17.HostsName);
      expect(hosts.hosts17.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts17.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts17.HostsName = defalut;
      print(hosts.hosts17.HostsName);
      expect(hosts.hosts17.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts17.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts17.IpAddress;
      print(hosts.hosts17.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts17.IpAddress = testData1s;
      print(hosts.hosts17.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts17.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts17.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts17.IpAddress = testData2s;
      print(hosts.hosts17.IpAddress);
      expect(hosts.hosts17.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts17.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts17.IpAddress = defalut;
      print(hosts.hosts17.IpAddress);
      expect(hosts.hosts17.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts17.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts18.HostsName;
      print(hosts.hosts18.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts18.HostsName = testData1s;
      print(hosts.hosts18.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts18.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts18.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts18.HostsName = testData2s;
      print(hosts.hosts18.HostsName);
      expect(hosts.hosts18.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts18.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts18.HostsName = defalut;
      print(hosts.hosts18.HostsName);
      expect(hosts.hosts18.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts18.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts18.IpAddress;
      print(hosts.hosts18.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts18.IpAddress = testData1s;
      print(hosts.hosts18.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts18.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts18.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts18.IpAddress = testData2s;
      print(hosts.hosts18.IpAddress);
      expect(hosts.hosts18.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts18.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts18.IpAddress = defalut;
      print(hosts.hosts18.IpAddress);
      expect(hosts.hosts18.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts18.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts19.HostsName;
      print(hosts.hosts19.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts19.HostsName = testData1s;
      print(hosts.hosts19.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts19.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts19.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts19.HostsName = testData2s;
      print(hosts.hosts19.HostsName);
      expect(hosts.hosts19.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts19.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts19.HostsName = defalut;
      print(hosts.hosts19.HostsName);
      expect(hosts.hosts19.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts19.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts19.IpAddress;
      print(hosts.hosts19.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts19.IpAddress = testData1s;
      print(hosts.hosts19.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts19.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts19.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts19.IpAddress = testData2s;
      print(hosts.hosts19.IpAddress);
      expect(hosts.hosts19.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts19.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts19.IpAddress = defalut;
      print(hosts.hosts19.IpAddress);
      expect(hosts.hosts19.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts19.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts20.HostsName;
      print(hosts.hosts20.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts20.HostsName = testData1s;
      print(hosts.hosts20.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts20.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts20.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts20.HostsName = testData2s;
      print(hosts.hosts20.HostsName);
      expect(hosts.hosts20.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts20.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts20.HostsName = defalut;
      print(hosts.hosts20.HostsName);
      expect(hosts.hosts20.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts20.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts20.IpAddress;
      print(hosts.hosts20.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts20.IpAddress = testData1s;
      print(hosts.hosts20.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts20.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts20.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts20.IpAddress = testData2s;
      print(hosts.hosts20.IpAddress);
      expect(hosts.hosts20.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts20.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts20.IpAddress = defalut;
      print(hosts.hosts20.IpAddress);
      expect(hosts.hosts20.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts20.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts21.HostsName;
      print(hosts.hosts21.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts21.HostsName = testData1s;
      print(hosts.hosts21.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts21.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts21.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts21.HostsName = testData2s;
      print(hosts.hosts21.HostsName);
      expect(hosts.hosts21.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts21.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts21.HostsName = defalut;
      print(hosts.hosts21.HostsName);
      expect(hosts.hosts21.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts21.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts21.IpAddress;
      print(hosts.hosts21.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts21.IpAddress = testData1s;
      print(hosts.hosts21.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts21.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts21.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts21.IpAddress = testData2s;
      print(hosts.hosts21.IpAddress);
      expect(hosts.hosts21.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts21.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts21.IpAddress = defalut;
      print(hosts.hosts21.IpAddress);
      expect(hosts.hosts21.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts21.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts22.HostsName;
      print(hosts.hosts22.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts22.HostsName = testData1s;
      print(hosts.hosts22.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts22.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts22.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts22.HostsName = testData2s;
      print(hosts.hosts22.HostsName);
      expect(hosts.hosts22.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts22.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts22.HostsName = defalut;
      print(hosts.hosts22.HostsName);
      expect(hosts.hosts22.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts22.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts22.IpAddress;
      print(hosts.hosts22.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts22.IpAddress = testData1s;
      print(hosts.hosts22.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts22.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts22.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts22.IpAddress = testData2s;
      print(hosts.hosts22.IpAddress);
      expect(hosts.hosts22.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts22.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts22.IpAddress = defalut;
      print(hosts.hosts22.IpAddress);
      expect(hosts.hosts22.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts22.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts23.HostsName;
      print(hosts.hosts23.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts23.HostsName = testData1s;
      print(hosts.hosts23.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts23.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts23.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts23.HostsName = testData2s;
      print(hosts.hosts23.HostsName);
      expect(hosts.hosts23.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts23.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts23.HostsName = defalut;
      print(hosts.hosts23.HostsName);
      expect(hosts.hosts23.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts23.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts23.IpAddress;
      print(hosts.hosts23.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts23.IpAddress = testData1s;
      print(hosts.hosts23.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts23.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts23.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts23.IpAddress = testData2s;
      print(hosts.hosts23.IpAddress);
      expect(hosts.hosts23.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts23.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts23.IpAddress = defalut;
      print(hosts.hosts23.IpAddress);
      expect(hosts.hosts23.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts23.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts24.HostsName;
      print(hosts.hosts24.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts24.HostsName = testData1s;
      print(hosts.hosts24.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts24.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts24.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts24.HostsName = testData2s;
      print(hosts.hosts24.HostsName);
      expect(hosts.hosts24.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts24.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts24.HostsName = defalut;
      print(hosts.hosts24.HostsName);
      expect(hosts.hosts24.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts24.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts24.IpAddress;
      print(hosts.hosts24.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts24.IpAddress = testData1s;
      print(hosts.hosts24.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts24.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts24.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts24.IpAddress = testData2s;
      print(hosts.hosts24.IpAddress);
      expect(hosts.hosts24.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts24.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts24.IpAddress = defalut;
      print(hosts.hosts24.IpAddress);
      expect(hosts.hosts24.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts24.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts25.HostsName;
      print(hosts.hosts25.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts25.HostsName = testData1s;
      print(hosts.hosts25.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts25.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts25.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts25.HostsName = testData2s;
      print(hosts.hosts25.HostsName);
      expect(hosts.hosts25.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts25.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts25.HostsName = defalut;
      print(hosts.hosts25.HostsName);
      expect(hosts.hosts25.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts25.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts25.IpAddress;
      print(hosts.hosts25.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts25.IpAddress = testData1s;
      print(hosts.hosts25.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts25.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts25.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts25.IpAddress = testData2s;
      print(hosts.hosts25.IpAddress);
      expect(hosts.hosts25.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts25.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts25.IpAddress = defalut;
      print(hosts.hosts25.IpAddress);
      expect(hosts.hosts25.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts25.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts26.HostsName;
      print(hosts.hosts26.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts26.HostsName = testData1s;
      print(hosts.hosts26.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts26.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts26.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts26.HostsName = testData2s;
      print(hosts.hosts26.HostsName);
      expect(hosts.hosts26.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts26.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts26.HostsName = defalut;
      print(hosts.hosts26.HostsName);
      expect(hosts.hosts26.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts26.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts26.IpAddress;
      print(hosts.hosts26.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts26.IpAddress = testData1s;
      print(hosts.hosts26.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts26.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts26.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts26.IpAddress = testData2s;
      print(hosts.hosts26.IpAddress);
      expect(hosts.hosts26.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts26.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts26.IpAddress = defalut;
      print(hosts.hosts26.IpAddress);
      expect(hosts.hosts26.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts26.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts27.HostsName;
      print(hosts.hosts27.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts27.HostsName = testData1s;
      print(hosts.hosts27.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts27.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts27.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts27.HostsName = testData2s;
      print(hosts.hosts27.HostsName);
      expect(hosts.hosts27.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts27.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts27.HostsName = defalut;
      print(hosts.hosts27.HostsName);
      expect(hosts.hosts27.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts27.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts27.IpAddress;
      print(hosts.hosts27.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts27.IpAddress = testData1s;
      print(hosts.hosts27.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts27.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts27.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts27.IpAddress = testData2s;
      print(hosts.hosts27.IpAddress);
      expect(hosts.hosts27.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts27.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts27.IpAddress = defalut;
      print(hosts.hosts27.IpAddress);
      expect(hosts.hosts27.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts27.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts28.HostsName;
      print(hosts.hosts28.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts28.HostsName = testData1s;
      print(hosts.hosts28.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts28.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts28.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts28.HostsName = testData2s;
      print(hosts.hosts28.HostsName);
      expect(hosts.hosts28.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts28.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts28.HostsName = defalut;
      print(hosts.hosts28.HostsName);
      expect(hosts.hosts28.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts28.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts28.IpAddress;
      print(hosts.hosts28.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts28.IpAddress = testData1s;
      print(hosts.hosts28.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts28.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts28.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts28.IpAddress = testData2s;
      print(hosts.hosts28.IpAddress);
      expect(hosts.hosts28.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts28.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts28.IpAddress = defalut;
      print(hosts.hosts28.IpAddress);
      expect(hosts.hosts28.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts28.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts29.HostsName;
      print(hosts.hosts29.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts29.HostsName = testData1s;
      print(hosts.hosts29.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts29.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts29.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts29.HostsName = testData2s;
      print(hosts.hosts29.HostsName);
      expect(hosts.hosts29.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts29.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts29.HostsName = defalut;
      print(hosts.hosts29.HostsName);
      expect(hosts.hosts29.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts29.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts29.IpAddress;
      print(hosts.hosts29.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts29.IpAddress = testData1s;
      print(hosts.hosts29.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts29.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts29.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts29.IpAddress = testData2s;
      print(hosts.hosts29.IpAddress);
      expect(hosts.hosts29.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts29.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts29.IpAddress = defalut;
      print(hosts.hosts29.IpAddress);
      expect(hosts.hosts29.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts29.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts30.HostsName;
      print(hosts.hosts30.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts30.HostsName = testData1s;
      print(hosts.hosts30.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts30.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts30.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts30.HostsName = testData2s;
      print(hosts.hosts30.HostsName);
      expect(hosts.hosts30.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts30.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts30.HostsName = defalut;
      print(hosts.hosts30.HostsName);
      expect(hosts.hosts30.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts30.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts30.IpAddress;
      print(hosts.hosts30.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts30.IpAddress = testData1s;
      print(hosts.hosts30.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts30.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts30.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts30.IpAddress = testData2s;
      print(hosts.hosts30.IpAddress);
      expect(hosts.hosts30.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts30.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts30.IpAddress = defalut;
      print(hosts.hosts30.IpAddress);
      expect(hosts.hosts30.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts30.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts31.HostsName;
      print(hosts.hosts31.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts31.HostsName = testData1s;
      print(hosts.hosts31.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts31.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts31.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts31.HostsName = testData2s;
      print(hosts.hosts31.HostsName);
      expect(hosts.hosts31.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts31.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts31.HostsName = defalut;
      print(hosts.hosts31.HostsName);
      expect(hosts.hosts31.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts31.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts31.IpAddress;
      print(hosts.hosts31.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts31.IpAddress = testData1s;
      print(hosts.hosts31.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts31.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts31.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts31.IpAddress = testData2s;
      print(hosts.hosts31.IpAddress);
      expect(hosts.hosts31.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts31.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts31.IpAddress = defalut;
      print(hosts.hosts31.IpAddress);
      expect(hosts.hosts31.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts31.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts32.HostsName;
      print(hosts.hosts32.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts32.HostsName = testData1s;
      print(hosts.hosts32.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts32.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts32.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts32.HostsName = testData2s;
      print(hosts.hosts32.HostsName);
      expect(hosts.hosts32.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts32.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts32.HostsName = defalut;
      print(hosts.hosts32.HostsName);
      expect(hosts.hosts32.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts32.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts32.IpAddress;
      print(hosts.hosts32.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts32.IpAddress = testData1s;
      print(hosts.hosts32.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts32.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts32.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts32.IpAddress = testData2s;
      print(hosts.hosts32.IpAddress);
      expect(hosts.hosts32.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts32.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts32.IpAddress = defalut;
      print(hosts.hosts32.IpAddress);
      expect(hosts.hosts32.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts32.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts33.HostsName;
      print(hosts.hosts33.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts33.HostsName = testData1s;
      print(hosts.hosts33.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts33.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts33.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts33.HostsName = testData2s;
      print(hosts.hosts33.HostsName);
      expect(hosts.hosts33.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts33.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts33.HostsName = defalut;
      print(hosts.hosts33.HostsName);
      expect(hosts.hosts33.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts33.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts33.IpAddress;
      print(hosts.hosts33.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts33.IpAddress = testData1s;
      print(hosts.hosts33.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts33.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts33.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts33.IpAddress = testData2s;
      print(hosts.hosts33.IpAddress);
      expect(hosts.hosts33.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts33.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts33.IpAddress = defalut;
      print(hosts.hosts33.IpAddress);
      expect(hosts.hosts33.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts33.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts34.HostsName;
      print(hosts.hosts34.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts34.HostsName = testData1s;
      print(hosts.hosts34.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts34.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts34.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts34.HostsName = testData2s;
      print(hosts.hosts34.HostsName);
      expect(hosts.hosts34.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts34.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts34.HostsName = defalut;
      print(hosts.hosts34.HostsName);
      expect(hosts.hosts34.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts34.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts34.IpAddress;
      print(hosts.hosts34.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts34.IpAddress = testData1s;
      print(hosts.hosts34.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts34.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts34.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts34.IpAddress = testData2s;
      print(hosts.hosts34.IpAddress);
      expect(hosts.hosts34.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts34.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts34.IpAddress = defalut;
      print(hosts.hosts34.IpAddress);
      expect(hosts.hosts34.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts34.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts35.HostsName;
      print(hosts.hosts35.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts35.HostsName = testData1s;
      print(hosts.hosts35.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts35.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts35.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts35.HostsName = testData2s;
      print(hosts.hosts35.HostsName);
      expect(hosts.hosts35.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts35.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts35.HostsName = defalut;
      print(hosts.hosts35.HostsName);
      expect(hosts.hosts35.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts35.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts35.IpAddress;
      print(hosts.hosts35.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts35.IpAddress = testData1s;
      print(hosts.hosts35.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts35.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts35.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts35.IpAddress = testData2s;
      print(hosts.hosts35.IpAddress);
      expect(hosts.hosts35.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts35.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts35.IpAddress = defalut;
      print(hosts.hosts35.IpAddress);
      expect(hosts.hosts35.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts35.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts36.HostsName;
      print(hosts.hosts36.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts36.HostsName = testData1s;
      print(hosts.hosts36.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts36.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts36.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts36.HostsName = testData2s;
      print(hosts.hosts36.HostsName);
      expect(hosts.hosts36.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts36.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts36.HostsName = defalut;
      print(hosts.hosts36.HostsName);
      expect(hosts.hosts36.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts36.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts36.IpAddress;
      print(hosts.hosts36.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts36.IpAddress = testData1s;
      print(hosts.hosts36.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts36.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts36.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts36.IpAddress = testData2s;
      print(hosts.hosts36.IpAddress);
      expect(hosts.hosts36.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts36.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts36.IpAddress = defalut;
      print(hosts.hosts36.IpAddress);
      expect(hosts.hosts36.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts36.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts37.HostsName;
      print(hosts.hosts37.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts37.HostsName = testData1s;
      print(hosts.hosts37.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts37.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts37.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts37.HostsName = testData2s;
      print(hosts.hosts37.HostsName);
      expect(hosts.hosts37.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts37.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts37.HostsName = defalut;
      print(hosts.hosts37.HostsName);
      expect(hosts.hosts37.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts37.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts37.IpAddress;
      print(hosts.hosts37.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts37.IpAddress = testData1s;
      print(hosts.hosts37.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts37.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts37.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts37.IpAddress = testData2s;
      print(hosts.hosts37.IpAddress);
      expect(hosts.hosts37.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts37.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts37.IpAddress = defalut;
      print(hosts.hosts37.IpAddress);
      expect(hosts.hosts37.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts37.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts38.HostsName;
      print(hosts.hosts38.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts38.HostsName = testData1s;
      print(hosts.hosts38.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts38.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts38.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts38.HostsName = testData2s;
      print(hosts.hosts38.HostsName);
      expect(hosts.hosts38.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts38.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts38.HostsName = defalut;
      print(hosts.hosts38.HostsName);
      expect(hosts.hosts38.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts38.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts38.IpAddress;
      print(hosts.hosts38.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts38.IpAddress = testData1s;
      print(hosts.hosts38.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts38.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts38.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts38.IpAddress = testData2s;
      print(hosts.hosts38.IpAddress);
      expect(hosts.hosts38.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts38.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts38.IpAddress = defalut;
      print(hosts.hosts38.IpAddress);
      expect(hosts.hosts38.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts38.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts39.HostsName;
      print(hosts.hosts39.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts39.HostsName = testData1s;
      print(hosts.hosts39.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts39.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts39.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts39.HostsName = testData2s;
      print(hosts.hosts39.HostsName);
      expect(hosts.hosts39.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts39.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts39.HostsName = defalut;
      print(hosts.hosts39.HostsName);
      expect(hosts.hosts39.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts39.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts39.IpAddress;
      print(hosts.hosts39.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts39.IpAddress = testData1s;
      print(hosts.hosts39.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts39.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts39.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts39.IpAddress = testData2s;
      print(hosts.hosts39.IpAddress);
      expect(hosts.hosts39.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts39.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts39.IpAddress = defalut;
      print(hosts.hosts39.IpAddress);
      expect(hosts.hosts39.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts39.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts40.HostsName;
      print(hosts.hosts40.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts40.HostsName = testData1s;
      print(hosts.hosts40.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts40.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts40.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts40.HostsName = testData2s;
      print(hosts.hosts40.HostsName);
      expect(hosts.hosts40.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts40.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts40.HostsName = defalut;
      print(hosts.hosts40.HostsName);
      expect(hosts.hosts40.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts40.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts40.IpAddress;
      print(hosts.hosts40.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts40.IpAddress = testData1s;
      print(hosts.hosts40.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts40.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts40.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts40.IpAddress = testData2s;
      print(hosts.hosts40.IpAddress);
      expect(hosts.hosts40.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts40.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts40.IpAddress = defalut;
      print(hosts.hosts40.IpAddress);
      expect(hosts.hosts40.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts40.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts41.HostsName;
      print(hosts.hosts41.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts41.HostsName = testData1s;
      print(hosts.hosts41.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts41.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts41.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts41.HostsName = testData2s;
      print(hosts.hosts41.HostsName);
      expect(hosts.hosts41.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts41.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts41.HostsName = defalut;
      print(hosts.hosts41.HostsName);
      expect(hosts.hosts41.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts41.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts41.IpAddress;
      print(hosts.hosts41.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts41.IpAddress = testData1s;
      print(hosts.hosts41.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts41.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts41.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts41.IpAddress = testData2s;
      print(hosts.hosts41.IpAddress);
      expect(hosts.hosts41.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts41.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts41.IpAddress = defalut;
      print(hosts.hosts41.IpAddress);
      expect(hosts.hosts41.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts41.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts42.HostsName;
      print(hosts.hosts42.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts42.HostsName = testData1s;
      print(hosts.hosts42.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts42.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts42.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts42.HostsName = testData2s;
      print(hosts.hosts42.HostsName);
      expect(hosts.hosts42.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts42.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts42.HostsName = defalut;
      print(hosts.hosts42.HostsName);
      expect(hosts.hosts42.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts42.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts42.IpAddress;
      print(hosts.hosts42.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts42.IpAddress = testData1s;
      print(hosts.hosts42.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts42.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts42.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts42.IpAddress = testData2s;
      print(hosts.hosts42.IpAddress);
      expect(hosts.hosts42.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts42.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts42.IpAddress = defalut;
      print(hosts.hosts42.IpAddress);
      expect(hosts.hosts42.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts42.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts43.HostsName;
      print(hosts.hosts43.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts43.HostsName = testData1s;
      print(hosts.hosts43.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts43.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts43.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts43.HostsName = testData2s;
      print(hosts.hosts43.HostsName);
      expect(hosts.hosts43.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts43.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts43.HostsName = defalut;
      print(hosts.hosts43.HostsName);
      expect(hosts.hosts43.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts43.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts43.IpAddress;
      print(hosts.hosts43.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts43.IpAddress = testData1s;
      print(hosts.hosts43.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts43.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts43.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts43.IpAddress = testData2s;
      print(hosts.hosts43.IpAddress);
      expect(hosts.hosts43.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts43.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts43.IpAddress = defalut;
      print(hosts.hosts43.IpAddress);
      expect(hosts.hosts43.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts43.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts44.HostsName;
      print(hosts.hosts44.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts44.HostsName = testData1s;
      print(hosts.hosts44.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts44.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts44.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts44.HostsName = testData2s;
      print(hosts.hosts44.HostsName);
      expect(hosts.hosts44.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts44.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts44.HostsName = defalut;
      print(hosts.hosts44.HostsName);
      expect(hosts.hosts44.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts44.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts44.IpAddress;
      print(hosts.hosts44.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts44.IpAddress = testData1s;
      print(hosts.hosts44.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts44.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts44.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts44.IpAddress = testData2s;
      print(hosts.hosts44.IpAddress);
      expect(hosts.hosts44.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts44.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts44.IpAddress = defalut;
      print(hosts.hosts44.IpAddress);
      expect(hosts.hosts44.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts44.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts45.HostsName;
      print(hosts.hosts45.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts45.HostsName = testData1s;
      print(hosts.hosts45.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts45.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts45.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts45.HostsName = testData2s;
      print(hosts.hosts45.HostsName);
      expect(hosts.hosts45.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts45.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts45.HostsName = defalut;
      print(hosts.hosts45.HostsName);
      expect(hosts.hosts45.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts45.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts45.IpAddress;
      print(hosts.hosts45.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts45.IpAddress = testData1s;
      print(hosts.hosts45.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts45.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts45.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts45.IpAddress = testData2s;
      print(hosts.hosts45.IpAddress);
      expect(hosts.hosts45.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts45.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts45.IpAddress = defalut;
      print(hosts.hosts45.IpAddress);
      expect(hosts.hosts45.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts45.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts46.HostsName;
      print(hosts.hosts46.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts46.HostsName = testData1s;
      print(hosts.hosts46.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts46.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts46.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts46.HostsName = testData2s;
      print(hosts.hosts46.HostsName);
      expect(hosts.hosts46.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts46.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts46.HostsName = defalut;
      print(hosts.hosts46.HostsName);
      expect(hosts.hosts46.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts46.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts46.IpAddress;
      print(hosts.hosts46.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts46.IpAddress = testData1s;
      print(hosts.hosts46.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts46.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts46.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts46.IpAddress = testData2s;
      print(hosts.hosts46.IpAddress);
      expect(hosts.hosts46.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts46.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts46.IpAddress = defalut;
      print(hosts.hosts46.IpAddress);
      expect(hosts.hosts46.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts46.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts47.HostsName;
      print(hosts.hosts47.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts47.HostsName = testData1s;
      print(hosts.hosts47.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts47.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts47.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts47.HostsName = testData2s;
      print(hosts.hosts47.HostsName);
      expect(hosts.hosts47.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts47.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts47.HostsName = defalut;
      print(hosts.hosts47.HostsName);
      expect(hosts.hosts47.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts47.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts47.IpAddress;
      print(hosts.hosts47.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts47.IpAddress = testData1s;
      print(hosts.hosts47.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts47.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts47.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts47.IpAddress = testData2s;
      print(hosts.hosts47.IpAddress);
      expect(hosts.hosts47.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts47.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts47.IpAddress = defalut;
      print(hosts.hosts47.IpAddress);
      expect(hosts.hosts47.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts47.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts48.HostsName;
      print(hosts.hosts48.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts48.HostsName = testData1s;
      print(hosts.hosts48.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts48.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts48.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts48.HostsName = testData2s;
      print(hosts.hosts48.HostsName);
      expect(hosts.hosts48.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts48.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts48.HostsName = defalut;
      print(hosts.hosts48.HostsName);
      expect(hosts.hosts48.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts48.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts48.IpAddress;
      print(hosts.hosts48.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts48.IpAddress = testData1s;
      print(hosts.hosts48.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts48.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts48.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts48.IpAddress = testData2s;
      print(hosts.hosts48.IpAddress);
      expect(hosts.hosts48.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts48.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts48.IpAddress = defalut;
      print(hosts.hosts48.IpAddress);
      expect(hosts.hosts48.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts48.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts49.HostsName;
      print(hosts.hosts49.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts49.HostsName = testData1s;
      print(hosts.hosts49.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts49.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts49.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts49.HostsName = testData2s;
      print(hosts.hosts49.HostsName);
      expect(hosts.hosts49.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts49.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts49.HostsName = defalut;
      print(hosts.hosts49.HostsName);
      expect(hosts.hosts49.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts49.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts49.IpAddress;
      print(hosts.hosts49.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts49.IpAddress = testData1s;
      print(hosts.hosts49.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts49.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts49.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts49.IpAddress = testData2s;
      print(hosts.hosts49.IpAddress);
      expect(hosts.hosts49.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts49.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts49.IpAddress = defalut;
      print(hosts.hosts49.IpAddress);
      expect(hosts.hosts49.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts49.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts50.HostsName;
      print(hosts.hosts50.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts50.HostsName = testData1s;
      print(hosts.hosts50.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts50.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts50.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts50.HostsName = testData2s;
      print(hosts.hosts50.HostsName);
      expect(hosts.hosts50.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts50.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts50.HostsName = defalut;
      print(hosts.hosts50.HostsName);
      expect(hosts.hosts50.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts50.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts50.IpAddress;
      print(hosts.hosts50.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts50.IpAddress = testData1s;
      print(hosts.hosts50.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts50.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts50.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts50.IpAddress = testData2s;
      print(hosts.hosts50.IpAddress);
      expect(hosts.hosts50.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts50.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts50.IpAddress = defalut;
      print(hosts.hosts50.IpAddress);
      expect(hosts.hosts50.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts50.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts51.HostsName;
      print(hosts.hosts51.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts51.HostsName = testData1s;
      print(hosts.hosts51.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts51.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts51.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts51.HostsName = testData2s;
      print(hosts.hosts51.HostsName);
      expect(hosts.hosts51.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts51.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts51.HostsName = defalut;
      print(hosts.hosts51.HostsName);
      expect(hosts.hosts51.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts51.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts51.IpAddress;
      print(hosts.hosts51.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts51.IpAddress = testData1s;
      print(hosts.hosts51.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts51.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts51.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts51.IpAddress = testData2s;
      print(hosts.hosts51.IpAddress);
      expect(hosts.hosts51.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts51.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts51.IpAddress = defalut;
      print(hosts.hosts51.IpAddress);
      expect(hosts.hosts51.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts51.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts52.HostsName;
      print(hosts.hosts52.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts52.HostsName = testData1s;
      print(hosts.hosts52.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts52.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts52.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts52.HostsName = testData2s;
      print(hosts.hosts52.HostsName);
      expect(hosts.hosts52.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts52.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts52.HostsName = defalut;
      print(hosts.hosts52.HostsName);
      expect(hosts.hosts52.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts52.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts52.IpAddress;
      print(hosts.hosts52.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts52.IpAddress = testData1s;
      print(hosts.hosts52.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts52.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts52.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts52.IpAddress = testData2s;
      print(hosts.hosts52.IpAddress);
      expect(hosts.hosts52.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts52.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts52.IpAddress = defalut;
      print(hosts.hosts52.IpAddress);
      expect(hosts.hosts52.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts52.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts53.HostsName;
      print(hosts.hosts53.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts53.HostsName = testData1s;
      print(hosts.hosts53.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts53.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts53.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts53.HostsName = testData2s;
      print(hosts.hosts53.HostsName);
      expect(hosts.hosts53.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts53.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts53.HostsName = defalut;
      print(hosts.hosts53.HostsName);
      expect(hosts.hosts53.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts53.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts53.IpAddress;
      print(hosts.hosts53.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts53.IpAddress = testData1s;
      print(hosts.hosts53.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts53.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts53.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts53.IpAddress = testData2s;
      print(hosts.hosts53.IpAddress);
      expect(hosts.hosts53.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts53.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts53.IpAddress = defalut;
      print(hosts.hosts53.IpAddress);
      expect(hosts.hosts53.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts53.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts54.HostsName;
      print(hosts.hosts54.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts54.HostsName = testData1s;
      print(hosts.hosts54.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts54.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts54.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts54.HostsName = testData2s;
      print(hosts.hosts54.HostsName);
      expect(hosts.hosts54.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts54.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts54.HostsName = defalut;
      print(hosts.hosts54.HostsName);
      expect(hosts.hosts54.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts54.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts54.IpAddress;
      print(hosts.hosts54.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts54.IpAddress = testData1s;
      print(hosts.hosts54.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts54.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts54.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts54.IpAddress = testData2s;
      print(hosts.hosts54.IpAddress);
      expect(hosts.hosts54.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts54.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts54.IpAddress = defalut;
      print(hosts.hosts54.IpAddress);
      expect(hosts.hosts54.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts54.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts55.HostsName;
      print(hosts.hosts55.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts55.HostsName = testData1s;
      print(hosts.hosts55.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts55.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts55.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts55.HostsName = testData2s;
      print(hosts.hosts55.HostsName);
      expect(hosts.hosts55.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts55.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts55.HostsName = defalut;
      print(hosts.hosts55.HostsName);
      expect(hosts.hosts55.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts55.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts55.IpAddress;
      print(hosts.hosts55.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts55.IpAddress = testData1s;
      print(hosts.hosts55.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts55.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts55.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts55.IpAddress = testData2s;
      print(hosts.hosts55.IpAddress);
      expect(hosts.hosts55.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts55.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts55.IpAddress = defalut;
      print(hosts.hosts55.IpAddress);
      expect(hosts.hosts55.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts55.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts56.HostsName;
      print(hosts.hosts56.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts56.HostsName = testData1s;
      print(hosts.hosts56.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts56.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts56.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts56.HostsName = testData2s;
      print(hosts.hosts56.HostsName);
      expect(hosts.hosts56.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts56.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts56.HostsName = defalut;
      print(hosts.hosts56.HostsName);
      expect(hosts.hosts56.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts56.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts56.IpAddress;
      print(hosts.hosts56.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts56.IpAddress = testData1s;
      print(hosts.hosts56.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts56.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts56.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts56.IpAddress = testData2s;
      print(hosts.hosts56.IpAddress);
      expect(hosts.hosts56.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts56.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts56.IpAddress = defalut;
      print(hosts.hosts56.IpAddress);
      expect(hosts.hosts56.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts56.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts57.HostsName;
      print(hosts.hosts57.HostsName);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts57.HostsName = testData1s;
      print(hosts.hosts57.HostsName);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts57.HostsName == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts57.HostsName == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts57.HostsName = testData2s;
      print(hosts.hosts57.HostsName);
      expect(hosts.hosts57.HostsName == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts57.HostsName == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts57.HostsName = defalut;
      print(hosts.hosts57.HostsName);
      expect(hosts.hosts57.HostsName == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts57.HostsName == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      hosts = HostsJsonFile();
      allPropatyCheckInit(hosts);

      // ①loadを実行する。
      await hosts.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hosts.hosts57.IpAddress;
      print(hosts.hosts57.IpAddress);

      // ②指定したプロパティにテストデータ1を書き込む。
      hosts.hosts57.IpAddress = testData1s;
      print(hosts.hosts57.IpAddress);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hosts.hosts57.IpAddress == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hosts.save();
      await hosts.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hosts.hosts57.IpAddress == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hosts.hosts57.IpAddress = testData2s;
      print(hosts.hosts57.IpAddress);
      expect(hosts.hosts57.IpAddress == testData2s, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts57.IpAddress == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hosts.hosts57.IpAddress = defalut;
      print(hosts.hosts57.IpAddress);
      expect(hosts.hosts57.IpAddress == defalut, true);
      await hosts.save();
      await hosts.load();
      expect(hosts.hosts57.IpAddress == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hosts, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

  });
}

void allPropatyCheckInit(HostsJsonFile test)
{
  expect(test.hosts1.HostsName, "");
  expect(test.hosts1.IpAddress, "");
  expect(test.hosts2.HostsName, "");
  expect(test.hosts2.IpAddress, "");
  expect(test.hosts3.HostsName, "");
  expect(test.hosts3.IpAddress, "");
  expect(test.hosts4.HostsName, "");
  expect(test.hosts4.IpAddress, "");
  expect(test.hosts5.HostsName, "");
  expect(test.hosts5.IpAddress, "");
  expect(test.hosts6.HostsName, "");
  expect(test.hosts6.IpAddress, "");
  expect(test.hosts7.HostsName, "");
  expect(test.hosts7.IpAddress, "");
  expect(test.hosts8.HostsName, "");
  expect(test.hosts8.IpAddress, "");
  expect(test.hosts9.HostsName, "");
  expect(test.hosts9.IpAddress, "");
  expect(test.hosts10.HostsName, "");
  expect(test.hosts10.IpAddress, "");
  expect(test.hosts11.HostsName, "");
  expect(test.hosts11.IpAddress, "");
  expect(test.hosts12.HostsName, "");
  expect(test.hosts12.IpAddress, "");
  expect(test.hosts13.HostsName, "");
  expect(test.hosts13.IpAddress, "");
  expect(test.hosts14.HostsName, "");
  expect(test.hosts14.IpAddress, "");
  expect(test.hosts15.HostsName, "");
  expect(test.hosts15.IpAddress, "");
  expect(test.hosts16.HostsName, "");
  expect(test.hosts16.IpAddress, "");
  expect(test.hosts17.HostsName, "");
  expect(test.hosts17.IpAddress, "");
  expect(test.hosts18.HostsName, "");
  expect(test.hosts18.IpAddress, "");
  expect(test.hosts19.HostsName, "");
  expect(test.hosts19.IpAddress, "");
  expect(test.hosts20.HostsName, "");
  expect(test.hosts20.IpAddress, "");
  expect(test.hosts21.HostsName, "");
  expect(test.hosts21.IpAddress, "");
  expect(test.hosts22.HostsName, "");
  expect(test.hosts22.IpAddress, "");
  expect(test.hosts23.HostsName, "");
  expect(test.hosts23.IpAddress, "");
  expect(test.hosts24.HostsName, "");
  expect(test.hosts24.IpAddress, "");
  expect(test.hosts25.HostsName, "");
  expect(test.hosts25.IpAddress, "");
  expect(test.hosts26.HostsName, "");
  expect(test.hosts26.IpAddress, "");
  expect(test.hosts27.HostsName, "");
  expect(test.hosts27.IpAddress, "");
  expect(test.hosts28.HostsName, "");
  expect(test.hosts28.IpAddress, "");
  expect(test.hosts29.HostsName, "");
  expect(test.hosts29.IpAddress, "");
  expect(test.hosts30.HostsName, "");
  expect(test.hosts30.IpAddress, "");
  expect(test.hosts31.HostsName, "");
  expect(test.hosts31.IpAddress, "");
  expect(test.hosts32.HostsName, "");
  expect(test.hosts32.IpAddress, "");
  expect(test.hosts33.HostsName, "");
  expect(test.hosts33.IpAddress, "");
  expect(test.hosts34.HostsName, "");
  expect(test.hosts34.IpAddress, "");
  expect(test.hosts35.HostsName, "");
  expect(test.hosts35.IpAddress, "");
  expect(test.hosts36.HostsName, "");
  expect(test.hosts36.IpAddress, "");
  expect(test.hosts37.HostsName, "");
  expect(test.hosts37.IpAddress, "");
  expect(test.hosts38.HostsName, "");
  expect(test.hosts38.IpAddress, "");
  expect(test.hosts39.HostsName, "");
  expect(test.hosts39.IpAddress, "");
  expect(test.hosts40.HostsName, "");
  expect(test.hosts40.IpAddress, "");
  expect(test.hosts41.HostsName, "");
  expect(test.hosts41.IpAddress, "");
  expect(test.hosts42.HostsName, "");
  expect(test.hosts42.IpAddress, "");
  expect(test.hosts43.HostsName, "");
  expect(test.hosts43.IpAddress, "");
  expect(test.hosts44.HostsName, "");
  expect(test.hosts44.IpAddress, "");
  expect(test.hosts45.HostsName, "");
  expect(test.hosts45.IpAddress, "");
  expect(test.hosts46.HostsName, "");
  expect(test.hosts46.IpAddress, "");
  expect(test.hosts47.HostsName, "");
  expect(test.hosts47.IpAddress, "");
  expect(test.hosts48.HostsName, "");
  expect(test.hosts48.IpAddress, "");
  expect(test.hosts49.HostsName, "");
  expect(test.hosts49.IpAddress, "");
  expect(test.hosts50.HostsName, "");
  expect(test.hosts50.IpAddress, "");
  expect(test.hosts51.HostsName, "");
  expect(test.hosts51.IpAddress, "");
  expect(test.hosts52.HostsName, "");
  expect(test.hosts52.IpAddress, "");
  expect(test.hosts53.HostsName, "");
  expect(test.hosts53.IpAddress, "");
  expect(test.hosts54.HostsName, "");
  expect(test.hosts54.IpAddress, "");
  expect(test.hosts55.HostsName, "");
  expect(test.hosts55.IpAddress, "");
  expect(test.hosts56.HostsName, "");
  expect(test.hosts56.IpAddress, "");
  expect(test.hosts57.HostsName, "");
  expect(test.hosts57.IpAddress, "");
}

void allPropatyCheck(HostsJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.hosts1.HostsName, "localhost");
  }
  expect(test.hosts1.IpAddress, "127.0.0.1");
  expect(test.hosts2.HostsName, "ts2100");
  expect(test.hosts2.IpAddress, "192.168.10.127");
  expect(test.hosts3.HostsName, "ts21db");
  expect(test.hosts3.IpAddress, "0.0.0.0");
  expect(test.hosts4.HostsName, "web000001");
  expect(test.hosts4.IpAddress, "192.168.10.1");
  expect(test.hosts5.HostsName, "subsrx");
  expect(test.hosts5.IpAddress, "192.168.10.1");
  expect(test.hosts6.HostsName, "compc");
  expect(test.hosts6.IpAddress, "192.168.10.126");
  expect(test.hosts7.HostsName, "mblsvr");
  expect(test.hosts7.IpAddress, "192.168.10.1");
  expect(test.hosts8.HostsName, "Con_steps");
  expect(test.hosts8.IpAddress, "200.1.1.104");
  expect(test.hosts9.HostsName, "poppy");
  expect(test.hosts9.IpAddress, "0.0.0.0");
  expect(test.hosts10.HostsName, "manage");
  expect(test.hosts10.IpAddress, "0.0.0.0");
  expect(test.hosts11.HostsName, "sims2100");
  expect(test.hosts11.IpAddress, "0.0.0.0");
  expect(test.hosts12.HostsName, "custserver");
  expect(test.hosts12.IpAddress, "0.0.0.0");
  expect(test.hosts13.HostsName, "mp1");
  expect(test.hosts13.IpAddress, "0.0.0.0");
  expect(test.hosts14.HostsName, "gx_server");
  expect(test.hosts14.IpAddress, "0.0.0.0");
  expect(test.hosts15.HostsName, "gx_s_server");
  expect(test.hosts15.IpAddress, "0.0.0.0");
  expect(test.hosts16.HostsName, "hqserver");
  expect(test.hosts16.IpAddress, "0.0.0.0");
  expect(test.hosts17.HostsName, "landisk");
  expect(test.hosts17.IpAddress, "0.0.0.0");
  expect(test.hosts18.HostsName, "hq2server");
  expect(test.hosts18.IpAddress, "0.0.0.0");
  expect(test.hosts19.HostsName, "hqimg_server");
  expect(test.hosts19.IpAddress, "0.0.0.0");
  expect(test.hosts20.HostsName, "new_hq");
  expect(test.hosts20.IpAddress, "0.0.0.0");
  expect(test.hosts21.HostsName, "hq_second");
  expect(test.hosts21.IpAddress, "0.0.0.0");
  expect(test.hosts22.HostsName, "new_hq_second");
  expect(test.hosts22.IpAddress, "0.0.0.0");
  expect(test.hosts23.HostsName, "drugrev");
  expect(test.hosts23.IpAddress, "0.0.0.0");
  expect(test.hosts24.HostsName, "timeserver");
  expect(test.hosts24.IpAddress, "0.0.0.0");
  expect(test.hosts25.HostsName, "centerserver_mst");
  expect(test.hosts25.IpAddress, "0.0.0.0");
  expect(test.hosts26.HostsName, "centerserver_trn");
  expect(test.hosts26.IpAddress, "0.0.0.0");
  expect(test.hosts27.HostsName, "custserver2");
  expect(test.hosts27.IpAddress, "0.0.0.0");
  expect(test.hosts28.HostsName, "posinfo");
  expect(test.hosts28.IpAddress, "0.0.0.0");
  expect(test.hosts29.HostsName, "pbchg1");
  expect(test.hosts29.IpAddress, "0.0.0.0");
  expect(test.hosts30.HostsName, "pbchg2");
  expect(test.hosts30.IpAddress, "0.0.0.0");
  expect(test.hosts31.HostsName, "compc2");
  expect(test.hosts31.IpAddress, "0.0.0.0");
  expect(test.hosts32.HostsName, "spqc");
  expect(test.hosts32.IpAddress, "0.0.0.0");
  expect(test.hosts33.HostsName, "two_connect");
  expect(test.hosts33.IpAddress, "0.0.0.0");
  expect(test.hosts34.HostsName, "point-system");
  expect(test.hosts34.IpAddress, "184.205.1.151");
  expect(test.hosts35.HostsName, "real.ja-point.com");
  expect(test.hosts35.IpAddress, "184.205.2.101");
  expect(test.hosts36.HostsName, "spqc_subsvr");
  expect(test.hosts36.IpAddress, "0.0.0.0");
  expect(test.hosts37.HostsName, "MailExchanger");
  expect(test.hosts37.IpAddress, "0.0.0.0");
  expect(test.hosts38.HostsName, "mvserver");
  expect(test.hosts38.IpAddress, "0.0.0.0");
  expect(test.hosts39.HostsName, "brain");
  expect(test.hosts39.IpAddress, "0.0.0.0");
  expect(test.hosts40.HostsName, "hq_2nd_server");
  expect(test.hosts40.IpAddress, "0.0.0.0");
  expect(test.hosts41.HostsName, "verup_cnct");
  expect(test.hosts41.IpAddress, "0.0.0.0");
  expect(test.hosts42.HostsName, "sqrc_server");
  expect(test.hosts42.IpAddress, "0.0.0.0");
  expect(test.hosts43.HostsName, "kitchen_print1");
  expect(test.hosts43.IpAddress, "0.0.0.0");
  expect(test.hosts44.HostsName, "kitchen_print2");
  expect(test.hosts44.IpAddress, "0.0.0.0");
  expect(test.hosts45.HostsName, "bkup_save");
  expect(test.hosts45.IpAddress, "0.0.0.0");
  expect(test.hosts46.HostsName, "tswebsvr");
  expect(test.hosts46.IpAddress, "0.0.0.0");
  expect(test.hosts47.HostsName, "histlog_server");
  expect(test.hosts47.IpAddress, "0.0.0.0");
  expect(test.hosts48.HostsName, "pack_on_time_svr");
  expect(test.hosts48.IpAddress, "0.0.0.0");
  expect(test.hosts49.HostsName, "histlog_sub_server");
  expect(test.hosts49.IpAddress, "0.0.0.0");
  expect(test.hosts50.HostsName, "cust_reserve_svr");
  expect(test.hosts50.IpAddress, "0.0.0.0");
  expect(test.hosts51.HostsName, "dpoint");
  expect(test.hosts51.IpAddress, "0.0.0.0");
  expect(test.hosts52.HostsName, "dpoint_rela_svr");
  expect(test.hosts52.IpAddress, "0.0.0.0");
  expect(test.hosts53.HostsName, "tpoint");
  expect(test.hosts53.IpAddress, "0.0.0.0");
  expect(test.hosts54.HostsName, "iot.975194.jp");
  expect(test.hosts54.IpAddress, "52.193.215.32");
  expect(test.hosts55.HostsName, "ws_hq");
  expect(test.hosts55.IpAddress, "192.168.11.150");
  expect(test.hosts56.HostsName, "recovery_file");
  expect(test.hosts56.IpAddress, "0.0.0.0");
  expect(test.hosts57.HostsName, "aibox");
  expect(test.hosts57.IpAddress, "0.0.0.0");
}

