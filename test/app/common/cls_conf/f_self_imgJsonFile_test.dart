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
import '../../../../lib/app/common/cls_conf/f_self_imgJsonFile.dart';

late F_self_imgJsonFile f_self_img;

void main(){
  f_self_imgJsonFile_test();
}

void f_self_imgJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "f_self_img.json";
  const String section = "org_ini_name";
  const String key = "img_no";
  const defaultData = "f_self_img1";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('F_self_imgJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await F_self_imgJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await F_self_imgJsonFile().setDefault();
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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await f_self_img.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(f_self_img,true);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        f_self_img.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await f_self_img.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(f_self_img,true);

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
      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①：loadを実行する。
      await f_self_img.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = f_self_img.org_ini_name.img_no;
      f_self_img.org_ini_name.img_no = testData1s;
      expect(f_self_img.org_ini_name.img_no == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await f_self_img.load();
      expect(f_self_img.org_ini_name.img_no != testData1s, true);
      expect(f_self_img.org_ini_name.img_no == prefixData, true);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = f_self_img.org_ini_name.img_no;
      f_self_img.org_ini_name.img_no = testData1s;
      expect(f_self_img.org_ini_name.img_no, testData1s);

      // ③saveを実行する。
      await f_self_img.save();

      // ④loadを実行する。
      await f_self_img.load();

      expect(f_self_img.org_ini_name.img_no != prefixData, true);
      expect(f_self_img.org_ini_name.img_no == testData1s, true);
      allPropatyCheck(f_self_img,false);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await f_self_img.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await f_self_img.save();

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await f_self_img.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(f_self_img.org_ini_name.img_no, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = f_self_img.org_ini_name.img_no;
      f_self_img.org_ini_name.img_no = testData1s;

      // ③ saveを実行する。
      await f_self_img.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(f_self_img.org_ini_name.img_no, testData1s);

      // ④ loadを実行する。
      await f_self_img.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(f_self_img.org_ini_name.img_no == testData1s, true);
      allPropatyCheck(f_self_img,false);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await f_self_img.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(f_self_img,true);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②任意のプロパティの値を変更する。
      f_self_img.org_ini_name.img_no = testData1s;
      expect(f_self_img.org_ini_name.img_no, testData1s);

      // ③saveを実行する。
      await f_self_img.save();
      expect(f_self_img.org_ini_name.img_no, testData1s);

      // ④loadを実行する。
      await f_self_img.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(f_self_img,true);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await f_self_img.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await f_self_img.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(f_self_img.org_ini_name.img_no == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await f_self_img.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await f_self_img.setValueWithName(section, "test_key", testData1s);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②任意のプロパティを変更する。
      f_self_img.org_ini_name.img_no = testData1s;

      // ③saveを実行する。
      await f_self_img.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await f_self_img.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②任意のプロパティを変更する。
      f_self_img.org_ini_name.img_no = testData1s;

      // ③saveを実行する。
      await f_self_img.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await f_self_img.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②任意のプロパティを変更する。
      f_self_img.org_ini_name.img_no = testData1s;

      // ③saveを実行する。
      await f_self_img.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await f_self_img.getValueWithName(section, "test_key");
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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await f_self_img.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      f_self_img.org_ini_name.img_no = testData1s;
      expect(f_self_img.org_ini_name.img_no, testData1s);

      // ④saveを実行する。
      await f_self_img.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(f_self_img.org_ini_name.img_no, testData1s);
      
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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await f_self_img.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + f_self_img.org_ini_name.img_no.toString());
      expect(f_self_img.org_ini_name.img_no == testData1s, true);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await f_self_img.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + f_self_img.org_ini_name.img_no.toString());
      expect(f_self_img.org_ini_name.img_no == testData2s, true);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await f_self_img.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + f_self_img.org_ini_name.img_no.toString());
      expect(f_self_img.org_ini_name.img_no == testData1s, true);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await f_self_img.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + f_self_img.org_ini_name.img_no.toString());
      expect(f_self_img.org_ini_name.img_no == testData2s, true);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await f_self_img.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + f_self_img.org_ini_name.img_no.toString());
      expect(f_self_img.org_ini_name.img_no == testData1s, true);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await f_self_img.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + f_self_img.org_ini_name.img_no.toString());
      expect(f_self_img.org_ini_name.img_no == testData1s, true);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await f_self_img.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + f_self_img.org_ini_name.img_no.toString());
      allPropatyCheck(f_self_img,true);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await f_self_img.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + f_self_img.org_ini_name.img_no.toString());
      allPropatyCheck(f_self_img,true);

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

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.org_ini_name.img_no;
      print(f_self_img.org_ini_name.img_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.org_ini_name.img_no = testData1s;
      print(f_self_img.org_ini_name.img_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.org_ini_name.img_no == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.org_ini_name.img_no == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.org_ini_name.img_no = testData2s;
      print(f_self_img.org_ini_name.img_no);
      expect(f_self_img.org_ini_name.img_no == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.org_ini_name.img_no == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.org_ini_name.img_no = defalut;
      print(f_self_img.org_ini_name.img_no);
      expect(f_self_img.org_ini_name.img_no == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.org_ini_name.img_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_start_name;
      print(f_self_img.png_name.image_start_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_start_name = testData1;
      print(f_self_img.png_name.image_start_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_start_name == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_start_name == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_start_name = testData2;
      print(f_self_img.png_name.image_start_name);
      expect(f_self_img.png_name.image_start_name == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_start_name == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_start_name = defalut;
      print(f_self_img.png_name.image_start_name);
      expect(f_self_img.png_name.image_start_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_start_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_bese_name;
      print(f_self_img.png_name.image_bese_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_bese_name = testData1s;
      print(f_self_img.png_name.image_bese_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_bese_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_bese_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_bese_name = testData2s;
      print(f_self_img.png_name.image_bese_name);
      expect(f_self_img.png_name.image_bese_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_bese_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_bese_name = defalut;
      print(f_self_img.png_name.image_bese_name);
      expect(f_self_img.png_name.image_bese_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_bese_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_item_name;
      print(f_self_img.png_name.image_item_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_item_name = testData1s;
      print(f_self_img.png_name.image_item_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_item_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_item_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_item_name = testData2s;
      print(f_self_img.png_name.image_item_name);
      expect(f_self_img.png_name.image_item_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_item_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_item_name = defalut;
      print(f_self_img.png_name.image_item_name);
      expect(f_self_img.png_name.image_item_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_item_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_itembig_name;
      print(f_self_img.png_name.image_itembig_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_itembig_name = testData1s;
      print(f_self_img.png_name.image_itembig_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_itembig_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_itembig_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_itembig_name = testData2s;
      print(f_self_img.png_name.image_itembig_name);
      expect(f_self_img.png_name.image_itembig_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_itembig_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_itembig_name = defalut;
      print(f_self_img.png_name.image_itembig_name);
      expect(f_self_img.png_name.image_itembig_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_itembig_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_list3_name;
      print(f_self_img.png_name.image_list3_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_list3_name = testData1s;
      print(f_self_img.png_name.image_list3_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_list3_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_list3_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_list3_name = testData2s;
      print(f_self_img.png_name.image_list3_name);
      expect(f_self_img.png_name.image_list3_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_list3_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_list3_name = defalut;
      print(f_self_img.png_name.image_list3_name);
      expect(f_self_img.png_name.image_list3_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_list3_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_subtotal_name;
      print(f_self_img.png_name.image_subtotal_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_subtotal_name = testData1s;
      print(f_self_img.png_name.image_subtotal_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_subtotal_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_subtotal_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_subtotal_name = testData2s;
      print(f_self_img.png_name.image_subtotal_name);
      expect(f_self_img.png_name.image_subtotal_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_subtotal_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_subtotal_name = defalut;
      print(f_self_img.png_name.image_subtotal_name);
      expect(f_self_img.png_name.image_subtotal_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_subtotal_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_total_name;
      print(f_self_img.png_name.image_total_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_total_name = testData1s;
      print(f_self_img.png_name.image_total_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_total_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_total_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_total_name = testData2s;
      print(f_self_img.png_name.image_total_name);
      expect(f_self_img.png_name.image_total_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_total_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_total_name = defalut;
      print(f_self_img.png_name.image_total_name);
      expect(f_self_img.png_name.image_total_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_total_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_totalbig_name;
      print(f_self_img.png_name.image_totalbig_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_totalbig_name = testData1s;
      print(f_self_img.png_name.image_totalbig_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_totalbig_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_totalbig_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_totalbig_name = testData2s;
      print(f_self_img.png_name.image_totalbig_name);
      expect(f_self_img.png_name.image_totalbig_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_totalbig_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_totalbig_name = defalut;
      print(f_self_img.png_name.image_totalbig_name);
      expect(f_self_img.png_name.image_totalbig_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_totalbig_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_ttl_off_name;
      print(f_self_img.png_name.image_ttl_off_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_ttl_off_name = testData1s;
      print(f_self_img.png_name.image_ttl_off_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_ttl_off_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_ttl_off_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_ttl_off_name = testData2s;
      print(f_self_img.png_name.image_ttl_off_name);
      expect(f_self_img.png_name.image_ttl_off_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_ttl_off_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_ttl_off_name = defalut;
      print(f_self_img.png_name.image_ttl_off_name);
      expect(f_self_img.png_name.image_ttl_off_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_ttl_off_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_ttl_ok_name;
      print(f_self_img.png_name.image_ttl_ok_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_ttl_ok_name = testData1s;
      print(f_self_img.png_name.image_ttl_ok_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_ttl_ok_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_ttl_ok_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_ttl_ok_name = testData2s;
      print(f_self_img.png_name.image_ttl_ok_name);
      expect(f_self_img.png_name.image_ttl_ok_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_ttl_ok_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_ttl_ok_name = defalut;
      print(f_self_img.png_name.image_ttl_ok_name);
      expect(f_self_img.png_name.image_ttl_ok_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_ttl_ok_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_ttl_total_name;
      print(f_self_img.png_name.image_ttl_total_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_ttl_total_name = testData1s;
      print(f_self_img.png_name.image_ttl_total_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_ttl_total_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_ttl_total_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_ttl_total_name = testData2s;
      print(f_self_img.png_name.image_ttl_total_name);
      expect(f_self_img.png_name.image_ttl_total_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_ttl_total_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_ttl_total_name = defalut;
      print(f_self_img.png_name.image_ttl_total_name);
      expect(f_self_img.png_name.image_ttl_total_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_ttl_total_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_ttl_unpaid_name;
      print(f_self_img.png_name.image_ttl_unpaid_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_ttl_unpaid_name = testData1s;
      print(f_self_img.png_name.image_ttl_unpaid_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_ttl_unpaid_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_ttl_unpaid_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_ttl_unpaid_name = testData2s;
      print(f_self_img.png_name.image_ttl_unpaid_name);
      expect(f_self_img.png_name.image_ttl_unpaid_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_ttl_unpaid_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_ttl_unpaid_name = defalut;
      print(f_self_img.png_name.image_ttl_unpaid_name);
      expect(f_self_img.png_name.image_ttl_unpaid_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_ttl_unpaid_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_txt_name;
      print(f_self_img.png_name.image_txt_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_txt_name = testData1s;
      print(f_self_img.png_name.image_txt_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_txt_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_txt_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_txt_name = testData2s;
      print(f_self_img.png_name.image_txt_name);
      expect(f_self_img.png_name.image_txt_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_txt_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_txt_name = defalut;
      print(f_self_img.png_name.image_txt_name);
      expect(f_self_img.png_name.image_txt_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_txt_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_itemanytime_name;
      print(f_self_img.png_name.image_itemanytime_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_itemanytime_name = testData1s;
      print(f_self_img.png_name.image_itemanytime_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_itemanytime_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_itemanytime_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_itemanytime_name = testData2s;
      print(f_self_img.png_name.image_itemanytime_name);
      expect(f_self_img.png_name.image_itemanytime_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_itemanytime_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_itemanytime_name = defalut;
      print(f_self_img.png_name.image_itemanytime_name);
      expect(f_self_img.png_name.image_itemanytime_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_itemanytime_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_totalbig_anytime_name;
      print(f_self_img.png_name.image_totalbig_anytime_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_totalbig_anytime_name = testData1s;
      print(f_self_img.png_name.image_totalbig_anytime_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_totalbig_anytime_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_totalbig_anytime_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_totalbig_anytime_name = testData2s;
      print(f_self_img.png_name.image_totalbig_anytime_name);
      expect(f_self_img.png_name.image_totalbig_anytime_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_totalbig_anytime_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_totalbig_anytime_name = defalut;
      print(f_self_img.png_name.image_totalbig_anytime_name);
      expect(f_self_img.png_name.image_totalbig_anytime_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_totalbig_anytime_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_bigcheck_1_name;
      print(f_self_img.png_name.image_btn_bigcheck_1_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_bigcheck_1_name = testData1s;
      print(f_self_img.png_name.image_btn_bigcheck_1_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_bigcheck_1_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_bigcheck_1_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_bigcheck_1_name = testData2s;
      print(f_self_img.png_name.image_btn_bigcheck_1_name);
      expect(f_self_img.png_name.image_btn_bigcheck_1_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_bigcheck_1_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_bigcheck_1_name = defalut;
      print(f_self_img.png_name.image_btn_bigcheck_1_name);
      expect(f_self_img.png_name.image_btn_bigcheck_1_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_bigcheck_1_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_bigcheck_2_name;
      print(f_self_img.png_name.image_btn_bigcheck_2_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_bigcheck_2_name = testData1s;
      print(f_self_img.png_name.image_btn_bigcheck_2_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_bigcheck_2_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_bigcheck_2_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_bigcheck_2_name = testData2s;
      print(f_self_img.png_name.image_btn_bigcheck_2_name);
      expect(f_self_img.png_name.image_btn_bigcheck_2_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_bigcheck_2_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_bigcheck_2_name = defalut;
      print(f_self_img.png_name.image_btn_bigcheck_2_name);
      expect(f_self_img.png_name.image_btn_bigcheck_2_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_bigcheck_2_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_bigcheck_down_name;
      print(f_self_img.png_name.image_btn_bigcheck_down_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_bigcheck_down_name = testData1s;
      print(f_self_img.png_name.image_btn_bigcheck_down_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_bigcheck_down_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_bigcheck_down_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_bigcheck_down_name = testData2s;
      print(f_self_img.png_name.image_btn_bigcheck_down_name);
      expect(f_self_img.png_name.image_btn_bigcheck_down_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_bigcheck_down_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_bigcheck_down_name = defalut;
      print(f_self_img.png_name.image_btn_bigcheck_down_name);
      expect(f_self_img.png_name.image_btn_bigcheck_down_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_bigcheck_down_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_check_1_name;
      print(f_self_img.png_name.image_btn_check_1_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_check_1_name = testData1s;
      print(f_self_img.png_name.image_btn_check_1_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_check_1_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_check_1_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_check_1_name = testData2s;
      print(f_self_img.png_name.image_btn_check_1_name);
      expect(f_self_img.png_name.image_btn_check_1_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_check_1_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_check_1_name = defalut;
      print(f_self_img.png_name.image_btn_check_1_name);
      expect(f_self_img.png_name.image_btn_check_1_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_check_1_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_check_2_name;
      print(f_self_img.png_name.image_btn_check_2_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_check_2_name = testData1s;
      print(f_self_img.png_name.image_btn_check_2_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_check_2_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_check_2_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_check_2_name = testData2s;
      print(f_self_img.png_name.image_btn_check_2_name);
      expect(f_self_img.png_name.image_btn_check_2_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_check_2_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_check_2_name = defalut;
      print(f_self_img.png_name.image_btn_check_2_name);
      expect(f_self_img.png_name.image_btn_check_2_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_check_2_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_check_down_name;
      print(f_self_img.png_name.image_btn_check_down_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_check_down_name = testData1s;
      print(f_self_img.png_name.image_btn_check_down_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_check_down_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_check_down_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_check_down_name = testData2s;
      print(f_self_img.png_name.image_btn_check_down_name);
      expect(f_self_img.png_name.image_btn_check_down_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_check_down_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_check_down_name = defalut;
      print(f_self_img.png_name.image_btn_check_down_name);
      expect(f_self_img.png_name.image_btn_check_down_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_check_down_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_norcpt_1_name;
      print(f_self_img.png_name.image_btn_norcpt_1_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_norcpt_1_name = testData1s;
      print(f_self_img.png_name.image_btn_norcpt_1_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_norcpt_1_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_norcpt_1_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_norcpt_1_name = testData2s;
      print(f_self_img.png_name.image_btn_norcpt_1_name);
      expect(f_self_img.png_name.image_btn_norcpt_1_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_norcpt_1_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_norcpt_1_name = defalut;
      print(f_self_img.png_name.image_btn_norcpt_1_name);
      expect(f_self_img.png_name.image_btn_norcpt_1_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_norcpt_1_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_norcpt_2_name;
      print(f_self_img.png_name.image_btn_norcpt_2_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_norcpt_2_name = testData1s;
      print(f_self_img.png_name.image_btn_norcpt_2_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_norcpt_2_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_norcpt_2_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_norcpt_2_name = testData2s;
      print(f_self_img.png_name.image_btn_norcpt_2_name);
      expect(f_self_img.png_name.image_btn_norcpt_2_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_norcpt_2_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_norcpt_2_name = defalut;
      print(f_self_img.png_name.image_btn_norcpt_2_name);
      expect(f_self_img.png_name.image_btn_norcpt_2_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_norcpt_2_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_norcpt_down_name;
      print(f_self_img.png_name.image_btn_norcpt_down_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_norcpt_down_name = testData1s;
      print(f_self_img.png_name.image_btn_norcpt_down_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_norcpt_down_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_norcpt_down_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_norcpt_down_name = testData2s;
      print(f_self_img.png_name.image_btn_norcpt_down_name);
      expect(f_self_img.png_name.image_btn_norcpt_down_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_norcpt_down_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_norcpt_down_name = defalut;
      print(f_self_img.png_name.image_btn_norcpt_down_name);
      expect(f_self_img.png_name.image_btn_norcpt_down_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_norcpt_down_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_receipt_1_name;
      print(f_self_img.png_name.image_btn_receipt_1_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_receipt_1_name = testData1s;
      print(f_self_img.png_name.image_btn_receipt_1_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_receipt_1_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_receipt_1_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_receipt_1_name = testData2s;
      print(f_self_img.png_name.image_btn_receipt_1_name);
      expect(f_self_img.png_name.image_btn_receipt_1_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_receipt_1_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_receipt_1_name = defalut;
      print(f_self_img.png_name.image_btn_receipt_1_name);
      expect(f_self_img.png_name.image_btn_receipt_1_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_receipt_1_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_receipt_2_name;
      print(f_self_img.png_name.image_btn_receipt_2_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_receipt_2_name = testData1s;
      print(f_self_img.png_name.image_btn_receipt_2_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_receipt_2_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_receipt_2_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_receipt_2_name = testData2s;
      print(f_self_img.png_name.image_btn_receipt_2_name);
      expect(f_self_img.png_name.image_btn_receipt_2_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_receipt_2_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_receipt_2_name = defalut;
      print(f_self_img.png_name.image_btn_receipt_2_name);
      expect(f_self_img.png_name.image_btn_receipt_2_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_receipt_2_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_receipt_down_name;
      print(f_self_img.png_name.image_btn_receipt_down_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_receipt_down_name = testData1s;
      print(f_self_img.png_name.image_btn_receipt_down_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_receipt_down_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_receipt_down_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_receipt_down_name = testData2s;
      print(f_self_img.png_name.image_btn_receipt_down_name);
      expect(f_self_img.png_name.image_btn_receipt_down_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_receipt_down_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_receipt_down_name = defalut;
      print(f_self_img.png_name.image_btn_receipt_down_name);
      expect(f_self_img.png_name.image_btn_receipt_down_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_receipt_down_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_minicheck_1_name;
      print(f_self_img.png_name.image_btn_minicheck_1_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_minicheck_1_name = testData1s;
      print(f_self_img.png_name.image_btn_minicheck_1_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_minicheck_1_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_minicheck_1_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_minicheck_1_name = testData2s;
      print(f_self_img.png_name.image_btn_minicheck_1_name);
      expect(f_self_img.png_name.image_btn_minicheck_1_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_minicheck_1_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_minicheck_1_name = defalut;
      print(f_self_img.png_name.image_btn_minicheck_1_name);
      expect(f_self_img.png_name.image_btn_minicheck_1_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_minicheck_1_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_minicheck_2_name;
      print(f_self_img.png_name.image_btn_minicheck_2_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_minicheck_2_name = testData1s;
      print(f_self_img.png_name.image_btn_minicheck_2_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_minicheck_2_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_minicheck_2_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_minicheck_2_name = testData2s;
      print(f_self_img.png_name.image_btn_minicheck_2_name);
      expect(f_self_img.png_name.image_btn_minicheck_2_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_minicheck_2_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_minicheck_2_name = defalut;
      print(f_self_img.png_name.image_btn_minicheck_2_name);
      expect(f_self_img.png_name.image_btn_minicheck_2_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_minicheck_2_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_minicheck_down_name;
      print(f_self_img.png_name.image_btn_minicheck_down_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_minicheck_down_name = testData1s;
      print(f_self_img.png_name.image_btn_minicheck_down_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_minicheck_down_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_minicheck_down_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_minicheck_down_name = testData2s;
      print(f_self_img.png_name.image_btn_minicheck_down_name);
      expect(f_self_img.png_name.image_btn_minicheck_down_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_minicheck_down_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_minicheck_down_name = defalut;
      print(f_self_img.png_name.image_btn_minicheck_down_name);
      expect(f_self_img.png_name.image_btn_minicheck_down_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_minicheck_down_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_mini_norcpt_1_name;
      print(f_self_img.png_name.image_btn_mini_norcpt_1_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_mini_norcpt_1_name = testData1s;
      print(f_self_img.png_name.image_btn_mini_norcpt_1_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_mini_norcpt_1_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_mini_norcpt_1_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_mini_norcpt_1_name = testData2s;
      print(f_self_img.png_name.image_btn_mini_norcpt_1_name);
      expect(f_self_img.png_name.image_btn_mini_norcpt_1_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_mini_norcpt_1_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_mini_norcpt_1_name = defalut;
      print(f_self_img.png_name.image_btn_mini_norcpt_1_name);
      expect(f_self_img.png_name.image_btn_mini_norcpt_1_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_mini_norcpt_1_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_mini_norcpt_2_name;
      print(f_self_img.png_name.image_btn_mini_norcpt_2_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_mini_norcpt_2_name = testData1s;
      print(f_self_img.png_name.image_btn_mini_norcpt_2_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_mini_norcpt_2_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_mini_norcpt_2_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_mini_norcpt_2_name = testData2s;
      print(f_self_img.png_name.image_btn_mini_norcpt_2_name);
      expect(f_self_img.png_name.image_btn_mini_norcpt_2_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_mini_norcpt_2_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_mini_norcpt_2_name = defalut;
      print(f_self_img.png_name.image_btn_mini_norcpt_2_name);
      expect(f_self_img.png_name.image_btn_mini_norcpt_2_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_mini_norcpt_2_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_mini_norcpt_down_name;
      print(f_self_img.png_name.image_btn_mini_norcpt_down_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_mini_norcpt_down_name = testData1s;
      print(f_self_img.png_name.image_btn_mini_norcpt_down_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_mini_norcpt_down_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_mini_norcpt_down_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_mini_norcpt_down_name = testData2s;
      print(f_self_img.png_name.image_btn_mini_norcpt_down_name);
      expect(f_self_img.png_name.image_btn_mini_norcpt_down_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_mini_norcpt_down_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_mini_norcpt_down_name = defalut;
      print(f_self_img.png_name.image_btn_mini_norcpt_down_name);
      expect(f_self_img.png_name.image_btn_mini_norcpt_down_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_mini_norcpt_down_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_mini_receipt_1_name;
      print(f_self_img.png_name.image_btn_mini_receipt_1_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_mini_receipt_1_name = testData1s;
      print(f_self_img.png_name.image_btn_mini_receipt_1_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_mini_receipt_1_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_mini_receipt_1_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_mini_receipt_1_name = testData2s;
      print(f_self_img.png_name.image_btn_mini_receipt_1_name);
      expect(f_self_img.png_name.image_btn_mini_receipt_1_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_mini_receipt_1_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_mini_receipt_1_name = defalut;
      print(f_self_img.png_name.image_btn_mini_receipt_1_name);
      expect(f_self_img.png_name.image_btn_mini_receipt_1_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_mini_receipt_1_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_mini_receipt_2_name;
      print(f_self_img.png_name.image_btn_mini_receipt_2_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_mini_receipt_2_name = testData1s;
      print(f_self_img.png_name.image_btn_mini_receipt_2_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_mini_receipt_2_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_mini_receipt_2_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_mini_receipt_2_name = testData2s;
      print(f_self_img.png_name.image_btn_mini_receipt_2_name);
      expect(f_self_img.png_name.image_btn_mini_receipt_2_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_mini_receipt_2_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_mini_receipt_2_name = defalut;
      print(f_self_img.png_name.image_btn_mini_receipt_2_name);
      expect(f_self_img.png_name.image_btn_mini_receipt_2_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_mini_receipt_2_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.png_name.image_btn_mini_receipt_down_name;
      print(f_self_img.png_name.image_btn_mini_receipt_down_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.png_name.image_btn_mini_receipt_down_name = testData1s;
      print(f_self_img.png_name.image_btn_mini_receipt_down_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.png_name.image_btn_mini_receipt_down_name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.png_name.image_btn_mini_receipt_down_name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.png_name.image_btn_mini_receipt_down_name = testData2s;
      print(f_self_img.png_name.image_btn_mini_receipt_down_name);
      expect(f_self_img.png_name.image_btn_mini_receipt_down_name == testData2s, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_mini_receipt_down_name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.png_name.image_btn_mini_receipt_down_name = defalut;
      print(f_self_img.png_name.image_btn_mini_receipt_down_name);
      expect(f_self_img.png_name.image_btn_mini_receipt_down_name == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.png_name.image_btn_mini_receipt_down_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_zero_x;
      print(f_self_img.all_offset.offset_zero_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_zero_x = testData1;
      print(f_self_img.all_offset.offset_zero_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_zero_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_zero_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_zero_x = testData2;
      print(f_self_img.all_offset.offset_zero_x);
      expect(f_self_img.all_offset.offset_zero_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_zero_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_zero_x = defalut;
      print(f_self_img.all_offset.offset_zero_x);
      expect(f_self_img.all_offset.offset_zero_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_zero_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_zero_y;
      print(f_self_img.all_offset.offset_zero_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_zero_y = testData1;
      print(f_self_img.all_offset.offset_zero_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_zero_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_zero_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_zero_y = testData2;
      print(f_self_img.all_offset.offset_zero_y);
      expect(f_self_img.all_offset.offset_zero_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_zero_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_zero_y = defalut;
      print(f_self_img.all_offset.offset_zero_y);
      expect(f_self_img.all_offset.offset_zero_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_zero_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_list_item_main_x;
      print(f_self_img.all_offset.offset_list_item_main_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_list_item_main_x = testData1;
      print(f_self_img.all_offset.offset_list_item_main_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_list_item_main_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_list_item_main_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_list_item_main_x = testData2;
      print(f_self_img.all_offset.offset_list_item_main_x);
      expect(f_self_img.all_offset.offset_list_item_main_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_list_item_main_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_list_item_main_x = defalut;
      print(f_self_img.all_offset.offset_list_item_main_x);
      expect(f_self_img.all_offset.offset_list_item_main_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_list_item_main_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_list_item_main_y;
      print(f_self_img.all_offset.offset_list_item_main_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_list_item_main_y = testData1;
      print(f_self_img.all_offset.offset_list_item_main_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_list_item_main_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_list_item_main_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_list_item_main_y = testData2;
      print(f_self_img.all_offset.offset_list_item_main_y);
      expect(f_self_img.all_offset.offset_list_item_main_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_list_item_main_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_list_item_main_y = defalut;
      print(f_self_img.all_offset.offset_list_item_main_y);
      expect(f_self_img.all_offset.offset_list_item_main_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_list_item_main_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_list_item_tend_x;
      print(f_self_img.all_offset.offset_list_item_tend_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_list_item_tend_x = testData1;
      print(f_self_img.all_offset.offset_list_item_tend_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_list_item_tend_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_list_item_tend_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_list_item_tend_x = testData2;
      print(f_self_img.all_offset.offset_list_item_tend_x);
      expect(f_self_img.all_offset.offset_list_item_tend_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_list_item_tend_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_list_item_tend_x = defalut;
      print(f_self_img.all_offset.offset_list_item_tend_x);
      expect(f_self_img.all_offset.offset_list_item_tend_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_list_item_tend_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_list_item_tend_y;
      print(f_self_img.all_offset.offset_list_item_tend_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_list_item_tend_y = testData1;
      print(f_self_img.all_offset.offset_list_item_tend_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_list_item_tend_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_list_item_tend_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_list_item_tend_y = testData2;
      print(f_self_img.all_offset.offset_list_item_tend_y);
      expect(f_self_img.all_offset.offset_list_item_tend_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_list_item_tend_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_list_item_tend_y = defalut;
      print(f_self_img.all_offset.offset_list_item_tend_y);
      expect(f_self_img.all_offset.offset_list_item_tend_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_list_item_tend_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_item_tend_x;
      print(f_self_img.all_offset.offset_item_tend_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_item_tend_x = testData1;
      print(f_self_img.all_offset.offset_item_tend_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_item_tend_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_item_tend_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_item_tend_x = testData2;
      print(f_self_img.all_offset.offset_item_tend_x);
      expect(f_self_img.all_offset.offset_item_tend_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_item_tend_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_item_tend_x = defalut;
      print(f_self_img.all_offset.offset_item_tend_x);
      expect(f_self_img.all_offset.offset_item_tend_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_item_tend_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_item_tend_y;
      print(f_self_img.all_offset.offset_item_tend_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_item_tend_y = testData1;
      print(f_self_img.all_offset.offset_item_tend_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_item_tend_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_item_tend_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_item_tend_y = testData2;
      print(f_self_img.all_offset.offset_item_tend_y);
      expect(f_self_img.all_offset.offset_item_tend_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_item_tend_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_item_tend_y = defalut;
      print(f_self_img.all_offset.offset_item_tend_y);
      expect(f_self_img.all_offset.offset_item_tend_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_item_tend_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_stl1_cashin_x;
      print(f_self_img.all_offset.offset_stl1_cashin_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_stl1_cashin_x = testData1;
      print(f_self_img.all_offset.offset_stl1_cashin_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_stl1_cashin_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_stl1_cashin_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_stl1_cashin_x = testData2;
      print(f_self_img.all_offset.offset_stl1_cashin_x);
      expect(f_self_img.all_offset.offset_stl1_cashin_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_stl1_cashin_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_stl1_cashin_x = defalut;
      print(f_self_img.all_offset.offset_stl1_cashin_x);
      expect(f_self_img.all_offset.offset_stl1_cashin_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_stl1_cashin_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_stl1_cashin_y;
      print(f_self_img.all_offset.offset_stl1_cashin_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_stl1_cashin_y = testData1;
      print(f_self_img.all_offset.offset_stl1_cashin_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_stl1_cashin_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_stl1_cashin_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_stl1_cashin_y = testData2;
      print(f_self_img.all_offset.offset_stl1_cashin_y);
      expect(f_self_img.all_offset.offset_stl1_cashin_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_stl1_cashin_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_stl1_cashin_y = defalut;
      print(f_self_img.all_offset.offset_stl1_cashin_y);
      expect(f_self_img.all_offset.offset_stl1_cashin_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_stl1_cashin_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_stl2_tend_x;
      print(f_self_img.all_offset.offset_stl2_tend_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_stl2_tend_x = testData1;
      print(f_self_img.all_offset.offset_stl2_tend_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_stl2_tend_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_stl2_tend_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_stl2_tend_x = testData2;
      print(f_self_img.all_offset.offset_stl2_tend_x);
      expect(f_self_img.all_offset.offset_stl2_tend_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_stl2_tend_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_stl2_tend_x = defalut;
      print(f_self_img.all_offset.offset_stl2_tend_x);
      expect(f_self_img.all_offset.offset_stl2_tend_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_stl2_tend_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_stl2_tend_y;
      print(f_self_img.all_offset.offset_stl2_tend_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_stl2_tend_y = testData1;
      print(f_self_img.all_offset.offset_stl2_tend_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_stl2_tend_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_stl2_tend_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_stl2_tend_y = testData2;
      print(f_self_img.all_offset.offset_stl2_tend_y);
      expect(f_self_img.all_offset.offset_stl2_tend_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_stl2_tend_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_stl2_tend_y = defalut;
      print(f_self_img.all_offset.offset_stl2_tend_y);
      expect(f_self_img.all_offset.offset_stl2_tend_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_stl2_tend_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_stl2_chg_x;
      print(f_self_img.all_offset.offset_stl2_chg_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_stl2_chg_x = testData1;
      print(f_self_img.all_offset.offset_stl2_chg_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_stl2_chg_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_stl2_chg_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_stl2_chg_x = testData2;
      print(f_self_img.all_offset.offset_stl2_chg_x);
      expect(f_self_img.all_offset.offset_stl2_chg_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_stl2_chg_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_stl2_chg_x = defalut;
      print(f_self_img.all_offset.offset_stl2_chg_x);
      expect(f_self_img.all_offset.offset_stl2_chg_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_stl2_chg_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_stl2_chg_y;
      print(f_self_img.all_offset.offset_stl2_chg_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_stl2_chg_y = testData1;
      print(f_self_img.all_offset.offset_stl2_chg_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_stl2_chg_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_stl2_chg_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_stl2_chg_y = testData2;
      print(f_self_img.all_offset.offset_stl2_chg_y);
      expect(f_self_img.all_offset.offset_stl2_chg_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_stl2_chg_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_stl2_chg_y = defalut;
      print(f_self_img.all_offset.offset_stl2_chg_y);
      expect(f_self_img.all_offset.offset_stl2_chg_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_stl2_chg_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_message_x;
      print(f_self_img.all_offset.offset_message_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_message_x = testData1;
      print(f_self_img.all_offset.offset_message_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_message_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_message_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_message_x = testData2;
      print(f_self_img.all_offset.offset_message_x);
      expect(f_self_img.all_offset.offset_message_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_message_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_message_x = defalut;
      print(f_self_img.all_offset.offset_message_x);
      expect(f_self_img.all_offset.offset_message_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_message_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_message_y;
      print(f_self_img.all_offset.offset_message_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_message_y = testData1;
      print(f_self_img.all_offset.offset_message_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_message_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_message_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_message_y = testData2;
      print(f_self_img.all_offset.offset_message_y);
      expect(f_self_img.all_offset.offset_message_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_message_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_message_y = defalut;
      print(f_self_img.all_offset.offset_message_y);
      expect(f_self_img.all_offset.offset_message_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_message_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_btn1_x;
      print(f_self_img.all_offset.offset_btn1_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_btn1_x = testData1;
      print(f_self_img.all_offset.offset_btn1_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_btn1_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_btn1_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_btn1_x = testData2;
      print(f_self_img.all_offset.offset_btn1_x);
      expect(f_self_img.all_offset.offset_btn1_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn1_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_btn1_x = defalut;
      print(f_self_img.all_offset.offset_btn1_x);
      expect(f_self_img.all_offset.offset_btn1_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn1_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_btn1_y;
      print(f_self_img.all_offset.offset_btn1_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_btn1_y = testData1;
      print(f_self_img.all_offset.offset_btn1_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_btn1_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_btn1_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_btn1_y = testData2;
      print(f_self_img.all_offset.offset_btn1_y);
      expect(f_self_img.all_offset.offset_btn1_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn1_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_btn1_y = defalut;
      print(f_self_img.all_offset.offset_btn1_y);
      expect(f_self_img.all_offset.offset_btn1_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn1_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_btn2_x;
      print(f_self_img.all_offset.offset_btn2_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_btn2_x = testData1;
      print(f_self_img.all_offset.offset_btn2_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_btn2_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_btn2_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_btn2_x = testData2;
      print(f_self_img.all_offset.offset_btn2_x);
      expect(f_self_img.all_offset.offset_btn2_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn2_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_btn2_x = defalut;
      print(f_self_img.all_offset.offset_btn2_x);
      expect(f_self_img.all_offset.offset_btn2_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn2_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_btn2_y;
      print(f_self_img.all_offset.offset_btn2_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_btn2_y = testData1;
      print(f_self_img.all_offset.offset_btn2_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_btn2_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_btn2_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_btn2_y = testData2;
      print(f_self_img.all_offset.offset_btn2_y);
      expect(f_self_img.all_offset.offset_btn2_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn2_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_btn2_y = defalut;
      print(f_self_img.all_offset.offset_btn2_y);
      expect(f_self_img.all_offset.offset_btn2_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn2_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_btn3_x;
      print(f_self_img.all_offset.offset_btn3_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_btn3_x = testData1;
      print(f_self_img.all_offset.offset_btn3_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_btn3_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_btn3_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_btn3_x = testData2;
      print(f_self_img.all_offset.offset_btn3_x);
      expect(f_self_img.all_offset.offset_btn3_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn3_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_btn3_x = defalut;
      print(f_self_img.all_offset.offset_btn3_x);
      expect(f_self_img.all_offset.offset_btn3_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn3_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_btn3_y;
      print(f_self_img.all_offset.offset_btn3_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_btn3_y = testData1;
      print(f_self_img.all_offset.offset_btn3_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_btn3_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_btn3_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_btn3_y = testData2;
      print(f_self_img.all_offset.offset_btn3_y);
      expect(f_self_img.all_offset.offset_btn3_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn3_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_btn3_y = defalut;
      print(f_self_img.all_offset.offset_btn3_y);
      expect(f_self_img.all_offset.offset_btn3_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn3_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_btn4_x;
      print(f_self_img.all_offset.offset_btn4_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_btn4_x = testData1;
      print(f_self_img.all_offset.offset_btn4_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_btn4_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_btn4_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_btn4_x = testData2;
      print(f_self_img.all_offset.offset_btn4_x);
      expect(f_self_img.all_offset.offset_btn4_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn4_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_btn4_x = defalut;
      print(f_self_img.all_offset.offset_btn4_x);
      expect(f_self_img.all_offset.offset_btn4_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn4_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_btn4_y;
      print(f_self_img.all_offset.offset_btn4_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_btn4_y = testData1;
      print(f_self_img.all_offset.offset_btn4_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_btn4_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_btn4_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_btn4_y = testData2;
      print(f_self_img.all_offset.offset_btn4_y);
      expect(f_self_img.all_offset.offset_btn4_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn4_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_btn4_y = defalut;
      print(f_self_img.all_offset.offset_btn4_y);
      expect(f_self_img.all_offset.offset_btn4_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_btn4_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_item_anytime_tend_x;
      print(f_self_img.all_offset.offset_item_anytime_tend_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_item_anytime_tend_x = testData1;
      print(f_self_img.all_offset.offset_item_anytime_tend_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_item_anytime_tend_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_item_anytime_tend_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_item_anytime_tend_x = testData2;
      print(f_self_img.all_offset.offset_item_anytime_tend_x);
      expect(f_self_img.all_offset.offset_item_anytime_tend_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_item_anytime_tend_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_item_anytime_tend_x = defalut;
      print(f_self_img.all_offset.offset_item_anytime_tend_x);
      expect(f_self_img.all_offset.offset_item_anytime_tend_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_item_anytime_tend_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_item_anytime_tend_y;
      print(f_self_img.all_offset.offset_item_anytime_tend_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_item_anytime_tend_y = testData1;
      print(f_self_img.all_offset.offset_item_anytime_tend_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_item_anytime_tend_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_item_anytime_tend_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_item_anytime_tend_y = testData2;
      print(f_self_img.all_offset.offset_item_anytime_tend_y);
      expect(f_self_img.all_offset.offset_item_anytime_tend_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_item_anytime_tend_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_item_anytime_tend_y = defalut;
      print(f_self_img.all_offset.offset_item_anytime_tend_y);
      expect(f_self_img.all_offset.offset_item_anytime_tend_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_item_anytime_tend_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_lang_btn_x;
      print(f_self_img.all_offset.offset_lang_btn_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_lang_btn_x = testData1;
      print(f_self_img.all_offset.offset_lang_btn_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_lang_btn_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_lang_btn_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_lang_btn_x = testData2;
      print(f_self_img.all_offset.offset_lang_btn_x);
      expect(f_self_img.all_offset.offset_lang_btn_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_lang_btn_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_lang_btn_x = defalut;
      print(f_self_img.all_offset.offset_lang_btn_x);
      expect(f_self_img.all_offset.offset_lang_btn_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_lang_btn_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_lang_btn_y;
      print(f_self_img.all_offset.offset_lang_btn_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_lang_btn_y = testData1;
      print(f_self_img.all_offset.offset_lang_btn_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_lang_btn_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_lang_btn_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_lang_btn_y = testData2;
      print(f_self_img.all_offset.offset_lang_btn_y);
      expect(f_self_img.all_offset.offset_lang_btn_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_lang_btn_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_lang_btn_y = defalut;
      print(f_self_img.all_offset.offset_lang_btn_y);
      expect(f_self_img.all_offset.offset_lang_btn_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_lang_btn_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_explain_x;
      print(f_self_img.all_offset.offset_explain_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_explain_x = testData1;
      print(f_self_img.all_offset.offset_explain_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_explain_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_explain_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_explain_x = testData2;
      print(f_self_img.all_offset.offset_explain_x);
      expect(f_self_img.all_offset.offset_explain_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_explain_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_explain_x = defalut;
      print(f_self_img.all_offset.offset_explain_x);
      expect(f_self_img.all_offset.offset_explain_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_explain_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_translate_x;
      print(f_self_img.all_offset.offset_translate_x);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_translate_x = testData1;
      print(f_self_img.all_offset.offset_translate_x);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_translate_x == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_translate_x == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_translate_x = testData2;
      print(f_self_img.all_offset.offset_translate_x);
      expect(f_self_img.all_offset.offset_translate_x == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_translate_x == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_translate_x = defalut;
      print(f_self_img.all_offset.offset_translate_x);
      expect(f_self_img.all_offset.offset_translate_x == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_translate_x == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.all_offset.offset_translate_y;
      print(f_self_img.all_offset.offset_translate_y);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.all_offset.offset_translate_y = testData1;
      print(f_self_img.all_offset.offset_translate_y);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.all_offset.offset_translate_y == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.all_offset.offset_translate_y == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.all_offset.offset_translate_y = testData2;
      print(f_self_img.all_offset.offset_translate_y);
      expect(f_self_img.all_offset.offset_translate_y == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_translate_y == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.all_offset.offset_translate_y = defalut;
      print(f_self_img.all_offset.offset_translate_y);
      expect(f_self_img.all_offset.offset_translate_y == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.all_offset.offset_translate_y == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.avi_size.movie_normal_w;
      print(f_self_img.avi_size.movie_normal_w);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.avi_size.movie_normal_w = testData1;
      print(f_self_img.avi_size.movie_normal_w);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.avi_size.movie_normal_w == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.avi_size.movie_normal_w == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.avi_size.movie_normal_w = testData2;
      print(f_self_img.avi_size.movie_normal_w);
      expect(f_self_img.avi_size.movie_normal_w == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.avi_size.movie_normal_w == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.avi_size.movie_normal_w = defalut;
      print(f_self_img.avi_size.movie_normal_w);
      expect(f_self_img.avi_size.movie_normal_w == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.avi_size.movie_normal_w == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.avi_size.movie_normal_h;
      print(f_self_img.avi_size.movie_normal_h);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.avi_size.movie_normal_h = testData1;
      print(f_self_img.avi_size.movie_normal_h);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.avi_size.movie_normal_h == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.avi_size.movie_normal_h == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.avi_size.movie_normal_h = testData2;
      print(f_self_img.avi_size.movie_normal_h);
      expect(f_self_img.avi_size.movie_normal_h == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.avi_size.movie_normal_h == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.avi_size.movie_normal_h = defalut;
      print(f_self_img.avi_size.movie_normal_h);
      expect(f_self_img.avi_size.movie_normal_h == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.avi_size.movie_normal_h == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.avi_size.movie_cashin_w;
      print(f_self_img.avi_size.movie_cashin_w);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.avi_size.movie_cashin_w = testData1;
      print(f_self_img.avi_size.movie_cashin_w);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.avi_size.movie_cashin_w == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.avi_size.movie_cashin_w == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.avi_size.movie_cashin_w = testData2;
      print(f_self_img.avi_size.movie_cashin_w);
      expect(f_self_img.avi_size.movie_cashin_w == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.avi_size.movie_cashin_w == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.avi_size.movie_cashin_w = defalut;
      print(f_self_img.avi_size.movie_cashin_w);
      expect(f_self_img.avi_size.movie_cashin_w == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.avi_size.movie_cashin_w == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.avi_size.movie_cashin_h;
      print(f_self_img.avi_size.movie_cashin_h);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.avi_size.movie_cashin_h = testData1;
      print(f_self_img.avi_size.movie_cashin_h);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.avi_size.movie_cashin_h == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.avi_size.movie_cashin_h == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.avi_size.movie_cashin_h = testData2;
      print(f_self_img.avi_size.movie_cashin_h);
      expect(f_self_img.avi_size.movie_cashin_h == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.avi_size.movie_cashin_h == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.avi_size.movie_cashin_h = defalut;
      print(f_self_img.avi_size.movie_cashin_h);
      expect(f_self_img.avi_size.movie_cashin_h == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.avi_size.movie_cashin_h == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.avi_size.movie_cashinout_w;
      print(f_self_img.avi_size.movie_cashinout_w);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.avi_size.movie_cashinout_w = testData1;
      print(f_self_img.avi_size.movie_cashinout_w);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.avi_size.movie_cashinout_w == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.avi_size.movie_cashinout_w == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.avi_size.movie_cashinout_w = testData2;
      print(f_self_img.avi_size.movie_cashinout_w);
      expect(f_self_img.avi_size.movie_cashinout_w == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.avi_size.movie_cashinout_w == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.avi_size.movie_cashinout_w = defalut;
      print(f_self_img.avi_size.movie_cashinout_w);
      expect(f_self_img.avi_size.movie_cashinout_w == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.avi_size.movie_cashinout_w == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      f_self_img = F_self_imgJsonFile();
      allPropatyCheckInit(f_self_img);

      // ①loadを実行する。
      await f_self_img.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = f_self_img.avi_size.movie_cashinout_h;
      print(f_self_img.avi_size.movie_cashinout_h);

      // ②指定したプロパティにテストデータ1を書き込む。
      f_self_img.avi_size.movie_cashinout_h = testData1;
      print(f_self_img.avi_size.movie_cashinout_h);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(f_self_img.avi_size.movie_cashinout_h == testData1, true);

      // ④saveを実行後、loadを実行する。
      await f_self_img.save();
      await f_self_img.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(f_self_img.avi_size.movie_cashinout_h == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      f_self_img.avi_size.movie_cashinout_h = testData2;
      print(f_self_img.avi_size.movie_cashinout_h);
      expect(f_self_img.avi_size.movie_cashinout_h == testData2, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.avi_size.movie_cashinout_h == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      f_self_img.avi_size.movie_cashinout_h = defalut;
      print(f_self_img.avi_size.movie_cashinout_h);
      expect(f_self_img.avi_size.movie_cashinout_h == defalut, true);
      await f_self_img.save();
      await f_self_img.load();
      expect(f_self_img.avi_size.movie_cashinout_h == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(f_self_img, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

  });
}

void allPropatyCheckInit(F_self_imgJsonFile test)
{
  expect(test.org_ini_name.img_no, "");
  expect(test.png_name.image_start_name, 0);
  expect(test.png_name.image_bese_name, "");
  expect(test.png_name.image_item_name, "");
  expect(test.png_name.image_itembig_name, "");
  expect(test.png_name.image_list3_name, "");
  expect(test.png_name.image_subtotal_name, "");
  expect(test.png_name.image_total_name, "");
  expect(test.png_name.image_totalbig_name, "");
  expect(test.png_name.image_ttl_off_name, "");
  expect(test.png_name.image_ttl_ok_name, "");
  expect(test.png_name.image_ttl_total_name, "");
  expect(test.png_name.image_ttl_unpaid_name, "");
  expect(test.png_name.image_txt_name, "");
  expect(test.png_name.image_itemanytime_name, "");
  expect(test.png_name.image_totalbig_anytime_name, "");
  expect(test.png_name.image_btn_bigcheck_1_name, "");
  expect(test.png_name.image_btn_bigcheck_2_name, "");
  expect(test.png_name.image_btn_bigcheck_down_name, "");
  expect(test.png_name.image_btn_check_1_name, "");
  expect(test.png_name.image_btn_check_2_name, "");
  expect(test.png_name.image_btn_check_down_name, "");
  expect(test.png_name.image_btn_norcpt_1_name, "");
  expect(test.png_name.image_btn_norcpt_2_name, "");
  expect(test.png_name.image_btn_norcpt_down_name, "");
  expect(test.png_name.image_btn_receipt_1_name, "");
  expect(test.png_name.image_btn_receipt_2_name, "");
  expect(test.png_name.image_btn_receipt_down_name, "");
  expect(test.png_name.image_btn_minicheck_1_name, "");
  expect(test.png_name.image_btn_minicheck_2_name, "");
  expect(test.png_name.image_btn_minicheck_down_name, "");
  expect(test.png_name.image_btn_mini_norcpt_1_name, "");
  expect(test.png_name.image_btn_mini_norcpt_2_name, "");
  expect(test.png_name.image_btn_mini_norcpt_down_name, "");
  expect(test.png_name.image_btn_mini_receipt_1_name, "");
  expect(test.png_name.image_btn_mini_receipt_2_name, "");
  expect(test.png_name.image_btn_mini_receipt_down_name, "");
  expect(test.all_offset.offset_zero_x, 0);
  expect(test.all_offset.offset_zero_y, 0);
  expect(test.all_offset.offset_list_item_main_x, 0);
  expect(test.all_offset.offset_list_item_main_y, 0);
  expect(test.all_offset.offset_list_item_tend_x, 0);
  expect(test.all_offset.offset_list_item_tend_y, 0);
  expect(test.all_offset.offset_item_tend_x, 0);
  expect(test.all_offset.offset_item_tend_y, 0);
  expect(test.all_offset.offset_stl1_cashin_x, 0);
  expect(test.all_offset.offset_stl1_cashin_y, 0);
  expect(test.all_offset.offset_stl2_tend_x, 0);
  expect(test.all_offset.offset_stl2_tend_y, 0);
  expect(test.all_offset.offset_stl2_chg_x, 0);
  expect(test.all_offset.offset_stl2_chg_y, 0);
  expect(test.all_offset.offset_message_x, 0);
  expect(test.all_offset.offset_message_y, 0);
  expect(test.all_offset.offset_btn1_x, 0);
  expect(test.all_offset.offset_btn1_y, 0);
  expect(test.all_offset.offset_btn2_x, 0);
  expect(test.all_offset.offset_btn2_y, 0);
  expect(test.all_offset.offset_btn3_x, 0);
  expect(test.all_offset.offset_btn3_y, 0);
  expect(test.all_offset.offset_btn4_x, 0);
  expect(test.all_offset.offset_btn4_y, 0);
  expect(test.all_offset.offset_item_anytime_tend_x, 0);
  expect(test.all_offset.offset_item_anytime_tend_y, 0);
  expect(test.all_offset.offset_lang_btn_x, 0);
  expect(test.all_offset.offset_lang_btn_y, 0);
  expect(test.all_offset.offset_explain_x, 0);
  expect(test.all_offset.offset_translate_x, 0);
  expect(test.all_offset.offset_translate_y, 0);
  expect(test.avi_size.movie_normal_w, 0);
  expect(test.avi_size.movie_normal_h, 0);
  expect(test.avi_size.movie_cashin_w, 0);
  expect(test.avi_size.movie_cashin_h, 0);
  expect(test.avi_size.movie_cashinout_w, 0);
  expect(test.avi_size.movie_cashinout_h, 0);
}

void allPropatyCheck(F_self_imgJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.org_ini_name.img_no, "f_self_img1");
  }
  expect(test.png_name.image_start_name, 1);
  expect(test.png_name.image_bese_name, "base.png");
  expect(test.png_name.image_item_name, "item.png");
  expect(test.png_name.image_itembig_name, "itembig.png");
  expect(test.png_name.image_list3_name, "list3.png");
  expect(test.png_name.image_subtotal_name, "subtotal.png");
  expect(test.png_name.image_total_name, "total.png");
  expect(test.png_name.image_totalbig_name, "totalbig.png");
  expect(test.png_name.image_ttl_off_name, "ttl_off.png");
  expect(test.png_name.image_ttl_ok_name, "ttl_ok.png");
  expect(test.png_name.image_ttl_total_name, "ttl_total.png");
  expect(test.png_name.image_ttl_unpaid_name, "ttl_unpaid.png");
  expect(test.png_name.image_txt_name, "txt.png");
  expect(test.png_name.image_itemanytime_name, "item_anytime.png");
  expect(test.png_name.image_totalbig_anytime_name, "totalbig_anytime.png");
  expect(test.png_name.image_btn_bigcheck_1_name, "btn_bigcheck_1.png");
  expect(test.png_name.image_btn_bigcheck_2_name, "btn_bigcheck_2.png");
  expect(test.png_name.image_btn_bigcheck_down_name, "btn_bigcheck_down.png");
  expect(test.png_name.image_btn_check_1_name, "btn_check_1.png");
  expect(test.png_name.image_btn_check_2_name, "btn_check_2.png");
  expect(test.png_name.image_btn_check_down_name, "btn_check_down.png");
  expect(test.png_name.image_btn_norcpt_1_name, "btn_norcpt_1.png");
  expect(test.png_name.image_btn_norcpt_2_name, "btn_norcpt_1.png");
  expect(test.png_name.image_btn_norcpt_down_name, "btn_norcpt_down.png");
  expect(test.png_name.image_btn_receipt_1_name, "btn_rcpt_1.png");
  expect(test.png_name.image_btn_receipt_2_name, "btn_rcpt_1.png");
  expect(test.png_name.image_btn_receipt_down_name, "btn_rcpt_down.png");
  expect(test.png_name.image_btn_minicheck_1_name, "btn_minicheck_1.png");
  expect(test.png_name.image_btn_minicheck_2_name, "btn_minicheck_2.png");
  expect(test.png_name.image_btn_minicheck_down_name, "btn_minicheck_down.png");
  expect(test.png_name.image_btn_mini_norcpt_1_name, "btn_right_1.png");
  expect(test.png_name.image_btn_mini_norcpt_2_name, "btn_right_1.png");
  expect(test.png_name.image_btn_mini_norcpt_down_name, "btn_right_down.png");
  expect(test.png_name.image_btn_mini_receipt_1_name, "btn_left_1.png");
  expect(test.png_name.image_btn_mini_receipt_2_name, "btn_left_1.png");
  expect(test.png_name.image_btn_mini_receipt_down_name, "btn_left_down.png");
  expect(test.all_offset.offset_zero_x, 0);
  expect(test.all_offset.offset_zero_y, 0);
  expect(test.all_offset.offset_list_item_main_x, 0);
  expect(test.all_offset.offset_list_item_main_y, 150);
  expect(test.all_offset.offset_list_item_tend_x, 0);
  expect(test.all_offset.offset_list_item_tend_y, 370);
  expect(test.all_offset.offset_item_tend_x, 0);
  expect(test.all_offset.offset_item_tend_y, 240);
  expect(test.all_offset.offset_stl1_cashin_x, 0);
  expect(test.all_offset.offset_stl1_cashin_y, 190);
  expect(test.all_offset.offset_stl2_tend_x, 0);
  expect(test.all_offset.offset_stl2_tend_y, 120);
  expect(test.all_offset.offset_stl2_chg_x, 0);
  expect(test.all_offset.offset_stl2_chg_y, 244);
  expect(test.all_offset.offset_message_x, 0);
  expect(test.all_offset.offset_message_y, 390);
  expect(test.all_offset.offset_btn1_x, 508);
  expect(test.all_offset.offset_btn1_y, 0);
  expect(test.all_offset.offset_btn2_x, 508);
  expect(test.all_offset.offset_btn2_y, 245);
  expect(test.all_offset.offset_btn3_x, 508);
  expect(test.all_offset.offset_btn3_y, 236);
  expect(test.all_offset.offset_btn4_x, 640);
  expect(test.all_offset.offset_btn4_y, 236);
  expect(test.all_offset.offset_item_anytime_tend_x, 0);
  expect(test.all_offset.offset_item_anytime_tend_y, 120);
  expect(test.all_offset.offset_lang_btn_x, 0);
  expect(test.all_offset.offset_lang_btn_y, 407);
  expect(test.all_offset.offset_explain_x, 28);
  expect(test.all_offset.offset_translate_x, 0);
  expect(test.all_offset.offset_translate_y, 390);
  expect(test.avi_size.movie_normal_w, 800);
  expect(test.avi_size.movie_normal_h, 390);
  expect(test.avi_size.movie_cashin_w, 800);
  expect(test.avi_size.movie_cashin_h, 200);
  expect(test.avi_size.movie_cashinout_w, 292);
  expect(test.avi_size.movie_cashinout_h, 390);
}

