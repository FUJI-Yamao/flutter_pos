// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rsv_custrealJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rsv_custrealJsonFile _$Rsv_custrealJsonFileFromJson(
        Map<String, dynamic> json) =>
    Rsv_custrealJsonFile()
      ..custreal = _Custreal.fromJson(json['custreal'] as Map<String, dynamic>);

Map<String, dynamic> _$Rsv_custrealJsonFileToJson(
        Rsv_custrealJsonFile instance) =>
    <String, dynamic>{
      'custreal': instance.custreal.toJson(),
    };

_Custreal _$CustrealFromJson(Map<String, dynamic> json) => _Custreal(
      user: json['user'] as int? ?? 2,
      exec_flg: json['exec_flg'] as int? ?? 0,
      exec_date: json['exec_date'] as String? ?? '0000-00-00',
      custrealsvr_cnct: json['custrealsvr_cnct'] as int? ?? 1,
    );

Map<String, dynamic> _$CustrealToJson(_Custreal instance) => <String, dynamic>{
      'user': instance.user,
      'exec_flg': instance.exec_flg,
      'exec_date': instance.exec_date,
      'custrealsvr_cnct': instance.custrealsvr_cnct,
    };
