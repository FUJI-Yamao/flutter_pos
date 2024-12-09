/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:ffi/ffi.dart';
import 'dart:ffi';
import 'dart:ffi' as ffi;
import '../library.dart';

class WinFFIPrinter {
  // イベント受付オープン
  int openPtrEvent(Pointer<Utf8> filePath) {
    // 外部関数（インターフェース）
    final int Function(Pointer<Utf8> filePath) interface = ptrDylib
        .lookup<NativeFunction<Int16 Function(Pointer<Utf8>)>>('OpenPtrEvent')
        .asFunction();

    // APIコール
    int ret = interface(filePath);

    return ret;   // 0：成功, -1：失敗
  }

  // イベント受付クローズ
  int closePtrEvent() {
    // 外部関数（インターフェース）
    final int Function() interface = ptrDylib
        .lookup<NativeFunction<Int16 Function()>>('ClosePtrEvent')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;   // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  // レシートロゴ登録
  int regLogo(Pointer<Utf8> filePath) {
    // 外部関数（インターフェース）
    final int Function(Pointer<Utf8> filePath) interface = ptrDylib
        .lookup<NativeFunction<Int16 Function(Pointer<Utf8>)>>('RegLogo')
        .asFunction();

    // APIコール
    int ret = interface(filePath);

    return ret;   // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  // レシート出力
  int outRec(Pointer<Utf16> textData, Pointer<Utf16> bcData) {
    // 外部関数（インターフェース）
    final int Function(Pointer<Utf16> textData, Pointer<Utf16> bcData) interface = ptrDylib
        .lookup<NativeFunction<Int16 Function(Pointer<Utf16>, Pointer<Utf16>)>>('OutRec')
        .asFunction();

    // APIコール
    int ret = interface(textData, bcData);

    return ret;   // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  // プリンタカバー開閉状態問合せ
  int inqStatCover() {
    // 外部関数（インターフェース）
    final int Function() interface = ptrDylib
        .lookup<NativeFunction<Int16 Function()>>('InqStatCover')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;   // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  // レシート用紙有無状態問合せ
  int inqStatPaper() {
    // 外部関数（インターフェース）
    final int Function() interface = ptrDylib
        .lookup<NativeFunction<Int16 Function()>>('InqStatPaper')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;   // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  // プリンタカバー開閉状態取得
  int getStatCover() {
    // 外部関数（インターフェース）
    final int Function() interface = ptrDylib
        .lookup<NativeFunction<Int16 Function()>>('GetStatCover')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;   // 0：カバー開, 1：カバー閉, else -1：ステータスエラー（非接続状態）
  }

  // レシート用紙有無状態取得
  int getStatPaper() {
    // 外部関数（インターフェース）
    final int Function() interface = ptrDylib
        .lookup<NativeFunction<Int16 Function()>>('GetStatPaper')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;   // 0：レシート用紙無し, 1：レシート用紙有り, else -1：ステータスエラー（非接続状態）
  }

  // イベントカウンタ取得
  int getPtrCntRef() {
    // 外部関数（インターフェース）
    final int Function() interface = ptrDylib
        .lookup<NativeFunction<Int16 Function()>>('GetPtrCntRef')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;
  }

  // イベント待機リセット
  void releasePtr() {
    // 外部関数（インターフェース）
    final void Function() interface = ptrDylib
        .lookup<NativeFunction<Void Function()>>('ReleasePtr')
        .asFunction();

    // APIコール
    interface();
  }
}