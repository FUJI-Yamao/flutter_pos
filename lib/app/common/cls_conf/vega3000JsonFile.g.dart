// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vega3000JsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vega3000JsonFile _$Vega3000JsonFileFromJson(Map<String, dynamic> json) =>
    Vega3000JsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Vega3000JsonFileToJson(Vega3000JsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? 'com1',
      baudrate: json['baudrate'] as int? ?? 19200,
      databit: json['databit'] as int? ?? 8,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 1,
      parity: json['parity'] as String? ?? 'even',
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