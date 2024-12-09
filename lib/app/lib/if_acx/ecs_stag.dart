/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:ecs_stag.c
class EcsStag {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsStateGet()
  /// * 機能概要      : ECS釣銭機速度変更コマンド送信
  /// * 引数          : TprTID src
  /// *                 STATE_ECS *stateEcs  詳細状態格納エリア
  /// *                 TprMsgDevReq2_t *rcvBuf  受信データアドレス
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifEcsStateGet(TprTID src, StateEcs stateEcs,
      TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> contentCode = List.generate(3, (_) => "");
      List<int> temp = List.generate(rcvBuf.data.length, (_) => 0);

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode == IfAcxDef.MSG_ACROK) {
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }
      if (errCode != IfAcxDef.MSG_ACROK) {
        return (errCode); // NG return   !
      }

      for (int i = 0; i < temp.length; i++) {
        if ((rcvBuf.data[i] == null) || (rcvBuf.data[i] == "")) {
          break;
        }
        temp[i] = rcvBuf.data[i].codeUnitAt(0);
      }

      stateEcs.unit = temp[2];
      stateEcs.actMode = temp[3];
      stateEcs.cinMode = temp[4];

      stateEcs.err.unit = temp[5] - 0x30;
      stateEcs.err.procCode = temp[6];
      contentCode.fillRange(0, contentCode.length, "0x00");
      contentCode = rcvBuf.data.sublist(7, 9);
      ifEcsStateErrCodeEdit(stateEcs, contentCode);

      stateEcs.sensor.billIn = ((temp[9] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.sensor.billOut = ((temp[9] & 0x01) == 0x00) ? 0 : 1;
      stateEcs.sensor.coinIn = ((temp[10] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.sensor.coinReturn = ((temp[10] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.sensor.coinOut = ((temp[10] & 0x01) == 0x00) ? 0 : 1;

      stateEcs.full.bill10000 = ((temp[11] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.full.bill2000 = ((temp[11] & 0x01) == 0x00) ? 0 : 1;
      stateEcs.full.bill5000 = ((temp[12] & 0x08) == 0x00) ? 0 : 1;
      stateEcs.full.bill1000 = ((temp[12] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.full.coin500 = ((temp[12] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.full.coin100 = ((temp[12] & 0x01) == 0x00) ? 0 : 1;
      stateEcs.full.coin50 = ((temp[13] & 0x08) == 0x00) ? 0 : 1;
      stateEcs.full.coin10 = ((temp[13] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.full.coin5 = ((temp[13] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.full.coin1 = ((temp[13] & 0x01) == 0x00) ? 0 : 1;

      stateEcs.nearFull.bill10000 = ((temp[14] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.nearFull.bill2000 = ((temp[14] & 0x01) == 0x00) ? 0 : 1;
      stateEcs.nearFull.bill5000 = ((temp[15] & 0x08) == 0x00) ? 0 : 1;
      stateEcs.nearFull.bill1000 = ((temp[15] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.nearFull.coin500 = ((temp[15] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.nearFull.coin100 = ((temp[15] & 0x01) == 0x00) ? 0 : 1;
      stateEcs.nearFull.coin50 = ((temp[16] & 0x08) == 0x00) ? 0 : 1;
      stateEcs.nearFull.coin10 = ((temp[16] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.nearFull.coin5 = ((temp[16] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.nearFull.coin1 = ((temp[16] & 0x01) == 0x00) ? 0 : 1;

      stateEcs.nearEmpty.bill10000 = ((temp[17] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.nearEmpty.bill2000 = ((temp[17] & 0x01) == 0x00) ? 0 : 1;
      stateEcs.nearEmpty.bill5000 = ((temp[18] & 0x08) == 0x00) ? 0 : 1;
      stateEcs.nearEmpty.bill1000 = ((temp[18] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.nearEmpty.coin500 = ((temp[18] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.nearEmpty.coin100 = ((temp[18] & 0x01) == 0x00) ? 0 : 1;
      stateEcs.nearEmpty.coin50 = ((temp[19] & 0x08) == 0x00) ? 0 : 1;
      stateEcs.nearEmpty.coin10 = ((temp[19] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.nearEmpty.coin5 = ((temp[19] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.nearEmpty.coin1 = ((temp[19] & 0x01) == 0x00) ? 0 : 1;

      stateEcs.empty.bill10000 = ((temp[20] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.empty.bill2000 = ((temp[20] & 0x01) == 0x00) ? 0 : 1;
      stateEcs.empty.bill5000 = ((temp[21] & 0x08) == 0x00) ? 0 : 1;
      stateEcs.empty.bill1000 = ((temp[21] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.empty.coin500 = ((temp[21] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.empty.coin100 = ((temp[21] & 0x01) == 0x00) ? 0 : 1;
      stateEcs.empty.coin50 = ((temp[22] & 0x08) == 0x00) ? 0 : 1;
      stateEcs.empty.coin10 = ((temp[22] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.empty.coin5 = ((temp[22] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.empty.coin1 = ((temp[22] & 0x01) == 0x00) ? 0 : 1;

      stateEcs.holder.full = ((temp[23] & 0x08) == 0x00) ? 0 : 1;
      stateEcs.holder.nearFull = ((temp[23] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.holder.nearEmpty = ((temp[23] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.holder.empty = ((temp[23] & 0x01) == 0x00) ? 0 : 1;

      stateEcs.actState = rcvBuf.data.sublist(24, (24 + stateEcs.actState.length));

      stateEcs.cashBox.lid = ((temp[45] & 0x08) == 0x00) ? 0 : 1;
      stateEcs.cashBox.set = ((temp[45] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.cashBox.bill = ((temp[45] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.cashBox.full = ((temp[45] & 0x01) == 0x00) ? 0 : 1;

      stateEcs.key.billSet = ((temp[46] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.key.billKey = temp[46] & 0x33;
      stateEcs.key.coinSet = ((temp[47] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.key.coinKey = temp[47] & 0x33;

      stateEcs.temp.billFull = ((temp[48] & 0x08) == 0x00) ? 0 : 1;
      stateEcs.temp.coinFull = ((temp[48] & 0x04) == 0x00) ? 0 : 1;
      stateEcs.temp.billStatus = ((temp[48] & 0x02) == 0x00) ? 0 : 1;
      stateEcs.temp.coinStatus = ((temp[48] & 0x01) == 0x00) ? 0 : 1;

      stateEcs.detail.bill = rcvBuf.data.sublist(49, 49 + (stateEcs.detail.bill.length)).join();
      stateEcs.detail.coin = rcvBuf.data.sublist(51, 51 + (stateEcs.detail.coin.length)).join();

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsStateErrCodeEdit()
  /// * 機能概要      : 
  /// * 引数          : TprTID src
  /// *                 int mode
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static void ifEcsStateErrCodeEdit(StateEcs stateEcs, List<String> code) {
    int i;

    for (i = 0; i < 2; i++) {
      stateEcs.err.contentCode[i] = ascii.encode(code[0]).toString();
    }
  }
}
