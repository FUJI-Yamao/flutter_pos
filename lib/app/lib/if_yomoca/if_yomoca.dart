/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/apl/compflag.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_type.dart';

/// 関連tprxソース: if_yomoca.c
class IfYomoca {
  /// 関連tprxソース: if_yomoca.c - if_yomoca_disable
  static int ifYomocaDisable(TprTID src) {
    if (!CompileFlag.PPSDVS) {
      List<String> sendBuf = [];
      int len = 1;
      int errCode = ifYomocaTransmit(src, TprDidDef.TPRDEVOUT, sendBuf, len);
      return errCode;
    } else {
      return 0;
    }
  }

  /// 処理概要：Ｙｏｍｏｃａの機能を有効にする。
  /// パラメータ：TprTID src
  /// 戻り値：int YOMOCA_NORMAL  正常終了
  ///           YOMOCA_SENDERR 異常終了
  /// 関連tprxソース: if_yomoca.c - if_yomoca_enable
  static int ifYomocaEnable(TprTID src) {
    // TODO:コンパイルSW
    //#ifndef PPSDVS
    List<String> sendBuf = [];

    sendBuf[0] = "1";
    int errCode = ifYomocaTransmit(src, TprDidDef.TPRDEVOUT, sendBuf, 1);
    return errCode;
    //#else
    //return( YOMOCA_NORMAL );
    //#endif
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: if_yomoca.c - if_yomoca_Transmit
  static int ifYomocaTransmit(
      TprTID src, int inOut, List<String> sendData, int len) {
    return 0;
  }
}
