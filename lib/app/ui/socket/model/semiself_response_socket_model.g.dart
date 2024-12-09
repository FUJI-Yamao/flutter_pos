// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semiself_response_socket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SemiSelfResponseInfo _$SemiSelfResponseInfoFromJson(
        Map<String, dynamic> json) =>
    SemiSelfResponseInfo(
      result: json['Result'] as bool,
      status: json['Status'] as String,
      cautionStatus: json['CautionStatus'] as String,
      uuid: json['Uuid'] as String,
      calcResultPay: json['CalcResultPay'] == null
          ? null
          : CalcResultPay.fromJson(
              json['CalcResultPay'] as Map<String, dynamic>),
      calcRequestParaPay: json['CalcRequestParaPay'] == null
          ? null
          : CalcRequestParaPay.fromJson(
              json['CalcRequestParaPay'] as Map<String, dynamic>),
      cancel: json['Cancel'] as bool,
      errNo: json['ErrNo'] as int,
    );

Map<String, dynamic> _$SemiSelfResponseInfoToJson(
        SemiSelfResponseInfo instance) =>
    <String, dynamic>{
      'Result': instance.result,
      'Status': instance.status,
      'CautionStatus': instance.cautionStatus,
      'Uuid': instance.uuid,
      'CalcResultPay': instance.calcResultPay,
      'CalcRequestParaPay': instance.calcRequestParaPay,
      'Cancel': instance.cancel,
      'ErrNo': instance.errNo,
    };
