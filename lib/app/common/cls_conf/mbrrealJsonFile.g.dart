// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mbrrealJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MbrrealJsonFile _$MbrrealJsonFileFromJson(Map<String, dynamic> json) =>
    MbrrealJsonFile()..JA = _JJA.fromJson(json['JA'] as Map<String, dynamic>);

Map<String, dynamic> _$MbrrealJsonFileToJson(MbrrealJsonFile instance) =>
    <String, dynamic>{
      'JA': instance.JA.toJson(),
    };

_JJA _$JJAFromJson(Map<String, dynamic> json) => _JJA(
      KEN_CD: json['KEN_CD'] as int? ?? 11,
      JA_CD: json['JA_CD'] as int? ?? 4735,
      HND_BRCH_CD: json['HND_BRCH_CD'] as String? ?? '0000',
      KANGEN_KBN: json['KANGEN_KBN'] as int? ?? 5,
      KANGEN_CD: json['KANGEN_CD'] as String? ?? '001',
      DTL_CD: json['DTL_CD'] as String? ?? '00001',
      BUSINESS_CD: json['BUSINESS_CD'] as int? ?? 3,
      DEAL_CD: json['DEAL_CD'] as int? ?? 101,
      CND_CD: json['CND_CD'] as String? ?? '000001',
      POINT_PT_CD: json['POINT_PT_CD'] as int? ?? 2,
      USER_ID: json['USER_ID'] as String? ?? '',
      PASSWORD: json['PASSWORD'] as String? ?? '',
    );

Map<String, dynamic> _$JJAToJson(_JJA instance) => <String, dynamic>{
      'KEN_CD': instance.KEN_CD,
      'JA_CD': instance.JA_CD,
      'HND_BRCH_CD': instance.HND_BRCH_CD,
      'KANGEN_KBN': instance.KANGEN_KBN,
      'KANGEN_CD': instance.KANGEN_CD,
      'DTL_CD': instance.DTL_CD,
      'BUSINESS_CD': instance.BUSINESS_CD,
      'DEAL_CD': instance.DEAL_CD,
      'CND_CD': instance.CND_CD,
      'POINT_PT_CD': instance.POINT_PT_CD,
      'USER_ID': instance.USER_ID,
      'PASSWORD': instance.PASSWORD,
    };
