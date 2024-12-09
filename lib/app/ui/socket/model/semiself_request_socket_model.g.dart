// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semiself_request_socket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SemiSelfRequestInfo _$SemiSelfRequestInfoFromJson(Map<String, dynamic> json) =>
    SemiSelfRequestInfo(
      macNo: json['MacNo'] as int,
      uuid: json['Uuid'] as String,
      cancel: json['Cancel'] as bool,
      cartLogQuery: (json['CartLogQuery'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      calcResultPay: json['CalcResultPay'] == null
          ? null
          : CalcResultPay.fromJson(
              json['CalcResultPay'] as Map<String, dynamic>),
      requestParaPay: json['CalcRequestParaPay'] == null
          ? null
          : CalcRequestParaPay.fromJson(
              json['CalcRequestParaPay'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SemiSelfRequestInfoToJson(
        SemiSelfRequestInfo instance) =>
    <String, dynamic>{
      'MacNo': instance.macNo,
      'Uuid': instance.uuid,
      'Cancel': instance.cancel,
      'CartLogQuery': instance.cartLogQuery,
      'CalcResultPay': instance.calcResultPay,
      'CalcRequestParaPay': instance.requestParaPay,
    };
