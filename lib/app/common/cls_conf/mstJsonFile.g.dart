// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mstJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MstJsonFile _$MstJsonFileFromJson(Map<String, dynamic> json) => MstJsonFile()
  ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$MstJsonFileToJson(MstJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? 'com1',
      baudrate: json['baudrate'] as int? ?? 38400,
      databit: json['databit'] as int? ?? 8,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 1,
      parity: json['parity'] as String? ?? 'none',
      id: json['id'] as int? ?? 1,
      port_type: json['port_type'] as String? ?? 'com',
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
