// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ecs_fwJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ecs_fwJsonFile _$Ecs_fwJsonFileFromJson(Map<String, dynamic> json) =>
    Ecs_fwJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Ecs_fwJsonFileToJson(Ecs_fwJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      type: json['type'] as int? ?? 0,
      ver_ctrl: json['ver_ctrl'] as int? ?? 0,
      ver_coin: json['ver_coin'] as int? ?? 0,
      ver_bill: json['ver_bill'] as int? ?? 0,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'type': instance.type,
      'ver_ctrl': instance.ver_ctrl,
      'ver_coin': instance.ver_coin,
      'ver_bill': instance.ver_bill,
    };
