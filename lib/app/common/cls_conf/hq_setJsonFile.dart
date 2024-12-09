/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'hq_setJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Hq_setJsonFile extends ConfigJsonFile {
  static final Hq_setJsonFile _instance = Hq_setJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "hq_set.json";

  Hq_setJsonFile(){
    setPath(_confPath, _fileName);
  }
  Hq_setJsonFile._internal();

  factory Hq_setJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Hq_setJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Hq_setJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Hq_setJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        netDoA_counter = _$NetDoA_counterFromJson(jsonD['netDoA_counter']);
      } catch(e) {
        netDoA_counter = _$NetDoA_counterFromJson({});
        ret = false;
      }
      try {
        css_counter = _$Css_counterFromJson(jsonD['css_counter']);
      } catch(e) {
        css_counter = _$Css_counterFromJson({});
        ret = false;
      }
      try {
        hq_cmn_option = _$Hq_cmn_optionFromJson(jsonD['hq_cmn_option']);
      } catch(e) {
        hq_cmn_option = _$Hq_cmn_optionFromJson({});
        ret = false;
      }
      try {
        hq_down_cycle = _$Hq_down_cycleFromJson(jsonD['hq_down_cycle']);
      } catch(e) {
        hq_down_cycle = _$Hq_down_cycleFromJson({});
        ret = false;
      }
      try {
        hq_down_specify = _$Hq_down_specifyFromJson(jsonD['hq_down_specify']);
      } catch(e) {
        hq_down_specify = _$Hq_down_specifyFromJson({});
        ret = false;
      }
      try {
        hq_up_cycle = _$Hq_up_cycleFromJson(jsonD['hq_up_cycle']);
      } catch(e) {
        hq_up_cycle = _$Hq_up_cycleFromJson({});
        ret = false;
      }
      try {
        hq_up_specify = _$Hq_up_specifyFromJson(jsonD['hq_up_specify']);
      } catch(e) {
        hq_up_specify = _$Hq_up_specifyFromJson({});
        ret = false;
      }
      try {
        tran_info = _$Tran_infoFromJson(jsonD['tran_info']);
      } catch(e) {
        tran_info = _$Tran_infoFromJson({});
        ret = false;
      }
      try {
        hq_TLIL = _$Hq_TLILFromJson(jsonD['hq_TLIL']);
      } catch(e) {
        hq_TLIL = _$Hq_TLILFromJson({});
        ret = false;
      }
      try {
        netdoa_day_info = _$Netdoa_day_infoFromJson(jsonD['netdoa_day_info']);
      } catch(e) {
        netdoa_day_info = _$Netdoa_day_infoFromJson({});
        ret = false;
      }
      try {
        netdoa_cls_info = _$Netdoa_cls_infoFromJson(jsonD['netdoa_cls_info']);
      } catch(e) {
        netdoa_cls_info = _$Netdoa_cls_infoFromJson({});
        ret = false;
      }
      try {
        netdoa_ej_info = _$Netdoa_ej_infoFromJson(jsonD['netdoa_ej_info']);
      } catch(e) {
        netdoa_ej_info = _$Netdoa_ej_infoFromJson({});
        ret = false;
      }
      try {
        ts_day_info = _$Ts_day_infoFromJson(jsonD['ts_day_info']);
      } catch(e) {
        ts_day_info = _$Ts_day_infoFromJson({});
        ret = false;
      }
      try {
        ts_cls_info = _$Ts_cls_infoFromJson(jsonD['ts_cls_info']);
      } catch(e) {
        ts_cls_info = _$Ts_cls_infoFromJson({});
        ret = false;
      }
      try {
        netdoa_mstsend = _$Netdoa_mstsendFromJson(jsonD['netdoa_mstsend']);
      } catch(e) {
        netdoa_mstsend = _$Netdoa_mstsendFromJson({});
        ret = false;
      }
      try {
        css_day_info = _$Css_day_infoFromJson(jsonD['css_day_info']);
      } catch(e) {
        css_day_info = _$Css_day_infoFromJson({});
        ret = false;
      }
      try {
        css_cls_info = _$Css_cls_infoFromJson(jsonD['css_cls_info']);
      } catch(e) {
        css_cls_info = _$Css_cls_infoFromJson({});
        ret = false;
      }
      try {
        css_odr_info = _$Css_odr_infoFromJson(jsonD['css_odr_info']);
      } catch(e) {
        css_odr_info = _$Css_odr_infoFromJson({});
        ret = false;
      }
      try {
        css_mst_create = _$Css_mst_createFromJson(jsonD['css_mst_create']);
      } catch(e) {
        css_mst_create = _$Css_mst_createFromJson({});
        ret = false;
      }
      try {
        cls_text_info = _$Cls_text_infoFromJson(jsonD['cls_text_info']);
      } catch(e) {
        cls_text_info = _$Cls_text_infoFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _NetDoA_counter netDoA_counter = _NetDoA_counter(
    hqhist_cd_up                       : 0,
    hqhist_cd_down                     : 0,
    hqtmp_mst_cd_up                    : 0,
    lgyoumu_serial_no                  : 0,
    hqhist_date_up                     : "",
    hqhist_date_down                   : "",
  );

  _Css_counter css_counter = _Css_counter(
    TranS3_hist_cd                     : "",
  );

  _Hq_cmn_option hq_cmn_option = _Hq_cmn_option(
    cnct_usb                           : 0,
    open_resend                        : 0,
    ts_lgyoumu                         : 0,
    gyoumu_suffix_digit                : 0,
    gyoumu_charcode                    : 0,
    gyoumu_newline                     : 0,
    gyoumu_date_set                    : 0,
    gyoumu_day_name                    : 0,
    gyoumu_ment_tran                   : 0,
    gyoumu_cnv_tax_typ                 : 0,
    zero_gyoumu_nosend                 : 0,
    cnct_2nd                           : 0,
    timing_2nd                         : 0,
    sndrcv_1st                         : 0,
    sndrcv_2nd                         : 0,
    namechg_2nd                        : 0,
  );

  _Hq_down_cycle hq_down_cycle = _Hq_down_cycle(
    value                              : 0,
  );

  _Hq_down_specify hq_down_specify = _Hq_down_specify(
    value1                             : "",
    value2                             : "",
    value3                             : "",
    value4                             : "",
    value5                             : "",
    value6                             : "",
    value7                             : "",
    value8                             : "",
    value9                             : "",
    value10                            : "",
    value11                            : "",
    value12                            : "",
  );

  _Hq_up_cycle hq_up_cycle = _Hq_up_cycle(
    value                              : 0,
  );

  _Hq_up_specify hq_up_specify = _Hq_up_specify(
    value1                             : "",
    value2                             : "",
    value3                             : "",
    value4                             : "",
    value5                             : "",
    value6                             : "",
    value7                             : "",
    value8                             : "",
    value9                             : "",
    value10                            : "",
    value11                            : "",
    value12                            : "",
  );

  _Tran_info tran_info = _Tran_info(
    css_tran11                         : "",
    css_tran12                         : "",
    css_tran13                         : "",
    css_tran15                         : "",
    css_tran21                         : "",
    css_tran22                         : "",
    css_tran24                         : "",
    css_tran25                         : "",
    css_tran26                         : "",
    css_tran27                         : "",
    css_tran28                         : "",
    css_tran29                         : "",
    css_tran2E                         : "",
    css_tran2F                         : "",
    css_tran55                         : "",
    css_tranT2                         : "",
    css_tranW3                         : "",
    css_tranW4                         : "",
    css_tranS3                         : "",
    css_tran8A                         : "",
    css_tran51_33                      : "",
    css_tran52_34                      : "",
    css_tran56_35                      : "",
    css_tran57_36                      : "",
    css_tran4A                         : "",
    css_tran4B                         : "",
    css_tran4C                         : "",
    css_tran76                         : "",
    css_tran73                         : "",
    css_tran71                         : "",
    css_tran72                         : "",
    css_tran7X                         : "",
    css_tranA1                         : "",
    css_tranA3                         : "",
    css_tranA4                         : "",
    css_tranA6                         : "",
    css_tranA7                         : "",
    css_tranA8                         : "",
    css_tranA9                         : "",
    css_tranC2                         : "",
    css_tranTL_IL                      : "",
    css_tranT3_I3                      : "",
  );

  _Hq_TLIL hq_TLIL = _Hq_TLIL(
    useMax                             : 0,
    Flag_001                           : 0,
    Mode_001                           : 0,
    Flag_002                           : 0,
    Mode_002                           : 0,
    Flag_003                           : 0,
    Mode_003                           : 0,
    Flag_004                           : 0,
    Mode_004                           : 0,
    Flag_005                           : 0,
    Mode_005                           : 0,
    Flag_006                           : 0,
    Mode_006                           : 0,
    Flag_007                           : 0,
    Mode_007                           : 0,
    Flag_008                           : 0,
    Mode_008                           : 0,
    Flag_009                           : 0,
    Mode_009                           : 0,
  );

  _Netdoa_day_info netdoa_day_info = _Netdoa_day_info(
    info_max                           : 0,
    info_01                            : "",
    info_02                            : "",
    info_03                            : "",
    info_04                            : "",
    info_05                            : "",
    info_06                            : "",
    info_07                            : "",
    info_08                            : "",
    info_09                            : "",
    info_10                            : "",
    info_11                            : "",
    info_12                            : "",
    info_13                            : "",
    info_14                            : "",
    info_15                            : "",
    info_16                            : "",
    info_17                            : "",
    info_18                            : "",
    info_19                            : "",
    info_20                            : "",
    info_21                            : "",
  );

  _Netdoa_cls_info netdoa_cls_info = _Netdoa_cls_info(
    info_max                           : 0,
    info_01                            : "",
    info_02                            : "",
    info_03                            : "",
    info_04                            : "",
    info_05                            : "",
    info_06                            : "",
    info_07                            : "",
    info_08                            : "",
    info_09                            : "",
    info_10                            : "",
    info_11                            : "",
    info_12                            : "",
    info_13                            : "",
    info_14                            : "",
    info_15                            : "",
    info_16                            : "",
    info_17                            : "",
    info_18                            : "",
    info_19                            : "",
    info_20                            : "",
    info_21                            : "",
    info_22                            : "",
    info_23                            : "",
    info_24                            : "",
    info_25                            : "",
    info_26                            : "",
    info_27                            : "",
    info_28                            : "",
    info_29                            : "",
    info_30                            : "",
  );

  _Netdoa_ej_info netdoa_ej_info = _Netdoa_ej_info(
    info_max                           : 0,
    info_01                            : "",
  );

  _Ts_day_info ts_day_info = _Ts_day_info(
    info_max                           : 0,
    info_01                            : "",
  );

  _Ts_cls_info ts_cls_info = _Ts_cls_info(
    info_max                           : 0,
    info_01                            : "",
  );

  _Netdoa_mstsend netdoa_mstsend = _Netdoa_mstsend(
    info_max                           : 0,
    info_01                            : "",
    info_02                            : "",
    info_03                            : "",
    info_04                            : "",
    info_05                            : "",
    info_06                            : "",
    info_07                            : "",
    info_08                            : "",
    info_09                            : "",
    info_10                            : "",
    info_11                            : "",
    info_12                            : "",
    info_13                            : "",
    info_14                            : "",
    info_15                            : "",
    info_16                            : "",
    info_17                            : "",
    info_18                            : "",
    info_19                            : "",
    info_20                            : "",
    info_21                            : "",
    info_22                            : "",
    info_23                            : "",
    info_24                            : "",
    info_25                            : "",
    info_26                            : "",
    info_27                            : "",
    info_28                            : "",
    info_29                            : "",
    info_30                            : "",
    info_31                            : "",
    info_32                            : "",
    info_33                            : "",
    info_34                            : "",
    info_35                            : "",
  );

  _Css_day_info css_day_info = _Css_day_info(
    info_max                           : 0,
    info_01                            : "",
    info_02                            : "",
    info_03                            : "",
    info_04                            : "",
  );

  _Css_cls_info css_cls_info = _Css_cls_info(
    info_max                           : 0,
    info_01                            : "",
    info_02                            : "",
    info_03                            : "",
    info_04                            : "",
    info_05                            : "",
    info_06                            : "",
  );

  _Css_odr_info css_odr_info = _Css_odr_info(
    info_max                           : 0,
    info_01                            : "",
  );

  _Css_mst_create css_mst_create = _Css_mst_create(
    info_max                           : 0,
    info_01                            : "",
  );

  _Cls_text_info cls_text_info = _Cls_text_info(
    info_max                           : 0,
    info_01                            : "",
    info_02                            : "",
    info_03                            : "",
    info_04                            : "",
  );
}

@JsonSerializable()
class _NetDoA_counter {
  factory _NetDoA_counter.fromJson(Map<String, dynamic> json) => _$NetDoA_counterFromJson(json);
  Map<String, dynamic> toJson() => _$NetDoA_counterToJson(this);

  _NetDoA_counter({
    required this.hqhist_cd_up,
    required this.hqhist_cd_down,
    required this.hqtmp_mst_cd_up,
    required this.lgyoumu_serial_no,
    required this.hqhist_date_up,
    required this.hqhist_date_down,
  });

  @JsonKey(defaultValue: 0)
  int    hqhist_cd_up;
  @JsonKey(defaultValue: 0)
  int    hqhist_cd_down;
  @JsonKey(defaultValue: 0)
  int    hqtmp_mst_cd_up;
  @JsonKey(defaultValue: 0)
  int    lgyoumu_serial_no;
  @JsonKey(defaultValue: "0000-00-00 00:00:00")
  String hqhist_date_up;
  @JsonKey(defaultValue: "0000-00-00 00:00:00")
  String hqhist_date_down;
}

@JsonSerializable()
class _Css_counter {
  factory _Css_counter.fromJson(Map<String, dynamic> json) => _$Css_counterFromJson(json);
  Map<String, dynamic> toJson() => _$Css_counterToJson(this);

  _Css_counter({
    required this.TranS3_hist_cd,
  });

  @JsonKey(defaultValue: "0,0")
  String TranS3_hist_cd;
}

@JsonSerializable()
class _Hq_cmn_option {
  factory _Hq_cmn_option.fromJson(Map<String, dynamic> json) => _$Hq_cmn_optionFromJson(json);
  Map<String, dynamic> toJson() => _$Hq_cmn_optionToJson(this);

  _Hq_cmn_option({
    required this.cnct_usb,
    required this.open_resend,
    required this.ts_lgyoumu,
    required this.gyoumu_suffix_digit,
    required this.gyoumu_charcode,
    required this.gyoumu_newline,
    required this.gyoumu_date_set,
    required this.gyoumu_day_name,
    required this.gyoumu_ment_tran,
    required this.gyoumu_cnv_tax_typ,
    required this.zero_gyoumu_nosend,
    required this.cnct_2nd,
    required this.timing_2nd,
    required this.sndrcv_1st,
    required this.sndrcv_2nd,
    required this.namechg_2nd,
  });

  @JsonKey(defaultValue: 0)
  int    cnct_usb;
  @JsonKey(defaultValue: 1)
  int    open_resend;
  @JsonKey(defaultValue: 1)
  int    ts_lgyoumu;
  @JsonKey(defaultValue: 0)
  int    gyoumu_suffix_digit;
  @JsonKey(defaultValue: 0)
  int    gyoumu_charcode;
  @JsonKey(defaultValue: 0)
  int    gyoumu_newline;
  @JsonKey(defaultValue: 0)
  int    gyoumu_date_set;
  @JsonKey(defaultValue: 0)
  int    gyoumu_day_name;
  @JsonKey(defaultValue: 0)
  int    gyoumu_ment_tran;
  @JsonKey(defaultValue: 0)
  int    gyoumu_cnv_tax_typ;
  @JsonKey(defaultValue: 0)
  int    zero_gyoumu_nosend;
  @JsonKey(defaultValue: 0)
  int    cnct_2nd;
  @JsonKey(defaultValue: 1)
  int    timing_2nd;
  @JsonKey(defaultValue: 0)
  int    sndrcv_1st;
  @JsonKey(defaultValue: 0)
  int    sndrcv_2nd;
  @JsonKey(defaultValue: 0)
  int    namechg_2nd;
}

@JsonSerializable()
class _Hq_down_cycle {
  factory _Hq_down_cycle.fromJson(Map<String, dynamic> json) => _$Hq_down_cycleFromJson(json);
  Map<String, dynamic> toJson() => _$Hq_down_cycleToJson(this);

  _Hq_down_cycle({
    required this.value,
  });

  @JsonKey(defaultValue: 5)
  int    value;
}

@JsonSerializable()
class _Hq_down_specify {
  factory _Hq_down_specify.fromJson(Map<String, dynamic> json) => _$Hq_down_specifyFromJson(json);
  Map<String, dynamic> toJson() => _$Hq_down_specifyToJson(this);

  _Hq_down_specify({
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
    required this.value5,
    required this.value6,
    required this.value7,
    required this.value8,
    required this.value9,
    required this.value10,
    required this.value11,
    required this.value12,
  });

  @JsonKey(defaultValue: "")
  String value1;
  @JsonKey(defaultValue: "")
  String value2;
  @JsonKey(defaultValue: "")
  String value3;
  @JsonKey(defaultValue: "")
  String value4;
  @JsonKey(defaultValue: "")
  String value5;
  @JsonKey(defaultValue: "")
  String value6;
  @JsonKey(defaultValue: "")
  String value7;
  @JsonKey(defaultValue: "")
  String value8;
  @JsonKey(defaultValue: "")
  String value9;
  @JsonKey(defaultValue: "")
  String value10;
  @JsonKey(defaultValue: "")
  String value11;
  @JsonKey(defaultValue: "")
  String value12;
}

@JsonSerializable()
class _Hq_up_cycle {
  factory _Hq_up_cycle.fromJson(Map<String, dynamic> json) => _$Hq_up_cycleFromJson(json);
  Map<String, dynamic> toJson() => _$Hq_up_cycleToJson(this);

  _Hq_up_cycle({
    required this.value,
  });

  @JsonKey(defaultValue: 15)
  int    value;
}

@JsonSerializable()
class _Hq_up_specify {
  factory _Hq_up_specify.fromJson(Map<String, dynamic> json) => _$Hq_up_specifyFromJson(json);
  Map<String, dynamic> toJson() => _$Hq_up_specifyToJson(this);

  _Hq_up_specify({
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
    required this.value5,
    required this.value6,
    required this.value7,
    required this.value8,
    required this.value9,
    required this.value10,
    required this.value11,
    required this.value12,
  });

  @JsonKey(defaultValue: "")
  String value1;
  @JsonKey(defaultValue: "")
  String value2;
  @JsonKey(defaultValue: "")
  String value3;
  @JsonKey(defaultValue: "")
  String value4;
  @JsonKey(defaultValue: "")
  String value5;
  @JsonKey(defaultValue: "")
  String value6;
  @JsonKey(defaultValue: "")
  String value7;
  @JsonKey(defaultValue: "")
  String value8;
  @JsonKey(defaultValue: "")
  String value9;
  @JsonKey(defaultValue: "")
  String value10;
  @JsonKey(defaultValue: "")
  String value11;
  @JsonKey(defaultValue: "")
  String value12;
}

@JsonSerializable()
class _Tran_info {
  factory _Tran_info.fromJson(Map<String, dynamic> json) => _$Tran_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Tran_infoToJson(this);

  _Tran_info({
    required this.css_tran11,
    required this.css_tran12,
    required this.css_tran13,
    required this.css_tran15,
    required this.css_tran21,
    required this.css_tran22,
    required this.css_tran24,
    required this.css_tran25,
    required this.css_tran26,
    required this.css_tran27,
    required this.css_tran28,
    required this.css_tran29,
    required this.css_tran2E,
    required this.css_tran2F,
    required this.css_tran55,
    required this.css_tranT2,
    required this.css_tranW3,
    required this.css_tranW4,
    required this.css_tranS3,
    required this.css_tran8A,
    required this.css_tran51_33,
    required this.css_tran52_34,
    required this.css_tran56_35,
    required this.css_tran57_36,
    required this.css_tran4A,
    required this.css_tran4B,
    required this.css_tran4C,
    required this.css_tran76,
    required this.css_tran73,
    required this.css_tran71,
    required this.css_tran72,
    required this.css_tran7X,
    required this.css_tranA1,
    required this.css_tranA3,
    required this.css_tranA4,
    required this.css_tranA6,
    required this.css_tranA7,
    required this.css_tranA8,
    required this.css_tranA9,
    required this.css_tranC2,
    required this.css_tranTL_IL,
    required this.css_tranT3_I3,
  });

  @JsonKey(defaultValue: "2,0")
  String css_tran11;
  @JsonKey(defaultValue: "1,0")
  String css_tran12;
  @JsonKey(defaultValue: "1,0")
  String css_tran13;
  @JsonKey(defaultValue: "1,0")
  String css_tran15;
  @JsonKey(defaultValue: "1,0")
  String css_tran21;
  @JsonKey(defaultValue: "2,0")
  String css_tran22;
  @JsonKey(defaultValue: "2,0")
  String css_tran24;
  @JsonKey(defaultValue: "2,0")
  String css_tran25;
  @JsonKey(defaultValue: "2,0")
  String css_tran26;
  @JsonKey(defaultValue: "1,0")
  String css_tran27;
  @JsonKey(defaultValue: "0,0")
  String css_tran28;
  @JsonKey(defaultValue: "1,0")
  String css_tran29;
  @JsonKey(defaultValue: "0,0")
  String css_tran2E;
  @JsonKey(defaultValue: "0,0")
  String css_tran2F;
  @JsonKey(defaultValue: "1,0")
  String css_tran55;
  @JsonKey(defaultValue: "0,0")
  String css_tranT2;
  @JsonKey(defaultValue: "1,0")
  String css_tranW3;
  @JsonKey(defaultValue: "0,0")
  String css_tranW4;
  @JsonKey(defaultValue: "0,0")
  String css_tranS3;
  @JsonKey(defaultValue: "0,0")
  String css_tran8A;
  @JsonKey(defaultValue: "0,0")
  String css_tran51_33;
  @JsonKey(defaultValue: "0,0")
  String css_tran52_34;
  @JsonKey(defaultValue: "0,0")
  String css_tran56_35;
  @JsonKey(defaultValue: "0,0")
  String css_tran57_36;
  @JsonKey(defaultValue: "0,0")
  String css_tran4A;
  @JsonKey(defaultValue: "0,0")
  String css_tran4B;
  @JsonKey(defaultValue: "0,0")
  String css_tran4C;
  @JsonKey(defaultValue: "1,0")
  String css_tran76;
  @JsonKey(defaultValue: "1,0")
  String css_tran73;
  @JsonKey(defaultValue: "1,0")
  String css_tran71;
  @JsonKey(defaultValue: "1,0")
  String css_tran72;
  @JsonKey(defaultValue: "0,0")
  String css_tran7X;
  @JsonKey(defaultValue: "0,0")
  String css_tranA1;
  @JsonKey(defaultValue: "0,0")
  String css_tranA3;
  @JsonKey(defaultValue: "0,0")
  String css_tranA4;
  @JsonKey(defaultValue: "0,0")
  String css_tranA6;
  @JsonKey(defaultValue: "0,0")
  String css_tranA7;
  @JsonKey(defaultValue: "0,0")
  String css_tranA8;
  @JsonKey(defaultValue: "0,0")
  String css_tranA9;
  @JsonKey(defaultValue: "0,0")
  String css_tranC2;
  @JsonKey(defaultValue: "-1,0")
  String css_tranTL_IL;
  @JsonKey(defaultValue: "-1,0")
  String css_tranT3_I3;
}

@JsonSerializable()
class _Hq_TLIL {
  factory _Hq_TLIL.fromJson(Map<String, dynamic> json) => _$Hq_TLILFromJson(json);
  Map<String, dynamic> toJson() => _$Hq_TLILToJson(this);

  _Hq_TLIL({
    required this.useMax,
    required this.Flag_001,
    required this.Mode_001,
    required this.Flag_002,
    required this.Mode_002,
    required this.Flag_003,
    required this.Mode_003,
    required this.Flag_004,
    required this.Mode_004,
    required this.Flag_005,
    required this.Mode_005,
    required this.Flag_006,
    required this.Mode_006,
    required this.Flag_007,
    required this.Mode_007,
    required this.Flag_008,
    required this.Mode_008,
    required this.Flag_009,
    required this.Mode_009,
  });

  @JsonKey(defaultValue: 9)
  int    useMax;
  @JsonKey(defaultValue: 1)
  int    Flag_001;
  @JsonKey(defaultValue: 1)
  int    Mode_001;
  @JsonKey(defaultValue: 1)
  int    Flag_002;
  @JsonKey(defaultValue: 3)
  int    Mode_002;
  @JsonKey(defaultValue: 1)
  int    Flag_003;
  @JsonKey(defaultValue: 4)
  int    Mode_003;
  @JsonKey(defaultValue: 0)
  int    Flag_004;
  @JsonKey(defaultValue: 60)
  int    Mode_004;
  @JsonKey(defaultValue: 1)
  int    Flag_005;
  @JsonKey(defaultValue: 61)
  int    Mode_005;
  @JsonKey(defaultValue: 0)
  int    Flag_006;
  @JsonKey(defaultValue: 63)
  int    Mode_006;
  @JsonKey(defaultValue: 1)
  int    Flag_007;
  @JsonKey(defaultValue: 81)
  int    Mode_007;
  @JsonKey(defaultValue: 0)
  int    Flag_008;
  @JsonKey(defaultValue: 83)
  int    Mode_008;
  @JsonKey(defaultValue: 0)
  int    Flag_009;
  @JsonKey(defaultValue: 11)
  int    Mode_009;
}

@JsonSerializable()
class _Netdoa_day_info {
  factory _Netdoa_day_info.fromJson(Map<String, dynamic> json) => _$Netdoa_day_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Netdoa_day_infoToJson(this);

  _Netdoa_day_info({
    required this.info_max,
    required this.info_01,
    required this.info_02,
    required this.info_03,
    required this.info_04,
    required this.info_05,
    required this.info_06,
    required this.info_07,
    required this.info_08,
    required this.info_09,
    required this.info_10,
    required this.info_11,
    required this.info_12,
    required this.info_13,
    required this.info_14,
    required this.info_15,
    required this.info_16,
    required this.info_17,
    required this.info_18,
    required this.info_19,
    required this.info_20,
    required this.info_21,
  });

  @JsonKey(defaultValue: 21)
  int    info_max;
  @JsonKey(defaultValue: "1,3,reg_dly_deal")
  String info_01;
  @JsonKey(defaultValue: "1,3,reg_dly_flow")
  String info_02;
  @JsonKey(defaultValue: "1,3,reg_dly_plu")
  String info_03;
  @JsonKey(defaultValue: "1,3,reg_dly_acr")
  String info_04;
  @JsonKey(defaultValue: "1,3,reg_dly_brgn")
  String info_05;
  @JsonKey(defaultValue: "1,3,reg_dly_mach")
  String info_06;
  @JsonKey(defaultValue: "1,4,version.json")
  String info_07;
  @JsonKey(defaultValue: "1,4,hq_set.json")
  String info_08;
  @JsonKey(defaultValue: "1,3,reg_dly_mdl")
  String info_09;
  @JsonKey(defaultValue: "1,3,reg_dly_sml")
  String info_10;
  @JsonKey(defaultValue: "1,5,LGYOUMU")
  String info_11;
  @JsonKey(defaultValue: "0,2,c_ej_log")
  String info_12;
  @JsonKey(defaultValue: "0,2,c_data_log")
  String info_13;
  @JsonKey(defaultValue: "0,2,c_status_log")
  String info_14;
  @JsonKey(defaultValue: "0,2,c_header_log")
  String info_15;
  @JsonKey(defaultValue: "1,3,reg_dly_cdpayflow")
  String info_16;
  @JsonKey(defaultValue: "1,1,rdly_deal_hour")
  String info_17;
  @JsonKey(defaultValue: "1,7,business_file")
  String info_18;
  @JsonKey(defaultValue: "1,3,reg_dly_tax_deal")
  String info_19;
  @JsonKey(defaultValue: "1,12,log/hist_err.sql")
  String info_20;
  @JsonKey(defaultValue: "1,11,OGYOUMU")
  String info_21;
}

@JsonSerializable()
class _Netdoa_cls_info {
  factory _Netdoa_cls_info.fromJson(Map<String, dynamic> json) => _$Netdoa_cls_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Netdoa_cls_infoToJson(this);

  _Netdoa_cls_info({
    required this.info_max,
    required this.info_01,
    required this.info_02,
    required this.info_03,
    required this.info_04,
    required this.info_05,
    required this.info_06,
    required this.info_07,
    required this.info_08,
    required this.info_09,
    required this.info_10,
    required this.info_11,
    required this.info_12,
    required this.info_13,
    required this.info_14,
    required this.info_15,
    required this.info_16,
    required this.info_17,
    required this.info_18,
    required this.info_19,
    required this.info_20,
    required this.info_21,
    required this.info_22,
    required this.info_23,
    required this.info_24,
    required this.info_25,
    required this.info_26,
    required this.info_27,
    required this.info_28,
    required this.info_29,
    required this.info_30,
  });

  @JsonKey(defaultValue: 30)
  int    info_max;
  @JsonKey(defaultValue: "1,3,reg_dly_deal")
  String info_01;
  @JsonKey(defaultValue: "1,3,reg_dly_flow")
  String info_02;
  @JsonKey(defaultValue: "1,3,reg_dly_plu")
  String info_03;
  @JsonKey(defaultValue: "1,3,reg_dly_acr")
  String info_04;
  @JsonKey(defaultValue: "1,3,reg_dly_brgn")
  String info_05;
  @JsonKey(defaultValue: "1,3,reg_dly_mach")
  String info_06;
  @JsonKey(defaultValue: "1,4,version.json")
  String info_07;
  @JsonKey(defaultValue: "1,4,hq_set.json")
  String info_08;
  @JsonKey(defaultValue: "1,3,reg_dly_mdl")
  String info_09;
  @JsonKey(defaultValue: "1,3,reg_dly_sml")
  String info_10;
  @JsonKey(defaultValue: "1,5,LGYOUMU")
  String info_11;
  @JsonKey(defaultValue: "1,4,sys.json")
  String info_12;
  @JsonKey(defaultValue: "1,1,c_cls_mst")
  String info_13;
  @JsonKey(defaultValue: "1,1,s_brgn_mst")
  String info_14;
  @JsonKey(defaultValue: "1,1,s_bdlitem_mst")
  String info_15;
  @JsonKey(defaultValue: "1,1,s_bdlsch_mst")
  String info_16;
  @JsonKey(defaultValue: "1,1,s_stmitem_mst")
  String info_17;
  @JsonKey(defaultValue: "1,1,s_stmsch_mst")
  String info_18;
  @JsonKey(defaultValue: "0,2,c_ej_log")
  String info_19;
  @JsonKey(defaultValue: "0,2,c_data_log")
  String info_20;
  @JsonKey(defaultValue: "0,2,c_status_log")
  String info_21;
  @JsonKey(defaultValue: "0,2,c_header_log")
  String info_22;
  @JsonKey(defaultValue: "1,3,reg_dly_cdpayflow")
  String info_23;
  @JsonKey(defaultValue: "1,1,rdly_deal_hour")
  String info_24;
  @JsonKey(defaultValue: "1,7,business_file")
  String info_25;
  @JsonKey(defaultValue: "1,3,reg_dly_tax_deal")
  String info_26;
  @JsonKey(defaultValue: "0,9,ATTENDTIME")
  String info_27;
  @JsonKey(defaultValue: "1,12,log/hist_err.sql")
  String info_28;
  @JsonKey(defaultValue: "1,1,s_cust_ttl_tbl")
  String info_29;
  @JsonKey(defaultValue: "1,11,OGYOUMU")
  String info_30;
}

@JsonSerializable()
class _Netdoa_ej_info {
  factory _Netdoa_ej_info.fromJson(Map<String, dynamic> json) => _$Netdoa_ej_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Netdoa_ej_infoToJson(this);

  _Netdoa_ej_info({
    required this.info_max,
    required this.info_01,
  });

  @JsonKey(defaultValue: 1)
  int    info_max;
  @JsonKey(defaultValue: "1,2,c_ej_log")
  String info_01;
}

@JsonSerializable()
class _Ts_day_info {
  factory _Ts_day_info.fromJson(Map<String, dynamic> json) => _$Ts_day_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Ts_day_infoToJson(this);

  _Ts_day_info({
    required this.info_max,
    required this.info_01,
  });

  @JsonKey(defaultValue: 1)
  int    info_max;
  @JsonKey(defaultValue: "1,5,LGYOUMU")
  String info_01;
}

@JsonSerializable()
class _Ts_cls_info {
  factory _Ts_cls_info.fromJson(Map<String, dynamic> json) => _$Ts_cls_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Ts_cls_infoToJson(this);

  _Ts_cls_info({
    required this.info_max,
    required this.info_01,
  });

  @JsonKey(defaultValue: 1)
  int    info_max;
  @JsonKey(defaultValue: "1,5,LGYOUMU")
  String info_01;
}

@JsonSerializable()
class _Netdoa_mstsend {
  factory _Netdoa_mstsend.fromJson(Map<String, dynamic> json) => _$Netdoa_mstsendFromJson(json);
  Map<String, dynamic> toJson() => _$Netdoa_mstsendToJson(this);

  _Netdoa_mstsend({
    required this.info_max,
    required this.info_01,
    required this.info_02,
    required this.info_03,
    required this.info_04,
    required this.info_05,
    required this.info_06,
    required this.info_07,
    required this.info_08,
    required this.info_09,
    required this.info_10,
    required this.info_11,
    required this.info_12,
    required this.info_13,
    required this.info_14,
    required this.info_15,
    required this.info_16,
    required this.info_17,
    required this.info_18,
    required this.info_19,
    required this.info_20,
    required this.info_21,
    required this.info_22,
    required this.info_23,
    required this.info_24,
    required this.info_25,
    required this.info_26,
    required this.info_27,
    required this.info_28,
    required this.info_29,
    required this.info_30,
    required this.info_31,
    required this.info_32,
    required this.info_33,
    required this.info_34,
    required this.info_35,
  });

  @JsonKey(defaultValue: 35)
  int    info_max;
  @JsonKey(defaultValue: "0,1,c_cls_mst")
  String info_01;
  @JsonKey(defaultValue: "0,1,c_plu_mst")
  String info_02;
  @JsonKey(defaultValue: "0,1,s_brgn_mst")
  String info_03;
  @JsonKey(defaultValue: "0,1,s_bdlsch_mst")
  String info_04;
  @JsonKey(defaultValue: "0,1,s_bdlitem_mst")
  String info_05;
  @JsonKey(defaultValue: "0,1,s_stmsch_mst")
  String info_06;
  @JsonKey(defaultValue: "0,1,s_stmitem_mst")
  String info_07;
  @JsonKey(defaultValue: "0,1,c_img_mst")
  String info_08;
  @JsonKey(defaultValue: "0,1,c_preset_mst")
  String info_09;
  @JsonKey(defaultValue: "0,1,c_tax_mst")
  String info_10;
  @JsonKey(defaultValue: "0,1,c_instre_mst")
  String info_11;
  @JsonKey(defaultValue: "0,1,c_staff_mst")
  String info_12;
  @JsonKey(defaultValue: "0,1,c_staffauth_mst")
  String info_13;
  @JsonKey(defaultValue: "0,1,c_keyauth_mst")
  String info_14;
  @JsonKey(defaultValue: "0,1,c_menuauth_mst")
  String info_15;
  @JsonKey(defaultValue: "0,1,c_operationauth_mst")
  String info_16;
  @JsonKey(defaultValue: "0,1,c_keyfnc_mst")
  String info_17;
  @JsonKey(defaultValue: "0,1,c_keyopt_mst")
  String info_18;
  @JsonKey(defaultValue: "0,1,c_producer_mst")
  String info_19;
  @JsonKey(defaultValue: "0,1,c_divide_mst")
  String info_20;
  @JsonKey(defaultValue: "0,1,c_msg_mst")
  String info_21;
  @JsonKey(defaultValue: "0,1,c_msglayout_mst")
  String info_22;
  @JsonKey(defaultValue: "0,1,c_msgsch_mst")
  String info_23;
  @JsonKey(defaultValue: "0,1,c_msgsch_layout_mst")
  String info_24;
  @JsonKey(defaultValue: "0,1,c_appl_grp_mst")
  String info_25;
  @JsonKey(defaultValue: "0,1,c_keykind_mst")
  String info_26;
  @JsonKey(defaultValue: "0,1,c_keykind_grp_mst")
  String info_27;
  @JsonKey(defaultValue: "0,1,c_operation_mst")
  String info_28;
  @JsonKey(defaultValue: "0,1,c_keyopt_set_mst")
  String info_29;
  @JsonKey(defaultValue: "0,1,c_keyopt_sub_mst")
  String info_30;
  @JsonKey(defaultValue: "0,1,c_scanplu_mst")
  String info_31;
  @JsonKey(defaultValue: "0,1,p_promsch_mst")
  String info_32;
  @JsonKey(defaultValue: "0,1,p_promitem_mst")
  String info_33;
  @JsonKey(defaultValue: "0,1,c_loypln_mst")
  String info_34;
  @JsonKey(defaultValue: "0,1,c_loyplu_mst")
  String info_35;
}

@JsonSerializable()
class _Css_day_info {
  factory _Css_day_info.fromJson(Map<String, dynamic> json) => _$Css_day_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Css_day_infoToJson(this);

  _Css_day_info({
    required this.info_max,
    required this.info_01,
    required this.info_02,
    required this.info_03,
    required this.info_04,
  });

  @JsonKey(defaultValue: 4)
  int    info_max;
  @JsonKey(defaultValue: "1,6,RGYOUMU")
  String info_01;
  @JsonKey(defaultValue: "1,10,CGYOUMU")
  String info_02;
  @JsonKey(defaultValue: "1,5,LGYOUMU")
  String info_03;
  @JsonKey(defaultValue: "1,11,OGYOUMU")
  String info_04;
}

@JsonSerializable()
class _Css_cls_info {
  factory _Css_cls_info.fromJson(Map<String, dynamic> json) => _$Css_cls_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Css_cls_infoToJson(this);

  _Css_cls_info({
    required this.info_max,
    required this.info_01,
    required this.info_02,
    required this.info_03,
    required this.info_04,
    required this.info_05,
    required this.info_06,
  });

  @JsonKey(defaultValue: 6)
  int    info_max;
  @JsonKey(defaultValue: "1,6,RGYOUMU")
  String info_01;
  @JsonKey(defaultValue: "1,10,CGYOUMU")
  String info_02;
  @JsonKey(defaultValue: "1,14,IGYOUMU")
  String info_03;
  @JsonKey(defaultValue: "1,15,DGYOUMU")
  String info_04;
  @JsonKey(defaultValue: "1,5,LGYOUMU")
  String info_05;
  @JsonKey(defaultValue: "1,11,OGYOUMU")
  String info_06;
}

@JsonSerializable()
class _Css_odr_info {
  factory _Css_odr_info.fromJson(Map<String, dynamic> json) => _$Css_odr_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Css_odr_infoToJson(this);

  _Css_odr_info({
    required this.info_max,
    required this.info_01,
  });

  @JsonKey(defaultValue: 1)
  int    info_max;
  @JsonKey(defaultValue: "1,8,HGYOUMU")
  String info_01;
}

@JsonSerializable()
class _Css_mst_create {
  factory _Css_mst_create.fromJson(Map<String, dynamic> json) => _$Css_mst_createFromJson(json);
  Map<String, dynamic> toJson() => _$Css_mst_createToJson(this);

  _Css_mst_create({
    required this.info_max,
    required this.info_01,
  });

  @JsonKey(defaultValue: 1)
  int    info_max;
  @JsonKey(defaultValue: "1,13,AGYOUMU")
  String info_01;
}

@JsonSerializable()
class _Cls_text_info {
  factory _Cls_text_info.fromJson(Map<String, dynamic> json) => _$Cls_text_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Cls_text_infoToJson(this);

  _Cls_text_info({
    required this.info_max,
    required this.info_01,
    required this.info_02,
    required this.info_03,
    required this.info_04,
  });

  @JsonKey(defaultValue: 4)
  int    info_max;
  @JsonKey(defaultValue: "0,2,c_ej_log")
  String info_01;
  @JsonKey(defaultValue: "0,2,c_data_log")
  String info_02;
  @JsonKey(defaultValue: "0,2,c_status_log")
  String info_03;
  @JsonKey(defaultValue: "0,2,c_header_log")
  String info_04;
}

