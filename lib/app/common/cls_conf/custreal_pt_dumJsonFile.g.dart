// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custreal_pt_dumJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Custreal_pt_dumJsonFile _$Custreal_pt_dumJsonFileFromJson(
        Map<String, dynamic> json) =>
    Custreal_pt_dumJsonFile()
      ..pts = _Pts.fromJson(json['pts'] as Map<String, dynamic>)
      ..enq = _Enq.fromJson(json['enq'] as Map<String, dynamic>)
      ..exc = _Exc.fromJson(json['exc'] as Map<String, dynamic>)
      ..exc_vd = _Exc_vd.fromJson(json['exc_vd'] as Map<String, dynamic>)
      ..add = _Add.fromJson(json['add'] as Map<String, dynamic>)
      ..add_vd = _Add_vd.fromJson(json['add_vd'] as Map<String, dynamic>);

Map<String, dynamic> _$Custreal_pt_dumJsonFileToJson(
        Custreal_pt_dumJsonFile instance) =>
    <String, dynamic>{
      'pts': instance.pts.toJson(),
      'enq': instance.enq.toJson(),
      'exc': instance.exc.toJson(),
      'exc_vd': instance.exc_vd.toJson(),
      'add': instance.add.toJson(),
      'add_vd': instance.add_vd.toJson(),
    };

_Pts _$PtsFromJson(Map<String, dynamic> json) => _Pts(
      pts: json['pts'] as int? ?? 10000,
    );

Map<String, dynamic> _$PtsToJson(_Pts instance) => <String, dynamic>{
      'pts': instance.pts,
    };

_Enq _$EnqFromJson(Map<String, dynamic> json) => _Enq(
      rt: json['rt'] as String? ?? '0000',
      offl: json['offl'] as int? ?? 0,
    );

Map<String, dynamic> _$EnqToJson(_Enq instance) => <String, dynamic>{
      'rt': instance.rt,
      'offl': instance.offl,
    };

_Exc _$ExcFromJson(Map<String, dynamic> json) => _Exc(
      rt: json['rt'] as String? ?? '0000',
      offl: json['offl'] as int? ?? 0,
    );

Map<String, dynamic> _$ExcToJson(_Exc instance) => <String, dynamic>{
      'rt': instance.rt,
      'offl': instance.offl,
    };

_Exc_vd _$Exc_vdFromJson(Map<String, dynamic> json) => _Exc_vd(
      rt: json['rt'] as String? ?? '0000',
      offl: json['offl'] as int? ?? 0,
    );

Map<String, dynamic> _$Exc_vdToJson(_Exc_vd instance) => <String, dynamic>{
      'rt': instance.rt,
      'offl': instance.offl,
    };

_Add _$AddFromJson(Map<String, dynamic> json) => _Add(
      rt: json['rt'] as String? ?? '0000',
      offl: json['offl'] as int? ?? 0,
    );

Map<String, dynamic> _$AddToJson(_Add instance) => <String, dynamic>{
      'rt': instance.rt,
      'offl': instance.offl,
    };

_Add_vd _$Add_vdFromJson(Map<String, dynamic> json) => _Add_vd(
      rt: json['rt'] as String? ?? '0000',
      offl: json['offl'] as int? ?? 0,
    );

Map<String, dynamic> _$Add_vdToJson(_Add_vd instance) => <String, dynamic>{
      'rt': instance.rt,
      'offl': instance.offl,
    };
