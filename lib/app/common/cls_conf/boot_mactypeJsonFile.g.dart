// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boot_mactypeJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Boot_mactypeJsonFile _$Boot_mactypeJsonFileFromJson(
        Map<String, dynamic> json) =>
    Boot_mactypeJsonFile()
      ..type = _Type.fromJson(json['type'] as Map<String, dynamic>)
      ..counter = _Counter.fromJson(json['counter'] as Map<String, dynamic>)
      ..debug_counter = _Debug_counter.fromJson(
          json['debug_counter'] as Map<String, dynamic>);

Map<String, dynamic> _$Boot_mactypeJsonFileToJson(
        Boot_mactypeJsonFile instance) =>
    <String, dynamic>{
      'type': instance.type.toJson(),
      'counter': instance.counter.toJson(),
      'debug_counter': instance.debug_counter.toJson(),
    };

_Type _$TypeFromJson(Map<String, dynamic> json) => _Type(
      tower: json['tower'] as String? ?? 'no',
    );

Map<String, dynamic> _$TypeToJson(_Type instance) => <String, dynamic>{
      'tower': instance.tower,
    };

_Counter _$CounterFromJson(Map<String, dynamic> json) => _Counter(
      max: json['max'] as int? ?? 3,
      cnt: json['cnt'] as int? ?? 3,
    );

Map<String, dynamic> _$CounterToJson(_Counter instance) => <String, dynamic>{
      'max': instance.max,
      'cnt': instance.cnt,
    };

_Debug_counter _$Debug_counterFromJson(Map<String, dynamic> json) =>
    _Debug_counter(
      max: json['max'] as int? ?? 3,
      cnt: json['cnt'] as int? ?? 3,
    );

Map<String, dynamic> _$Debug_counterToJson(_Debug_counter instance) =>
    <String, dynamic>{
      'max': instance.max,
      'cnt': instance.cnt,
    };
