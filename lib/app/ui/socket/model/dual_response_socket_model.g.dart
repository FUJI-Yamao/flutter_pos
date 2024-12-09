// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dual_response_socket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DualResponseInfo _$DualResponseInfoFromJson(Map<String, dynamic> json) =>
    DualResponseInfo(
      result: json['Result'] as bool,
      isAuto: json['IsAuto'] as bool,
      error: json['Error'] as int,
    );

Map<String, dynamic> _$DualResponseInfoToJson(DualResponseInfo instance) =>
    <String, dynamic>{
      'Result': instance.result,
      'IsAuto': instance.isAuto,
      'Error': instance.error,
    };
