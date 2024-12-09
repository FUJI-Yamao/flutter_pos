/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:ecs_recalc.c
class EcsRecalc {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsReCalc()
  /// * 機能概要      : 精査コマンド送信ライブラリ(富士電機製釣銭釣札機)
  /// * 引数          : TprTID src
  /// *                 short  motion     精査の動作種別
  /// *                                    0:確定時は精査しない
  /// *                                    1:確定・不確定によらず紙幣、硬貨とも精査する
  /// *                                    2:確定・不確定によらず紙幣のみ精査する
  /// *                                    3:確定・不確定によらず硬貨のみ精査する
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsReCalc(TprTID src, int motion) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(40, (_) => "\x00");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }
      sendBuf.fillRange(0, sendBuf.length, "\x30");
      sendBuf[len++] = TprDefAsc.DC1;
      sendBuf[len++] = IfAcxDef.ECS_RECALC;
      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x31";
      switch (motion) {
        case 0: sendBuf[len++] = "\x30"; break;
        case 1: sendBuf[len++] = "\x31"; break;
        case 2: sendBuf[len++] = "\x32"; break;
        case 3: sendBuf[len++] = "\x33"; break;
      }

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
