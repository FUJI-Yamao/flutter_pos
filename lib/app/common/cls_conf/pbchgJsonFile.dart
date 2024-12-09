/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'pbchgJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class PbchgJsonFile extends ConfigJsonFile {
  static final PbchgJsonFile _instance = PbchgJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "pbchg.json";

  PbchgJsonFile(){
    setPath(_confPath, _fileName);
  }
  PbchgJsonFile._internal();

  factory PbchgJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$PbchgJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$PbchgJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$PbchgJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        system = _$SystemFromJson(jsonD['system']);
      } catch(e) {
        system = _$SystemFromJson({});
        ret = false;
      }
      try {
        count = _$CountFromJson(jsonD['count']);
      } catch(e) {
        count = _$CountFromJson({});
        ret = false;
      }
      try {
        tran = _$TranFromJson(jsonD['tran']);
      } catch(e) {
        tran = _$TranFromJson({});
        ret = false;
      }
      try {
        retry = _$RetryFromJson(jsonD['retry']);
      } catch(e) {
        retry = _$RetryFromJson({});
        ret = false;
      }
      try {
        save_ = _$Save_FromJson(jsonD['save_']);
      } catch(e) {
        save_ = _$Save_FromJson({});
        ret = false;
      }
      try {
        download = _$DownloadFromJson(jsonD['download']);
      } catch(e) {
        download = _$DownloadFromJson({});
        ret = false;
      }
      try {
        util = _$UtilFromJson(jsonD['util']);
      } catch(e) {
        util = _$UtilFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _System system = _System(
    termcd                             : 0,
    groupcd                            : 0,
    officecd                           : 0,
    strecd                             : 0,
  );

  _Count count = _Count(
    dealseqno                          : 0,
    serviceseqno                       : 0,
  );

  _Tran tran = _Tran(
    steps                              : 0,
    res_sel                            : 0,
    fee1_sel                           : 0,
    fee2_sel                           : 0,
  );

  _Retry retry = _Retry(
    cnct                               : 0,
    interval                           : 0,
    cnt                                : 0,
    rd_timeout                         : 0,
    wt_timeout                         : 0,
  );

  _Save_ save_ = _Save_(
    month                              : 0,
  );

  _Download download = _Download(
    date                               : "",
    result                             : 0,
  );

  _Util util = _Util(
    exec                               : 0,
  );
}

@JsonSerializable()
class _System {
  factory _System.fromJson(Map<String, dynamic> json) => _$SystemFromJson(json);
  Map<String, dynamic> toJson() => _$SystemToJson(this);

  _System({
    required this.termcd,
    required this.groupcd,
    required this.officecd,
    required this.strecd,
  });

  @JsonKey(defaultValue: 0)
  int    termcd;
  @JsonKey(defaultValue: 0)
  int    groupcd;
  @JsonKey(defaultValue: 0)
  int    officecd;
  @JsonKey(defaultValue: 0)
  int    strecd;
}

@JsonSerializable()
class _Count {
  factory _Count.fromJson(Map<String, dynamic> json) => _$CountFromJson(json);
  Map<String, dynamic> toJson() => _$CountToJson(this);

  _Count({
    required this.dealseqno,
    required this.serviceseqno,
  });

  @JsonKey(defaultValue: 1)
  int    dealseqno;
  @JsonKey(defaultValue: 1)
  int    serviceseqno;
}

@JsonSerializable()
class _Tran {
  factory _Tran.fromJson(Map<String, dynamic> json) => _$TranFromJson(json);
  Map<String, dynamic> toJson() => _$TranToJson(this);

  _Tran({
    required this.steps,
    required this.res_sel,
    required this.fee1_sel,
    required this.fee2_sel,
  });

  @JsonKey(defaultValue: 95)
  int    steps;
  @JsonKey(defaultValue: 5)
  int    res_sel;
  @JsonKey(defaultValue: 6)
  int    fee1_sel;
  @JsonKey(defaultValue: 7)
  int    fee2_sel;
}

@JsonSerializable()
class _Retry {
  factory _Retry.fromJson(Map<String, dynamic> json) => _$RetryFromJson(json);
  Map<String, dynamic> toJson() => _$RetryToJson(this);

  _Retry({
    required this.cnct,
    required this.interval,
    required this.cnt,
    required this.rd_timeout,
    required this.wt_timeout,
  });

  @JsonKey(defaultValue: 20)
  int    cnct;
  @JsonKey(defaultValue: 30)
  int    interval;
  @JsonKey(defaultValue: 4)
  int    cnt;
  @JsonKey(defaultValue: 60)
  int    rd_timeout;
  @JsonKey(defaultValue: 60)
  int    wt_timeout;
}

@JsonSerializable()
class _Save_ {
  factory _Save_.fromJson(Map<String, dynamic> json) => _$Save_FromJson(json);
  Map<String, dynamic> toJson() => _$Save_ToJson(this);

  _Save_({
    required this.month,
  });

  @JsonKey(defaultValue: 13)
  int    month;
}

@JsonSerializable()
class _Download {
  factory _Download.fromJson(Map<String, dynamic> json) => _$DownloadFromJson(json);
  Map<String, dynamic> toJson() => _$DownloadToJson(this);

  _Download({
    required this.date,
    required this.result,
  });

  @JsonKey(defaultValue: "00000000000000")
  String date;
  @JsonKey(defaultValue: 0)
  int    result;
}

@JsonSerializable()
class _Util {
  factory _Util.fromJson(Map<String, dynamic> json) => _$UtilFromJson(json);
  Map<String, dynamic> toJson() => _$UtilToJson(this);

  _Util({
    required this.exec,
  });

  @JsonKey(defaultValue: 0)
  int    exec;
}

