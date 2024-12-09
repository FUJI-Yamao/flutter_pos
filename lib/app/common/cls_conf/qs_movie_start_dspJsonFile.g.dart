// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qs_movie_start_dspJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Qs_movie_start_dspJsonFile _$Qs_movie_start_dspJsonFileFromJson(
        Map<String, dynamic> json) =>
    Qs_movie_start_dspJsonFile()
      ..common = _Common.fromJson(json['common'] as Map<String, dynamic>);

Map<String, dynamic> _$Qs_movie_start_dspJsonFileToJson(
        Qs_movie_start_dspJsonFile instance) =>
    <String, dynamic>{
      'common': instance.common.toJson(),
    };

_Common _$CommonFromJson(Map<String, dynamic> json) => _Common(
      brand_typ: json['brand_typ'] as int? ?? 0,
      logo_typ: json['logo_typ'] as int? ?? 0,
    );

Map<String, dynamic> _$CommonToJson(_Common instance) => <String, dynamic>{
      'brand_typ': instance.brand_typ,
      'logo_typ': instance.logo_typ,
    };
