// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devreadJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevreadJsonFile _$DevreadJsonFileFromJson(Map<String, dynamic> json) =>
    DevreadJsonFile()
      ..device = _Device.fromJson(json['device'] as Map<String, dynamic>);

Map<String, dynamic> _$DevreadJsonFileToJson(DevreadJsonFile instance) =>
    <String, dynamic>{
      'device': instance.device.toJson(),
    };

_Device _$DeviceFromJson(Map<String, dynamic> json) => _Device(
      read_date: json['read_date'] as String? ?? '2017/08',
    );

Map<String, dynamic> _$DeviceToJson(_Device instance) => <String, dynamic>{
      'read_date': instance.read_date,
    };
