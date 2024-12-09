// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pbchgJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PbchgJsonFile _$PbchgJsonFileFromJson(Map<String, dynamic> json) =>
    PbchgJsonFile()
      ..system = _System.fromJson(json['system'] as Map<String, dynamic>)
      ..count = _Count.fromJson(json['count'] as Map<String, dynamic>)
      ..tran = _Tran.fromJson(json['tran'] as Map<String, dynamic>)
      ..retry = _Retry.fromJson(json['retry'] as Map<String, dynamic>)
      ..save_ = _Save_.fromJson(json['save_'] as Map<String, dynamic>)
      ..download = _Download.fromJson(json['download'] as Map<String, dynamic>)
      ..util = _Util.fromJson(json['util'] as Map<String, dynamic>);

Map<String, dynamic> _$PbchgJsonFileToJson(PbchgJsonFile instance) =>
    <String, dynamic>{
      'system': instance.system.toJson(),
      'count': instance.count.toJson(),
      'tran': instance.tran.toJson(),
      'retry': instance.retry.toJson(),
      'save_': instance.save_.toJson(),
      'download': instance.download.toJson(),
      'util': instance.util.toJson(),
    };

_System _$SystemFromJson(Map<String, dynamic> json) => _System(
      termcd: json['termcd'] as int? ?? 0,
      groupcd: json['groupcd'] as int? ?? 0,
      officecd: json['officecd'] as int? ?? 0,
      strecd: json['strecd'] as int? ?? 0,
    );

Map<String, dynamic> _$SystemToJson(_System instance) => <String, dynamic>{
      'termcd': instance.termcd,
      'groupcd': instance.groupcd,
      'officecd': instance.officecd,
      'strecd': instance.strecd,
    };

_Count _$CountFromJson(Map<String, dynamic> json) => _Count(
      dealseqno: json['dealseqno'] as int? ?? 1,
      serviceseqno: json['serviceseqno'] as int? ?? 1,
    );

Map<String, dynamic> _$CountToJson(_Count instance) => <String, dynamic>{
      'dealseqno': instance.dealseqno,
      'serviceseqno': instance.serviceseqno,
    };

_Tran _$TranFromJson(Map<String, dynamic> json) => _Tran(
      steps: json['steps'] as int? ?? 95,
      res_sel: json['res_sel'] as int? ?? 5,
      fee1_sel: json['fee1_sel'] as int? ?? 6,
      fee2_sel: json['fee2_sel'] as int? ?? 7,
    );

Map<String, dynamic> _$TranToJson(_Tran instance) => <String, dynamic>{
      'steps': instance.steps,
      'res_sel': instance.res_sel,
      'fee1_sel': instance.fee1_sel,
      'fee2_sel': instance.fee2_sel,
    };

_Retry _$RetryFromJson(Map<String, dynamic> json) => _Retry(
      cnct: json['cnct'] as int? ?? 20,
      interval: json['interval'] as int? ?? 30,
      cnt: json['cnt'] as int? ?? 4,
      rd_timeout: json['rd_timeout'] as int? ?? 60,
      wt_timeout: json['wt_timeout'] as int? ?? 60,
    );

Map<String, dynamic> _$RetryToJson(_Retry instance) => <String, dynamic>{
      'cnct': instance.cnct,
      'interval': instance.interval,
      'cnt': instance.cnt,
      'rd_timeout': instance.rd_timeout,
      'wt_timeout': instance.wt_timeout,
    };

_Save_ _$Save_FromJson(Map<String, dynamic> json) => _Save_(
      month: json['month'] as int? ?? 13,
    );

Map<String, dynamic> _$Save_ToJson(_Save_ instance) => <String, dynamic>{
      'month': instance.month,
    };

_Download _$DownloadFromJson(Map<String, dynamic> json) => _Download(
      date: json['date'] as String? ?? '00000000000000',
      result: json['result'] as int? ?? 0,
    );

Map<String, dynamic> _$DownloadToJson(_Download instance) => <String, dynamic>{
      'date': instance.date,
      'result': instance.result,
    };

_Util _$UtilFromJson(Map<String, dynamic> json) => _Util(
      exec: json['exec'] as int? ?? 0,
    );

Map<String, dynamic> _$UtilToJson(_Util instance) => <String, dynamic>{
      'exec': instance.exec,
    };
