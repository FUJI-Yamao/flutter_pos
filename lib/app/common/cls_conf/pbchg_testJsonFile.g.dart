// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pbchg_testJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pbchg_testJsonFile _$Pbchg_testJsonFileFromJson(Map<String, dynamic> json) =>
    Pbchg_testJsonFile()
      ..system = _System.fromJson(json['system'] as Map<String, dynamic>)
      ..balance = _Balance.fromJson(json['balance'] as Map<String, dynamic>)
      ..stre = _Stre.fromJson(json['stre'] as Map<String, dynamic>)
      ..corp = _Corp.fromJson(json['corp'] as Map<String, dynamic>)
      ..corp_result =
          _Corp_result.fromJson(json['corp_result'] as Map<String, dynamic>)
      ..ntte = _Ntte.fromJson(json['ntte'] as Map<String, dynamic>)
      ..receipt = _Receipt.fromJson(json['receipt'] as Map<String, dynamic>)
      ..matching = _Matching.fromJson(json['matching'] as Map<String, dynamic>)
      ..check = _Check.fromJson(json['check'] as Map<String, dynamic>);

Map<String, dynamic> _$Pbchg_testJsonFileToJson(Pbchg_testJsonFile instance) =>
    <String, dynamic>{
      'system': instance.system.toJson(),
      'balance': instance.balance.toJson(),
      'stre': instance.stre.toJson(),
      'corp': instance.corp.toJson(),
      'corp_result': instance.corp_result.toJson(),
      'ntte': instance.ntte.toJson(),
      'receipt': instance.receipt.toJson(),
      'matching': instance.matching.toJson(),
      'check': instance.check.toJson(),
    };

_System _$SystemFromJson(Map<String, dynamic> json) => _System(
      test: json['test'] as int? ?? 0,
    );

Map<String, dynamic> _$SystemToJson(_System instance) => <String, dynamic>{
      'test': instance.test,
    };

_Balance _$BalanceFromJson(Map<String, dynamic> json) => _Balance(
      amount: json['amount'] as int? ?? 500000,
      result: json['result'] as int? ?? 1,
    );

Map<String, dynamic> _$BalanceToJson(_Balance instance) => <String, dynamic>{
      'amount': instance.amount,
      'result': instance.result,
    };

_Stre _$StreFromJson(Map<String, dynamic> json) => _Stre(
      result: json['result'] as int? ?? 1,
    );

Map<String, dynamic> _$StreToJson(_Stre instance) => <String, dynamic>{
      'result': instance.result,
    };

_Corp _$CorpFromJson(Map<String, dynamic> json) => _Corp(
      result: json['result'] as int? ?? 1,
    );

Map<String, dynamic> _$CorpToJson(_Corp instance) => <String, dynamic>{
      'result': instance.result,
    };

_Corp_result _$Corp_resultFromJson(Map<String, dynamic> json) => _Corp_result(
      result: json['result'] as int? ?? 1,
    );

Map<String, dynamic> _$Corp_resultToJson(_Corp_result instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

_Ntte _$NtteFromJson(Map<String, dynamic> json) => _Ntte(
      result: json['result'] as int? ?? 1,
    );

Map<String, dynamic> _$NtteToJson(_Ntte instance) => <String, dynamic>{
      'result': instance.result,
    };

_Receipt _$ReceiptFromJson(Map<String, dynamic> json) => _Receipt(
      result: json['result'] as int? ?? 1,
    );

Map<String, dynamic> _$ReceiptToJson(_Receipt instance) => <String, dynamic>{
      'result': instance.result,
    };

_Matching _$MatchingFromJson(Map<String, dynamic> json) => _Matching(
      result: json['result'] as int? ?? 1,
    );

Map<String, dynamic> _$MatchingToJson(_Matching instance) => <String, dynamic>{
      'result': instance.result,
    };

_Check _$CheckFromJson(Map<String, dynamic> json) => _Check(
      result: json['result'] as int? ?? 1,
    );

Map<String, dynamic> _$CheckToJson(_Check instance) => <String, dynamic>{
      'result': instance.result,
    };
