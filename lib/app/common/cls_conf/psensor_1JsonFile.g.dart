// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psensor_1JsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Psensor_1JsonFile _$Psensor_1JsonFileFromJson(Map<String, dynamic> json) =>
    Psensor_1JsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Psensor_1JsonFileToJson(Psensor_1JsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? 'com1',
      baudrate: json['baudrate'] as int? ?? 115200,
      databit: json['databit'] as int? ?? 8,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 1,
      parity: json['parity'] as String? ?? 'none',
      id: json['id'] as int? ?? 1,
      port_type: json['port_type'] as String? ?? 'fip',
      interval: json['interval'] as int? ?? 3,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'port': instance.port,
      'baudrate': instance.baudrate,
      'databit': instance.databit,
      'startbit': instance.startbit,
      'stopbit': instance.stopbit,
      'parity': instance.parity,
      'id': instance.id,
      'port_type': instance.port_type,
      'interval': instance.interval,
    };
