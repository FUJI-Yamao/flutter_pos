// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yumeca_polJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Yumeca_polJsonFile _$Yumeca_polJsonFileFromJson(Map<String, dynamic> json) =>
    Yumeca_polJsonFile()
      ..normal = _Normal.fromJson(json['normal'] as Map<String, dynamic>);

Map<String, dynamic> _$Yumeca_polJsonFileToJson(Yumeca_polJsonFile instance) =>
    <String, dynamic>{
      'normal': instance.normal.toJson(),
    };

_Normal _$NormalFromJson(Map<String, dynamic> json) => _Normal(
      url: json['url'] as String? ?? '0.0.0.0',
      url_auto_cancel: json['url_auto_cancel'] as String? ?? '0.0.0.0',
      timeout: json['timeout'] as int? ?? 5,
      client_signature: json['client_signature'] as int? ?? 0,
      debug_zan: json['debug_zan'] as int? ?? 1000,
      comp_no: json['comp_no'] as int? ?? 0,
    );

Map<String, dynamic> _$NormalToJson(_Normal instance) => <String, dynamic>{
      'url': instance.url,
      'url_auto_cancel': instance.url_auto_cancel,
      'timeout': instance.timeout,
      'client_signature': instance.client_signature,
      'debug_zan': instance.debug_zan,
      'comp_no': instance.comp_no,
    };
