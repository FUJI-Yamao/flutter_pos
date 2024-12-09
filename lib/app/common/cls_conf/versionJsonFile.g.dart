// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'versionJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionJsonFile _$VersionJsonFileFromJson(Map<String, dynamic> json) =>
    VersionJsonFile()
      ..version = _Version.fromJson(json['version'] as Map<String, dynamic>)
      ..apl = _Apl.fromJson(json['apl'] as Map<String, dynamic>)
      ..base_db = _Base_db.fromJson(json['base_db'] as Map<String, dynamic>)
      ..FSI_apl = _FFSI_apl.fromJson(json['FSI_apl'] as Map<String, dynamic>)
      ..IC_Card = _IIC_Card.fromJson(json['IC_Card'] as Map<String, dynamic>)
      ..self_data =
          _Self_data.fromJson(json['self_data'] as Map<String, dynamic>)
      ..IC_Card_Multi = _IIC_Card_Multi.fromJson(
          json['IC_Card_Multi'] as Map<String, dynamic>);

Map<String, dynamic> _$VersionJsonFileToJson(VersionJsonFile instance) =>
    <String, dynamic>{
      'version': instance.version.toJson(),
      'apl': instance.apl.toJson(),
      'base_db': instance.base_db.toJson(),
      'FSI_apl': instance.FSI_apl.toJson(),
      'IC_Card': instance.IC_Card.toJson(),
      'self_data': instance.self_data.toJson(),
      'IC_Card_Multi': instance.IC_Card_Multi.toJson(),
    };

_Version _$VersionFromJson(Map<String, dynamic> json) => _Version(
      max: json['max'] as int? ?? 4,
      section01: json['section01'] as String? ?? 'apl',
      section02: json['section02'] as String? ?? 'base_db',
      section03: json['section03'] as String? ?? 'IC_Card',
      section04: json['section04'] as String? ?? 'IC_Card_Multi',
    );

Map<String, dynamic> _$VersionToJson(_Version instance) => <String, dynamic>{
      'max': instance.max,
      'section01': instance.section01,
      'section02': instance.section02,
      'section03': instance.section03,
      'section04': instance.section04,
    };

_Apl _$AplFromJson(Map<String, dynamic> json) => _Apl(
      ver: json['ver'] as String? ?? '',
    );

Map<String, dynamic> _$AplToJson(_Apl instance) => <String, dynamic>{
      'ver': instance.ver,
    };

_Base_db _$Base_dbFromJson(Map<String, dynamic> json) => _Base_db(
      ver: json['ver'] as String? ?? '',
    );

Map<String, dynamic> _$Base_dbToJson(_Base_db instance) => <String, dynamic>{
      'ver': instance.ver,
    };

_FFSI_apl _$FFSI_aplFromJson(Map<String, dynamic> json) => _FFSI_apl(
      ver: json['ver'] as String? ?? 'v3.21 2004/04/28 20:00',
    );

Map<String, dynamic> _$FFSI_aplToJson(_FFSI_apl instance) => <String, dynamic>{
      'ver': instance.ver,
    };

_IIC_Card _$IIC_CardFromJson(Map<String, dynamic> json) => _IIC_Card(
      ver: json['ver'] as String? ?? 'v2.17',
    );

Map<String, dynamic> _$IIC_CardToJson(_IIC_Card instance) => <String, dynamic>{
      'ver': instance.ver,
    };

_Self_data _$Self_dataFromJson(Map<String, dynamic> json) => _Self_data(
      ver: json['ver'] as String? ?? 'v2.44',
    );

Map<String, dynamic> _$Self_dataToJson(_Self_data instance) =>
    <String, dynamic>{
      'ver': instance.ver,
    };

_IIC_Card_Multi _$IIC_Card_MultiFromJson(Map<String, dynamic> json) =>
    _IIC_Card_Multi(
      ver: json['ver'] as String? ?? 'vX.XX',
    );

Map<String, dynamic> _$IIC_Card_MultiToJson(_IIC_Card_Multi instance) =>
    <String, dynamic>{
      'ver': instance.ver,
    };
