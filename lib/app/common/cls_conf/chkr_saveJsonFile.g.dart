// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chkr_saveJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chkr_saveJsonFile _$Chkr_saveJsonFileFromJson(Map<String, dynamic> json) =>
    Chkr_saveJsonFile()
      ..loan = _Loan.fromJson(json['loan'] as Map<String, dynamic>);

Map<String, dynamic> _$Chkr_saveJsonFileToJson(Chkr_saveJsonFile instance) =>
    <String, dynamic>{
      'loan': instance.loan.toJson(),
    };

_Loan _$LoanFromJson(Map<String, dynamic> json) => _Loan(
      inout_10000: json['inout_10000'] as int? ?? 0,
      inout_5000: json['inout_5000'] as int? ?? 0,
      inout_2000: json['inout_2000'] as int? ?? 0,
      inout_1000: json['inout_1000'] as int? ?? 0,
      inout_500: json['inout_500'] as int? ?? 0,
      inout_100: json['inout_100'] as int? ?? 0,
      inout_50: json['inout_50'] as int? ?? 0,
      inout_10: json['inout_10'] as int? ?? 0,
      inout_5: json['inout_5'] as int? ?? 0,
      inout_1: json['inout_1'] as int? ?? 0,
    );

Map<String, dynamic> _$LoanToJson(_Loan instance) => <String, dynamic>{
      'inout_10000': instance.inout_10000,
      'inout_5000': instance.inout_5000,
      'inout_2000': instance.inout_2000,
      'inout_1000': instance.inout_1000,
      'inout_500': instance.inout_500,
      'inout_100': instance.inout_100,
      'inout_50': instance.inout_50,
      'inout_10': instance.inout_10,
      'inout_5': instance.inout_5,
      'inout_1': instance.inout_1,
    };
