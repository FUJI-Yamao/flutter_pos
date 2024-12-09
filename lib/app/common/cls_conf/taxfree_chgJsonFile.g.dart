// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxfree_chgJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Taxfree_chgJsonFile _$Taxfree_chgJsonFileFromJson(Map<String, dynamic> json) =>
    Taxfree_chgJsonFile()
      ..reform_date =
          _Reform_date.fromJson(json['reform_date'] as Map<String, dynamic>);

Map<String, dynamic> _$Taxfree_chgJsonFileToJson(
        Taxfree_chgJsonFile instance) =>
    <String, dynamic>{
      'reform_date': instance.reform_date.toJson(),
    };

_Reform_date _$Reform_dateFromJson(Map<String, dynamic> json) => _Reform_date(
      typ_reform_date: json['typ_reform_date'] as String? ?? '0000-00-00',
      resid_reform_date: json['resid_reform_date'] as String? ?? '0000-00-00',
    );

Map<String, dynamic> _$Reform_dateToJson(_Reform_date instance) =>
    <String, dynamic>{
      'typ_reform_date': instance.typ_reform_date,
      'resid_reform_date': instance.resid_reform_date,
    };
