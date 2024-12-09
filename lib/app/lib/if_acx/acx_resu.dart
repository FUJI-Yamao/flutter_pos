/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/drv/ffi/library.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'fal2_statuss.dart';

/// 関連tprxソース:acx_resu.c
class AcxResu {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxResultGet()
  /// * 機能概要      : Coin/Bill Changer & Coin Changer Result Get
  /// * 引数          : TprTID src
  /// *                 TprMsgDevReq2_t rcvBuf
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  ///  関連tprxソース: acx_resu.c- if_acx_ResultGet
  static int ifAcxResultGet(TprTID src, TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      int offset = 0;
      int myAddress = 0;
      int othAddress = 0;

      switch (AcxCom.ifAcbSelect()) {
        case CoinChanger.FAL2:
          myAddress = (int.parse(rcvBuf.data[1]) & 0x0f);
          othAddress = (int.parse(rcvBuf.data[2]) >> 4);
          if ((myAddress == 0) && (othAddress == 0)) {
            //本来存在しないフォーマット。特殊処理を行う。(ENQの代わり)
            errCode = ifFal2SpResultGet(src, rcvBuf);
            return errCode;
          }
          offset = 5;
          break;
        default:
          offset = 0;
          break;
      }

      if (!isDummyAcx()) {
        errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);

        if (errCode == IfAcxDef.MSG_ACROK) {
          //  OK !  next
          errCode = AcxCom.ifAcxResultChk(src, rcvBuf.data[offset]);
        }
      } else {
        errCode = IfAcxDef.MSG_ACROK;
      }
      return errCode;
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
  ///  関連tprxソース: acx_resu.c- if_fal2_SpResultGet
  static int ifFal2SpResultGet(TprTID src, TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      StateFal2 stateFal2 = StateFal2();

      errCode = Fal2Statuss.ifFal2StatSenseGet(src, stateFal2, rcvBuf);

      if (errCode == IfAcxDef.MSG_ACROK) {
        // OK !  next
        errCode = Fal2Statuss.ifFal2StatSenseGetUnitInfoChk(src, stateFal2, null);
      }

      return errCode;
    // #else
    } else {
      return (IfAcxDef.MSG_ACROK);
    // #endif
    }
  }
}
