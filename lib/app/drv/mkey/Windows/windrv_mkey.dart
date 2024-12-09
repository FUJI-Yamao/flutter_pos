/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/if/if_drv_control.dart';

import '../../ffi/library.dart';
import '../../ffi/windows/winffi_mkey.dart';
import '../../../inc/sys/tpr_type.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../inc/apl/rxmem_define.dart';

/// キーID     POSキー   PCキー
/// 0x00      0          0
/// 0x01      1          1
/// 0x02      2          2
/// 0x03      3          3
/// 0x04      4          4
/// 0x05      5          5
/// 0x06      6          6
/// 0x07      7          7
/// 0x08      8          8
/// 0x09      9          9
/// 0x0A      00         Dot
/// 0x0B      小計       RCtrl
/// 0x0C      現計       Enter
/// 0x0D      CLEAR     F20
/// 0x0E      ×          U
/// 0x0F      PLU        J
/// 0xFF      ナシ       Esc（デバッグ用）

/// プロトタイプ向け、メカキーとキーの対応用.
// 実機設定に合わせて52キータイプのコードに差し替えて、本体処理に送信する。
final List<String> MkeyTblWin52 = [
  "\x01\x12",    "\x01\x11",    "\x02\x11",    "\x03\x11",    "\x01\x10",  //   0   1   2   3   4
  "\x02\x10",    "\x03\x10",    "\x01\x09",    "\x02\x09",    "\x03\x09",  //   5   6   7   8   9
  "\x03\x12",    "\x01\x13",    "\x03\x13",    "\x01\x08",    "\x03\x08",  //  00 STL CASH CLR MUL
  "\x04\x12",    "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",  // PLU ___ ___ ___ ___
  "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",  // ___ ___ ___ ___ ___
  "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",  // ___ ___ ___ ___ ___
  "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",  // ___ ___ ___ ___ ___
  "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",  // ___ ___ ___ ___ ___
  "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",  // ___ ___ ___ ___ ___
  "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",  // ___ ___ ___ ___ ___
  "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",  // ___ ___ ___ ___ ___
  "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",  // ___ ___ ___ ___ ___
  "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",    "\x00\x00",  // ___ ___ ___ ___ ___
];

/// デバイスドライバ制御（Winメカキー）
///
///  関連tprxソース:
class WinDrvMkey {
  /// 戻り値
  static const OK_I = 0;
  static const NG_I = -1;
  static const OK_B = true;
  static const NG_B = false;

  /// デバイスID、タスクID
  TprDID myDid = 0;
  TprTID myTid = 0;
  int iDrvno = 0;

  static SendPort? _parentSendPort;

  static WinFFIMkey ffiMkey = WinFFIMkey();

  /// メカキーステート
  static bool isOpened = false;

  static bool isStroke = true;

  /// メイン処理
  ///
  /// 引数　：timer
  ///
  /// 戻り値：なし
  ///
  /// 関連tprxソース:基本的に既存コードのドライバのmain処理のwhileループ内の処理とします。
  ///
  /// 　⇒　回しっぱなしにするとプロセスが開放されないため、1処理毎にプロセスを開放する。
  Future<void> _onTimer(Timer timer) async {
    startKeyHook();
  }

  /// 初期化関数
  ///
  /// 引数:[tid] タスクID
  ///
  /// 戻り値：0 = Normal End
  ///
  ///      -1 = Error
  ///
  /// 関連tprxソース:基本的に既存コードのドライバのmain処理のwhileループまでの初期化処理とします。
  bool drv_init(SendPort parentSendPort, int tid) {
    /// タスクIDを取得する
    myTid = tid;
    iDrvno = (myTid >> bitShift_Tid) & 0x000000FF;
    _parentSendPort = parentSendPort;

    return OK_B;
  }

  /// ドライバ動作開始処理
  ///
  /// 引数：なし
  ///
  /// 戻り値：なし
  ///
  /// 関連tprxソース:既存コードのドライバのmain処理のwhileループに到達する場所に設置して下さい。
  Future<void> drv_start() async {
    await mkey_open();
    Timer.periodic(Duration(milliseconds: 10), (timer) => {_onTimer(timer)});
  }

  /// メカキーをオープンする関数
  static Future<void> mkey_open() async {
    // キーフック開始
    // 内部でループして返ってこないのでIsolateを立てる.
    if (!isWithoutDevice()) {
      Isolate.spawn(_mkey_start, ffiMkey);
    }
    isOpened = true;
    TprLog().logAdd(0, LogLevelDefine.normal, "Windows MKey open success.",);
  }

  /// メカキーをオープンするFFIを呼び出す.
  static void _mkey_start(WinFFIMkey key) {
    key.openMkey();
  }

  /// メカキーをクローズする関数
  static void mkey_close() {
    // キーフック終了
    ffiMkey.closeMkey();
    isOpened = false;
  }

  /// イベント受付スレッド
  static void startKeyHook() {
    if (!isOpened) {
      return;
    }
    // 監視ループ
    if (((1 == ffiMkey.getStrokeStat()) && isStroke) || (isWithoutDevice())) {
      String key = ffiMkey.getKey();
      if (!isOpened || "0xFF" == key) {
        isOpened = false;
        return;
      }
      if ("" == key) {
        return;
      }
      // key取得
      isStroke = false;
      RxInputBuf inp = RxInputBuf();
      inp.ctrl.ctrl = true;
      inp.devInf.devId = 1;
      inp.mecData = _mkeyKeyCodeEdit(key);
      TprLog().logAdd(0, LogLevelDefine.normal,
          "Windows Key Push input:$key)");
      if (inp.mecData != "") {
        _parentSendPort?.send(NotifyFromSIsolate(
            NotifyTypeFromSIsolate.mechaKeyCommand,
            inp)); // メインアプリのスレッドにinput情報を送信.
      }
    } else if (0 == ffiMkey.getStrokeStat()) {
      isStroke = true;
    }
  }

  /// プロトタイプ向け、メカキーとキーの対応用.
  static String _mkeyKeyCodeEdit(String keycode) {
    return MkeyTblWin52[int.parse(keycode)];
  }
}
