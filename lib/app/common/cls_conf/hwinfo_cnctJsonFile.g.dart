// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hwinfo_cnctJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hwinfo_cnctJsonFile _$Hwinfo_cnctJsonFileFromJson(Map<String, dynamic> json) =>
    Hwinfo_cnctJsonFile()
      ..comm = _Comm.fromJson(json['comm'] as Map<String, dynamic>);

Map<String, dynamic> _$Hwinfo_cnctJsonFileToJson(
        Hwinfo_cnctJsonFile instance) =>
    <String, dynamic>{
      'comm': instance.comm.toJson(),
    };

_Comm _$CommFromJson(Map<String, dynamic> json) => _Comm(
      head: json['head'] as String? ?? 'http://',
      host: json['host'] as String? ?? 'iot.975194.jp',
      url: json['url'] as String? ?? '/api/v1/info',
      time_out: json['time_out'] as int? ?? 180,
      portal_user: json['portal_user'] as String? ?? 'use-token-auth',
      portal_pass: json['portal_pass'] as String? ?? 'Teraoka0893',
      dns1: json['dns1'] as String? ?? '8.8.8.8',
      dns2: json['dns2'] as String? ?? '8.8.4.4',
      max_data_len: json['max_data_len'] as int? ?? 0,
    );

Map<String, dynamic> _$CommToJson(_Comm instance) => <String, dynamic>{
      'head': instance.head,
      'host': instance.host,
      'url': instance.url,
      'time_out': instance.time_out,
      'portal_user': instance.portal_user,
      'portal_pass': instance.portal_pass,
      'dns1': instance.dns1,
      'dns2': instance.dns2,
      'max_data_len': instance.max_data_len,
    };
