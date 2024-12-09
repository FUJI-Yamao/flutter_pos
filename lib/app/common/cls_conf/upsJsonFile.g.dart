// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpsJsonFile _$UpsJsonFileFromJson(Map<String, dynamic> json) =>
    UpsJsonFile()..ups = _Ups.fromJson(json['ups'] as Map<String, dynamic>);

Map<String, dynamic> _$UpsJsonFileToJson(UpsJsonFile instance) =>
    <String, dynamic>{
      'ups': instance.ups.toJson(),
    };

_Ups _$UpsFromJson(Map<String, dynamic> json) => _Ups(
      port: json['port'] as String? ?? '/dev/cua0',
      basetimer: json['basetimer'] as int? ?? 5000,
      emgtimer: json['emgtimer'] as int? ?? 1000,
      emgcnt: json['emgcnt'] as int? ?? 10,
    );

Map<String, dynamic> _$UpsToJson(_Ups instance) => <String, dynamic>{
      'port': instance.port,
      'basetimer': instance.basetimer,
      'emgtimer': instance.emgtimer,
      'emgcnt': instance.emgcnt,
    };
