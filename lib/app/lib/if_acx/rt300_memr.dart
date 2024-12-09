/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:convert';

import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import 'package:flutter_pos/app/inc/lib/acx_log_lib.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:rt300_memr.c
class Rt300Memr {
  Rt300LogData rt300 = Rt300LogData();

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifRt300MemoryRead()
  /// * 機能概要      : ログリードコマンド送信ライブラリ(RT300)
  /// * 引数          : TprTID src
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  Future<int>	ifRt300MemoryRead( TprTID src ) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(28, (_) => "");
      int len = 0;
      int i = 0;
      int send = 0;
      int number = 0;
      List<String> sendData = List.generate(4, (_) => "");

      if ((AcxCom.ifAcbSelect() & CoinChanger.RT_300) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      sendBuf.fillRange(0, sendBuf.length, "");
      sendData.fillRange(0, sendData.length, "0x30");
      sendBuf[len++] = TprDefAsc.DC1;
      sendBuf[len++] = IfAcxDef.RT300_LOGREAD;
      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x36";

      /* ログ番号 */
      sendBuf[len++] = latin1.decode([0x30 + (rt300.logNum ~/ 10)]);
      sendBuf[len++] = latin1.decode([0x30 + (rt300.logNum % 10)]);

      /* インデックス番号 */
      number = rt300.indexNum;
      while (number != 0) {
        for (i = 0; i < 4; i++) {
          send = number % 16;
          sendData[i] = latin1.decode([0x30 + (send)]);
          number = (number / 16) as int;
        }
      }

      for (i = 0; i < 4; i++) {
        sendBuf[len++] = sendData[3 - i];
      }
      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return (errCode);
    }else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

}
