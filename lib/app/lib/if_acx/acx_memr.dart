/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:flutter_pos/app/inc/sys/tpr.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_memr.c
class AcxMemr {
  // TODO:コンパイルSW
  //#ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrMemoryRead()
  /// * 機能概要      : Coin Changer Memory Data Read
  /// * 引数          : TprTID src
  /// *              : List<String> address
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcrMemoryRead(TprTID src, List<String> address) async {
    int errCode;
    int len;
    int iLoop;
    List<String> sendBuf = List.generate(16, (_) => "");

    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_MEMREAD;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x34";

    sendBuf.addAll(address);
    for (iLoop = 0; iLoop < 4; iLoop++) {
      sendBuf[4 + iLoop] = (int.parse(sendBuf[4 + iLoop]) | 0x30).toString();
    }

    len = 8;
    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  // #endif

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxMemoryRead()
  /// * 機能概要      : Coin Changer Memory Data Read
  /// * 引数          : TprTID src
  /// *              : List<String> address
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxMemoryRead(
      TprTID src, List<String> address, int changerFlg) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      //@@@ Lib共通化時に廃止 -> LogReadへ統合

      if (changerFlg == CoinChanger.ACR_COINBILL) /* Coin/Bill Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
            errCode = IfAcxDef.MSG_ACROK;
            break;
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.RT_300:
            errCode = await ifAcrMemoryRead(src, address);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      } else if (changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */ {
        errCode = await ifAcrMemoryRead(src, address);
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
}
