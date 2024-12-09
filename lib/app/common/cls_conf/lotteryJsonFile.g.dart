// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lotteryJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryJsonFile _$LotteryJsonFileFromJson(Map<String, dynamic> json) =>
    LotteryJsonFile()
      ..common = _Common.fromJson(json['common'] as Map<String, dynamic>);

Map<String, dynamic> _$LotteryJsonFileToJson(LotteryJsonFile instance) =>
    <String, dynamic>{
      'common': instance.common.toJson(),
    };

_Common _$CommonFromJson(Map<String, dynamic> json) => _Common(
      lottery_assist_amt: json['lottery_assist_amt'] as int? ?? 300,
      lottery_assist_cnt: json['lottery_assist_cnt'] as int? ?? 10,
    );

Map<String, dynamic> _$CommonToJson(_Common instance) => <String, dynamic>{
      'lottery_assist_amt': instance.lottery_assist_amt,
      'lottery_assist_cnt': instance.lottery_assist_cnt,
    };
