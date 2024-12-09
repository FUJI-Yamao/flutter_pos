// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gcat_cnctJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gcat_cnctJsonFile _$Gcat_cnctJsonFileFromJson(Map<String, dynamic> json) =>
    Gcat_cnctJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Gcat_cnctJsonFileToJson(Gcat_cnctJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? 'com1',
      baudrate: json['baudrate'] as int? ?? 4800,
      databit: json['databit'] as int? ?? 8,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 1,
      parity: json['parity'] as String? ?? 'none',
      bill: json['bill'] as String? ?? 'no',
      text_timer: json['text_timer'] as int? ?? 5,
      respons_timer: json['respons_timer'] as int? ?? 12,
      ack_cnt: json['ack_cnt'] as int? ?? 3,
      text_cnt: json['text_cnt'] as int? ?? 59,
      eot_cnt: json['eot_cnt'] as int? ?? 3,
      nak_cnt: json['nak_cnt'] as int? ?? 3,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'port': instance.port,
      'baudrate': instance.baudrate,
      'databit': instance.databit,
      'startbit': instance.startbit,
      'stopbit': instance.stopbit,
      'parity': instance.parity,
      'bill': instance.bill,
      'text_timer': instance.text_timer,
      'respons_timer': instance.respons_timer,
      'ack_cnt': instance.ack_cnt,
      'text_cnt': instance.text_cnt,
      'eot_cnt': instance.eot_cnt,
      'nak_cnt': instance.nak_cnt,
    };
