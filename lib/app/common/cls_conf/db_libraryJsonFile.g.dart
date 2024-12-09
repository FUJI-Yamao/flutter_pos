// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_libraryJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Db_libraryJsonFile _$Db_libraryJsonFileFromJson(Map<String, dynamic> json) =>
    Db_libraryJsonFile()
      ..windows = _Windows.fromJson(json['windows'] as Map<String, dynamic>)
      ..ubuntu = _Ubuntu.fromJson(json['ubuntu'] as Map<String, dynamic>)
      ..android = _Android.fromJson(json['android'] as Map<String, dynamic>);

Map<String, dynamic> _$Db_libraryJsonFileToJson(Db_libraryJsonFile instance) =>
    <String, dynamic>{
      'windows': instance.windows.toJson(),
      'ubuntu': instance.ubuntu.toJson(),
      'android': instance.android.toJson(),
    };

_Windows _$WindowsFromJson(Map<String, dynamic> json) => _Windows(
      isDbPathValid: json['isDbPathValid'] as String? ?? 'true',
      dbPath: json['dbPath'] as String? ?? 'C:\\pos',
      subDir: json['subDir'] as String? ?? 'data',
      dbName: json['dbName'] as String? ?? 'tpr.db',
      version: json['version'] as String? ?? '1',
    );

Map<String, dynamic> _$WindowsToJson(_Windows instance) => <String, dynamic>{
      'isDbPathValid': instance.isDbPathValid,
      'dbPath': instance.dbPath,
      'subDir': instance.subDir,
      'dbName': instance.dbName,
      'version': instance.version,
    };

_Ubuntu _$UbuntuFromJson(Map<String, dynamic> json) => _Ubuntu(
      isDbPathValid: json['isDbPathValid'] as String? ?? 'false',
      dbPath: json['dbPath'] as String? ?? '',
      subDir: json['subDir'] as String? ?? 'data',
      dbName: json['dbName'] as String? ?? 'tpr.db',
      version: json['version'] as String? ?? '1',
    );

Map<String, dynamic> _$UbuntuToJson(_Ubuntu instance) => <String, dynamic>{
      'isDbPathValid': instance.isDbPathValid,
      'dbPath': instance.dbPath,
      'subDir': instance.subDir,
      'dbName': instance.dbName,
      'version': instance.version,
    };

_Android _$AndroidFromJson(Map<String, dynamic> json) => _Android(
      isDbPathValid: json['isDbPathValid'] as String? ?? 'true',
      dbPath: json['dbPath'] as String? ??
          '/data/user/0/jp.co.fsi.flutter_pos/app_flutter',
      subDir: json['subDir'] as String? ?? 'data',
      dbName: json['dbName'] as String? ?? 'tpr.db',
      version: json['version'] as String? ?? '1',
    );

Map<String, dynamic> _$AndroidToJson(_Android instance) => <String, dynamic>{
      'isDbPathValid': instance.isDbPathValid,
      'dbPath': instance.dbPath,
      'subDir': instance.subDir,
      'dbName': instance.dbName,
      'version': instance.version,
    };
