/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'suicaJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class SuicaJsonFile extends ConfigJsonFile {
  static final SuicaJsonFile _instance = SuicaJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "suica.json";

  SuicaJsonFile(){
    setPath(_confPath, _fileName);
  }
  SuicaJsonFile._internal();

  factory SuicaJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$SuicaJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$SuicaJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$SuicaJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        suica = _$SuicaFromJson(jsonD['suica']);
      } catch(e) {
        suica = _$SuicaFromJson({});
        ret = false;
      }
      try {
        sense = _$SenseFromJson(jsonD['sense']);
      } catch(e) {
        sense = _$SenseFromJson({});
        ret = false;
      }
      try {
        TRAN = _$TTRANFromJson(jsonD['TRAN']);
      } catch(e) {
        TRAN = _$TTRANFromJson({});
        ret = false;
      }
      try {
        key = _$KeyFromJson(jsonD['key']);
      } catch(e) {
        key = _$KeyFromJson({});
        ret = false;
      }
      try {
        multi_nimoca = _$Multi_nimocaFromJson(jsonD['multi_nimoca']);
      } catch(e) {
        multi_nimoca = _$Multi_nimocaFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Suica suica = _Suica(
    SuicaNo                            : "",
    ng_print                           : 0,
  );

  _Sense sense = _Sense(
    send_date                          : "",
    offset                             : "",
    rw_code                            : "",
    str_id                             : "",
    rw_mac                             : "",
    rw_ip                              : "",
    subnet                             : "",
    gateway                            : "",
    svr_ip                             : "",
    port_no                            : "",
    serial_no                          : "",
    product_no                         : "",
    end_icseq                          : "",
    send_cnt                           : "",
    non_send_cnt                       : "",
    timeout1                           : "",
    timeout2                           : "",
    timeout3                           : "",
    trm_data_pt                        : "",
    trm_data_vr                        : "",
    cent_occnt                         : "",
    est_part                           : "",
    parse_amt                          : "",
    rw_fver                            : "",
  );

  _TTRAN TRAN = _TTRAN(
    before_tran_typ                    : "",
    before_tran_amt                    : "",
    before_seq_ic                      : "",
  );

  _Key key = _Key(
    suica_debug_key                    : 0,
  );

  _Multi_nimoca multi_nimoca = _Multi_nimoca(
    nimoca_aplchg_wait1                : 0,
    nimoca_aplchg_wait2                : 0,
    nimoca_aplchg_wait3                : 0,
  );
}

@JsonSerializable()
class _Suica {
  factory _Suica.fromJson(Map<String, dynamic> json) => _$SuicaFromJson(json);
  Map<String, dynamic> toJson() => _$SuicaToJson(this);

  _Suica({
    required this.SuicaNo,
    required this.ng_print,
  });

  @JsonKey(defaultValue: "0000000000000")
  String SuicaNo;
  @JsonKey(defaultValue: 0)
  int    ng_print;
}

@JsonSerializable()
class _Sense {
  factory _Sense.fromJson(Map<String, dynamic> json) => _$SenseFromJson(json);
  Map<String, dynamic> toJson() => _$SenseToJson(this);

  _Sense({
    required this.send_date,
    required this.offset,
    required this.rw_code,
    required this.str_id,
    required this.rw_mac,
    required this.rw_ip,
    required this.subnet,
    required this.gateway,
    required this.svr_ip,
    required this.port_no,
    required this.serial_no,
    required this.product_no,
    required this.end_icseq,
    required this.send_cnt,
    required this.non_send_cnt,
    required this.timeout1,
    required this.timeout2,
    required this.timeout3,
    required this.trm_data_pt,
    required this.trm_data_vr,
    required this.cent_occnt,
    required this.est_part,
    required this.parse_amt,
    required this.rw_fver,
  });

  @JsonKey(defaultValue: "")
  String send_date;
  @JsonKey(defaultValue: "")
  String offset;
  @JsonKey(defaultValue: "")
  String rw_code;
  @JsonKey(defaultValue: "")
  String str_id;
  @JsonKey(defaultValue: "")
  String rw_mac;
  @JsonKey(defaultValue: "")
  String rw_ip;
  @JsonKey(defaultValue: "")
  String subnet;
  @JsonKey(defaultValue: "")
  String gateway;
  @JsonKey(defaultValue: "")
  String svr_ip;
  @JsonKey(defaultValue: "")
  String port_no;
  @JsonKey(defaultValue: "")
  String serial_no;
  @JsonKey(defaultValue: "")
  String product_no;
  @JsonKey(defaultValue: "")
  String end_icseq;
  @JsonKey(defaultValue: "")
  String send_cnt;
  @JsonKey(defaultValue: "")
  String non_send_cnt;
  @JsonKey(defaultValue: "")
  String timeout1;
  @JsonKey(defaultValue: "")
  String timeout2;
  @JsonKey(defaultValue: "")
  String timeout3;
  @JsonKey(defaultValue: "")
  String trm_data_pt;
  @JsonKey(defaultValue: "")
  String trm_data_vr;
  @JsonKey(defaultValue: "")
  String cent_occnt;
  @JsonKey(defaultValue: "")
  String est_part;
  @JsonKey(defaultValue: "")
  String parse_amt;
  @JsonKey(defaultValue: "")
  String rw_fver;
}

@JsonSerializable()
class _TTRAN {
  factory _TTRAN.fromJson(Map<String, dynamic> json) => _$TTRANFromJson(json);
  Map<String, dynamic> toJson() => _$TTRANToJson(this);

  _TTRAN({
    required this.before_tran_typ,
    required this.before_tran_amt,
    required this.before_seq_ic,
  });

  @JsonKey(defaultValue: "")
  String before_tran_typ;
  @JsonKey(defaultValue: "")
  String before_tran_amt;
  @JsonKey(defaultValue: "")
  String before_seq_ic;
}

@JsonSerializable()
class _Key {
  factory _Key.fromJson(Map<String, dynamic> json) => _$KeyFromJson(json);
  Map<String, dynamic> toJson() => _$KeyToJson(this);

  _Key({
    required this.suica_debug_key,
  });

  @JsonKey(defaultValue: 0)
  int    suica_debug_key;
}

@JsonSerializable()
class _Multi_nimoca {
  factory _Multi_nimoca.fromJson(Map<String, dynamic> json) => _$Multi_nimocaFromJson(json);
  Map<String, dynamic> toJson() => _$Multi_nimocaToJson(this);

  _Multi_nimoca({
    required this.nimoca_aplchg_wait1,
    required this.nimoca_aplchg_wait2,
    required this.nimoca_aplchg_wait3,
  });

  @JsonKey(defaultValue: 4)
  int    nimoca_aplchg_wait1;
  @JsonKey(defaultValue: 2)
  int    nimoca_aplchg_wait2;
  @JsonKey(defaultValue: 4)
  int    nimoca_aplchg_wait3;
}

