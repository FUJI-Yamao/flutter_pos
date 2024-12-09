// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fileinstallJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileinstallJsonFile _$FileinstallJsonFileFromJson(Map<String, dynamic> json) =>
    FileinstallJsonFile()
      ..info = _Info.fromJson(json['info'] as Map<String, dynamic>)
      ..file1 = _File1.fromJson(json['file1'] as Map<String, dynamic>)
      ..file2 = _File2.fromJson(json['file2'] as Map<String, dynamic>)
      ..file3 = _File3.fromJson(json['file3'] as Map<String, dynamic>);

Map<String, dynamic> _$FileinstallJsonFileToJson(
        FileinstallJsonFile instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'file1': instance.file1.toJson(),
      'file2': instance.file2.toJson(),
      'file3': instance.file3.toJson(),
    };

_Info _$InfoFromJson(Map<String, dynamic> json) => _Info(
      field_max: json['field_max'] as int? ?? 3,
    );

Map<String, dynamic> _$InfoToJson(_Info instance) => <String, dynamic>{
      'field_max': instance.field_max,
    };

_File1 _$File1FromJson(Map<String, dynamic> json) => _File1(
      name: json['name'] as String? ?? 'CANALPAY_LCL_RSA_PRIKEY.pem',
      place: json['place'] as String? ?? 'conf',
    );

Map<String, dynamic> _$File1ToJson(_File1 instance) => <String, dynamic>{
      'name': instance.name,
      'place': instance.place,
    };

_File2 _$File2FromJson(Map<String, dynamic> json) => _File2(
      name: json['name'] as String? ?? 'CANALPAY_LCL_RSA_PUBKEY.pem',
      place: json['place'] as String? ?? 'conf',
    );

Map<String, dynamic> _$File2ToJson(_File2 instance) => <String, dynamic>{
      'name': instance.name,
      'place': instance.place,
    };

_File3 _$File3FromJson(Map<String, dynamic> json) => _File3(
      name: json['name'] as String? ?? 'CANALPAY_SRV_RSA_PUBKEY.pem',
      place: json['place'] as String? ?? 'conf',
    );

Map<String, dynamic> _$File3ToJson(_File3 instance) => <String, dynamic>{
      'name': instance.name,
      'place': instance.place,
    };
