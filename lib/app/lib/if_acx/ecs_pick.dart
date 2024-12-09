/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:ecs_pick.c
class EcsPick {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsPickup()
  /// * 機能概要      : 回収コマンド送信ライブラリ(富士電機製釣銭釣札機)
  /// * 引数          : TprTID src
  /// *                 PICK_ECS pickEcs   回収データ格納エリア
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsPickup(TprTID src, PickEcs pickEcs) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(40, (_) => "\x00");
      int len = 0;
      String buf = "\x00\x00\x00";
      int idx;
      int amt = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }
      sendBuf.fillRange(0, sendBuf.length, "\x30");
      sendBuf[len++] = TprDefAsc.DC1;
      sendBuf[len++] = IfAcxDef.ECS_PICKUP;
      sendBuf[len++] = "\x32";
      sendBuf[len++] = "\x32";
      // Mode1
      for (idx = 0; idx <= 10; idx++) {
        switch (idx) {
          case 0: amt = pickEcs.cBillKind.coin500;  break;
          case 1: amt = pickEcs.cBillKind.coin100;  break;
          case 2: amt = pickEcs.cBillKind.coin50;   break;
          case 3: amt = pickEcs.cBillKind.coin10;   break;
          case 4: amt = pickEcs.cBillKind.coin5;    break;
          case 5: amt = pickEcs.cBillKind.coin1;    break;
          case 6: amt = pickEcs.cBillKind.bill10000;break;
          case 7: amt = pickEcs.cBillKind.bill5000; break;
          case 8: amt = pickEcs.cBillKind.bill2000; break;
          case 9: amt = pickEcs.cBillKind.bill1000; break;
          case 10: amt = 0;                         break;
        }
        if (amt == 10000) {
          sendBuf.add("\x3e\x3e\x3e");
        }
        else if (amt == 10001) {
          sendBuf.add("\x3f\x3f\x3f");
        }
        else if (amt >= 0 && amt <= 999) {
          buf = amt.toString().padLeft(3);
          sendBuf.add(buf);
        }
        else {
          return (IfAcxDef.MSG_INPUTERR);
        }
        len += 3;
      }

      // Mode
      int temp = int.parse(sendBuf[len]);
      temp |= (pickEcs.bill == 0) ? 0x00 : 0x01;
      temp |= (pickEcs.coin == 0) ? 0x00 : 0x02;
      temp |= (pickEcs.leave == 0) ? 0x00 : 0x04;
      temp |= (pickEcs.caset == 0) ? 0x00 : 0x08;
      sendBuf[len] = temp.toString();
      len++;

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
