/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

import '../environment.dart';

enum json_result {
  success, // 成功
  invalid_parameter, // 不正パラメータ
  no_file, // ファイル消失
  element_not_found, // 指定セクション、指定キー不存在
  invalid_format, // 不正フォーマット
  other_error, // その他処理エラー
}

class JsonRet {
  bool result = false; // 結果
  json_result cause = json_result.other_error; // 結果理由
  dynamic value; // 取得・設定した値
}

enum JsonLanguage {
  non,
  aa, // 日本語
  ex, // 英語
  cn, // 中国語
  tw, // 中国語
}

/// 設定ファイルを読みだすファイルパスクラス.
class JsonPath {
  ///  アプリ用フォルダの絶対パス
  String absolutePath = "";
  static final JsonPath _cache = JsonPath._internal();
  factory JsonPath() {
    return _cache;
  }
  JsonPath._internal();
}

// *************************************************
// ※getApplicationSupportDirectory()で得られるパスはOS毎に異なるが、
// 　いずれもアプリ用フォルダとして、プロジェクトフォルダ外に作成される。
// 　Windows   C:\Users\ユーザ\AppData\Roaming\会社名\アプリ名
// 　Android   /data/user/0/会社名.アプリ名/files/
// 　Linux     admin:///root/.local/share/会社名.アプリ名/
//  会社名　：jp.co.fsi
//　アプリ名：flutter_pos
// ************************************************
// ※ ～JsonFile.g.dartの生成方法
// Terminal（端末）で下記コマンドを実行する。
// $ flutter pub run build_runner build
// 追加したファイルだけが実行されない場合、下記コマンドで全体的に強制実行
// $ flutter pub run build_runner build --delete-conflicting-outputs
// 上記でもうまく行かない場合は...
// $ flutter clean ⇒ $ flutter pub get ⇒ $ flutter packages pub run build_runner build
// ************************************************
abstract class ConfigJsonFile {
  // *************************************************
  // 変数
  // *************************************************
  String _confPath = "";
  String _confLang = "";
  String _fileName = "";

  // *************************************************
  // 抽象メソッド
  // *************************************************
  bool setSectionData(jsonR);
  String jsonFileToJson();


  // *************************************************
  // 共通メソッド
  // *************************************************
  // *********************
  // setPath
  // 引数　confPath：assets/...以下のパス
  // 　　　fileName：JSONファイル名
  // 継承先で設定されたJsonファイルのパス情報を当該クラスに取り込む
  // *********************
  void setPath(String confPath, String fileName,
      [JsonLanguage confLang = JsonLanguage.non]) {
    _confPath = confPath;
    _fileName = fileName;
    changeLanguage(confLang);
  }

  Directory _getAppDir() {
    if (JsonPath().absolutePath.isEmpty) {
      return Directory(EnvironmentData.TPRX_HOME);
    }
    return Directory(JsonPath().absolutePath);
  }

  Future<String> getFilePath() async {
    Directory appDir = _getAppDir();
    final String jsonPath = join(appDir.path, _confPath, _confLang, _fileName);
    return jsonPath;
  }

  String getFileName() {
    return _fileName;
  }

  // *********************
  // changeLanguage
  // 引数　confLang：言語別フォルダの指定
  // 言語別フォルダを指定する。指定された情報はパスの一部として付加する。
  // *********************
  void changeLanguage(JsonLanguage confLang) {
    switch (confLang) {
      case JsonLanguage.aa:
        _confLang = "aa/";
        break;
      case JsonLanguage.ex:
        _confLang = "ex/";
        break;
      case JsonLanguage.cn:
        _confLang = "cn/";
        break;
      case JsonLanguage.tw:
        _confLang = "tw/";
        break;
      default:
        _confLang = "";
        break;
    }
  }

  // *********************
  // save
  // 展開中のデータを元にJSONファイルを上書き保存する。
  // *********************
  Future save() async {
    Directory appDir = _getAppDir();
    Directory _jsonDir = Directory(join(appDir.path, _confPath, _confLang));
    if (!(_jsonDir.existsSync())) {
      // ディレクトリが存在しない場合は作成する。
      _jsonDir.createSync(recursive: true);
    }
    final String tempPath = join(_jsonDir.path, "temp_" + _fileName);
    final String jsonPath = join(_jsonDir.path, _fileName);
    final File file = File(jsonPath);
    final File tempfile = File(tempPath);
    debugPrint("save実行：" + file.path);

    if (file.existsSync()) {
      // 元ファイルが存在していればバックアップ
      final String jsonR = await file.readAsString();
      tempfile.writeAsStringSync(jsonR, encoding: utf8, flush: false);
    }
    // 元ファイルを新しい内容で上書きする。
    String jsonW = jsonFileToJson();
    if (getDebugState()) {
      jsonW = jsonShaping(jsonW);
    }
    file.writeAsStringSync(jsonW, encoding: utf8, flush: false);
    if (tempfile.existsSync()) {
      // バックアップを生成していれば削除する。
      tempfile.deleteSync();
    }
  }

  // *********************
  // getValueWithName
  // 引数　section：Jsonファイル内のオブジェクト名（INIファイルのセクション名）
  // 　　　key    ：JSONファイル内のプロパティ名（INIファイルのキー名）
  // 戻り値　result：true ：成功
  //　　　　　　　　　 false：失敗
  //        cause：json_result.success          ：読み込み成功
  // 　　　　　　　　 json_result.invalid_parameter：パラメータエラー
  // 　　　　　　　　 json_result.no_file          ：ファイル無し
  //               json_resultother_error       ：指定セクション、指定キー不存在
  // 　　　　　　　　 json_result.other_error      ：その他、処理エラー
  //       value ：読み込んだ値（型指定無し：コールした側で適切に処理すること）
  // *********************
  Future<JsonRet> getValueWithName(String section, String key) async {
    Directory appDir = _getAppDir();
    final String jsonPath = join(appDir.path, _confPath, _confLang, _fileName);

    return await getJsonValue(jsonPath, section, key);
  }

  // *********************
  // setValueWithName
  // 引数　section：Jsonファイル内のオブジェクト名（INIファイルのセクション名）
  // 　　　key    ：JSONファイル内のプロパティ名（INIファイルのキー名）
  // 　　　value  ：上記に関する値
  // 戻り値　result：true ：成功
  //　　　　　　　　　 false：失敗
  //        cause：json_result.success          ：書き込み成功
  // 　　　　　　　　 json_result.invalid_parameter：パラメータエラー
  // 　　　　　　　　 json_result.no_file          ：ファイル無し
  //               json_resultother_error       ：指定セクション、指定キー不存在
  // 　　　　　　　　 json_result.other_error      ：その他、処理エラー
  // *********************
  Future<JsonRet> setValueWithName(
      String section, String key, dynamic value) async {
    Directory appDir = _getAppDir();
    final String jsonPath = join(appDir.path, _confPath, _confLang, _fileName);

    return await setJsonValue(jsonPath, section, key, value);
  }

  // *********************
  // getValueWithName
  // 引数  なし
  // 戻り値 result：true ：成功
  //                false：失敗
  //        cause ：json_result.success          ：読み込み成功
  //                json_result.invalid_parameter：パラメータエラー
  //                json_result.no_file          ：ファイル無し
  //                json_result.other_error      ：その他、処理エラー
  //       value  ：読み込んだJsonファイルをMapに変換したオブジェクト
  // *********************
  Future<JsonRet> getMap() async {
    Directory appDir = _getAppDir();
    final String jsonPath = join(appDir.path, _confPath, _confLang, _fileName);

    return await getJsonMap(jsonPath);
  }

  // *********************
  // setMap
  // 引数   object ：JsonファイルのMapオブジェクト
  // 戻り値 result ：true ：成功
  //                 false：失敗
  //        cause  ：json_result.success          ：書き込み成功
  //                 json_result.invalid_parameter：パラメータエラー
  //                 json_result.no_file          ：ファイル無し
  //                 json_result.other_error      ：その他、処理エラー
  // *********************
  Future<JsonRet> setMap(Object object) async {
    Directory appDir = _getAppDir();
    final String jsonPath = join(appDir.path, _confPath, _confLang, _fileName);

    return await setJsonMap(jsonPath, object);
  }

  // **********************************************
  // _restoreJson
  // 引数　tempPath：バックアップファイルのパス情報
  // 　　　jsonPath：元ファイルのパス情報
  // _restoreJson実行時にtempPathが存在していた場合、
  // 前回のsave実行時で何らかの事故が起こっている可能性がある。
  // tempPathとjsonPathで新旧比較し、新しい方から復活を試みる。
  // **********************************************
  Future _restoreJson(tempPath, jsonPath) async {
    final File temp = File(tempPath);
    final File json = File(jsonPath);
    bool validDataJson = false;
    bool validDataTemp = false;
    String jsonW = "";
    String str = "";
    if (temp.existsSync()) {
      debugPrint("バックアップJSON残留検知");
      if (json.existsSync()) {
        if (json.lastModifiedSync().isAfter(temp.lastModifiedSync()) == true) {
          // 元データが新しい場合、更新開始してバックアップが削除できてないケース
          // 先に元データの更新が完了しているか確認する。
          debugPrint("元データの方が新しい　⇒　復帰を試みる");
          jsonW = await json.readAsString();
          validDataJson = setSectionData(jsonW);
        } else {
          // バックアップが新しい場合、更新着手前に中断しているケース
          debugPrint("バックアップの方が新しい");
          validDataJson = false;
        }
      }
      if (validDataJson == true) {
        // 正常に読み込めていればバックアップを破棄する。
        debugPrint("元データ正常");
        validDataTemp = false;
      } else {
        // 元データが正常に読み込め無ければバックアップでリトライする。
        debugPrint("バックアップで復帰を試みる");
        jsonW = await temp.readAsString();
        validDataTemp = setSectionData(jsonW);
        str = "バックアップJSONから復帰";
      }
      if (validDataTemp == true) {
        debugPrint(str);
        json.writeAsStringSync(jsonW, encoding: utf8, flush: false);
        str = "バックアップJSON削除";
      } else {
        str = "バックアップJSON破棄";
      }
      temp.deleteSync();
      debugPrint(str);
    }
  }

  // **********************************************
  // setDefault
  // 対象のJSONファイルをassetsから読み込み、アプリフォルダに新規作成（上書き保存）する。
  // **********************************************
  Future<void> setDefault() async {
    Directory appDir = _getAppDir();
    final String jsonPath = join(appDir.path, _confPath, _confLang, _fileName);
    final File file = File(jsonPath);
    if (file.existsSync()) {
      file.deleteSync();
    }
    setSectionData("{}");
    await save();
    debugPrint("JSONファイル生成完了");
  }

  // **********************************************
  // load
  // アプリフォルダに格納中の対象JSONファイルを読み込む。
  // 存在しない場合はsetDefaultを、破損している場合は
  // _restoreJsonやsetDefault実行し復帰させる、
  // **********************************************
  Future<void> load() async {
    Directory appDir = _getAppDir();
    final String tempPath =
        join(appDir.path, _confPath, _confLang, "temp_" + _fileName);
    final String jsonPath = join(appDir.path, _confPath, _confLang, _fileName);
    debugPrint("load実行：" + jsonPath);

    // JSONファイル復活処理
    await _restoreJson(tempPath, jsonPath);

    final File file = File(jsonPath);
    if (!(file.existsSync())) {
      debugPrint("JSONファイル消失 ⇒　初期ファイル読込実行");
      await setDefault();
    } else {
      final String jsonR = await file.readAsString();
      bool validData = setSectionData(jsonR);
      if (validData != true) {
        debugPrint("JSONファイルload失敗 ⇒　破棄して初期ファイル読込実行");
        await setDefault();
      }
    }
  }

  // **********************************************
  // preMake
  // アプリフォルダに格納中の対象JSONファイルが
  // 存在しなければ作成（load）する。存在すれば何もしない。
  // **********************************************
  Future<void> preMake() async {
    Directory appDir = _getAppDir();
    final String jsonPath = join(appDir.path, _confPath, _confLang, _fileName);

    final File file = File(jsonPath);
    if (!(file.existsSync())) {
      await load();
    }
  }

  // **********************************************
  // delete
  // アプリフォルダに格納中の対象JSONファイルを削除する。
  // **********************************************
  Future<void> delete() async {
    Directory appDir = _getAppDir();
    final String jsonPath = join(appDir.path, _confPath, _confLang, _fileName);

    final File file = File(jsonPath);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }
}

// *********************
// getJsonValue
// 引数　filePath：Jsonファイルの絶対パス
//      section：Jsonファイル内のオブジェクト名（INIファイルのセクション名）
// 　　　key    ：JSONファイル内のプロパティ名（INIファイルのキー名）
// 戻り値　result：true ：成功
//　　　　　　　　　 false：失敗
//        cause：json_result.success          ：読み込み成功
// 　　　　　　　　 json_result.invalid_parameter：パラメータエラー
// 　　　　　　　　 json_result.no_file          ：ファイル無し
//               json_resultother_error       ：指定セクション、指定キー不存在
// 　　　　　　　　 json_result.other_error      ：その他、処理エラー
//       value ：読み込んだ値（型指定無し：コールした側で適切に処理すること）
// *********************
Future<JsonRet> getJsonValue(
    String filePath, String section, String key) async {
  JsonRet ret = JsonRet();
  try {
    do {
      if (filePath.isEmpty || section.isEmpty || key.isEmpty) {
        ret.cause = json_result.invalid_parameter;
        break;
      }

      final File file = File(filePath);
      if (!(file.existsSync())) {
        debugPrint("JSONファイル消失");
        ret.cause = json_result.no_file;
        break;
      }

      final String jsonR = await file.readAsString();
      dynamic jsonObj;
      try {
        jsonObj = await json.decode(jsonR);
      } catch (e) {
        ret.cause = json_result.invalid_format;
        break;
      }
      dynamic value;
      try {
        value = jsonObj[section][key];
        if((value.runtimeType == Null)){
          ret.cause = json_result.element_not_found;
          break;
        }
      } catch (e) {
        ret.cause = json_result.element_not_found;
        break;
      }
      ret.result = true;
      ret.cause = json_result.success;
      ret.value = value;
    } while (false);
  } catch (e, s) {
    debugPrint(e.toString() + "," + s.toString());
  }
  return ret;
}

// *********************
// setJsonValue
// 引数　filePath：Jsonファイルの絶対パス
//      section：Jsonファイル内のオブジェクト名（INIファイルのセクション名）
// 　　　key    ：JSONファイル内のプロパティ名（INIファイルのキー名）
// 　　　value  ：上記に関する値
// 戻り値　result：true ：成功
//　　　　　　　　　 false：失敗
//        cause：json_result.success          ：書き込み成功
// 　　　　　　　　 json_result.invalid_parameter：パラメータエラー
// 　　　　　　　　 json_result.no_file          ：ファイル無し
//               json_resultother_error       ：指定セクション、指定キー不存在
// 　　　　　　　　 json_result.other_error      ：その他、処理エラー
// *********************
Future<JsonRet> setJsonValue(
    String filePath, String section, String key, dynamic value) async {
  JsonRet ret = JsonRet();
  try {
    do {
      if (filePath.isEmpty || section.isEmpty || key.isEmpty) {
        ret.cause = json_result.invalid_parameter;
        break;
      }

      final File file = File(filePath);
      debugPrint("setValueWithName実行：" + file.path);
      if (!file.existsSync()) {
        debugPrint("JSONファイル消失");
        ret.cause = json_result.no_file;
        break;
      }

      List tempStr = filePath.split("/");
      String fileName = tempStr[tempStr.length - 1];
      Directory jsonDir =
          Directory(filePath.substring(0, (filePath.length - fileName.length)));

      final String tempPath = join(jsonDir.path, "temp_" + fileName);

      // 元ファイルが存在していればバックアップ
      final File tempfile = File(tempPath);
      final String jsonR = await file.readAsString();
      tempfile.writeAsStringSync(jsonR, encoding: utf8, flush: false);

      dynamic jsonObj;
      try {
        jsonObj = await json.decode(jsonR);
      } catch (e) {
        ret.cause = json_result.invalid_format;
        break;
      }
      // 指定要素が存在するかチェックする。
      try {
        final test = jsonObj[section][key];
        if (test.runtimeType == Null) {
          ret.cause = json_result.element_not_found;
          break;
        }
      } catch (e) {
        ret.cause = json_result.element_not_found;
        break;
      }
      // JSONデコードして値をセットする。
      jsonObj[section][key] = value;
      String jsonW = json.encode(jsonObj);
      if (getDebugState()) {
        jsonW = jsonShaping(jsonW);
      }
      file.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      if (tempfile.existsSync()) {
        // バックアップを生成していれば削除する。
        tempfile.deleteSync();
      }
      ret.result = true;
      ret.cause = json_result.success;
      ret.value = value;
    } while (false);
  } catch (e, s) {
    debugPrint(e.toString() + "," + s.toString());
  }
  return ret;
}

// *********************
// getJsonMap
// 引数   filePath：Jsonファイルの絶対パス
// 戻り値   result：true ：成功
//                  false：失敗
//          cause ：json_result.success          ：読み込み成功
//                  json_result.invalid_parameter：パラメータエラー
//                  json_result.no_file          ：ファイル無し
//          value ：読み込んだJsonMap
// *********************
Future<JsonRet> getJsonMap(String filePath) async {
  JsonRet ret = JsonRet();
  try {
    do {
      if (filePath.isEmpty) {
        ret.cause = json_result.invalid_parameter;
        break;
      }

      final File file = File(filePath);
      debugPrint("getJsonMap：" + file.path);
      if (!(file.existsSync())) {
        debugPrint("JSONファイル消失");
        ret.cause = json_result.no_file;
        break;
      }

      final String jsonR = await file.readAsString();
      Object jsonObj;
      try {
        jsonObj = await json.decode(jsonR);
      } catch (e) {
        ret.cause = json_result.invalid_format;
        break;
      }
      ret.result = true;
      ret.cause = json_result.success;
      ret.value = jsonObj;
    } while (false);
  } catch (e, s) {
    debugPrint(e.toString() + "," + s.toString());
  }
  return ret;
}

// *********************
// setJsonMap
// 引数   filePath：Jsonファイルの絶対パス
//        jsonObj ：JsonファイルのMapオブジェクト
// 戻り値 result  ：true ：成功
//                  false：失敗
//        cause   ：json_result.success          ：書き込み成功
//                  json_result.invalid_parameter：パラメータエラー
//                  json_result.no_file          ：ファイル無し
//        value     null
// *********************
Future<JsonRet> setJsonMap(String filePath, Object jsonObj) async {
  JsonRet ret = JsonRet();
  try {
    do {
      if (filePath.isEmpty) {
        ret.cause = json_result.invalid_parameter;
        break;
      }

      final File file = File(filePath);
      debugPrint("setJsonMap：" + file.path);
      if (!file.existsSync()) {
        debugPrint("JSONファイル消失");
        ret.cause = json_result.no_file;
        break;
      }

      List tempStr = filePath.split("/");
      String fileName = tempStr[tempStr.length - 1];
      Directory jsonDir =
      Directory(filePath.substring(0, (filePath.length - fileName.length)));

      final String tempPath = join(jsonDir.path, "temp_" + fileName);

      // 元ファイルが存在していればバックアップ
      final File tempfile = File(tempPath);
      final String jsonR = await file.readAsString();
      tempfile.writeAsStringSync(jsonR, encoding: utf8, flush: false);

      // JSONデコードして値をセットする。
      String jsonW = "";
      try {
        jsonW = json.encode(jsonObj);
      } catch (e) {
        ret.cause = json_result.invalid_format;
        break;
      }
      if (getDebugState()) {
        jsonW = jsonShaping(jsonW);
      }
      file.writeAsStringSync(jsonW, encoding: utf8, flush: false);
      if (tempfile.existsSync()) {
        // バックアップを生成していれば削除する。
        tempfile.deleteSync();
      }
      ret.result = true;
      ret.cause = json_result.success;
    } while (false);
  } catch (e, s) {
    debugPrint(e.toString() + "," + s.toString());
  }
  return ret;
}

// **********************************************
// getDebugState
// アプリの実行形態（Release/Debug）を返却する。
// Configurationの「Additional run arg」（Additional arg）で
// 「--dart-define=JSON_SHAPING=***」が設定されている場合はそれに従う。
// 設定されていない場合はrunの設定（dart.vm.product）に従う。
// 戻り値：true ..... DEBUG
//        false .... RELEASE
// **********************************************
bool getDebugState() {
  const vm = bool.fromEnvironment("dart.vm.product");
  const debug = bool.fromEnvironment("JSON_SHAPING", defaultValue: !vm);
  return debug;
}

String jsonShaping(String jsonW) {
  // Debug版は内容を分かりやすくするためJSONファイル保存時に整形する。
  // Release版は整形無用（2023/2/14）
  jsonW = jsonW.replaceAll('},"', '},\n    "');
  jsonW = jsonW.replaceAll(':{"', ':{\n        "');
  jsonW = jsonW.replaceAll(',"', ',\n        "');
  jsonW = jsonW.replaceAll('},', '\n    },');
  jsonW = jsonW.replaceAll('}}', '\n    }\n}\n');
  jsonW = jsonW.replaceAll('{"', '{\n    "');
  jsonW = jsonW.replaceAll('":', '": ');
  jsonW = jsonW.replaceAll('": ": ', '": ":');
  jsonW = jsonW.replaceAll(',\n      ",\n      "', ',",\n      "');
  return jsonW;
}