/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:convert';
import 'dart:io';

import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:get/get.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import '../cm_chg/ltobcd.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_sset.c
class AcxSset {
  static const WAIT_TIME = 100000; /* 0.1s */

  // TODO:コンパイルSW
  //#ifndef PPSDVS
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20StateSet()
  /// * 機能概要      : Coin/Bill Changer near full, near end & State Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb20StateSet(TprTID src) async {
    int sswNo;
    int kind;
    int sendRes;
    List<int> setData = [];

    kind = 1;

    for (sswNo = 1; sswNo <= 25; sswNo++) {
      setData[0] = ifAcb20SswSet(sswNo);
      if (setData[0] < 0) {
        continue;
      }

      sleep(const Duration(microseconds: WAIT_TIME));

      sendRes = await ifAcb20SswCmdSend(src, kind, sswNo, setData);
      if (sendRes != IfAcxDef.MSG_ACROK) {
        return sendRes;
      }
    }
    return IfAcxDef.MSG_ACROK;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20SswSet()
  /// * 機能概要      : Coin/Bill Changer near full, near end & State Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifAcb20SswSet(int sswNo) {
    int setData;

    switch (sswNo) {
      case 23:
        setData = 0x00e8;
        break;
      default:
        setData = -2;
        break;
    }

    return setData;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20SswSet()
  /// * 機能概要      : Coin/Bill Changer near full, near end & State Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb20SswCmdSend(TprTID src, int kind, int sswNo,
      List<int> setData) async {
    int errCode;
    List<String> sendBuf = List.generate(10, (_) => "");
    int len;
    String sswNoBcd;

    // init : Send Buffer
    sendBuf.fillRange(0, sendBuf.length, "\x00");

    sswNoBcd = Ltobcd.cmLtobcd(sswNo, sswNo.bitLength);

    sendBuf[0] = TprDefAsc.DC1;
    if ((AcxCom.ifAcbSelect() & CoinChanger.RT_300_X) != 0) {
      sendBuf[1] = IfAcxDef.ACR_SSWSET2; //既存のコマンドも使用可能だが、全てのssw設定を拡張コマンドにて対応とする
      sendBuf[6] = latin1.decode([((sswNo >> 4) | 0x30)]);
      sendBuf[7] = latin1.decode([((sswNo & 0x0f) | 0x30)]);
    }
    else {
      sendBuf[1] = IfAcxDef.ACR_SSWSET;
      sendBuf[6] = latin1.decode([((int.parse(sswNoBcd) >> 4) | 0x30)]);
      sendBuf[7] = latin1.decode([((int.parse(sswNoBcd) & 0x0f) | 0x30)]);
    }
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x36";
    sendBuf[4] = "\x30";
    sendBuf[5] = latin1.decode([kind | 0x30]);
    sendBuf[8] = latin1.decode([((setData[0] >> 4) | 0x30)]);
    sendBuf[9] = latin1.decode([((setData[0] & 0x0f) | 0x30)]);

    len = 10;

    //     transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb10StateSet()
  /// * 機能概要      : Coin/Bill Changer near full, near end & State Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb10StateSet(TprTID src, NearEnd nearEnd) async {
    // near full data dummy 5000 2000 1000 500 100 50 10 5 1 dummy
    List<String> nearFullData = [
      "000" // dummy
      "080" // 5000
      "080" // 2000
      "280" // 1000
      "060" //  500
      "110" //  100
      "130" //   50
      "110" //   10
      "120" //    5
      "130" //    1
      "000" // dummy
    ];
    String stateData = "\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00";
    int errCode;
    List<String> sendBuf = List.generate(80, (_) => "");
    int len;

    // init : Send Buffer
    sendBuf.fillRange(0, sendBuf.length, "\x00");

    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = "\x5D";
    sendBuf[2] = "\x34";
    sendBuf[3] = "\x36";

    //  near full data set
    sendBuf.addAll(nearFullData);

    //  near end data set (5000,2000,1000,500,100,50,10,5,1)
    sendBuf.add(nearEnd.bill5000.toString().padLeft(3, "\x00"));
    sendBuf.add(nearEnd.bill2000.toString().padLeft(3, "\x00"));
    sendBuf.add(nearEnd.bill1000.toString().padLeft(3, "\x00"));
    sendBuf.add(nearEnd.coin500.toString().padLeft(3, "\x00"));
    sendBuf.add(nearEnd.coin100.toString().padLeft(3, "\x00"));
    sendBuf.add(nearEnd.coin50.toString().padLeft(3, "\x00"));
    sendBuf.add(nearEnd.coin10.toString().padLeft(3, "\x00"));
    sendBuf.add(nearEnd.coin5.toString().padLeft(3, "\x00"));
    sendBuf.add(nearEnd.coin1.toString().padLeft(3, "\x00"));

    //  state data set
    sendBuf.add(stateData);

    len = 74;

    //     transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  // #endif

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20SswSet()
  /// * 機能概要      : Coin/Bill Changer near full, near end & State Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcbStateSet(TprTID src, NearEnd nearEnd) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      switch (AcxCom.ifAcbSelect()) {
        case CoinChanger.ACB_10:
          errCode = await ifAcb10StateSet(src, nearEnd);
          break;
        case CoinChanger.ACB_20:
        case CoinChanger.ACB_50_:
        case CoinChanger.ACB_200:
        case CoinChanger.RT_300:
          errCode = await ifAcb20StateSet(src);
          break;
        case CoinChanger.SST1:
        case CoinChanger.FAL2:
        case CoinChanger.ECS:
        case CoinChanger.ECS_777:
          errCode = await AcxCom.ifAcxCmdSkip(src, ifAcbStateSet); //処理なし
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
