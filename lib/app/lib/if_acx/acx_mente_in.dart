/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../if/if_changer_isolate.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_mente_in.c
class AcxMenteIn {
  // TODO:コンパイルSW
  //#ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifRt300MenteIn()
  /// * 機能概要      : Mentenance(Out of Sales) In
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifRt300MenteIn(TprTID src) async {
    int errCode;
    List<String> sendBuf = List.generate(4 + 1, (_) => "");
    int len = 0;

    //  Send Buffer set(Change out Command)
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ACR_MENTE_IN;
    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x30";

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
    return errCode;
  }
  //#endif

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxMenteIn()
  /// * 機能概要      : Mentenance(Out of Sales) In
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxMenteIn(TprTID src, int changerFlg) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      TprLog().logAdd(
          IfChangerIsolate.taskId, LogLevelDefine.normal, "***** IN Start");

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
            errCode = await ifRt300MenteIn(src);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      } else if (changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.RT_300:
            errCode = await ifRt300MenteIn(src);
            break;
          default:
            return (IfAcxDef.MSG_ACROK);
        }
      } else /* Changer_flg NG ! */ {
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
