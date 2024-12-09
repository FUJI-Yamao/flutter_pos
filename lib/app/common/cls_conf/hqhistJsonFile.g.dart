// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hqhistJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HqhistJsonFile _$HqhistJsonFileFromJson(Map<String, dynamic> json) =>
    HqhistJsonFile()
      ..cycle = _Cycle.fromJson(json['cycle'] as Map<String, dynamic>)
      ..specify = _Specify.fromJson(json['specify'] as Map<String, dynamic>)
      ..counter = _Counter.fromJson(json['counter'] as Map<String, dynamic>);

Map<String, dynamic> _$HqhistJsonFileToJson(HqhistJsonFile instance) =>
    <String, dynamic>{
      'cycle': instance.cycle.toJson(),
      'specify': instance.specify.toJson(),
      'counter': instance.counter.toJson(),
    };

_Cycle _$CycleFromJson(Map<String, dynamic> json) => _Cycle(
      value: json['value'] as int? ?? 9999,
    );

Map<String, dynamic> _$CycleToJson(_Cycle instance) => <String, dynamic>{
      'value': instance.value,
    };

_Specify _$SpecifyFromJson(Map<String, dynamic> json) => _Specify(
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

Map<String, dynamic> _$SpecifyToJson(_Specify instance) => <String, dynamic>{
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

_Counter _$CounterFromJson(Map<String, dynamic> json) => _Counter(
      hqhist_cd_down: json['hqhist_cd_down'] as int? ?? 0,
      hqhist_cd_up: json['hqhist_cd_up'] as int? ?? 0,
      hqtmp_mst_cd_up: json['hqtmp_mst_cd_up'] as int? ?? 0,
      last_ttllog_serial_no: json['last_ttllog_serial_no'] as int? ?? 0,
      nippou_cnt: json['nippou_cnt'] as int? ?? 0,
      meisai_cnt: json['meisai_cnt'] as int? ?? 0,
      TranS3_hist_cd: json['TranS3_hist_cd'] as String? ?? '0,0',
      last_ttllog_serial_no2nd: json['last_ttllog_serial_no2nd'] as int? ?? 0,
    );

Map<String, dynamic> _$CounterToJson(_Counter instance) => <String, dynamic>{
      'hqhist_cd_down': instance.hqhist_cd_down,
      'hqhist_cd_up': instance.hqhist_cd_up,
      'hqtmp_mst_cd_up': instance.hqtmp_mst_cd_up,
      'last_ttllog_serial_no': instance.last_ttllog_serial_no,
      'nippou_cnt': instance.nippou_cnt,
      'meisai_cnt': instance.meisai_cnt,
      'TranS3_hist_cd': instance.TranS3_hist_cd,
      'last_ttllog_serial_no2nd': instance.last_ttllog_serial_no2nd,
    };
