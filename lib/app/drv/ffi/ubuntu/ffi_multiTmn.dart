/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'dart:typed_data';
import 'dart:ffi';
import 'dart:ffi' as ffi;
import 'dart:io';
import '../library.dart';
import '../../../inc/lib/tmncat.dart';

/// OposDirectIOのレスポンスデータ
class TmnOposDirectIOResult {
  int result = 0;
  int data = 0;
  String bstr  = "";
}

/// CifGetEventのレスポンスデータ
class TmnCifGetEventResult {
   int    result = 0;
   int    errorResponse = 0;
   int    directIOEventNumber = 0;
   int    directIOData = 0;
   String directIOString  = "";
}

/// CifPropertyのレスポンスデータ
class TmnCifPropertyResult {
   int    result = 0;
   int    lng = 0;
   int    bol = 0;
   String bstr  = "";
}

/// 金額データ
class TmnCY {
   int     hi = 0;
   int     lo = 0;
}

/// OposAuthorizeのレスポンスデータ
class TmnOposAuthorizeResult {
   int    result = 0;
   TmnCY  amount = TmnCY();
   TmnCY  taxOthers = TmnCY();
}

class FFIMultiTmn {
  static int TMN_OK =  0;
  static int TMN_NG = -1;
  static int NORMAL_MODE = 0;
  static int TEST_MODE = 1;
  int _mode = 0;

  /// TMN システム呼び出しAPI初期化
  /// 引数:なし
  /// 戻り値： OPOS_SUCCESS         成功
  ///          OPOS_E_FFIINVALID    失敗
  int tmnApiInit(String path) {
      int ret = tmncat.OPOS_E_FFIINVALID;
      if (!Platform.isWindows) {
        final Pointer<Int> modePointer = calloc.allocate<Int>(1);
        final Pointer<Utf8> pathPointer = path.toNativeUtf8();

        try {
          // 外部関数（インターフェース）
          final int Function(Pointer<Utf8> pathPointer, Pointer<Int> modePointer) interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Int>)>>('TmnApiInit')
              .asFunction();

          // APIコール
          if (interface(pathPointer, modePointer) == TMN_OK) {
            ret = tmncat.OPOS_SUCCESS;
            _mode = modePointer.value;
          }
        } catch (e) {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnApiInit() -- $e");
          ret = tmncat.OPOS_E_FFIINVALID; // 異常終了
        } finally {
          calloc.free(pathPointer);
          calloc.free(modePointer);
        }
      } else {
        debugPrint("TMN システム " +
            "FFIMultiTmn.tmnApiInit() -- interface() WITHOUT_DEVICE実行");
        ret = tmncat.OPOS_SUCCESS;
      }
      return ret;
  }

  /// TMN システム呼び出しAPI準備確認
  /// 引数:なし
  /// 戻り値： OPOS_SUCCESS         完了
  ///          OPOS_E_FFIINVALID    未完了
  int tmnApiIsReady() {
      int ret = tmncat.OPOS_E_FFIINVALID;
      if (!Platform.isWindows) {
        try {
          // 外部関数（インターフェース）
          final int Function() interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function()>>('TmnApiIsReady')
              .asFunction();

          // APIコール
          if (interface() == TMN_OK) {
            ret = tmncat.OPOS_SUCCESS;
          }
        } catch (e) {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnApiIsReady() -- $e");
          ret = tmncat.OPOS_E_FFIINVALID; // 異常終了
        } finally {
        }
      } else {
        debugPrint("TMN システム " +
            "FFIMultiTmn.tmnApiIsReady() -- interface() WITHOUT_DEVICE実行");
        ret = tmncat.OPOS_SUCCESS;
      }
      return ret;
  }

  /// TMN システム利用開始時に呼び出す。
  /// 引数:なし
  /// 戻り値： OPOS_SUCCESS     成功。
  ///          OPOS_E_ILLEGAL   当該プロセス内で既にオープン済み。
  ///          OPOS_E_NOEXIST   DeviceName が不正。
  ///          OPOS_E_NOSERVICE 必要な TMN モジュール群が見つからない。
  ///          OPOS_E_EXTENDED  TMN エラーコードリストを参照してください。
  int tmnOposOpen() {
      int ret = tmncat.OPOS_E_FFIINVALID;

      try {
        // 外部関数（インターフェース）
        if ( (!Platform.isWindows && (_mode == NORMAL_MODE)) || (_mode == TEST_MODE) ) {
          final int Function() interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function()>>('TmnOposOpen')
              .asFunction();

          // APIコール
          ret = interface();
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposOpen() -- interface() WITHOUT_DEVICE実行");
          ret = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposOpen() -- $e");
        ret = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
      }
      return ret;
  }

  /// TMN システム利用終了時に呼び出す。
  /// 引数:なし
  /// 戻り値： OPOS_SUCCESS     成功。
  ///          OPOS_E_EXTENDED  123000001 成功だが、実行中要求のキャンセルに失敗
  ///                           他はTMN エラーコードリストを参照してください。
  int tmnOposClose() {
      int ret = tmncat.OPOS_E_FFIINVALID;

      try {
        // 外部関数（インターフェース）
        if ( (!Platform.isWindows && (_mode == NORMAL_MODE)) || (_mode == TEST_MODE) ) {
          final int Function() interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function()>>('TmnOposClose')
              .asFunction();

          // APIコール
          ret = interface();
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposClose() -- interface() WITHOUT_DEVICE実行");
          ret = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposClose() -- $e");
        ret = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
      }
      return ret;
  }

  /// TMN システムの使用権を獲得します。
  /// 引数:int timeout
  /// 戻り値： OPOS_SUCCESS    成功。
  ///          OPOS_E_CLOSED   オープンされていない。
  ///          OPOS_E_ILLEGAL  Timeout 値が不正。
  ///          OPOS_E_EXTENDED TMN エラーコードリストを参照してください。
  int tmnOposClaimDevice(int timeout) {
      int ret = tmncat.OPOS_E_FFIINVALID;

      try {
        // 外部関数（インターフェース）
        if ( (!Platform.isWindows && (_mode == NORMAL_MODE)) || (_mode == TEST_MODE) ) {
          final int Function(int timeout) interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function(Int32)>>('TmnOposClaimDevice')
              .asFunction();

          // APIコール
          ret = interface(timeout);
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposClaimDevice() -- interface() WITHOUT_DEVICE実行");
          ret = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposClaimDevice() -- $e");
        ret = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
      }
      return ret;
  }

  /// TMN システムの使用権を放棄します。
  /// 引数:なし
  /// 戻り値： OPOS_SUCCESS    成功。
  ///          OPOS_E_CLOSED   オープンされていない。
  ///          OPOS_E_ILLEGAL  アプリケーションは使用権を有していない。
  ///          OPOS_E_EXTENDED TMN エラーコードリストを参照してください。
  int tmnOposReleaseDevice() {
      int ret = tmncat.OPOS_E_FFIINVALID;

      try {
        // 外部関数（インターフェース）
        if ( (!Platform.isWindows && (_mode == NORMAL_MODE)) || (_mode == TEST_MODE) ) {
          final int Function() interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function()>>('TmnOposReleaseDevice')
              .asFunction();

          // APIコール
          ret = interface();
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposReleaseDevice() -- interface() WITHOUT_DEVICE実行");
          ret = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposReleaseDevice() -- $e");
        ret = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
      }
      return ret;
  }

  /// 自己診断の実行。
  /// 引数:int level
  /// 戻り値： OPOS_SUCCESS      成功。
  ///          OPOS_E_CLOSED     オープンされていない。
  ///          OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
  ///          OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
  ///          OPOS_E_ILLEGAL    Level 値が不正。
  ///          OPOS_E_BUSY       先に発行された要求が完了していない。
  ///          OPOS_E_EXTENDED   TMN エラーコードリストを参照してください。
  int tmnOposCheckHealth(int level) {
      int ret = tmncat.OPOS_E_FFIINVALID;

      try {
        // 外部関数（インターフェース）
        if ( !Platform.isWindows && (_mode == NORMAL_MODE) ) {
          final int Function(int level) interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function(Int32)>>('TmnOposCheckHealth')
              .asFunction();

          // APIコール
          ret = interface(level);
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposCheckHealth() -- interface() WITHOUT_DEVICE実行");
          ret = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposCheckHealth() -- $e");
        ret = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
      }
      return ret;
  }

  /// 非同期要求のキャンセル。
  /// 引数:なし
  /// 戻り値： OPOS_SUCCESS      成功。
  ///          OPOS_E_CLOSED     オープンされていない。
  ///          OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
  ///          OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
  ///          OPOS_E_ILLEGAL    キャンセル不可能な取引状態。
  ///          OPOS_E_BUSY       先に発行された要求が完了していない。
  ///          OPOS_E_EXTENDED   TMN エラーコードリストを参照してください
  int tmnOposClearOutput() {
      int ret = tmncat.OPOS_E_FFIINVALID;

      try {
        // 外部関数（インターフェース）
        if ( (!Platform.isWindows && (_mode == NORMAL_MODE)) || (_mode == TEST_MODE) ) {
          final int Function() interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function()>>('TmnOposClearOutput')
              .asFunction();

          // APIコール
          ret = interface();
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposClearOutput() -- interface() WITHOUT_DEVICE実行");
          ret = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposClearOutput() -- $e");
        ret = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
      }
      return ret;
  }

  /// コマンド番号により、様々な保守機能を実行。
  /// 引数:int command, int data, String stData
  /// 戻り値： OPOS_SUCCESS      成功。
  ///          OPOS_E_CLOSED     オープンされていない。
  ///          OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
  ///          OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
  ///          OPOS_E_ILLEGAL    パラメータ値が不正。
  ///          OPOS_E_BUSY       先に発行された要求が完了していない。
  ///          OPOS_E_EXTENDED   TMN エラーコードリストを参照してください。
  TmnOposDirectIOResult tmnOposDirectIO(int command, int data, String stData) {
      TmnOposDirectIOResult ret = TmnOposDirectIOResult();
      final Pointer<Utf8> stDataPointer = stData.toNativeUtf8();
      final Pointer<Int> dataPointer = calloc.allocate<Int>(1);
      dataPointer.value = data;
      try {
        // 外部関数（インターフェース）
        if ( (!Platform.isWindows && (_mode == NORMAL_MODE)) || (_mode == TEST_MODE) ) {
          final int Function(int command, Pointer<Int> dataPointer, Pointer<Utf8> stDataPointer) interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function(Int32, Pointer<Int>, Pointer<Utf8>)>>('TmnOposDirectIO')
              .asFunction();

          // APIコール
          ret.result = interface(command, dataPointer, stDataPointer);
          ret.data = dataPointer.value;
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposDirectIO() -- interface() WITHOUT_DEVICE実行");
          ret.result = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposDirectIO() -- $e");
        ret.result = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
        calloc.free(stDataPointer);
        calloc.free(dataPointer);
      }
      return ret;
  }

  /// イベントの取得
  /// 引数:なし
  /// 戻り値： OPOS_SUCCESS      成功。
  ///          OPOS_E_CLOSED     オープンされていない。
  ///          OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
  ///          OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
  ///          OPOS_E_ILLEGAL    パラメータ値が不正。
  ///          OPOS_E_BUSY       先に発行された要求が完了していない。
  ///          OPOS_E_EXTENDED   TMN エラーコードリストを参照してください。
  TmnCifGetEventResult tmnCifGetEvent() {

      TmnCifGetEventResult ret = TmnCifGetEventResult();
      final Pointer<Int> pErrorResponse = calloc.allocate<Int>(1);
      final Pointer<Int> pEventNumber = calloc.allocate<Int>(1);
      final Pointer<Int> pData = calloc.allocate<Int>(1);
      final Pointer<Utf8> pString = calloc.allocate<Utf8>(4096);
      try {
        // 外部関数（インターフェース）
        if ( (!Platform.isWindows && (_mode == NORMAL_MODE)) || (_mode == TEST_MODE) ) {
          final int Function(Pointer<Int> pErrorResponse, Pointer<Int> pEventNumber, Pointer<Int> pData, Pointer<Utf8> pString) interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function(Pointer<Int>, Pointer<Int>, Pointer<Int>, Pointer<Utf8>)>>('TmnCifGetEvent')
              .asFunction();

          // APIコール
          ret.result = interface(pErrorResponse, pEventNumber, pData, pString);
          ret.errorResponse = pErrorResponse.value;
          ret.directIOEventNumber = pEventNumber.value;
          ret.directIOData = pData.value;
          ret.directIOString = pString.toDartString();
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnCifGetEvent() -- interface() WITHOUT_DEVICE実行");
          ret.result = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnCifGetEvent() -- $e");
        ret.result = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
        calloc.free(pErrorResponse);
        calloc.free(pEventNumber);
        calloc.free(pData);
        calloc.free(pString);
      }
      return ret;
  }

  /// プロパティ値の取得
  /// 引数:int kind
  /// 戻り値： OPOS_SUCCESS      成功。
  ///          OPOS_E_CLOSED     オープンされていない。
  ///          OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
  ///          OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
  ///          OPOS_E_ILLEGAL    パラメータ値が不正。
  ///          OPOS_E_BUSY       先に発行された要求が完了していない。
  ///          OPOS_E_EXTENDED   TMN エラーコードリストを参照してください。
  TmnCifPropertyResult tmnCifGetProperty(int kind) {

      TmnCifPropertyResult ret = TmnCifPropertyResult();
      final Pointer<Int> plng = calloc.allocate<Int>(1);
      final Pointer<Int> pbol = calloc.allocate<Int>(1);
      final Pointer<Utf8> pbstr = calloc.allocate<Utf8>(4096);
      try {
        // 外部関数（インターフェース）
        if ( (!Platform.isWindows && (_mode == NORMAL_MODE)) || (_mode == TEST_MODE) ) {
          final int Function(int kind, Pointer<Int> plng, Pointer<Int> pbol, Pointer<Utf8> pbstr) interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function(Int32, Pointer<Int>, Pointer<Int>, Pointer<Utf8>)>>('TmnCifGetProperty')
              .asFunction();

          // APIコール
          ret.result = interface(kind, plng, pbol, pbstr);
          ret.lng = plng.value;
          ret.bol = pbol.value;
          ret.bstr += pbstr.toDartString();
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnCifGetProperty() -- interface() WITHOUT_DEVICE実行");
          ret.result = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnCifGetProperty() -- $e");
        ret.result = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
        calloc.free(plng);
        calloc.free(pbol);
        calloc.free(pbstr);
      }
      return ret;
  }

  /// プロパティ値の設定
  /// 引数:int kind, int lng, int bol, String bstr
  /// 戻り値： OPOS_SUCCESS      成功。
  ///          OPOS_E_CLOSED     オープンされていない。
  ///          OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
  ///          OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
  ///          OPOS_E_ILLEGAL    パラメータ値が不正。
  ///          OPOS_E_BUSY       先に発行された要求が完了していない。
  ///          OPOS_E_EXTENDED   TMN エラーコードリストを参照してください。
  int tmnCifSetProperty(int kind, int lng, int bol, String bstr) {

      int ret = tmncat.OPOS_E_FFIINVALID;
      final Pointer<Int> plng = calloc.allocate<Int>(1);
      final Pointer<Int> pbol = calloc.allocate<Int>(1);
      final Pointer<Utf8> pbstr = bstr.toNativeUtf8();
      plng.value = lng;
      pbol.value = bol;
      try {
        // 外部関数（インターフェース）
        if ( (!Platform.isWindows && (_mode == NORMAL_MODE)) || (_mode == TEST_MODE) ) {
          final int Function(int kind, Pointer<Int> plng, Pointer<Int> pbol, Pointer<Utf8> pbstr) interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function(Int32, Pointer<Int>, Pointer<Int>, Pointer<Utf8>)>>('TmnCifSetProperty')
              .asFunction();

          // APIコール
          ret = interface(kind, plng, pbol, pbstr);
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnCifSetProperty() -- interface() WITHOUT_DEVICE実行");
          ret = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnCifSetProperty() -- $e");
        ret = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
        calloc.free(plng);
        calloc.free(pbol);
        calloc.free(pbstr);
      }
      return ret;
  }

  /// 決済の実行
  /// 引数:int sequenceNumber, TmnCY amount, TmnCY taxOthers, int timeout
  /// 戻り値： OPOS_SUCCESS      成功。
  ///          OPOS_E_CLOSED     オープンされていない。
  ///          OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
  ///          OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
  ///          OPOS_E_ILLEGAL    Timeout 値が不正。
  ///          OPOS_E_BUSY       先に発行された要求が完了していない。
  ///          OPOS_E_EXTENDED   TMN エラーコードリストを参照してください
  TmnOposAuthorizeResult tmnOposAuthorizeSales(int sequenceNumber, TmnCY amount, TmnCY taxOthers, int timeout) {
      TmnOposAuthorizeResult ret = TmnOposAuthorizeResult();
      final Pointer<Int> pAmountHi = calloc.allocate<Int>(1);
      final Pointer<Int> pAmountLo = calloc.allocate<Int>(1);
      final Pointer<Int> pTaxOthersHi = calloc.allocate<Int>(1);
      final Pointer<Int> pTaxOthersLo = calloc.allocate<Int>(1);
      pAmountHi.value = amount.hi;
      pAmountLo.value = amount.lo;
      pTaxOthersHi.value = taxOthers.hi;
      pTaxOthersLo.value = taxOthers.lo;
      try {
        // 外部関数（インターフェース）
        if ( (!Platform.isWindows && (_mode == NORMAL_MODE)) || (_mode == TEST_MODE) ) {
          final int Function(int sequenceNumber, Pointer<Int> pAmountHi, Pointer<Int> pAmountLo, Pointer<Int> pTaxOthersHi, Pointer<Int> pTaxOthersLo, int timeout) interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function(Int32, Pointer<Int>, Pointer<Int>, Pointer<Int>, Pointer<Int>, Int32)>>('TmnOposAuthorizeSales')
              .asFunction();

          // APIコール
          ret.result = interface(sequenceNumber, pAmountHi, pAmountLo,pTaxOthersHi, pTaxOthersLo, timeout);
          ret.amount.hi = pAmountHi.value;
          ret.amount.lo = pAmountLo.value;
          ret.taxOthers.hi = pTaxOthersHi.value;
          ret.taxOthers.lo = pTaxOthersLo.value;
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposAuthorizeSales() -- interface() WITHOUT_DEVICE実行");
          ret.result = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposAuthorizeSales() -- $e");
        ret.result = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
        calloc.free(pAmountHi);
        calloc.free(pAmountLo);
        calloc.free(pTaxOthersHi);
        calloc.free(pTaxOthersLo);
      }
      return ret;
  }

  /// 決済の取消
  /// 引数:int sequenceNumber, TmnCY amount, TmnCY taxOthers, int timeout
  /// 戻り値： OPOS_SUCCESS      成功。
  ///          OPOS_E_CLOSED     オープンされていない。
  ///          OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
  ///          OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
  ///          OPOS_E_ILLEGAL    Timeout 値が不正。
  ///          OPOS_E_BUSY       先に発行された要求が完了していない。
  ///          OPOS_E_EXTENDED   TMN エラーコードリストを参照してください
  TmnOposAuthorizeResult tmnOposAuthorizeVoid(int sequenceNumber, TmnCY amount, TmnCY taxOthers, int timeout) {
      TmnOposAuthorizeResult ret = TmnOposAuthorizeResult();
      final Pointer<Int> pAmountHi = calloc.allocate<Int>(1);
      final Pointer<Int> pAmountLo = calloc.allocate<Int>(1);
      final Pointer<Int> pTaxOthersHi = calloc.allocate<Int>(1);
      final Pointer<Int> pTaxOthersLo = calloc.allocate<Int>(1);
      pAmountHi.value = amount.hi;
      pAmountLo.value = amount.lo;
      pTaxOthersHi.value = taxOthers.hi;
      pTaxOthersLo.value = taxOthers.lo;
      try {
        // 外部関数（インターフェース）
        if ( (!Platform.isWindows && (_mode == NORMAL_MODE)) || (_mode == TEST_MODE) ) {
          final int Function(int sequenceNumber, Pointer<Int> pAmountHi, Pointer<Int> pAmountLo, Pointer<Int> pTaxOthersHi, Pointer<Int> pTaxOthersLo, int timeout) interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function(Int32, Pointer<Int>, Pointer<Int>, Pointer<Int>, Pointer<Int>, Int32)>>('TmnOposAuthorizeVoid')
              .asFunction();

          // APIコール
          ret.result = interface(sequenceNumber, pAmountHi, pAmountLo,pTaxOthersHi, pTaxOthersLo, timeout);
          ret.amount.hi = pAmountHi.value;
          ret.amount.lo = pAmountLo.value;
          ret.taxOthers.hi = pTaxOthersHi.value;
          ret.taxOthers.lo = pTaxOthersLo.value;
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposAuthorizeVoid() -- interface() WITHOUT_DEVICE実行");
          ret.result = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposAuthorizeVoid() -- $e");
        ret.result = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
        calloc.free(pAmountHi);
        calloc.free(pAmountLo);
        calloc.free(pTaxOthersHi);
        calloc.free(pTaxOthersLo);
      }
      return ret;
  }

  /// 集計または中間系の実行
  /// 引数:int sequenceNumber, TmnCY amount, TmnCY taxOthers, int timeout
  /// 戻り値： OPOS_SUCCESS      成功。
  ///          OPOS_E_CLOSED     オープンされていない。
  ///          OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
  ///          OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
  ///          OPOS_E_ILLEGAL    Timeout 値が不正。
  ///          OPOS_E_BUSY       先に発行された要求が完了していない。
  ///          OPOS_E_EXTENDED   TMN エラーコードリストを参照してください。
  int tmnOposAccessDailyLog(int sequenceNumber, int type, int timeout) {
      int ret = tmncat.OPOS_E_FFIINVALID;
      try {
        // 外部関数（インターフェース）
        if ( (!Platform.isWindows && (_mode == NORMAL_MODE)) || (_mode == TEST_MODE) ) {
          final int Function(int sequenceNumber, int type, int timeout) interface = multiTmnDylib
              .lookup<NativeFunction<Int32 Function(Int32, Int32, Int32)>>('TmnOposAccessDailyLog')
              .asFunction();

          // APIコール
          ret = interface(sequenceNumber, type, timeout);
        } else {
          debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposAccessDailyLog() -- interface() WITHOUT_DEVICE実行");
          ret = tmncat.OPOS_SUCCESS; // 正常終了
        }
      } catch (e) {
        debugPrint("TMN システム " +
              "FFIMultiTmn.tmnOposAccessDailyLog() -- $e");
        ret = tmncat.OPOS_E_FFIINVALID; // 異常終了
      } finally {
      }
      return ret;
  }
}
