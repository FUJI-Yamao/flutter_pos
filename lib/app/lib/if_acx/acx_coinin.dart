/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'ecs_cont.dart';
import 'fal2_coinin.dart';

/// 関連tprxソース:acx_coinin.c
class AcxCoinIn {
  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxCoinInsert()
  /// * 機能概要      : 硬貨投入コマンド送信ライブラリ  (NEC製釣銭釣札機(FAL2)
  /// * 引数          : TprTID src
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxCoinInsert(TprTID src) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;

      switch (AcxCom.ifAcbSelect()) {
        case CoinChanger.ACB_10:
        case CoinChanger.ACB_20:
        case CoinChanger.ACB_50_:
        case CoinChanger.ACB_200:
        case CoinChanger.RT_300:
        case CoinChanger.SST1:
          errCode = await AcxCom.ifAcxCmdSkip(src, ifAcxCoinInsert); //処理なし
          break;
        case CoinChanger.FAL2:
          errCode = await Fal2CoinIn.ifFal2CoinInsert(src);
          break;
        case CoinChanger.ECS:
        case CoinChanger.ECS_777:
          errCode = await EcsCont.ifEcsCinContinue(src);
          break;
        default:
          errCode = IfAcxDef.MSG_ACRFLGERR;
          break;
      }

      return errCode;
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
