// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sm_scale1JsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sm_scale1JsonFile _$Sm_scale1JsonFileFromJson(Map<String, dynamic> json) =>
    Sm_scale1JsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Sm_scale1JsonFileToJson(Sm_scale1JsonFile instance) =>
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
      id: json['id'] as int? ?? 1,
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
