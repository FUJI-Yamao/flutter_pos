// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nttd_precaJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nttd_precaJsonFile _$Nttd_precaJsonFileFromJson(Map<String, dynamic> json) =>
    Nttd_precaJsonFile()
      ..arcs = _Arcs.fromJson(json['arcs'] as Map<String, dynamic>)
      ..normal = _Normal.fromJson(json['normal'] as Map<String, dynamic>);

Map<String, dynamic> _$Nttd_precaJsonFileToJson(Nttd_precaJsonFile instance) =>
    <String, dynamic>{
      'arcs': instance.arcs.toJson(),
      'normal': instance.normal.toJson(),
    };

_Arcs _$ArcsFromJson(Map<String, dynamic> json) => _Arcs(
      url: json['url'] as String? ?? '10.207.5.230:3100/gaihan/servlet/online?',
      schemeid: json['schemeid'] as int? ?? 70101,
      mbr_add_code: json['mbr_add_code'] as int? ?? 6101,
      debug_zan: json['debug_zan'] as int? ?? 10000,
    );

Map<String, dynamic> _$ArcsToJson(_Arcs instance) => <String, dynamic>{
      'url': instance.url,
      'schemeid': instance.schemeid,
      'mbr_add_code': instance.mbr_add_code,
      'debug_zan': instance.debug_zan,
    };

_Normal _$NormalFromJson(Map<String, dynamic> json) => _Normal(
      url: json['url'] as String? ?? ':3100/gaihan/servlet/online?',
      schemeid: json['schemeid'] as int? ?? 0,
      mbr_add_code: json['mbr_add_code'] as int? ?? 0,
      debug_zan: json['debug_zan'] as int? ?? 10000,
    );

Map<String, dynamic> _$NormalToJson(_Normal instance) => <String, dynamic>{
      'url': instance.url,
      'schemeid': instance.schemeid,
      'mbr_add_code': instance.mbr_add_code,
      'debug_zan': instance.debug_zan,
    };
