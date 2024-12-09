/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_memg.c
class AcxMemg {
  // TODO:コンパイルSW
  //#ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb50DrwOpen()
  /// * 機能概要      : Coin Changer Memory Data Get
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  int ifAcxMemoryGet(TprTID src, List<String> ptData, TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int bcdPint;
      String bcdData;
      int errCode;

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);

      if (errCode == IfAcxDef.MSG_ACROK) {
        //  OK !  next
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }
      if (errCode != IfAcxDef.MSG_ACROK) {
        return errCode; // NG return
      }
      //  OK !  next

      // make BCD data
      for (bcdPint = 0; bcdPint < 32; bcdPint++) {
        ptData[bcdPint] = (int.parse(rcvBuf.data[2 + (bcdPint * 2)]) << 4).toString();
        bcdData = (int.parse(rcvBuf.data[2 + ((bcdPint * 2) + 1)]) & 0x0f).toString();
        ptData[bcdPint] = (int.parse(ptData[bcdPint]) | int.parse(bcdData)).toString();
      }

      return IfAcxDef.MSG_ACROK;
      // #else
    } else {
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
