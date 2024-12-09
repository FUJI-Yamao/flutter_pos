// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custreal_ajsJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Custreal_ajsJsonFile _$Custreal_ajsJsonFileFromJson(
        Map<String, dynamic> json) =>
    Custreal_ajsJsonFile()
      ..https_host =
          _Https_host.fromJson(json['https_host'] as Map<String, dynamic>)
      ..normal = _Normal.fromJson(json['normal'] as Map<String, dynamic>)
      ..beniya_authcode = _Beniya_authcode.fromJson(
          json['beniya_authcode'] as Map<String, dynamic>);

Map<String, dynamic> _$Custreal_ajsJsonFileToJson(
        Custreal_ajsJsonFile instance) =>
    <String, dynamic>{
      'https_host': instance.https_host.toJson(),
      'normal': instance.normal.toJson(),
      'beniya_authcode': instance.beniya_authcode.toJson(),
    };

_Https_host _$Https_hostFromJson(Map<String, dynamic> json) => _Https_host(
      url1: json['url1'] as String? ?? 'https:',
      url2: json['url2'] as String? ?? 'https:',
      timeout: json['timeout'] as int? ?? 3,
    );

Map<String, dynamic> _$Https_hostToJson(_Https_host instance) =>
    <String, dynamic>{
      'url1': instance.url1,
      'url2': instance.url2,
      'timeout': instance.timeout,
    };

_Normal _$NormalFromJson(Map<String, dynamic> json) => _Normal(
      url: json['url'] as String? ?? '0.0.0.0',
      url_auto_cancel: json['url_auto_cancel'] as String? ?? '0.0.0.0',
      timeout: json['timeout'] as int? ?? 15,
      timeout2: json['timeout2'] as int? ?? 30,
      client_signature: json['client_signature'] as int? ?? 0,
      debug_zan: json['debug_zan'] as int? ?? 1000,
      debug_bonus: json['debug_bonus'] as int? ?? 0,
      debug_coupon: json['debug_coupon'] as int? ?? 0,
      debug_errcode: json['debug_errcode'] as int? ?? 0,
    );

Map<String, dynamic> _$NormalToJson(_Normal instance) => <String, dynamic>{
      'url': instance.url,
      'url_auto_cancel': instance.url_auto_cancel,
      'timeout': instance.timeout,
      'timeout2': instance.timeout2,
      'client_signature': instance.client_signature,
      'debug_zan': instance.debug_zan,
      'debug_bonus': instance.debug_bonus,
      'debug_coupon': instance.debug_coupon,
      'debug_errcode': instance.debug_errcode,
    };

_Beniya_authcode _$Beniya_authcodeFromJson(Map<String, dynamic> json) =>
    _Beniya_authcode(
      auth_url: json['auth_url'] as String? ?? 'https://',
      timeout: json['timeout'] as int? ?? 5,
    );

Map<String, dynamic> _$Beniya_authcodeToJson(_Beniya_authcode instance) =>
    <String, dynamic>{
      'auth_url': instance.auth_url,
      'timeout': instance.timeout,
    };
