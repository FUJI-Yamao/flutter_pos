// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acb20JsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Acb20JsonFile _$Acb20JsonFileFromJson(Map<String, dynamic> json) =>
    Acb20JsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Acb20JsonFileToJson(Acb20JsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? 'com1',
      baudrate: json['baudrate'] as int? ?? 2400,
      databit: json['databit'] as int? ?? 7,
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
