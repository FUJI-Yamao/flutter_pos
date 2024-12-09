/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ffi' as ffi;
import 'dart:io' show Platform, Directory;

import 'package:path/path.dart' as path;

const String _drvDir = 'lib/app/drv';

// ドロア
ffi.DynamicLibrary? _drwDylib;
ffi.DynamicLibrary get drwDylib {
  if (_drwDylib != null) {
    return _drwDylib!;
  }

  // 共有ライブラリの遅延読込み
  try {
    // リリースモード
    if (Platform.isWindows) {
      _drwDylib = ffi.DynamicLibrary.open(path.join(
          Directory.current.path,
          _drvDir,
          'lib',
          'Windows',
          'dist',
          'x64',
          'Release',
          'cash_drawer.dll'));
    } else if (Platform.isLinux) {
      _drwDylib = ffi.DynamicLibrary.open(path.join(Directory.current.path,
          _drvDir, 'lib', 'Ubuntu', 'libcash_drawer.so.1.0.0'));
    } else {
      _drwDylib = ffi.DynamicLibrary.process();
    }
  } catch (err) {
    // エラー画面表示
  }

  return _drwDylib!;
}

// メカキー
ffi.DynamicLibrary? _mkeyDylib;
ffi.DynamicLibrary get mkeyDylib {
  if (_mkeyDylib != null) {
    return _mkeyDylib!;
  }

  // 共有ライブラリの遅延読込み
  try {
    // リリースモード
    if (Platform.isWindows) {
      _mkeyDylib = ffi.DynamicLibrary.open(path.join(Directory.current.path,
          _drvDir, 'lib', 'Windows', 'dist', 'x64', 'Release', 'mkey.dll'));
    } else if (Platform.isLinux) {
      _mkeyDylib = ffi.DynamicLibrary.open(path.join(Directory.current.path,
          _drvDir, 'lib', 'Ubuntu', 'libmkey.so.1.0.0'));
    } else {
      _mkeyDylib = ffi.DynamicLibrary.process();
    }
  } catch (err) {
    // エラー画面表示
  }

  return _mkeyDylib!;
}

// スキャナ
ffi.DynamicLibrary? _scnDylib;
ffi.DynamicLibrary get scnDylib {
  if (_scnDylib != null) {
    return _scnDylib!;
  }

  // 共有ライブラリの遅延読込み
  try {
    // リリースモード
    if (Platform.isWindows) {
      _scnDylib = ffi.DynamicLibrary.open(path.join(Directory.current.path,
          _drvDir, 'lib', 'Windows', 'dist', 'x64', 'Release', 'scanner.dll'));
    } else if (Platform.isLinux) {
      _scnDylib = ffi.DynamicLibrary.open(path.join(Directory.current.path,
          _drvDir, 'lib', 'Ubuntu', 'libscanner.so.1.0.0'));
    } else {
      _scnDylib = ffi.DynamicLibrary.process();
    }
  } catch (err) {
    // エラー画面表示
  }

  return _scnDylib!;
}

// プリンタ
ffi.DynamicLibrary? _printDylib;
ffi.DynamicLibrary get printDylib {
  if (_printDylib != null) {
    return _printDylib!;
  }

  // 共有ライブラリの遅延読込み
  try {
    // リリースモード
    if (Platform.isWindows) {
      _printDylib = ffi.DynamicLibrary.open(path.join(Directory.current.path,
          _drvDir, 'lib', 'Windows', 'dist', 'x64', 'Release', 'printer.dll'));
    } else if (Platform.isLinux) {
      _printDylib = ffi.DynamicLibrary.open(path.join(Directory.current.path,
          _drvDir, 'lib', 'Ubuntu', 'libprinter.so.1.0.0'));
    } else {
      _printDylib = ffi.DynamicLibrary.process();
    }
  } catch (err) {
    // エラー画面表示
  }

  return _printDylib!;
}

// UPS Plus
ffi.DynamicLibrary? _upsPlusDylib;
ffi.DynamicLibrary get upsPlusDylib {
  if (_upsPlusDylib != null) {
    return _upsPlusDylib!;
  }

  // 共有ライブラリの遅延読込み
  try {
    // リリースモード
    if (Platform.isLinux) {
      _upsPlusDylib = ffi.DynamicLibrary.open(path.join(Directory.current.path,
          _drvDir, 'lib', 'Ubuntu', 'libUpsPlusAPI.so'));
    } else {
      _upsPlusDylib = ffi.DynamicLibrary.process();
    }
  } catch (err) {
    // エラー画面表示
  }

  return _upsPlusDylib!;
}

// TMN システム
ffi.DynamicLibrary? _multiTmnDylib;
ffi.DynamicLibrary get multiTmnDylib {
  if (_multiTmnDylib != null) {
    return _multiTmnDylib!;
  }

  // 共有ライブラリの遅延読込み
  try {
    // リリースモード
    if (Platform.isLinux) {
      _multiTmnDylib = ffi.DynamicLibrary.open(path.join(Directory.current.path,
          _drvDir, 'lib', 'Ubuntu', 'libMultiTmnAPI.so'));
    } else {
      _multiTmnDylib = ffi.DynamicLibrary.process();
    }
  } catch (err) {
    // エラー画面表示
  }

  return _multiTmnDylib!;
}

// 釣銭機
ffi.DynamicLibrary? _changerDylib;
ffi.DynamicLibrary get changerDylib {
  if (_changerDylib != null) {
    return _changerDylib!;
  }

  // 共有ライブラリの遅延読込み
  try {
    // リリースモード
    if (Platform.isLinux) {
      _changerDylib = ffi.DynamicLibrary.open(path.join(Directory.current.path,
          _drvDir, 'lib', 'Ubuntu', 'libChangerAPI.so'));
    } else {
      _changerDylib = ffi.DynamicLibrary.process();
    }
  } catch (err) {
    // エラー画面表示
  }

  return _changerDylib!;
}

// VEGA3000
ffi.DynamicLibrary? _vega3000Dylib;
ffi.DynamicLibrary get vega3000Dylib {
  if (_vega3000Dylib != null) {
    return _vega3000Dylib!;
  }

  // 共有ライブラリの遅延読込み
  try {
    // リリースモード
    if (Platform.isLinux) {
      _vega3000Dylib = ffi.DynamicLibrary.open(path.join(Directory.current.path,
          _drvDir, 'lib', 'Ubuntu', 'libPlusPosConnector.so.1.0.0'));
    } else {
      _vega3000Dylib = ffi.DynamicLibrary.process();
    }
  } catch (err) {
    // エラー画面表示
  }

  return _vega3000Dylib!;
}

// ***************************
// Windows環境でのLinuxデバッグを実行する
// Configurationの「Additional run arg」（Additional arg）で
// 「--dart-define=LINUX_DEBUG_BY_WIN=***」が設定されている場合はそれに従う。
// 引数　：なし
// 戻り値：true  有効
//       false　無効（通常状態）
// ***************************
bool isLinuxDebugByWin() {
  bool isLinuxDebugByWin = false;
  const debug = bool.fromEnvironment("LINUX_DEBUG_BY_WIN", defaultValue: false);
  if ((Platform.isWindows) && (debug == true)) {
    isLinuxDebugByWin = true;
  }
  return isLinuxDebugByWin;
}

// ***************************
// デバイス非接続での動作設定
// Configurationの「Additional run arg」（Additional arg）で
// 「--dart-define=WITHOUT_DEVICE=***」が設定されている場合はそれに従う。
// 引数　：なし
// 戻り値：true  有効（デバイス無し状態）
//       false　無効（通常状態）
// ***************************
bool isWithoutDevice() {
  const isWithoutDevice =
  bool.fromEnvironment("WITHOUT_DEVICE", defaultValue: false);
  return isWithoutDevice;
}

// ***************************
// ドロア非接続での動作設定
// Configurationの「Additional run arg」（Additional arg）で
// 「--dart-define=WITHOUT_DRAWER=***」が設定されている場合はそれに従う。
// 引数　：なし
// 戻り値：true  有効（ドロア無し状態）
//       false　無効（通常状態）
// ***************************
bool isWithoutDrawer() {
  const isWithoutDrawer =
  bool.fromEnvironment("WITHOUT_DRAWER", defaultValue: false);
  return isWithoutDrawer;
}

// ***************************
// 釣銭機模擬応答
// Configurationの「Additional run arg」（Additional arg）で
// 「--dart-define=DUMMY_ACX=***」が設定されている場合はそれに従う。
// 引数　：なし
// 戻り値：true  有効（釣銭釣札機無し状態で模擬応答させる）
//       false　無効（通常状態）
// ***************************
bool isDummyAcx() {
  const isDummyAcx =
  bool.fromEnvironment("DUMMY_ACX", defaultValue: false);
  return isDummyAcx;
}

// ***************************
// QC指定ボタン強制有効（休止中にしない）
// Configurationの「Additional run arg」（Additional arg）で
// 「--dart-define=FORCE_VALID_QC=***」が設定されている場合はそれに従う。
// 引数　：なし
// 戻り値：true  有効（QC指定ボタン強制有効）
//       false　無効（通常状態）
// ***************************
bool isForceValidQc() {
  const isDummyAcx =
  bool.fromEnvironment("FORCE_VALID_QC", defaultValue: false);
  return isDummyAcx;
}
