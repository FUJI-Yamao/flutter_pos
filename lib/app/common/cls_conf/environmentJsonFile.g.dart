// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environmentJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnvironmentJsonFile _$EnvironmentJsonFileFromJson(Map<String, dynamic> json) =>
    EnvironmentJsonFile()
      ..environment =
          _Environment.fromJson(json['environment'] as Map<String, dynamic>);

Map<String, dynamic> _$EnvironmentJsonFileToJson(
        EnvironmentJsonFile instance) =>
    <String, dynamic>{
      'environment': instance.environment.toJson(),
    };

_Environment _$EnvironmentFromJson(Map<String, dynamic> json) => _Environment(
      HOME: json['HOME'] as String? ?? '/pj/tprx',
      PATH: json['PATH'] as String? ?? '',
      SHELL: json['SHELL'] as String? ?? '/bin/bash',
      BASE_ENV: json['BASE_ENV'] as String? ?? '',
      LC_ALL: json['LC_ALL'] as String? ?? '',
      LANG: json['LANG'] as String? ?? '',
      LINGUAS: json['LINGUAS'] as String? ?? '',
      TPRX_HOME: json['TPRX_HOME'] as String? ?? '/pj/tprx/',
      DISPLAY: json['DISPLAY'] as String? ?? '',
      WINDOW: json['WINDOW'] as String? ?? '',
      CONTENT_LENGTH: json['CONTENT_LENGTH'] as String? ?? '',
      PGPASSWORD: json['PGPASSWORD'] as String? ?? '',
      PGUSER: json['PGUSER'] as String? ?? '',
      PGDATA: json['PGDATA'] as String? ?? '/usr/local/pgsql/data',
      PGDATABASE: json['PGDATABASE'] as String? ?? '',
      PGHOST: json['PGHOST'] as String? ?? '',
      PGOPTIONS: json['PGOPTIONS'] as String? ?? '',
      PGPORT: json['PGPORT'] as String? ?? '',
      PGTTY: json['PGTTY'] as String? ?? '',
      PGCLIENTENCODING: json['PGCLIENTENCODING'] as String? ?? '',
      SMX_HOME: json['SMX_HOME'] as String? ?? '',
      TUO_SEND_ENV: json['TUO_SEND_ENV'] as String? ?? '',
    );

Map<String, dynamic> _$EnvironmentToJson(_Environment instance) =>
    <String, dynamic>{
      'HOME': instance.HOME,
      'PATH': instance.PATH,
      'SHELL': instance.SHELL,
      'BASE_ENV': instance.BASE_ENV,
      'LC_ALL': instance.LC_ALL,
      'LANG': instance.LANG,
      'LINGUAS': instance.LINGUAS,
      'TPRX_HOME': instance.TPRX_HOME,
      'DISPLAY': instance.DISPLAY,
      'WINDOW': instance.WINDOW,
      'CONTENT_LENGTH': instance.CONTENT_LENGTH,
      'PGPASSWORD': instance.PGPASSWORD,
      'PGUSER': instance.PGUSER,
      'PGDATA': instance.PGDATA,
      'PGDATABASE': instance.PGDATABASE,
      'PGHOST': instance.PGHOST,
      'PGOPTIONS': instance.PGOPTIONS,
      'PGPORT': instance.PGPORT,
      'PGTTY': instance.PGTTY,
      'PGCLIENTENCODING': instance.PGCLIENTENCODING,
      'SMX_HOME': instance.SMX_HOME,
      'TUO_SEND_ENV': instance.TUO_SEND_ENV,
    };
