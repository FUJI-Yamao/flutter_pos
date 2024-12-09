// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'msr_chkJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Msr_chkJsonFile _$Msr_chkJsonFileFromJson(Map<String, dynamic> json) =>
    Msr_chkJsonFile()
      ..JIS1 = _JJIS1.fromJson(json['JIS1'] as Map<String, dynamic>)
      ..JIS2 = _JJIS2.fromJson(json['JIS2'] as Map<String, dynamic>);

Map<String, dynamic> _$Msr_chkJsonFileToJson(Msr_chkJsonFile instance) =>
    <String, dynamic>{
      'JIS1': instance.JIS1.toJson(),
      'JIS2': instance.JIS2.toJson(),
    };

_JJIS1 _$JJIS1FromJson(Map<String, dynamic> json) => _JJIS1(
      length1: json['length1'] as int? ?? 40,
      length2: json['length2'] as int? ?? 32,
      length3: json['length3'] as int? ?? 35,
      length4: json['length4'] as int? ?? 0,
      length5: json['length5'] as int? ?? 0,
      max_length: json['max_length'] as int? ?? 40,
      min_length: json['min_length'] as int? ?? 30,
    );

Map<String, dynamic> _$JJIS1ToJson(_JJIS1 instance) => <String, dynamic>{
      'length1': instance.length1,
      'length2': instance.length2,
      'length3': instance.length3,
      'length4': instance.length4,
      'length5': instance.length5,
      'max_length': instance.max_length,
      'min_length': instance.min_length,
    };

_JJIS2 _$JJIS2FromJson(Map<String, dynamic> json) => _JJIS2(
      length1: json['length1'] as int? ?? 72,
      length2: json['length2'] as int? ?? 0,
      length3: json['length3'] as int? ?? 0,
      length4: json['length4'] as int? ?? 0,
      length5: json['length5'] as int? ?? 0,
      max_length: json['max_length'] as int? ?? 72,
      min_length: json['min_length'] as int? ?? 70,
    );

Map<String, dynamic> _$JJIS2ToJson(_JJIS2 instance) => <String, dynamic>{
      'length1': instance.length1,
      'length2': instance.length2,
      'length3': instance.length3,
      'length4': instance.length4,
      'length5': instance.length5,
      'max_length': instance.max_length,
      'min_length': instance.min_length,
    };
