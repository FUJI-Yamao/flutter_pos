// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batteryJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatteryJsonFile _$BatteryJsonFileFromJson(Map<String, dynamic> json) =>
    BatteryJsonFile()
      ..battery = _Battery.fromJson(json['battery'] as Map<String, dynamic>);

Map<String, dynamic> _$BatteryJsonFileToJson(BatteryJsonFile instance) =>
    <String, dynamic>{
      'battery': instance.battery.toJson(),
    };

_Battery _$BatteryFromJson(Map<String, dynamic> json) => _Battery(
      warning_date: json['warning_date'] as String? ?? '0000-00-00',
    );

Map<String, dynamic> _$BatteryToJson(_Battery instance) => <String, dynamic>{
      'warning_date': instance.warning_date,
    };
