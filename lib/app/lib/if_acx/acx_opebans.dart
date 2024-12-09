/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:flutter_pos/app/lib/if_acx/acx_coin.dart';

import '../../common/cmn_sysfunc.dart';
import '../../if/if_changer_isolate.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'acx_spco.dart';

/// 関連tprxソース:acx_opebans.c
class AcxOpebans {
  // TODO:コンパイルSW
  //#ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb200LocalOpeBanSet()
  /// * 機能概要      : Local Operation Ban Set
  /// * 引数          : TprTID src
  /// *              : int motion
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb200LocalOpeBanSet(TprTID src, int motion) async {
    int errCode;
    List<String> sendBuf = List.generate(6, (_) => "");
    int len;

    // Send Buffer set(Local Operation Ban Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_LOCALOPEBAN;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x32";
    sendBuf[5] = "\x30"; // D1
    switch (acrLocalOpeBanFlgGetIndex(motion)) {
      case AcrLocalOpeBanFlg.ACR_LOCALOPEBAN_YES:
        sendBuf[4] = "\x30"; // D0
        break;
      case AcrLocalOpeBanFlg.ACR_LOCALOPEBAN_NO:
        sendBuf[4] = "\x31"; // D0
        break;
      default:
        return (IfAcxDef.MSG_ACRFLGERR);
    }
    len = 6;

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrLocalOpeBanSet()
  /// * 機能概要      : Local Operation Ban Set
  /// * 引数          : TprTID src
  /// *              : int motion
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcrLocalOpeBanSet(TprTID src, int motion) async {
    int errCode;
    List<String> sendBuf = List.generate(6, (_) => "");
    int len;

    //  Send Buffer set(Local Operation Ban Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_LOCALOPEBAN;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x32";
    sendBuf[5] = "\x30"; // D1
    switch (acrLocalOpeBanFlgGetIndex(motion)) {
      case AcrLocalOpeBanFlg.ACR_LOCALOPEBAN_YES:
        sendBuf[4] = "\x30"; // D0
        break;
      case AcrLocalOpeBanFlg.ACR_LOCALOPEBAN_NO:
        sendBuf[4] = "\x31"; // D0
        break;
      default:
        return (IfAcxDef.MSG_ACRFLGERR);
    }
    len = 6;

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  // #endif

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxLocalOpeBanSet()
  /// * 機能概要      : Local Operation Ban Set
  /// * 引数          : TprTID src
  /// *              : int motion
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxLocalOpeBanSet(
      TprTID src, int changerFlg, int motion) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      if (changerFlg == CoinChanger.ACR_COINBILL) /* Coin/Bill Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
          case CoinChanger.ECS:
          case CoinChanger.SST1:
          case CoinChanger.FAL2:
          case CoinChanger.ECS_777:
            errCode =
                await AcxCom.ifAcxCmdSkip(src, ifAcxLocalOpeBanSet); //処理なし
            break;
          case CoinChanger.ACB_200:
          case CoinChanger.RT_300:
            errCode = await ifAcb200LocalOpeBanSet(src, motion);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      } else if (changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            errCode =
                await AcxCom.ifAcxCmdSkip(src, ifAcxLocalOpeBanSet); //処理なし
            break;
          default:
            errCode = await ifAcrLocalOpeBanSet(src, motion);
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

  static AcrLocalOpeBanFlg acrLocalOpeBanFlgGetIndex(int handle) {
    switch (handle) {
      case 0:
        return AcrLocalOpeBanFlg.ACR_LOCALOPEBAN_YES;
      case 1:
        return AcrLocalOpeBanFlg.ACR_LOCALOPEBAN_NO;
      default:
        return AcrLocalOpeBanFlg.ACR_LOCALOPEBAN_YES;
    }
  }
}
