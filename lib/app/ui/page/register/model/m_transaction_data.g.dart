// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_transaction_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDataList _$TransactionDataListFromJson(Map<String, dynamic> json) =>
    TransactionDataList(
      list: (json['TransactionDataList'] as List<dynamic>)
          .map((e) => TransactionData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionDataListToJson(
        TransactionDataList instance) =>
    <String, dynamic>{
      'TransactionDataList': instance.list,
    };

TransactionData _$TransactionDataFromJson(Map<String, dynamic> json) =>
    TransactionData()
      .._compCd = json['CompCd'] as int?
      .._streCd = json['StreCd'] as int?
      .._macNo = json['MacNo'] as int?
      .._uuid = json['Uuid'] as String?
      .._refundFlag = json['RefundFlag'] as int?
      .._refundDate = json['RefundDate'] as String?
      .._opeMode = json['OpeMode'] as int?
      .._priceMode = json['PriceMode'] as int?
      .._posSpec = json['PosSpec'] as int?
      .._arcsInfo = json['ArcsInfo'] == null
          ? null
          : ArcsInfo.fromJson(json['ArcsInfo'] as Map<String, dynamic>)
      .._lastResultData = json['CalcResultItem'] == null
          ? null
          : CalcResultItem.fromJson(
              json['CalcResultItem'] as Map<String, dynamic>)
      .._isAlreadyWarning = json['IsAlreadyWarning'] as bool?;

Map<String, dynamic> _$TransactionDataToJson(TransactionData instance) =>
    <String, dynamic>{
      'CompCd': instance._compCd,
      'StreCd': instance._streCd,
      'MacNo': instance._macNo,
      'Uuid': instance._uuid,
      'RefundFlag': instance._refundFlag,
      'RefundDate': instance._refundDate,
      'OpeMode': instance._opeMode,
      'PriceMode': instance._priceMode,
      'PosSpec': instance._posSpec,
      'ArcsInfo': instance._arcsInfo,
      'CalcResultItem': instance._lastResultData,
      'IsAlreadyWarning': instance._isAlreadyWarning,
    };
