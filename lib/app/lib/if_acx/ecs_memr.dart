/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:ecs_download.c
class EcsDownload {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsMemoryRead()
  /// * 機能概要      : ログリードコマンド送信ライブラリ(富士電機製釣銭釣札機)
  /// * 引数          : TprTID src
  /// *                 char *address
  /// *                 char *size
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsMemoryRead(
      TprTID src, List<String> address, List<String> size) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(28, (_) => "\x00");
      int len = 0;
      int i = 0;
      int j = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      sendBuf.fillRange(0, sendBuf.length, "\x30");
      sendBuf[len++] = TprDefAsc.DC1;
      sendBuf[len++] = IfAcxDef.ECS_LOGREAD;
      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x39";

      sendBuf.addAll(address); /* 開始アドレス */
      for (i = 0; i < 7; i++) {
        sendBuf[4 + i] = (sendBuf[4 + i].codeUnitAt(0) | 0x30).toString();
      }

      sendBuf.addAll(size); /* 取得データバイト数÷２ */
      for (j = 0; j < 2; j++) {
        sendBuf[11 + j] = (sendBuf[11 + j].codeUnitAt(0) | 0x30).toString();
      }

      len = 13;

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return (errCode);
    } else {
    // #else
      return (IfAcxDef.MSG_ACROK);
    // #endif
    }
  }
}
