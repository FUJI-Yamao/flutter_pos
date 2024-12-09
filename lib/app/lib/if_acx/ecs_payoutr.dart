/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'acx_stcg.dart';

/// 関連tprxソース:ecs_download.c
class EcsDownload {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsPayOutRead()
  /// * 機能概要      : 払出枚数リードコマンド送信ライブラリ(富士電機製釣銭釣札機 ECS-777)
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsPayOutRead(TprTID src) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(40, (_) => "\x30");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_777) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      sendBuf.fillRange(0, sendBuf.length, "\x30");
      sendBuf[len++] = TprDefAsc.DC1; /* 0x11 */
      sendBuf[len++] = IfAcxDef.ECS_PAYOUTREAD; /* 0x71 */
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

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsPayOutReadGet()
  /// * 機能概要      : 払出枚数リードコマンド返信取得ライブラリ(富士電機製釣銭釣札機 ECS-777)
  /// * 引数          : TprTID src
  /// *		             ECS_PAYOUT *ecsPayOut
  /// *		             TprMsgDevReq2_t *rcvBuf
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifEcsPayOutReadGet(TprTID src, EcsPayout ecsPayOut, TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> readBuf = List.generate(30, (_) => "0x00");
      int idx;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_777) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode == IfAcxDef.MSG_ACROK) {
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }

      if (errCode != IfAcxDef.MSG_ACROK) {
        return (errCode); // NG return !
      }

      for (idx = 0; idx < readBuf.length; idx++) {
        readBuf[idx] = (rcvBuf.data[idx + 2].codeUnitAt(0) & 0x3f).toString();
      }

      ecsPayOut.payoutCoin500 = AcxStcg.ifAcxRepack(src, readBuf.sublist(0));
      ecsPayOut.payoutCoin100 = AcxStcg.ifAcxRepack(src, readBuf.sublist(3));
      ecsPayOut.payoutCoin50 = AcxStcg.ifAcxRepack(src, readBuf.sublist(6));
      ecsPayOut.payoutCoin10 = AcxStcg.ifAcxRepack(src, readBuf.sublist(9));
      ecsPayOut.payoutCoin5 = AcxStcg.ifAcxRepack(src, readBuf.sublist(12));
      ecsPayOut.payoutCoin1 = AcxStcg.ifAcxRepack(src, readBuf.sublist(15));
      ecsPayOut.payoutBill10000 = AcxStcg.ifAcxRepack(src, readBuf.sublist(18));
      ecsPayOut.payoutBill5000 = AcxStcg.ifAcxRepack(src, readBuf.sublist(21));
      ecsPayOut.payoutBill2000 = AcxStcg.ifAcxRepack(src, readBuf.sublist(24));
      ecsPayOut.payoutBill1000 = AcxStcg.ifAcxRepack(src, readBuf.sublist(27));

      return (errCode);
    } else {
    // #else
      return (IfAcxDef.MSG_ACROK);
    // #endif
    }
  }
}
