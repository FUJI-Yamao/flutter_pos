// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'valuecardJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValuecardJsonFile _$ValuecardJsonFileFromJson(Map<String, dynamic> json) =>
    ValuecardJsonFile()
      ..normal = _Normal.fromJson(json['normal'] as Map<String, dynamic>);

Map<String, dynamic> _$ValuecardJsonFileToJson(ValuecardJsonFile instance) =>
    <String, dynamic>{
      'normal': instance.normal.toJson(),
    };

_Normal _$NormalFromJson(Map<String, dynamic> json) => _Normal(
      url: json['url'] as String? ?? '',
      url_auto_cancel: json['url_auto_cancel'] as String? ?? '',
      timeout: json['timeout'] as int? ?? 5,
      client_signature: json['client_signature'] as int? ?? 0,
      debug_zan: json['debug_zan'] as int? ?? 1000,
      debug_bonus: json['debug_bonus'] as int? ?? 0,
      debug_coupon: json['debug_coupon'] as int? ?? 0,
      cnct_type: json['cnct_type'] as String? ?? 'DLL',
      Auth_Token: json['Auth_Token'] as String? ?? '',
      Auth_key: json['Auth_key'] as String? ?? '',
      seqno: json['seqno'] as int? ?? 0,
    );

Map<String, dynamic> _$NormalToJson(_Normal instance) => <String, dynamic>{
      'url': instance.url,
      'url_auto_cancel': instance.url_auto_cancel,
      'timeout': instance.timeout,
      'client_signature': instance.client_signature,
      'debug_zan': instance.debug_zan,
      'debug_bonus': instance.debug_bonus,
      'debug_coupon': instance.debug_coupon,
      'cnct_type': instance.cnct_type,
      'Auth_Token': instance.Auth_Token,
      'Auth_key': instance.Auth_key,
      'seqno': instance.seqno,
    };
