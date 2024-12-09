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

/// 関連tprxソース:acx_closer.c
class AcxCloser {
  // TODO:コンパイルSW
  // #ifndef PPSDVS
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifRt300CloseRead()
  /// * 機能概要      : Close Data Read
  /// * 引数          : TprTID src
  /// *                 int indexNo
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifRt300CloseRead(TprTID src, int indexNo) async {
    int errCode;
    List<String> sendBuf = List.generate(15 + 1, (_) => "");
    int len = 0;

    // Send Buffer set(Change out Command)
    sendBuf.fillRange(0, sendBuf.length, "");
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ACR_CLOSE_DATAREAD;
    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x32";
    sendBuf[len++] = latin1.decode([(indexNo >> 4) | 0x30]);
    sendBuf[len++] = latin1.decode([(indexNo & 0x0f) | 0x30]);

    // transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
    return errCode;
  }

  // #endif

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxCloseRead()
  /// * 機能概要      : Close Data Read
  /// * 引数          : TprTID src
  /// *                 int changerFlg
  /// *                 int indexNo
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcxCloseRead(
      TprTID src, int changerFlg, int indexNo) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      // Coin/Bill Changer ?
      if (changerFlg == CoinChanger.ACR_COINBILL) {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.ECS:
          case CoinChanger.SST1:
          case CoinChanger.FAL2:
          case CoinChanger.ECS_777:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
          case CoinChanger.RT_300:
            errCode = await ifRt300CloseRead(src, indexNo);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      }
      // Coin Changer ?
      else if (changerFlg == CoinChanger.ACR_COINONLY) {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.RT_300:
            errCode = await ifRt300CloseRead(src, indexNo);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      }
      // changerFlg NG !
      else {
        errCode = IfAcxDef.MSG_ACRFLGERR;
      }

      return errCode;
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
