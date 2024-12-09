// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cogcaJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CogcaJsonFile _$CogcaJsonFileFromJson(Map<String, dynamic> json) =>
    CogcaJsonFile()
      ..normal = _Normal.fromJson(json['normal'] as Map<String, dynamic>);

Map<String, dynamic> _$CogcaJsonFileToJson(CogcaJsonFile instance) =>
    <String, dynamic>{
      'normal': instance.normal.toJson(),
    };

_Normal _$NormalFromJson(Map<String, dynamic> json) => _Normal(
      url: json['url'] as String? ?? '',
      url_auto_cancel: json['url_auto_cancel'] as String? ?? '',
      timeout: json['timeout'] as int? ?? 7,
      client_signature: json['client_signature'] as int? ?? 0,
      debug_zan: json['debug_zan'] as int? ?? 1000,
      debug_bonus: json['debug_bonus'] as int? ?? 0,
      debug_coupon: json['debug_coupon'] as int? ?? 0,
    );

Map<String, dynamic> _$NormalToJson(_Normal instance) => <String, dynamic>{
      'url': instance.url,
      'url_auto_cancel': instance.url_auto_cancel,
      'timeout': instance.timeout,
      'client_signature': instance.client_signature,
      'debug_zan': instance.debug_zan,
      'debug_bonus': instance.debug_bonus,
      'debug_coupon': instance.debug_coupon,
    };
