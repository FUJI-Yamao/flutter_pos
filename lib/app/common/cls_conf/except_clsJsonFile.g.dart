// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'except_clsJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Except_clsJsonFile _$Except_clsJsonFileFromJson(Map<String, dynamic> json) =>
    Except_clsJsonFile()
      ..except_cls =
          _Except_cls.fromJson(json['except_cls'] as Map<String, dynamic>);

Map<String, dynamic> _$Except_clsJsonFileToJson(Except_clsJsonFile instance) =>
    <String, dynamic>{
      'except_cls': instance.except_cls.toJson(),
    };

_Except_cls _$Except_clsFromJson(Map<String, dynamic> json) => _Except_cls(
      lrgcls_cd: json['lrgcls_cd'] as String? ?? '',
      mdlcls_cd: json['mdlcls_cd'] as String? ?? '',
      smlcls_cd: json['smlcls_cd'] as String? ?? '',
    );

Map<String, dynamic> _$Except_clsToJson(_Except_cls instance) =>
    <String, dynamic>{
      'lrgcls_cd': instance.lrgcls_cd,
      'mdlcls_cd': instance.mdlcls_cd,
      'smlcls_cd': instance.smlcls_cd,
    };
