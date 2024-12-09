// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tprtim_counterJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tprtim_counterJsonFile _$Tprtim_counterJsonFileFromJson(
        Map<String, dynamic> json) =>
    Tprtim_counterJsonFile()
      ..tran = _Tran.fromJson(json['tran'] as Map<String, dynamic>);

Map<String, dynamic> _$Tprtim_counterJsonFileToJson(
        Tprtim_counterJsonFile instance) =>
    <String, dynamic>{
      'tran': instance.tran.toJson(),
    };

_Tran _$TranFromJson(Map<String, dynamic> json) => _Tran(
      nearend_base: json['nearend_base'] as int? ?? 0,
      nearend_curr: json['nearend_curr'] as int? ?? 0,
      nearend_check_fail: json['nearend_check_fail'] as int? ?? 0,
    );

Map<String, dynamic> _$TranToJson(_Tran instance) => <String, dynamic>{
      'nearend_base': instance.nearend_base,
      'nearend_curr': instance.nearend_curr,
      'nearend_check_fail': instance.nearend_check_fail,
    };
