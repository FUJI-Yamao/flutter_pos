// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacuum_dateJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vacuum_dateJsonFile _$Vacuum_dateJsonFileFromJson(Map<String, dynamic> json) =>
    Vacuum_dateJsonFile()
      ..db = _Db.fromJson(json['db'] as Map<String, dynamic>);

Map<String, dynamic> _$Vacuum_dateJsonFileToJson(
        Vacuum_dateJsonFile instance) =>
    <String, dynamic>{
      'db': instance.db.toJson(),
    };

_Db _$DbFromJson(Map<String, dynamic> json) => _Db(
      vacuum_date: json['vacuum_date'] as String? ?? '2018/07/01',
    );

Map<String, dynamic> _$DbToJson(_Db instance) => <String, dynamic>{
      'vacuum_date': instance.vacuum_date,
    };
