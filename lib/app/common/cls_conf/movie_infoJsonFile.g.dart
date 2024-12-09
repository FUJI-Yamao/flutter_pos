// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_infoJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie_infoJsonFile _$Movie_infoJsonFileFromJson(Map<String, dynamic> json) =>
    Movie_infoJsonFile()
      ..common = _Common.fromJson(json['common'] as Map<String, dynamic>);

Map<String, dynamic> _$Movie_infoJsonFileToJson(Movie_infoJsonFile instance) =>
    <String, dynamic>{
      'common': instance.common.toJson(),
    };

_Common _$CommonFromJson(Map<String, dynamic> json) => _Common(
      position_x: json['position_x'] as int? ?? 27,
      position_y: json['position_y'] as int? ?? 113,
      width_size: json['width_size'] as int? ?? 576,
      height_size: json['height_size'] as int? ?? 432,
      restart_info: json['restart_info'] as int? ?? 0,
      explain_info: json['explain_info'] as int? ?? 0,
      update_info: json['update_info'] as int? ?? 0,
    );

Map<String, dynamic> _$CommonToJson(_Common instance) => <String, dynamic>{
      'position_x': instance.position_x,
      'position_y': instance.position_y,
      'width_size': instance.width_size,
      'height_size': instance.height_size,
      'restart_info': instance.restart_info,
      'explain_info': instance.explain_info,
      'update_info': instance.update_info,
    };
