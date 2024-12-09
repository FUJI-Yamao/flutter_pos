/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_outerr_in.c
class AcxOuterrIn {
  // TODO:コンパイルSW
  // #ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifRt300OutErrIn()
  /// * 機能概要      : Out Error -> In
  /// * 引数          : TprTID src
  /// * 戻り値 result : 0(MSG_ACROK) 正常終了
  /// *        mode   :
  /// *-------------------------------------------------------------------------------
  static Future<int> ifRt300OutErrIn(TprTID src) async {
    int errCode;
    List<String> sendBuf = List.generate(4 + 1, (_) => "");
    int len = 0;

    //  Send Buffer set(Change out Command)
    sendBuf.fillRange(0, sendBuf.length, "0x00");
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ACR_OUTERR_IN;
    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x30";

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
    return errCode;
  }
  // #endif

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxOutErrIn()
  /// * 機能概要      : Out Error -> In
  /// * 引数          : TprTID src
  /// * 戻り値 result : 0(MSG_ACROK) 正常終了
  /// *        mode   :
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcxOutErrIn(TprTID src, int changerFlg) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      if (changerFlg == CoinChanger.ACR_COINBILL) /* Coin/Bill Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.ECS:
          case CoinChanger.SST1:
          case CoinChanger.FAL2:
          case CoinChanger.ECS_777:
            return (IfAcxDef.MSG_ACROK);
          case CoinChanger.RT_300:
            errCode = await ifRt300OutErrIn(src);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      } else if (changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.RT_300:
            errCode = await ifRt300OutErrIn(src);
            break;
          default:
            return (IfAcxDef.MSG_ACROK);
        }
      } else /* changerFlg NG ! */ {
        errCode = IfAcxDef.MSG_ACRFLGERR;
      }

      return errCode;
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  // TODO:00016 佐藤 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース:acx_outerr_in - if_acx_Mente_In()
  int ifAcxMenteIn(int src, int changerFlg) {
    return 0;
  }

  // TODO:00016 佐藤 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース:acx_outerr_in - if_acx_CinStart()
  int ifAcxCinStart(int src, int changerFlg) {
    return 0;
  }
}
