// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repicaJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepicaJsonFile _$RepicaJsonFileFromJson(Map<String, dynamic> json) =>
    RepicaJsonFile()
      ..normal = _Normal.fromJson(json['normal'] as Map<String, dynamic>)
      ..cocona = _Cocona.fromJson(json['cocona'] as Map<String, dynamic>);

Map<String, dynamic> _$RepicaJsonFileToJson(RepicaJsonFile instance) =>
    <String, dynamic>{
      'normal': instance.normal.toJson(),
      'cocona': instance.cocona.toJson(),
    };

_Normal _$NormalFromJson(Map<String, dynamic> json) => _Normal(
      url: json['url'] as String? ?? 'https://',
      url_auto_cancel: json['url_auto_cancel'] as String? ?? 'https://',
      timeout: json['timeout'] as int? ?? 5,
      client_signature: json['client_signature'] as int? ?? 0,
      debug_zan: json['debug_zan'] as int? ?? 1000,
      validFlg: json['validFlg'] as int? ?? 0,
      debug_pntzan: json['debug_pntzan'] as int? ?? 1000,
    );

Map<String, dynamic> _$NormalToJson(_Normal instance) => <String, dynamic>{
      'url': instance.url,
      'url_auto_cancel': instance.url_auto_cancel,
      'timeout': instance.timeout,
      'client_signature': instance.client_signature,
      'debug_zan': instance.debug_zan,
      'validFlg': instance.validFlg,
      'debug_pntzan': instance.debug_pntzan,
    };

_Cocona _$CoconaFromJson(Map<String, dynamic> json) => _Cocona(
      url: json['url'] as String? ??
          'https://zz3401gzacts.pos.ppsys.jp/posv2.php?com_key=ZZ3401GZACTS',
      url_auto_cancel: json['url_auto_cancel'] as String? ??
          'https://zz3401gzacts.pos.ppsys.jp/posv2extend.php?actionName=TransactionConfirm&com_key=ZZ3401GZACTS',
      client_signature: json['client_signature'] as int? ?? 0,
      debug_zan: json['debug_zan'] as int? ?? 1000,
      validFlg_cocona: json['validFlg_cocona'] as int? ?? 0,
    );

Map<String, dynamic> _$CoconaToJson(_Cocona instance) => <String, dynamic>{
      'url': instance.url,
      'url_auto_cancel': instance.url_auto_cancel,
      'client_signature': instance.client_signature,
      'debug_zan': instance.debug_zan,
      'validFlg_cocona': instance.validFlg_cocona,
    };
