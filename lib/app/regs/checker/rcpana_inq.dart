/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';

///  関連tprxソース: rcpana_inq.c
class RcPanaInq {
  /// 照会受信データをJISからUTF8に変換する（CardCrewにて使用の為コンパイルフラグの外に移動）
  /// 引数:[jis] 変換前文字列（JISコード）
  /// 戻値: UTF8コード文字列
  ///  関連tprxソース: rcpana_inq.c - rcPana_Inq_Rcvdata_Cnv
  static Future<String> rcPanaIncRcvdataCnv(String jis) async {
    // 引数StringをUint8Listに変換
    Uint8List utf8List = await CharsetConverter.encode('sjis', jis);
    return await CharsetConverter.decode('sjis', Uint8List.fromList(utf8List));
  }
}