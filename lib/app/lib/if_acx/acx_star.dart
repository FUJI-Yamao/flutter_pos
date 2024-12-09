/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_star.c
class AcxStar {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcbStateRead()
  /// * 機能概要      : Coin/Bill Changer Status Send
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcbStateRead(TprTID src) async {
    int errCode;
    List<String> sendBuf = List.generate(4, (_) => "");
    int len;

    // init : Send Buffer
    sendBuf.fillRange(0, sendBuf.length, '\x00');

    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = "\x56";
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x30";
    len = 4;

    // transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrStateRead()
  /// * 機能概要      : Coin      Changer Status Send
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcrStateRead(TprTID src) async {
    int errCode;
    String sendBuf = "\x00";
    int len;

    //  Buffer set(Status Get Command)
    sendBuf = TprDefAsc.ENQ;
    len = 1;
    // transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, [sendBuf], len);

    return errCode;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxStateRead()
  /// * 機能概要      : Coin/Bill Changer Status Read
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxStateRead(TprTID src, int changerFlg) async {
    int errCode;
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      // Coin/Bill Changer ?
      if (changerFlg == CoinChanger.ACR_COINBILL) {
        errCode = await ifAcbStateRead(src);
      } else {
        // Coin      Changer ?
        if (changerFlg == CoinChanger.ACR_COINONLY) {
          errCode = await ifAcrStateRead(src);
        } else {
          // changerFlg NG !
          errCode = IfAcxDef.MSG_ACRFLGERR;
        }
      }

      return errCode;
    } else {
    // #else
      return (IfAcxDef.MSG_ACROK);
    // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcbState80Read()
  /// * 機能概要      :
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcbState80Read(TprTID src) async {
    //TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(6, (_) => "");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ACB_50_X) == 0) {
        return IfAcxDef.MSG_ACRFLGERR;
      }
      sendBuf.fillRange(0, sendBuf.length, "\x30");
      sendBuf[len++] = TprDefAsc.DC1;
      sendBuf[len++] = IfAcxDef.ACR_STATEREAD;
      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x32";
      sendBuf[len++] = "\x38";
      sendBuf[len++] = "\x30";

      //  transmit a message
      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return errCode;
    } else {
    // #else
      return IfAcxDef.MSG_ACROK;
    // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcbStateLastDataRead()
  /// * 機能概要      :
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcbStateLastDataRead(TprTID src, int type) async {
    //TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(6, (_) => "");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ACB_50_X) == 0) {
        return IfAcxDef.MSG_ACRFLGERR;
      }
      sendBuf.fillRange(0, sendBuf.length, "\x30");
      sendBuf[len++] = TprDefAsc.DC1;
      sendBuf[len++] = IfAcxDef.ACR_STATEREAD;
      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x32";
      if (type == AcrUnitCmd.BILL_CMD.index) {
        sendBuf[len++] = "\x38";
        sendBuf[len++] = "\x32";
      } else {
        sendBuf[len++] = "\x30";
        sendBuf[len++] = "\x34";
      }

      //  transmit a message
      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return errCode;
    } else {
    // #else
      return IfAcxDef.MSG_ACROK;
    // #endif
    }
  }
}
