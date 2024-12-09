// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mupdate_counterJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mupdate_counterJsonFile _$Mupdate_counterJsonFileFromJson(
        Map<String, dynamic> json) =>
    Mupdate_counterJsonFile()
      ..tran = _Tran.fromJson(json['tran'] as Map<String, dynamic>);

Map<String, dynamic> _$Mupdate_counterJsonFileToJson(
        Mupdate_counterJsonFile instance) =>
    <String, dynamic>{
      'tran': instance.tran.toJson(),
    };

_Tran _$TranFromJson(Map<String, dynamic> json) => _Tran(
      ttllog_all_cnt: json['ttllog_all_cnt'] as int? ?? 0,
      ttllog_m_cnt: json['ttllog_m_cnt'] as int? ?? 0,
    );

Map<String, dynamic> _$TranToJson(_Tran instance) => <String, dynamic>{
      'ttllog_all_cnt': instance.ttllog_all_cnt,
      'ttllog_m_cnt': instance.ttllog_m_cnt,
    };
