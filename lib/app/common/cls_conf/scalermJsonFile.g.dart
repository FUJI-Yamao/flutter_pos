// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scalermJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScalermJsonFile _$ScalermJsonFileFromJson(Map<String, dynamic> json) =>
    ScalermJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>)
      ..info = _Info.fromJson(json['info'] as Map<String, dynamic>);

Map<String, dynamic> _$ScalermJsonFileToJson(ScalermJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
      'info': instance.info.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? '/dev/ttyS1',
      port2: json['port2'] as String? ?? '/dev/ttyS3',
      baudrate: json['baudrate'] as int? ?? 19200,
      databit: json['databit'] as int? ?? 8,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 1,
      parity: json['parity'] as String? ?? 'even',
      bill: json['bill'] as String? ?? 'no',
      id: json['id'] as int? ?? 1,
      stability_cond: json['stability_cond'] as String? ?? '01',
      tare_accumutation: json['tare_accumutation'] as int? ?? 0,
      tare_subtraction: json['tare_subtraction'] as int? ?? 1,
      start_range: json['start_range'] as String? ?? '00',
      auto_zero_reset: json['auto_zero_reset'] as int? ?? 1,
      auto_tare_clear: json['auto_tare_clear'] as int? ?? 0,
      priority_tare: json['priority_tare'] as int? ?? 1,
      auto_clear_cond: json['auto_clear_cond'] as int? ?? 0,
      tare_auto_clear: json['tare_auto_clear'] as int? ?? 1,
      zero_lamp: json['zero_lamp'] as int? ?? 0,
      manual_tare_cancel: json['manual_tare_cancel'] as int? ?? 0,
      digital_tare: json['digital_tare'] as int? ?? 0,
      weight_reset: json['weight_reset'] as int? ?? 0,
      zero_tracking: json['zero_tracking'] as int? ?? 0,
      pos_of_decimal_point: json['pos_of_decimal_point'] as String? ?? '000',
      rezero_range: json['rezero_range'] as String? ?? '000',
      rezero_func: json['rezero_func'] as int? ?? 0,
      single_or_multi: json['single_or_multi'] as int? ?? 1,
      negative_disp: json['negative_disp'] as String? ?? '00',
      tare_range: json['tare_range'] as int? ?? 0,
      type_of_point: json['type_of_point'] as int? ?? 0,
      digital_filter: json['digital_filter'] as String? ?? '01',
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'port': instance.port,
      'port2': instance.port2,
      'baudrate': instance.baudrate,
      'databit': instance.databit,
      'startbit': instance.startbit,
      'stopbit': instance.stopbit,
      'parity': instance.parity,
      'bill': instance.bill,
      'id': instance.id,
      'stability_cond': instance.stability_cond,
      'tare_accumutation': instance.tare_accumutation,
      'tare_subtraction': instance.tare_subtraction,
      'start_range': instance.start_range,
      'auto_zero_reset': instance.auto_zero_reset,
      'auto_tare_clear': instance.auto_tare_clear,
      'priority_tare': instance.priority_tare,
      'auto_clear_cond': instance.auto_clear_cond,
      'tare_auto_clear': instance.tare_auto_clear,
      'zero_lamp': instance.zero_lamp,
      'manual_tare_cancel': instance.manual_tare_cancel,
      'digital_tare': instance.digital_tare,
      'weight_reset': instance.weight_reset,
      'zero_tracking': instance.zero_tracking,
      'pos_of_decimal_point': instance.pos_of_decimal_point,
      'rezero_range': instance.rezero_range,
      'rezero_func': instance.rezero_func,
      'single_or_multi': instance.single_or_multi,
      'negative_disp': instance.negative_disp,
      'tare_range': instance.tare_range,
      'type_of_point': instance.type_of_point,
      'digital_filter': instance.digital_filter,
    };

_Info _$InfoFromJson(Map<String, dynamic> json) => _Info(
      version: json['version'] as int? ?? 0,
    );

Map<String, dynamic> _$InfoToJson(_Info instance) => <String, dynamic>{
      'version': instance.version,
    };
