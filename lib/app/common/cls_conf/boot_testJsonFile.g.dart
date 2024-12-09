// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boot_testJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Boot_testJsonFile _$Boot_testJsonFileFromJson(Map<String, dynamic> json) =>
    Boot_testJsonFile()
      ..boot_test =
          _Boot_test.fromJson(json['boot_test'] as Map<String, dynamic>);

Map<String, dynamic> _$Boot_testJsonFileToJson(Boot_testJsonFile instance) =>
    <String, dynamic>{
      'boot_test': instance.boot_test.toJson(),
    };

_Boot_test _$Boot_testFromJson(Map<String, dynamic> json) => _Boot_test(
      boot_test: json['boot_test'] as int? ?? 0,
      test_count_max: json['test_count_max'] as int? ?? 0,
      test_count: json['test_count'] as int? ?? 0,
      usb_mem_ng_count: json['usb_mem_ng_count'] as int? ?? 0,
      usb_con_ng_count: json['usb_con_ng_count'] as int? ?? 0,
    );

Map<String, dynamic> _$Boot_testToJson(_Boot_test instance) =>
    <String, dynamic>{
      'boot_test': instance.boot_test,
      'test_count_max': instance.test_count_max,
      'test_count': instance.test_count,
      'usb_mem_ng_count': instance.usb_mem_ng_count,
      'usb_con_ng_count': instance.usb_con_ng_count,
    };
