/*
* (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
* CONFIDENTIAL/社外秘
* 無断開示・無断複製禁止
*/

/// 初期起動用Main
/// Main→app→開設処理またはメニューへ遷移
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

import 'app/app_customer.dart';
import 'app/app_register.dart';
import 'app/common/cls_conf/sysJsonFile.dart';
import 'app/common/environment.dart';
import 'app/common/language_label_importer.dart';
import 'app/inc/sys/tpr_log.dart';
import 'app/sys/syst/sys_main.dart';
import 'app/ui/enum/e_screen_kind.dart';
import 'app/ui/model/m_screeen_info.dart';
import 'ps_control/ps_monitoring.dart';

/// 外部より引数取得
void main(List<String> args) async {
  /// android用 flutter engine & framework bind
  WidgetsFlutterBinding.ensureInitialized();
  /// screenInfo.jsonを読込んで画面情報を取得する
  await EnvironmentData().initScreenInfo();
  // 起動パラメータの画面種別を確認して、画面サイズを調整
  if (Platform.isLinux || Platform.isWindows) {
    // 画面判定
    linuxWindowsJugement(args);
    // 画面調整
    await windowManagerCall();
  } else {
    await androidJugement();
  }


  // 画面種別毎で起動処理を分ける
  switch (EnvironmentData().screenKind) {
    case ScreenKind.register:
    // 暫定でregisterと同じ動作でregister2を起動
    case ScreenKind.register2:
      // DBイニシャライズ→GetXService
      // https://github.com/jonataslaw/getx/blob/master/README.ja-JP.md
      // サービスクラスの初期化をawait
      await SysMain.startAppIniRegister();
      /// 多言語ラベルDB登録
      var languageImporter = LanguageLabelImporter();
      /// 失敗時はエラーログ出力
      if (!await languageImporter.execute()) {
        const errorMessage = "多言語ラベル取り込み処理が失敗しました。";
        if (kDebugMode) { print(errorMessage); }
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error, errorMessage);
      }
      runApp(const RegisterApp()); // キャッシャー側画面
      // 他画面起動処理.
      RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
      PosPsMonitoring.startIsolate(rootIsolateToken);

    case ScreenKind.customer:   // XGA客表
      await SysMain.startAppIniCustomer();
      runApp(const CustomerApp()); // お客様側画面

    case ScreenKind.customer_7_1 || ScreenKind.customer_7_2:    // 7inch客表
      await SysMain.startAppIniCustomer_7();
      runApp(const CustomerApp()); // お客様側画面
  }
}

/// 画面種別の設定
void setScreenKind(ScreenKind screenKind) {
  EnvironmentData().screenKind = screenKind;
  TprLog().outputIsolateName = screenKind.commandParameterName;
}

/// キャッシャー側/お客様側を判定 Linux/Windows用
void linuxWindowsJugement(List<String> args) {
  bool isDebug = false; // true:debug mode false:release mode
  // Linux/Windowsはコマンドラインからのパラメータ取得
  if (args.isEmpty) {
    // debugモード判定
    assert(isDebug = true);
    if (isDebug) {
      // debug時変更　register:キャッシャー側/customer:お客様側
      setScreenKind(ScreenKind.register);
    } else {
      setScreenKind(ScreenKind.register);
      String strMsg =
          'Relase Mode：パラメータが設定されずに起動されています。${ScreenKind.register.commandParameterName}を起動します。';
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, strMsg);
    }
  } else {
    setScreenKind(ScreenKind.values.byName(args[0]));
  }

  if (isCustomerDebug()) {
    // 強制的に客表画面にする.
    setScreenKind(ScreenKind.customer);
  }
}

/// Window_managerを呼び出す。
Future<void> windowManagerCall() async {
  /// 画面サイズおよびポジションの設定
// // Linuxの場合上部ステータスバーとアプリの上部タイトルバーをひかないと表示位置がずれる
//   double dblLinuxheight = 0;
//   if (GetPlatform.isLinux) {
//     dblLinuxheight = 27 +
//         47;
//   }

  /// 自身の画面情報の取得
  ScreenInfo screenInfo = EnvironmentData().getOwnScreenInfo();

  // 画面設定値（レジ/お客様）
  double dblPosition = screenInfo.position;
  double dblWidth = screenInfo.width;
  double dblHeight = screenInfo.height;
  debugPrint('*** $dblPosition , $dblWidth , $dblHeight ***');

  // 初期化
  // WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  // 画面サイズ指定
  WindowOptions windowOptions = WindowOptions(
    size: Size(dblWidth, dblHeight),
    center: false,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden, // コメントを外すと_■×が表示されなくなる
  );

  // 暫定処置（引き続き調査）//　待ちを入れないと指定位置に表示されない async/await による問題
  // await new Future.delayed(Duration(seconds: 1));
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  // 位置指定
  await windowManager.setPosition(Offset(dblPosition, 0));

// 画面サイズをMaxにする場合の指定
// // debugモード判定
// assert(isDebug = true);
// if (!isDebug) {
//   // releaseモードの場合画面を広げる（上部「_□x」の表示は？）
//   bool blnCurrent = await windowManager.isFullScreen();
//   await windowManager.setFullScreen(!blnCurrent);
// }
}

/// キャッシャー側/お客様側を判定 android用
Future<void> androidJugement() async {
  var rootPath;
  var file;
// android用ファイル
  var fileName1 = '${ScreenKind.register.commandParameterName}.txt';
  var fileName2 = '${ScreenKind.customer.commandParameterName}.txt';
// 「/data/user/0/com.example.flutter_pos/files/register.txt」
// パスの取得
  rootPath = Directory(EnvironmentData.TPRX_HOME);
  file = File('${rootPath.path.trim()}/$fileName1');
// register.txt が存在するか
  if (file.existsSync()) {
    setScreenKind(ScreenKind.register);
  } else {
// registerがない場合
    file = File('${rootPath.path.trim()}/$fileName2');
// customer.txt が存在するか
    if (file.existsSync()) {
      setScreenKind(ScreenKind.customer);
    } else {
      setScreenKind(ScreenKind.register);
      String strMsg =
          '$fileフォルダにファイルが存在しませんでした。${ScreenKind.register.commandParameterName}を起動します。';
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, strMsg);
    }
  }
// ステータスバーとナビゲーションバーを非表示にする（スワイプで表示される）
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

/// 客表画面の実装&確認用のデバッグ設定.
/// 「--dart-define=CUSTOMER=true」で客側画面起動
/// 引数　：なし
/// 戻り値：true  有効（客側画面）
///       false　無効（店員側状態）
bool isCustomerDebug() {
  // 最終的にdefaultValue は false とする。
  const isCustomerDebug =
  bool.fromEnvironment("CUSTOMER", defaultValue: false);
  return isCustomerDebug;
}
