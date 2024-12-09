/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pos/app/lib/if_th/utf2shift.dart';
import '../library.dart';

class PrintRet {
  int result = -1; // ドライバ実行結果
  List<String> readData = []; // Readデータ
  int readSize = 0; // Readしたサイズ
  int writeSize = 0; // Writeしたサイズ
  int status = -1; // ステータス
  int downLoadSize = 0; // FWダウンロードサイズ
  String downLoadData = ""; //FWダウンロードデータ
	int offBits = 0; // ビットマップデータ
	int width = 0; // ビットマップデータ
	int height = 0; // ビットマップデータ
	List<int> bitImageData = []; // ビットマップデータ
	int bitDataSize = 0; // ビットマップデータサイズ
}

class FFIPrinter {
  PrintRet ret = PrintRet();

	/// プリンタ―　オープンデバイス
  /// 引数:[path] ファイルディスクリプタのパス
  /// 戻り値：PrintRet
  ///         .result = 0  : Normal End
  ///         .result = -1 : Error End
  ///         ※上記以外は不定値
	PrintRet printerOpenDevice(String devicePath) {
		if (!isWithoutDevice()) {
			final Pointer<Utf8> pathPointer = devicePath.toNativeUtf8();
			try {
				//外部関数（インターフェース）
				final int Function(Pointer<Utf8> devicePath, bool debugMode) interface =
				printDylib
						.lookup<NativeFunction<Int16 Function(Pointer<Utf8>, Bool)>>(
						"PrinterPortOpen").asFunction();

				//APIコール
				ret.result = interface(pathPointer, kDebugMode);
			} catch(e) {
				//
			} finally {
				calloc.free(pathPointer);
			}
		} else {
			debugPrint("プリンタ オープンデバイス "
					"FFIPrinter.printerOpenDevice() -- interface() WITHOUT_DEVICE実行");
			ret.result = 0;
		}
		return ret;
	}

	/// プリンタ―　クローズデバイス
	/// 引数:なし
  /// 戻り値：PrintRet
  ///         .result = 0  : Normal End
  ///         .result = -1 : Error End
  ///         ※上記以外は不定値
	PrintRet printerCloseDevice() {
		if (!isWithoutDevice()) {
			//外部関数（インターフェース）
			final int Function() interface = printDylib
					.lookup<NativeFunction<Int16 Function()>>("PrinterPortClose").asFunction();
			//APIコール
			ret.result = interface();
		} else {
			debugPrint("プリンタ クローズデバイス "
					"FFIPrinter.printerCloseDevice() -- interface() WITHOUT_DEVICE実行");
			ret.result = 0;
		}
		return ret;
	}

  /// プリンタ―　ロゴ登録
  /// 引数: [index]  : 登録番号
  /// 　　　[path]   : BMPのファイルパス
  /// 戻り値：PrintRet
  ///         .result = 0  : Normal End
  ///         .result = -1 : Error End
  ///         ※上記以外は不定値
	PrintRet printerLogoWrite(int index, String filePath) {
		if (!isWithoutDevice()) {
			final Pointer<Utf8> logoPointer = filePath.toNativeUtf8();
			try {
				//外部関数（インターフェース）
				final int Function(int index, Pointer<
						Utf8> filePath) interface = printDylib
						.lookup<NativeFunction<Int16 Function(Int16, Pointer<Utf8>)>>(
						"PrinterLogoWrite").asFunction();
        //APIコール
				ret.result = interface(index, logoPointer);
			} catch(e) {
				//
			} finally {
				calloc.free(logoPointer);
			}
		} else {
			debugPrint("プリンタ ロゴライト "
					"FFIPrinter.printerLogoWrite() -- interface() WITHOUT_DEVICE実行");
			ret.result = 0;
		}
		return ret;
	}

	/// プリンタ―　書き込み（印字）
  /// 引数: [data]          : Writeデータ
  /// 　　　[writeDataSize] : Writeデータサイズ
  /// 戻り値：PrintRet
  ///         .result = 0  : Normal End
  ///         .result = -1 : Error End
  ///         .writeSize : Writeしたサイズ
  ///         ※上記以外は不定値
  PrintRet printerWriteDevice(String data, int dataSize) {
		int i;
    if (!isWithoutDevice()) {
			List<String> dataList = data.split("");

			Pointer<UnsignedChar> pData = malloc.allocate(dataSize);
      final Pointer<Int> pWriteSize = malloc.allocate(4);

			for (i = 0; i < dataSize; i++) {
				pData[i] = dataList[i].codeUnitAt(0);
			}
			try {
				//外部関数（インターフェース）
      final int Function(
              Pointer<UnsignedChar> pData, int writeDataSize, Pointer<Int> pWriteSize)
          interface = printDylib
              .lookup<
                  NativeFunction<
                      Int16 Function(Pointer<UnsignedChar>, Int,
                          Pointer<Int>)>>("PrinterWriteDevice")
						.asFunction();
				//APIコール
      	ret.result = interface(pData, dataSize, pWriteSize);
			} catch(e) {
				//
			} finally {
				ret.writeSize = pWriteSize.value;
				calloc.free(pData);
				calloc.free(pWriteSize);
			}
		} else {
			debugPrint("プリンタ ライトデバイス "
					"FFIPrinter.printerWriteDevice() -- interface() WITHOUT_DEVICE実行");
			ret.result = 0;
			ret.writeSize = dataSize;
		}
		return ret;
	}

	/// プリンタ―　ビットマップデータ取得
	/// 引数: [filePath]  : 登録番号
	/// 戻り値：PrintRet
	///         .result = 0  : Normal End
	///         .result = -1 : Error End
	///         .offBits
	///         .width
	///         .height
	///         ※上記以外は不定値
	PrintRet printerGetBmpImage(String filePath) {
		if (!isWithoutDevice()) {
			final Pointer<Utf8> logoPointer = filePath.toNativeUtf8();
			final Pointer<Int> pOffBits = malloc.allocate(4);
			final Pointer<Int> pWidth = malloc.allocate(4);
			final Pointer<Int> pHeight = malloc.allocate(4);
			try {
				//外部関数（インターフェース）
        final int Function(Pointer<Utf8> filePath, Pointer<Int> pOffBits, Pointer<Int> pWidth, Pointer<Int> pHeight) interface = printDylib
            .lookup<NativeFunction<Int16 Function(Pointer<Utf8>, Pointer<Int>, Pointer<Int>, Pointer<Int>)>>(
                "tprtss_get_bmpimage")
            .asFunction();
        //APIコール
				ret.result = interface(logoPointer, pOffBits, pWidth, pHeight);
			} catch(e) {
				//
			} finally {
				ret.offBits = pOffBits.value;
				ret.width = pWidth.value;
				ret.height = pHeight.value;
				calloc.free(logoPointer);
				calloc.free(pOffBits);
				calloc.free(pWidth);
				calloc.free(pHeight);
			}
		} else {
			debugPrint("プリンタ ビットマップデータ取得 "
					"FFIPrinter.printerGetBmpImage() -- interface() WITHOUT_DEVICE実行");
			ret.result = 0;
		}
		return ret;
	}

	/// プリンタ―　ビットマップイメージデータ取得
	/// 引数: [logoNo]  : 登録番号
	///      [filePath]   :
	///      [offBits]   :
	///      [width]   :
	///      [height]   :
	///      [lineByte]   :
	/// 戻り値：PrintRet
	///         .result = 0  : Normal End
	///         .result = -1 : Error End
	///         .bitImageData
	///         ※上記以外は不定値
	PrintRet printerGetBmpImageData(int logoNo, String filePath, int offBits, int width, int height, int lineByte) {
		if (!isWithoutDevice()) {
			final Pointer<Utf8> logoPointer = filePath.toNativeUtf8();
			final Pointer<UnsignedChar> pData = malloc.allocate(lineByte * height + 32);
			final Pointer<Int> pDataSize = malloc.allocate(4);
			try {
				//外部関数（インターフェース）
        final int Function(
                int logoNo,
                Pointer<Utf8> filePath,
                int offBits,
                int width,
                int height,
                int lineByte,
                Pointer<UnsignedChar> pData,
                Pointer<Int> pDataSize) interface =
            printDylib.lookup<NativeFunction<Int16 Function(
                            Int,
                            Pointer<Utf8>,
                            Int,
                            Int,
                            Int,
                            Int,
                            Pointer<UnsignedChar>,
                            Pointer<Int>)
						>>("tprtss_get_bmpimage_data").asFunction();
        //APIコール
				ret.result = interface(logoNo, logoPointer, offBits, width, height, lineByte, pData, pDataSize);
			} catch(e) {
				//
			} finally {
				ret.bitDataSize = pDataSize.value;
				ret.bitImageData.clear();
				for (int i = 0; i < pDataSize.value; i++) {
					ret.bitImageData.add(pData[i]);
				}
				calloc.free(logoPointer);
				calloc.free(pData);
				calloc.free(pDataSize);
			}
		} else {
			debugPrint("プリンタ ビットマップデータ取得 "
					"FFIPrinter.printerGetBmpImage() -- interface() WITHOUT_DEVICE実行");
			ret.result = 0;
		}
		return ret;
	}

	/// プリンタ―データのテキスト出力（デバッグ、および調査用）
	/// 引数: [data] : プリンタへの出力データ（コマンド（バイナリ）＋ 文字列データ（SJIS)
	/// 戻り値：なし
	/// 注：普通にファイル出力しても誤変換されてしまうため、コード変換してファイル出力する。
	void debugSjisDataTextOut(String data) {
		List<String> dataList1 = data.split("");
		List<String> dataList0 = List<String>.generate(data.length, (index) =>
				latin1.decode([dataList1[index].codeUnitAt(0)]));
		String sjisText = dataList0.join();
		Utf2Shift.textOutput(sjisText);
	}

	/// プリンタ―　読み込み
  /// 引数: [readBufSize] : 読み込みバッファサイズ
  /// 戻り値：PrintRet
  ///         .result = 0  : Normal End
  ///         .result = -1 : Error End
  ///         .readData : Readデータ
  ///         .readSize : Readしたサイズ
  ///         ※上記以外は不定値
  PrintRet printerReadDevice(int readBufSize) {
		if (!isWithoutDevice()) {
			final Pointer<UnsignedChar> pReadData = malloc.allocate(readBufSize);
			final Pointer<Int> pReadSize = malloc.allocate(4);

			try {
				//外部関数（インターフェース）
				final int Function(
								Pointer<UnsignedChar> pReadData, int readBufSize, Pointer<Int> readSize)
						interface = printDylib
								.lookup<
										NativeFunction<
												Int16 Function(Pointer<UnsignedChar>, Int,
														Pointer<Int>)>>("PrinterReadDevice")
								.asFunction();

				//APIコール
				ret.result = interface(pReadData, readBufSize, pReadSize);
			} catch(e) {
			//
			} finally {
				ret.readSize = pReadSize.value;
				ret.readData.clear();
				for (int i = 0; i < ret.readSize; i++) {
					ret.readData.add(pReadData[i].toString());
				}
				calloc.free(pReadData);
				calloc.free(pReadSize);
			}
		} else {
			// debugPrint("プリンタ リードデバイス "
			// 		"FFIPrinter.printerReadDevice() -- interface() WITHOUT_DEVICE実行");
			ret.result = 0;
		}
		return ret;
	}

	/// プリンタ―　ステータス取得
  /// 引数: [status]  : ステータス
  /// 戻り値：PrintRet
  ///         .result = 0  : Normal End
  ///         .result = -1 : Error End
  ///         .status : プリンタステータス
  ///         ※上記以外の変数は不定値
  PrintRet printerGetStatus() {
		if (!isWithoutDevice()) {
      Pointer<Int> pStatus = malloc.allocate(4);

      //外部関数（インターフェース）
      final int Function(Pointer<Int> pStatus) interface = printDylib
          .lookup<NativeFunction<Int16 Function(Pointer<Int>)>>(
              "PrinterGetStatus")
          .asFunction();

      //APIコール
      ret.result = interface(pStatus);
      ret.status = pStatus.value;
      calloc.free(pStatus);
		} else {
			// debugPrint("プリンタ ステータス取得 "
			// 		"FFIPrinter.printerGetStatus() -- interface() WITHOUT_DEVICE実行");
			ret.result = 0;
			ret.status = 0;
		}
		return ret;
	}

  /// プリンタ―　デバイスリセット
  /// 引数: なし
  /// 戻り値：PrintRet
  ///         .result = 0  : Normal End
  ///         .result = -1 : Error End
  ///         ※上記以外の変数は不定値
  PrintRet printerResetDevice() {
    if (!isWithoutDevice()) {
      //外部関数（インターフェース）
      final int Function() interface = printDylib
          .lookup<NativeFunction<Int16 Function()>>("PrinterResetDevice")
          .asFunction();

      //APIコール
      ret.result = interface();
		} else {
			debugPrint("プリンタ リセットデバイス "
					"FFIPrinter.printerResetDevice() -- interface() WITHOUT_DEVICE実行");
			ret.result = 0;
		}
		return ret;
	}

  /// プリンタ―　ダウンロードコマンド取得
  /// 引数: [filePath]：ダウンロードデータファイルのパス
  /// 戻り値：PrintRet
  ///         .result = 0  : Normal End
  ///         .result = -1 : Error End
  ///        String readData = ""; // ダウンロードデータ
  ///         ※上記以外の変数は不定値
  PrintRet printerDownload(String filePath) {
    if (!isWithoutDevice()) {
      final Pointer<Utf8> pPath = filePath.toNativeUtf8();
      //外部関数（インターフェース）
      final int Function(Pointer<Utf8> pPath) interface = printDylib
          .lookup<NativeFunction<Int16 Function(Pointer<Utf8>)>>("printerDownloadData")
          .asFunction();

      //APIコール
      ret.result = interface(pPath);
      calloc.free(pPath);
    } else {
      debugPrint(
          "プリンタ ダウンロードデータ取得 FFIPrinter.printerDownloadData() -- interface() WITHOUT_DEVICE実行");
      ret.result = 0; // 正常終了
    }
    return ret;
  }
}
