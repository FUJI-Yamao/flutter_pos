/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:convert';

import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_chge.c
class AcxChge {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrChange()
  /// * 機能概要      : Coin Changer Balance Fixed Chenge
  /// * 引数          : TprTID src
  /// *                 TprMsgDevReq2_t rcvBuf
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcrChange(TprTID src, int chgFlag) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;
      List<String> sendBuf = List.generate(5, (_) => "");
      int len;

      // Send Buffer set(Balance Clear Command)
      sendBuf[0] = TprDefAsc.DC1;
      sendBuf[1] = "\x39";
      sendBuf[2] = "\x30";
      sendBuf[3] = "\x31";
      sendBuf[4] = latin1.decode([chgFlag + 0]);
      len = 5;

      // transmit a message
      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return errCode;
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
