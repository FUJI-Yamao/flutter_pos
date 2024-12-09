// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bm_missmachJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bm_missmachJsonFile _$Bm_missmachJsonFileFromJson(Map<String, dynamic> json) =>
    Bm_missmachJsonFile()
      ..comp = _Comp.fromJson(json['comp'] as Map<String, dynamic>)
      ..cd_backup =
          _Cd_backup.fromJson(json['cd_backup'] as Map<String, dynamic>);

Map<String, dynamic> _$Bm_missmachJsonFileToJson(
        Bm_missmachJsonFile instance) =>
    <String, dynamic>{
      'comp': instance.comp.toJson(),
      'cd_backup': instance.cd_backup.toJson(),
    };

_Comp _$CompFromJson(Map<String, dynamic> json) => _Comp(
      rec_comp: json['rec_comp'] as String? ?? 'ok',
    );

Map<String, dynamic> _$CompToJson(_Comp instance) => <String, dynamic>{
      'rec_comp': instance.rec_comp,
    };

_Cd_backup _$Cd_backupFromJson(Map<String, dynamic> json) => _Cd_backup(
      ej_backup: json['ej_backup'] as String? ?? '0000-00-00',
    );

Map<String, dynamic> _$Cd_backupToJson(_Cd_backup instance) =>
    <String, dynamic>{
      'ej_backup': instance.ej_backup,
    };
