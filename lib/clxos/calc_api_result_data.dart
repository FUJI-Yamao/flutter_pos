import 'package:json_annotation/json_annotation.dart';

import '../app/inc/sys/tpr_dlg.dart';

part 'calc_api_result_data.g.dart';

/// クラウドPOSのエラー判定.
class ClxosErr{
  static getErrCd(int? retSts, int? posErrCd, String? errMsg){
    if (posErrCd != null && posErrCd != 0) {
      return posErrCd;
    }
    if((retSts != null && retSts != 0)
    || (errMsg != null && errMsg != "")){
      return  DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
    }
  
    return 0;
  }
}


/// レジ開設のレスポンスデータ
/// レジ精算のレスポンスデータ
@JsonSerializable()
class CalcResultStore {
    /// 返答ステータス 0：エラーなし ０以外：エラー発生
    @JsonKey(name: 'RetSts')
    int?       retSts;
    /// エラーメッセージ
    @JsonKey(name: 'ErrMsg')
    String?    errMsg;
    /// 営業日（YYYY/MM/DD）
    @JsonKey(name: 'SaleDate')
    String?    saleDate;
    /// 強制終了日時（YYYY/MM/DD HH:MM:SS）
    @JsonKey(name: 'ForcedClose')
    String?    forcedClose;

  CalcResultStore({
    required this.retSts,
    required this.errMsg,
    required this.saleDate,
    required this.forcedClose,
  });

  factory CalcResultStore.fromJson(Map<String, dynamic> json) => _$CalcResultStoreFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultStoreToJson(this);
}

/// 従業員オープンのレスポンスデータ
/// 従業員クローズ"のレスポンスデータ
@JsonSerializable()
class CalcResultStaff {
    /// 返答ステータス 0：エラーなし ０以外：エラー発生
    @JsonKey(name: 'RetSts')
    int?       retSts;
    /// エラーメッセージ
    @JsonKey(name: 'ErrMsg')
    String?    errMsg;
    /// POSエラーコード
    @JsonKey(name: 'PosErrCd')
    int?       posErrCd;
    /// 従業員番号
    @JsonKey(name: 'StaffCd')
    String?    staffCd;
    /// 従業員名称
    @JsonKey(name: 'StaffName')
    String?    staffName;
    /// メニューで操作できないコード一覧
    @JsonKey(name: 'MenuAuthNotCode')
    List?      menuAuthNotCodeList;
    /// 登録で操作できないコード一覧
    @JsonKey(name: 'KeyAuthNotCode')
    List?      keyAuthNotCodeList;

  CalcResultStaff({
    required this.retSts,
    required this.errMsg,
    required this.posErrCd,
    required this.staffCd,
    required this.staffName,
    required this.menuAuthNotCodeList,
    required this.keyAuthNotCodeList,
  });

  factory CalcResultStaff.fromJson(Map<String, dynamic> json) => _$CalcResultStaffFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultStaffToJson(this);
}

/// 商品情報の呼出のレスポンスデータ
/// 売価チェックのレスポンスデータ
@JsonSerializable()
class CalcResultItem {
    /// 返答ステータス
    @JsonKey(name: 'RetSts')
    int?       retSts;
    /// エラーメッセージ
    @JsonKey(name: 'ErrMsg')
    String?    errMsg;
    /// POSエラーコード
    @JsonKey(name: 'PosErrCd')
    int?       posErrCd;
    /// 商品情報リスト
    @JsonKey(name: 'ItemList') 
    List<ResultItemData>? calcResultItemList;
    /// 合計情報
    @JsonKey(name: 'TotalData') 
    List<TotalData>? totalDataList;
    /// 会員情報
    @JsonKey(name: 'CustData') 
    CustData? custData;
    /// 小計値下情報
    @JsonKey(name: 'SubttlList') 
    List<SubttlResData>? subttlList;

  CalcResultItem({
     required this.retSts,
     required this.errMsg,
     required this.posErrCd,
     required this.calcResultItemList,
     required this.totalDataList,
     required this.custData,
     required this.subttlList,
  });
  CalcResultItem.empty():
    retSts = null,
    errMsg = null,
    posErrCd = null,
    calcResultItemList = null,
    totalDataList = null,
    custData =null,
    subttlList = null;

  factory CalcResultItem.fromJson(Map<String, dynamic> json) => _$CalcResultItemFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultItemToJson(this);

  /// クラウドPOSからの返り値から、エラーコードを返す.
  int getErrId() {
    return ClxosErr.getErrCd(retSts, posErrCd, errMsg);
  }
}

/// 支払操作のレスポンスデータ
/// 支払確認のレスポンスデータ
/// 再発行のレスポンスデータ
/// 領収書のレスポンスデータ
/// 取引リセットのレスポンスデータ
@JsonSerializable()
class CalcResultPay {
    /// 返答ステータス
    @JsonKey(name: 'RetSts')
    int?       retSts;
    /// エラーメッセージ
    @JsonKey(name: 'ErrMsg')
    String?    errMsg;
    /// POSエラーコード
    @JsonKey(name: 'PosErrCd')
    int?       posErrCd;
    /// 合計情報
    @JsonKey(name: 'TotalData')
    PayTotalData? totalData;
    /// 電子レシート情報
    @JsonKey(name: 'DigitalReceipt')
    PayDigitalReceipt? digitalReceipt;

  CalcResultPay({
     required this.retSts,
     required this.errMsg,
     required this.posErrCd,
     required this.totalData,
     required this.digitalReceipt,
  });

  factory CalcResultPay.fromJson(Map<String, dynamic> json) => _$CalcResultPayFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultPayToJson(this);

  /// クラウドPOSからの返り値から、エラーコードを返す.
  int getErrId() {
    return ClxosErr.getErrCd(retSts, posErrCd, errMsg);
  }
}

/// 訂正操作のレスポンスデータ
@JsonSerializable()
class CalcResultVoid {
    /// 返答ステータス
    @JsonKey(name: 'RetSts')
    int?       retSts;
    /// エラーメッセージ
    @JsonKey(name: 'ErrMsg')
    String?    errMsg;
    /// POSエラーコード
    @JsonKey(name: 'PosErrCd')
    int?       posErrCd;
    /// 合計情報
    @JsonKey(name: 'TotalData')
    PayTotalData? totalData;
    /// 電子レシート情報
    @JsonKey(name: 'DigitalReceipt')
    PayDigitalReceipt? digitalReceipt;

  CalcResultVoid({
     required this.retSts,
     required this.errMsg,
     required this.posErrCd,
     required this.totalData,
     required this.digitalReceipt,
  });

  factory CalcResultVoid.fromJson(Map<String, dynamic> json) => _$CalcResultVoidFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultVoidToJson(this);
}

/// 訂正確認のレスポンスデータ
@JsonSerializable()
class CalcResultVoidSearch {
    /// 返答ステータス
    @JsonKey(name: 'RetSts')
    int?       retSts;
    /// エラーメッセージ
    @JsonKey(name: 'ErrMsg')
    String?    errMsg;
    /// POSで表示するエラーコード
    @JsonKey(name: 'PosErrCd')
    int?       posErrCd;
    /// 検索した取引のシリアルNo
    @JsonKey(name: 'SerialNo')
    String? serialNo;
    /// 検索した取引の営業日
    @JsonKey(name: 'SaleDate')
    String? saleDate;
    /// 検索した取引のレシート番号
    @JsonKey(name: 'ReceiptNo')
    int?    receiptNo;
    /// 検索した取引のジャーナル番号
    @JsonKey(name: 'PrintNo')
    int?    printNo;
    /// 検索した取引のレジ番号
    @JsonKey(name: 'MacNo')
    int?    macNo;
    /// 検索した取引の売上金額
    @JsonKey(name: 'SaleAmt')
    int?    saleAmt;
    /// クレジット情報
    @JsonKey(name: 'CrdtInfo')
    CrdtInfo? crdtInfo;

  CalcResultVoidSearch({
     required this.retSts,
     required this.errMsg,
     required this.posErrCd,
     required this.serialNo,
     required this.saleDate,
     required this.receiptNo,
     required this.printNo,
     required this.macNo,
     required this.saleAmt,
     required this.crdtInfo,
  });

  factory CalcResultVoidSearch.fromJson(Map<String, dynamic> json) => _$CalcResultVoidSearchFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultVoidSearchToJson(this);
}

/// クレジット情報
@JsonSerializable()
class CrdtInfo {

    /// 支払タイプ
    @JsonKey(name: 'Space')
	int?   space;
    /// 端末処理通番
    @JsonKey(name: 'PosReceiptNo')
	int?   posReceiptNo;
    /// カード番号（マスク済みのもの）
    @JsonKey(name: 'MemberCode')
	String?  memberCode;
    /// 
    @JsonKey(name: 'StreJoinNo')
	String?  streJoinNo;
    /// 端末識別コード
    @JsonKey(name: 'PosRecognizeNo')
	String?  posRecognizeNo;

  CrdtInfo({
        required this.space,
        required this.posReceiptNo,
        required this.memberCode,
        required this.streJoinNo,
        required this.posRecognizeNo,
  });

  factory CrdtInfo.fromJson(Map<String, dynamic> json) => _$CrdtInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CrdtInfoToJson(this);
}

/// 前さばき(保存)のレスポンスデータ
/// 前さばき(削除)のレスポンスデータ
@JsonSerializable()
class CalcResultReturn {
    /// 返答ステータス 0：エラーなし ０以外：エラー発生
    @JsonKey(name: 'RetSts')
    int?       retSts;
    /// エラーメッセージ
    @JsonKey(name: 'ErrMsg')
    String?    errMsg;

  CalcResultReturn({
    required this.retSts,
    required this.errMsg,
  });

  factory CalcResultReturn.fromJson(Map<String, dynamic> json) => _$CalcResultReturnFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultReturnToJson(this);
}

/// 前さばき(呼出)のレスポンスデータ
@JsonSerializable()
class CalcResultCustomercard {
    /// 返答ステータス
    @JsonKey(name: 'RetSts')
    int?       retSts;
    /// エラーメッセージ
    @JsonKey(name: 'ErrMsg')
    String?    errMsg;
    /// 商品情報リスト
    @JsonKey(name: 'ItemList') 
    List<ResultItemData>? resultItemDataList;
    /// 合計情報
    @JsonKey(name: 'TotalData') 
    List<TotalData>? totalDataList;
    /// 会員情報
    @JsonKey(name: 'CustData') 
    CustData? custData;
    /// CLxOSの取引別UUID
    @JsonKey(name: 'UUID')
    String?    uuid;
    /// CLxOSの操作従業員コード
    @JsonKey(name: 'StaffCode')
    int?       staffCode;
    /// CLxOSの操作レジ番号
    @JsonKey(name: 'SaveMacNo')
    int?       saveMacNo;
    /// CLxOSの保存日時
    @JsonKey(name: 'SaveTime')
    String?    saveTime;

  CalcResultCustomercard({
     required this.retSts,
     required this.errMsg,
     required this.resultItemDataList,
     required this.totalDataList,
     required this.custData,
     required this.uuid,
     required this.staffCode,
     required this.saveMacNo,
     required this.saveTime,
  });

  factory CalcResultCustomercard.fromJson(Map<String, dynamic> json) => _$CalcResultCustomercardFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultCustomercardToJson(this);
}

/// 実績集計のレスポンスデータ
@JsonSerializable()
class CalcResultActualResults {
  /// 返答ステータス
  @JsonKey(name: 'RetSts')
  int?       retSts;
  /// エラーメッセージ
  @JsonKey(name: 'ErrMsg')
  String?    errMsg;
  /// POSエラーコード
  @JsonKey(name: 'PosErrCd')
  int?       posErrCd;
  /// 処理した件数
  @JsonKey(name: 'Count')
  int?       count;
  /// 残り件数
  @JsonKey(name: 'Remain')
  int?       remain;

  CalcResultActualResults({
    required this.retSts,
    required this.errMsg,
    required this.posErrCd,
    required this.count,
    required this.remain,
  });

  factory CalcResultActualResults.fromJson(Map<String, dynamic> json) => _$CalcResultActualResultsFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultActualResultsToJson(this);
}

/// 差異チェックのレスポンスデータ
@JsonSerializable()
class CalcResultDrwchk {
    /// 返答ステータス
    @JsonKey(name: 'RetSts')
    int?       retSts;
    /// エラーメッセージ
    @JsonKey(name: 'ErrMsg')
    String?    errMsg;
    /// 配列の要素はobject
    @JsonKey(name: 'PayList')
    List<PaychkData>? paychkDataList;

    @JsonKey(name: 'CashInfo')
    CashChaChkAmtData? cashInfoData;

    @JsonKey(name: 'ChaInfo')
    CashChaChkAmtData? chaInfoData;

    @JsonKey(name: 'ChkInfo')
    CashChaChkAmtData? chkInfoData;
   
  CalcResultDrwchk({
     required this.retSts,
     required this.errMsg,
     required this.paychkDataList,
     required this.cashInfoData,
     required this.chaInfoData,
     required this.chkInfoData,

  });

  factory CalcResultDrwchk.fromJson(Map<String, dynamic> json) => _$CalcResultDrwchkFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultDrwchkToJson(this);
}

/// 商品情報リスト
@JsonSerializable()
class ResultItemData {
    /// 商品ごとの返答ステータス
    @JsonKey(name: 'RetSts')
    int?        retSts;
    /// 商品ごとのエラーメッセージ
    @JsonKey(name: 'ErrMsg')
    String?    errMsg;
    /// POSエラーコード
    @JsonKey(name: 'PosErrCd')
    int?       posErrCd;
    /// 登録番号
    @JsonKey(name: 'SeqNo')
    int?        seqNo;
    /// 0:通常　1:取消　2:カゴ抜け　　3:期限切れ
    @JsonKey(name: 'Type')
    int?        type;
    /// 商品タイプ0:通常 　30:不定貫   31:個数変更不可 800:無償商品
    @JsonKey(name: 'ItemType')
    int?        itemType;
    /// 警告タイプ0:通常   100:酒　300:一類医薬品
    @JsonKey(name: 'WarningType')
    int?        warningType;
    /// 商品マスタで管理している商品コード
    @JsonKey(name: 'Barcode')
    String?    barcode;
    /// リクエスト時のバーコード１段目
    @JsonKey(name: 'OrgBarcode1')
    String?    orgBarcode1;
    /// リクエスト時のバーコード２段目
    @JsonKey(name: 'OrgBarcode2')
    String?    orgBarcode2;
    /// 商品名称
    @JsonKey(name: 'Name')
    String?    name;
    /// 商品単価
    @JsonKey(name: 'Price')
    int?        price;
    /// 登録点数
    @JsonKey(name: 'Qty')
    int?        qty;
    @JsonKey(name: 'DiscountList') 
    List<DiscountData>? discountList;
    /// 税リスト
    @JsonKey(name: 'TaxList') 
    List<TaxData>? taxDataList;
    /// 価格リスト
    @JsonKey(name: 'PriceList')
    List<PriceData>? priceList;
    /// 商品スキャン時間
    @JsonKey(name: 'ScanTime')
    String?    scanTime;
    /// 商品種別weight_flgのこと
    @JsonKey(name: 'ItemKind')
    int?        itemKind;
    /// 値下タイプ
    @JsonKey(name: 'ItemDscType')
    int?        itemDscType;
    /// 値下額
    @JsonKey(name: 'ItemDscVal')
    int?        itemDscVal;
    /// 値下コード
    @JsonKey(name: 'ItemDscCode')
    int?        itemDscCode;
    /// 売価変更金額
    @JsonKey(name: 'PrcChgVal')
    int?        prcChgVal;
    /// 売価変更フラグ
    @JsonKey(name: 'PrcChgFlg')
    int?        prcChgFlg;
    /// 単品値下フラグ
    @JsonKey(name: 'DiscChgFlg')
    int?        discChgFlg;
    /// 小数点登録値　　小数点以下2桁まで
    @JsonKey(name: 'DecimalVal')
    String?    decimalVal;
    /// 分類登録時のコード
    @JsonKey(name: 'ClsNo')
    int?        clsNo;
    /// 分類登録時の金額
    @JsonKey(name: 'ClsVal')
    int?        clsVal;
    @JsonKey(name: 'PointAddList') 
    List<PointAddData>? pointAddList;

  ResultItemData({
        required this.retSts,
        required this.errMsg,
        required this.posErrCd,
        required this.seqNo,
        required this.type,
        required this.itemType,
        required this.warningType,
        required this.barcode,
        required this.orgBarcode1,
        required this.orgBarcode2,
        required this.name,
        required this.price,
        required this.qty,
        required this.discountList,
        required this.taxDataList,
        required this.scanTime,
        required this.itemKind,
        required this.itemDscType,
        required this.itemDscVal,
        required this.itemDscCode,
        required this.prcChgVal,
        required this.prcChgFlg,
        required this.discChgFlg,
        required this.decimalVal,
        required this.clsNo,
        required this.clsVal,
        required this.pointAddList
  });

  factory ResultItemData.fromJson(Map<String, dynamic> json) => _$ResultItemDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResultItemDataToJson(this);

  /// クラウドPOSからの返り値から、エラーコードを返す.
  int getErrId() {
    return ClxosErr.getErrCd(retSts, posErrCd, errMsg);
  }
}

/// 予約レポートの出力のレスポンスデータ
@JsonSerializable()
class CalcResultBatchReport {
  /// 返答ステータス
  @JsonKey(name: 'RetSts')
  int?       retSts;
  /// エラーメッセージ
  @JsonKey(name: 'ErrMsg')
  String?    errMsg;
  /// 合計情報
  @JsonKey(name: 'TotalData')
  PayTotalData? totalData;
  /// 電子レシート情報
  @JsonKey(name: 'DigitalReceipt')
  PayDigitalReceipt? digitalReceipt;

  CalcResultBatchReport({
    required this.retSts,
    required this.errMsg,
    required this.totalData,
    required this.digitalReceipt,
  });

  factory CalcResultBatchReport.fromJson(Map<String, dynamic> json) => _$CalcResultBatchReportFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultBatchReportToJson(this);
}

/// 入金のレスポンスデータ
/// 支払のレスポンスデータ
/// 釣機参照のレスポンスデータ
@JsonSerializable()
class CalcResultChanger {
  /// 返答ステータス
  @JsonKey(name: 'RetSts')
  int?       retSts;
  /// エラーメッセージ
  @JsonKey(name: 'ErrMsg')
  String?    errMsg;
  /// 電子レシート情報
  @JsonKey(name: 'DigitalReceipt')
  PayDigitalReceipt? digitalReceipt;

  CalcResultChanger({
    required this.retSts,
    required this.errMsg,
    required this.digitalReceipt,
  });

  factory CalcResultChanger.fromJson(Map<String, dynamic> json) => _$CalcResultChangerFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultChangerToJson(this);
}

/// 検索領収書のレスポンスデータ
@JsonSerializable()
class CalcResultSearchReceipt {
  /// 返答ステータス
  @JsonKey(name: 'RetSts')
  int?       retSts;
  /// エラーメッセージ
  @JsonKey(name: 'ErrMsg')
  String?    errMsg;
  /// POSエラーコード
  @JsonKey(name: 'PosErrCd')
  int?       posErrCd;
  /// 合計情報
  @JsonKey(name: 'TotalData')
  PayTotalData? totalData;
  /// 電子レシート情報
  @JsonKey(name: 'DigitalReceipt')
  PayDigitalReceipt? digitalReceipt;

  CalcResultSearchReceipt({
    required this.retSts,
    required this.errMsg,
    required this.posErrCd,
    required this.totalData,
    required this.digitalReceipt,
  });

  factory CalcResultSearchReceipt.fromJson(Map<String, dynamic> json) => _$CalcResultSearchReceiptFromJson(json);
  Map<String, dynamic> toJson() => _$CalcResultSearchReceiptToJson(this);
}

/// DiscountData
@JsonSerializable()
class DiscountData {
    /// 1:特売 2:MM 3:SM 4:分類一括 5:値引   6:割引  7:売価変更値引 8:会員 など
    @JsonKey(name: 'Type')
    int?       type;
    /// 施策コード
    @JsonKey(name: 'Code')
    int?    code;
    /// 施策名称 固定の名称1:特売 2:まとめ値引 3:セット値引 4:値下5:値引 6:割引 7:売変 8:会員
    @JsonKey(name: 'Name')
    String?    name;
    /// 値下金額
    @JsonKey(name: 'DiscountPrice')
    int?       discountPrice;
    /// 成立フラグ
    @JsonKey(name: 'FormedFlg')
    int?       formedFlg;

  DiscountData({
    required this.type,
    required this.code,
    required this.name,
    required this.discountPrice,
    required this.formedFlg,
  });

  factory DiscountData.fromJson(Map<String, dynamic> json) => _$DiscountDataFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountDataToJson(this);
}

/// 税リスト
@JsonSerializable()
class TaxData {
    /// 税タイプ
    @JsonKey(name: 'Type')
    int?       type;
    /// 税率
    @JsonKey(name: 'Rate')
    int?       rate;
    /// 税コード
    @JsonKey(name: 'Code')
    int?       code;

  TaxData({
    required this.type,
    required this.rate,
    required this.code,
  });

  factory TaxData.fromJson(Map<String, dynamic> json) => _$TaxDataFromJson(json);
  Map<String, dynamic> toJson() => _$TaxDataToJson(this);
}

/// 価格リスト
@JsonSerializable()
class PriceData {
  @JsonKey(name: 'MdlClsCd')
  int?       mdlClsCd;

  @JsonKey(name: 'MdlClsName')
  String?       mdlClsName;

  @JsonKey(name: 'SmlClsCd')
  int?       smlClsCd;

  @JsonKey(name: 'SmlClsName')
  String?       smlClsName;

  @JsonKey(name: 'PosPrice')
  int?       posPrice;

  @JsonKey(name: 'BrgnPrice')
  int?       brgnPrice;

  @JsonKey(name: 'BrgnCustPrice')
  int?       brgnCustPrice;

  @JsonKey(name: 'BdlType')
  int?       bdlType;

  @JsonKey(name: 'BdlFormQty1')
  int?       bdlFormQty1;

  @JsonKey(name: 'BdlFormQty2')
  int?       bdlFormQty2;

  @JsonKey(name: 'BdlFormQty3')
  int?       bdlFormQty3;

  @JsonKey(name: 'BdlFormQty4')
  int?       bdlFormQty4;

  @JsonKey(name: 'BdlFormQty5')
  int?       bdlFormQty5;

  @JsonKey(name: 'BdlFormPrc1')
  int?       bdlFormPrc1;

  @JsonKey(name: 'BdlFormPrc2')
  int?       bdlFormPrc2;

  @JsonKey(name: 'BdlFormPrc3')
  int?       bdlFormPrc3;

  @JsonKey(name: 'BdlFormPrc4')
  int?       bdlFormPrc4;

  @JsonKey(name: 'BdlFormPrc5')
  int?       bdlFormPrc5;

  @JsonKey(name: 'BdlFormCustPrc1')
  int?       bdlFormCustPrc1;

  @JsonKey(name: 'BdlFormCustPrc2')
  int?       bdlFormCustPrc2;

  @JsonKey(name: 'BdlFormCustPrc3')
  int?       bdlFormCustPrc3;

  @JsonKey(name: 'BdlFormCustPrc4')
  int?       bdlFormCustPrc4;

  @JsonKey(name: 'BdlFormCustPrc5')
  int?       bdlFormCustPrc5;

  @JsonKey(name: 'BdlAvg')
  int?       bdlAvg;

  @JsonKey(name: 'BdlCustAvg')
  int?       bdlCustAvg;

  PriceData({
    required this.mdlClsCd,
    required this.mdlClsName,
    required this.smlClsCd,
    required this.smlClsName,
    required this.posPrice,
    required this.brgnPrice,
    required this.brgnCustPrice,
    required this.bdlType,
    required this.bdlFormQty1,
    required this.bdlFormQty2,
    required this.bdlFormQty3,
    required this.bdlFormQty4,
    required this.bdlFormQty5,
    required this.bdlFormPrc1,
    required this.bdlFormPrc2,
    required this.bdlFormPrc3,
    required this.bdlFormPrc4,
    required this.bdlFormPrc5,
    required this.bdlFormCustPrc1,
    required this.bdlFormCustPrc2,
    required this.bdlFormCustPrc3,
    required this.bdlFormCustPrc4,
    required this.bdlFormCustPrc5,
    required this.bdlAvg,
    required this.bdlCustAvg,
  });

  factory PriceData.fromJson(Map<String, dynamic> json) => _$PriceDataFromJson(json);
  Map<String, dynamic> toJson() => _$PriceDataToJson(this);
}

/// PointAddData
@JsonSerializable()
class PointAddData {
    /// 1:商品加算　2:ロイヤリティ加算
    @JsonKey(name: 'Type')
    int?       type;
    /// 付与ポイント
    @JsonKey(name: 'Point')
    int?       point;
    /// 施策名称1:商品加算の名称 2:ロイヤリティの名称
    @JsonKey(name: 'Name')
    String?    name;

  PointAddData({
    required this.type,
    required this.point,
    required this.name,
  });

  factory PointAddData.fromJson(Map<String, dynamic> json) => _$PointAddDataFromJson(json);
  Map<String, dynamic> toJson() => _$PointAddDataToJson(this);
}

/// 合計情報
@JsonSerializable()
class TotalData {
    /// 値引後の税込合計金額
    @JsonKey(name: 'Amount')
    int?        amount;
    @JsonKey(name: 'DiscountList')
    List<TotalDataDiscountData>? totalDataDiscountList;
    /// 小計値下対象金額
    @JsonKey(name: 'BaseAmount')
    int?        baseAmount;
    /// 合計点数
    @JsonKey(name: 'TotalQty')
    int?        totalQty;
    /// 返品取引フラグ　0:通常売上　　1:全商品を返品操作扱い
    @JsonKey(name: 'RefundFlag')
    int?        refundFlag;
    /// 小計額
    @JsonKey(name: 'Subtotal')
    int?        subtotal;
    /// 小計値下合計金額
    @JsonKey(name: 'SubDscAmount')
    int?        subDscAmount;
    /// 外税額の合計
    @JsonKey(name: 'ExTaxAmount')
    int?        exTaxAmount;

  TotalData({
      required this.amount,
      required this.totalDataDiscountList,
      required this.baseAmount,
      required this.totalQty,
      required this.refundFlag,
      required this.subtotal,
      required this.subDscAmount,
      required this.exTaxAmount,
  });

  factory TotalData.fromJson(Map<String, dynamic> json) => _$TotalDataFromJson(json);
  Map<String, dynamic> toJson() => _$TotalDataToJson(this);
}

/// TotalDataDiscountData
@JsonSerializable()
class TotalDataDiscountData {
    /// 0:値下合計 1:特売 2:MM 3:SM 4:分類一括 5:値引   6:割引  7:売価変更値引  8:会員   など
    @JsonKey(name: 'Type')
    int?        type;
    /// 各タイプの値下合計金額
    @JsonKey(name: 'DiscountPrice')
    int?        discountPrice;

  TotalDataDiscountData({
      required this.type,
      required this.discountPrice,

  });

  factory TotalDataDiscountData.fromJson(Map<String, dynamic> json) => _$TotalDataDiscountDataFromJson(json);
  Map<String, dynamic> toJson() => _$TotalDataDiscountDataToJson(this);
}

/// 会員情報
@JsonSerializable()
class CustData {
    /// 会員コード
    @JsonKey(name: 'CustCode')
    String?    custCode;
    /// 前回ポイント
    @JsonKey(name: 'LastPoint')
    int?       lastPoint;
    /// 会員名称
    @JsonKey(name: 'CustName')
    String?    custName;
    /// 会員状態
    @JsonKey(name: 'CustStatus')
    String?    custStatus;

  CustData({
      required this.custCode,
      required this.lastPoint,
      required this.custName,
      required this.custStatus,
  });

  factory CustData.fromJson(Map<String, dynamic> json) => _$CustDataFromJson(json);
  Map<String, dynamic> toJson() => _$CustDataToJson(this);
}

/// 小計値下情報
@JsonSerializable()
class SubttlResData {
    /// 小計値下のキーコード
    @JsonKey(name: 'StlDscCode')
    int?    stlDscCode;
    /// 小計値下の値引額/割引率/割増率
    @JsonKey(name: 'StlDscVal')
    int?       stlDscVal;
    /// 小計値下額
    @JsonKey(name: 'StlDscAmount')
    int?    stlDscAmount;
    /// 小計値下の名称
    @JsonKey(name: 'StlDscName')
    String?    stlDscName;

  SubttlResData({
      required this.stlDscCode,
      required this.stlDscVal,
      required this.stlDscAmount,
      required this.stlDscName,
  });

  factory SubttlResData.fromJson(Map<String, dynamic> json) => _$SubttlResDataFromJson(json);
  Map<String, dynamic> toJson() => _$SubttlResDataToJson(this);
}

/// 合計情報
@JsonSerializable()
class PayTotalData {
    /// 値引後の税込合計金額
    @JsonKey(name: 'Amount')
    int?     amount;
    /// 合計支払額
    @JsonKey(name: 'Payment')
    int?     payment;
    /// お釣り
    @JsonKey(name: 'Change')
    int?     change;
    /// 変便取引フラグ
    @JsonKey(name: 'RefundFlag')
    int? refundFlag;
    /// 合計点数
    @JsonKey(name: 'TotalQty')
    int? totalQty;
    /// 企業コード
    @JsonKey(name: 'CompCd')
    int? compCd;
    /// 店舗コード
    @JsonKey(name: 'StreCd')
    int? streCd;
    /// レジ番号
    @JsonKey(name: 'MacNo')
    int? macNo;
    /// レシート番号
    @JsonKey(name: 'ReceiptNo')
    int? receiptNo;
    /// ジャーナル番号（プリント番号）
    @JsonKey(name: 'PrintNo')
    int? printNo;
    /// キャッシャー番号
    @JsonKey(name: 'CashierNo')
    int? cashierNo;
    /// 売上日時
    @JsonKey(name: 'EndTime')
    String? endTime;
    /// 取引コード
    @JsonKey(name: 'SerialNo')
    String? SerialNo;
    /// 取引別のUUID
    @JsonKey(name: 'UUID')
    String? uuid;

  PayTotalData({
        required this.amount,
        required this.payment,
        required this.change,
        required this.refundFlag,
        required this.totalQty,
        required this.compCd,
        required this.streCd,
        required this.macNo,
        required this.receiptNo,
        required this.printNo,
        required this.cashierNo,
        required this.endTime,
        required this.SerialNo,
        required this.uuid,
  });

  factory PayTotalData.fromJson(Map<String, dynamic> json) => _$PayTotalDataFromJson(json);
  Map<String, dynamic> toJson() => _$PayTotalDataToJson(this);
}

/// 電子レシート情報
@JsonSerializable()
class PayDigitalReceipt {
     /// 取引情報
     @JsonKey(name: 'Transaction')
     PayTransaction? transaction;

  PayDigitalReceipt({
        required this.transaction,
  });

  factory PayDigitalReceipt.fromJson(Map<String, dynamic> json) => _$PayDigitalReceiptFromJson(json);
  Map<String, dynamic> toJson() => _$PayDigitalReceiptToJson(this);
}

/// 取引情報
@JsonSerializable()
class PayTransaction {
    /// レシート日付時刻
    @JsonKey(name: 'ReceiptDateTime')
    String?    receiptDateTime;
    /// POS端末番号
    @JsonKey(name: 'WorkstationID')
    String?    workstationID;  
    /// レシート番号
    @JsonKey(name: 'ReceiptNumber')
    String?    receiptNumber;  
    /// 取引コード
    @JsonKey(name: 'TransactionID')
    String?    transactionID;  
    /// 現状未使用（標準電子レシート用）
    @JsonKey(name: 'ReceiptImage')
    PayReceiptImage? receiptImage;
    /// 現状未使用（標準電子レシート用）
    @JsonKey(name: 'RetailTransaction')
    PayRetailTransaction? retailTransaction;
    @JsonKey(name: 'TRKReceiptImage')
    List<PayTRKReceiptImage>? trkReceiptImageList;

  PayTransaction({
        required this.receiptDateTime,
        required this.workstationID,
        required this.receiptNumber,
        required this.transactionID,
        required this.receiptImage,
        required this.retailTransaction,
        required this.trkReceiptImageList,
  });

  factory PayTransaction.fromJson(Map<String, dynamic> json) => _$PayTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$PayTransactionToJson(this);
}

/// PayReceiptImage
@JsonSerializable()
class PayReceiptImage {
    /// 現状未使用（標準電子レシート用）
    @JsonKey(name: 'ReceiptLine')
    List? receiptLineList;

  PayReceiptImage({
        required this.receiptLineList,
  });

  factory PayReceiptImage.fromJson(Map<String, dynamic> json) => _$PayReceiptImageFromJson(json);
  Map<String, dynamic> toJson() => _$PayReceiptImageToJson(this);
}

/// PayRetailTransaction
@JsonSerializable()
class PayRetailTransaction {
    /// 現状未使用（標準電子レシート用）
    @JsonKey(name: 'LineItem')
    PayLineItem? lineItem;
    /// 現状未使用（標準電子レシート用）
    @JsonKey(name: 'Total')
    List? totalList;
    /// 現状未使用（標準電子レシート用）
    @JsonKey(name: 'Customer')
    String? customer;

  PayRetailTransaction({
        required this.lineItem,
        required this.totalList,
        required this.customer,
  });

  factory PayRetailTransaction.fromJson(Map<String, dynamic> json) => _$PayRetailTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$PayRetailTransactionToJson(this);
}

/// PayLineItem
@JsonSerializable()
class PayLineItem {
    /// 現状未使用（標準電子レシート用）
    @JsonKey(name: 'Sale')
    List? saleList;

  PayLineItem({
        required this.saleList,
  });

  factory PayLineItem.fromJson(Map<String, dynamic> json) => _$PayLineItemFromJson(json);
  Map<String, dynamic> toJson() => _$PayLineItemToJson(this);
}

/// PayTRKReceiptImage
@JsonSerializable()
class PayTRKReceiptImage {
    /// 改行量
    @JsonKey(name: 'LineSpace')
    int?       lineSpace;
    /// "Line"：スタンダード印字/"Page"：ページモード印字
    @JsonKey(name: 'PrintType')
    String?    printType;
    /// "NotCut"：なにもしない/"PartialCut"：パーシャルカット（一部残し）/"FullCut"：フルカット
    @JsonKey(name: 'CutType')
    String?    cutType;
    @JsonKey(name: 'ReceiptLine')
    List? receiptLineList;
    @JsonKey(name: 'PageParts')
    PayPageParts? pageParts;

  PayTRKReceiptImage({
        required this.lineSpace,
        required this.printType,
        required this.cutType,
        required this.receiptLineList,
        required this.pageParts,
  });

  factory PayTRKReceiptImage.fromJson(Map<String, dynamic> json) => _$PayTRKReceiptImageFromJson(json);
  Map<String, dynamic> toJson() => _$PayTRKReceiptImageToJson(this);
}

/// PayPageParts
@JsonSerializable()
class PayPageParts {
    /// 確保領域（幅）
    @JsonKey(name: 'Width')
    int?        width;
    /// 確保領域（高さ）
    @JsonKey(name: 'Height')
    int?        height;
    /// 回転指示
    @JsonKey(name: 'Direction')
    String?     direction;
    /// 回転角度
    @JsonKey(name: 'Rotate')
    String?    rotate;
    @JsonKey(name: 'PartsList')
    List<PayPartsData>? partsDataList;

  PayPageParts({
        required this.width,
        required this.height,
        required this.direction,
        required this.rotate,
        required this.partsDataList,
  });

  factory PayPageParts.fromJson(Map<String, dynamic> json) => _$PayPagePartsFromJson(json);
  Map<String, dynamic> toJson() => _$PayPagePartsToJson(this);
}

/// PayPartsData
@JsonSerializable()
class PayPartsData {
    /// Text：文字印字Rectangle：矩形印字（枠）Line：罫線Image：ビットマップ印字
    @JsonKey(name: 'PartsType')
    String?    partsType;
    /// 開始位置（X）
    @JsonKey(name: 'StartX')
    int?       startX;
    /// 開始位置（Y）
    @JsonKey(name: 'StartY')
    int?       startY;
    /// 終了位置（X） LineとRectangleで使用
    @JsonKey(name: 'EndX')
    int?       endX;
    /// 終了位置（Y） LineとRectangleで使用
    @JsonKey(name: 'EndY')
    int?       endY;
    /// フォントサイズ Textで使用
    @JsonKey(name: 'Font')
    String?    font;
    /// フォントサイズ倍率 Textで使用
    @JsonKey(name: 'Scale')
    String?    scale;
    /// テキスト印字内容 Textで使用
    @JsonKey(name: 'Text')
    String?    text;
    /// 線種類　LineとRectangleで使用
    @JsonKey(name: 'LineStyle')
    String?    lineStyle;
    /// イメージファイル Imageで使用
    @JsonKey(name: 'FileName')
    String?    fileName;
    /// バーコードデータ BarcodeとQRcode　で使用
    @JsonKey(name: 'BarcodeData')
    String?    barcodeData;
    /// バーコードの種類 Barcodeで使用EAN13/EAN8/CODE128
    @JsonKey(name: 'BarcodeType')
    String?    barcodeType;
    /// HRI文字印字位置 Barcodeで使用/None：印字しない/Above：バーコードの上/Below：バーコードの下
    @JsonKey(name: 'HriPosition')
    String?    hriPosition;

  PayPartsData({
        required this.partsType,
        required this.startX,
        required this.startY,
        required this.endX,
        required this.endY,
        required this.font,
        required this.scale,
        required this.text,
        required this.lineStyle,
        required this.fileName,
        required this.barcodeData,
        required this.barcodeType,
        required this.hriPosition,
  });

  factory PayPartsData.fromJson(Map<String, dynamic> json) => _$PayPartsDataFromJson(json);
  Map<String, dynamic> toJson() => _$PayPartsDataToJson(this);
}

@JsonSerializable()
class CashChaChkAmtData {
  // 合計金額
  @JsonKey(name: 'TotalAmt')
  int? totalAmt;
  
  // 釣準備金額
  @JsonKey(name: 'LoanAmt')
  int? loanAmt;
  
  //入金金額
  @JsonKey(name: 'InAmt')
  int? inAmt;
  
  //出金金額
  @JsonKey(name: 'OutAmt')
  int? outAmt;
  
  // 回収金額
  @JsonKey(name: 'PickAmt')
  int? pickAmt;
  
  //その他金額
  @JsonKey(name: 'OtherAmt')
  int? otherAmt;

  CashChaChkAmtData({
        required this.totalAmt,
        required this.loanAmt,
        required this.inAmt,
        required this.outAmt,
        required this.pickAmt,
        required this.otherAmt,
  });

  factory CashChaChkAmtData.fromJson(Map<String, dynamic> json) => _$CashChaChkAmtDataFromJson(json);
  Map<String, dynamic> toJson() => _$CashChaChkAmtDataToJson(this);

}

/// PaychkData
@JsonSerializable()
class PaychkData {
    /// 1:現計　2:会計　3:品券
    @JsonKey(name: 'GroupID')
    int?    groupID;
    /// 支払コード
    @JsonKey(name: 'Code')
    int?    code;
    /// 支払名称（最大半角20文字分）
    @JsonKey(name: 'Name')
    String?    name;
    /// 並び順
    @JsonKey(name: 'Order')
    int?    order;
    /// 理論在高
    @JsonKey(name: 'TheoryAmt')
    int?    theoryAmt;
    /// 釣準備金
    @JsonKey(name: 'LoanAmt')
    int?    loanAmt;
    /// 入金金額
    @JsonKey(name: 'InAmt')
    int?    inAmt;
    /// 出金金額
    @JsonKey(name: 'OutAmt')
    int?    outAmt;
    /// 回収金額
    @JsonKey(name: 'PickAmt')
    int?    pickAmt;

  PaychkData({
        required this.groupID,
        required this.code,
        required this.name,
        required this.order,
        required this.theoryAmt,
        required this.loanAmt,
        required this.inAmt,
        required this.outAmt,
        required this.pickAmt,
  });

  factory PaychkData.fromJson(Map<String, dynamic> json) => _$PaychkDataFromJson(json);
  Map<String, dynamic> toJson() => _$PaychkDataToJson(this);
}

/// 分類情報のレスポンスデータ
@JsonSerializable()
class GetClassInfo {
  /// 返答ステータス　0：エラーなし　０以外：エラー発生
  @JsonKey(name: 'RetSts')
  int?       retSts;
  /// エラーメッセージ　エラーなしの場合はセットしない
  @JsonKey(name: 'ErrMsg')
  String?    errMsg;
  /// 更新日時（YYYY/MM/DD HH:MM:SS）
  /// 今回確認時のAWSシステム時刻を返答する
  /// 次回以降はこの値をrLastUpdatedに使用する
  @JsonKey(name: 'LastUpdated')
  String?    lastUpdated;
  /// 配列の要素はobject
  /// 分類登録用のデータ
  /// 中分類か小分類は企業ごとに変わる
  @JsonKey(name: 'ClsList')
  List<ClsListData>? clsList;

  GetClassInfo({
    required this.retSts,
    required this.errMsg,
    required this.lastUpdated,
    required this.clsList,
  });

  factory GetClassInfo.fromJson(Map<String, dynamic> json) => _$GetClassInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GetClassInfoToJson(this);
}

/// 分類情報取得リスト用データ
@JsonSerializable()
class ClsListData {
  /// 分類コード（中分類か小分類）
  @JsonKey(name: 'Code')
  int?    code;
  /// 分類名称（最大半角20文字分）
  @JsonKey(name: 'Name')
  String?    name;

  ClsListData({
    required this.code,
    required this.name
  });

  factory ClsListData.fromJson(Map<String, dynamic> json) => _$ClsListDataFromJson(json);
  Map<String, dynamic> toJson() => _$ClsListDataToJson(this);
}

