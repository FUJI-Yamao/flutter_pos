/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'acx_stcg.dart';

/// 関連tprxソース:ecs_drwg.c
class EcsDrwg {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsDownload()
  /// * 機能概要      : 棒金収納状況読出しレスポンス受信データ解析ライブラリ(富士電機製釣銭釣札機)
  /// * 引数          : TprTID src
  /// *                 StateAcxDrw *stateAcxDrw  棒金収納状態状態格納エリア
  /// *                 TprMsgDevReq2_t *rcvBuf  受信データアドレス
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsDrwGet(TprTID src, StateAcxDrw stateAcxDrw,
      TprMsgDevReq2_t rcvBuf) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> readBuf = List.generate(27, (_) => "\x00");
      int idx;

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

      for (idx = 0; idx < readBuf.length; idx++) {
        readBuf[idx] = (rcvBuf.data[idx + 2].codeUnitAt(0) & 0x3f).toString();
      }

      stateAcxDrw.stock.coin500 = AcxStcg.ifAcxRepack(src, readBuf.sublist(0));
      stateAcxDrw.stock.coin100 = AcxStcg.ifAcxRepack(src, readBuf.sublist(3));
      stateAcxDrw.stock.coin50 = AcxStcg.ifAcxRepack(src, readBuf.sublist(6));
      stateAcxDrw.stock.coin10 = AcxStcg.ifAcxRepack(src, readBuf.sublist(9));
      stateAcxDrw.stock.coin5 = AcxStcg.ifAcxRepack(src, readBuf.sublist(12));
      stateAcxDrw.stock.coin1 = AcxStcg.ifAcxRepack(src, readBuf.sublist(15));
      stateAcxDrw.reserv1Stock = AcxStcg.ifAcxRepack(src, readBuf.sublist(18));
      stateAcxDrw.reserv2Stock = AcxStcg.ifAcxRepack(src, readBuf.sublist(21));

      stateAcxDrw.deviceState = readBuf[24].codeUnitAt(0) - 0x30;

      stateAcxDrw.cBillState.coin500 = ((readBuf[25].codeUnitAt(0) & 0x08) == 0x00) ? 0 : 1;
      stateAcxDrw.cBillState.coin100 = ((readBuf[25].codeUnitAt(0) & 0x04) == 0x00) ? 0 : 1;
      stateAcxDrw.cBillState.coin50 = ((readBuf[25].codeUnitAt(0) & 0x02) == 0x00) ? 0 : 1;
      stateAcxDrw.cBillState.coin10 = ((readBuf[25].codeUnitAt(0) & 0x01) == 0x00) ? 0 : 1;
      stateAcxDrw.cBillState.coin5 = ((readBuf[26].codeUnitAt(0) & 0x08) == 0x00) ? 0 : 1;
      stateAcxDrw.cBillState.coin1 = ((readBuf[26].codeUnitAt(0) & 0x04) == 0x00) ? 0 : 1;
      stateAcxDrw.reserv1State = ((readBuf[26].codeUnitAt(0) & 0x02) == 0x00) ? 0 : 1;
      stateAcxDrw.reserv2State = ((readBuf[26].codeUnitAt(0) & 0x01) == 0x00) ? 0 : 1;

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
