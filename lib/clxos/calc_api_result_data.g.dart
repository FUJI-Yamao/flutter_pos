// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calc_api_result_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalcResultStore _$CalcResultStoreFromJson(Map<String, dynamic> json) =>
    CalcResultStore(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      saleDate: json['SaleDate'] as String?,
      forcedClose: json['ForcedClose'] as String?,
    );

Map<String, dynamic> _$CalcResultStoreToJson(CalcResultStore instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'SaleDate': instance.saleDate,
      'ForcedClose': instance.forcedClose,
    };

CalcResultStaff _$CalcResultStaffFromJson(Map<String, dynamic> json) =>
    CalcResultStaff(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      posErrCd: json['PosErrCd'] as int?,
      staffCd: json['StaffCd'] as String?,
      staffName: json['StaffName'] as String?,
      menuAuthNotCodeList: json['MenuAuthNotCode'] as List<dynamic>?,
      keyAuthNotCodeList: json['KeyAuthNotCode'] as List<dynamic>?,
    );

Map<String, dynamic> _$CalcResultStaffToJson(CalcResultStaff instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'PosErrCd': instance.posErrCd,
      'StaffCd': instance.staffCd,
      'StaffName': instance.staffName,
      'MenuAuthNotCode': instance.menuAuthNotCodeList,
      'KeyAuthNotCode': instance.keyAuthNotCodeList,
    };

CalcResultItem _$CalcResultItemFromJson(Map<String, dynamic> json) =>
    CalcResultItem(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      posErrCd: json['PosErrCd'] as int?,
      calcResultItemList: (json['ItemList'] as List<dynamic>?)
          ?.map((e) => ResultItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDataList: (json['TotalData'] as List<dynamic>?)
          ?.map((e) => TotalData.fromJson(e as Map<String, dynamic>))
          .toList(),
      custData: json['CustData'] == null
          ? null
          : CustData.fromJson(json['CustData'] as Map<String, dynamic>),
      subttlList: (json['SubttlList'] as List<dynamic>?)
          ?.map((e) => SubttlResData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CalcResultItemToJson(CalcResultItem instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'PosErrCd': instance.posErrCd,
      'ItemList': instance.calcResultItemList,
      'TotalData': instance.totalDataList,
      'CustData': instance.custData,
      'SubttlList': instance.subttlList,
    };

CalcResultPay _$CalcResultPayFromJson(Map<String, dynamic> json) =>
    CalcResultPay(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      posErrCd: json['PosErrCd'] as int?,
      totalData: json['TotalData'] == null
          ? null
          : PayTotalData.fromJson(json['TotalData'] as Map<String, dynamic>),
      digitalReceipt: json['DigitalReceipt'] == null
          ? null
          : PayDigitalReceipt.fromJson(
              json['DigitalReceipt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalcResultPayToJson(CalcResultPay instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'PosErrCd': instance.posErrCd,
      'TotalData': instance.totalData,
      'DigitalReceipt': instance.digitalReceipt,
    };

CalcResultVoid _$CalcResultVoidFromJson(Map<String, dynamic> json) =>
    CalcResultVoid(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      posErrCd: json['PosErrCd'] as int?,
      totalData: json['TotalData'] == null
          ? null
          : PayTotalData.fromJson(json['TotalData'] as Map<String, dynamic>),
      digitalReceipt: json['DigitalReceipt'] == null
          ? null
          : PayDigitalReceipt.fromJson(
              json['DigitalReceipt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalcResultVoidToJson(CalcResultVoid instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'PosErrCd': instance.posErrCd,
      'TotalData': instance.totalData,
      'DigitalReceipt': instance.digitalReceipt,
    };

CalcResultVoidSearch _$CalcResultVoidSearchFromJson(
        Map<String, dynamic> json) =>
    CalcResultVoidSearch(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      posErrCd: json['PosErrCd'] as int?,
      serialNo: json['SerialNo'] as String?,
      saleDate: json['SaleDate'] as String?,
      receiptNo: json['ReceiptNo'] as int?,
      printNo: json['PrintNo'] as int?,
      macNo: json['MacNo'] as int?,
      saleAmt: json['SaleAmt'] as int?,
      crdtInfo: json['CrdtInfo'] == null
          ? null
          : CrdtInfo.fromJson(json['CrdtInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalcResultVoidSearchToJson(
        CalcResultVoidSearch instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'PosErrCd': instance.posErrCd,
      'SerialNo': instance.serialNo,
      'SaleDate': instance.saleDate,
      'ReceiptNo': instance.receiptNo,
      'PrintNo': instance.printNo,
      'MacNo': instance.macNo,
      'SaleAmt': instance.saleAmt,
      'CrdtInfo': instance.crdtInfo,
    };

CrdtInfo _$CrdtInfoFromJson(Map<String, dynamic> json) => CrdtInfo(
      space: json['Space'] as int?,
      posReceiptNo: json['PosReceiptNo'] as int?,
      memberCode: json['MemberCode'] as String?,
      streJoinNo: json['StreJoinNo'] as String?,
      posRecognizeNo: json['PosRecognizeNo'] as String?,
    );

Map<String, dynamic> _$CrdtInfoToJson(CrdtInfo instance) => <String, dynamic>{
      'Space': instance.space,
      'PosReceiptNo': instance.posReceiptNo,
      'MemberCode': instance.memberCode,
      'StreJoinNo': instance.streJoinNo,
      'PosRecognizeNo': instance.posRecognizeNo,
    };

CalcResultReturn _$CalcResultReturnFromJson(Map<String, dynamic> json) =>
    CalcResultReturn(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
    );

Map<String, dynamic> _$CalcResultReturnToJson(CalcResultReturn instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
    };

CalcResultCustomercard _$CalcResultCustomercardFromJson(
        Map<String, dynamic> json) =>
    CalcResultCustomercard(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      resultItemDataList: (json['ItemList'] as List<dynamic>?)
          ?.map((e) => ResultItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDataList: (json['TotalData'] as List<dynamic>?)
          ?.map((e) => TotalData.fromJson(e as Map<String, dynamic>))
          .toList(),
      custData: json['CustData'] == null
          ? null
          : CustData.fromJson(json['CustData'] as Map<String, dynamic>),
      uuid: json['UUID'] as String?,
      staffCode: json['StaffCode'] as int?,
      saveMacNo: json['SaveMacNo'] as int?,
      saveTime: json['SaveTime'] as String?,
    );

Map<String, dynamic> _$CalcResultCustomercardToJson(
        CalcResultCustomercard instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'ItemList': instance.resultItemDataList,
      'TotalData': instance.totalDataList,
      'CustData': instance.custData,
      'UUID': instance.uuid,
      'StaffCode': instance.staffCode,
      'SaveMacNo': instance.saveMacNo,
      'SaveTime': instance.saveTime,
    };

CalcResultActualResults _$CalcResultActualResultsFromJson(
        Map<String, dynamic> json) =>
    CalcResultActualResults(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      posErrCd: json['PosErrCd'] as int?,
      count: json['Count'] as int?,
      remain: json['Remain'] as int?,
    );

Map<String, dynamic> _$CalcResultActualResultsToJson(
        CalcResultActualResults instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'PosErrCd': instance.posErrCd,
      'Count': instance.count,
      'Remain': instance.remain,
    };

CalcResultDrwchk _$CalcResultDrwchkFromJson(Map<String, dynamic> json) =>
    CalcResultDrwchk(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      paychkDataList: (json['PayList'] as List<dynamic>?)
          ?.map((e) => PaychkData.fromJson(e as Map<String, dynamic>))
          .toList(),
      cashInfoData: json['CashInfo'] == null
          ? null
          : CashChaChkAmtData.fromJson(
              json['CashInfo'] as Map<String, dynamic>),
      chaInfoData: json['ChaInfo'] == null
          ? null
          : CashChaChkAmtData.fromJson(json['ChaInfo'] as Map<String, dynamic>),
      chkInfoData: json['ChkInfo'] == null
          ? null
          : CashChaChkAmtData.fromJson(json['ChkInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalcResultDrwchkToJson(CalcResultDrwchk instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'PayList': instance.paychkDataList,
      'CashInfo': instance.cashInfoData,
      'ChaInfo': instance.chaInfoData,
      'ChkInfo': instance.chkInfoData,
    };

ResultItemData _$ResultItemDataFromJson(Map<String, dynamic> json) =>
    ResultItemData(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      posErrCd: json['PosErrCd'] as int?,
      seqNo: json['SeqNo'] as int?,
      type: json['Type'] as int?,
      itemType: json['ItemType'] as int?,
      warningType: json['WarningType'] as int?,
      barcode: json['Barcode'] as String?,
      orgBarcode1: json['OrgBarcode1'] as String?,
      orgBarcode2: json['OrgBarcode2'] as String?,
      name: json['Name'] as String?,
      price: json['Price'] as int?,
      qty: json['Qty'] as int?,
      discountList: (json['DiscountList'] as List<dynamic>?)
          ?.map((e) => DiscountData.fromJson(e as Map<String, dynamic>))
          .toList(),
      taxDataList: (json['TaxList'] as List<dynamic>?)
          ?.map((e) => TaxData.fromJson(e as Map<String, dynamic>))
          .toList(),
      scanTime: json['ScanTime'] as String?,
      itemKind: json['ItemKind'] as int?,
      itemDscType: json['ItemDscType'] as int?,
      itemDscVal: json['ItemDscVal'] as int?,
      itemDscCode: json['ItemDscCode'] as int?,
      prcChgVal: json['PrcChgVal'] as int?,
      prcChgFlg: json['PrcChgFlg'] as int?,
      discChgFlg: json['DiscChgFlg'] as int?,
      decimalVal: json['DecimalVal'] as String?,
      clsNo: json['ClsNo'] as int?,
      clsVal: json['ClsVal'] as int?,
      pointAddList: (json['PointAddList'] as List<dynamic>?)
          ?.map((e) => PointAddData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..priceList = (json['PriceList'] as List<dynamic>?)
        ?.map((e) => PriceData.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ResultItemDataToJson(ResultItemData instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'PosErrCd': instance.posErrCd,
      'SeqNo': instance.seqNo,
      'Type': instance.type,
      'ItemType': instance.itemType,
      'WarningType': instance.warningType,
      'Barcode': instance.barcode,
      'OrgBarcode1': instance.orgBarcode1,
      'OrgBarcode2': instance.orgBarcode2,
      'Name': instance.name,
      'Price': instance.price,
      'Qty': instance.qty,
      'DiscountList': instance.discountList,
      'TaxList': instance.taxDataList,
      'PriceList': instance.priceList,
      'ScanTime': instance.scanTime,
      'ItemKind': instance.itemKind,
      'ItemDscType': instance.itemDscType,
      'ItemDscVal': instance.itemDscVal,
      'ItemDscCode': instance.itemDscCode,
      'PrcChgVal': instance.prcChgVal,
      'PrcChgFlg': instance.prcChgFlg,
      'DiscChgFlg': instance.discChgFlg,
      'DecimalVal': instance.decimalVal,
      'ClsNo': instance.clsNo,
      'ClsVal': instance.clsVal,
      'PointAddList': instance.pointAddList,
    };

CalcResultBatchReport _$CalcResultBatchReportFromJson(
        Map<String, dynamic> json) =>
    CalcResultBatchReport(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      totalData: json['TotalData'] == null
          ? null
          : PayTotalData.fromJson(json['TotalData'] as Map<String, dynamic>),
      digitalReceipt: json['DigitalReceipt'] == null
          ? null
          : PayDigitalReceipt.fromJson(
              json['DigitalReceipt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalcResultBatchReportToJson(
        CalcResultBatchReport instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'TotalData': instance.totalData,
      'DigitalReceipt': instance.digitalReceipt,
    };

CalcResultChanger _$CalcResultChangerFromJson(Map<String, dynamic> json) =>
    CalcResultChanger(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      digitalReceipt: json['DigitalReceipt'] == null
          ? null
          : PayDigitalReceipt.fromJson(
              json['DigitalReceipt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalcResultChangerToJson(CalcResultChanger instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'DigitalReceipt': instance.digitalReceipt,
    };

CalcResultSearchReceipt _$CalcResultSearchReceiptFromJson(
        Map<String, dynamic> json) =>
    CalcResultSearchReceipt(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      posErrCd: json['PosErrCd'] as int?,
      totalData: json['TotalData'] == null
          ? null
          : PayTotalData.fromJson(json['TotalData'] as Map<String, dynamic>),
      digitalReceipt: json['DigitalReceipt'] == null
          ? null
          : PayDigitalReceipt.fromJson(
              json['DigitalReceipt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalcResultSearchReceiptToJson(
        CalcResultSearchReceipt instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'PosErrCd': instance.posErrCd,
      'TotalData': instance.totalData,
      'DigitalReceipt': instance.digitalReceipt,
    };

DiscountData _$DiscountDataFromJson(Map<String, dynamic> json) => DiscountData(
      type: json['Type'] as int?,
      code: json['Code'] as int?,
      name: json['Name'] as String?,
      discountPrice: json['DiscountPrice'] as int?,
      formedFlg: json['FormedFlg'] as int?,
    );

Map<String, dynamic> _$DiscountDataToJson(DiscountData instance) =>
    <String, dynamic>{
      'Type': instance.type,
      'Code': instance.code,
      'Name': instance.name,
      'DiscountPrice': instance.discountPrice,
      'FormedFlg': instance.formedFlg,
    };

TaxData _$TaxDataFromJson(Map<String, dynamic> json) => TaxData(
      type: json['Type'] as int?,
      rate: json['Rate'] as int?,
      code: json['Code'] as int?,
    );

Map<String, dynamic> _$TaxDataToJson(TaxData instance) => <String, dynamic>{
      'Type': instance.type,
      'Rate': instance.rate,
      'Code': instance.code,
    };

PriceData _$PriceDataFromJson(Map<String, dynamic> json) => PriceData(
      mdlClsCd: json['MdlClsCd'] as int?,
      mdlClsName: json['MdlClsName'] as String?,
      smlClsCd: json['SmlClsCd'] as int?,
      smlClsName: json['SmlClsName'] as String?,
      posPrice: json['PosPrice'] as int?,
      brgnPrice: json['BrgnPrice'] as int?,
      brgnCustPrice: json['BrgnCustPrice'] as int?,
      bdlType: json['BdlType'] as int?,
      bdlFormQty1: json['BdlFormQty1'] as int?,
      bdlFormQty2: json['BdlFormQty2'] as int?,
      bdlFormQty3: json['BdlFormQty3'] as int?,
      bdlFormQty4: json['BdlFormQty4'] as int?,
      bdlFormQty5: json['BdlFormQty5'] as int?,
      bdlFormPrc1: json['BdlFormPrc1'] as int?,
      bdlFormPrc2: json['BdlFormPrc2'] as int?,
      bdlFormPrc3: json['BdlFormPrc3'] as int?,
      bdlFormPrc4: json['BdlFormPrc4'] as int?,
      bdlFormPrc5: json['BdlFormPrc5'] as int?,
      bdlFormCustPrc1: json['BdlFormCustPrc1'] as int?,
      bdlFormCustPrc2: json['BdlFormCustPrc2'] as int?,
      bdlFormCustPrc3: json['BdlFormCustPrc3'] as int?,
      bdlFormCustPrc4: json['BdlFormCustPrc4'] as int?,
      bdlFormCustPrc5: json['BdlFormCustPrc5'] as int?,
      bdlAvg: json['BdlAvg'] as int?,
      bdlCustAvg: json['BdlCustAvg'] as int?,
    );

Map<String, dynamic> _$PriceDataToJson(PriceData instance) => <String, dynamic>{
      'MdlClsCd': instance.mdlClsCd,
      'MdlClsName': instance.mdlClsName,
      'SmlClsCd': instance.smlClsCd,
      'SmlClsName': instance.smlClsName,
      'PosPrice': instance.posPrice,
      'BrgnPrice': instance.brgnPrice,
      'BrgnCustPrice': instance.brgnCustPrice,
      'BdlType': instance.bdlType,
      'BdlFormQty1': instance.bdlFormQty1,
      'BdlFormQty2': instance.bdlFormQty2,
      'BdlFormQty3': instance.bdlFormQty3,
      'BdlFormQty4': instance.bdlFormQty4,
      'BdlFormQty5': instance.bdlFormQty5,
      'BdlFormPrc1': instance.bdlFormPrc1,
      'BdlFormPrc2': instance.bdlFormPrc2,
      'BdlFormPrc3': instance.bdlFormPrc3,
      'BdlFormPrc4': instance.bdlFormPrc4,
      'BdlFormPrc5': instance.bdlFormPrc5,
      'BdlFormCustPrc1': instance.bdlFormCustPrc1,
      'BdlFormCustPrc2': instance.bdlFormCustPrc2,
      'BdlFormCustPrc3': instance.bdlFormCustPrc3,
      'BdlFormCustPrc4': instance.bdlFormCustPrc4,
      'BdlFormCustPrc5': instance.bdlFormCustPrc5,
      'BdlAvg': instance.bdlAvg,
      'BdlCustAvg': instance.bdlCustAvg,
    };

PointAddData _$PointAddDataFromJson(Map<String, dynamic> json) => PointAddData(
      type: json['Type'] as int?,
      point: json['Point'] as int?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$PointAddDataToJson(PointAddData instance) =>
    <String, dynamic>{
      'Type': instance.type,
      'Point': instance.point,
      'Name': instance.name,
    };

TotalData _$TotalDataFromJson(Map<String, dynamic> json) => TotalData(
      amount: json['Amount'] as int?,
      totalDataDiscountList: (json['DiscountList'] as List<dynamic>?)
          ?.map(
              (e) => TotalDataDiscountData.fromJson(e as Map<String, dynamic>))
          .toList(),
      baseAmount: json['BaseAmount'] as int?,
      totalQty: json['TotalQty'] as int?,
      refundFlag: json['RefundFlag'] as int?,
      subtotal: json['Subtotal'] as int?,
      subDscAmount: json['SubDscAmount'] as int?,
      exTaxAmount: json['ExTaxAmount'] as int?,
    );

Map<String, dynamic> _$TotalDataToJson(TotalData instance) => <String, dynamic>{
      'Amount': instance.amount,
      'DiscountList': instance.totalDataDiscountList,
      'BaseAmount': instance.baseAmount,
      'TotalQty': instance.totalQty,
      'RefundFlag': instance.refundFlag,
      'Subtotal': instance.subtotal,
      'SubDscAmount': instance.subDscAmount,
      'ExTaxAmount': instance.exTaxAmount,
    };

TotalDataDiscountData _$TotalDataDiscountDataFromJson(
        Map<String, dynamic> json) =>
    TotalDataDiscountData(
      type: json['Type'] as int?,
      discountPrice: json['DiscountPrice'] as int?,
    );

Map<String, dynamic> _$TotalDataDiscountDataToJson(
        TotalDataDiscountData instance) =>
    <String, dynamic>{
      'Type': instance.type,
      'DiscountPrice': instance.discountPrice,
    };

CustData _$CustDataFromJson(Map<String, dynamic> json) => CustData(
      custCode: json['CustCode'] as String?,
      lastPoint: json['LastPoint'] as int?,
      custName: json['CustName'] as String?,
      custStatus: json['CustStatus'] as String?,
    );

Map<String, dynamic> _$CustDataToJson(CustData instance) => <String, dynamic>{
      'CustCode': instance.custCode,
      'LastPoint': instance.lastPoint,
      'CustName': instance.custName,
      'CustStatus': instance.custStatus,
    };

SubttlResData _$SubttlResDataFromJson(Map<String, dynamic> json) =>
    SubttlResData(
      stlDscCode: json['StlDscCode'] as int?,
      stlDscVal: json['StlDscVal'] as int?,
      stlDscAmount: json['StlDscAmount'] as int?,
      stlDscName: json['StlDscName'] as String?,
    );

Map<String, dynamic> _$SubttlResDataToJson(SubttlResData instance) =>
    <String, dynamic>{
      'StlDscCode': instance.stlDscCode,
      'StlDscVal': instance.stlDscVal,
      'StlDscAmount': instance.stlDscAmount,
      'StlDscName': instance.stlDscName,
    };

PayTotalData _$PayTotalDataFromJson(Map<String, dynamic> json) => PayTotalData(
      amount: json['Amount'] as int?,
      payment: json['Payment'] as int?,
      change: json['Change'] as int?,
      refundFlag: json['RefundFlag'] as int?,
      totalQty: json['TotalQty'] as int?,
      compCd: json['CompCd'] as int?,
      streCd: json['StreCd'] as int?,
      macNo: json['MacNo'] as int?,
      receiptNo: json['ReceiptNo'] as int?,
      printNo: json['PrintNo'] as int?,
      cashierNo: json['CashierNo'] as int?,
      endTime: json['EndTime'] as String?,
      SerialNo: json['SerialNo'] as String?,
      uuid: json['UUID'] as String?,
    );

Map<String, dynamic> _$PayTotalDataToJson(PayTotalData instance) =>
    <String, dynamic>{
      'Amount': instance.amount,
      'Payment': instance.payment,
      'Change': instance.change,
      'RefundFlag': instance.refundFlag,
      'TotalQty': instance.totalQty,
      'CompCd': instance.compCd,
      'StreCd': instance.streCd,
      'MacNo': instance.macNo,
      'ReceiptNo': instance.receiptNo,
      'PrintNo': instance.printNo,
      'CashierNo': instance.cashierNo,
      'EndTime': instance.endTime,
      'SerialNo': instance.SerialNo,
      'UUID': instance.uuid,
    };

PayDigitalReceipt _$PayDigitalReceiptFromJson(Map<String, dynamic> json) =>
    PayDigitalReceipt(
      transaction: json['Transaction'] == null
          ? null
          : PayTransaction.fromJson(
              json['Transaction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayDigitalReceiptToJson(PayDigitalReceipt instance) =>
    <String, dynamic>{
      'Transaction': instance.transaction,
    };

PayTransaction _$PayTransactionFromJson(Map<String, dynamic> json) =>
    PayTransaction(
      receiptDateTime: json['ReceiptDateTime'] as String?,
      workstationID: json['WorkstationID'] as String?,
      receiptNumber: json['ReceiptNumber'] as String?,
      transactionID: json['TransactionID'] as String?,
      receiptImage: json['ReceiptImage'] == null
          ? null
          : PayReceiptImage.fromJson(
              json['ReceiptImage'] as Map<String, dynamic>),
      retailTransaction: json['RetailTransaction'] == null
          ? null
          : PayRetailTransaction.fromJson(
              json['RetailTransaction'] as Map<String, dynamic>),
      trkReceiptImageList: (json['TRKReceiptImage'] as List<dynamic>?)
          ?.map((e) => PayTRKReceiptImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PayTransactionToJson(PayTransaction instance) =>
    <String, dynamic>{
      'ReceiptDateTime': instance.receiptDateTime,
      'WorkstationID': instance.workstationID,
      'ReceiptNumber': instance.receiptNumber,
      'TransactionID': instance.transactionID,
      'ReceiptImage': instance.receiptImage,
      'RetailTransaction': instance.retailTransaction,
      'TRKReceiptImage': instance.trkReceiptImageList,
    };

PayReceiptImage _$PayReceiptImageFromJson(Map<String, dynamic> json) =>
    PayReceiptImage(
      receiptLineList: json['ReceiptLine'] as List<dynamic>?,
    );

Map<String, dynamic> _$PayReceiptImageToJson(PayReceiptImage instance) =>
    <String, dynamic>{
      'ReceiptLine': instance.receiptLineList,
    };

PayRetailTransaction _$PayRetailTransactionFromJson(
        Map<String, dynamic> json) =>
    PayRetailTransaction(
      lineItem: json['LineItem'] == null
          ? null
          : PayLineItem.fromJson(json['LineItem'] as Map<String, dynamic>),
      totalList: json['Total'] as List<dynamic>?,
      customer: json['Customer'] as String?,
    );

Map<String, dynamic> _$PayRetailTransactionToJson(
        PayRetailTransaction instance) =>
    <String, dynamic>{
      'LineItem': instance.lineItem,
      'Total': instance.totalList,
      'Customer': instance.customer,
    };

PayLineItem _$PayLineItemFromJson(Map<String, dynamic> json) => PayLineItem(
      saleList: json['Sale'] as List<dynamic>?,
    );

Map<String, dynamic> _$PayLineItemToJson(PayLineItem instance) =>
    <String, dynamic>{
      'Sale': instance.saleList,
    };

PayTRKReceiptImage _$PayTRKReceiptImageFromJson(Map<String, dynamic> json) =>
    PayTRKReceiptImage(
      lineSpace: json['LineSpace'] as int?,
      printType: json['PrintType'] as String?,
      cutType: json['CutType'] as String?,
      receiptLineList: json['ReceiptLine'] as List<dynamic>?,
      pageParts: json['PageParts'] == null
          ? null
          : PayPageParts.fromJson(json['PageParts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayTRKReceiptImageToJson(PayTRKReceiptImage instance) =>
    <String, dynamic>{
      'LineSpace': instance.lineSpace,
      'PrintType': instance.printType,
      'CutType': instance.cutType,
      'ReceiptLine': instance.receiptLineList,
      'PageParts': instance.pageParts,
    };

PayPageParts _$PayPagePartsFromJson(Map<String, dynamic> json) => PayPageParts(
      width: json['Width'] as int?,
      height: json['Height'] as int?,
      direction: json['Direction'] as String?,
      rotate: json['Rotate'] as String?,
      partsDataList: (json['PartsList'] as List<dynamic>?)
          ?.map((e) => PayPartsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PayPagePartsToJson(PayPageParts instance) =>
    <String, dynamic>{
      'Width': instance.width,
      'Height': instance.height,
      'Direction': instance.direction,
      'Rotate': instance.rotate,
      'PartsList': instance.partsDataList,
    };

PayPartsData _$PayPartsDataFromJson(Map<String, dynamic> json) => PayPartsData(
      partsType: json['PartsType'] as String?,
      startX: json['StartX'] as int?,
      startY: json['StartY'] as int?,
      endX: json['EndX'] as int?,
      endY: json['EndY'] as int?,
      font: json['Font'] as String?,
      scale: json['Scale'] as String?,
      text: json['Text'] as String?,
      lineStyle: json['LineStyle'] as String?,
      fileName: json['FileName'] as String?,
      barcodeData: json['BarcodeData'] as String?,
      barcodeType: json['BarcodeType'] as String?,
      hriPosition: json['HriPosition'] as String?,
    );

Map<String, dynamic> _$PayPartsDataToJson(PayPartsData instance) =>
    <String, dynamic>{
      'PartsType': instance.partsType,
      'StartX': instance.startX,
      'StartY': instance.startY,
      'EndX': instance.endX,
      'EndY': instance.endY,
      'Font': instance.font,
      'Scale': instance.scale,
      'Text': instance.text,
      'LineStyle': instance.lineStyle,
      'FileName': instance.fileName,
      'BarcodeData': instance.barcodeData,
      'BarcodeType': instance.barcodeType,
      'HriPosition': instance.hriPosition,
    };

CashChaChkAmtData _$CashChaChkAmtDataFromJson(Map<String, dynamic> json) =>
    CashChaChkAmtData(
      totalAmt: json['TotalAmt'] as int?,
      loanAmt: json['LoanAmt'] as int?,
      inAmt: json['InAmt'] as int?,
      outAmt: json['OutAmt'] as int?,
      pickAmt: json['PickAmt'] as int?,
      otherAmt: json['OtherAmt'] as int?,
    );

Map<String, dynamic> _$CashChaChkAmtDataToJson(CashChaChkAmtData instance) =>
    <String, dynamic>{
      'TotalAmt': instance.totalAmt,
      'LoanAmt': instance.loanAmt,
      'InAmt': instance.inAmt,
      'OutAmt': instance.outAmt,
      'PickAmt': instance.pickAmt,
      'OtherAmt': instance.otherAmt,
    };

PaychkData _$PaychkDataFromJson(Map<String, dynamic> json) => PaychkData(
      groupID: json['GroupID'] as int?,
      code: json['Code'] as int?,
      name: json['Name'] as String?,
      order: json['Order'] as int?,
      theoryAmt: json['TheoryAmt'] as int?,
      loanAmt: json['LoanAmt'] as int?,
      inAmt: json['InAmt'] as int?,
      outAmt: json['OutAmt'] as int?,
      pickAmt: json['PickAmt'] as int?,
    );

Map<String, dynamic> _$PaychkDataToJson(PaychkData instance) =>
    <String, dynamic>{
      'GroupID': instance.groupID,
      'Code': instance.code,
      'Name': instance.name,
      'Order': instance.order,
      'TheoryAmt': instance.theoryAmt,
      'LoanAmt': instance.loanAmt,
      'InAmt': instance.inAmt,
      'OutAmt': instance.outAmt,
      'PickAmt': instance.pickAmt,
    };

GetClassInfo _$GetClassInfoFromJson(Map<String, dynamic> json) => GetClassInfo(
      retSts: json['RetSts'] as int?,
      errMsg: json['ErrMsg'] as String?,
      lastUpdated: json['LastUpdated'] as String?,
      clsList: (json['ClsList'] as List<dynamic>?)
          ?.map((e) => ClsListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetClassInfoToJson(GetClassInfo instance) =>
    <String, dynamic>{
      'RetSts': instance.retSts,
      'ErrMsg': instance.errMsg,
      'LastUpdated': instance.lastUpdated,
      'ClsList': instance.clsList,
    };

ClsListData _$ClsListDataFromJson(Map<String, dynamic> json) => ClsListData(
      code: json['Code'] as int?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$ClsListDataToJson(ClsListData instance) =>
    <String, dynamic>{
      'Code': instance.code,
      'Name': instance.name,
    };
