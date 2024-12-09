/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:ecs_calcs.c
class EcsCalcs {
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsCalcModeSet()
  /// * 機能概要      : Calculate Mode Set
  /// * 引数          : TprTID src
  /// *              : int mode   入金モード(0:釣銭先行モード／1:入金確定モード)
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsCalcModeSet(TprTID src, int mode) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(40, (_) => "");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }
      sendBuf[len++] = TprDefAsc.DC1;
      sendBuf[len++] = IfAcxDef.ECS_CALCLATEMODE;
      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x34";
      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x31";
      sendBuf[len++] = "\x30";
      sendBuf[len++] = ((mode == 0) ? 0x30 : 0x31).toString();

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return (errCode);
      // #else
    } else {
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}