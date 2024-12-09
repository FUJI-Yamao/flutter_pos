// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxfreeJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaxfreeJsonFile _$TaxfreeJsonFileFromJson(Map<String, dynamic> json) =>
    TaxfreeJsonFile()
      ..term_info =
          _Term_info.fromJson(json['term_info'] as Map<String, dynamic>)
      ..term_info_demo = _Term_info_demo.fromJson(
          json['term_info_demo'] as Map<String, dynamic>)
      ..url_info = _Url_info.fromJson(json['url_info'] as Map<String, dynamic>)
      ..data = _Data.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$TaxfreeJsonFileToJson(TaxfreeJsonFile instance) =>
    <String, dynamic>{
      'term_info': instance.term_info.toJson(),
      'term_info_demo': instance.term_info_demo.toJson(),
      'url_info': instance.url_info.toJson(),
      'data': instance.data.toJson(),
    };

_Term_info _$Term_infoFromJson(Map<String, dynamic> json) => _Term_info(
      corp_code: json['corp_code'] as int? ?? 1,
      shop_code: json['shop_code'] as int? ?? 1,
      licence_key: json['licence_key'] as String? ?? '',
      licence_get: json['licence_get'] as String? ?? '',
      master_get: json['master_get'] as String? ?? '',
      country_get: json['country_get'] as String? ?? '',
      term_code: json['term_code'] as String? ?? '',
    );

Map<String, dynamic> _$Term_infoToJson(_Term_info instance) =>
    <String, dynamic>{
      'corp_code': instance.corp_code,
      'shop_code': instance.shop_code,
      'licence_key': instance.licence_key,
      'licence_get': instance.licence_get,
      'master_get': instance.master_get,
      'country_get': instance.country_get,
      'term_code': instance.term_code,
    };

_Term_info_demo _$Term_info_demoFromJson(Map<String, dynamic> json) =>
    _Term_info_demo(
      corp_code: json['corp_code'] as int? ?? 855,
      shop_code: json['shop_code'] as int? ?? 1,
      licence_key: json['licence_key'] as String? ?? 'vd3href2dz4s',
      licence_get: json['licence_get'] as String? ?? '',
      term_code: json['term_code'] as String? ?? '',
    );

Map<String, dynamic> _$Term_info_demoToJson(_Term_info_demo instance) =>
    <String, dynamic>{
      'corp_code': instance.corp_code,
      'shop_code': instance.shop_code,
      'licence_key': instance.licence_key,
      'licence_get': instance.licence_get,
      'term_code': instance.term_code,
    };

_Url_info _$Url_infoFromJson(Map<String, dynamic> json) => _Url_info(
      server_typ: json['server_typ'] as int? ?? 0,
      url_business:
          json['url_business'] as String? ?? 'https://j-taxfree.com/ceapi/',
      url_demo:
          json['url_demo'] as String? ?? 'https://japantaxfree.com/ceapi/',
      timeout: json['timeout'] as int? ?? 10,
    );

Map<String, dynamic> _$Url_infoToJson(_Url_info instance) => <String, dynamic>{
      'server_typ': instance.server_typ,
      'url_business': instance.url_business,
      'url_demo': instance.url_demo,
      'timeout': instance.timeout,
    };

_Data _$DataFromJson(Map<String, dynamic> json) => _Data(
      keep_day: json['keep_day'] as int? ?? 7,
    );

Map<String, dynamic> _$DataToJson(_Data instance) => <String, dynamic>{
      'keep_day': instance.keep_day,
    };
