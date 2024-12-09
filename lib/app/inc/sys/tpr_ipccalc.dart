/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'tpr_ipc.dart';

/// プロセス間通信メッセージ構造（パラメタ設定）
///  関連tprxソース:tpripc.h

class TprIpcCalc {
  static void Set_TprCommon(String buf, TprCommon res) {
    res.mid = int.tryParse(buf.substring(0, 3)) ?? 0; //4Byte
    res.length = int.tryParse(buf.substring(4, 7)) ?? 0; //4Byte
  }

  static void Set_TprSysFail(String buf, TprSysFail res) {
    res.mid = int.tryParse(buf.substring(0, 3)) ?? 0; //4Byte
    res.length = int.tryParse(buf.substring(4, 7)) ?? 0; //4Byte
    res.errnum = int.tryParse(buf.substring(8, 11)) ?? 0; //4Byte
  }

  static void Set_TprtStat(String buf, TprtStat res) {
    res.mid = int.tryParse(buf.substring(0, 3)) ?? 0; //4Byte
    res.length = int.tryParse(buf.substring(4, 7)) ?? 0; //4Byte
    res.tid = int.tryParse(buf.substring(8, 11)) ?? 0; //4Byte
    res.mode = int.tryParse(buf.substring(12, 15)) ?? 0; //4Byte
  }

  static void Set_TprTimReq(String buf, TprTimReq res) {
    res.mid = int.tryParse(buf.substring(0, 3)) ?? 0; //4Byte
    res.length = int.tryParse(buf.substring(4, 7)) ?? 0; //4Byte
    res.sec = int.tryParse(buf.substring(8, 11)) ?? 0; //4Byte
    res.msec = int.tryParse(buf.substring(12, 15)) ?? 0; //4Byte
    res.timID = int.tryParse(buf.substring(16, 19)) ?? 0; //4Byte
    res.drvno = int.tryParse(buf.substring(20, 23)) ?? 0; //4Byte
  }

  static void Set_TprTim(String buf, TprTim res) {
    res.mid = int.tryParse(buf.substring(0, 3)) ?? 0; //4Byte
    res.length = int.tryParse(buf.substring(4, 7)) ?? 0; //4Byte
    res.timID = int.tryParse(buf.substring(12, 15)) ?? 0; //4Byte
  }

  static void Set_TprMsgDevReq(String buf, TprMsgDevReq res, int datalen) {
    res.mid = int.tryParse(buf.substring(0, 3)) ?? 0; //4Byte
    res.length = int.tryParse(buf.substring(4, 7)) ?? 0; //4Byte
    res.tid = int.tryParse(buf.substring(8, 11)) ?? 0; //4Byte
    res.io = int.tryParse(buf.substring(12, 15)) ?? 0; //4Byte
    res.result = int.tryParse(buf.substring(16, 19)) ?? 0; //4Byte
    res.datalen = int.tryParse(buf.substring(20, 23)) ?? 0; //4Byte
    //res.data = buf.substring(24, 24 + datalen - 1);	//String
  }

  static void Set_TprMsgDevReq2(String buf, TprMsgDevReq2 res, int datalen) {
    res.mid = int.tryParse(buf.substring(0, 3)) ?? 0; //4Byte
    res.length = int.tryParse(buf.substring(4, 7)) ?? 0; //4Byte
    res.tid = int.tryParse(buf.substring(8, 11)) ?? 0; //4Byte
    res.src = int.tryParse(buf.substring(12, 15)) ?? 0; //4Byte
    res.io = int.tryParse(buf.substring(16, 19)) ?? 0; //4Byte
    res.result = int.tryParse(buf.substring(20, 23)) ?? 0; //4Byte
    res.datalen = int.tryParse(buf.substring(24, 27)) ?? 0; //4Byte
    //res.data = buf.substring(28, 28 + datalen - 1);	//String
  }

  static void Set_TprMsgDevReq3(String buf, TprMsgDevReq3 res, int datalen) {
    res.mid = int.tryParse(buf.substring(0, 3)) ?? 0; //4Byte
    res.length = int.tryParse(buf.substring(4, 7)) ?? 0; //4Byte
    res.tid = int.tryParse(buf.substring(8, 11)) ?? 0; //4Byte
    res.src = int.tryParse(buf.substring(12, 15)) ?? 0; //4Byte
    res.io = int.tryParse(buf.substring(16, 19)) ?? 0; //4Byte
    res.result = int.tryParse(buf.substring(20, 23)) ?? 0; //4Byte
    res.tout = int.tryParse(buf.substring(24, 27)) ?? 0; //4Byte
    res.datalen = int.tryParse(buf.substring(28, 31)) ?? 0; //4Byte
    //res.data = buf.substring(32, 32 + datalen - 1);	//String
  }

  static void Set_TprMsg(String buf, TprMsg res, int datalen) {
    int sizoft = 0;
    int reqsiz = 24 + datalen;
    int req2siz = 28 + datalen;
    int req3siz = 32 + datalen;
    Set_TprCommon(buf.substring(0, 7), res.common); //8Byte
    Set_TprSysFail(buf.substring(8, 19), res.sysfail); //12Byte
    Set_TprCommon(buf.substring(20, 27), res.sysfailack); //8Byte
    Set_TprtStat(buf.substring(28, 43), res.taskstat); //16Byte
    Set_TprtStat(buf.substring(44, 59), res.sysnotify); //16Byte
    Set_TprtStat(buf.substring(60, 75), res.sysnotifyack); //16Byte
    Set_TprTimReq(buf.substring(76, 99), res.timereq); //24Byte
    Set_TprTim(buf.substring(100, 111), res.timeout); //12Byte
    sizoft = 112;
    Set_TprMsgDevReq(
        buf.substring(sizoft + (reqsiz * 0), sizoft + (reqsiz * 1) - 1),
        res.devreq,
        datalen); //24+aByte
    Set_TprMsgDevReq(
        buf.substring(sizoft + (reqsiz * 1), sizoft + (reqsiz * 2) - 1),
        res.devack,
        datalen); //24+aByte
    Set_TprMsgDevReq(
        buf.substring(sizoft + (reqsiz * 2), sizoft + (reqsiz * 3) - 1),
        res.devnotify,
        datalen); //24+aByte
    sizoft += (reqsiz * 3);
    Set_TprMsgDevReq2(
        buf.substring(sizoft + (req2siz * 0), sizoft + (req2siz * 1) - 1),
        res.devreq2,
        datalen); //28+aByte
    Set_TprMsgDevReq2(
        buf.substring(sizoft + (req2siz * 1), sizoft + (req2siz * 2) - 1),
        res.devack2,
        datalen); //28+aByte
    Set_TprMsgDevReq2(
        buf.substring(sizoft + (req2siz * 2), sizoft + (req2siz * 3) - 1),
        res.devnotify2,
        datalen); //28+aByte
    sizoft += (req2siz * 3);
    Set_TprMsgDevReq3(
        buf.substring(sizoft + (req3siz * 0), sizoft + (req3siz * 1) - 1),
        res.devreq3,
        datalen); //32+aByte
    Set_TprMsgDevReq3(
        buf.substring(sizoft + (req3siz * 1), sizoft + (req3siz * 2) - 1),
        res.devack3,
        datalen); //32+aByte
    Set_TprMsgDevReq3(
        buf.substring(sizoft + (req3siz * 2), sizoft + (req3siz * 3) - 1),
        res.devnotify3,
        datalen); //32+aByte
    sizoft += (req3siz * 3);
    Set_TprSysFail(buf.substring(sizoft, sizoft + 11), res.apl); //12Byte
  }
}
