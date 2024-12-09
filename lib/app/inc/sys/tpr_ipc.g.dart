// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tpr_ipc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TprMsgDevReq _$TprMsgDevReqFromJson(Map<String, dynamic> json) => TprMsgDevReq(
      mid: json['mid'] as int? ?? 0,
      length: json['length'] as int? ?? 0,
      tid: json['tid'] as int? ?? 0,
      io: json['io'] as int? ?? 0,
      result: json['result'] as int? ?? 0,
      datalen: json['datalen'] as int? ?? 0,
    )..data = (json['data'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$TprMsgDevReqToJson(TprMsgDevReq instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'length': instance.length,
      'tid': instance.tid,
      'io': instance.io,
      'result': instance.result,
      'datalen': instance.datalen,
      'data': instance.data,
    };

TprMsgDevReq2 _$TprMsgDevReq2FromJson(Map<String, dynamic> json) =>
    TprMsgDevReq2(
      mid: json['mid'] as int? ?? 0,
      length: json['length'] as int? ?? 0,
      tid: json['tid'] as int? ?? 0,
      src: json['src'] as int? ?? 0,
      io: json['io'] as int? ?? 0,
      result: json['result'] as int? ?? 0,
      datalen: json['datalen'] as int? ?? 0,
      dataStr: json['dataStr'] as String? ?? "",
      payloadlen: json['payloadlen'] as int? ?? 0,
      payload: json['payload'] as String? ?? "",
    )..data = (json['data'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$TprMsgDevReq2ToJson(TprMsgDevReq2 instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'length': instance.length,
      'tid': instance.tid,
      'src': instance.src,
      'io': instance.io,
      'result': instance.result,
      'datalen': instance.datalen,
      'data': instance.data,
      'dataStr': instance.dataStr,
      'payloadlen': instance.payloadlen,
      'payload': instance.payload,
    };
