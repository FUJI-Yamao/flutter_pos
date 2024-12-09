// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sm_scale2JsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sm_scale2JsonFile _$Sm_scale2JsonFileFromJson(Map<String, dynamic> json) =>
    Sm_scale2JsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Sm_scale2JsonFileToJson(Sm_scale2JsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? 'com1',
      baudrate: json['baudrate'] as int? ?? 38400,
      databit: json['databit'] as int? ?? 8,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 1,
      parity: json['parity'] as String? ?? 'even',
      bill: json['bill'] as String? ?? 'no',
      id: json['id'] as int? ?? 2,
      interval: json['interval'] as int? ?? 3,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'port': instance.port,
      'baudrate': instance.baudrate,
      'databit': instance.databit,
      'startbit': instance.startbit,
      'stopbit': instance.stopbit,
      'parity': instance.parity,
      'bill': instance.bill,
      'id': instance.id,
      'interval': instance.interval,
    };
