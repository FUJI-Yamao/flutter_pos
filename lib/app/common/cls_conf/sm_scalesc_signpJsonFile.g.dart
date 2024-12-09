// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sm_scalesc_signpJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sm_scalesc_signpJsonFile _$Sm_scalesc_signpJsonFileFromJson(
        Map<String, dynamic> json) =>
    Sm_scalesc_signpJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Sm_scalesc_signpJsonFileToJson(
        Sm_scalesc_signpJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      baudrate: json['baudrate'] as int? ?? 38400,
      databit: json['databit'] as int? ?? 8,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 1,
      parity: json['parity'] as String? ?? 'even',
      id: json['id'] as int? ?? 2,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'baudrate': instance.baudrate,
      'databit': instance.databit,
      'startbit': instance.startbit,
      'stopbit': instance.stopbit,
      'parity': instance.parity,
      'id': instance.id,
    };
