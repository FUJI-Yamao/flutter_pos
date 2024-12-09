// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'systemCheckJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemCheckJsonFile _$SystemCheckJsonFileFromJson(Map<String, dynamic> json) =>
    SystemCheckJsonFile()
      ..systemcheck =
          _Systemcheck.fromJson(json['systemcheck'] as Map<String, dynamic>);

Map<String, dynamic> _$SystemCheckJsonFileToJson(
        SystemCheckJsonFile instance) =>
    <String, dynamic>{
      'systemcheck': instance.systemcheck.toJson(),
    };

_Systemcheck _$SystemcheckFromJson(Map<String, dynamic> json) => _Systemcheck(
      check_sys: json['check_sys'] as String? ?? 'no',
      check_wait_time: json['check_wait_time'] as int? ?? 600,
      check_proc: json['check_proc'] as String? ?? 'yes',
      check_disk: json['check_disk'] as String? ?? 'yes',
      disk_thresh: json['disk_thresh'] as int? ?? 90,
      check_hdd: json['check_hdd'] as String? ?? 'yes',
      check_mb: json['check_mb'] as String? ?? 'yes',
      mail_to: json['mail_to'] as String? ?? 'remote_mail@digi.jp',
      mail_from: json['mail_from'] as String? ?? 'webseries_syschk@digi.jp',
    );

Map<String, dynamic> _$SystemcheckToJson(_Systemcheck instance) =>
    <String, dynamic>{
      'check_sys': instance.check_sys,
      'check_wait_time': instance.check_wait_time,
      'check_proc': instance.check_proc,
      'check_disk': instance.check_disk,
      'disk_thresh': instance.disk_thresh,
      'check_hdd': instance.check_hdd,
      'check_mb': instance.check_mb,
      'mail_to': instance.mail_to,
      'mail_from': instance.mail_from,
    };
