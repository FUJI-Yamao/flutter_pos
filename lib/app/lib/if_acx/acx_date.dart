/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import '../cm_sys/sysdate.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_date.c
class AcxDate {
  // TODO:コンパイルSW
  // #ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名    : int ifAcbDateTimeSet()
  /// * 機能概要  : 日付、時間を設定
  /// * 引数      : TprTID src
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcbDateTimeSet(TprTID src) async {
    int errCode = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(14, (_) => "");
    int len;
    DateTime dt;

    //  System Date & Time Get/
    // cm_clr((char *) & dt, sizeof(dt));
    dt = SysDate().cmReadSysdate();

    /*  Send Buffer set(Date & Time Command) */
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_DATETIMESET;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x3a";
    AcxCom.ifAcxDecToAscii(src, dt.year - 100, sendBuf.sublist(4));
    AcxCom.ifAcxDecToAscii(src, dt.month + 1, sendBuf.sublist(6));
    AcxCom.ifAcxDecToAscii(src, dt.day, sendBuf.sublist(8));
    AcxCom.ifAcxDecToAscii(src, dt.hour, sendBuf.sublist(10));
    AcxCom.ifAcxDecToAscii(src, dt.minute, sendBuf.sublist(12));
    len = 14;

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  // #endif

  // TODO:コンパイルSW
  // #ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名    : int ifAcb200DateTimeSet()
  /// * 機能概要  :　日付、時間を設定
  /// * 引数      : TprTID src
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb200DateTimeSet(TprTID src) async {
    int errCode = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(16, (_) => "");
    int len;
    DateTime dt;

    //  System Date & Time Get
    // cm_clr((char *) & dt, sizeof(dt));
    dt = SysDate().cmReadSysdate();

    //  Send Buffer set(Date & Time Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_DATETIMESET;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x3c";
    AcxCom.ifAcxDecToAscii(src, dt.year - 100, sendBuf.sublist(4));
    AcxCom.ifAcxDecToAscii(src, dt.month + 1, sendBuf.sublist(6));
    AcxCom.ifAcxDecToAscii(src, dt.day, sendBuf.sublist(8));
    AcxCom.ifAcxDecToAscii(src, dt.hour, sendBuf.sublist(10));
    AcxCom.ifAcxDecToAscii(src, dt.minute, sendBuf.sublist(12));
    AcxCom.ifAcxDecToAscii(src, dt.second, sendBuf.sublist(14));
    len = 16;

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  // #endif

  // TODO:コンパイルSW
  // #ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名    : int ifSst1DateTimeSet()
  /// * 機能概要  :　日付、時間を設定
  /// * 引数      : TprTID src
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifSst1DateTimeSet(TprTID src) async {
    int errCode = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(16, (_) => "");
    int len;
    DateTime dt;

    //  System Date & Time Get
    // cm_clr((char *) & dt, sizeof(dt));
    dt = SysDate().cmReadSysdate();

    //  Send Buffer set(Date & Time Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.SST1_DATETIMESET;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x3c";
    AcxCom.ifAcxDecToAscii(src, dt.year - 100, sendBuf.sublist(4));
    AcxCom.ifAcxDecToAscii(src, dt.month + 1, sendBuf.sublist(6));
    AcxCom.ifAcxDecToAscii(src, dt.day, sendBuf.sublist(8));
    AcxCom.ifAcxDecToAscii(src, dt.hour, sendBuf.sublist(10));
    AcxCom.ifAcxDecToAscii(src, dt.minute, sendBuf.sublist(12));
    AcxCom.ifAcxDecToAscii(src, dt.second, sendBuf.sublist(14));
    len = 16;

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  // #endif

  // TODO:コンパイルSW
  // #ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名    : int ifEcsDateTimeSet()
  /// * 機能概要  :　日付、時間を設定
  /// * 引数      : TprTID src
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsDateTimeSet(TprTID src) async {
    int errCode = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(18, (_) => "");
    int len;
    DateTime dt;

    //  System Date & Time Get
    // cm_clr((char *) & dt, sizeof(dt));
    dt = SysDate().cmReadSysdate();

    //  Send Buffer set(Date & Time Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ECS_DATETIMESET;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x3e";

    String temp = (dt.year + 1900).toString().padLeft(5, "0");
    for (int i = 0; i < 5; i++) {
      sendBuf[4+i] = temp[0];
    }
    AcxCom.ifAcxDecToAscii(src, dt.month + 1, sendBuf.sublist(8));
    AcxCom.ifAcxDecToAscii(src, dt.day, sendBuf.sublist(10));
    AcxCom.ifAcxDecToAscii(src, dt.hour, sendBuf.sublist(12));
    AcxCom.ifAcxDecToAscii(src, dt.minute, sendBuf.sublist(14));
    AcxCom.ifAcxDecToAscii(src, dt.second, sendBuf.sublist(16));
    len = 18;

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  // #endif

  ///*--------------------------------------------------------------------------------
  /// * 関数名    : int ifAcxDateTimeSet()
  /// * 機能概要  :　日付、時間を設定
  /// * 引数      : TprTID src
  /// *           : int changerFlg
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxDateTimeSet(TprTID src, int changerFlg) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      // Coin/Bill Changer ?
      if (changerFlg == CoinChanger.ACR_COINBILL) {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
            errCode = await ifAcbDateTimeSet(src);
            break;
          case CoinChanger.ACB_200:
          case CoinChanger.RT_300:
            errCode = await ifAcb200DateTimeSet(src);
            break;
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            errCode = await ifEcsDateTimeSet(src);
            break;
          case CoinChanger.SST1:
          case CoinChanger.FAL2:
            errCode = await ifSst1DateTimeSet(src);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      }
      // Coin Changer ?/
      else if (changerFlg == CoinChanger.ACR_COINONLY) {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            errCode = await ifEcsDateTimeSet(src);
            break;
          default:
            errCode = await ifAcbDateTimeSet(src); //RT-200か判別できないため、秒無し送信
            break;
        }
      }
      else {
        errCode = IfAcxDef.MSG_ACRFLGERR;
      }
      return errCode;
      // #else
    } else {
      return IfAcxDef.MSG_ACROK;
      // #endif
    }
  }
}
