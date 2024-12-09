// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_2800_3JsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scan_2800_3JsonFile _$Scan_2800_3JsonFileFromJson(Map<String, dynamic> json) =>
    Scan_2800_3JsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Scan_2800_3JsonFileToJson(
        Scan_2800_3JsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? 'com2',
      baudrate: json['baudrate'] as int? ?? 9600,
      databit: json['databit'] as int? ?? 7,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 2,
      parity: json['parity'] as String? ?? 'odd',
      id: json['id'] as int? ?? 33,
      port_type: json['port_type'] as String? ?? 'scan',
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
    };
