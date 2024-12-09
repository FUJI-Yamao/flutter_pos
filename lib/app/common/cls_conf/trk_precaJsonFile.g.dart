// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trk_precaJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trk_precaJsonFile _$Trk_precaJsonFileFromJson(Map<String, dynamic> json) =>
    Trk_precaJsonFile()
      ..normal = _Normal.fromJson(json['normal'] as Map<String, dynamic>);

Map<String, dynamic> _$Trk_precaJsonFileToJson(Trk_precaJsonFile instance) =>
    <String, dynamic>{
      'normal': instance.normal.toJson(),
    };

_Normal _$NormalFromJson(Map<String, dynamic> json) => _Normal(
      url: json['url'] as String? ?? 'http://',
      url_auto_cancel: json['url_auto_cancel'] as String? ?? 'http://',
      timeout: json['timeout'] as int? ?? 5,
      client_signature: json['client_signature'] as int? ?? 0,
      debug_zan: json['debug_zan'] as int? ?? 10000,
      debug_premium: json['debug_premium'] as int? ?? 1000,
    );

Map<String, dynamic> _$NormalToJson(_Normal instance) => <String, dynamic>{
      'url': instance.url,
      'url_auto_cancel': instance.url_auto_cancel,
      'timeout': instance.timeout,
      'client_signature': instance.client_signature,
      'debug_zan': instance.debug_zan,
      'debug_premium': instance.debug_premium,
    };
