/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import '../lib/cm_sys/cm_cksys.dart';
import '../ui/enum/e_screen_kind.dart';
import '../ui/model/m_screeen_info.dart';
import 'cls_conf/environmentJsonFile.dart';

/// 設定ファイルから取得されるデータ.
/// 使用頻度が高いもの.
class EnvironmentData {
  static const HOME = "/pj/tprx";
  static const TPRX_HOME = "/pj/tprx/";
  static const PG_DATA = "/usr/local/pgsql/data";
  static const SHELL = "/bin/bash";
  static const NONE = "";

  /// 共有変数：environment.json から読み取ったパラメタ
  Map<String, String> env = {
    "HOME": "",
    "PATH": "",
    "SHELL": "",
    "BASE_ENV": "",
    "LC_ALL": "",
    "LANG": "",
    "LINGUAS": "",
    "TPRX_HOME": "",
    "DISPLAY": "",
    "WINDOW": "",
    "CONTENT_LENGTH": "",
    "PGPASSWORD": "",
    "PGUSER": "",
    "PGDATA": "",
    "PGDATABASE": "",
    "PGHOST": "",
    "PGOPTIONS": "",
    "PGPORT": "",
    "PGTTY": "",
    "PGCLIENTENCODING": "",
    "SMX_HOME": "",
    "TUO_SEND_ENV": ""
  };

  /// 関連tprxソース:tprmacro.h getenv( "TPRX_HOME" );
  String sysHomeDir = "";

  /// プロトタイプ向け.WebAPIを利用するかどうか.
  bool isUseWebAPI = false;

  /// 画面情報（screenInfo.json）
  final Map<ScreenKind, ScreenInfo> _mapScreenInfo = {};

  /// 自身の画面
  ScreenKind screenKind = ScreenKind.register;

  static final EnvironmentData _instance = EnvironmentData._internal();
  factory EnvironmentData() {
    return _instance;
  }
  EnvironmentData._internal();

  /// 環境変数を取得する.
  Future<void> tprLibGetEnv() async {
    EnvironmentJsonFile envJson = EnvironmentJsonFile();
    await envJson.load();

    env["HOME"] = envJson.environment.HOME;
    if (env["HOME"]!.isEmpty) {
      env["HOME"] = HOME;
    }
    env["PATH"] = envJson.environment.PATH;
    env["SHELL"] = envJson.environment.SHELL;
    if (env["SHELL"]!.isEmpty) {
      env["SHELL"] = SHELL;
    }
    env["BASE_ENV"] = envJson.environment.BASE_ENV;
    env["LC_ALL"] = envJson.environment.LC_ALL;
    env["LANG"] = envJson.environment.LANG;
    env["LINGUAS"] = envJson.environment.LINGUAS;
    env["TPRX_HOME"] = envJson.environment.TPRX_HOME;
    if (env["TPRX_HOME"]!.isEmpty) {
      env["TPRX_HOME"] = TPRX_HOME;
    }
    env["DISPLAY"] = envJson.environment.DISPLAY;
    env["WINDOW"] = envJson.environment.WINDOW;
    env["CONTENT_LENGTH"] = envJson.environment.CONTENT_LENGTH;
    env["PGPASSWORD"] = envJson.environment.PGPASSWORD;
    env["PGUSER"] = envJson.environment.PGUSER;
    env["PGDATA"] = envJson.environment.PGDATA;
    if (env["PGDATA"]!.isEmpty) {
      env["PGDATA"] = PG_DATA;
    }
    env["PGDATABASE"] = envJson.environment.PGDATABASE;
    env["PGHOST"] = envJson.environment.PGHOST;
    env["PGOPTIONS"] = envJson.environment.PGOPTIONS;
    env["PGPORT"] = envJson.environment.PGPORT;
    env["PGTTY"] = envJson.environment.PGTTY;
    env["PGCLIENTENCODING"] = envJson.environment.PGCLIENTENCODING;
    env["SMX_HOME"] = envJson.environment.SMX_HOME;
    env["TUO_SEND_ENV"] = envJson.environment.TUO_SEND_ENV;

    sysHomeDir = env["TPRX_HOME"]!;
    if (sysHomeDir.substring(sysHomeDir.length-1) == "/") {
      sysHomeDir = sysHomeDir.substring(0, sysHomeDir.length-1);
    }
  }

  /// screenInfo.jsonを読込んで画面情報を取得する
  Future<void> initScreenInfo() async {
    String str = await rootBundle.loadString("assets/ui/screenInfo.json");
    dynamic json = jsonDecode(str);
    debugPrint('screenInfo:$json');

    _mapScreenInfo[ScreenKind.register] = _createScreenInfo(json['screenKind']['register']);
    _mapScreenInfo[ScreenKind.register2] = _createScreenInfo(json['screenKind']['register2']);
    _mapScreenInfo[ScreenKind.customer] = _createScreenInfo(json['screenKind']['customer']);
    _mapScreenInfo[ScreenKind.customer_7_1] = _createScreenInfo(json['screenKind']['customer_7_1']);
    _mapScreenInfo[ScreenKind.customer_7_2] = _createScreenInfo(json['screenKind']['customer_7_2']);
  }

  /// ScreenInfoの生成
  ScreenInfo _createScreenInfo(Map<String, dynamic> map) {
    return ScreenInfo(
      width: map['width'],
      height: map['height'],
      position: double.parse('${map['position']}'),
      address: map['address'],
      port: map['port'],
    );
  }

  /// 自身の画面情報の取得
  ScreenInfo getOwnScreenInfo() {
    return getScreenInfo(screenKind);
  }

  /// 画面情報の取得
  ScreenInfo getScreenInfo(ScreenKind screenKind) {
    ScreenInfo? screenInfo = _mapScreenInfo[screenKind];
    if (screenInfo == null) {
      throw AssertionError('_mapScreenInfoに$screenKindが見つからない');
    }
    return screenInfo;
  }

}

/// プラットフォームを考慮した処理クラス.
class TprxPlatform {
  static bool isDesktop =
      (Platform.isLinux || Platform.isMacOS || Platform.isWindows);

  /// プラットフォームに合わせたパスに直す.
  static getPlatformPath(String path) {
    if(Platform.isAndroid){ //Androidは自アプリ内のフォルダへアクセスさせる.
      if(path.isNotEmpty && path[0] == "/"){
        // 絶対パスが指定されている場合、相対パスに直す.
        path = path.substring(1);
      }
      return join(AppPath().path, path);
    }
    return path;
  }

  ///  パスをプラットフォーム用に直してdirectoryを取得する
  ///
  /// Androidではアプリケーションフォルダ内にしかアクセスできないため、
  /// パスを加工してDirectoryを取得する.
  static Directory getDirectory(String path){
    return  Directory(getPlatformPath(path));
  }

  /// パスをプラットフォーム用に直してfileを取得する
  ///
  /// Androidではアプリケーションフォルダ内にしかアクセスできないため、
  /// パスを加工してFileを取得する.
  static File getFile(String path){
    return  File(getPlatformPath(path));
  }
}
