/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:json_annotation/json_annotation.dart';

part 'calc_api_data.g.dart';

/// レジ開設のリクエストパラメータ
/// レジ精算のリクエストパラメータ
class CalcRequestStore {
  /// 企業コード
  int compCd;

  /// 店舗コード
  int streCd;

  /// マシン番号
  int macNo;

  /// 営業日
  String saleDate;

  /// 同一営業日で再度開設をする
  int? again;

  CalcRequestStore({
    required this.compCd,
    required this.streCd,
    required this.macNo,
    required this.saleDate,
    this.again = null,
  });
}

/// 従業員オープンのリクエストパラメータ
/// 従業員クローズ"のリクエストパラメータ
class CalcRequestStaff {
  /// 企業コード
  int compCd;

  /// 店舗コード
  int streCd;

  /// マシン番号
  int macNo;

  /// 従業員番号
  String staffCd;

  /// 従業員パスワード
  String passwd;

  /// バーコードスキャンしたときのフラグ   0: 手入力 1:スキャニング
  int? scanFlag;

  /// チェッカーフラグ
  int? checkerFlag;

  CalcRequestStaff({
    required this.compCd,
    required this.streCd,
    required this.macNo,
    required this.staffCd,
    this.passwd = "",
    this.scanFlag = null,
    this.checkerFlag = null,
  });
}

/// 商品情報の呼出のリクエストパラメータ
/// 売価チェックのリクエストパラメータ
@JsonSerializable()
class CalcRequestParaItem {
  /// 企業コード
  @JsonKey(name: 'CompCd')
  int compCd;

  /// 店舗コード
  @JsonKey(name: 'StreCd')
  int streCd;

  /// 商品情報リスト
  @JsonKey(name: 'ItemList')
  List<ItemData> itemList = <ItemData>[];

  /// 顧客コード
  @JsonKey(name: 'CustCode')
  String custCode;

  /// 小計値下情報
  @JsonKey(name: 'SubttlList')
  List<SubttlData> subttlList = <SubttlData>[];

  /// マシン番号
  @JsonKey(name: 'MacNo')
  int? macNo;

  /// 取引別のUUID
  @JsonKey(name: 'Uuid')
  String uuid;

  /// オペモード
  @JsonKey(name: 'OpeMode')
  int? opeMode;

  /// 返品操作フラグ
  @JsonKey(name: 'RefundFlag')
  int? refundFlag;

  /// 価格セットモード
  @JsonKey(name: 'PriceMode')
  int? priceMode;

  /// POS動作仕様
  @JsonKey(name: 'PosSpec')
  int? posSpec;

  /// ユーザ別情報
  @JsonKey(name: 'ArcsInfo')
  ArcsInfo? arcsInfo;

  CalcRequestParaItem({
    required this.compCd,
    required this.streCd,
    this.custCode = "",
    this.macNo = null,
    this.uuid = "",
    this.opeMode = null,
    this.refundFlag = null,
    this.priceMode = null,
    this.arcsInfo
  });
  factory CalcRequestParaItem.fromJson(Map<String, dynamic> json) => _$CalcRequestParaItemFromJson(json);
  Map<String, dynamic> toJson() => _$CalcRequestParaItemToJson(this);
}

/// 支払操作のリクエストパラメータ
/// 支払確認のリクエストパラメータ
/// 再発行のリクエストパラメータ
/// 領収書のリクエストパラメータ
/// 取引リセットのリクエストパラメータ
@JsonSerializable()
class CalcRequestParaPay {
  /// 企業コード
  @JsonKey(name: 'CompCd')
  int compCd;

  /// 店舗コード
  @JsonKey(name: 'StreCd')
  int streCd;

  /// 商品情報リスト
  @JsonKey(name: 'ItemList')
  List<ItemData> itemList = <ItemData>[];

  /// 顧客コード
  @JsonKey(name: 'CustCode')
  String custCode;

  /// 小計値下情報
  @JsonKey(name: 'SubttlList')
  List<SubttlData> subttlList = <SubttlData>[];

  /// マシン番号
  @JsonKey(name: 'MacNo')
  int? macNo;

  /// 取引別のUUID
  @JsonKey(name: 'Uuid')
  String uuid;

  /// 支払情報リスト
  @JsonKey(name: 'PayList', defaultValue: <PayData>[])
  List<PayData> payList = <PayData>[];

  /// オペモード
  @JsonKey(name: 'OpeMode')
  int? opeMode;

  /// 返品操作フラグ
  @JsonKey(name: 'RefundFlag')
  int? refundFlag;

  /// 返品操作日（YYYY-MM-DD）
  @JsonKey(name: 'RefundDate')
  String refundDate;

  /// 価格セットモード
  @JsonKey(name: 'PriceMode')
  int? priceMode;

  /// POS動作仕様
  @JsonKey(name: 'PosSpec')
  int? posSpec;

  /// ユーザ別情報
  @JsonKey(name: 'ArcsInfo')
  ArcsInfo? arcsInfo;

  /// 送信先レジ番号
  @JsonKey(name: 'QcSendMacNo')
  int? qcSendMacNo;

  /// 送信先レジ名称							
  @JsonKey(name: 'QcSendMacName')
  String? qcSendMacName;
  

  CalcRequestParaPay({
    required this.compCd,
    required this.streCd,
    this.custCode = "",
    this.macNo = null,
    this.uuid = "",
    this.opeMode = null,
    this.refundFlag = null,
    this.refundDate = "",
    this.priceMode = null,
    this.posSpec = null,
    this.arcsInfo,
    this.qcSendMacNo = null,
    this.qcSendMacName = null,
  });
  factory CalcRequestParaPay.fromJson(Map<String, dynamic> json) => _$CalcRequestParaPayFromJson(json);
  Map<String, dynamic> toJson() => _$CalcRequestParaPayToJson(this);
}

/// 訂正操作のリクエストパラメータ
class CalcRequestParaVoid {
  /// 企業コード
  int compCd;

  /// 店舗コード
  int streCd;

  /// マシン番号
  int macNo;

  /// 取引別のUUID
  String uuid;

  /// オペモード
  int opeMode;

  /// 訂正レジ番号
  int voidMacNo;

  /// 訂正営業日
  String voidSaleDate;

  /// 訂正レシート番号
  int voidReceiptNo;

  /// 訂正ジャーナル番号
  int voidPrintNo;

  /// 訂正伝票番号
  String? voidPosReceiptNo;

  /// 支払情報リスト
  List<PayVoidData> payVoidList = <PayVoidData>[];

  CalcRequestParaVoid({
    required this.compCd,
    required this.streCd,
    required this.macNo,
    required this.uuid,
    required this.opeMode,
    required this.voidMacNo,
    required this.voidSaleDate,
    required this.voidReceiptNo,
    required this.voidPrintNo,
    required this.voidPosReceiptNo,
    required this.payVoidList,
  });
}

/// 訂正確認のリクエストパラメータ
class CalcRequestParaVoidSearch {
  /// 企業コード
  int compCd;

  /// 店舗コード
  int streCd;

  /// マシン番号
  int macNo;

  /// 取引別のUUID
  String uuid;

  /// オペモード
  int opeMode;

  /// 訂正レジ番号
  int voidMacNo;

  /// 訂正営業日
  String voidSaleDate;

  /// 訂正レシート番号
  int voidReceiptNo;

  /// 訂正ジャーナル番号
  int? voidPrintNo;

  /// 訂正取引金額
  int? voidAmt;

  CalcRequestParaVoidSearch({
    required this.compCd,
    required this.streCd,
    required this.macNo,
    required this.uuid,
    required this.opeMode,
    required this.voidMacNo,
    required this.voidSaleDate,
    required this.voidReceiptNo,
    required this.voidPrintNo,
    required this.voidAmt,
  });
}

/// 差異チェックのリクエストパラメータ
class CalcRequestDrwchk {
  /// 企業コード
  int compCd;

  /// 店舗コード
  int streCd;

  /// マシン番号
  int macNo;

  /// オペモード
  int? opeMode;

  InoutInfo? inoutInfo;

  CalcRequestDrwchk({
    required this.compCd,
    required this.streCd,
    required this.macNo,
    this.opeMode = null,
    this.inoutInfo = null,
  });
}

/// 釣準備のリクエストパラメータ
/// 売上回収のリクエストパラメータ
class CalcRequestPick {
  /// 企業コード
  int compCd;

  /// 店舗コード
  int streCd;

  /// マシン番号
  int macNo;

  /// オペモード
  int? opeMode;
  InoutInfo? inoutInfo;

  /// 金種別登録を「する」ときにセット
  List<PickPayData> payList = <PickPayData>[];

  CalcRequestPick({
    required this.compCd,
    required this.streCd,
    required this.macNo,
    this.opeMode = null,
    this.inoutInfo = null,
  });
}

/// 入金のリクエストパラメータ
/// 支払のリクエストパラメータ
/// 釣機参照のリクエストパラメータ
/// 釣機回収のリクエストパラメータ
class CalcRequestParaChanger {
  /// 企業コード
  int compCd;

  /// 店舗コード
  int streCd;

  /// マシン番号
  int macNo;

  /// オペモード
  int? opeMode;

  /// 金種別登録を「する」ときにセット
  InoutInfo? inoutInfo;

  CalcRequestParaChanger({
    required this.compCd,
    required this.streCd,
    required this.macNo,
    this.opeMode,
    this.inoutInfo,
  });
}

/// 前さばき(呼出)のリクエストパラメータ
class CalcRequestCustomercardLoad {
  /// 企業コード
  int compCd;

  /// 店舗コード
  int streCd;

  /// バーコード18桁の情報
  String customerCard;

  CalcRequestCustomercardLoad({
    required this.compCd,
    required this.streCd,
    required this.customerCard,
  });
}

/// 前さばき(削除)のリクエストパラメータ
class CalcRequestCustomercardDel {
  /// 企業コード
  int compCd;

  /// 店舗コード
  int streCd;

  /// バーコード18桁の情報
  String customerCard;

  /// レジ番号
  int macNo;

  CalcRequestCustomercardDel({
    required this.compCd,
    required this.streCd,
    required this.customerCard,
    required this.macNo,
  });
}

/// 前さばき(保存)のリクエストパラメータ
class CalcRequestCustomercardSave {
  /// 企業コード
  int compCd;

  /// 店舗コード
  int streCd;

  /// 商品情報リスト
  List<ItemData> itemList;

  /// 顧客コード
  String custCode;

  /// マシン番号
  int? macNo;

  /// 取引別のUUID
  String uuid;

  /// オペモード
  int? opeMode;

  /// バーコード18桁の情報
  String customerCard;

  CalcRequestCustomercardSave({
    required this.compCd,
    required this.streCd,
    required this.itemList,
    required this.customerCard,
    this.custCode = "",
    this.macNo = null,
    this.uuid = "",
    this.opeMode = null,
  });
}

/// 検索領収書のリクエストパラメータ
class CalcRequestParaSearchReceipt {
  /// 企業コード
  int compCd;

  /// 店舗コード
  int streCd;

  /// マシン番号
  int macNo;

  /// 取引別のUUID
  String uuid;

  /// オペモード
  int opeMode;

  /// 発行したいレジ番号
  int voidMacNo;

  /// 発行したい営業日
  String voidSaleDate;

  /// 発行したいレシート番号
  int voidReceiptNo;

  /// 発行したいジャーナル番号
  int voidPrintNo;

  /// 過去テーブルセットのフラグ
  int voidPastSet;

  CalcRequestParaSearchReceipt({
    required this.compCd,
    required this.streCd,
    required this.macNo,
    required this.uuid,
    required this.opeMode,
    required this.voidMacNo,
    required this.voidSaleDate,
    required this.voidReceiptNo,
    required this.voidPrintNo,
    required this.voidPastSet,
  });
}

/// 商品情報リスト
@JsonSerializable()
class ItemData {
  /// 登録番号
  @JsonKey(name: 'rSeqNo')
  int seqNo;

  /// 登録点数
  @JsonKey(name: 'rQty')
  int qty;

  /// 0:通常　1:取消　2:カゴ抜け
  @JsonKey(name: 'rType')
  int type;

  /// バーコード１段目
  @JsonKey(name: 'rBarcode1')
  String barcode1;

  /// バーコード２段目
  @JsonKey(name: 'rBarcode2')
  String barcode2;

  /// スキャン時間（YYYY-MM-DD HH:MM:SS）
  @JsonKey(name: 'rCnctTime')
  String cnctTime;

  /// 値下タイプ
  @JsonKey(name: 'rItemDscType')
  int? itemDscType;

  /// 値下額
  @JsonKey(name: 'rItemDscVal')
  int? itemDscVal;

  /// 値下コード
  @JsonKey(name: 'rItemDscCode')
  int? itemDscCode;

  /// 売価変更金額
  @JsonKey(name: 'rPrcChgVal')
  int? prcChgVal;

  /// 分類登録時のコード
  @JsonKey(name: 'rClsNo')
  int clsNo;

  /// 分類登録時の金額
  @JsonKey(name: 'rClsVal')
  int? clsVal;

  /// 小数点登録値　　小数点以下2桁まで
  @JsonKey(name: 'rDecimalVal')
  String decimalVal;

  /// 税変換キーコード
  @JsonKey(name: 'rTaxChgCode')
  int? taxChgCode;

  ItemData({
    required this.seqNo,
    required this.qty,
    required this.type,
    required this.barcode1,
    required this.cnctTime,
    required this.clsNo,
    required this.clsVal,
    this.barcode2 = "",
    this.itemDscType = null,
    this.itemDscVal = null,
    this.itemDscCode = null,
    this.prcChgVal = null,
    this.decimalVal = "",
    this.taxChgCode = null,
  });

  factory ItemData.fromJson(Map<String, dynamic> json) => _$ItemDataFromJson(json);
  Map<String, dynamic> toMap() =>
      {
        'rSeqNo': seqNo,
        'rQty': qty,
        'rType': type,
        'rBarcode1': barcode1,
        'rBarcode2': barcode2,
        'rCnctTime': cnctTime,
        'rItemDscType': itemDscType,
        'rItemDscVal': itemDscVal,
        'rItemDscCode': itemDscCode,
        'rPrcChgVal': prcChgVal,
        'rClsNo': clsNo,
        'rClsVal': clsVal,
        'rDecimalVal': decimalVal,
        'rTaxChgCode': taxChgCode,
      };

  // TODO:00015 江原 json-annotationライブラリの自動生成の都合で追加。toMapと同じため、不都合なければ上記は削除する
  Map<String, dynamic> toJson() => _$ItemDataToJson(this);
}


/// 予約レポートの出力のリクエストデータ
@JsonSerializable()
class CalcRequestBatchReport {
  /// 企業コード
  @JsonKey(name: 'rCompCd')
  int? compCd;

  /// 店舗コード
  @JsonKey(name: 'rStreCd')
  int? streCd;

  /// マシン番号
  @JsonKey(name: 'rMacNo')
  int? macNo;

  /// 営業日（YYYY/MM/DD）
  @JsonKey(name: 'rSaleDate')
  String? saleDate;

  /// 予約グループ番号
  @JsonKey(name: 'rBatchGrpCd')
  int? batchGrpCd;

  /// 予約番号
  @JsonKey(name: 'rBatchNo')
  int? batchNo;

  /// 予約番号の印字順
  @JsonKey(name: 'rBatchOrder')
  int? batchOrder;

  CalcRequestBatchReport({
    required this.compCd,
    required this.streCd,
    required this.macNo,
    required this.saleDate,
    required this.batchGrpCd,
    required this.batchNo,
    required this.batchOrder,
  });

  factory CalcRequestBatchReport.fromJson(Map<String, dynamic> json) => _$CalcRequestBatchReportFromJson(json);
  Map<String, dynamic> toJson() => _$CalcRequestBatchReportToJson(this);
}

/// 小計値下情報
@JsonSerializable()
class SubttlData {
  /// 小計値下のキーコード
  @JsonKey(name: 'rStlDscCode')
  int? stlDscCode;

  /// 小計値下の値引額/割引率/割増率
  @JsonKey(name: 'rStlDscVal')
  int? stlDscVal;

  SubttlData({
    this.stlDscCode = null,
    this.stlDscVal = null,
  });

  factory SubttlData.fromMap(Map<String, dynamic> map) =>
      SubttlData(
        stlDscCode: map['rStlDscCode'],
        stlDscVal: map['rStlDscVal'],
      );

  Map<String, dynamic> toMap() =>
      {
        'rStlDscCode': stlDscCode,
        'rStlDscVal': stlDscVal,
      };

  // TODO:00015 江原 json-annotationライブラリの自動生成の都合で追加。fromMap、toMapと同じため、不都合なければ上記は削除する
  factory SubttlData.fromJson(Map<String, dynamic> json) => _$SubttlDataFromJson(json);
  Map<String, dynamic> toJson() => _$SubttlDataToJson(this);
}

/// 支払情報リスト
@JsonSerializable()
class PayData {
  /// 支払キーコード
  @JsonKey(name: 'rPayCode')
  int payCode;

  /// 支払金額
  @JsonKey(name: 'rAmount')
  int amount;

  /// 枚数
  @JsonKey(name: 'rSheet')
  int? sheet;

  /// クレジット通番カウンタ
  @JsonKey(name: 'rCreditNo')
  String? creditNo;

  /// 入力方法
  @JsonKey(name: 'rDataDivision')
  String? dataDivision;

  /// サインレスフラグ
  @JsonKey(name: 'rTotalLevel')
  String? totalLevel;

  /// 支払い区分
  @JsonKey(name: 'rTranDivision')
  String? tranDivision;

  /// 分割回数
  @JsonKey(name: 'rDivideCount')
  String? divideCount;

  /// カード番号
  @JsonKey(name: 'rMemberCode')
  String? memberCode;

  /// ご利用日
  @JsonKey(name: 'rSaleyymmdd')
  String? saleyymmdd;

  /// 支払い金額
  @JsonKey(name: 'rSaleAmount')
  String? saleAmount;

  /// 承認番号
  @JsonKey(name: 'rRecognizeNo')
  String? recognizeNo;

  /// 有効期限　yymm
  @JsonKey(name: 'rGoodThru')
  String? goodThru;

  /// 端末識別コード
  @JsonKey(name: 'rPosRecognizeNo')
  String? posRecognizeNo;

  /// 端末処理通番
  @JsonKey(name: 'rPosReceiptNo')
  String? posReceiptNo;

  /// その他
  @JsonKey(name: 'rChaCount1')
  String? chaCount1;

  /// その他
  @JsonKey(name: 'rChaAmount1')
  String? chaAmount1;

  /// その他
  @JsonKey(name: 'rChaCount2')
  String? chaCount2;

  /// その他
  @JsonKey(name: 'rChaAmount2')
  String? chaAmount2;

  /// その他
  @JsonKey(name: 'rChaCount3')
  String? chaCount3;

  /// その他
  @JsonKey(name: 'rChaAmount3')
  String? chaAmount3;

  /// その他
  @JsonKey(name: 'rChaCount7')
  String? chaCount7;

  /// その他
  @JsonKey(name: 'rChaAmount7')
  String? chaAmount7;

  /// カード種別
  @JsonKey(name: 'rSellKind')
  String? sellKind;

  /// 問合通番
  @JsonKey(name: 'rSeqInqNo')
  String? seqInqNo;

  /// 商品コード
  @JsonKey(name: 'rChargeCheckNo')
  String? chargeCheckNo;

  /// 元伝票番号
  @JsonKey(name: 'rCancelSlipNo')
  String? cancelSlipNo;

  /// 要求コード
  @JsonKey(name: 'rReqCode')
  String? reqCode;
  @JsonKey(name: 'rCardJis1')
  String? cardJis1;
  @JsonKey(name: 'rCardJis2')
  String? cardJis2;

  ///取扱区分
  @JsonKey(name: 'rHandleDivide')
  String? handleDivide;

  /// 支払い内容
  @JsonKey(name: 'rPayAWay')
  String? payAWay;

  @JsonKey(name: 'rCardName')
  String? cardName;

  PayData({
    required this.payCode,
    required this.amount,
    this.sheet,
    this.creditNo,
    this.dataDivision,
    this.totalLevel,
    this.tranDivision,
    this.divideCount,
    this.memberCode,
    this.saleyymmdd,
    this.saleAmount,
    this.recognizeNo,
    this.goodThru,
    this.posRecognizeNo,
    this.posReceiptNo,
    this.chaCount1,
    this.chaAmount1,
    this.chaCount2,
    this.chaAmount2,
    this.chaCount3,
    this.chaAmount3,
    this.chaCount7,
    this.chaAmount7,
    this.sellKind,
    this.seqInqNo,
    this.chargeCheckNo,
    this.cancelSlipNo,
    this.reqCode,
    this.cardJis1,
    this.cardJis2,
    this.handleDivide,
    this.payAWay,
    this.cardName,
  });

  factory PayData.fromJson(Map<String, dynamic> json) => _$PayDataFromJson(json);
  Map<String, dynamic> toJson() => _$PayDataToJson(this);
}

/// 支払情報(Void)リスト
class PayVoidData {
  /// クレジット通番カウンタ
  String? creditNo;

  /// 入力方法
  String? dataDivision;

  /// サインレスフラグ
  String? totalLevel;

  /// 支払い区分
  String? tranDivision;

  /// 分割回数
  String? divideCount;

  /// カード番号
  String? memberCode;

  /// ご利用日
  String? saleyymmdd;

  /// 支払い金額
  String? saleAmount;

  /// 承認番号
  String? recognizeNo;

  /// 有効期限　yymm
  String? goodThru;

  /// 端末識別コード
  String? posRecognizeNo;

  /// 端末処理通番
  String? posReceiptNo;

  /// その他
  String? chaCount1;

  /// その他
  String? chaAmount1;

  /// その他
  String? chaCount2;

  /// その他
  String? chaAmount2;

  /// その他
  String? chaCount3;

  /// その他
  String? chaAmount3;

  /// その他
  String? chaCount7;

  /// その他
  String? chaAmount7;

  /// カード種別
  String? sellKind;

  /// 問合通番
  String? seqInqNo;

  /// 商品コード
  String? chargeCheckNo;

  /// 元伝票番号
  String? cancelSlipNo;

  /// 要求コード
  String? reqCode;
  String? cardJis1;
  String? cardJis2;

  ///取扱区分
  String? handleDivide;

  /// 支払い内容
  String? payAWay;

  String? cardName;

  PayVoidData({
    this.creditNo,
    this.dataDivision,
    this.totalLevel,
    this.tranDivision,
    this.divideCount,
    this.memberCode,
    this.saleyymmdd,
    this.saleAmount,
    this.recognizeNo,
    this.goodThru,
    this.posRecognizeNo,
    this.posReceiptNo,
    this.chaCount1,
    this.chaAmount1,
    this.chaCount2,
    this.chaAmount2,
    this.chaCount3,
    this.chaAmount3,
    this.chaCount7,
    this.chaAmount7,
    this.sellKind,
    this.seqInqNo,
    this.chargeCheckNo,
    this.cancelSlipNo,
    this.reqCode,
    this.cardJis1,
    this.cardJis2,
    this.handleDivide,
    this.payAWay,
    this.cardName,
  });

  factory PayVoidData.fromMap(Map<String, dynamic> map) =>
      PayVoidData(
        creditNo: map['rCreditNo'],
        dataDivision: map['rDataDivision'],
        totalLevel: map['rTotalLevel'],
        tranDivision: map['rTranDivision'],
        divideCount: map['rDivideCount'],
        memberCode: map['rMemberCode'],
        saleyymmdd: map['rSaleyymmdd'],
        saleAmount: map['rSaleAmount'],
        recognizeNo: map['rRecognizeNo'],
        goodThru: map['rGoodThru'],
        posRecognizeNo: map['rPosRecognizeNo'],
        posReceiptNo: map['rPosReceiptNo'],
        chaCount1: map['rChaCount_1'],
        chaAmount1: map['rChaAmount_1'],
        chaCount2: map['rChaCount_2'],
        chaAmount2: map['rChaAmount_2'],
        chaCount3: map['rChaCount_3'],
        chaAmount3: map['rChaAmount_3'],
        chaCount7: map['rChaCount_7'],
        chaAmount7: map['rChaAmount_7'],
        sellKind: map['rSellKind'],
        seqInqNo: map['rSeqInqNo'],
        chargeCheckNo: map['rChangeCheckNo'],
        cancelSlipNo: map['rCancelSlipNo'],
        reqCode: map['rReqCode'],
        cardJis1: map['rCardJis_1'],
        cardJis2: map['rCardJis_2'],
        handleDivide: map['rHandleDivide'],
        payAWay: map['rPayAWay'],
        cardName: map['rCardName'],
      );

  Map<String, dynamic> toMap() =>
      {
        'rCreditNo': creditNo,
        'rDataDivision': dataDivision,
        'rTotalLevel': totalLevel,
        'rTranDivision': tranDivision,
        'rDivideCount': divideCount,
        'rMemberCode': memberCode,
        'rSaleyymmdd': saleyymmdd,
        'rSaleAmount': saleAmount,
        'rRecognizeNo': recognizeNo,
        'rGoodThru': goodThru,
        'rPosRecognizeNo': posRecognizeNo,
        'rPosReceiptNo': posReceiptNo,
        'rChaCount_1': chaCount1,
        'rChaAmount_1': chaAmount1,
        'rChaCount_2': chaCount2,
        'rChaAmount_2': chaAmount2,
        'rChaCount_3': chaCount3,
        'rChaAmount_3': chaAmount3,
        'rChaCount_7': chaCount7,
        'rChaAmount_7': chaAmount7,
        'rSellKind': sellKind,
        'rSeqInqNo': seqInqNo,
        'rChangeCheckNo': chargeCheckNo,
        'rCancelSlipNo': cancelSlipNo,
        'rReqCode': reqCode,
        'rCardJis_1': cardJis1,
        'rCardJis_2': cardJis2,
        'rHandleDivide': handleDivide,
        'rPayAWay': payAWay,
        'rCardName': cardName,
      };
}

/// ユーザ別情報
@JsonSerializable()
class ArcsInfo {
  @JsonKey(name: 'rCustType')
  int? custType;
  @JsonKey(name: 'rWorkType')
  int? workType;

  ArcsInfo({
    this.custType,
    this.workType,
  });

  factory ArcsInfo.fromMap(Map<String, dynamic> map) =>
      ArcsInfo(
        custType: map['rCustType'],
        workType: map['rWorkType'],
      );

  Map<String, dynamic> toMap() =>
      {
        'rCustType': custType,
        'rWorkType': workType,
      };
  
  // TODO:00015 江原 json-annotationライブラリの自動生成の都合で追加。fromMap、toMapと同じため、不都合なければ上記は削除する
  factory ArcsInfo.fromJson(Map<String, dynamic> json) => _$ArcsInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ArcsInfoToJson(this);
}

/// 金種別登録を「する」ときにセット
class PickPayData {
  /// 支払コード
  int? code;

  /// 回収金額
  int? pickAmount;

  PickPayData({
    this.code = null,
    this.pickAmount = null,
  });

  factory PickPayData.fromMap(Map<String, dynamic> map) =>
      PickPayData(
        code: map['rCode'],
        pickAmount: map['rPickAmount'],
      );

  Map<String, dynamic> toMap() =>
      {
        'rCode': code,
        'rPickAmount': pickAmount,
      };
}

/// InoutInfo
class InoutInfo {
  /// 一括入力金額（円）
  int? amtTotal;
  /// 金種別登録時の10000円の枚数
  int? sht10000;
  /// 金種別登録時の5000円の枚数
  int? sht05000;
  /// 金種別登録時の2000円の枚数
  int? sht02000;
  /// 金種別登録時の1000円の枚数
  int? sht01000;
  /// 金種別登録時の500円の枚数
  int? sht00500;
  /// 金種別登録時の100円の枚数
  int? sht00100;
  /// 金種別登録時の50円の枚数
  int? sht00050;
  /// 金種別登録時の10円の枚数
  int? sht00010;
  /// 金種別登録時の5円の枚数
  int? sht00005;
  /// 金種別登録時の1円の枚数
  int? sht00001;
  /// 釣機収納庫枚数　１００００円
  int? stockSht10000;
  /// 釣機収納庫枚数　５０００円
  int? stockSht05000;
  /// 釣機収納庫枚数　２０００円
  int? stockSht02000;
  /// 釣機収納庫枚数　１０００円
  int? stockSht01000;
  /// 釣機収納庫枚数　５００円
  int? stockSht00500;
  /// 釣機収納庫枚数　１００円
  int? stockSht00100;
  /// 釣機収納庫枚数　５０円
  int? stockSht00050;
  /// 釣機収納庫枚数　１０円
  int? stockSht00010;
  /// 釣機収納庫枚数　５円
  int? stockSht00005;
  /// 釣機収納庫枚数　１円
  int? stockSht00001;
  /// 釣機金庫枚数　　１００００円
  int? stockPolSht10000;
  /// 釣機金庫枚数　　５０００円
  int? stockPolSht05000;
  /// 釣機金庫枚数　　２０００円
  int? stockPolSht02000;
  /// 釣機金庫枚数　　１０００円
  int? stockPolSht01000;
  /// 釣機金庫枚数　　５００円
  int? stockPolSht00500;
  /// 釣機金庫枚数　　１００円
  int? stockPolSht00100;
  /// 釣機金庫枚数　　５０円
  int? stockPolSht00050;
  /// 釣機金庫枚数　　１０円
  int? stockPolSht00010;
  /// 釣機金庫枚数　　５円
  int? stockPolSht00005;
  /// 釣機金庫枚数　　１円
  int? stockPolSht00001;
  /// 釣銭機金庫枚数　その他
  int? stockPolShtOth;
  /// 釣札機回収予備枚数
  int? stockPolShtFil;
  /// 釣札機収納部リジェクト回数
  int? stockRjct;
  /// 釣銭機硬貨投入部情報
  int? coinSlot;
  /// 釣機在高取得日時
  String? stockGetDate;
  /// 釣機在高不確定情報
  int? stockStateErrCode;
  /// 差異チェック入力データ反映フラグ
  int? drwChkPickFlg;
  /// ファンクションキーコード
  int? fncCode;
  /// 区分
  int? divCode;
  /// 入金理由名称
  String? divName;
  /// お預り
  int? tendData;
  /// お釣り
  int? changeData;
  /// 金種10000円枚数（出金用）
  int? outSht10000;
  /// 金種5000円枚数（出金用）
  int? outSht05000;
  /// 金種2000円枚数（出金用）
  int? outSht02000;
  /// 金種1000円枚数（出金用）
  int? outSht01000;
  /// 金種500円枚数（出金用）
  int? outSht00500;
  /// 金種100円枚数（出金用）
  int? outSht00100;
  /// 金種50円枚数（出金用）
  int? outSht00050;
  /// 金種10円枚数（出金用）
  int? outSht00010;
  /// 金種5円枚数（出金用）
  int? outSht00005;
  /// 金種1円枚数（出金用）
  int? outSht00001;
  /// 釣機両替出金額
  int? chgPtnOutPrice;
  /// 発行番号
  String? recycleNo;
  /// 操作従業員番号
  String? recycleStaffNo;
  /// 事務所指示金額
  int? recycleOfficeTtlAmt;
  /// 入金レジ番号　　　
  int? recycleInMacNo;
  /// 出金レジ番号　　　
  int? recycleOutMacNo;
  /// 入出金フラグ　　　　
  int? recycleInOutType;
  /// 両替フラグ　　　　　
  int? recycleExchgFlg;
  /// 再入金　　　　　　　
  int? recycleRein;
  /// 入金差異フラグ
  int? recycleInDiff;
  /// 両替出金額
  int? recycleChgOutAmt;
  /// 入出金額
  int? recycleTtlAmt;
  /// 事務所指示10000円枚数
  int? recycleOfficeSht10000;
  /// 事務所指示5000円枚数
  int? recycleOfficeSht05000;
  /// 事務所指示2000円枚数
  int? recycleOfficeSht02000;
  /// 事務所指示1000円枚数
  int? recycleOfficeSht01000;
  /// 事務所指示500円枚数
  int? recycleOfficeSht00500;
  /// 事務所指示100円枚数
  int? recycleOfficeSht00100;
  /// 事務所指示50円枚数
  int? recycleOfficeSht00050;
  /// 事務所指示10円枚数
  int? recycleOfficeSht00010;
  /// 事務所指示5円枚数
  int? recycleOfficeSht00005;
  /// 事務所指示1円枚数
  int? recycleOfficeSht00001;
  /// 入出金10000円枚数
  int? recycleSht10000;
  /// 入出金5000円枚数
  int? recycleSht05000;
  /// 入出金2000円枚数
  int? recycleSht02000;
  /// 入出金1000円枚数
  int? recycleSht01000;
  /// 入出金500円枚数
  int? recycleSht00500;
  /// 入出金100円枚数
  int? recycleSht00100;
  /// 入出金50円枚数
  int? recycleSht00050;
  /// 入出金10円枚数
  int? recycleSht00010;
  /// 入出金5円枚数
  int? recycleSht00005;
  /// 入出金1円枚数
  int? recycleSht00001;
  /// 入出金回数
  int? recycleInOutCnt;
  /// 回収方法選択ボタン
  int? pickBtn;
  /// 改修カセット金額
  int? pickCassette;
  /// 回収前釣機収納庫10000円枚数
  int? bfrHolder10000;
  /// 回収前釣機収納庫5000円枚数
  int? bfrHolder05000;
  /// 回収前釣機収納庫2000円枚数
  int? bfrHolder02000;
  /// 回収前釣機収納庫1000円枚数
  int? bfrHolder01000;
  /// 回収前釣機収納庫500円枚数
  int? bfrHolder00500;
  /// 回収前釣機収納庫100円枚数
  int? bfrHolder00100;
  /// 回収前釣機収納庫50円枚数
  int? bfrHolder00050;
  /// 回収前釣機収納庫10円枚数
  int? bfrHolder00010;
  /// 回収前釣機収納庫5円枚数
  int? bfrHolder00005;
  /// 回収前釣機収納庫1円枚数
  int? bfrHolder00001;
  /// 回収前釣機金庫10000円枚数
  int? bfrOverflow10000;
  /// 回収前釣機金庫5000円枚数
  int? bfrOverflow05000;
  /// 回収前釣機金庫2000円枚数
  int? bfrOverflow02000;
  /// 回収前釣機金庫1000円枚数
  int? bfrOverflow01000;
  /// 回収前釣機金庫500円枚数
  int? bfrOverflow00500;
  /// 回収前釣機金庫100円枚数
  int? bfrOverflow00100;
  /// 回収前釣機金庫50円枚数
  int? bfrOverflow00050;
  /// 回収前釣機金庫10円枚数
  int? bfrOverflow00010;
  /// 回収前釣機金庫5円枚数
  int? bfrOverflow00005;
  /// 回収前釣機金庫1円枚数
  int? bfrOverflow00001;
  /// 回収後残10000円枚数
  int? resvHolder10000;
  /// 回収後残5000円枚数
  int? resvHolder05000;
  /// 回収後残2000円枚数
  int? resvHolder02000;
  /// 回収後残1000円枚数
  int? resvHolder01000;
  /// 回収後残500円枚数
  int? resvHolder00500;
  /// 回収後残100円枚数
  int? resvHolder00100;
  /// 回収後残50円枚数
  int? resvHolder00050;
  /// 回収後残10円枚数
  int? resvHolder00010;
  /// 回収後残5円枚数
  int? resvHolder00005;
  /// 回収後残1円枚数
  int? resvHolder00001;
  /// 回収後残棒金500円枚数
  int? resvDrawdata00500;
  /// 回収後残棒金100円枚数
  int? resvDrawdata00100;
  /// 回収後残棒金50円枚数
  int? resvDrawdata00050;
  /// 回収後残棒金10円枚数
  int? resvDrawdata00010;
  /// 回収後残棒金5円枚数
  int? resvDrawdata00005;
  /// 回収後残棒金1円枚数
  int? resvDrawdata00001;
  /// 従業員精算フラグ
  int? closeFlg;
  /// 回収タイプ
  int? pickTyp;
  /// 操作従業員コード
  String? opeStaffCode;
  /// 回収結果エラー番号
  int? cPickErrNo;
  /// 分割出金フラグ
  int? kindoutPrnFlg;
  /// 分割出金ステータス1
  int? kindoutPrnStat1;
  /// 分割出金ステータス2
  int? kindoutPrnStat2;
  /// 分割出金ステータス3
  int? kindoutPrnStat3;
  /// 分割出金ステータス4
  int? kindoutPrnStat4;
  /// 分割出金ステータス5
  int? kindoutPrnStat5;
  /// 分割出金ステータス6
  int? kindoutPrnStat6;
  /// 分割出金ステータス7
  int? kindoutPrnStat7;
  /// 分割出金ステータス8
  int? kindoutPrnStat8;
  /// 分割出金ステータス9
  int? kindoutPrnStat9;
  /// 分割出金ステータス10
  int? kindoutPrnStat10;
  /// 分割出金エラー番号1
  int? kindoutPrnErrNo1;
  /// 分割出金エラー番号2
  int? kindoutPrnErrNo2;
  /// 分割出金エラー番号3
  int? kindoutPrnErrNo3;
  /// 分割出金エラー番号4
  int? kindoutPrnErrNo4;
  /// 分割出金エラー番号5
  int? kindoutPrnErrNo5;
  /// 分割出金エラー番号6
  int? kindoutPrnErrNo6;
  /// 分割出金エラー番号7
  int? kindoutPrnErrNo7;
  /// 分割出金エラー番号8
  int? kindoutPrnErrNo8;
  /// 分割出金エラー番号9
  int? kindoutPrnErrNo9;
  /// 分割出金エラー番号10
  int? kindoutPrnErrNo10;
  /// 金種別登録を「する」時にセット
  List<PickPayData>? payList = <PickPayData>[];

  InoutInfo({
    this.amtTotal,
    this.sht10000,
    this.sht05000,
    this.sht02000,
    this.sht01000,
    this.sht00500,
    this.sht00100,
    this.sht00050,
    this.sht00010,
    this.sht00005,
    this.sht00001,
    this.stockSht10000,
    this.stockSht05000,
    this.stockSht02000,
    this.stockSht01000,
    this.stockSht00500,
    this.stockSht00100,
    this.stockSht00050,
    this.stockSht00010,
    this.stockSht00005,
    this.stockSht00001,
    this.stockPolSht10000,
    this.stockPolSht05000,
    this.stockPolSht02000,
    this.stockPolSht01000,
    this.stockPolSht00500,
    this.stockPolSht00100,
    this.stockPolSht00050,
    this.stockPolSht00010,
    this.stockPolSht00005,
    this.stockPolSht00001,
    this.stockPolShtOth,
    this.stockPolShtFil,
    this.stockRjct,
    this.coinSlot,
    this.stockGetDate,
    this.stockStateErrCode,
    this.fncCode,
    this.divCode,
    this.divName,
    this.tendData,
    this.changeData,
    this.outSht10000,
    this.outSht05000,
    this.outSht02000,
    this.outSht01000,
    this.outSht00500,
    this.outSht00100,
    this.outSht00050,
    this.outSht00010,
    this.outSht00005,
    this.outSht00001,
    this.chgPtnOutPrice,
    this.recycleNo,
    this.recycleStaffNo,
    this.recycleOfficeTtlAmt,
    this.recycleInMacNo,
    this.recycleOutMacNo,
    this.recycleInOutType,
    this.recycleExchgFlg,
    this.recycleRein,
    this.recycleInDiff,
    this.recycleChgOutAmt,
    this.recycleTtlAmt,
    this.recycleOfficeSht10000,
    this.recycleOfficeSht05000,
    this.recycleOfficeSht02000,
    this.recycleOfficeSht01000,
    this.recycleOfficeSht00500,
    this.recycleOfficeSht00100,
    this.recycleOfficeSht00050,
    this.recycleOfficeSht00010,
    this.recycleOfficeSht00005,
    this.recycleOfficeSht00001,
    this.recycleSht10000,
    this.recycleSht05000,
    this.recycleSht02000,
    this.recycleSht01000,
    this.recycleSht00500,
    this.recycleSht00100,
    this.recycleSht00050,
    this.recycleSht00010,
    this.recycleSht00005,
    this.recycleSht00001,
    this.recycleInOutCnt,
    this.pickBtn,
    this.pickCassette,
    this.bfrHolder10000,
    this.bfrHolder05000,
    this.bfrHolder02000,
    this.bfrHolder01000,
    this.bfrHolder00500,
    this.bfrHolder00100,
    this.bfrHolder00050,
    this.bfrHolder00010,
    this.bfrHolder00005,
    this.bfrHolder00001,
    this.bfrOverflow10000,
    this.bfrOverflow05000,
    this.bfrOverflow02000,
    this.bfrOverflow01000,
    this.bfrOverflow00500,
    this.bfrOverflow00100,
    this.bfrOverflow00050,
    this.bfrOverflow00010,
    this.bfrOverflow00005,
    this.bfrOverflow00001,
    this.resvHolder10000,
    this.resvHolder05000,
    this.resvHolder02000,
    this.resvHolder01000,
    this.resvHolder00500,
    this.resvHolder00100,
    this.resvHolder00050,
    this.resvHolder00010,
    this.resvHolder00005,
    this.resvHolder00001,
    this.resvDrawdata00500,
    this.resvDrawdata00100,
    this.resvDrawdata00050,
    this.resvDrawdata00010,
    this.resvDrawdata00005,
    this.resvDrawdata00001,
    this.closeFlg,
    this.pickTyp,
    this.opeStaffCode,
    this.cPickErrNo,
    this.kindoutPrnFlg,
    this.kindoutPrnStat1,
    this.kindoutPrnStat2,
    this.kindoutPrnStat3,
    this.kindoutPrnStat4,
    this.kindoutPrnStat5,
    this.kindoutPrnStat6,
    this.kindoutPrnStat7,
    this.kindoutPrnStat8,
    this.kindoutPrnStat9,
    this.kindoutPrnStat10,
    this.kindoutPrnErrNo1,
    this.kindoutPrnErrNo2,
    this.kindoutPrnErrNo3,
    this.kindoutPrnErrNo4,
    this.kindoutPrnErrNo5,
    this.kindoutPrnErrNo6,
    this.kindoutPrnErrNo7,
    this.kindoutPrnErrNo8,
    this.kindoutPrnErrNo9,
    this.kindoutPrnErrNo10,
    this.payList,
  });

  factory InoutInfo.fromMap(Map<String, dynamic> map) =>
      InoutInfo(
        amtTotal: map['rAmtTotal'],
        sht10000: map['rSht10000'],
        sht05000: map['rSht05000'],
        sht02000: map['rSht02000'],
        sht01000: map['rSht01000'],
        sht00500: map['rSht00500'],
        sht00100: map['rSht00100'],
        sht00050: map['rSht00050'],
        sht00010: map['rSht00010'],
        sht00005: map['rSht00005'],
        sht00001: map['rSht00001'],
        stockSht10000: map['rStockSht10000'],
        stockSht05000: map['rStockSht05000'],
        stockSht02000: map['rStockSht02000'],
        stockSht01000: map['rStockSht01000'],
        stockSht00500: map['rStockSht00500'],
        stockSht00100: map['rStockSht00100'],
        stockSht00050: map['rStockSht00050'],
        stockSht00010: map['rStockSht00010'],
        stockSht00005: map['rStockSht00005'],
        stockSht00001: map['rStockSht00001'],
        stockPolSht10000: map['rStockPolSht10000'],
        stockPolSht05000: map['rStockPolSht05000'],
        stockPolSht02000: map['rStockPolSht02000'],
        stockPolSht01000: map['rStockPolSht01000'],
        stockPolSht00500: map['rStockPolSht00500'],
        stockPolSht00100: map['rStockPolSht00100'],
        stockPolSht00050: map['rStockPolSht00050'],
        stockPolSht00010: map['rStockPolSht00010'],
        stockPolSht00005: map['rStockPolSht00005'],
        stockPolSht00001: map['rStockPolSht00001'],
        stockPolShtOth: map['rStockPolShtOth'],
        stockPolShtFil: map['rStockPolShtFil'],
        stockRjct: map['rStockRjct'],
        coinSlot: map['rCoinSlot'],
        stockGetDate: map['rStockGetDate'],
        stockStateErrCode: map['rStockStateErrCode'],
        fncCode: map['rFncCode'],
        divCode: map['rDivCode'],
        divName: map['rDivName'],
        tendData: map['rTendData'],
        changeData: map['rChangeData'],
        outSht10000: map['rOutSht10000'],
        outSht05000: map['rOutSht05000'],
        outSht02000: map['rOutSht02000'],
        outSht01000: map['rOutSht01000'],
        outSht00500: map['rOutSht00500'],
        outSht00100: map['rOutSht00100'],
        outSht00050: map['rOutSht00050'],
        outSht00010: map['rOutSht00010'],
        outSht00005: map['rOutSht00005'],
        outSht00001: map['rOutSht00001'],
        chgPtnOutPrice: map['rChgPtnOutPrice'],
        recycleNo: map['rRecycleNo'],
        recycleStaffNo: map['rRecycleStaffNo'],
        recycleOfficeTtlAmt: map['rRecycleOfficeTtlAmt'],
        recycleInMacNo: map['rRecycleInMacNo'],
        recycleOutMacNo: map['rRecycleOutMacNo'],
        recycleInOutType: map['rRecycleInOutType'],
        recycleExchgFlg: map['rRecycleExchgFlg'],
        recycleRein: map['rRecycleRein'],
        recycleInDiff: map['rRecycleInDiff'],
        recycleChgOutAmt: map['rRecycleChgOutAmt'],
        recycleTtlAmt: map['rRecycleTtlAmt'],
        recycleOfficeSht10000: map['rRecycleOfficeSht10000'],
        recycleOfficeSht05000: map['rRecycleOfficeSht05000'],
        recycleOfficeSht02000: map['rRecycleOfficeSht02000'],
        recycleOfficeSht01000: map['rRecycleOfficeSht01000'],
        recycleOfficeSht00500: map['rRecycleOfficeSht00500'],
        recycleOfficeSht00100: map['rRecycleOfficeSht00100'],
        recycleOfficeSht00050: map['rRecycleOfficeSht00050'],
        recycleOfficeSht00010: map['rRecycleOfficeSht00010'],
        recycleOfficeSht00005: map['rRecycleOfficeSht00005'],
        recycleOfficeSht00001: map['rRecycleOfficeSht00001'],
        recycleSht10000: map['rRecycleSht10000'],
        recycleSht05000: map['rRecycleSht05000'],
        recycleSht02000: map['rRecycleSht02000'],
        recycleSht01000: map['rRecycleSht01000'],
        recycleSht00500: map['rRecycleSht00500'],
        recycleSht00100: map['rRecycleSht00100'],
        recycleSht00050: map['rRecycleSht00050'],
        recycleSht00010: map['rRecycleSht00010'],
        recycleSht00005: map['rRecycleSht00005'],
        recycleSht00001: map['rRecycleSht00001'],
        recycleInOutCnt: map['rRecycleInOutCnt'],
        pickBtn: map['rPickBtn'],
        pickCassette: map['rPickCassette'],
        bfrHolder10000: map['rRecycleSht10000'],
        bfrHolder05000: map['rRecycleSht05000'],
        bfrHolder02000: map['rRecycleSht02000'],
        bfrHolder01000: map['rRecycleSht01000'],
        bfrHolder00500: map['rRecycleSht00500'],
        bfrHolder00100: map['rRecycleSht00100'],
        bfrHolder00050: map['rRecycleSht00050'],
        bfrHolder00010: map['rRecycleSht00010'],
        bfrHolder00005: map['rRecycleSht00005'],
        bfrHolder00001: map['rRecycleSht00001'],
        bfrOverflow10000: map['rBfrOverflow10000'],
        bfrOverflow05000: map['rBfrOverflow05000'],
        bfrOverflow02000: map['rBfrOverflow02000'],
        bfrOverflow01000: map['rBfrOverflow01000'],
        bfrOverflow00500: map['rBfrOverflow00500'],
        bfrOverflow00100: map['rBfrOverflow00100'],
        bfrOverflow00050: map['rBfrOverflow00050'],
        bfrOverflow00010: map['rBfrOverflow00010'],
        bfrOverflow00005: map['rBfrOverflow00005'],
        bfrOverflow00001: map['rBfrOverflow00001'],
        resvHolder10000: map['rResvHolder10000'],
        resvHolder05000: map['rResvHolder05000'],
        resvHolder02000: map['rResvHolder02000'],
        resvHolder01000: map['rResvHolder01000'],
        resvHolder00500: map['rResvHolder00500'],
        resvHolder00100: map['rResvHolder00100'],
        resvHolder00050: map['rResvHolder00050'],
        resvHolder00010: map['rResvHolder00010'],
        resvHolder00005: map['rResvHolder00005'],
        resvHolder00001: map['rResvHolder00001'],
        resvDrawdata00500: map['rResvDrawdata00500'],
        resvDrawdata00100: map['rResvDrawdata00100'],
        resvDrawdata00050: map['rResvDrawdata00050'],
        resvDrawdata00010: map['rResvDrawdata00010'],
        resvDrawdata00005: map['rResvDrawdata00005'],
        resvDrawdata00001: map['rResvDrawdata00001'],
        closeFlg: map['rCloseFlg'],
        pickTyp: map['rPickTyp'],
        opeStaffCode: map['rOpeStaffCode'],
        cPickErrNo: map['rCPickErrNo'],
        kindoutPrnFlg: map['rKindoutPrnFlg'],
        kindoutPrnStat1: map['rKindoutPrnStat1'],
        kindoutPrnStat2: map['rKindoutPrnStat2'],
        kindoutPrnStat3: map['rKindoutPrnStat3'],
        kindoutPrnStat4: map['rKindoutPrnStat4'],
        kindoutPrnStat5: map['rKindoutPrnStat5'],
        kindoutPrnStat6: map['rKindoutPrnStat6'],
        kindoutPrnStat7: map['rKindoutPrnStat7'],
        kindoutPrnStat8: map['rKindoutPrnStat8'],
        kindoutPrnStat9: map['rKindoutPrnStat9'],
        kindoutPrnStat10: map['rKindoutPrnStat10'],
        kindoutPrnErrNo1: map['rKindoutPrnErrNo1'],
        kindoutPrnErrNo2: map['rKindoutPrnErrNo2'],
        kindoutPrnErrNo3: map['rKindoutPrnErrNo3'],
        kindoutPrnErrNo4: map['rKindoutPrnErrNo4'],
        kindoutPrnErrNo5: map['rKindoutPrnErrNo5'],
        kindoutPrnErrNo6: map['rKindoutPrnErrNo6'],
        kindoutPrnErrNo7: map['rKindoutPrnErrNo7'],
        kindoutPrnErrNo8: map['rKindoutPrnErrNo8'],
        kindoutPrnErrNo9: map['rKindoutPrnErrNo9'],
        kindoutPrnErrNo10: map['rKindoutPrnErrNo10'],
        payList: map['rPayList'],
      );

  Map<String, dynamic> toMap() =>
      {
        'rAmtTotal': amtTotal,
        'rSht10000': sht10000,
        'rSht05000': sht05000,
        'rSht02000': sht02000,
        'rSht01000': sht01000,
        'rSht00500': sht00500,
        'rSht00100': sht00100,
        'rSht00050': sht00050,
        'rSht00010': sht00010,
        'rSht00005': sht00005,
        'rSht00001': sht00001,
        'rStockSht10000': stockSht10000,
        'rStockSht05000': stockSht05000,
        'rStockSht02000': stockSht02000,
        'rStockSht01000': stockSht01000,
        'rStockSht00500': stockSht00500,
        'rStockSht00100': stockSht00100,
        'rStockSht00050': stockSht00050,
        'rStockSht00010': stockSht00010,
        'rStockSht00005': stockSht00005,
        'rStockSht00001': stockSht00001,
        'rStockPolSht10000': stockPolSht10000,
        'rStockPolSht05000': stockPolSht05000,
        'rStockPolSht02000': stockPolSht02000,
        'rStockPolSht01000': stockPolSht01000,
        'rStockPolSht00500': stockPolSht00500,
        'rStockPolSht00100': stockPolSht00100,
        'rStockPolSht00050': stockPolSht00050,
        'rStockPolSht00010': stockPolSht00010,
        'rStockPolSht00005': stockPolSht00005,
        'rStockPolSht00001': stockPolSht00001,
        'rStockPolShtOth': stockPolShtOth,
        'rStockPolShtFil': stockPolShtFil,
        'rStockRjct': stockRjct,
        'rCoinSlot': coinSlot,
        'rStockGetDate': stockGetDate,
        'rStockStateErrCode': stockStateErrCode,
        'rFncCode': fncCode,
        'rDivCode': divCode,
        'rDivName': divName,
        'rTendData': tendData,
        'rChangeData': changeData,
        'rOutSht10000': outSht10000,
        'rOutSht05000': outSht05000,
        'rOutSht02000': outSht02000,
        'rOutSht01000': outSht01000,
        'rOutSht00500': outSht00500,
        'rOutSht00100': outSht00100,
        'rOutSht00050': outSht00050,
        'rOutSht00010': outSht00010,
        'rOutSht00005': outSht00005,
        'rOutSht00001': outSht00001,
        'rChgPtnOutPrice': chgPtnOutPrice,
        'rRecycleNo': recycleNo,
        'rRecycleStaffNo': recycleStaffNo,
        'rRecycleOfficeTtlAmt': recycleOfficeTtlAmt,
        'rRecycleInMacNo': recycleInMacNo,
        'rRecycleOutMacNo': recycleOutMacNo,
        'rRecycleInOutType': recycleInOutType,
        'rRecycleExchgFlg': recycleExchgFlg,
        'rRecycleRein': recycleRein,
        'rRecycleInDiff': recycleInDiff,
        'rRecycleChgOutAmt': recycleChgOutAmt,
        'rRecycleTtlAmt': recycleTtlAmt,
        'rRecycleOfficeSht10000': recycleOfficeSht10000,
        'rRecycleOfficeSht05000': recycleOfficeSht05000,
        'rRecycleOfficeSht02000': recycleOfficeSht02000,
        'rRecycleOfficeSht01000': recycleOfficeSht01000,
        'rRecycleOfficeSht00500': recycleOfficeSht00500,
        'rRecycleOfficeSht00100': recycleOfficeSht00100,
        'rRecycleOfficeSht00050': recycleOfficeSht00050,
        'rRecycleOfficeSht00010': recycleOfficeSht00010,
        'rRecycleOfficeSht00005': recycleOfficeSht00005,
        'rRecycleOfficeSht00001': recycleOfficeSht00001,
        'rRecycleSht10000': recycleSht10000,
        'rRecycleSht05000': recycleSht05000,
        'rRecycleSht02000': recycleSht02000,
        'rRecycleSht01000': recycleSht01000,
        'rRecycleSht00500': recycleSht00500,
        'rRecycleSht00100': recycleSht00100,
        'rRecycleSht00050': recycleSht00050,
        'rRecycleSht00010': recycleSht00010,
        'rRecycleSht00005': recycleSht00005,
        'rRecycleSht00001': recycleSht00001,
        'rRecycleInOutCnt': recycleInOutCnt,
        'rPickBtn': pickBtn,
        'rPickCassette': pickCassette,
        'rBfrHolder10000': bfrHolder10000,
        'rBfrHolder05000': bfrHolder05000,
        'rBfrHolder02000': bfrHolder02000,
        'rBfrHolder01000': bfrHolder01000,
        'rBfrHolder00500': bfrHolder00500,
        'rBfrHolder00100': bfrHolder00100,
        'rBfrHolder00050': bfrHolder00050,
        'rBfrHolder00010': bfrHolder00010,
        'rBfrHolder00005': bfrHolder00005,
        'rBfrHolder00001': bfrHolder00001,
        'rBfrOverflow10000': bfrOverflow10000,
        'rBfrOverflow05000': bfrOverflow05000,
        'rBfrOverflow02000': bfrOverflow02000,
        'rBfrOverflow01000': bfrOverflow01000,
        'rBfrOverflow00500': bfrOverflow00500,
        'rBfrOverflow00100': bfrOverflow00100,
        'rBfrOverflow00050': bfrOverflow00050,
        'rBfrOverflow00010': bfrOverflow00010,
        'rBfrOverflow00005': bfrOverflow00005,
        'rBfrOverflow00001': bfrOverflow00001,
        'rResvDrawdata00500': resvDrawdata00500,
        'rResvDrawdata00100': resvDrawdata00100,
        'rResvDrawdata00050': resvDrawdata00050,
        'rResvDrawdata00010': resvDrawdata00010,
        'rResvDrawdata00005': resvDrawdata00005,
        'rResvDrawdata00001': resvDrawdata00001,
        'rCloseFlg': closeFlg,
        'rPickTyp': pickTyp,
        'rOpeStaffCode': opeStaffCode,
        'rCPickErrNo': cPickErrNo,
        'rKindoutPrnFlg': kindoutPrnFlg,
        'rKindoutPrnStat1': kindoutPrnStat1,
        'rKindoutPrnStat2': kindoutPrnStat2,
        'rKindoutPrnStat3': kindoutPrnStat3,
        'rKindoutPrnStat4': kindoutPrnStat4,
        'rKindoutPrnStat5': kindoutPrnStat5,
        'rKindoutPrnStat6': kindoutPrnStat6,
        'rKindoutPrnStat7': kindoutPrnStat7,
        'rKindoutPrnStat8': kindoutPrnStat8,
        'rKindoutPrnStat9': kindoutPrnStat9,
        'rKindoutPrnStat10': kindoutPrnStat10,
        'rKindoutPrnErrNo1': kindoutPrnErrNo1,
        'rKindoutPrnErrNo2': kindoutPrnErrNo2,
        'rKindoutPrnErrNo3': kindoutPrnErrNo3,
        'rKindoutPrnErrNo4': kindoutPrnErrNo4,
        'rKindoutPrnErrNo5': kindoutPrnErrNo5,
        'rKindoutPrnErrNo6': kindoutPrnErrNo6,
        'rKindoutPrnErrNo7': kindoutPrnErrNo7,
        'rKindoutPrnErrNo8': kindoutPrnErrNo8,
        'rKindoutPrnErrNo9': kindoutPrnErrNo9,
        'rKindoutPrnErrNo10': kindoutPrnErrNo10,
        'rPayList': payList,
      };
}

/// 分類情報取得のパラメータ
class GetClassInfoParaChanger {
  /// 企業コード
  int compCd;

  /// 店舗コード
  int streCd;

  /// マシン番号
  int macNo;

  /// マシン番号
  int? lastUpdated = null;

  GetClassInfoParaChanger({
    required this.compCd,
    required this.streCd,
    required this.macNo,
    this.lastUpdated,
  });
}