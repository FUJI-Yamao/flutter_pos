// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_ctrlJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Version_ctrlJsonFile _$Version_ctrlJsonFileFromJson(
        Map<String, dynamic> json) =>
    Version_ctrlJsonFile()
      ..apl_ver = _Apl_ver.fromJson(json['apl_ver'] as Map<String, dynamic>)
      ..sub_ver = _Sub_ver.fromJson(json['sub_ver'] as Map<String, dynamic>);

Map<String, dynamic> _$Version_ctrlJsonFileToJson(
        Version_ctrlJsonFile instance) =>
    <String, dynamic>{
      'apl_ver': instance.apl_ver.toJson(),
      'sub_ver': instance.sub_ver.toJson(),
    };

_Apl_ver _$Apl_verFromJson(Map<String, dynamic> json) => _Apl_ver(
      max: json['max'] as int? ?? 1,
      ver1: json['ver1'] as String? ?? 'AA1',
    );

Map<String, dynamic> _$Apl_verToJson(_Apl_ver instance) => <String, dynamic>{
      'max': instance.max,
      'ver1': instance.ver1,
    };

_Sub_ver _$Sub_verFromJson(Map<String, dynamic> json) => _Sub_ver(
      max: json['max'] as int? ?? 1,
      ver1: json['ver1'] as String? ?? 'vAA1-1',
    );

Map<String, dynamic> _$Sub_verToJson(_Sub_ver instance) => <String, dynamic>{
      'max': instance.max,
      'ver1': instance.ver1,
    };
