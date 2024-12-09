/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'ecs_calcs.dart';
import 'fal2_statesr.dart';

/// 関連tprxソース:acx_calcs.c
class AcxCalcs {
  // TODO:コンパイルSW
  //#ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20CalcModeSet()
  /// * 機能概要      : Calculate Mode Set
  /// * 引数          : TprTID src
  /// *              : int motion
  /// *              : int mode
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb20CalcModeSet(TprTID src, int motion,
      int mode) async {
    int errCode;
    List<String> sendBuf = List.generate(8 + 1, (_) => "");
    int len;

    //  Send Buffer set(Change out Command)
    sendBuf.fillRange(0, sendBuf.length, "0x00");
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_CALCLATEMODE;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x34";
    sendBuf[4] = "\x30";
    sendBuf[6] = "\x30";
    switch (acrCalcFlagGetIndex(motion)) {
      case AcrCalcFlag.ACR_CALC_ENQ:
        sendBuf[5] = "\x30";
        sendBuf[7] = "\x30";
        break;
      case AcrCalcFlag.ACR_CALC_SET:
        sendBuf[5] = "\x31";
        switch (acrCalcModeGetIndex(mode)) {
          case AcrCalcMode.ACR_CALC_MANUAL:
            sendBuf[7] = "\x30";
            break;
          case AcrCalcMode.ACR_CALC_AUTO:
            sendBuf[7] = "\x31";
            break;
          case AcrCalcMode.ACR_CALC_CTRL:
            if (AcxCom.ifAcbSelect() & CoinChanger.RT_300_X != 0) {
              sendBuf[7] = "\x32";
            } else {
              return (IfAcxDef.MSG_ACRFLGERR);
            }
            break;
          default:
            return (IfAcxDef.MSG_ACRFLGERR);
        }
        break;
      default:
        return (IfAcxDef.MSG_ACRFLGERR);
    }
    len = 8;

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrCalcModeSet()
  /// * 機能概要      : Calculate Mode Set
  /// * 引数          : TprTID src
  /// *              : int motion
  /// *              : int mode
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcrCalcModeSet(TprTID src, int motion, int mode) async {
    int errCode;
    List<String> sendBuf = List.generate(8 + 1, (_) => "");
    int len;

    //  Send Buffer set(Change out Command)
    sendBuf.fillRange(0, sendBuf.length, "0x00");
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_CALCLATEMODE;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x34";
    sendBuf[4] = "\x30";
    sendBuf[6] = "\x30";
    switch (acrCalcFlagGetIndex(motion)) {
      case AcrCalcFlag.ACR_CALC_ENQ:
        sendBuf[5] = "\x30";
        sendBuf[7] = "\x30";
        break;
      case AcrCalcFlag.ACR_CALC_SET:
        sendBuf[5] = "\x31";
        switch (acrCalcModeGetIndex(mode)) {
          case AcrCalcMode.ACR_CALC_MANUAL:
            sendBuf[7] = "\x30";
            break;
          case AcrCalcMode.ACR_CALC_AUTO:
            sendBuf[7] = "\x31";
            break;
          case AcrCalcMode.ACR_CALC_CTRL:
            if (AcxCom.ifAcbSelect() & CoinChanger.RT_300_X != 0) {
              sendBuf[7] = "\x32";
            } else {
              return (IfAcxDef.MSG_ACRFLGERR);
            }
            break;
          default:
            return (IfAcxDef.MSG_ACRFLGERR);
        }
        break;
      default:
        return (IfAcxDef.MSG_ACRFLGERR);
    }
    len = 8;

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  // #endif

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrCalcModeSet()
  /// * 機能概要      : Calculate Mode Set
  /// * 引数          : TprTID src
  /// *              : int motion
  /// *              : int mode
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxCalcModeSet(TprTID src, int changerFlg, int motion,
      int mode) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACRFLGERR;
      int ecsMode;
      List<String> status = List.generate(3, (_) => "");

      if (changerFlg == CoinChanger.ACR_COINBILL) /* Coin/Bill Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
            return (IfAcxDef.MSG_ACROK);
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.RT_300:
          case CoinChanger.SST1:
            errCode = await ifAcb20CalcModeSet(src, motion, mode);
            break;
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            if (motion == AcrCalcFlag.ACR_CALC_SET.index) {
              ecsMode = (mode == AcrCalcMode.ACR_CALC_AUTO.no) ? 1 : 0;
              errCode = await EcsCalcs.ifEcsCalcModeSet(src, ecsMode);
            }
            break;
          case CoinChanger.FAL2:
            status.fillRange(0, status.length, "\x00");
            status[0] = "\x00";
            switch (acrCalcModeGetIndex(mode)) {
              case AcrCalcMode.ACR_CALC_MANUAL:
                status[1] = "\x00";
                break;
              case AcrCalcMode.ACR_CALC_AUTO:
                status[1] = "\x01";
                break;
              default:
                return (IfAcxDef.MSG_ACRFLGERR);
            }
            errCode = await Fal2Statesr.ifFal2StateSetRead(src, 1, 2, status);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      }
      else if (changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            errCode = await ifAcb20CalcModeSet(src, motion, mode);
            break;
          default:
            errCode = await ifAcrCalcModeSet(src, motion, mode);
            break;
        }
      } else /* changerFlg NG ! */ {
        errCode = IfAcxDef.MSG_ACRFLGERR;
      }

      return errCode;
      // #else
    } else {
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  static AcrCalcFlag acrCalcFlagGetIndex(int handle) {
    switch (handle) {
      case 0:
        return AcrCalcFlag.ACR_CALC_ENQ;
      case 1:
        return AcrCalcFlag.ACR_CALC_SET;
      default:
        return AcrCalcFlag.ACR_CALC_ENQ;
    }
  }

  static AcrCalcMode acrCalcModeGetIndex(int handle) {
    switch (handle) {
      case 0:
        return AcrCalcMode.ACR_CALC_MANUAL;
      case 1:
        return AcrCalcMode.ACR_CALC_AUTO;
      case 2:
        return AcrCalcMode.ACR_CALC_CTRL;
      default:
        return AcrCalcMode.ACR_CALC_MANUAL;
    }
  }
}
