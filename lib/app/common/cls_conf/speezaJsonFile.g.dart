// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speezaJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeezaJsonFile _$SpeezaJsonFileFromJson(Map<String, dynamic> json) =>
    SpeezaJsonFile()
      ..QcSelect =
          _QQcSelect.fromJson(json['QcSelect'] as Map<String, dynamic>);

Map<String, dynamic> _$SpeezaJsonFileToJson(SpeezaJsonFile instance) =>
    <String, dynamic>{
      'QcSelect': instance.QcSelect.toJson(),
    };

_QQcSelect _$QQcSelectFromJson(Map<String, dynamic> json) => _QQcSelect(
      ConMacNo1: json['ConMacNo1'] as int? ?? 0,
      ConMacName1: json['ConMacName1'] as String? ?? '',
      ConMacNo2: json['ConMacNo2'] as int? ?? 0,
      ConMacName2: json['ConMacName2'] as String? ?? '',
      ConMacNo3: json['ConMacNo3'] as int? ?? 0,
      ConMacName3: json['ConMacName3'] as String? ?? '',
      ReceiptPrint: json['ReceiptPrint'] as int? ?? 0,
      ConPrint1: json['ConPrint1'] as int? ?? 0,
      ConPrint2: json['ConPrint2'] as int? ?? 0,
      ConPrint3: json['ConPrint3'] as int? ?? 0,
      ConColor1: json['ConColor1'] as int? ?? 204,
      ConColor2: json['ConColor2'] as int? ?? 207,
      ConColor3: json['ConColor3'] as int? ?? 209,
      ConPosi1: json['ConPosi1'] as int? ?? 2,
      ConPosi2: json['ConPosi2'] as int? ?? 1,
      ConPosi3: json['ConPosi3'] as int? ?? 0,
    );

Map<String, dynamic> _$QQcSelectToJson(_QQcSelect instance) =>
    <String, dynamic>{
      'ConMacNo1': instance.ConMacNo1,
      'ConMacName1': instance.ConMacName1,
      'ConMacNo2': instance.ConMacNo2,
      'ConMacName2': instance.ConMacName2,
      'ConMacNo3': instance.ConMacNo3,
      'ConMacName3': instance.ConMacName3,
      'ReceiptPrint': instance.ReceiptPrint,
      'ConPrint1': instance.ConPrint1,
      'ConPrint2': instance.ConPrint2,
      'ConPrint3': instance.ConPrint3,
      'ConColor1': instance.ConColor1,
      'ConColor2': instance.ConColor2,
      'ConColor3': instance.ConColor3,
      'ConPosi1': instance.ConPosi1,
      'ConPosi2': instance.ConPosi2,
      'ConPosi3': instance.ConPosi3,
    };
