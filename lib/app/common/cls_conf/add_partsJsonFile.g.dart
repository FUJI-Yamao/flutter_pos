// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_partsJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Add_partsJsonFile _$Add_partsJsonFileFromJson(Map<String, dynamic> json) =>
    Add_partsJsonFile()
      ..Guidance =
          _GGuidance.fromJson(json['Guidance'] as Map<String, dynamic>);

Map<String, dynamic> _$Add_partsJsonFileToJson(Add_partsJsonFile instance) =>
    <String, dynamic>{
      'Guidance': instance.Guidance.toJson(),
    };

_GGuidance _$GGuidanceFromJson(Map<String, dynamic> json) => _GGuidance(
      MsgBoxColor: json['MsgBoxColor'] as int? ?? 15,
      StatBoxColor: json['StatBoxColor'] as int? ?? 15,
      DispType: json['DispType'] as int? ?? 0,
    );

Map<String, dynamic> _$GGuidanceToJson(_GGuidance instance) =>
    <String, dynamic>{
      'MsgBoxColor': instance.MsgBoxColor,
      'StatBoxColor': instance.StatBoxColor,
      'DispType': instance.DispType,
    };
