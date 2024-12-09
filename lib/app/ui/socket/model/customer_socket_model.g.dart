// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_socket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoStaffInfo _$AutoStaffInfoFromJson(Map<String, dynamic> json) =>
    AutoStaffInfo(
      compCd: json['CompCd'] as int,
      streCd: json['StreCd'] as int,
      macNo: json['MacNo'] as int,
      staffCd: json['StaffCd'] as String,
    );

Map<String, dynamic> _$AutoStaffInfoToJson(AutoStaffInfo instance) =>
    <String, dynamic>{
      'CompCd': instance.compCd,
      'StreCd': instance.streCd,
      'MacNo': instance.macNo,
      'StaffCd': instance.staffCd,
    };
