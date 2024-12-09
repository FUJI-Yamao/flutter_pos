// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_counterJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Update_counterJsonFile _$Update_counterJsonFileFromJson(
        Map<String, dynamic> json) =>
    Update_counterJsonFile()
      ..tran = _Tran.fromJson(json['tran'] as Map<String, dynamic>);

Map<String, dynamic> _$Update_counterJsonFileToJson(
        Update_counterJsonFile instance) =>
    <String, dynamic>{
      'tran': instance.tran.toJson(),
    };

_Tran _$TranFromJson(Map<String, dynamic> json) => _Tran(
      ttllog_all_cnt: json['ttllog_all_cnt'] as int? ?? 0,
    );

Map<String, dynamic> _$TranToJson(_Tran instance) => <String, dynamic>{
      'ttllog_all_cnt': instance.ttllog_all_cnt,
    };
