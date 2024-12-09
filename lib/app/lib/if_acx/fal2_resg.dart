/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:fal2_resg.c
class Fal2Resg {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2ResultGet()
  /// * 機能概要      : 1バイトコードレスポンス取得ライブラリ
  /// * 引数          : TprTID src
  /// *             		TprMsgDevReq2_t *rcvBuf
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifFal2ResultGet(TprTID src, TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode != IfAcxDef.MSG_ACROK) {
        return (errCode); // NG return !
      }

      if (errCode == IfAcxDef.MSG_ACROK) { // Header OK
        errCode = AcxCom.ifAcxResultChk(src, rcvBuf.data[5]);
      }

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2ResFormatChk()
  /// * 機能概要      : コマンドレスポンスフォーマット確認ライブラリ
  /// * 引数          : TprTID src
  /// *             		TprMsgDevReq2_t *rcvBuf
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifFal2ResFormatChk(TprTID src, TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      String cmd;

      cmd = rcvBuf.data[5];

      switch (cmd) {
        case TprDefAsc.DLE:
          errCode = IfAcxDef.MSG_ACROK;
          break;
        case TprDefAsc.BEL:
          errCode = IfAcxDef.MSG_ACRACT;
          break;
        case TprDefAsc.CAN:
          errCode = DlgConfirmMsgKind.MSG_TEXT37.index;
          break;
        default:
          errCode = IfAcxDef.MSG_ACRERROR;
          break;
      }

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
