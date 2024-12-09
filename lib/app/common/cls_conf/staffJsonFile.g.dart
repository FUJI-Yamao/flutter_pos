// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staffJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffJsonFile _$StaffJsonFileFromJson(Map<String, dynamic> json) =>
    StaffJsonFile()
      ..simple_2staff = _Simple_2staff.fromJson(
          json['simple_2staff'] as Map<String, dynamic>);

Map<String, dynamic> _$StaffJsonFileToJson(StaffJsonFile instance) =>
    <String, dynamic>{
      'simple_2staff': instance.simple_2staff.toJson(),
    };

_Simple_2staff _$Simple_2staffFromJson(Map<String, dynamic> json) =>
    _Simple_2staff(
      person: json['person'] as int? ?? 1,
    );

Map<String, dynamic> _$Simple_2staffToJson(_Simple_2staff instance) =>
    <String, dynamic>{
      'person': instance.person,
    };
