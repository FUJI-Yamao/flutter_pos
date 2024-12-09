/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'acx_sset.dart';

/// 関連tprxソース:acx_ssw50.c
class AcxSsw50 {
  // #ifndef PPSDVS
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb50Ssw50Set()
  /// * 機能概要      : ssw50 Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb50Ssw50Set(TprTID src) async {
    int sswNo;
    int kind;
    int sendRes;
    List<int> setData = [];

    kind = 0;
    sswNo = 50;
    setData[0] = 0x08;

    sendRes = await AcxSset.ifAcb20SswCmdSend(src, kind, sswNo, setData);

    return sendRes;
  }
  // #endif

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcbSsw50Set()
  /// * 機能概要      : ssw50 Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcbSsw50Set(TprTID src) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      switch (AcxCom.ifAcbSelect()) {
        case CoinChanger.ACB_10:
        case CoinChanger.ACB_20:
        case CoinChanger.SST1:
        case CoinChanger.FAL2:
          errCode = await AcxCom.ifAcxCmdSkip(src, ifAcbSsw50Set); //処理なし
          break;
        case CoinChanger.ACB_50_:
        case CoinChanger.ACB_200:
        case CoinChanger.RT_300:
          errCode = await ifAcb50Ssw50Set(src);
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