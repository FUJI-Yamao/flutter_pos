/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:convert';

import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../if/if_changer_isolate.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_closew.c
class AcxClosew {
  // TODO:コンパイルSW
  // #ifndef PPSDVS
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifRt300CloseWrite()
  /// * 機能概要      : Close Data Write
  /// * 引数          : TprTID src
  /// *                 int mode
  /// *                 List<int> staffCd
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifRt300CloseWrite(TprTID src, int mode,
      List<int> staffCd) async {
    int errCode;
    List<String> sendBuf = List.generate(15 + 1, (_) => "");
    int len = 0;
    List<int> closeId = List.generate(10, (_) => 0);
    String log = "";
    String temp = "";

    closeId = staffCd;
    temp = closeId.join("");
    String temp2 = staffCd.join("");
    String temp2Str = "";
    if (int.parse(temp) > 99999999) { //従業員コードが9桁以上の場合は下8桁で処理する
      temp2Str = (int.parse(temp2) % 100000000).toString();
      for (int i = 0; i < temp2Str.length; i++) {
        closeId[i+1] = int.parse(temp2Str[i]);
      }
      log = "ifRt300CloseWrite: staffCd[$staffCd] length over -> id[$closeId]";
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);
    }

    // Send Buffer set(Change out Command)
    sendBuf.fillRange(0, sendBuf.length, "");
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ACR_CLOSE;
    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x3C";
    sendBuf[len++] = "\x30";
    switch (acrCloseTypGetIndex(mode)) {
      case AcrCloseTyp.ACR_CLOSE_TYP_CHG:
        sendBuf[len++] = "\x30";
        break;
      case AcrCloseTyp.ACR_CLOSE_TYP_CLS:
        sendBuf[len++] = "\x31";
        break;
      default:
        return (IfAcxDef.MSG_ACRFLGERR);
    }
    temp = closeId.join("");
    sendBuf[len++] = latin1.decode([0x30 + ((int.parse(temp) % 100000000) ~/ 10000000)]);
    sendBuf[len++] = latin1.decode([0x30 + ((int.parse(temp) % 10000000) ~/ 1000000)]);
    sendBuf[len++] = latin1.decode([0x30 + ((int.parse(temp) % 1000000) ~/ 100000)]);
    sendBuf[len++] = latin1.decode([0x30 + ((int.parse(temp) % 100000) ~/ 10000)]);
    sendBuf[len++] = latin1.decode([0x30 + ((int.parse(temp) % 10000) ~/ 1000)]);
    sendBuf[len++] = latin1.decode([0x30 + ((int.parse(temp) % 1000) ~/ 100)]);
    sendBuf[len++] = latin1.decode([0x30 + ((int.parse(temp) % 100) ~/ 10)]);
    sendBuf[len++] = latin1.decode([0x30 + ((int.parse(temp) % 10) ~/ 1)]);

    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x30";

    // transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
    return errCode;
  }

  // #endif

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifRt300CloseWrite()
  /// * 機能概要      : Close Data Write
  /// * 引数          : TprTID src
  /// *                 int changerFlg
  /// *                 int mode
  /// *                 List<int> staffCd
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcxCloseWrite(TprTID src, int changerFlg, int mode,
      List<int> staffCd) async {
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
            errCode = await ifRt300CloseWrite(src, mode, staffCd);
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
            errCode = await ifRt300CloseWrite(src, mode, staffCd);
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

  static AcrCloseTyp acrCloseTypGetIndex(int handle) {
    switch (handle) {
      case 0:
        return AcrCloseTyp.ACR_CLOSE_TYP_CHG;
      case 1:
        return AcrCloseTyp.ACR_CLOSE_TYP_CLS;
      default:
        return AcrCloseTyp.ACR_CLOSE_TYP_CHG;
    }
  }
}
