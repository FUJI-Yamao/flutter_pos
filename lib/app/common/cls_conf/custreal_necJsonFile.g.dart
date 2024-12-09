// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custreal_necJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Custreal_necJsonFile _$Custreal_necJsonFileFromJson(
        Map<String, dynamic> json) =>
    Custreal_necJsonFile()
      ..nec = _Nec.fromJson(json['nec'] as Map<String, dynamic>)
      ..custrealsvr =
          _Custrealsvr.fromJson(json['custrealsvr'] as Map<String, dynamic>);

Map<String, dynamic> _$Custreal_necJsonFileToJson(
        Custreal_necJsonFile instance) =>
    <String, dynamic>{
      'nec': instance.nec.toJson(),
      'custrealsvr': instance.custrealsvr.toJson(),
    };

_Nec _$NecFromJson(Map<String, dynamic> json) => _Nec(
      compcd: json['compcd'] as int? ?? 1,
      tenantcd: json['tenantcd'] as int? ?? 1006001,
      url: json['url'] as String? ?? 'http:',
    );

Map<String, dynamic> _$NecToJson(_Nec instance) => <String, dynamic>{
      'compcd': instance.compcd,
      'tenantcd': instance.tenantcd,
      'url': instance.url,
    };

_Custrealsvr _$CustrealsvrFromJson(Map<String, dynamic> json) => _Custrealsvr(
      timeout: json['timeout'] as int? ?? 5,
      opentimeout: json['opentimeout'] as int? ?? 1,
      openretrycnt: json['openretrycnt'] as int? ?? 3,
      openretrywait: json['openretrywait'] as int? ?? 500,
      retrywaittime: json['retrywaittime'] as int? ?? 1,
      retrycnt: json['retrycnt'] as int? ?? 1,
    );

Map<String, dynamic> _$CustrealsvrToJson(_Custrealsvr instance) =>
    <String, dynamic>{
      'timeout': instance.timeout,
      'opentimeout': instance.opentimeout,
      'openretrycnt': instance.openretrycnt,
      'openretrywait': instance.openretrywait,
      'retrywaittime': instance.retrywaittime,
      'retrycnt': instance.retrycnt,
    };
