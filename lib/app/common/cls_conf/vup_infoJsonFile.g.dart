// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vup_infoJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vup_infoJsonFile _$Vup_infoJsonFileFromJson(Map<String, dynamic> json) =>
    Vup_infoJsonFile()
      ..vup_info = _Vup_info.fromJson(json['vup_info'] as Map<String, dynamic>);

Map<String, dynamic> _$Vup_infoJsonFileToJson(Vup_infoJsonFile instance) =>
    <String, dynamic>{
      'vup_info': instance.vup_info.toJson(),
    };

_Vup_info _$Vup_infoFromJson(Map<String, dynamic> json) => _Vup_info(
      vup_exe: json['vup_exe'] as int? ?? 0,
      reboot: json['reboot'] as int? ?? 0,
    );

Map<String, dynamic> _$Vup_infoToJson(_Vup_info instance) => <String, dynamic>{
      'vup_exe': instance.vup_exe,
      'reboot': instance.reboot,
    };
