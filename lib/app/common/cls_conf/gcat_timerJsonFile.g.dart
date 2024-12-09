// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gcat_timerJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gcat_timerJsonFile _$Gcat_timerJsonFileFromJson(Map<String, dynamic> json) =>
    Gcat_timerJsonFile()
      ..cat_timer =
          _Cat_timer.fromJson(json['cat_timer'] as Map<String, dynamic>)
      ..cct_timer =
          _Cct_timer.fromJson(json['cct_timer'] as Map<String, dynamic>)
      ..mst_timer =
          _Mst_timer.fromJson(json['mst_timer'] as Map<String, dynamic>);

Map<String, dynamic> _$Gcat_timerJsonFileToJson(Gcat_timerJsonFile instance) =>
    <String, dynamic>{
      'cat_timer': instance.cat_timer.toJson(),
      'cct_timer': instance.cct_timer.toJson(),
      'mst_timer': instance.mst_timer.toJson(),
    };

_Cat_timer _$Cat_timerFromJson(Map<String, dynamic> json) => _Cat_timer(
      cat_stat_timer: json['cat_stat_timer'] as int? ?? 600,
      cat_recv_timer: json['cat_recv_timer'] as int? ?? 3000,
    );

Map<String, dynamic> _$Cat_timerToJson(_Cat_timer instance) =>
    <String, dynamic>{
      'cat_stat_timer': instance.cat_stat_timer,
      'cat_recv_timer': instance.cat_recv_timer,
    };

_Cct_timer _$Cct_timerFromJson(Map<String, dynamic> json) => _Cct_timer(
      cct_rcv_timer: json['cct_rcv_timer'] as int? ?? 240000,
    );

Map<String, dynamic> _$Cct_timerToJson(_Cct_timer instance) =>
    <String, dynamic>{
      'cct_rcv_timer': instance.cct_rcv_timer,
    };

_Mst_timer _$Mst_timerFromJson(Map<String, dynamic> json) => _Mst_timer(
      mst_rcv_timer: json['mst_rcv_timer'] as int? ?? 180000,
    );

Map<String, dynamic> _$Mst_timerToJson(_Mst_timer instance) =>
    <String, dynamic>{
      'mst_rcv_timer': instance.mst_rcv_timer,
    };
