// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_libraryJsonFile_ps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Db_libraryJsonFile_Ps _$Db_libraryJsonFile_PsFromJson(
        Map<String, dynamic> json) =>
    Db_libraryJsonFile_Ps()
      ..localdb = _Localdb.fromJson(json['localdb'] as Map<String, dynamic>)
      ..externaldb =
          _Externaldb.fromJson(json['externaldb'] as Map<String, dynamic>);

Map<String, dynamic> _$Db_libraryJsonFile_PsToJson(
        Db_libraryJsonFile_Ps instance) =>
    <String, dynamic>{
      'localdb': instance.localdb.toJson(),
      'externaldb': instance.externaldb.toJson(),
    };

_Localdb _$LocaldbFromJson(Map<String, dynamic> json) => _Localdb(
      dbName: json['dbName'] as String? ?? 'tpr.db',
      host: json['host'] as String? ?? 'localhost',
      port: json['port'] as String? ?? '5432',
      username: json['username'] as String? ?? 'postgres',
      password: json['password'] as String? ?? 'postgres',
      connectionTimeout: json['connectionTimeout'] as String? ?? '7',
    );

Map<String, dynamic> _$LocaldbToJson(_Localdb instance) => <String, dynamic>{
      'dbName': instance.dbName,
      'host': instance.host,
      'port': instance.port,
      'username': instance.username,
      'password': instance.password,
      'connectionTimeout': instance.connectionTimeout,
    };

_Externaldb _$ExternaldbFromJson(Map<String, dynamic> json) => _Externaldb(
      dbName: json['dbName'] as String? ?? 'tpr.db',
      host: json['host'] as String? ?? '',
      port: json['port'] as String? ?? '5432',
      username: json['username'] as String? ?? 'postgres',
      password: json['password'] as String? ?? 'postgres',
      connectionTimeout: json['connectionTimeout'] as String? ?? '7',
    );

Map<String, dynamic> _$ExternaldbToJson(_Externaldb instance) =>
    <String, dynamic>{
      'dbName': instance.dbName,
      'host': instance.host,
      'port': instance.port,
      'username': instance.username,
      'password': instance.password,
      'connectionTimeout': instance.connectionTimeout,
    };
