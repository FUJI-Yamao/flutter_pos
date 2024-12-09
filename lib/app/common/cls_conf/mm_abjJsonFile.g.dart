// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mm_abjJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mm_abjJsonFile _$Mm_abjJsonFileFromJson(Map<String, dynamic> json) =>
    Mm_abjJsonFile()
      ..now = _Now.fromJson(json['now'] as Map<String, dynamic>)
      ..bkup = _Bkup.fromJson(json['bkup'] as Map<String, dynamic>);

Map<String, dynamic> _$Mm_abjJsonFileToJson(Mm_abjJsonFile instance) =>
    <String, dynamic>{
      'now': instance.now.toJson(),
      'bkup': instance.bkup.toJson(),
    };

_Now _$NowFromJson(Map<String, dynamic> json) => _Now(
      now_exe_date: json['now_exe_date'] as String? ?? '0000-00-00 00:00:00',
      now_rcpt_no: json['now_rcpt_no'] as int? ?? 0,
      now_sale_date: json['now_sale_date'] as String? ?? '0000-00-00',
    );

Map<String, dynamic> _$NowToJson(_Now instance) => <String, dynamic>{
      'now_exe_date': instance.now_exe_date,
      'now_rcpt_no': instance.now_rcpt_no,
      'now_sale_date': instance.now_sale_date,
    };

_Bkup _$BkupFromJson(Map<String, dynamic> json) => _Bkup(
      bkup_exe_date: json['bkup_exe_date'] as String? ?? '0000-00-00 00:00:00',
      bkup_rcpt_no: json['bkup_rcpt_no'] as int? ?? 0,
      bkup_sale_date: json['bkup_sale_date'] as String? ?? '0000-00-00',
    );

Map<String, dynamic> _$BkupToJson(_Bkup instance) => <String, dynamic>{
      'bkup_exe_date': instance.bkup_exe_date,
      'bkup_rcpt_no': instance.bkup_rcpt_no,
      'bkup_sale_date': instance.bkup_sale_date,
    };
