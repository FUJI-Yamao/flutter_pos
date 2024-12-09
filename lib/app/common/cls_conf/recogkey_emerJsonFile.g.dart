// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recogkey_emerJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recogkey_emerJsonFile _$Recogkey_emerJsonFileFromJson(
        Map<String, dynamic> json) =>
    Recogkey_emerJsonFile()
      ..DATE = _DDATE.fromJson(json['DATE'] as Map<String, dynamic>)
      ..TIME = _TTIME.fromJson(json['TIME'] as Map<String, dynamic>);

Map<String, dynamic> _$Recogkey_emerJsonFileToJson(
        Recogkey_emerJsonFile instance) =>
    <String, dynamic>{
      'DATE': instance.DATE.toJson(),
      'TIME': instance.TIME.toJson(),
    };

_DDATE _$DDATEFromJson(Map<String, dynamic> json) => _DDATE(
      date: json['date'] as String? ?? '',
    );

Map<String, dynamic> _$DDATEToJson(_DDATE instance) => <String, dynamic>{
      'date': instance.date,
    };

_TTIME _$TTIMEFromJson(Map<String, dynamic> json) => _TTIME(
      time: json['time'] as String? ?? '',
    );

Map<String, dynamic> _$TTIMEToJson(_TTIME instance) => <String, dynamic>{
      'time': instance.time,
    };
