/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:ecs_star.c
class EcsStar {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsStateRead()
  /// * 機能概要      : 詳細状態リードコマンド送信ライブラリ(富士電機製釣銭釣札機)
  /// * 引数          : TprTID src
  /// * 戻り値 result : 0(MSG_ACROK) 正常終了
  /// *-------------------------------------------------------------------------------
  static Future<int> ifEcsStateRead(TprTID src) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(40, (_) => "");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }
      sendBuf.fillRange(0, sendBuf.length, "\x30");
      sendBuf[len++] = TprDefAsc.DC1;
      sendBuf[len++] = IfAcxDef.ECS_STATEREAD;
      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x30";

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return (errCode);
    } else {
    // #else
      return (IfAcxDef.MSG_ACROK);
    // #endif
    }
  }
}