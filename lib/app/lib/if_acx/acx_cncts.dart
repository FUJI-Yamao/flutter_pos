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
import 'fal2_statesr.dart';

/// 関連tprxソース:acx_cncts.c
class AcxCncts {
  // TODO:コンパイルSW
  // #ifndef PPSDVS
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20ConnectModeSet()
  /// * 機能概要      : Connect Mode Reset
  /// * 引数          : TprTID src
  /// *                 int rad
  /// *                 int acr
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcb20ConnectModeSet(TprTID src, int rad, int acr) async {
    int errCode;
    List<String> sendBuf = List.generate(6 + 1, (_) => "");
    int len;

    // Send Buffer set(Change out Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_CONNECTMODE;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x32";
    sendBuf[4] = "\x30";

    int temp = sendBuf[4].codeUnitAt(16);
    switch (acrConnectRadGetIndex(rad)) {
      case AcrConnectRad.ACR_RAD_CUT:
        sendBuf[4] = latin1.decode([temp | 0x02]);
        break;
      case AcrConnectRad.ACR_RAD_CONNECT:
        break;
      default:
        return (IfAcxDef.MSG_ACRFLGERR);
    }
    switch (acrConnectAcrGetIndex(acr)) {
      case AcrConnectAcr.ACR_ACR_CUT:
        sendBuf[4] = latin1.decode([temp | 0x01]);
        break;
      case AcrConnectAcr.ACR_ACR_CONNECT:
        break;
      default:
        return (IfAcxDef.MSG_ACRFLGERR);
    }
    sendBuf[5] = "\x30";
    len = 6;

    // transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrConnectModeSet()
  /// * 機能概要      : Connect Mode Reset(SST1)
  /// * 引数          : TprTID src
  /// *                 int rad
  /// *                 int acr
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcrConnectModeSet(TprTID src, int rad, int acr) async {
    int errCode;
    List<String> sendBuf = List.generate(6 + 1, (_) => "");
    int len;

    // Send Buffer set(Change out Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_CONNECTMODE;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x32";
    sendBuf[4] = "\x30";

    int temp = sendBuf[4].codeUnitAt(16);
    switch (acrConnectRadGetIndex(rad)) {
      case AcrConnectRad.ACR_RAD_CUT:
        sendBuf[4] = latin1.decode([temp | 0x02]);
        break;
      case AcrConnectRad.ACR_RAD_CONNECT:
        break;
      default:
        return (IfAcxDef.MSG_ACRFLGERR);
    }
    switch (acrConnectAcrGetIndex(acr)) {
      case AcrConnectAcr.ACR_ACR_CUT:
        sendBuf[4] = latin1.decode([temp | 0x01]);
        break;
      case AcrConnectAcr.ACR_ACR_CONNECT:
        break;
      default:
        return (IfAcxDef.MSG_ACRFLGERR);
    }
    sendBuf[5] = "\x30";
    len = 6;

    // transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifSst1CnctModeSetReset()
  /// * 機能概要      : Connect Mode Reset(SST1)
  /// * 引数          : TprTID src
  /// *                 int indexNo
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifSst1CnctModeSetReset(TprTID src) async {
    int errCode = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(1, (_) => "");

    // Send Buffer set(Change out Command)
    sendBuf[0] = "\x99";
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, 1);

    return errCode;
  }

  // #endif

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifRt300CloseRead()
  /// * 機能概要      : Connect Mode Set
  /// * 引数          : TprTID src
  /// *                 int indexNo
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcxConnectModeSet(
      TprTID src, int changerFlg, int rad, int acr) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;
      List<String> status = List.generate(3, (_) => "");

      // Coin/Bill Changer ?
      if (changerFlg == CoinChanger.ACR_COINBILL) {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
            return (IfAcxDef.MSG_ACROK);
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.ECS:
          case CoinChanger.SST1:
          case CoinChanger.ECS_777:
            errCode = await ifAcb20ConnectModeSet(src, rad, acr);
            break;
          case CoinChanger.RT_300:
            errCode =
                await AcxCom.ifAcxCmdSkip(src, ifAcxConnectModeSet); //処理なし
            break;
          case CoinChanger.FAL2:
            status.fillRange(0, status.length, "");
            status[0] = "\x00";
            if ((rad == AcrConnectRad.ACR_RAD_CUT.index) &&
                (acr == AcrConnectAcr.ACR_ACR_CUT.index)) {
              return (IfAcxDef.MSG_ACRFLGERR);
            } else if (rad == AcrConnectRad.ACR_RAD_CUT.index) {
              status[1] = "\x01";
            } else if (acr == AcrConnectAcr.ACR_ACR_CUT.index) {
              status[1] = "\x02";
            } else {
              status[1] = "\x00";
            }
            errCode = await Fal2Statesr.ifFal2StateSetRead(src, 1, 1, status);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      }
      // Coin Changer ?
      else if (changerFlg == CoinChanger.ACR_COINONLY) {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            errCode = await ifAcb20ConnectModeSet(src, rad, acr);
            break;
          default:
            errCode = await ifAcrConnectModeSet(src, rad, acr);
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

  static AcrConnectRad acrConnectRadGetIndex(int handle) {
    switch (handle) {
      case 0:
        return AcrConnectRad.ACR_RAD_CONNECT;
      case 1:
        return AcrConnectRad.ACR_RAD_CUT;
      default:
        return AcrConnectRad.ACR_RAD_CONNECT;
    }
  }

  static AcrConnectAcr acrConnectAcrGetIndex(int handle) {
    switch (handle) {
      case 0:
        return AcrConnectAcr.ACR_ACR_CONNECT;
      case 1:
        return AcrConnectAcr.ACR_ACR_CUT;
      default:
        return AcrConnectAcr.ACR_ACR_CONNECT;
    }
  }
}
