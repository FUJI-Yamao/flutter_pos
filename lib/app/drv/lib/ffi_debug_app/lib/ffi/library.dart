/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'dart:ffi' as ffi;
import 'dart:io' show Platform, Directory;

import 'package:path/path.dart' as path;

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
          '..',
          'Windows',
          'dist',
          'x64',
          'Release',
          'cash_drawer.dll'));
    }
    else {
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
      _mkeyDylib = ffi.DynamicLibrary.open(path.join(
          Directory.current.path,
          '..',
          'Windows',
          'dist',
          'x64',
          'Release',
          'mkey.dll'));
    }
    else {
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
      _scnDylib = ffi.DynamicLibrary.open(path.join(
          Directory.current.path,
          '..',
          'Windows',
          'dist',
          'x64',
          'Release',
          'scanner.dll'));
    }
    else {
      _scnDylib = ffi.DynamicLibrary.process();
    }
  } catch (err) {
    // エラー画面表示
  }

  return _scnDylib!;
}

// プリンタ
ffi.DynamicLibrary? _ptrDylib;
ffi.DynamicLibrary get ptrDylib {
  if (_ptrDylib != null) {
    return _ptrDylib!;
  }

  // 共有ライブラリの遅延読込み
  try {
    // リリースモード
    if (Platform.isWindows) {
      _ptrDylib = ffi.DynamicLibrary.open(path.join(
          Directory.current.path,
          '..',
          'Windows',
          'dist',
          'x64',
          'Release',
          'printer.dll'));
    }
    else {
      _ptrDylib = ffi.DynamicLibrary.process();
    }
  } catch (err) {
    // エラー画面表示
  }

  return _ptrDylib!;
}