// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'f_self_contentJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

F_self_contentJsonFile _$F_self_contentJsonFileFromJson(
        Map<String, dynamic> json) =>
    F_self_contentJsonFile()
      ..content_dir =
          _Content_dir.fromJson(json['content_dir'] as Map<String, dynamic>)
      ..content_file =
          _Content_file.fromJson(json['content_file'] as Map<String, dynamic>)
      ..content_time =
          _Content_time.fromJson(json['content_time'] as Map<String, dynamic>);

Map<String, dynamic> _$F_self_contentJsonFileToJson(
        F_self_contentJsonFile instance) =>
    <String, dynamic>{
      'content_dir': instance.content_dir.toJson(),
      'content_file': instance.content_file.toJson(),
      'content_time': instance.content_time.toJson(),
    };

_Content_dir _$Content_dirFromJson(Map<String, dynamic> json) => _Content_dir(
      dir: json['dir'] as String? ?? 'conf/image/movie',
    );

Map<String, dynamic> _$Content_dirToJson(_Content_dir instance) =>
    <String, dynamic>{
      'dir': instance.dir,
    };

_Content_file _$Content_fileFromJson(Map<String, dynamic> json) =>
    _Content_file(
      content_1_name: json['content_1_name'] as String? ?? '',
      content_2_name: json['content_2_name'] as String? ?? '',
      content_3_name: json['content_3_name'] as String? ?? '',
      content_4_name: json['content_4_name'] as String? ?? '',
      content_5_name: json['content_5_name'] as String? ?? '',
      content_6_name: json['content_6_name'] as String? ?? '',
      content_7_name: json['content_7_name'] as String? ?? '',
      content_8_name: json['content_8_name'] as String? ?? '',
    );

Map<String, dynamic> _$Content_fileToJson(_Content_file instance) =>
    <String, dynamic>{
      'content_1_name': instance.content_1_name,
      'content_2_name': instance.content_2_name,
      'content_3_name': instance.content_3_name,
      'content_4_name': instance.content_4_name,
      'content_5_name': instance.content_5_name,
      'content_6_name': instance.content_6_name,
      'content_7_name': instance.content_7_name,
      'content_8_name': instance.content_8_name,
    };

_Content_time _$Content_timeFromJson(Map<String, dynamic> json) =>
    _Content_time(
      content_1_time: json['content_1_time'] as String? ?? '',
      content_2_time: json['content_2_time'] as String? ?? '',
      content_3_time: json['content_3_time'] as String? ?? '',
      content_4_time: json['content_4_time'] as String? ?? '',
      content_5_time: json['content_5_time'] as String? ?? '',
      content_6_time: json['content_6_time'] as String? ?? '',
      content_7_time: json['content_7_time'] as String? ?? '',
      content_8_time: json['content_8_time'] as String? ?? '',
    );

Map<String, dynamic> _$Content_timeToJson(_Content_time instance) =>
    <String, dynamic>{
      'content_1_time': instance.content_1_time,
      'content_2_time': instance.content_2_time,
      'content_3_time': instance.content_3_time,
      'content_4_time': instance.content_4_time,
      'content_5_time': instance.content_5_time,
      'content_6_time': instance.content_6_time,
      'content_7_time': instance.content_7_time,
      'content_8_time': instance.content_8_time,
    };
