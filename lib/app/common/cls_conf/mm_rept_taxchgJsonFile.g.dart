// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mm_rept_taxchgJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mm_rept_taxchgJsonFile _$Mm_rept_taxchgJsonFileFromJson(
        Map<String, dynamic> json) =>
    Mm_rept_taxchgJsonFile()
      ..tax_chg = _Tax_chg.fromJson(json['tax_chg'] as Map<String, dynamic>)
      ..tax_chage_1 =
          _Tax_chage_1.fromJson(json['tax_chage_1'] as Map<String, dynamic>);

Map<String, dynamic> _$Mm_rept_taxchgJsonFileToJson(
        Mm_rept_taxchgJsonFile instance) =>
    <String, dynamic>{
      'tax_chg': instance.tax_chg.toJson(),
      'tax_chage_1': instance.tax_chage_1.toJson(),
    };

_Tax_chg _$Tax_chgFromJson(Map<String, dynamic> json) => _Tax_chg(
      date: json['date'] as String? ?? '2014-04-01',
    );

Map<String, dynamic> _$Tax_chgToJson(_Tax_chg instance) => <String, dynamic>{
      'date': instance.date,
    };

_Tax_chage_1 _$Tax_chage_1FromJson(Map<String, dynamic> json) => _Tax_chage_1(
      date: json['date'] as int? ?? 20191001,
    );

Map<String, dynamic> _$Tax_chage_1ToJson(_Tax_chage_1 instance) =>
    <String, dynamic>{
      'date': instance.date,
    };
