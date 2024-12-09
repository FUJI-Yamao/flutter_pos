/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../../inc/lib/if_acx.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_cstp.c
class AcxCstp{
  // TODO:コンパイルSW
  //#ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20CinStop()
  /// * 機能概要      :
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb20CinStop(TprTID src) async {
    int errCode;
    List<String> sendBuf = List.generate(4, (_) => "0");
    int len;

    // Send Buffer set(Cin Stop Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_CINSTOP;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x30";
    len = 4;

    // transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrCinStop()
  /// * 機能概要      :
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcrCinStop(TprTID src) async {
    int errCode;
    List<String> sendBuf = List.generate(4, (_) => "0");
    int len;

    // Send Buffer set(Cin Stop Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_CINSTOP;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x30";
    len = 4;

    // transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }
  //#endif

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxCinStop()
  /// * 機能概要      :
  /// * 引数          : TprTID src
  ///                : int changerFlg
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxCinStop(TprTID src, int changerFlg) async {
    // TODO:コンパイルSW
//#ifndef PPSDVS
    if (true) {
      int errCode;

      // Coin/Bill Changer ?
      if (changerFlg == CoinChanger.ACR_COINBILL) {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.RT_300:
          case CoinChanger.SST1:
            errCode = await ifAcb20CinStop(src);
            break;
          case CoinChanger.ECS:
          case CoinChanger.FAL2:
          case CoinChanger.ECS_777:
            errCode = await AcxCom.ifAcxCmdSkip(src, ifAcxCinStop); //処理なし
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      }
      // Coin Changer ?
      else if (changerFlg == CoinChanger.ACR_COINONLY) {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            errCode = IfAcxDef.MSG_ACROK; //処理なし
            break;
          default:
            errCode = await ifAcrCinStop(src);
            break;
        }
      }
      // Changer_flg NG !
      else {
        errCode = IfAcxDef.MSG_ACRFLGERR;
      }

      return errCode;
    }
//#else
    else {
      return (IfAcxDef.MSG_ACROK);
//#endif
    }
  }
}
