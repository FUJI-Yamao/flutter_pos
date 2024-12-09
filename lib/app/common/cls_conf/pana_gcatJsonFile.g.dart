// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pana_gcatJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pana_gcatJsonFile _$Pana_gcatJsonFileFromJson(Map<String, dynamic> json) =>
    Pana_gcatJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Pana_gcatJsonFileToJson(Pana_gcatJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? 'com3',
      baudrate: json['baudrate'] as int? ?? 2400,
      databit: json['databit'] as int? ?? 8,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 1,
      parity: json['parity'] as String? ?? 'even',
      bill: json['bill'] as String? ?? 'no',
      tmout_nak_send: json['tmout_nak_send'] as int? ?? 1,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'port': instance.port,
      'baudrate': instance.baudrate,
      'databit': instance.databit,
      'startbit': instance.startbit,
      'stopbit': instance.stopbit,
      'parity': instance.parity,
      'bill': instance.bill,
      'tmout_nak_send': instance.tmout_nak_send,
    };
