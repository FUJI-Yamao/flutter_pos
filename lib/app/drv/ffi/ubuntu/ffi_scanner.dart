/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../ffi_access_test.dart';
import '../library.dart';

class ScanRet {
	int result = 0;        // ドライバ実行結果（取得キー）
	int fds = 0;           // ファイルディスクリプタの番号
	String scanData = "";  // スキャンデータ
}

class FFIScanner {
	Pointer<Int> pfds = malloc.allocate<Int>(4);
	int pos = 0;
	int pos0 = 0;
	String data = "";
	String testBarcode = "";
	static String preDt = "2023-01-01 00:00:00.000000";  // debug用

	/// スキャナー　ポートオープン
	/// 引数:[filePath] ファイルディスクリプタのパス
	/// 戻り値：ScanRet
	///         .result = 0  : Normal End
	///         .result = -1 : Error End
	///         .fds : ファイルディスクリプタの番号
	///         .scanData = "" : 空白で返す。
	ScanRet scannerPortOpen(String filePath) {
		ScanRet ret = ScanRet();

		if (!isWithoutDevice()) {
			final Pointer<Utf8> pathPointer = filePath.toNativeUtf8();
			try {
				//外部関数（インターフェース）
				final int Function(Pointer<Utf8> pathName, Pointer<Int> fds)
				interface = scnDylib.lookup<NativeFunction<
						Int16 Function(Pointer<Utf8>, Pointer<Int>)>>(
						"ScanPortOpen").asFunction();

				//APIコール
				ret.result = interface(pathPointer, pfds);
				ret.fds = pfds.value;
				ret.scanData = "";
				debugPrint("ScanPortOpen" +
						" pfds.value:" + pfds.value.toString() +
						" pfds.address:" + pfds.address.toString() +
						" pathPointer:" + pathPointer.toDartString());
			} catch(e) {
				ret.result = -1; // 異常終了
				ret.fds = 0;
				ret.scanData = "";
			} finally {
				calloc.free(pathPointer);
			}
		} else {
			ret.result = 0; // 正常終了
			ret.fds = 123456789;
			ret.scanData = "";
			debugPrint("スキャナー ポートオープン" +
					" fds=" + ret.fds.toString() +
					" pfds=" + pfds.address.toString() +
					" FFIScanner.scannerPortOpen() -- interface() WITHOUT_DEVICE実行");
		}
		return ret;
	}

	/// スキャナー　ポートクローズ
	/// 引数:[fds]　ファイルディスクリプタの番号
	/// 戻り値：0  : Normal End
	///       -1 : Error End
	int scannerPortClose(int fds) {
		late int ret;
		if (!isWithoutDevice()) {
			//外部関数（インターフェース）
			final int Function(int fds) interface = scnDylib
					.lookup<NativeFunction<Int16 Function(Int)>>("ScanPortClose")
					.asFunction();

			//APIコール
			ret = interface(fds);
		} else {
			debugPrint("スキャナー ポートクローズ" +
					" FFIScanner.scannerPortClose() -- interface() WITHOUT_DEVICE実行");
			ret = 0; // 正常終了
		}
		return ret;
	}

	/// スキャナー　ポート初期化
	/// 引数:[fds]　ファイルディスクリプタの番号
	///     [baudRate] ボーレート
	///     [dataBit] データビット数
	///     [stopBit] ストップビット数
	/// 戻り値：ScanRet
	///         .result = 0  : Normal End
	///         .result = -1 : Error End
	///         .fds : ドライバで取得したファイル名
	///         .scanData = "" : 空白を返す。
	int scannerPortInit(int fds, int baudRate, int dataBit, int stopBit) {
		late int ret;
		if (!isWithoutDevice()) {
			//外部関数（インターフェース）
			final int Function(int fds, int baudRate, int dataBit, int stopBit) interface = scnDylib
					.lookup<NativeFunction<Int16 Function(Int, Int, Int, Int)>>(
					"ScanPortInit")
					.asFunction();

			//APIコール
			ret = interface(fds, baudRate, dataBit, stopBit);
		} else {
			debugPrint("スキャナー ポート初期化" +
					" fds=" + fds.toString() +
					" rate=" + baudRate.toString() +
					" bit=" + dataBit.toString() +
					" stop=" + stopBit.toString() +
					" FFIScanner.scannerPortInit() -- interface() WITHOUT_DEVICE実行");
			ret = 0; // 正常終了
		}
		return ret;
	}

	// int scannerEnable(int fds) {
	// 	late int ret;
	// 	if (!isWithoutDevice()) {
	// 		//外部関数（インターフェース）
	// 		final int Function(int fds) interface = scnDylib
	// 				.lookup<NativeFunction<Int16 Function(Int)>>("ScanEnable")
	// 				.asFunction();
	//
	// 		//APIコール
	// 		ret = interface(fds);
	// 	} else {
	//
	// 	}
	//   return ret;
	// }

	// int scannerDisable(int fds) {
	// 	late int ret;
	// 	if (!isWithoutDevice()) {
	// 		//外部関数（インターフェース）
	// 		final int Function(int fds) interface = scnDylib
	// 				.lookup<NativeFunction<Int16 Function(Int)>>("ScanDisable")
	// 				.asFunction();
	//
	// 		ret = interface(fds);
	// 	} else {
	//
	// 	}
	// 	return ret;
	// }

	/// スキャナー　データ受信
	///　引数:[fds]　ファイルディスクリプタの番号
	///     [filePath] ファイルディスクリプタのパス
	/// 戻り値：ScanRet
	///         .result = 0  : Normal End
	///         .result = -1 : Error End
	///         .fds = null :  特にセットしない（失敗時は0セット）
	///         .scanData : スキャナー受信データ。
	ScanRet scannerDataRcv(int fds, String filePath) {

		int rcvSize = 1;
		ScanRet ret = ScanRet();

		if (!isWithoutDevice() && (testBarcode == "") && (data == "")) {
			Pointer<Uint8> rcvData = malloc.allocate<Uint8>(rcvSize);
			final Pointer<Utf8> pathPointer = filePath.toNativeUtf8();
			pfds.value = fds;
			try {
				//外部関数（インターフェース）
				final int Function(Pointer<Int> fds, Pointer<Utf8> filePath, Pointer<
						Uint8> rcvData, int rcvSize) interface = scnDylib
						.lookup<NativeFunction<
						Int16 Function(Pointer<Int>, Pointer<Utf8>, Pointer<Uint8>, Int)>>(
						"ScanDataRcv").asFunction();
				rcvData.value = 0;
				ret.result = interface(pfds, pathPointer, rcvData, rcvSize);

				List<int> temp = [rcvData.value];
				try{
					ret.scanData = ascii.decode(temp);
				}catch(e){
					ret.scanData = "";
				}
				ret.fds = pfds.value;
			} catch(e) {
				ret.result = -1; // 異常終了
				ret.fds = 0;
				ret.scanData = "";
			} finally {
				calloc.free(rcvData);
				calloc.free(pathPointer);
			}
		} else {
			// 確認したいバーコードデータをdata0にセットして、実行（リロード）して下さい。
			// バーコード入力の間隔はintervalで調整できます。
			// また、アイソレート通信でバーコードデータをアプリ側から送信可能としました。
			// 　⇒IfDrvControl().scanIsolateCtrl.barcodeLoopbackIn("F4902102076395" + "\x0D");

			String data0 = "";
			// data0 = "A856102000253" + "\x0D" + "F4946842501908" + "\x0D" + "A856102000260" + "\x0D";  // MINTIA ワイルド
			// data0 = "A856102000253" + "\x0D" + "F4902102107648" + "\x0D" + "A856102000260" + "\x0D";  // 綾鷹
			// data0 = "A856102000253" + "\x0D" + "F4902102141109" + "\x0D" + "A856102000260" + "\x0D";  // コーラ
			// data0 = "A856102000253" + "\x0D" + "F4902102076395" + "\x0D" + "A856102000260" + "\x0D";  // ファンタ　オレンジ
			// data0 =                            "F2700009999999" + "\x0D"                           ;  // 従業員バーコード

			final interval = 5; // (sec)
			if (data0 != "") {
				DateTime dt = DateTime.now();
				final dt0 = DateTime.parse(preDt);
				if (dt.difference(dt0).inSeconds > interval) {
					data = data0;
					data0 = "";
					preDt = dt.toString();
				}
			}
			if (testBarcode != "") {
				data = testBarcode;
				testBarcode = "";
			}

			if ((pos + 1) <= data.length) {
				ret.scanData = data.substring(pos, pos + 1);
			} else {
				ret.scanData = "";
			}
			if (data != "") {
				pos++;
				if ((pos > (data.length)) && (data.length != 0)) {
					debugPrint("スキャナー データ受信" +
							" data:" + data.replaceAll("\x0D", "/") +
							" fds:" + fds.toString() +
							" pfds:" + pfds.address.toString() +
							" filePath:" + filePath +
							"  FFIScanner.scannerDataRcv() -- interface() WITHOUT_DEVICE実行");
					pos = 0;
					data = "";
				}
			} else {
				pos = 0;
			}
			ret.result = 0;
			ret.fds = fds;
		}
		return ret;
	}

	/// スキャナー　データ送信（コマンド送信）
	/// （デバイスドライバ未対応のため、暫定記載）
	/// 引数:[fds]　デバイスファイル名
	///     [filePath] デバイスファイルのパス
	///     [sendMsg]　送信メッセージ
	///     [sndSize]　送信メッセージのサイズ
	/// 戻り値：ScanRet
	///         .result = 0  : Normal End
	///         .result = -1 : Error End
	///         .fds = null :  特にセットしない（失敗時は0セット）
	///         .scanData = null : 特にセットしない（失敗時は""セット）
	ScanRet scannerDataSnd(int fds, String filePath, String sendMsg, int sndSize) {

		ScanRet ret = ScanRet();

		if (!isWithoutDevice()) {
			Pointer<Uint8> psendMsg = malloc.allocate<Uint8>(sndSize);
			final Pointer<Utf8> pathPointer = filePath.toNativeUtf8();
			pfds.value = fds;
			for (int i = 0; i < sndSize; i++){
				psendMsg[i] = sendMsg.codeUnitAt(i);
			}
			try {
				//外部関数（インターフェース）
				/* TODO:ScanDataSnd未実装のためコメントアウト。実装後はdebugPrintは削除
				final int Function(
								Pointer<Int> fds, Pointer<Utf8> filePath, Pointer<Uint8> sndData, int sndSize) interface = scnDylib
						.lookup<NativeFunction<Int16 Function(
								Pointer<Int>, Pointer<Utf8>, Pointer<Uint8>, Int)>>(
						"ScanDataSnd").asFunction();

				ret.result = interface(pfds, pathPointer, psendMsg, sndSize);
				 */
				debugPrint("スキャナー データ送信" +
						" sndData:" + sendMsg +
						" fds:" + fds.toString() +
						" filePath:" + filePath +
						"  FFIScanner.scannerDataSnd() -- interface()");
				ret.result = 0;
				ret.fds = fds;
			} catch(e) {
				ret.result = -1; // 異常終了
				ret.fds = 0;
				ret.scanData = "";
				//
			} finally {
				calloc.free(pathPointer);
				calloc.free(psendMsg);
			}
		} else {
			String temp = "";
			for (int i = 0; i < sndSize; i++){
				temp += sendMsg.codeUnitAt(i).toRadixString(16).padLeft(2,"0");
			}
			ret.result = 0;
			debugPrint("スキャナー データ送信" +
					" sndData:" + temp +
					" fds:" + fds.toString() +
					" filePath:" + filePath +
					"  FFIScanner.scannerDataSnd() -- interface() WITHOUT_DEVICE実行");
		}
		return ret;
	}
}
