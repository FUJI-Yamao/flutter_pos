// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eat_inJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Eat_inJsonFile _$Eat_inJsonFileFromJson(Map<String, dynamic> json) =>
    Eat_inJsonFile()
      ..counter = _Counter.fromJson(json['counter'] as Map<String, dynamic>);

Map<String, dynamic> _$Eat_inJsonFileToJson(Eat_inJsonFile instance) =>
    <String, dynamic>{
      'counter': instance.counter.toJson(),
    };

_Counter _$CounterFromJson(Map<String, dynamic> json) => _Counter(
      start: json['start'] as int? ?? 1,
      end: json['end'] as int? ?? 999,
    );

Map<String, dynamic> _$CounterToJson(_Counter instance) => <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };
