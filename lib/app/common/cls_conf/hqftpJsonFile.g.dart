// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hqftpJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HqftpJsonFile _$HqftpJsonFileFromJson(Map<String, dynamic> json) =>
    HqftpJsonFile()
      ..cycle = _Cycle.fromJson(json['cycle'] as Map<String, dynamic>)
      ..specify = _Specify.fromJson(json['specify'] as Map<String, dynamic>)
      ..strcls = _Strcls.fromJson(json['strcls'] as Map<String, dynamic>);

Map<String, dynamic> _$HqftpJsonFileToJson(HqftpJsonFile instance) =>
    <String, dynamic>{
      'cycle': instance.cycle.toJson(),
      'specify': instance.specify.toJson(),
      'strcls': instance.strcls.toJson(),
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

_Strcls _$StrclsFromJson(Map<String, dynamic> json) => _Strcls(
      il_tl_send: json['il_tl_send'] as int? ?? 0,
      jnl_send: json['jnl_send'] as int? ?? 0,
    );

Map<String, dynamic> _$StrclsToJson(_Strcls instance) => <String, dynamic>{
      'il_tl_send': instance.il_tl_send,
      'jnl_send': instance.jnl_send,
    };
