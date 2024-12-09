/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:fal2_coinin.c
class Fal2CoinIn {
  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxCoinInsert()
  /// * 機能概要      : 硬貨投入コマンド送信ライブラリ  (NEC製釣銭釣札機(FAL2)
  /// * 引数          : TprTID src
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifFal2CoinInsert(TprTID src) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(40, (_) => "");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.FAL2) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      sendBuf[len++] = "\x80";
      sendBuf[len++] = IfAcxDef.FAL2_COININSERT;
      sendBuf[len++] = "\x00";
      sendBuf[len++] = "\x00";

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
