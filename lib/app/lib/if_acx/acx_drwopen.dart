/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:convert';

import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_drwopen.c
class AcxDrwOpen {
  // TODO:コンパイルSW
  //#ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb50DrwOpen()
  /// * 機能概要      : Drawer Open / Close
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb50DrwOpen(TprTID src, int data) async {
    int errCode;
    List<String> sendBuf = List.generate(6, (_) => "");
    int len;

    //  Send Buffer set
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_DRWOPEN;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x32";
    sendBuf[4] = "\x30";
    sendBuf[5] = latin1.decode([data | 0x30]);
    len = 6;

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsDrwOpen()
  /// * 機能概要      : Drawer Open / Close
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsDrwOpen(TprTID src, int data) async {
    int errCode;
    List<String> sendBuf = List.generate(4, (_) => "");
    int len = 0;

    if (data == AcrDrawerLockFlg.ACR_DRW_LOCK.index) {
      //閉じるがECSではないので処理せず
      errCode = await AcxCom.ifAcxCmdSkip(src, ifEcsDrwOpen);
      return errCode;
    }

    //  Send Buffer set
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ECS_DRWOPEN;
    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x30";

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }
  // #endif

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsDrwOpen()
  /// * 機能概要      : Drawer Open / Close
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxDrwOpen(TprTID src, int data) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      switch (AcxCom.ifAcbSelect()) {
        case CoinChanger.ACB_10:
        case CoinChanger.ACB_20:
        case CoinChanger.SST1:
          errCode = IfAcxDef.MSG_ACROK;
          break;
        case CoinChanger.ECS:
        case CoinChanger.ECS_777:
          errCode = await ifEcsDrwOpen(src, data);
          break;
        case CoinChanger.ACB_50_:
        case CoinChanger.ACB_200:
        case CoinChanger.RT_300:
          errCode = await ifAcb50DrwOpen(src, data);
          break;
        case CoinChanger.FAL2:
        default:
          errCode = IfAcxDef.MSG_ACRFLGERR;
          break;
      }

      return errCode;
    // #else
    } else {
      return (IfAcxDef.MSG_ACROK);
    }
    // #endif
  }
}
