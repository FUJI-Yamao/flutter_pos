/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'acx_stcg.dart';

/// 関連tprxソース:ecs_recalcg.c
class EcsRecalcg {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsReCalcGet()
  /// * 機能概要      : 精査レスポンス受信データ解析ライブラリ(富士電機製釣銭釣札機)
  /// * 引数          : TprTID src
  /// *                 RECALCDATA *reCalc  精査レスポンス格納エリア
  /// *                 TprMsgDevReq2_t *rcvBuf  受信データアドレス
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  int ifEcsReCalcGet(TprTID src, ReCalcData reCalc, TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode != IfAcxDef.MSG_ACROK) {
        return (errCode); /* NG return   !  */
      }

      if (int.parse(rcvBuf.data[0]) != 0x30) {
        errCode = AcxCom.ifAcxResultChk(src, rcvBuf.data[0]);
        return (errCode);
      } else {
        errCode = DlgConfirmMsgKind.MSG_ACRCHECK.dlgId;

        int temp = int.parse(rcvBuf.data[2]);
        reCalc.ejectCoin = ((temp & 0x01) != 0) ? 1 : 0;
        reCalc.ejectBill = ((temp & 0x02) != 0) ? 1 : 0;
        reCalc.reserveBill = ((temp & 0x04) != 0) ? 1 : 0;
        reCalc.stop = ((temp & 0x08) != 0) ? 1 : 0;
        reCalc.bill = AcxStcg.ifAcxRepack(src, rcvBuf.data.sublist(3));
        reCalc.coin = AcxStcg.ifAcxRepack(src, rcvBuf.data.sublist(6));
      }

      return (errCode);
    } else {
    // #else
      return (IfAcxDef.MSG_ACROK);
    // #endif
    }
  }
}
