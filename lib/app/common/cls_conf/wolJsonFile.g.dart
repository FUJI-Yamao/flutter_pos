// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wolJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WolJsonFile _$WolJsonFileFromJson(Map<String, dynamic> json) => WolJsonFile()
  ..system = _System.fromJson(json['system'] as Map<String, dynamic>)
  ..mm_system = _Mm_system.fromJson(json['mm_system'] as Map<String, dynamic>);

Map<String, dynamic> _$WolJsonFileToJson(WolJsonFile instance) =>
    <String, dynamic>{
      'system': instance.system.toJson(),
      'mm_system': instance.mm_system.toJson(),
    };

_System _$SystemFromJson(Map<String, dynamic> json) => _System(
      wol_settime: json['wol_settime'] as String? ?? '0000',
      wol_time: json['wol_time'] as String? ?? '0000-00-00 00:00:00',
      reboot: json['reboot'] as int? ?? 0,
    );

Map<String, dynamic> _$SystemToJson(_System instance) => <String, dynamic>{
      'wol_settime': instance.wol_settime,
      'wol_time': instance.wol_time,
      'reboot': instance.reboot,
    };

_Mm_system _$Mm_systemFromJson(Map<String, dynamic> json) => _Mm_system(
      wolDelay: json['wolDelay'] as int? ?? 40,
    );

Map<String, dynamic> _$Mm_systemToJson(_Mm_system instance) =>
    <String, dynamic>{
      'wolDelay': instance.wolDelay,
    };
