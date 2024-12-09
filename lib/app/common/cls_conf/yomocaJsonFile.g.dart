// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yomocaJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YomocaJsonFile _$YomocaJsonFileFromJson(Map<String, dynamic> json) =>
    YomocaJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$YomocaJsonFileToJson(YomocaJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? 'com2',
      baudrate: json['baudrate'] as int? ?? 9600,
      databit: json['databit'] as int? ?? 8,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 1,
      parity: json['parity'] as String? ?? 'none',
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'port': instance.port,
      'baudrate': instance.baudrate,
      'databit': instance.databit,
      'startbit': instance.startbit,
      'stopbit': instance.stopbit,
      'parity': instance.parity,
    };
