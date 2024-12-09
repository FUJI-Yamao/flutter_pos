// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lock_request_socket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LockRequestInfo _$LockRequestInfoFromJson(Map<String, dynamic> json) =>
    LockRequestInfo(
      lockStatus: json['LockStatus'] as bool,
    );

Map<String, dynamic> _$LockRequestInfoToJson(LockRequestInfo instance) =>
    <String, dynamic>{
      'LockStatus': instance.lockStatus,
    };
