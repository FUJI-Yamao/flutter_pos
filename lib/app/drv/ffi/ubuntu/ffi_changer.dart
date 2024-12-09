/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ffi';
import 'dart:ffi' as ffi;
import 'dart:io';

import '../library.dart';
import '../../../inc/sys/tpr_ipc.dart';
import '../../changer/tprdrv_changer.dart';

class changerffiRet {
  int result = 0;      // ドライバ実行結果（取得キー）
  int fds = 0;         // ファイルディスクリプタ
}

class changerffiReceiveResult {
    int result = 0;
    TprMsgDevNotify2_t msg = TprMsgDevNotify2_t();
}

class FFIChanger {

  /// 釣銭機ポートオープン
  /// 引数:[filePath] デバイス名
  ///      [selectType]釣銭機タイプ
  /// 戻り値：result： 0 : 正常終了／ -1 : 異常終了
  ///         fds   ：ファイルディスクリプタ
  changerffiRet changerPortOpen(String filePath, int selectType) {
      Pointer<Int> fds = calloc.allocate<Int>(4);
      final Pointer<Utf8> pathPointer = filePath.toNativeUtf8();
      changerffiRet ret = changerffiRet();
      try {
		//外部関数（インターフェース）
        if ( !isWithoutDevice() ) {
          final int Function(Pointer<Utf8> pathPointer, Pointer<Int> fds, int selectType) interface = changerDylib
            .lookup<NativeFunction<Int16 Function(Pointer<Utf8>, Pointer<Int>, Int)>>("ChangerPortOpen")
            .asFunction();
          //APIコール
          ret.result = interface(pathPointer, fds, selectType);
	        ret.fds = fds.value;
        } else {
          ret.fds = 123456;
          ret.result = 0; // 正常終了
          debugPrint(" changer " +
              "FFIChanger.changerPortOpen() -- interface() WITHOUT_DEVICE実行");
        }
      } catch (e) {
        ret.result = -1; // 異常終了
        ret.fds = 0;
      } finally {
        calloc.free(fds);
        calloc.free(pathPointer);
      }
      return ret;
    }

  /// 釣銭機ポートクローズ
  /// 引数:[fds] ファイルディスクリプタ
  /// 戻り値： 0 : 正常終了
  ///         -1 : 異常終了
  int changerPortClose(int fds) {
      late int ret;
      try {
		//外部関数（インターフェース）
        if ( !isWithoutDevice() ) {
          final int Function(int fds) interface = changerDylib
            .lookup<NativeFunction<Int16 Function(Int)>>("ChangerPortClose")
            .asFunction();

          //APIコール
          ret = interface(fds);
        } else {
          debugPrint(" changer " +
              "FFIChanger.changerPortClose() -- interface() WITHOUT_DEVICE実行");
          ret = 0; // 正常終了
        }
      } catch (e) {
        ret = -1; // 異常終了
      } finally {
      }
      return ret;
	}

  /// 釣銭機ポート初期化
  /// 引数:[fds] ファイルディスクリプタ
  ///      [baudRate] baudRate(1200,2400,4800,9600,19200,38400)
  ///      [dataBit] dataBit(7,8)
  ///      [stopBit] stopBit(1,2)
  ///      [parity] parity(0:NONE,1:EVEN,2:ODD)
  /// 戻り値： 0 : 正常終了
  ///         -1 : 異常終了
  int changerPortInit(int fds, int baudRate, int dataBit, int stopBit, int parity) {
      late int ret;
      try {
		//外部関数（インターフェース）
        if ( !isWithoutDevice() ) {
          final int Function(int fds, int baudRate, int dataBit, int stopBit, int parity) interface = changerDylib
            .lookup<NativeFunction<Int16 Function(Int, Int, Int, Int, Int)>>("ChangerPortInit")
            .asFunction();

          //APIコール
          ret = interface(fds, baudRate, dataBit, stopBit, parity);
         } else {
          debugPrint(" changer " +
              "FFIChanger.changerPortInit() -- interface() WITHOUT_DEVICE実行");
          ret = 0; // 正常終了
        }
      } catch (e) {
        ret = -1; // 異常終了
      } finally {
      }
      return ret;
	}

  /// 釣銭機データ送信
  /// 引数:[fds] ファイルディスクリプタ
  ///      [msg.mid] MID
  ///      [msg.tid] TID
  ///      [msg.src] ソースNo.
  ///      [msg.io] シーケンスNo.
  ///      [msg.datalen] 送信データ長
  ///      [msg.data] 送信データ
  /// 戻り値： 0 : 正常終了
  ///         -1 : 異常終了
  int changerDataSend(int fds, TprMsgDevReq2_t msg) {
      String buffer = "";
      for( int i=0;i<msg.datalen;i++) {
          buffer = buffer + msg.data[i];
      }
      Pointer<Utf8> sendData = buffer.toNativeUtf8();

      late int ret;
      int mid = msg.mid;
      int tid = msg.tid;
      int src = msg.src;
      int io = msg.io;
      int sndLength = msg.datalen;
      try {
		//外部関数（インターフェース）
        if ( !isWithoutDevice() ) {
          final int Function(int fds, Pointer<Utf8> sendData, int sndLength, int mid, int tid, int src, int io) interface = changerDylib
            .lookup<NativeFunction<Int16 Function(Int, Pointer<Utf8>, Int, Int, Int, Int, Int)>>("ChangerDataSend")
            .asFunction();

          //APIコール
          ret = interface(fds, sendData, sndLength, mid, tid, src, io);
        } else {
           debugPrint(" changer " +
              "FFIChanger.changerDataSend() -- interface() WITHOUT_DEVICE実行");
           ret = 0; // 正常終了
        }
      } catch (e) {
        ret = -1; // 異常終了
      } finally {
      }
      return ret;
    }

  /// 釣銭機データ受信
  /// 引数:[fds] ファイルディスクリプタ
  ///      [interval] 
  ///      [timeout] 
  /// 戻り値：[result]      0 : 正常終了/ -1 : 異常終了
  ///         [msg.mid]     送信時のMID
  ///         [msg.tid]     送信時のTID
  ///         [msg.src]     送信時のsrc
  ///         [msg.io]      送信時のio
  ///         [msg.result]  受信結果
  ///         [msg.datalen] 受信データ長
  ///         [msg.data]    受信データ
  changerffiReceiveResult changerDataReceive(int fds, int interval, int timeout) {
	  int i;
      changerffiReceiveResult ret = changerffiReceiveResult();
      Pointer<Utf8> rcvDataPointer = calloc.allocate<Utf8>(1024);
      Pointer<Int> rcvDataLenPointer = calloc.allocate<Int>(4);

      Pointer<Int> midPointer = calloc.allocate<Int>(4);
      Pointer<Int> tidPointer = calloc.allocate<Int>(4);
      Pointer<Int> srcPointer = calloc.allocate<Int>(4);
      Pointer<Int> ioPointer = calloc.allocate<Int>(4);
      Pointer<Int> resultPointer = calloc.allocate<Int>(4);
      try {
		//外部関数（インターフェース）
        if ( !isWithoutDevice() ) {
          final int Function(int fds, int interval, int timeout
                           , Pointer<Utf8> rcvDataPointer, Pointer<Int> rcvDataLenPointer
                           , Pointer<Int> midPointer, Pointer<Int> tidPointer, Pointer<Int> srcPointer
                           , Pointer<Int> ioPointer, Pointer<Int> resultPointer
                           ) interface = changerDylib
            .lookup<NativeFunction<Int16 Function(Int, Int, Int, Pointer<Utf8>, Pointer<Int>, Pointer<Int>, Pointer<Int>, Pointer<Int>, Pointer<Int>, Pointer<Int>)>>("ChangerDataReceive")
            .asFunction();

          //APIコール
          ret.result = interface(fds, interval, timeout, rcvDataPointer, rcvDataLenPointer, midPointer, tidPointer, srcPointer, ioPointer, resultPointer);
          ret.msg.mid = midPointer.value;
          ret.msg.tid = tidPointer.value;
          ret.msg.src = srcPointer.value;
          ret.msg.io = ioPointer.value;
          ret.msg.result = resultPointer.value;
          if (ret.result != TprDrvChanger.CHANGER_OK_I) {
            ret.msg.datalen = 0;
            for(i=0; i<ret.msg.data.length; i++) {
              ret.msg.data[i] = '\x30';
            }
          } else {
            ret.msg.datalen = rcvDataLenPointer.value;
            final tmpString = rcvDataPointer.toDartString();
            for(i=0; i<ret.msg.datalen; i++) {
              ret.msg.data[i] = tmpString[i];
            }
          }
        } else {
          debugPrint(" changer " +
              "FFIChanger.changerDataReceive() -- interface() WITHOUT_DEVICE実行");
          ret.result = 0; // 正常終了
          ret.msg.mid = 0;
          ret.msg.tid = 0;
          ret.msg.src = 0;
          ret.msg.io = 0;
          ret.msg.result = 0;
          for(i=0; i < ret.msg.data.length; i++) {
            ret.msg.data[i] = '\x30';
          }
          // ESC-777
          ret.msg.datalen = 38;
          ret.msg.data[ 0] = "\x32";  ret.msg.data[ 1] = "\x33";
          // // RT-300
          // ret.msg.datalen = 118;
          // ret.msg.data[ 0] = "\x32";  ret.msg.data[ 1] = "\x37";
        }
      } catch (e) {
        ret.result = -1; // 異常終了
      } finally {
        calloc.free(rcvDataPointer);
        calloc.free(rcvDataLenPointer);
        calloc.free(midPointer);
        calloc.free(tidPointer);
        calloc.free(srcPointer);
        calloc.free(ioPointer);
        calloc.free(resultPointer);
      }
      //print("changerDataReceive:${ret.msg.data.join()}");
      return ret;
    }
}
