// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yamatoJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YamatoJsonFile _$YamatoJsonFileFromJson(Map<String, dynamic> json) =>
    YamatoJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$YamatoJsonFileToJson(YamatoJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? 'com1',
      baudrate: json['baudrate'] as int? ?? 9600,
      databit: json['databit'] as int? ?? 8,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 1,
      parity: json['parity'] as String? ?? 'none',
      bill: json['bill'] as String? ?? 'no',
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'port': instance.port,
      'baudrate': instance.baudrate,
      'databit': instance.databit,
      'startbit': instance.startbit,
      'stopbit': instance.stopbit,
      'parity': instance.parity,
      'bill': instance.bill,
    };
