// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suicaJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuicaJsonFile _$SuicaJsonFileFromJson(Map<String, dynamic> json) =>
    SuicaJsonFile()
      ..suica = _Suica.fromJson(json['suica'] as Map<String, dynamic>)
      ..sense = _Sense.fromJson(json['sense'] as Map<String, dynamic>)
      ..TRAN = _TTRAN.fromJson(json['TRAN'] as Map<String, dynamic>)
      ..key = _Key.fromJson(json['key'] as Map<String, dynamic>)
      ..multi_nimoca =
          _Multi_nimoca.fromJson(json['multi_nimoca'] as Map<String, dynamic>);

Map<String, dynamic> _$SuicaJsonFileToJson(SuicaJsonFile instance) =>
    <String, dynamic>{
      'suica': instance.suica.toJson(),
      'sense': instance.sense.toJson(),
      'TRAN': instance.TRAN.toJson(),
      'key': instance.key.toJson(),
      'multi_nimoca': instance.multi_nimoca.toJson(),
    };

_Suica _$SuicaFromJson(Map<String, dynamic> json) => _Suica(
      SuicaNo: json['SuicaNo'] as String? ?? '0000000000000',
      ng_print: json['ng_print'] as int? ?? 0,
    );

Map<String, dynamic> _$SuicaToJson(_Suica instance) => <String, dynamic>{
      'SuicaNo': instance.SuicaNo,
      'ng_print': instance.ng_print,
    };

_Sense _$SenseFromJson(Map<String, dynamic> json) => _Sense(
      send_date: json['send_date'] as String? ?? '',
      offset: json['offset'] as String? ?? '',
      rw_code: json['rw_code'] as String? ?? '',
      str_id: json['str_id'] as String? ?? '',
      rw_mac: json['rw_mac'] as String? ?? '',
      rw_ip: json['rw_ip'] as String? ?? '',
      subnet: json['subnet'] as String? ?? '',
      gateway: json['gateway'] as String? ?? '',
      svr_ip: json['svr_ip'] as String? ?? '',
      port_no: json['port_no'] as String? ?? '',
      serial_no: json['serial_no'] as String? ?? '',
      product_no: json['product_no'] as String? ?? '',
      end_icseq: json['end_icseq'] as String? ?? '',
      send_cnt: json['send_cnt'] as String? ?? '',
      non_send_cnt: json['non_send_cnt'] as String? ?? '',
      timeout1: json['timeout1'] as String? ?? '',
      timeout2: json['timeout2'] as String? ?? '',
      timeout3: json['timeout3'] as String? ?? '',
      trm_data_pt: json['trm_data_pt'] as String? ?? '',
      trm_data_vr: json['trm_data_vr'] as String? ?? '',
      cent_occnt: json['cent_occnt'] as String? ?? '',
      est_part: json['est_part'] as String? ?? '',
      parse_amt: json['parse_amt'] as String? ?? '',
      rw_fver: json['rw_fver'] as String? ?? '',
    );

Map<String, dynamic> _$SenseToJson(_Sense instance) => <String, dynamic>{
      'send_date': instance.send_date,
      'offset': instance.offset,
      'rw_code': instance.rw_code,
      'str_id': instance.str_id,
      'rw_mac': instance.rw_mac,
      'rw_ip': instance.rw_ip,
      'subnet': instance.subnet,
      'gateway': instance.gateway,
      'svr_ip': instance.svr_ip,
      'port_no': instance.port_no,
      'serial_no': instance.serial_no,
      'product_no': instance.product_no,
      'end_icseq': instance.end_icseq,
      'send_cnt': instance.send_cnt,
      'non_send_cnt': instance.non_send_cnt,
      'timeout1': instance.timeout1,
      'timeout2': instance.timeout2,
      'timeout3': instance.timeout3,
      'trm_data_pt': instance.trm_data_pt,
      'trm_data_vr': instance.trm_data_vr,
      'cent_occnt': instance.cent_occnt,
      'est_part': instance.est_part,
      'parse_amt': instance.parse_amt,
      'rw_fver': instance.rw_fver,
    };

_TTRAN _$TTRANFromJson(Map<String, dynamic> json) => _TTRAN(
      before_tran_typ: json['before_tran_typ'] as String? ?? '',
      before_tran_amt: json['before_tran_amt'] as String? ?? '',
      before_seq_ic: json['before_seq_ic'] as String? ?? '',
    );

Map<String, dynamic> _$TTRANToJson(_TTRAN instance) => <String, dynamic>{
      'before_tran_typ': instance.before_tran_typ,
      'before_tran_amt': instance.before_tran_amt,
      'before_seq_ic': instance.before_seq_ic,
    };

_Key _$KeyFromJson(Map<String, dynamic> json) => _Key(
      suica_debug_key: json['suica_debug_key'] as int? ?? 0,
    );

Map<String, dynamic> _$KeyToJson(_Key instance) => <String, dynamic>{
      'suica_debug_key': instance.suica_debug_key,
    };

_Multi_nimoca _$Multi_nimocaFromJson(Map<String, dynamic> json) =>
    _Multi_nimoca(
      nimoca_aplchg_wait1: json['nimoca_aplchg_wait1'] as int? ?? 4,
      nimoca_aplchg_wait2: json['nimoca_aplchg_wait2'] as int? ?? 2,
      nimoca_aplchg_wait3: json['nimoca_aplchg_wait3'] as int? ?? 4,
    );

Map<String, dynamic> _$Multi_nimocaToJson(_Multi_nimoca instance) =>
    <String, dynamic>{
      'nimoca_aplchg_wait1': instance.nimoca_aplchg_wait1,
      'nimoca_aplchg_wait2': instance.nimoca_aplchg_wait2,
      'nimoca_aplchg_wait3': instance.nimoca_aplchg_wait3,
    };
