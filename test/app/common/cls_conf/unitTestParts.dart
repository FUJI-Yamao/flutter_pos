import 'package:flutter_pos/app/common/environment.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';

// テスト環境設定
// アプリ用フォルダのパスの要素を設定する。
// C:\Users\userName\AppData\Roaming\companyName\appName\
// const String userName    = "koidnori";
const String userName    = "koidnori";
const String companyName = "jp.co.fsi";
const String appName     = "flutter_pos";
const String _testPath   = "test_assets/";

// モック
// getApplicationSupportDirectory内で実行しているgetApplicationSupportPaht()が
// テスト環境でアプリ用フォルダのパスを取得できないため準備する。
class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin implements PathProviderPlatform {

  @override
  Future<String> getApplicationSupportPath() async {
    final String Path = join('C:', 'Users', userName, 'AppData', 'Roaming', companyName, appName);
    return Directory(Path).path;
  }
}

enum testFunc {
  getPattern1,
  getPattern2,
  getPattern3,
  getPattern4,
  getPattern5,
  getPattern6,
  getPattern7,
  getPattern8,
  getPattern9,
  makePattern1,
  makePattern2,
  makePattern3,
  makePattern4,
  makePattern5,
  makePattern6,
  makePattern7,
  makePattern8,
  makePattern9,
}

// ***************************************
// テストデータをコピーして実フォルダに作成する。
// 実データの作成タイミング（順番など）はここで行う。
// ***************************************
Future getTestDate(
    String confPath,
    String fileName,
    testFunc func,
    ) async {

  final testNameN1 = "testN1_" + fileName;  // 正常テストデータ(NormalDeta)
  final testNameN2 = "testN2_" + fileName;  // 正常テストデータ(NormalDeta)
  final testNameN3 = "testN3_" + fileName;  // 正常テストデータ(NormalDeta)
  final testNameE1 = "testE1_" + fileName;  // 異常テストデータ(ErrorData)
  final testNameE2 = "testE2_" + fileName;  // 異常テストデータ(ErrorData)

  Directory appDir = Directory(EnvironmentData.TPRX_HOME);
  Directory _testDir = Directory(join(appDir.path, _testPath));

  String jsonR;
  String jsonW;
  final String originalPath = join(appDir.path, confPath, fileName);
  final String tempPath = join(appDir.path, confPath, "temp_" + fileName);
  final String testPathN1 = join(appDir.path, _testPath, testNameN1);
  final String testPathN2 = join(appDir.path, _testPath, testNameN2);
  final String testPathN3 = join(appDir.path, _testPath, testNameN3);
  final String testPathE1 = join(appDir.path, _testPath, testNameE1);
  final String testPathE2 = join(appDir.path, _testPath, testNameE2);
  final String jsonPath = join(appDir.path, _testPath, fileName);
  final String absPath = join(appDir.path, _testPath);

  switch(func){
    case testFunc.getPattern1:
      final File testFileN1 = File(testPathN1);
      final File jsonFile = File(originalPath);
      final File testFileE2 = File(testPathE2);
      final File tempFile = File(tempPath);
      jsonR = await testFileN1.readAsString();
      jsonFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      jsonR = await testFileE2.readAsString();
      tempFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      break;
    case testFunc.getPattern2:
      final File testFileN1 = File(testPathN1);
      final File jsonFile = File(originalPath);
      final File testFileE2 = File(testPathE2);
      final File tempFile = File(tempPath);
      jsonR = await testFileN1.readAsString();
      jsonFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      jsonR = await testFileE2.readAsString();
      tempFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      break;
    case testFunc.getPattern3:
      final File tempFile = File(tempPath);
      jsonR = await tempFile.readAsString();
      tempFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      sleep(Duration(seconds: 1));
      final File jsonFile = File(originalPath);
      final File testFileE2 = File(testPathE2);
      jsonR = await testFileE2.readAsString();
      jsonFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      break;
    case testFunc.getPattern4:
      final File tempFile = File(tempPath);
      jsonR = await tempFile.readAsString();
      tempFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      sleep(Duration(seconds: 1));
      final File jsonFile = File(originalPath);
      final File testFileN1 = File(testPathN1);
      jsonR = await testFileN1.readAsString();
      jsonFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      break;
    case testFunc.getPattern5:
      final File testFileN1 = File(testPathN1);
      final File jsonFile = File(originalPath);
      final File testFileE2 = File(testPathE2);
      final File tempFile = File(tempPath);
      jsonR = await testFileN1.readAsString();
      jsonFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      sleep(Duration(seconds: 1));
      jsonR = await testFileE2.readAsString();
      tempFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      break;
    case testFunc.getPattern6:
      final File testFileN1 = File(testPathN1);
      final File jsonFile = File(originalPath);
      jsonR = await testFileN1.readAsString();
      jsonFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      break;
    case testFunc.getPattern7:
      final File testFileE1 = File(testPathE1);
      final File jsonFile = File(originalPath);
      final File testFileE2 = File(testPathE2);
      final File tempFile = File(tempPath);
      jsonR = await testFileE1.readAsString();
      jsonFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      sleep(Duration(seconds: 1));
      jsonR = await testFileE2.readAsString();
      tempFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      break;
    case testFunc.getPattern8:
      final File testFileE1 = File(testPathE1);
      final File jsonFile = File(originalPath);
      final File testFileE2 = File(testPathE2);
      final File tempFile = File(tempPath);
      jsonR = await testFileE2.readAsString();
      tempFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      sleep(Duration(seconds: 1));
      jsonR = await testFileE1.readAsString();
      jsonFile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      break;
    case testFunc.getPattern9:
      print(originalPath);
      print(testPathN1);
      print(testPathN2);
      print(testPathN3);

      await Directory(join(appDir.path, confPath).replaceFirst("/aa/","/ex/")).create(recursive:true);
      final File testFileN1 = File(testPathN1);
      final File jsonFile1 = File(originalPath.replaceFirst("/aa/","/ex/"));
      jsonR = await testFileN1.readAsString();
      jsonFile1.writeAsStringSync(jsonR, encoding: utf8, flush: false);

      await Directory(join(appDir.path, confPath).replaceFirst("/aa/","/cn/")).create(recursive:true);
      final File testFileN2 = File(testPathN2);
      final File jsonFile2 = File(originalPath.replaceFirst("/aa/","/cn/"));
      jsonR = await testFileN2.readAsString();
      jsonFile2.writeAsStringSync(jsonR, encoding: utf8, flush: false);

      await Directory(join(appDir.path, confPath).replaceFirst("/aa/","/tw/")).create(recursive:true);
      final File testFileN3 = File(testPathN3);
      final File jsonFile3 = File(originalPath.replaceFirst("/aa/","/tw/"));
      jsonR = await testFileN3.readAsString();
      jsonFile3.writeAsStringSync(jsonR, encoding: utf8, flush: false);
      break;
    default:
  }
}

// ***************************************
// テストデータをテストフォルダに作成する。
// 実フォルダに作成するのはgetTestDataで別途行う。
// 実データの作成タイミング（順番など）はそちらで行う。
// ***************************************
Future makeTestData(
    String   confPath,
    String   fileName,
    testFunc testPatern,
    String   section,
    String   key,
    dynamic  value1,
   [dynamic value2,
    dynamic value3]
    ) async{

  final testNameN1 = "testN1_" + fileName;  // 正常テストデータ(NormalDeta)
  final testNameN2 = "testN2_" + fileName;  // 正常テストデータ(NormalDeta)
  final testNameN3 = "testN3_" + fileName;  // 正常テストデータ(NormalDeta)
  final testNameE1 = "testE1_" + fileName;  // 異常テストデータ(ErrorData)
  final testNameE2 = "testE2_" + fileName;  // 異常テストデータ(ErrorData)

  Directory appDir = Directory(EnvironmentData.TPRX_HOME);
  Directory _testDir = Directory(join(appDir.path, _testPath));

  if (!(_testDir.existsSync())) {
    // テスト用ディレクトリが存在しない場合は作成する。
    _testDir.createSync(recursive: true);
  }
  String jsonR;
  String jsonW;
  final String originalPath = join(appDir.path, confPath, fileName);
  final String tempPath = join(appDir.path, confPath, "temp_" + fileName);
  final String testPathN1 = join(appDir.path, _testPath, testNameN1);
  final String testPathN2 = join(appDir.path, _testPath, testNameN2);
  final String testPathN3 = join(appDir.path, _testPath, testNameN3);
  final String testPathE1 = join(appDir.path, _testPath, testNameE1);
  final String testPathE2 = join(appDir.path, _testPath, testNameE2);
  final String jsonPath = join(appDir.path, _testPath, fileName);

  switch(testPatern){
    case testFunc.makePattern1:   // バックアップ作成中
      final File jsonFile = File(originalPath);
      final File testFileN1 = File(testPathN1);
      final File testFileE2 = File(testPathE2);
      jsonR = await jsonFile.readAsString();
      jsonW = await getJsonString(jsonR, section, key, value1);
      testFileN1.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      jsonR = await jsonFile.readAsString();
      jsonW = await getJsonString(jsonR, section, key, value2);
      jsonW = jsonW.substring(0,jsonW.length - 5);
      testFileE2.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      break;
    case testFunc.makePattern2:   // バックアップ作成直後
      final File jsonFile = File(originalPath);
      final File testFileN1 = File(testPathN1);
      final File testFileE2 = File(testPathE2);
      jsonR = await jsonFile.readAsString();
      jsonW = await getJsonString(jsonR, section, key, value1);
      testFileN1.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      jsonR = await jsonFile.readAsString();
      jsonW = await getJsonString(jsonR, section, key, value2);
      testFileE2.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      break;
    case testFunc.makePattern3:   // JSON更新中
      final File jsonFile = File(originalPath);
      final File tempFile = File(tempPath);
      final File testFileE2 = File(testPathE2);
      jsonR = await jsonFile.readAsString();
      jsonW = await getJsonString(jsonR, section, key, value1);
      tempFile.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      jsonW = await getJsonString(jsonR, section, key, value2);
      jsonW = jsonW.substring(0,jsonW.length - 5);
      testFileE2.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      break;
    case testFunc.makePattern4:   // JSON更新完了直後
      final File jsonFile = File(originalPath);
      final File tempFile = File(tempPath);
      final File testFileN1 = File(testPathN1);
      jsonR = await jsonFile.readAsString();
      jsonW = await getJsonString(jsonR, section, key, value1);
      tempFile.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      jsonW = await getJsonString(jsonR, section, key, value2);
      testFileN1.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      break;
    case testFunc.makePattern5:   // バックアップ削除中（そんなことあるのか？）
      final File jsonFile = File(originalPath);
      final File testFileN1 = File(testPathN1);
      final File testFileE2= File(testPathE2);
      jsonR = await jsonFile.readAsString();
      jsonW = await getJsonString(jsonR, section, key, value1);
      testFileN1.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      jsonW = await getJsonString(jsonR, section, key, value2);
      jsonW = jsonW.substring(0,jsonW.length - 5);
      testFileE2.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      break;
    case testFunc.makePattern6:   // バックアップ削除完了直後
      final File jsonFile = File(originalPath);
      final File testFileN1 = File(testPathN1);
      jsonR = await jsonFile.readAsString();
      jsonW = await getJsonString(jsonR, section, key, value1);
      testFileN1.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      break;
    case testFunc.makePattern7:   // 両方壊れている場合1（バックアップが新しい場合）
    case testFunc.makePattern8:   // 両方壊れている場合2（JSONが新しい場合）
      final File jsonFile = File(originalPath);
      final File testFileE1 = File(testPathE1);
      final File testFileE2 = File(testPathE2);
      jsonR = await jsonFile.readAsString();
      jsonW = await getJsonString(jsonR, section, key, value1);
      jsonW = jsonW.substring(0,jsonW.length - 5);
      sleep(Duration(seconds: 1));
      testFileE1.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      jsonW = await getJsonString(jsonR, section, key, value2);
      jsonW = jsonW.substring(0,jsonW.length - 5);
      testFileE2.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      break;
    case testFunc.makePattern9:   // 言語切換
      final File jsonFile = File(originalPath);
      final File testFileN1 = File(testPathN1);
      final File testFileN2 = File(testPathN2);
      final File testFileN3 = File(testPathN3);
      jsonR = await jsonFile.readAsString();
      jsonW = await getJsonString(jsonR, section, key, value1);
      testFileN1.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      jsonW = await getJsonString(jsonR, section, key, value2);
      testFileN2.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      jsonW = await getJsonString(jsonR, section, key, value3);
      testFileN3.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      break;
    default:
      break;
  }
}

// ***************************************
// デバッグ状態を返す。
// テスト中はデバッグ状態となるためあまり意味はないが。。。
// ***************************************
bool _getDebugState(){
  const vm = bool.fromEnvironment("dart.vm.product");
  const debug = bool.fromEnvironment("JSON_SHAPING", defaultValue: !vm);
  return debug;
}

// ***************************************
// 指定したセクション、キーについて、指定値に変更した上で、
// JSONファイルの文字列を返却する。
// 変更がない文字列を取得する場合は、当該関数を使用しない。
// ***************************************
Future getJsonString(String jsonR, String section, String key, dynamic value) async
{
  final jsonObj = await json.decode(jsonR);
  jsonObj[section][key] = value;

  String jsonW = json.encode(jsonObj);
  if (_getDebugState() == true) {
    // Debug版は内容を分かりやすくするためJSONファイル保存時に整形する。
    // Release版は整形無用（2023/2/14）
    jsonW = jsonW.replaceAll('},"', '},\n    "');
    jsonW = jsonW.replaceAll(':{"', ':{\n        "');
    jsonW = jsonW.replaceAll(',"', ',\n        "');
    jsonW = jsonW.replaceAll('},', '\n    },');
    jsonW = jsonW.replaceAll('}}', '\n    }\n}\n');
    jsonW = jsonW.replaceAll('{"', '{\n    "');
    jsonW = jsonW.replaceAll('":', '": ');
  }
  return jsonW;
}
