// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hq_setJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hq_setJsonFile _$Hq_setJsonFileFromJson(Map<String, dynamic> json) =>
    Hq_setJsonFile()
      ..netDoA_counter = _NetDoA_counter.fromJson(
          json['netDoA_counter'] as Map<String, dynamic>)
      ..css_counter =
          _Css_counter.fromJson(json['css_counter'] as Map<String, dynamic>)
      ..hq_cmn_option =
          _Hq_cmn_option.fromJson(json['hq_cmn_option'] as Map<String, dynamic>)
      ..hq_down_cycle =
          _Hq_down_cycle.fromJson(json['hq_down_cycle'] as Map<String, dynamic>)
      ..hq_down_specify = _Hq_down_specify.fromJson(
          json['hq_down_specify'] as Map<String, dynamic>)
      ..hq_up_cycle =
          _Hq_up_cycle.fromJson(json['hq_up_cycle'] as Map<String, dynamic>)
      ..hq_up_specify =
          _Hq_up_specify.fromJson(json['hq_up_specify'] as Map<String, dynamic>)
      ..tran_info =
          _Tran_info.fromJson(json['tran_info'] as Map<String, dynamic>)
      ..hq_TLIL = _Hq_TLIL.fromJson(json['hq_TLIL'] as Map<String, dynamic>)
      ..netdoa_day_info = _Netdoa_day_info.fromJson(
          json['netdoa_day_info'] as Map<String, dynamic>)
      ..netdoa_cls_info = _Netdoa_cls_info.fromJson(
          json['netdoa_cls_info'] as Map<String, dynamic>)
      ..netdoa_ej_info = _Netdoa_ej_info.fromJson(
          json['netdoa_ej_info'] as Map<String, dynamic>)
      ..ts_day_info =
          _Ts_day_info.fromJson(json['ts_day_info'] as Map<String, dynamic>)
      ..ts_cls_info =
          _Ts_cls_info.fromJson(json['ts_cls_info'] as Map<String, dynamic>)
      ..netdoa_mstsend = _Netdoa_mstsend.fromJson(
          json['netdoa_mstsend'] as Map<String, dynamic>)
      ..css_day_info =
          _Css_day_info.fromJson(json['css_day_info'] as Map<String, dynamic>)
      ..css_cls_info =
          _Css_cls_info.fromJson(json['css_cls_info'] as Map<String, dynamic>)
      ..css_odr_info =
          _Css_odr_info.fromJson(json['css_odr_info'] as Map<String, dynamic>)
      ..css_mst_create = _Css_mst_create.fromJson(
          json['css_mst_create'] as Map<String, dynamic>)
      ..cls_text_info = _Cls_text_info.fromJson(
          json['cls_text_info'] as Map<String, dynamic>);

Map<String, dynamic> _$Hq_setJsonFileToJson(Hq_setJsonFile instance) =>
    <String, dynamic>{
      'netDoA_counter': instance.netDoA_counter.toJson(),
      'css_counter': instance.css_counter.toJson(),
      'hq_cmn_option': instance.hq_cmn_option.toJson(),
      'hq_down_cycle': instance.hq_down_cycle.toJson(),
      'hq_down_specify': instance.hq_down_specify.toJson(),
      'hq_up_cycle': instance.hq_up_cycle.toJson(),
      'hq_up_specify': instance.hq_up_specify.toJson(),
      'tran_info': instance.tran_info.toJson(),
      'hq_TLIL': instance.hq_TLIL.toJson(),
      'netdoa_day_info': instance.netdoa_day_info.toJson(),
      'netdoa_cls_info': instance.netdoa_cls_info.toJson(),
      'netdoa_ej_info': instance.netdoa_ej_info.toJson(),
      'ts_day_info': instance.ts_day_info.toJson(),
      'ts_cls_info': instance.ts_cls_info.toJson(),
      'netdoa_mstsend': instance.netdoa_mstsend.toJson(),
      'css_day_info': instance.css_day_info.toJson(),
      'css_cls_info': instance.css_cls_info.toJson(),
      'css_odr_info': instance.css_odr_info.toJson(),
      'css_mst_create': instance.css_mst_create.toJson(),
      'cls_text_info': instance.cls_text_info.toJson(),
    };

_NetDoA_counter _$NetDoA_counterFromJson(Map<String, dynamic> json) =>
    _NetDoA_counter(
      hqhist_cd_up: json['hqhist_cd_up'] as int? ?? 0,
      hqhist_cd_down: json['hqhist_cd_down'] as int? ?? 0,
      hqtmp_mst_cd_up: json['hqtmp_mst_cd_up'] as int? ?? 0,
      lgyoumu_serial_no: json['lgyoumu_serial_no'] as int? ?? 0,
      hqhist_date_up:
          json['hqhist_date_up'] as String? ?? '0000-00-00 00:00:00',
      hqhist_date_down:
          json['hqhist_date_down'] as String? ?? '0000-00-00 00:00:00',
    );

Map<String, dynamic> _$NetDoA_counterToJson(_NetDoA_counter instance) =>
    <String, dynamic>{
      'hqhist_cd_up': instance.hqhist_cd_up,
      'hqhist_cd_down': instance.hqhist_cd_down,
      'hqtmp_mst_cd_up': instance.hqtmp_mst_cd_up,
      'lgyoumu_serial_no': instance.lgyoumu_serial_no,
      'hqhist_date_up': instance.hqhist_date_up,
      'hqhist_date_down': instance.hqhist_date_down,
    };

_Css_counter _$Css_counterFromJson(Map<String, dynamic> json) => _Css_counter(
      TranS3_hist_cd: json['TranS3_hist_cd'] as String? ?? '0,0',
    );

Map<String, dynamic> _$Css_counterToJson(_Css_counter instance) =>
    <String, dynamic>{
      'TranS3_hist_cd': instance.TranS3_hist_cd,
    };

_Hq_cmn_option _$Hq_cmn_optionFromJson(Map<String, dynamic> json) =>
    _Hq_cmn_option(
      cnct_usb: json['cnct_usb'] as int? ?? 0,
      open_resend: json['open_resend'] as int? ?? 1,
      ts_lgyoumu: json['ts_lgyoumu'] as int? ?? 1,
      gyoumu_suffix_digit: json['gyoumu_suffix_digit'] as int? ?? 0,
      gyoumu_charcode: json['gyoumu_charcode'] as int? ?? 0,
      gyoumu_newline: json['gyoumu_newline'] as int? ?? 0,
      gyoumu_date_set: json['gyoumu_date_set'] as int? ?? 0,
      gyoumu_day_name: json['gyoumu_day_name'] as int? ?? 0,
      gyoumu_ment_tran: json['gyoumu_ment_tran'] as int? ?? 0,
      gyoumu_cnv_tax_typ: json['gyoumu_cnv_tax_typ'] as int? ?? 0,
      zero_gyoumu_nosend: json['zero_gyoumu_nosend'] as int? ?? 0,
      cnct_2nd: json['cnct_2nd'] as int? ?? 0,
      timing_2nd: json['timing_2nd'] as int? ?? 1,
      sndrcv_1st: json['sndrcv_1st'] as int? ?? 0,
      sndrcv_2nd: json['sndrcv_2nd'] as int? ?? 0,
      namechg_2nd: json['namechg_2nd'] as int? ?? 0,
    );

Map<String, dynamic> _$Hq_cmn_optionToJson(_Hq_cmn_option instance) =>
    <String, dynamic>{
      'cnct_usb': instance.cnct_usb,
      'open_resend': instance.open_resend,
      'ts_lgyoumu': instance.ts_lgyoumu,
      'gyoumu_suffix_digit': instance.gyoumu_suffix_digit,
      'gyoumu_charcode': instance.gyoumu_charcode,
      'gyoumu_newline': instance.gyoumu_newline,
      'gyoumu_date_set': instance.gyoumu_date_set,
      'gyoumu_day_name': instance.gyoumu_day_name,
      'gyoumu_ment_tran': instance.gyoumu_ment_tran,
      'gyoumu_cnv_tax_typ': instance.gyoumu_cnv_tax_typ,
      'zero_gyoumu_nosend': instance.zero_gyoumu_nosend,
      'cnct_2nd': instance.cnct_2nd,
      'timing_2nd': instance.timing_2nd,
      'sndrcv_1st': instance.sndrcv_1st,
      'sndrcv_2nd': instance.sndrcv_2nd,
      'namechg_2nd': instance.namechg_2nd,
    };

_Hq_down_cycle _$Hq_down_cycleFromJson(Map<String, dynamic> json) =>
    _Hq_down_cycle(
      value: json['value'] as int? ?? 5,
    );

Map<String, dynamic> _$Hq_down_cycleToJson(_Hq_down_cycle instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

_Hq_down_specify _$Hq_down_specifyFromJson(Map<String, dynamic> json) =>
    _Hq_down_specify(
      value1: json['value1'] as String? ?? '',
      value2: json['value2'] as String? ?? '',
      value3: json['value3'] as String? ?? '',
      value4: json['value4'] as String? ?? '',
      value5: json['value5'] as String? ?? '',
      value6: json['value6'] as String? ?? '',
      value7: json['value7'] as String? ?? '',
      value8: json['value8'] as String? ?? '',
      value9: json['value9'] as String? ?? '',
      value10: json['value10'] as String? ?? '',
      value11: json['value11'] as String? ?? '',
      value12: json['value12'] as String? ?? '',
    );

Map<String, dynamic> _$Hq_down_specifyToJson(_Hq_down_specify instance) =>
    <String, dynamic>{
      'value1': instance.value1,
      'value2': instance.value2,
      'value3': instance.value3,
      'value4': instance.value4,
      'value5': instance.value5,
      'value6': instance.value6,
      'value7': instance.value7,
      'value8': instance.value8,
      'value9': instance.value9,
      'value10': instance.value10,
      'value11': instance.value11,
      'value12': instance.value12,
    };

_Hq_up_cycle _$Hq_up_cycleFromJson(Map<String, dynamic> json) => _Hq_up_cycle(
      value: json['value'] as int? ?? 15,
    );

Map<String, dynamic> _$Hq_up_cycleToJson(_Hq_up_cycle instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

_Hq_up_specify _$Hq_up_specifyFromJson(Map<String, dynamic> json) =>
    _Hq_up_specify(
      value1: json['value1'] as String? ?? '',
      value2: json['value2'] as String? ?? '',
      value3: json['value3'] as String? ?? '',
      value4: json['value4'] as String? ?? '',
      value5: json['value5'] as String? ?? '',
      value6: json['value6'] as String? ?? '',
      value7: json['value7'] as String? ?? '',
      value8: json['value8'] as String? ?? '',
      value9: json['value9'] as String? ?? '',
      value10: json['value10'] as String? ?? '',
      value11: json['value11'] as String? ?? '',
      value12: json['value12'] as String? ?? '',
    );

Map<String, dynamic> _$Hq_up_specifyToJson(_Hq_up_specify instance) =>
    <String, dynamic>{
      'value1': instance.value1,
      'value2': instance.value2,
      'value3': instance.value3,
      'value4': instance.value4,
      'value5': instance.value5,
      'value6': instance.value6,
      'value7': instance.value7,
      'value8': instance.value8,
      'value9': instance.value9,
      'value10': instance.value10,
      'value11': instance.value11,
      'value12': instance.value12,
    };

_Tran_info _$Tran_infoFromJson(Map<String, dynamic> json) => _Tran_info(
      css_tran11: json['css_tran11'] as String? ?? '2,0',
      css_tran12: json['css_tran12'] as String? ?? '1,0',
      css_tran13: json['css_tran13'] as String? ?? '1,0',
      css_tran15: json['css_tran15'] as String? ?? '1,0',
      css_tran21: json['css_tran21'] as String? ?? '1,0',
      css_tran22: json['css_tran22'] as String? ?? '2,0',
      css_tran24: json['css_tran24'] as String? ?? '2,0',
      css_tran25: json['css_tran25'] as String? ?? '2,0',
      css_tran26: json['css_tran26'] as String? ?? '2,0',
      css_tran27: json['css_tran27'] as String? ?? '1,0',
      css_tran28: json['css_tran28'] as String? ?? '0,0',
      css_tran29: json['css_tran29'] as String? ?? '1,0',
      css_tran2E: json['css_tran2E'] as String? ?? '0,0',
      css_tran2F: json['css_tran2F'] as String? ?? '0,0',
      css_tran55: json['css_tran55'] as String? ?? '1,0',
      css_tranT2: json['css_tranT2'] as String? ?? '0,0',
      css_tranW3: json['css_tranW3'] as String? ?? '1,0',
      css_tranW4: json['css_tranW4'] as String? ?? '0,0',
      css_tranS3: json['css_tranS3'] as String? ?? '0,0',
      css_tran8A: json['css_tran8A'] as String? ?? '0,0',
      css_tran51_33: json['css_tran51_33'] as String? ?? '0,0',
      css_tran52_34: json['css_tran52_34'] as String? ?? '0,0',
      css_tran56_35: json['css_tran56_35'] as String? ?? '0,0',
      css_tran57_36: json['css_tran57_36'] as String? ?? '0,0',
      css_tran4A: json['css_tran4A'] as String? ?? '0,0',
      css_tran4B: json['css_tran4B'] as String? ?? '0,0',
      css_tran4C: json['css_tran4C'] as String? ?? '0,0',
      css_tran76: json['css_tran76'] as String? ?? '1,0',
      css_tran73: json['css_tran73'] as String? ?? '1,0',
      css_tran71: json['css_tran71'] as String? ?? '1,0',
      css_tran72: json['css_tran72'] as String? ?? '1,0',
      css_tran7X: json['css_tran7X'] as String? ?? '0,0',
      css_tranA1: json['css_tranA1'] as String? ?? '0,0',
      css_tranA3: json['css_tranA3'] as String? ?? '0,0',
      css_tranA4: json['css_tranA4'] as String? ?? '0,0',
      css_tranA6: json['css_tranA6'] as String? ?? '0,0',
      css_tranA7: json['css_tranA7'] as String? ?? '0,0',
      css_tranA8: json['css_tranA8'] as String? ?? '0,0',
      css_tranA9: json['css_tranA9'] as String? ?? '0,0',
      css_tranC2: json['css_tranC2'] as String? ?? '0,0',
      css_tranTL_IL: json['css_tranTL_IL'] as String? ?? '-1,0',
      css_tranT3_I3: json['css_tranT3_I3'] as String? ?? '-1,0',
    );

Map<String, dynamic> _$Tran_infoToJson(_Tran_info instance) =>
    <String, dynamic>{
      'css_tran11': instance.css_tran11,
      'css_tran12': instance.css_tran12,
      'css_tran13': instance.css_tran13,
      'css_tran15': instance.css_tran15,
      'css_tran21': instance.css_tran21,
      'css_tran22': instance.css_tran22,
      'css_tran24': instance.css_tran24,
      'css_tran25': instance.css_tran25,
      'css_tran26': instance.css_tran26,
      'css_tran27': instance.css_tran27,
      'css_tran28': instance.css_tran28,
      'css_tran29': instance.css_tran29,
      'css_tran2E': instance.css_tran2E,
      'css_tran2F': instance.css_tran2F,
      'css_tran55': instance.css_tran55,
      'css_tranT2': instance.css_tranT2,
      'css_tranW3': instance.css_tranW3,
      'css_tranW4': instance.css_tranW4,
      'css_tranS3': instance.css_tranS3,
      'css_tran8A': instance.css_tran8A,
      'css_tran51_33': instance.css_tran51_33,
      'css_tran52_34': instance.css_tran52_34,
      'css_tran56_35': instance.css_tran56_35,
      'css_tran57_36': instance.css_tran57_36,
      'css_tran4A': instance.css_tran4A,
      'css_tran4B': instance.css_tran4B,
      'css_tran4C': instance.css_tran4C,
      'css_tran76': instance.css_tran76,
      'css_tran73': instance.css_tran73,
      'css_tran71': instance.css_tran71,
      'css_tran72': instance.css_tran72,
      'css_tran7X': instance.css_tran7X,
      'css_tranA1': instance.css_tranA1,
      'css_tranA3': instance.css_tranA3,
      'css_tranA4': instance.css_tranA4,
      'css_tranA6': instance.css_tranA6,
      'css_tranA7': instance.css_tranA7,
      'css_tranA8': instance.css_tranA8,
      'css_tranA9': instance.css_tranA9,
      'css_tranC2': instance.css_tranC2,
      'css_tranTL_IL': instance.css_tranTL_IL,
      'css_tranT3_I3': instance.css_tranT3_I3,
    };

_Hq_TLIL _$Hq_TLILFromJson(Map<String, dynamic> json) => _Hq_TLIL(
      useMax: json['useMax'] as int? ?? 9,
      Flag_001: json['Flag_001'] as int? ?? 1,
      Mode_001: json['Mode_001'] as int? ?? 1,
      Flag_002: json['Flag_002'] as int? ?? 1,
      Mode_002: json['Mode_002'] as int? ?? 3,
      Flag_003: json['Flag_003'] as int? ?? 1,
      Mode_003: json['Mode_003'] as int? ?? 4,
      Flag_004: json['Flag_004'] as int? ?? 0,
      Mode_004: json['Mode_004'] as int? ?? 60,
      Flag_005: json['Flag_005'] as int? ?? 1,
      Mode_005: json['Mode_005'] as int? ?? 61,
      Flag_006: json['Flag_006'] as int? ?? 0,
      Mode_006: json['Mode_006'] as int? ?? 63,
      Flag_007: json['Flag_007'] as int? ?? 1,
      Mode_007: json['Mode_007'] as int? ?? 81,
      Flag_008: json['Flag_008'] as int? ?? 0,
      Mode_008: json['Mode_008'] as int? ?? 83,
      Flag_009: json['Flag_009'] as int? ?? 0,
      Mode_009: json['Mode_009'] as int? ?? 11,
    );

Map<String, dynamic> _$Hq_TLILToJson(_Hq_TLIL instance) => <String, dynamic>{
      'useMax': instance.useMax,
      'Flag_001': instance.Flag_001,
      'Mode_001': instance.Mode_001,
      'Flag_002': instance.Flag_002,
      'Mode_002': instance.Mode_002,
      'Flag_003': instance.Flag_003,
      'Mode_003': instance.Mode_003,
      'Flag_004': instance.Flag_004,
      'Mode_004': instance.Mode_004,
      'Flag_005': instance.Flag_005,
      'Mode_005': instance.Mode_005,
      'Flag_006': instance.Flag_006,
      'Mode_006': instance.Mode_006,
      'Flag_007': instance.Flag_007,
      'Mode_007': instance.Mode_007,
      'Flag_008': instance.Flag_008,
      'Mode_008': instance.Mode_008,
      'Flag_009': instance.Flag_009,
      'Mode_009': instance.Mode_009,
    };

_Netdoa_day_info _$Netdoa_day_infoFromJson(Map<String, dynamic> json) =>
    _Netdoa_day_info(
      info_max: json['info_max'] as int? ?? 21,
      info_01: json['info_01'] as String? ?? '1,3,reg_dly_deal',
      info_02: json['info_02'] as String? ?? '1,3,reg_dly_flow',
      info_03: json['info_03'] as String? ?? '1,3,reg_dly_plu',
      info_04: json['info_04'] as String? ?? '1,3,reg_dly_acr',
      info_05: json['info_05'] as String? ?? '1,3,reg_dly_brgn',
      info_06: json['info_06'] as String? ?? '1,3,reg_dly_mach',
      info_07: json['info_07'] as String? ?? '1,4,version.json',
      info_08: json['info_08'] as String? ?? '1,4,hq_set.json',
      info_09: json['info_09'] as String? ?? '1,3,reg_dly_mdl',
      info_10: json['info_10'] as String? ?? '1,3,reg_dly_sml',
      info_11: json['info_11'] as String? ?? '1,5,LGYOUMU',
      info_12: json['info_12'] as String? ?? '0,2,c_ej_log',
      info_13: json['info_13'] as String? ?? '0,2,c_data_log',
      info_14: json['info_14'] as String? ?? '0,2,c_status_log',
      info_15: json['info_15'] as String? ?? '0,2,c_header_log',
      info_16: json['info_16'] as String? ?? '1,3,reg_dly_cdpayflow',
      info_17: json['info_17'] as String? ?? '1,1,rdly_deal_hour',
      info_18: json['info_18'] as String? ?? '1,7,business_file',
      info_19: json['info_19'] as String? ?? '1,3,reg_dly_tax_deal',
      info_20: json['info_20'] as String? ?? '1,12,log/hist_err.sql',
      info_21: json['info_21'] as String? ?? '1,11,OGYOUMU',
    );

Map<String, dynamic> _$Netdoa_day_infoToJson(_Netdoa_day_info instance) =>
    <String, dynamic>{
      'info_max': instance.info_max,
      'info_01': instance.info_01,
      'info_02': instance.info_02,
      'info_03': instance.info_03,
      'info_04': instance.info_04,
      'info_05': instance.info_05,
      'info_06': instance.info_06,
      'info_07': instance.info_07,
      'info_08': instance.info_08,
      'info_09': instance.info_09,
      'info_10': instance.info_10,
      'info_11': instance.info_11,
      'info_12': instance.info_12,
      'info_13': instance.info_13,
      'info_14': instance.info_14,
      'info_15': instance.info_15,
      'info_16': instance.info_16,
      'info_17': instance.info_17,
      'info_18': instance.info_18,
      'info_19': instance.info_19,
      'info_20': instance.info_20,
      'info_21': instance.info_21,
    };

_Netdoa_cls_info _$Netdoa_cls_infoFromJson(Map<String, dynamic> json) =>
    _Netdoa_cls_info(
      info_max: json['info_max'] as int? ?? 30,
      info_01: json['info_01'] as String? ?? '1,3,reg_dly_deal',
      info_02: json['info_02'] as String? ?? '1,3,reg_dly_flow',
      info_03: json['info_03'] as String? ?? '1,3,reg_dly_plu',
      info_04: json['info_04'] as String? ?? '1,3,reg_dly_acr',
      info_05: json['info_05'] as String? ?? '1,3,reg_dly_brgn',
      info_06: json['info_06'] as String? ?? '1,3,reg_dly_mach',
      info_07: json['info_07'] as String? ?? '1,4,version.json',
      info_08: json['info_08'] as String? ?? '1,4,hq_set.json',
      info_09: json['info_09'] as String? ?? '1,3,reg_dly_mdl',
      info_10: json['info_10'] as String? ?? '1,3,reg_dly_sml',
      info_11: json['info_11'] as String? ?? '1,5,LGYOUMU',
      info_12: json['info_12'] as String? ?? '1,4,sys.json',
      info_13: json['info_13'] as String? ?? '1,1,c_cls_mst',
      info_14: json['info_14'] as String? ?? '1,1,s_brgn_mst',
      info_15: json['info_15'] as String? ?? '1,1,s_bdlitem_mst',
      info_16: json['info_16'] as String? ?? '1,1,s_bdlsch_mst',
      info_17: json['info_17'] as String? ?? '1,1,s_stmitem_mst',
      info_18: json['info_18'] as String? ?? '1,1,s_stmsch_mst',
      info_19: json['info_19'] as String? ?? '0,2,c_ej_log',
      info_20: json['info_20'] as String? ?? '0,2,c_data_log',
      info_21: json['info_21'] as String? ?? '0,2,c_status_log',
      info_22: json['info_22'] as String? ?? '0,2,c_header_log',
      info_23: json['info_23'] as String? ?? '1,3,reg_dly_cdpayflow',
      info_24: json['info_24'] as String? ?? '1,1,rdly_deal_hour',
      info_25: json['info_25'] as String? ?? '1,7,business_file',
      info_26: json['info_26'] as String? ?? '1,3,reg_dly_tax_deal',
      info_27: json['info_27'] as String? ?? '0,9,ATTENDTIME',
      info_28: json['info_28'] as String? ?? '1,12,log/hist_err.sql',
      info_29: json['info_29'] as String? ?? '1,1,s_cust_ttl_tbl',
      info_30: json['info_30'] as String? ?? '1,11,OGYOUMU',
    );

Map<String, dynamic> _$Netdoa_cls_infoToJson(_Netdoa_cls_info instance) =>
    <String, dynamic>{
      'info_max': instance.info_max,
      'info_01': instance.info_01,
      'info_02': instance.info_02,
      'info_03': instance.info_03,
      'info_04': instance.info_04,
      'info_05': instance.info_05,
      'info_06': instance.info_06,
      'info_07': instance.info_07,
      'info_08': instance.info_08,
      'info_09': instance.info_09,
      'info_10': instance.info_10,
      'info_11': instance.info_11,
      'info_12': instance.info_12,
      'info_13': instance.info_13,
      'info_14': instance.info_14,
      'info_15': instance.info_15,
      'info_16': instance.info_16,
      'info_17': instance.info_17,
      'info_18': instance.info_18,
      'info_19': instance.info_19,
      'info_20': instance.info_20,
      'info_21': instance.info_21,
      'info_22': instance.info_22,
      'info_23': instance.info_23,
      'info_24': instance.info_24,
      'info_25': instance.info_25,
      'info_26': instance.info_26,
      'info_27': instance.info_27,
      'info_28': instance.info_28,
      'info_29': instance.info_29,
      'info_30': instance.info_30,
    };

_Netdoa_ej_info _$Netdoa_ej_infoFromJson(Map<String, dynamic> json) =>
    _Netdoa_ej_info(
      info_max: json['info_max'] as int? ?? 1,
      info_01: json['info_01'] as String? ?? '1,2,c_ej_log',
    );

Map<String, dynamic> _$Netdoa_ej_infoToJson(_Netdoa_ej_info instance) =>
    <String, dynamic>{
      'info_max': instance.info_max,
      'info_01': instance.info_01,
    };

_Ts_day_info _$Ts_day_infoFromJson(Map<String, dynamic> json) => _Ts_day_info(
      info_max: json['info_max'] as int? ?? 1,
      info_01: json['info_01'] as String? ?? '1,5,LGYOUMU',
    );

Map<String, dynamic> _$Ts_day_infoToJson(_Ts_day_info instance) =>
    <String, dynamic>{
      'info_max': instance.info_max,
      'info_01': instance.info_01,
    };

_Ts_cls_info _$Ts_cls_infoFromJson(Map<String, dynamic> json) => _Ts_cls_info(
      info_max: json['info_max'] as int? ?? 1,
      info_01: json['info_01'] as String? ?? '1,5,LGYOUMU',
    );

Map<String, dynamic> _$Ts_cls_infoToJson(_Ts_cls_info instance) =>
    <String, dynamic>{
      'info_max': instance.info_max,
      'info_01': instance.info_01,
    };

_Netdoa_mstsend _$Netdoa_mstsendFromJson(Map<String, dynamic> json) =>
    _Netdoa_mstsend(
      info_max: json['info_max'] as int? ?? 35,
      info_01: json['info_01'] as String? ?? '0,1,c_cls_mst',
      info_02: json['info_02'] as String? ?? '0,1,c_plu_mst',
      info_03: json['info_03'] as String? ?? '0,1,s_brgn_mst',
      info_04: json['info_04'] as String? ?? '0,1,s_bdlsch_mst',
      info_05: json['info_05'] as String? ?? '0,1,s_bdlitem_mst',
      info_06: json['info_06'] as String? ?? '0,1,s_stmsch_mst',
      info_07: json['info_07'] as String? ?? '0,1,s_stmitem_mst',
      info_08: json['info_08'] as String? ?? '0,1,c_img_mst',
      info_09: json['info_09'] as String? ?? '0,1,c_preset_mst',
      info_10: json['info_10'] as String? ?? '0,1,c_tax_mst',
      info_11: json['info_11'] as String? ?? '0,1,c_instre_mst',
      info_12: json['info_12'] as String? ?? '0,1,c_staff_mst',
      info_13: json['info_13'] as String? ?? '0,1,c_staffauth_mst',
      info_14: json['info_14'] as String? ?? '0,1,c_keyauth_mst',
      info_15: json['info_15'] as String? ?? '0,1,c_menuauth_mst',
      info_16: json['info_16'] as String? ?? '0,1,c_operationauth_mst',
      info_17: json['info_17'] as String? ?? '0,1,c_keyfnc_mst',
      info_18: json['info_18'] as String? ?? '0,1,c_keyopt_mst',
      info_19: json['info_19'] as String? ?? '0,1,c_producer_mst',
      info_20: json['info_20'] as String? ?? '0,1,c_divide_mst',
      info_21: json['info_21'] as String? ?? '0,1,c_msg_mst',
      info_22: json['info_22'] as String? ?? '0,1,c_msglayout_mst',
      info_23: json['info_23'] as String? ?? '0,1,c_msgsch_mst',
      info_24: json['info_24'] as String? ?? '0,1,c_msgsch_layout_mst',
      info_25: json['info_25'] as String? ?? '0,1,c_appl_grp_mst',
      info_26: json['info_26'] as String? ?? '0,1,c_keykind_mst',
      info_27: json['info_27'] as String? ?? '0,1,c_keykind_grp_mst',
      info_28: json['info_28'] as String? ?? '0,1,c_operation_mst',
      info_29: json['info_29'] as String? ?? '0,1,c_keyopt_set_mst',
      info_30: json['info_30'] as String? ?? '0,1,c_keyopt_sub_mst',
      info_31: json['info_31'] as String? ?? '0,1,c_scanplu_mst',
      info_32: json['info_32'] as String? ?? '0,1,p_promsch_mst',
      info_33: json['info_33'] as String? ?? '0,1,p_promitem_mst',
      info_34: json['info_34'] as String? ?? '0,1,c_loypln_mst',
      info_35: json['info_35'] as String? ?? '0,1,c_loyplu_mst',
    );

Map<String, dynamic> _$Netdoa_mstsendToJson(_Netdoa_mstsend instance) =>
    <String, dynamic>{
      'info_max': instance.info_max,
      'info_01': instance.info_01,
      'info_02': instance.info_02,
      'info_03': instance.info_03,
      'info_04': instance.info_04,
      'info_05': instance.info_05,
      'info_06': instance.info_06,
      'info_07': instance.info_07,
      'info_08': instance.info_08,
      'info_09': instance.info_09,
      'info_10': instance.info_10,
      'info_11': instance.info_11,
      'info_12': instance.info_12,
      'info_13': instance.info_13,
      'info_14': instance.info_14,
      'info_15': instance.info_15,
      'info_16': instance.info_16,
      'info_17': instance.info_17,
      'info_18': instance.info_18,
      'info_19': instance.info_19,
      'info_20': instance.info_20,
      'info_21': instance.info_21,
      'info_22': instance.info_22,
      'info_23': instance.info_23,
      'info_24': instance.info_24,
      'info_25': instance.info_25,
      'info_26': instance.info_26,
      'info_27': instance.info_27,
      'info_28': instance.info_28,
      'info_29': instance.info_29,
      'info_30': instance.info_30,
      'info_31': instance.info_31,
      'info_32': instance.info_32,
      'info_33': instance.info_33,
      'info_34': instance.info_34,
      'info_35': instance.info_35,
    };

_Css_day_info _$Css_day_infoFromJson(Map<String, dynamic> json) =>
    _Css_day_info(
      info_max: json['info_max'] as int? ?? 4,
      info_01: json['info_01'] as String? ?? '1,6,RGYOUMU',
      info_02: json['info_02'] as String? ?? '1,10,CGYOUMU',
      info_03: json['info_03'] as String? ?? '1,5,LGYOUMU',
      info_04: json['info_04'] as String? ?? '1,11,OGYOUMU',
    );

Map<String, dynamic> _$Css_day_infoToJson(_Css_day_info instance) =>
    <String, dynamic>{
      'info_max': instance.info_max,
      'info_01': instance.info_01,
      'info_02': instance.info_02,
      'info_03': instance.info_03,
      'info_04': instance.info_04,
    };

_Css_cls_info _$Css_cls_infoFromJson(Map<String, dynamic> json) =>
    _Css_cls_info(
      info_max: json['info_max'] as int? ?? 6,
      info_01: json['info_01'] as String? ?? '1,6,RGYOUMU',
      info_02: json['info_02'] as String? ?? '1,10,CGYOUMU',
      info_03: json['info_03'] as String? ?? '1,14,IGYOUMU',
      info_04: json['info_04'] as String? ?? '1,15,DGYOUMU',
      info_05: json['info_05'] as String? ?? '1,5,LGYOUMU',
      info_06: json['info_06'] as String? ?? '1,11,OGYOUMU',
    );

Map<String, dynamic> _$Css_cls_infoToJson(_Css_cls_info instance) =>
    <String, dynamic>{
      'info_max': instance.info_max,
      'info_01': instance.info_01,
      'info_02': instance.info_02,
      'info_03': instance.info_03,
      'info_04': instance.info_04,
      'info_05': instance.info_05,
      'info_06': instance.info_06,
    };

_Css_odr_info _$Css_odr_infoFromJson(Map<String, dynamic> json) =>
    _Css_odr_info(
      info_max: json['info_max'] as int? ?? 1,
      info_01: json['info_01'] as String? ?? '1,8,HGYOUMU',
    );

Map<String, dynamic> _$Css_odr_infoToJson(_Css_odr_info instance) =>
    <String, dynamic>{
      'info_max': instance.info_max,
      'info_01': instance.info_01,
    };

_Css_mst_create _$Css_mst_createFromJson(Map<String, dynamic> json) =>
    _Css_mst_create(
      info_max: json['info_max'] as int? ?? 1,
      info_01: json['info_01'] as String? ?? '1,13,AGYOUMU',
    );

Map<String, dynamic> _$Css_mst_createToJson(_Css_mst_create instance) =>
    <String, dynamic>{
      'info_max': instance.info_max,
      'info_01': instance.info_01,
    };

_Cls_text_info _$Cls_text_infoFromJson(Map<String, dynamic> json) =>
    _Cls_text_info(
      info_max: json['info_max'] as int? ?? 4,
      info_01: json['info_01'] as String? ?? '0,2,c_ej_log',
      info_02: json['info_02'] as String? ?? '0,2,c_data_log',
      info_03: json['info_03'] as String? ?? '0,2,c_status_log',
      info_04: json['info_04'] as String? ?? '0,2,c_header_log',
    );

Map<String, dynamic> _$Cls_text_infoToJson(_Cls_text_info instance) =>
    <String, dynamic>{
      'info_max': instance.info_max,
      'info_01': instance.info_01,
      'info_02': instance.info_02,
      'info_03': instance.info_03,
      'info_04': instance.info_04,
    };
