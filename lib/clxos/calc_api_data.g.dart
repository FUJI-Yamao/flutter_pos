// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calc_api_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalcRequestParaItem _$CalcRequestParaItemFromJson(Map<String, dynamic> json) =>
    CalcRequestParaItem(
      compCd: json['CompCd'] as int,
      streCd: json['StreCd'] as int,
      custCode: json['CustCode'] as String? ?? "",
      macNo: json['MacNo'] as int? ?? null,
      uuid: json['Uuid'] as String? ?? "",
      opeMode: json['OpeMode'] as int? ?? null,
      refundFlag: json['RefundFlag'] as int? ?? null,
      priceMode: json['PriceMode'] as int? ?? null,
      arcsInfo: json['ArcsInfo'] == null
          ? null
          : ArcsInfo.fromJson(json['ArcsInfo'] as Map<String, dynamic>),
    )
      ..itemList = (json['ItemList'] as List<dynamic>)
          .map((e) => ItemData.fromJson(e as Map<String, dynamic>))
          .toList()
      ..subttlList = (json['SubttlList'] as List<dynamic>)
          .map((e) => SubttlData.fromJson(e as Map<String, dynamic>))
          .toList()
      ..posSpec = json['PosSpec'] as int?;

Map<String, dynamic> _$CalcRequestParaItemToJson(
        CalcRequestParaItem instance) =>
    <String, dynamic>{
      'CompCd': instance.compCd,
      'StreCd': instance.streCd,
      'ItemList': instance.itemList,
      'CustCode': instance.custCode,
      'SubttlList': instance.subttlList,
      'MacNo': instance.macNo,
      'Uuid': instance.uuid,
      'OpeMode': instance.opeMode,
      'RefundFlag': instance.refundFlag,
      'PriceMode': instance.priceMode,
      'PosSpec': instance.posSpec,
      'ArcsInfo': instance.arcsInfo,
    };

CalcRequestParaPay _$CalcRequestParaPayFromJson(Map<String, dynamic> json) =>
    CalcRequestParaPay(
      compCd: json['CompCd'] as int,
      streCd: json['StreCd'] as int,
      custCode: json['CustCode'] as String? ?? "",
      macNo: json['MacNo'] as int? ?? null,
      uuid: json['Uuid'] as String? ?? "",
      opeMode: json['OpeMode'] as int? ?? null,
      refundFlag: json['RefundFlag'] as int? ?? null,
      refundDate: json['RefundDate'] as String? ?? "",
      priceMode: json['PriceMode'] as int? ?? null,
      posSpec: json['PosSpec'] as int? ?? null,
      arcsInfo: json['ArcsInfo'] == null
          ? null
          : ArcsInfo.fromJson(json['ArcsInfo'] as Map<String, dynamic>),
      qcSendMacNo: json['QcSendMacNo'] as int? ?? null,
      qcSendMacName: json['QcSendMacName'] as String? ?? null,
    )
      ..itemList = (json['ItemList'] as List<dynamic>)
          .map((e) => ItemData.fromJson(e as Map<String, dynamic>))
          .toList()
      ..subttlList = (json['SubttlList'] as List<dynamic>)
          .map((e) => SubttlData.fromJson(e as Map<String, dynamic>))
          .toList()
      ..payList = (json['PayList'] as List<dynamic>?)
              ?.map((e) => PayData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

Map<String, dynamic> _$CalcRequestParaPayToJson(CalcRequestParaPay instance) =>
    <String, dynamic>{
      'CompCd': instance.compCd,
      'StreCd': instance.streCd,
      'ItemList': instance.itemList,
      'CustCode': instance.custCode,
      'SubttlList': instance.subttlList,
      'MacNo': instance.macNo,
      'Uuid': instance.uuid,
      'PayList': instance.payList,
      'OpeMode': instance.opeMode,
      'RefundFlag': instance.refundFlag,
      'RefundDate': instance.refundDate,
      'PriceMode': instance.priceMode,
      'PosSpec': instance.posSpec,
      'ArcsInfo': instance.arcsInfo,
      'QcSendMacNo': instance.qcSendMacNo,
      'QcSendMacName': instance.qcSendMacName,
    };

ItemData _$ItemDataFromJson(Map<String, dynamic> json) => ItemData(
      seqNo: json['rSeqNo'] as int,
      qty: json['rQty'] as int,
      type: json['rType'] as int,
      barcode1: json['rBarcode1'] as String,
      cnctTime: json['rCnctTime'] as String,
      clsNo: json['rClsNo'] as int,
      clsVal: json['rClsVal'] as int?,
      barcode2: json['rBarcode2'] as String? ?? "",
      itemDscType: json['rItemDscType'] as int? ?? null,
      itemDscVal: json['rItemDscVal'] as int? ?? null,
      itemDscCode: json['rItemDscCode'] as int? ?? null,
      prcChgVal: json['rPrcChgVal'] as int? ?? null,
      decimalVal: json['rDecimalVal'] as String? ?? "",
      taxChgCode: json['rTaxChgCode'] as int? ?? null,
    );

Map<String, dynamic> _$ItemDataToJson(ItemData instance) => <String, dynamic>{
      'rSeqNo': instance.seqNo,
      'rQty': instance.qty,
      'rType': instance.type,
      'rBarcode1': instance.barcode1,
      'rBarcode2': instance.barcode2,
      'rCnctTime': instance.cnctTime,
      'rItemDscType': instance.itemDscType,
      'rItemDscVal': instance.itemDscVal,
      'rItemDscCode': instance.itemDscCode,
      'rPrcChgVal': instance.prcChgVal,
      'rClsNo': instance.clsNo,
      'rClsVal': instance.clsVal,
      'rDecimalVal': instance.decimalVal,
      'rTaxChgCode': instance.taxChgCode,
    };

CalcRequestBatchReport _$CalcRequestBatchReportFromJson(
        Map<String, dynamic> json) =>
    CalcRequestBatchReport(
      compCd: json['rCompCd'] as int?,
      streCd: json['rStreCd'] as int?,
      macNo: json['rMacNo'] as int?,
      saleDate: json['rSaleDate'] as String?,
      batchGrpCd: json['rBatchGrpCd'] as int?,
      batchNo: json['rBatchNo'] as int?,
      batchOrder: json['rBatchOrder'] as int?,
    );

Map<String, dynamic> _$CalcRequestBatchReportToJson(
        CalcRequestBatchReport instance) =>
    <String, dynamic>{
      'rCompCd': instance.compCd,
      'rStreCd': instance.streCd,
      'rMacNo': instance.macNo,
      'rSaleDate': instance.saleDate,
      'rBatchGrpCd': instance.batchGrpCd,
      'rBatchNo': instance.batchNo,
      'rBatchOrder': instance.batchOrder,
    };

SubttlData _$SubttlDataFromJson(Map<String, dynamic> json) => SubttlData(
      stlDscCode: json['rStlDscCode'] as int? ?? null,
      stlDscVal: json['rStlDscVal'] as int? ?? null,
    );

Map<String, dynamic> _$SubttlDataToJson(SubttlData instance) =>
    <String, dynamic>{
      'rStlDscCode': instance.stlDscCode,
      'rStlDscVal': instance.stlDscVal,
    };

PayData _$PayDataFromJson(Map<String, dynamic> json) => PayData(
      payCode: json['rPayCode'] as int,
      amount: json['rAmount'] as int,
      sheet: json['rSheet'] as int?,
      creditNo: json['rCreditNo'] as String?,
      dataDivision: json['rDataDivision'] as String?,
      totalLevel: json['rTotalLevel'] as String?,
      tranDivision: json['rTranDivision'] as String?,
      divideCount: json['rDivideCount'] as String?,
      memberCode: json['rMemberCode'] as String?,
      saleyymmdd: json['rSaleyymmdd'] as String?,
      saleAmount: json['rSaleAmount'] as String?,
      recognizeNo: json['rRecognizeNo'] as String?,
      goodThru: json['rGoodThru'] as String?,
      posRecognizeNo: json['rPosRecognizeNo'] as String?,
      posReceiptNo: json['rPosReceiptNo'] as String?,
      chaCount1: json['rChaCount1'] as String?,
      chaAmount1: json['rChaAmount1'] as String?,
      chaCount2: json['rChaCount2'] as String?,
      chaAmount2: json['rChaAmount2'] as String?,
      chaCount3: json['rChaCount3'] as String?,
      chaAmount3: json['rChaAmount3'] as String?,
      chaCount7: json['rChaCount7'] as String?,
      chaAmount7: json['rChaAmount7'] as String?,
      sellKind: json['rSellKind'] as String?,
      seqInqNo: json['rSeqInqNo'] as String?,
      chargeCheckNo: json['rChargeCheckNo'] as String?,
      cancelSlipNo: json['rCancelSlipNo'] as String?,
      reqCode: json['rReqCode'] as String?,
      cardJis1: json['rCardJis1'] as String?,
      cardJis2: json['rCardJis2'] as String?,
      handleDivide: json['rHandleDivide'] as String?,
      payAWay: json['rPayAWay'] as String?,
      cardName: json['rCardName'] as String?,
    );

Map<String, dynamic> _$PayDataToJson(PayData instance) => <String, dynamic>{
      'rPayCode': instance.payCode,
      'rAmount': instance.amount,
      'rSheet': instance.sheet,
      'rCreditNo': instance.creditNo,
      'rDataDivision': instance.dataDivision,
      'rTotalLevel': instance.totalLevel,
      'rTranDivision': instance.tranDivision,
      'rDivideCount': instance.divideCount,
      'rMemberCode': instance.memberCode,
      'rSaleyymmdd': instance.saleyymmdd,
      'rSaleAmount': instance.saleAmount,
      'rRecognizeNo': instance.recognizeNo,
      'rGoodThru': instance.goodThru,
      'rPosRecognizeNo': instance.posRecognizeNo,
      'rPosReceiptNo': instance.posReceiptNo,
      'rChaCount1': instance.chaCount1,
      'rChaAmount1': instance.chaAmount1,
      'rChaCount2': instance.chaCount2,
      'rChaAmount2': instance.chaAmount2,
      'rChaCount3': instance.chaCount3,
      'rChaAmount3': instance.chaAmount3,
      'rChaCount7': instance.chaCount7,
      'rChaAmount7': instance.chaAmount7,
      'rSellKind': instance.sellKind,
      'rSeqInqNo': instance.seqInqNo,
      'rChargeCheckNo': instance.chargeCheckNo,
      'rCancelSlipNo': instance.cancelSlipNo,
      'rReqCode': instance.reqCode,
      'rCardJis1': instance.cardJis1,
      'rCardJis2': instance.cardJis2,
      'rHandleDivide': instance.handleDivide,
      'rPayAWay': instance.payAWay,
      'rCardName': instance.cardName,
    };

ArcsInfo _$ArcsInfoFromJson(Map<String, dynamic> json) => ArcsInfo(
      custType: json['rCustType'] as int?,
      workType: json['rWorkType'] as int?,
    );

Map<String, dynamic> _$ArcsInfoToJson(ArcsInfo instance) => <String, dynamic>{
      'rCustType': instance.custType,
      'rWorkType': instance.workType,
    };
