// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tpointJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TpointJsonFile _$TpointJsonFileFromJson(Map<String, dynamic> json) =>
    TpointJsonFile()
      ..comm = _Comm.fromJson(json['comm'] as Map<String, dynamic>);

Map<String, dynamic> _$TpointJsonFileToJson(TpointJsonFile instance) =>
    <String, dynamic>{
      'comm': instance.comm.toJson(),
    };

_Comm _$CommFromJson(Map<String, dynamic> json) => _Comm(
      passwd: json['passwd'] as String? ?? 'pass',
      timeout: json['timeout'] as int? ?? 3,
      retrycnt: json['retrycnt'] as int? ?? 0,
    );

Map<String, dynamic> _$CommToJson(_Comm instance) => <String, dynamic>{
      'passwd': instance.passwd,
      'timeout': instance.timeout,
      'retrycnt': instance.retrycnt,
    };
