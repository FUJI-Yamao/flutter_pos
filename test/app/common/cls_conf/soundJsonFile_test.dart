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
import '../../../../lib/app/common/cls_conf/soundJsonFile.dart';

late SoundJsonFile sound;

void main(){
  soundJsonFile_test();
}

void soundJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "sound.json";
  const String section = "sound";
  const String key = "wav_use";
  const defaultData = 1;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('SoundJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await SoundJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await SoundJsonFile().setDefault();
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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await sound.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(sound,true);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        sound.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await sound.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(sound,true);

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
      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①：loadを実行する。
      await sound.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = sound.sound.wav_use;
      sound.sound.wav_use = testData1;
      expect(sound.sound.wav_use == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await sound.load();
      expect(sound.sound.wav_use != testData1, true);
      expect(sound.sound.wav_use == prefixData, true);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = sound.sound.wav_use;
      sound.sound.wav_use = testData1;
      expect(sound.sound.wav_use, testData1);

      // ③saveを実行する。
      await sound.save();

      // ④loadを実行する。
      await sound.load();

      expect(sound.sound.wav_use != prefixData, true);
      expect(sound.sound.wav_use == testData1, true);
      allPropatyCheck(sound,false);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await sound.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await sound.save();

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await sound.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(sound.sound.wav_use, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = sound.sound.wav_use;
      sound.sound.wav_use = testData1;

      // ③ saveを実行する。
      await sound.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(sound.sound.wav_use, testData1);

      // ④ loadを実行する。
      await sound.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(sound.sound.wav_use == testData1, true);
      allPropatyCheck(sound,false);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await sound.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(sound,true);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②任意のプロパティの値を変更する。
      sound.sound.wav_use = testData1;
      expect(sound.sound.wav_use, testData1);

      // ③saveを実行する。
      await sound.save();
      expect(sound.sound.wav_use, testData1);

      // ④loadを実行する。
      await sound.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(sound,true);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await sound.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await sound.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(sound.sound.wav_use == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await sound.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await sound.setValueWithName(section, "test_key", testData1);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②任意のプロパティを変更する。
      sound.sound.wav_use = testData1;

      // ③saveを実行する。
      await sound.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await sound.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②任意のプロパティを変更する。
      sound.sound.wav_use = testData1;

      // ③saveを実行する。
      await sound.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await sound.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②任意のプロパティを変更する。
      sound.sound.wav_use = testData1;

      // ③saveを実行する。
      await sound.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await sound.getValueWithName(section, "test_key");
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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await sound.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      sound.sound.wav_use = testData1;
      expect(sound.sound.wav_use, testData1);

      // ④saveを実行する。
      await sound.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(sound.sound.wav_use, testData1);
      
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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await sound.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + sound.sound.wav_use.toString());
      expect(sound.sound.wav_use == testData1, true);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await sound.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + sound.sound.wav_use.toString());
      expect(sound.sound.wav_use == testData2, true);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await sound.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + sound.sound.wav_use.toString());
      expect(sound.sound.wav_use == testData1, true);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await sound.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + sound.sound.wav_use.toString());
      expect(sound.sound.wav_use == testData2, true);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await sound.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + sound.sound.wav_use.toString());
      expect(sound.sound.wav_use == testData1, true);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await sound.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + sound.sound.wav_use.toString());
      expect(sound.sound.wav_use == testData1, true);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await sound.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + sound.sound.wav_use.toString());
      allPropatyCheck(sound,true);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await sound.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + sound.sound.wav_use.toString());
      allPropatyCheck(sound,true);

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

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.sound.wav_use;
      print(sound.sound.wav_use);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.sound.wav_use = testData1;
      print(sound.sound.wav_use);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.sound.wav_use == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.sound.wav_use == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.sound.wav_use = testData2;
      print(sound.sound.wav_use);
      expect(sound.sound.wav_use == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.sound.wav_use == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.sound.wav_use = defalut;
      print(sound.sound.wav_use);
      expect(sound.sound.wav_use == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.sound.wav_use == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.guidance.left_volume;
      print(sound.guidance.left_volume);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.guidance.left_volume = testData1;
      print(sound.guidance.left_volume);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.guidance.left_volume == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.guidance.left_volume == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.guidance.left_volume = testData2;
      print(sound.guidance.left_volume);
      expect(sound.guidance.left_volume == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.guidance.left_volume == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.guidance.left_volume = defalut;
      print(sound.guidance.left_volume);
      expect(sound.guidance.left_volume == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.guidance.left_volume == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.guidance.right_volume;
      print(sound.guidance.right_volume);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.guidance.right_volume = testData1;
      print(sound.guidance.right_volume);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.guidance.right_volume == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.guidance.right_volume == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.guidance.right_volume = testData2;
      print(sound.guidance.right_volume);
      expect(sound.guidance.right_volume == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.guidance.right_volume == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.guidance.right_volume = defalut;
      print(sound.guidance.right_volume);
      expect(sound.guidance.right_volume == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.guidance.right_volume == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.hdaivoice.voice_volume;
      print(sound.hdaivoice.voice_volume);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.hdaivoice.voice_volume = testData1;
      print(sound.hdaivoice.voice_volume);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.hdaivoice.voice_volume == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.hdaivoice.voice_volume == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.hdaivoice.voice_volume = testData2;
      print(sound.hdaivoice.voice_volume);
      expect(sound.hdaivoice.voice_volume == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.voice_volume == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.hdaivoice.voice_volume = defalut;
      print(sound.hdaivoice.voice_volume);
      expect(sound.hdaivoice.voice_volume == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.voice_volume == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.hdaivoice.voice_speed;
      print(sound.hdaivoice.voice_speed);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.hdaivoice.voice_speed = testData1;
      print(sound.hdaivoice.voice_speed);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.hdaivoice.voice_speed == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.hdaivoice.voice_speed == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.hdaivoice.voice_speed = testData2;
      print(sound.hdaivoice.voice_speed);
      expect(sound.hdaivoice.voice_speed == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.voice_speed == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.hdaivoice.voice_speed = defalut;
      print(sound.hdaivoice.voice_speed);
      expect(sound.hdaivoice.voice_speed == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.voice_speed == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.hdaivoice.effect_volume0;
      print(sound.hdaivoice.effect_volume0);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.hdaivoice.effect_volume0 = testData1;
      print(sound.hdaivoice.effect_volume0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.hdaivoice.effect_volume0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.hdaivoice.effect_volume0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.hdaivoice.effect_volume0 = testData2;
      print(sound.hdaivoice.effect_volume0);
      expect(sound.hdaivoice.effect_volume0 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.hdaivoice.effect_volume0 = defalut;
      print(sound.hdaivoice.effect_volume0);
      expect(sound.hdaivoice.effect_volume0 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.hdaivoice.effect_volume1;
      print(sound.hdaivoice.effect_volume1);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.hdaivoice.effect_volume1 = testData1;
      print(sound.hdaivoice.effect_volume1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.hdaivoice.effect_volume1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.hdaivoice.effect_volume1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.hdaivoice.effect_volume1 = testData2;
      print(sound.hdaivoice.effect_volume1);
      expect(sound.hdaivoice.effect_volume1 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.hdaivoice.effect_volume1 = defalut;
      print(sound.hdaivoice.effect_volume1);
      expect(sound.hdaivoice.effect_volume1 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.hdaivoice.effect_volume2;
      print(sound.hdaivoice.effect_volume2);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.hdaivoice.effect_volume2 = testData1;
      print(sound.hdaivoice.effect_volume2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.hdaivoice.effect_volume2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.hdaivoice.effect_volume2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.hdaivoice.effect_volume2 = testData2;
      print(sound.hdaivoice.effect_volume2);
      expect(sound.hdaivoice.effect_volume2 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.hdaivoice.effect_volume2 = defalut;
      print(sound.hdaivoice.effect_volume2);
      expect(sound.hdaivoice.effect_volume2 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.hdaivoice.effect_volume3;
      print(sound.hdaivoice.effect_volume3);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.hdaivoice.effect_volume3 = testData1;
      print(sound.hdaivoice.effect_volume3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.hdaivoice.effect_volume3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.hdaivoice.effect_volume3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.hdaivoice.effect_volume3 = testData2;
      print(sound.hdaivoice.effect_volume3);
      expect(sound.hdaivoice.effect_volume3 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.hdaivoice.effect_volume3 = defalut;
      print(sound.hdaivoice.effect_volume3);
      expect(sound.hdaivoice.effect_volume3 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.hdaivoice.effect_volume4;
      print(sound.hdaivoice.effect_volume4);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.hdaivoice.effect_volume4 = testData1;
      print(sound.hdaivoice.effect_volume4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.hdaivoice.effect_volume4 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.hdaivoice.effect_volume4 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.hdaivoice.effect_volume4 = testData2;
      print(sound.hdaivoice.effect_volume4);
      expect(sound.hdaivoice.effect_volume4 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume4 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.hdaivoice.effect_volume4 = defalut;
      print(sound.hdaivoice.effect_volume4);
      expect(sound.hdaivoice.effect_volume4 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.hdaivoice.effect_volume5;
      print(sound.hdaivoice.effect_volume5);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.hdaivoice.effect_volume5 = testData1;
      print(sound.hdaivoice.effect_volume5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.hdaivoice.effect_volume5 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.hdaivoice.effect_volume5 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.hdaivoice.effect_volume5 = testData2;
      print(sound.hdaivoice.effect_volume5);
      expect(sound.hdaivoice.effect_volume5 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume5 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.hdaivoice.effect_volume5 = defalut;
      print(sound.hdaivoice.effect_volume5);
      expect(sound.hdaivoice.effect_volume5 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.hdaivoice.effect_volume6;
      print(sound.hdaivoice.effect_volume6);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.hdaivoice.effect_volume6 = testData1;
      print(sound.hdaivoice.effect_volume6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.hdaivoice.effect_volume6 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.hdaivoice.effect_volume6 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.hdaivoice.effect_volume6 = testData2;
      print(sound.hdaivoice.effect_volume6);
      expect(sound.hdaivoice.effect_volume6 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume6 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.hdaivoice.effect_volume6 = defalut;
      print(sound.hdaivoice.effect_volume6);
      expect(sound.hdaivoice.effect_volume6 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.hdaivoice.effect_volume7;
      print(sound.hdaivoice.effect_volume7);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.hdaivoice.effect_volume7 = testData1;
      print(sound.hdaivoice.effect_volume7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.hdaivoice.effect_volume7 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.hdaivoice.effect_volume7 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.hdaivoice.effect_volume7 = testData2;
      print(sound.hdaivoice.effect_volume7);
      expect(sound.hdaivoice.effect_volume7 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume7 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.hdaivoice.effect_volume7 = defalut;
      print(sound.hdaivoice.effect_volume7);
      expect(sound.hdaivoice.effect_volume7 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.hdaivoice.effect_volume8;
      print(sound.hdaivoice.effect_volume8);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.hdaivoice.effect_volume8 = testData1;
      print(sound.hdaivoice.effect_volume8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.hdaivoice.effect_volume8 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.hdaivoice.effect_volume8 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.hdaivoice.effect_volume8 = testData2;
      print(sound.hdaivoice.effect_volume8);
      expect(sound.hdaivoice.effect_volume8 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume8 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.hdaivoice.effect_volume8 = defalut;
      print(sound.hdaivoice.effect_volume8);
      expect(sound.hdaivoice.effect_volume8 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.hdaivoice.effect_volume9;
      print(sound.hdaivoice.effect_volume9);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.hdaivoice.effect_volume9 = testData1;
      print(sound.hdaivoice.effect_volume9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.hdaivoice.effect_volume9 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.hdaivoice.effect_volume9 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.hdaivoice.effect_volume9 = testData2;
      print(sound.hdaivoice.effect_volume9);
      expect(sound.hdaivoice.effect_volume9 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume9 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.hdaivoice.effect_volume9 = defalut;
      print(sound.hdaivoice.effect_volume9);
      expect(sound.hdaivoice.effect_volume9 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.hdaivoice.effect_volume9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.arsttsvoice.voice_volume;
      print(sound.arsttsvoice.voice_volume);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.arsttsvoice.voice_volume = testData1;
      print(sound.arsttsvoice.voice_volume);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.arsttsvoice.voice_volume == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.arsttsvoice.voice_volume == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.arsttsvoice.voice_volume = testData2;
      print(sound.arsttsvoice.voice_volume);
      expect(sound.arsttsvoice.voice_volume == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.arsttsvoice.voice_volume == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.arsttsvoice.voice_volume = defalut;
      print(sound.arsttsvoice.voice_volume);
      expect(sound.arsttsvoice.voice_volume == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.arsttsvoice.voice_volume == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.arsttsvoice.voice_loudness;
      print(sound.arsttsvoice.voice_loudness);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.arsttsvoice.voice_loudness = testData1;
      print(sound.arsttsvoice.voice_loudness);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.arsttsvoice.voice_loudness == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.arsttsvoice.voice_loudness == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.arsttsvoice.voice_loudness = testData2;
      print(sound.arsttsvoice.voice_loudness);
      expect(sound.arsttsvoice.voice_loudness == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.arsttsvoice.voice_loudness == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.arsttsvoice.voice_loudness = defalut;
      print(sound.arsttsvoice.voice_loudness);
      expect(sound.arsttsvoice.voice_loudness == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.arsttsvoice.voice_loudness == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.arsttsvoice.voice_speed;
      print(sound.arsttsvoice.voice_speed);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.arsttsvoice.voice_speed = testData1;
      print(sound.arsttsvoice.voice_speed);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.arsttsvoice.voice_speed == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.arsttsvoice.voice_speed == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.arsttsvoice.voice_speed = testData2;
      print(sound.arsttsvoice.voice_speed);
      expect(sound.arsttsvoice.voice_speed == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.arsttsvoice.voice_speed == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.arsttsvoice.voice_speed = defalut;
      print(sound.arsttsvoice.voice_speed);
      expect(sound.arsttsvoice.voice_speed == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.arsttsvoice.voice_speed == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.arsttsvoice.voice_leave;
      print(sound.arsttsvoice.voice_leave);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.arsttsvoice.voice_leave = testData1;
      print(sound.arsttsvoice.voice_leave);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.arsttsvoice.voice_leave == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.arsttsvoice.voice_leave == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.arsttsvoice.voice_leave = testData2;
      print(sound.arsttsvoice.voice_leave);
      expect(sound.arsttsvoice.voice_leave == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.arsttsvoice.voice_leave == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.arsttsvoice.voice_leave = defalut;
      print(sound.arsttsvoice.voice_leave);
      expect(sound.arsttsvoice.voice_leave == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.arsttsvoice.voice_leave == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.G1R;
      print(sound.volume.G1R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.G1R = testData1;
      print(sound.volume.G1R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.G1R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.G1R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.G1R = testData2;
      print(sound.volume.G1R);
      expect(sound.volume.G1R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.G1R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.G1R = defalut;
      print(sound.volume.G1R);
      expect(sound.volume.G1R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.G1R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.G1L;
      print(sound.volume.G1L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.G1L = testData1;
      print(sound.volume.G1L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.G1L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.G1L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.G1L = testData2;
      print(sound.volume.G1L);
      expect(sound.volume.G1L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.G1L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.G1L = defalut;
      print(sound.volume.G1L);
      expect(sound.volume.G1L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.G1L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.G2;
      print(sound.volume.G2);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.G2 = testData1;
      print(sound.volume.G2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.G2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.G2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.G2 = testData2;
      print(sound.volume.G2);
      expect(sound.volume.G2 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.G2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.G2 = defalut;
      print(sound.volume.G2);
      expect(sound.volume.G2 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.G2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.VIA_DXS1;
      print(sound.volume.VIA_DXS1);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.VIA_DXS1 = testData1;
      print(sound.volume.VIA_DXS1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.VIA_DXS1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.VIA_DXS1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.VIA_DXS1 = testData2;
      print(sound.volume.VIA_DXS1);
      expect(sound.volume.VIA_DXS1 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.VIA_DXS1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.VIA_DXS1 = defalut;
      print(sound.volume.VIA_DXS1);
      expect(sound.volume.VIA_DXS1 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.VIA_DXS1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.VIA_DXS2;
      print(sound.volume.VIA_DXS2);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.VIA_DXS2 = testData1;
      print(sound.volume.VIA_DXS2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.VIA_DXS2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.VIA_DXS2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.VIA_DXS2 = testData2;
      print(sound.volume.VIA_DXS2);
      expect(sound.volume.VIA_DXS2 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.VIA_DXS2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.VIA_DXS2 = defalut;
      print(sound.volume.VIA_DXS2);
      expect(sound.volume.VIA_DXS2 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.VIA_DXS2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.VIA_DXS3;
      print(sound.volume.VIA_DXS3);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.VIA_DXS3 = testData1;
      print(sound.volume.VIA_DXS3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.VIA_DXS3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.VIA_DXS3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.VIA_DXS3 = testData2;
      print(sound.volume.VIA_DXS3);
      expect(sound.volume.VIA_DXS3 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.VIA_DXS3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.VIA_DXS3 = defalut;
      print(sound.volume.VIA_DXS3);
      expect(sound.volume.VIA_DXS3 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.VIA_DXS3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.VIA_DXS4;
      print(sound.volume.VIA_DXS4);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.VIA_DXS4 = testData1;
      print(sound.volume.VIA_DXS4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.VIA_DXS4 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.VIA_DXS4 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.VIA_DXS4 = testData2;
      print(sound.volume.VIA_DXS4);
      expect(sound.volume.VIA_DXS4 == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.VIA_DXS4 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.VIA_DXS4 = defalut;
      print(sound.volume.VIA_DXS4);
      expect(sound.volume.VIA_DXS4 == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.VIA_DXS4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.ERR_R;
      print(sound.volume.ERR_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.ERR_R = testData1;
      print(sound.volume.ERR_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.ERR_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.ERR_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.ERR_R = testData2;
      print(sound.volume.ERR_R);
      expect(sound.volume.ERR_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.ERR_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.ERR_R = defalut;
      print(sound.volume.ERR_R);
      expect(sound.volume.ERR_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.ERR_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.ERR_L;
      print(sound.volume.ERR_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.ERR_L = testData1;
      print(sound.volume.ERR_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.ERR_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.ERR_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.ERR_L = testData2;
      print(sound.volume.ERR_L);
      expect(sound.volume.ERR_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.ERR_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.ERR_L = defalut;
      print(sound.volume.ERR_L);
      expect(sound.volume.ERR_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.ERR_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.WARN_R;
      print(sound.volume.WARN_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.WARN_R = testData1;
      print(sound.volume.WARN_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.WARN_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.WARN_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.WARN_R = testData2;
      print(sound.volume.WARN_R);
      expect(sound.volume.WARN_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.WARN_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.WARN_R = defalut;
      print(sound.volume.WARN_R);
      expect(sound.volume.WARN_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.WARN_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.WARN_L;
      print(sound.volume.WARN_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.WARN_L = testData1;
      print(sound.volume.WARN_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.WARN_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.WARN_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.WARN_L = testData2;
      print(sound.volume.WARN_L);
      expect(sound.volume.WARN_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.WARN_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.WARN_L = defalut;
      print(sound.volume.WARN_L);
      expect(sound.volume.WARN_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.WARN_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.FANFARE1_R;
      print(sound.volume.FANFARE1_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.FANFARE1_R = testData1;
      print(sound.volume.FANFARE1_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.FANFARE1_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.FANFARE1_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.FANFARE1_R = testData2;
      print(sound.volume.FANFARE1_R);
      expect(sound.volume.FANFARE1_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.FANFARE1_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.FANFARE1_R = defalut;
      print(sound.volume.FANFARE1_R);
      expect(sound.volume.FANFARE1_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.FANFARE1_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.FANFARE1_L;
      print(sound.volume.FANFARE1_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.FANFARE1_L = testData1;
      print(sound.volume.FANFARE1_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.FANFARE1_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.FANFARE1_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.FANFARE1_L = testData2;
      print(sound.volume.FANFARE1_L);
      expect(sound.volume.FANFARE1_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.FANFARE1_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.FANFARE1_L = defalut;
      print(sound.volume.FANFARE1_L);
      expect(sound.volume.FANFARE1_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.FANFARE1_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.FANFARE2_R;
      print(sound.volume.FANFARE2_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.FANFARE2_R = testData1;
      print(sound.volume.FANFARE2_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.FANFARE2_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.FANFARE2_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.FANFARE2_R = testData2;
      print(sound.volume.FANFARE2_R);
      expect(sound.volume.FANFARE2_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.FANFARE2_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.FANFARE2_R = defalut;
      print(sound.volume.FANFARE2_R);
      expect(sound.volume.FANFARE2_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.FANFARE2_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.FANFARE2_L;
      print(sound.volume.FANFARE2_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.FANFARE2_L = testData1;
      print(sound.volume.FANFARE2_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.FANFARE2_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.FANFARE2_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.FANFARE2_L = testData2;
      print(sound.volume.FANFARE2_L);
      expect(sound.volume.FANFARE2_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.FANFARE2_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.FANFARE2_L = defalut;
      print(sound.volume.FANFARE2_L);
      expect(sound.volume.FANFARE2_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.FANFARE2_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.FANFARE3_R;
      print(sound.volume.FANFARE3_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.FANFARE3_R = testData1;
      print(sound.volume.FANFARE3_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.FANFARE3_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.FANFARE3_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.FANFARE3_R = testData2;
      print(sound.volume.FANFARE3_R);
      expect(sound.volume.FANFARE3_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.FANFARE3_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.FANFARE3_R = defalut;
      print(sound.volume.FANFARE3_R);
      expect(sound.volume.FANFARE3_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.FANFARE3_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.FANFARE3_L;
      print(sound.volume.FANFARE3_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.FANFARE3_L = testData1;
      print(sound.volume.FANFARE3_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.FANFARE3_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.FANFARE3_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.FANFARE3_L = testData2;
      print(sound.volume.FANFARE3_L);
      expect(sound.volume.FANFARE3_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.FANFARE3_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.FANFARE3_L = defalut;
      print(sound.volume.FANFARE3_L);
      expect(sound.volume.FANFARE3_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.FANFARE3_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.BIRTH_R;
      print(sound.volume.BIRTH_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.BIRTH_R = testData1;
      print(sound.volume.BIRTH_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.BIRTH_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.BIRTH_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.BIRTH_R = testData2;
      print(sound.volume.BIRTH_R);
      expect(sound.volume.BIRTH_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.BIRTH_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.BIRTH_R = defalut;
      print(sound.volume.BIRTH_R);
      expect(sound.volume.BIRTH_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.BIRTH_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.BIRTH_L;
      print(sound.volume.BIRTH_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.BIRTH_L = testData1;
      print(sound.volume.BIRTH_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.BIRTH_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.BIRTH_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.BIRTH_L = testData2;
      print(sound.volume.BIRTH_L);
      expect(sound.volume.BIRTH_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.BIRTH_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.BIRTH_L = defalut;
      print(sound.volume.BIRTH_L);
      expect(sound.volume.BIRTH_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.BIRTH_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.POPUP_R;
      print(sound.volume.POPUP_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.POPUP_R = testData1;
      print(sound.volume.POPUP_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.POPUP_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.POPUP_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.POPUP_R = testData2;
      print(sound.volume.POPUP_R);
      expect(sound.volume.POPUP_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.POPUP_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.POPUP_R = defalut;
      print(sound.volume.POPUP_R);
      expect(sound.volume.POPUP_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.POPUP_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.POPUP_L;
      print(sound.volume.POPUP_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.POPUP_L = testData1;
      print(sound.volume.POPUP_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.POPUP_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.POPUP_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.POPUP_L = testData2;
      print(sound.volume.POPUP_L);
      expect(sound.volume.POPUP_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.POPUP_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.POPUP_L = defalut;
      print(sound.volume.POPUP_L);
      expect(sound.volume.POPUP_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.POPUP_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.VERIFONE_R;
      print(sound.volume.VERIFONE_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.VERIFONE_R = testData1;
      print(sound.volume.VERIFONE_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.VERIFONE_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.VERIFONE_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.VERIFONE_R = testData2;
      print(sound.volume.VERIFONE_R);
      expect(sound.volume.VERIFONE_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.VERIFONE_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.VERIFONE_R = defalut;
      print(sound.volume.VERIFONE_R);
      expect(sound.volume.VERIFONE_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.VERIFONE_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.volume.VERIFONE_L;
      print(sound.volume.VERIFONE_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.volume.VERIFONE_L = testData1;
      print(sound.volume.VERIFONE_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.volume.VERIFONE_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.volume.VERIFONE_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.volume.VERIFONE_L = testData2;
      print(sound.volume.VERIFONE_L);
      expect(sound.volume.VERIFONE_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.VERIFONE_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.volume.VERIFONE_L = defalut;
      print(sound.volume.VERIFONE_L);
      expect(sound.volume.VERIFONE_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.volume.VERIFONE_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.designated.D_Left;
      print(sound.designated.D_Left);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.designated.D_Left = testData1;
      print(sound.designated.D_Left);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.designated.D_Left == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.designated.D_Left == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.designated.D_Left = testData2;
      print(sound.designated.D_Left);
      expect(sound.designated.D_Left == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.designated.D_Left == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.designated.D_Left = defalut;
      print(sound.designated.D_Left);
      expect(sound.designated.D_Left == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.designated.D_Left == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.designated.D_Right;
      print(sound.designated.D_Right);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.designated.D_Right = testData1;
      print(sound.designated.D_Right);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.designated.D_Right == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.designated.D_Right == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.designated.D_Right = testData2;
      print(sound.designated.D_Right);
      expect(sound.designated.D_Right == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.designated.D_Right == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.designated.D_Right = defalut;
      print(sound.designated.D_Right);
      expect(sound.designated.D_Right == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.designated.D_Right == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.CLICK_NUM_R;
      print(sound.pitch.CLICK_NUM_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.CLICK_NUM_R = testData1;
      print(sound.pitch.CLICK_NUM_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.CLICK_NUM_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.CLICK_NUM_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.CLICK_NUM_R = testData2;
      print(sound.pitch.CLICK_NUM_R);
      expect(sound.pitch.CLICK_NUM_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.CLICK_NUM_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.CLICK_NUM_R = defalut;
      print(sound.pitch.CLICK_NUM_R);
      expect(sound.pitch.CLICK_NUM_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.CLICK_NUM_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.CLICK_NUM_L;
      print(sound.pitch.CLICK_NUM_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.CLICK_NUM_L = testData1;
      print(sound.pitch.CLICK_NUM_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.CLICK_NUM_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.CLICK_NUM_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.CLICK_NUM_L = testData2;
      print(sound.pitch.CLICK_NUM_L);
      expect(sound.pitch.CLICK_NUM_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.CLICK_NUM_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.CLICK_NUM_L = defalut;
      print(sound.pitch.CLICK_NUM_L);
      expect(sound.pitch.CLICK_NUM_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.CLICK_NUM_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.ERR_NUM_R;
      print(sound.pitch.ERR_NUM_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.ERR_NUM_R = testData1;
      print(sound.pitch.ERR_NUM_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.ERR_NUM_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.ERR_NUM_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.ERR_NUM_R = testData2;
      print(sound.pitch.ERR_NUM_R);
      expect(sound.pitch.ERR_NUM_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.ERR_NUM_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.ERR_NUM_R = defalut;
      print(sound.pitch.ERR_NUM_R);
      expect(sound.pitch.ERR_NUM_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.ERR_NUM_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.ERR_NUM_L;
      print(sound.pitch.ERR_NUM_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.ERR_NUM_L = testData1;
      print(sound.pitch.ERR_NUM_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.ERR_NUM_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.ERR_NUM_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.ERR_NUM_L = testData2;
      print(sound.pitch.ERR_NUM_L);
      expect(sound.pitch.ERR_NUM_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.ERR_NUM_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.ERR_NUM_L = defalut;
      print(sound.pitch.ERR_NUM_L);
      expect(sound.pitch.ERR_NUM_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.ERR_NUM_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.FANFARE1_NUM_R;
      print(sound.pitch.FANFARE1_NUM_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.FANFARE1_NUM_R = testData1;
      print(sound.pitch.FANFARE1_NUM_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.FANFARE1_NUM_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.FANFARE1_NUM_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.FANFARE1_NUM_R = testData2;
      print(sound.pitch.FANFARE1_NUM_R);
      expect(sound.pitch.FANFARE1_NUM_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.FANFARE1_NUM_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.FANFARE1_NUM_R = defalut;
      print(sound.pitch.FANFARE1_NUM_R);
      expect(sound.pitch.FANFARE1_NUM_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.FANFARE1_NUM_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.FANFARE1_NUM_L;
      print(sound.pitch.FANFARE1_NUM_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.FANFARE1_NUM_L = testData1;
      print(sound.pitch.FANFARE1_NUM_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.FANFARE1_NUM_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.FANFARE1_NUM_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.FANFARE1_NUM_L = testData2;
      print(sound.pitch.FANFARE1_NUM_L);
      expect(sound.pitch.FANFARE1_NUM_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.FANFARE1_NUM_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.FANFARE1_NUM_L = defalut;
      print(sound.pitch.FANFARE1_NUM_L);
      expect(sound.pitch.FANFARE1_NUM_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.FANFARE1_NUM_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.FANFARE2_NUM_R;
      print(sound.pitch.FANFARE2_NUM_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.FANFARE2_NUM_R = testData1;
      print(sound.pitch.FANFARE2_NUM_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.FANFARE2_NUM_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.FANFARE2_NUM_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.FANFARE2_NUM_R = testData2;
      print(sound.pitch.FANFARE2_NUM_R);
      expect(sound.pitch.FANFARE2_NUM_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.FANFARE2_NUM_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.FANFARE2_NUM_R = defalut;
      print(sound.pitch.FANFARE2_NUM_R);
      expect(sound.pitch.FANFARE2_NUM_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.FANFARE2_NUM_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.FANFARE2_NUM_L;
      print(sound.pitch.FANFARE2_NUM_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.FANFARE2_NUM_L = testData1;
      print(sound.pitch.FANFARE2_NUM_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.FANFARE2_NUM_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.FANFARE2_NUM_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.FANFARE2_NUM_L = testData2;
      print(sound.pitch.FANFARE2_NUM_L);
      expect(sound.pitch.FANFARE2_NUM_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.FANFARE2_NUM_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.FANFARE2_NUM_L = defalut;
      print(sound.pitch.FANFARE2_NUM_L);
      expect(sound.pitch.FANFARE2_NUM_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.FANFARE2_NUM_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.FANFARE3_NUM_R;
      print(sound.pitch.FANFARE3_NUM_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.FANFARE3_NUM_R = testData1;
      print(sound.pitch.FANFARE3_NUM_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.FANFARE3_NUM_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.FANFARE3_NUM_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.FANFARE3_NUM_R = testData2;
      print(sound.pitch.FANFARE3_NUM_R);
      expect(sound.pitch.FANFARE3_NUM_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.FANFARE3_NUM_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.FANFARE3_NUM_R = defalut;
      print(sound.pitch.FANFARE3_NUM_R);
      expect(sound.pitch.FANFARE3_NUM_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.FANFARE3_NUM_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.FANFARE3_NUM_L;
      print(sound.pitch.FANFARE3_NUM_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.FANFARE3_NUM_L = testData1;
      print(sound.pitch.FANFARE3_NUM_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.FANFARE3_NUM_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.FANFARE3_NUM_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.FANFARE3_NUM_L = testData2;
      print(sound.pitch.FANFARE3_NUM_L);
      expect(sound.pitch.FANFARE3_NUM_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.FANFARE3_NUM_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.FANFARE3_NUM_L = defalut;
      print(sound.pitch.FANFARE3_NUM_L);
      expect(sound.pitch.FANFARE3_NUM_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.FANFARE3_NUM_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.BIRTH_NUM_R;
      print(sound.pitch.BIRTH_NUM_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.BIRTH_NUM_R = testData1;
      print(sound.pitch.BIRTH_NUM_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.BIRTH_NUM_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.BIRTH_NUM_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.BIRTH_NUM_R = testData2;
      print(sound.pitch.BIRTH_NUM_R);
      expect(sound.pitch.BIRTH_NUM_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.BIRTH_NUM_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.BIRTH_NUM_R = defalut;
      print(sound.pitch.BIRTH_NUM_R);
      expect(sound.pitch.BIRTH_NUM_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.BIRTH_NUM_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.BIRTH_NUM_L;
      print(sound.pitch.BIRTH_NUM_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.BIRTH_NUM_L = testData1;
      print(sound.pitch.BIRTH_NUM_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.BIRTH_NUM_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.BIRTH_NUM_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.BIRTH_NUM_L = testData2;
      print(sound.pitch.BIRTH_NUM_L);
      expect(sound.pitch.BIRTH_NUM_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.BIRTH_NUM_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.BIRTH_NUM_L = defalut;
      print(sound.pitch.BIRTH_NUM_L);
      expect(sound.pitch.BIRTH_NUM_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.BIRTH_NUM_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.WARNING_NUM_R;
      print(sound.pitch.WARNING_NUM_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.WARNING_NUM_R = testData1;
      print(sound.pitch.WARNING_NUM_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.WARNING_NUM_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.WARNING_NUM_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.WARNING_NUM_R = testData2;
      print(sound.pitch.WARNING_NUM_R);
      expect(sound.pitch.WARNING_NUM_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.WARNING_NUM_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.WARNING_NUM_R = defalut;
      print(sound.pitch.WARNING_NUM_R);
      expect(sound.pitch.WARNING_NUM_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.WARNING_NUM_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.WARNING_NUM_L;
      print(sound.pitch.WARNING_NUM_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.WARNING_NUM_L = testData1;
      print(sound.pitch.WARNING_NUM_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.WARNING_NUM_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.WARNING_NUM_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.WARNING_NUM_L = testData2;
      print(sound.pitch.WARNING_NUM_L);
      expect(sound.pitch.WARNING_NUM_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.WARNING_NUM_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.WARNING_NUM_L = defalut;
      print(sound.pitch.WARNING_NUM_L);
      expect(sound.pitch.WARNING_NUM_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.WARNING_NUM_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.POPUP_NUM_R;
      print(sound.pitch.POPUP_NUM_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.POPUP_NUM_R = testData1;
      print(sound.pitch.POPUP_NUM_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.POPUP_NUM_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.POPUP_NUM_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.POPUP_NUM_R = testData2;
      print(sound.pitch.POPUP_NUM_R);
      expect(sound.pitch.POPUP_NUM_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.POPUP_NUM_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.POPUP_NUM_R = defalut;
      print(sound.pitch.POPUP_NUM_R);
      expect(sound.pitch.POPUP_NUM_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.POPUP_NUM_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.POPUP_NUM_L;
      print(sound.pitch.POPUP_NUM_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.POPUP_NUM_L = testData1;
      print(sound.pitch.POPUP_NUM_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.POPUP_NUM_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.POPUP_NUM_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.POPUP_NUM_L = testData2;
      print(sound.pitch.POPUP_NUM_L);
      expect(sound.pitch.POPUP_NUM_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.POPUP_NUM_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.POPUP_NUM_L = defalut;
      print(sound.pitch.POPUP_NUM_L);
      expect(sound.pitch.POPUP_NUM_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.POPUP_NUM_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.VERIFONE_NUM_R;
      print(sound.pitch.VERIFONE_NUM_R);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.VERIFONE_NUM_R = testData1;
      print(sound.pitch.VERIFONE_NUM_R);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.VERIFONE_NUM_R == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.VERIFONE_NUM_R == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.VERIFONE_NUM_R = testData2;
      print(sound.pitch.VERIFONE_NUM_R);
      expect(sound.pitch.VERIFONE_NUM_R == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.VERIFONE_NUM_R == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.VERIFONE_NUM_R = defalut;
      print(sound.pitch.VERIFONE_NUM_R);
      expect(sound.pitch.VERIFONE_NUM_R == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.VERIFONE_NUM_R == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      sound = SoundJsonFile();
      allPropatyCheckInit(sound);

      // ①loadを実行する。
      await sound.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = sound.pitch.VERIFONE_NUM_L;
      print(sound.pitch.VERIFONE_NUM_L);

      // ②指定したプロパティにテストデータ1を書き込む。
      sound.pitch.VERIFONE_NUM_L = testData1;
      print(sound.pitch.VERIFONE_NUM_L);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(sound.pitch.VERIFONE_NUM_L == testData1, true);

      // ④saveを実行後、loadを実行する。
      await sound.save();
      await sound.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(sound.pitch.VERIFONE_NUM_L == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      sound.pitch.VERIFONE_NUM_L = testData2;
      print(sound.pitch.VERIFONE_NUM_L);
      expect(sound.pitch.VERIFONE_NUM_L == testData2, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.VERIFONE_NUM_L == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      sound.pitch.VERIFONE_NUM_L = defalut;
      print(sound.pitch.VERIFONE_NUM_L);
      expect(sound.pitch.VERIFONE_NUM_L == defalut, true);
      await sound.save();
      await sound.load();
      expect(sound.pitch.VERIFONE_NUM_L == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(sound, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

  });
}

void allPropatyCheckInit(SoundJsonFile test)
{
  expect(test.sound.wav_use, 0);
  expect(test.guidance.left_volume, 0);
  expect(test.guidance.right_volume, 0);
  expect(test.hdaivoice.voice_volume, 0);
  expect(test.hdaivoice.voice_speed, 0);
  expect(test.hdaivoice.effect_volume0, 0);
  expect(test.hdaivoice.effect_volume1, 0);
  expect(test.hdaivoice.effect_volume2, 0);
  expect(test.hdaivoice.effect_volume3, 0);
  expect(test.hdaivoice.effect_volume4, 0);
  expect(test.hdaivoice.effect_volume5, 0);
  expect(test.hdaivoice.effect_volume6, 0);
  expect(test.hdaivoice.effect_volume7, 0);
  expect(test.hdaivoice.effect_volume8, 0);
  expect(test.hdaivoice.effect_volume9, 0);
  expect(test.arsttsvoice.voice_volume, 0);
  expect(test.arsttsvoice.voice_loudness, 0);
  expect(test.arsttsvoice.voice_speed, 0);
  expect(test.arsttsvoice.voice_leave, 0);
  expect(test.volume.G1R, 0);
  expect(test.volume.G1L, 0);
  expect(test.volume.G2, 0);
  expect(test.volume.VIA_DXS1, 0);
  expect(test.volume.VIA_DXS2, 0);
  expect(test.volume.VIA_DXS3, 0);
  expect(test.volume.VIA_DXS4, 0);
  expect(test.volume.ERR_R, 0);
  expect(test.volume.ERR_L, 0);
  expect(test.volume.WARN_R, 0);
  expect(test.volume.WARN_L, 0);
  expect(test.volume.FANFARE1_R, 0);
  expect(test.volume.FANFARE1_L, 0);
  expect(test.volume.FANFARE2_R, 0);
  expect(test.volume.FANFARE2_L, 0);
  expect(test.volume.FANFARE3_R, 0);
  expect(test.volume.FANFARE3_L, 0);
  expect(test.volume.BIRTH_R, 0);
  expect(test.volume.BIRTH_L, 0);
  expect(test.volume.POPUP_R, 0);
  expect(test.volume.POPUP_L, 0);
  expect(test.volume.VERIFONE_R, 0);
  expect(test.volume.VERIFONE_L, 0);
  expect(test.designated.D_Left, 0);
  expect(test.designated.D_Right, 0);
  expect(test.pitch.CLICK_NUM_R, 0);
  expect(test.pitch.CLICK_NUM_L, 0);
  expect(test.pitch.ERR_NUM_R, 0);
  expect(test.pitch.ERR_NUM_L, 0);
  expect(test.pitch.FANFARE1_NUM_R, 0);
  expect(test.pitch.FANFARE1_NUM_L, 0);
  expect(test.pitch.FANFARE2_NUM_R, 0);
  expect(test.pitch.FANFARE2_NUM_L, 0);
  expect(test.pitch.FANFARE3_NUM_R, 0);
  expect(test.pitch.FANFARE3_NUM_L, 0);
  expect(test.pitch.BIRTH_NUM_R, 0);
  expect(test.pitch.BIRTH_NUM_L, 0);
  expect(test.pitch.WARNING_NUM_R, 0);
  expect(test.pitch.WARNING_NUM_L, 0);
  expect(test.pitch.POPUP_NUM_R, 0);
  expect(test.pitch.POPUP_NUM_L, 0);
  expect(test.pitch.VERIFONE_NUM_R, 0);
  expect(test.pitch.VERIFONE_NUM_L, 0);
}

void allPropatyCheck(SoundJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.sound.wav_use, 1);
  }
  expect(test.guidance.left_volume, 100);
  expect(test.guidance.right_volume, 100);
  expect(test.hdaivoice.voice_volume, 100);
  expect(test.hdaivoice.voice_speed, 130);
  expect(test.hdaivoice.effect_volume0, 100);
  expect(test.hdaivoice.effect_volume1, 100);
  expect(test.hdaivoice.effect_volume2, 100);
  expect(test.hdaivoice.effect_volume3, 100);
  expect(test.hdaivoice.effect_volume4, 100);
  expect(test.hdaivoice.effect_volume5, 100);
  expect(test.hdaivoice.effect_volume6, 100);
  expect(test.hdaivoice.effect_volume7, 100);
  expect(test.hdaivoice.effect_volume8, 100);
  expect(test.hdaivoice.effect_volume9, 100);
  expect(test.arsttsvoice.voice_volume, 119);
  expect(test.arsttsvoice.voice_loudness, 1);
  expect(test.arsttsvoice.voice_speed, 1);
  expect(test.arsttsvoice.voice_leave, 500);
  expect(test.volume.G1R, 10);
  expect(test.volume.G1L, 10);
  expect(test.volume.G2, 10);
  expect(test.volume.VIA_DXS1, 100);
  expect(test.volume.VIA_DXS2, 100);
  expect(test.volume.VIA_DXS3, 100);
  expect(test.volume.VIA_DXS4, 100);
  expect(test.volume.ERR_R, 10);
  expect(test.volume.ERR_L, 10);
  expect(test.volume.WARN_R, 10);
  expect(test.volume.WARN_L, 10);
  expect(test.volume.FANFARE1_R, 10);
  expect(test.volume.FANFARE1_L, 10);
  expect(test.volume.FANFARE2_R, 10);
  expect(test.volume.FANFARE2_L, 10);
  expect(test.volume.FANFARE3_R, 10);
  expect(test.volume.FANFARE3_L, 10);
  expect(test.volume.BIRTH_R, 10);
  expect(test.volume.BIRTH_L, 10);
  expect(test.volume.POPUP_R, 10);
  expect(test.volume.POPUP_L, 10);
  expect(test.volume.VERIFONE_R, 10);
  expect(test.volume.VERIFONE_L, 10);
  expect(test.designated.D_Left, 10);
  expect(test.designated.D_Right, 10);
  expect(test.pitch.CLICK_NUM_R, 1);
  expect(test.pitch.CLICK_NUM_L, 1);
  expect(test.pitch.ERR_NUM_R, 1);
  expect(test.pitch.ERR_NUM_L, 1);
  expect(test.pitch.FANFARE1_NUM_R, 1);
  expect(test.pitch.FANFARE1_NUM_L, 1);
  expect(test.pitch.FANFARE2_NUM_R, 1);
  expect(test.pitch.FANFARE2_NUM_L, 1);
  expect(test.pitch.FANFARE3_NUM_R, 1);
  expect(test.pitch.FANFARE3_NUM_L, 1);
  expect(test.pitch.BIRTH_NUM_R, 1);
  expect(test.pitch.BIRTH_NUM_L, 1);
  expect(test.pitch.WARNING_NUM_R, 1);
  expect(test.pitch.WARNING_NUM_L, 1);
  expect(test.pitch.POPUP_NUM_R, 1);
  expect(test.pitch.POPUP_NUM_L, 1);
  expect(test.pitch.VERIFONE_NUM_R, 1);
  expect(test.pitch.VERIFONE_NUM_L, 1);
}

