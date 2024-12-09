/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:json_annotation/json_annotation.dart';

import 'tpr_type.dart';
part 'tpr_ipc.g.dart';

/// プロセス間通信メッセージ構造
///  関連tprxソース:tpripc.h

/// TPRMID_SYSFAILACK
class TprCommon {
  TprMID mid = 0; /* an area of the message receiving */
  int length = 0; /* extention data length */
}

typedef TprCommon_t = TprCommon;
typedef TprSysFailAck_t = TprCommon;

/// TPRMID_SYSFAIL
class TprSysFail {
  TprMID mid = 0; /* an area of the message receiving */
  int length = 0; /* extention data length */
  int errnum = 0; /* error status of system operation */
}

typedef TprSysFail_t = TprSysFail;
typedef TprApl_t = TprSysFail;

/// TPRMID_READY, TPRMID_NO_READY, TPRMID_CO_READY, TPRMIT_NO_CO_READY, TPRMID_SYSNOTIFY, TPRMID_SYSNOTIFYACK
class TprtStat {
  TprMID mid = 0; /* an area of the message receiving */
  int length = 0; /* extention data length */
  int tid = 0; /* task ID. */
  TprTID mode = 0; /* status option */
}

typedef TprtStat_t = TprtStat;
typedef TprSysNotify_t = TprtStat;
typedef TprSysNotifyAck_t = TprtStat;

/// TPRMID_TIMREQ
class TprTimReq {
  TprMID mid = 0; /* an area of the message receiving */
  int length = 0; /* extention data length */
  int sec = 0; /* sec */
  int msec = 0; /* msec(100msec=1) */
  int timID = 0; /* id set when timer was set */
  int drvno = 0; /* driver pipe No. */
}

typedef TprTimReq_t = TprTimReq;

/// TPRMID_TIMREQ
class TprTim {
  TprMID mid = 0; /* an area of the message receiving */
  int length = 0; /* extention data length */
  int timID = 0; /* id set when timer was set */
}

typedef TprTim_t = TprTim;

/// TPRMID_DEVREQ, TPRMID_DEVACK, TPRMID_DEVNOTIFY
@JsonSerializable()
class TprMsgDevReq {
  TprMID mid = 0; /* an area of the message receiving */
  int length = 0; /* extention data length */
  TprDID tid = 0; /* device ID */
  int io = 0; /* input or output */
  int result = 0; /* device I/O result */
  int datalen = 0; /* datalen & sequence No. */
  /* MSB 2bit */
  /* 00B: 1 packet data */
  /* 01B: multi packes of begining */
  /* 10B: multi packet of continued */
  /* 11B: multi packet of ending */
  List<String> data = List.generate(1024, (_) => ""); /* device data */

  TprMsgDevReq({
    this.mid = 0,
    this.length = 0,
    this.tid = 0,
    this.io = 0,
    this.result = 0,
    this.datalen = 0,
    List<String>? tmpData,
  }){
    if(tmpData != null){
      data = tmpData;
    } else {
      data = List.generate(1024, (_) => "");
    }
  }

  /// Jsonからの変換
  factory TprMsgDevReq.fromJson(Map<String, dynamic> json) =>
      _$TprMsgDevReqFromJson(json);

  /// Jsonへの変換
  Map<String, dynamic> toJson() => _$TprMsgDevReqToJson(this);
}

typedef TprMsgDevReq_t = TprMsgDevReq;
typedef TprMsgDevAck_t = TprMsgDevReq;
typedef TprMsgDevNotify_t = TprMsgDevReq;

/// TPRMID_DEVREQ, TPRMID_DEVACK, TPRMID_DEVNOTIFY
@JsonSerializable()
class TprMsgDevReq2 {
  TprMID mid = 0; /* an area of the message receiving */
  int length = 0; /* extention data length */
  TprDID tid = 0; /* device ID */
  TprTID src = 0; /* source task ID */
  int io = 0; /* input or output */
  int result = 0; /* device I/O result */
  int datalen = 0; /* datalen & sequence No. */
  /* MSB 2bit */
  /* 00B: 1 packet data */
  /* 01B: multi packes of begining */
  /* 10B: multi packet of continued */
  /* 11B: multi packet of ending */
  List<String> data = List.generate(1024, (_) => ""); /* device data */
  String dataStr = ""; /* device data */
  int payloadlen = 0; /* payloadlen */
  String payload = ""; /* printer command & string data */

  TprMsgDevReq2({
    this.mid = 0,
    this.length = 0,
    this.tid = 0,
    this.src = 0,
    this.io = 0,
    this.result = 0,
    this.datalen = 0,
    List<String>? tmpData,
    this.dataStr = "",
    this.payloadlen = 0,
    this.payload = "",
  }){
    if(tmpData != null){
      data = tmpData;
    } else {
      data = List.generate(1024, (_) => "");
    }
  }

  /// Jsonからの変換
  factory TprMsgDevReq2.fromJson(Map<String, dynamic> json) =>
      _$TprMsgDevReq2FromJson(json);

  /// Jsonへの変換
  Map<String, dynamic> toJson() => _$TprMsgDevReq2ToJson(this);
}

typedef TprMsgDevReq2_t = TprMsgDevReq2;
typedef TprMsgDevAck2_t = TprMsgDevReq2;
typedef TprMsgDevNotify2_t = TprMsgDevReq2;

/// TPRMID_DEVREQ, TPRMID_DEVACK, TPRMID_DEVNOTIFY
class TprMsgDevReq3 {
  TprMID mid = 0; /* an area of the message receiving */
  int length = 0; /* extention data length */
  TprDID tid = 0; /* device ID */
  TprTID src = 0; /* source task ID */
  int io = 0; /* input or output */
  int result = 0; /* device I/O result */
  int tout = 0; /* command timeout */
  int datalen = 0; /* data length */
  List<String> data = List.generate(1025, (_) => ""); /* device data */
}

typedef TprMsgDevReq3_t = TprMsgDevReq3;
typedef TprMsgDevAck3_t = TprMsgDevReq3;
typedef TprMsgDevNotify3_t = TprMsgDevReq3;

class TprMsg {
  TprCommon_t common = TprCommon_t();
  TprSysFail_t sysfail = TprSysFail_t();
  TprSysFailAck_t sysfailack = TprSysFailAck_t();
  TprtStat_t taskstat = TprtStat_t();
  TprSysNotify_t sysnotify = TprSysNotify_t();
  TprSysNotifyAck_t sysnotifyack = TprSysNotifyAck_t();
  TprTimReq_t timereq = TprTimReq_t();
  TprTim_t timeout = TprTim_t();
  TprMsgDevReq_t devreq = TprMsgDevReq_t();
  TprMsgDevAck_t devack = TprMsgDevAck_t();
  TprMsgDevNotify_t devnotify = TprMsgDevNotify_t();
  TprMsgDevReq2_t devreq2 = TprMsgDevReq2_t();
  TprMsgDevAck2_t devack2 = TprMsgDevAck2_t();
  TprMsgDevNotify2_t devnotify2 = TprMsgDevNotify2_t();
  TprMsgDevReq3_t devreq3 = TprMsgDevReq3_t();
  TprMsgDevAck3_t devack3 = TprMsgDevAck3_t();
  TprMsgDevNotify3_t devnotify3 = TprMsgDevNotify3_t();
  TprApl_t apl = TprApl_t();
  String data = "";
}

typedef TprMsg_t = TprMsg;

class TprIpcSize {
  static const tprCmn = 8; //4 * 2
  static const tprSysFail = 12; //4 * 3
  static const tprtStat = 16; //4 * 4
  static const tprTimReq = 24; //4 * 6
  static const tprTim = 12; //4 * 3
  static const tprMsgDevReq = 1048; //(4 * 6) + 1024
  static const tprMsgDevReq2 = 1052; //(4 * 7) + 1024
  static const tprMsgDevReq3 = 1056; //(4 * 8) + 1024
  static const tprMsg = (tprCmn * 2) +
      (tprSysFail * 2) +
      (tprtStat * 3) +
      tprTimReq +
      tprTim +
      (tprMsgDevReq * 3) +
      (tprMsgDevReq2 * 3) +
      (tprMsgDevReq3 * 3);
}
