// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpointJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RpointJsonFile _$RpointJsonFileFromJson(Map<String, dynamic> json) =>
    RpointJsonFile()
      ..communicate =
          _Communicate.fromJson(json['communicate'] as Map<String, dynamic>)
      ..training = _Training.fromJson(json['training'] as Map<String, dynamic>);

Map<String, dynamic> _$RpointJsonFileToJson(RpointJsonFile instance) =>
    <String, dynamic>{
      'communicate': instance.communicate.toJson(),
      'training': instance.training.toJson(),
    };

_Communicate _$CommunicateFromJson(Map<String, dynamic> json) => _Communicate(
      url: json['url'] as String? ?? 'https://',
      hmac_key: json['hmac_key'] as String? ?? 'none',
      timeout: json['timeout'] as int? ?? 5,
      access_key: json['access_key'] as String? ?? 'none',
    );

Map<String, dynamic> _$CommunicateToJson(_Communicate instance) =>
    <String, dynamic>{
      'url': instance.url,
      'hmac_key': instance.hmac_key,
      'timeout': instance.timeout,
      'access_key': instance.access_key,
    };

_Training _$TrainingFromJson(Map<String, dynamic> json) => _Training(
      tr_points: json['tr_points'] as int? ?? 1000,
    );

Map<String, dynamic> _$TrainingToJson(_Training instance) => <String, dynamic>{
      'tr_points': instance.tr_points,
    };
