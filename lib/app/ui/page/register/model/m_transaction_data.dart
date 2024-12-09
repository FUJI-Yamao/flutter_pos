/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:json_annotation/json_annotation.dart';

import '../../../../../clxos/calc_api_data.dart';
import '../../../../../clxos/calc_api_result_data.dart';

part 'm_transaction_data.g.dart';

/// トランザクションデータのリスト
@JsonSerializable()
class TransactionDataList {
  /// トランザクションデータのリスト
  @JsonKey(name: 'TransactionDataList')
  List<TransactionData> list;

  /// コンストラクタ
  TransactionDataList({
    required this.list,
  });

  /// 初期化コンストラクタ
  TransactionDataList.init() : this(list: [TransactionData.init()]);

  /// fromJson
  factory TransactionDataList.fromJson(Map<String, dynamic> json) => _$TransactionDataListFromJson(json);

  /// toJson
  Map<String, dynamic> toJson() => _$TransactionDataListToJson(this);
}

/// トランザクションデータ
@JsonSerializable()
class TransactionData {
  /// 企業コード
  @JsonKey(name: 'CompCd', includeFromJson: true, includeToJson: true)
  int? _compCd;

  /// 店舗コード
  @JsonKey(name: 'StreCd', includeFromJson: true, includeToJson: true)
  int? _streCd;

  /// マシン番号
  @JsonKey(name: 'MacNo', includeFromJson: true, includeToJson: true)
  int? _macNo;

  /// 取引別のUUID
  @JsonKey(name: 'Uuid', includeFromJson: true, includeToJson: true)
  String? _uuid;

  /// 返品操作フラグ
  @JsonKey(name: 'RefundFlag', includeFromJson: true, includeToJson: true)
  int? _refundFlag;
  bool get isRefund => _refundFlag != null && _refundFlag != 0;

  /// 返品操作日（YYYY-MM-DD）
  @JsonKey(name: 'RefundDate', includeFromJson: true, includeToJson: true)
  String? _refundDate;
  String get refundDate => _refundDate ?? '';

  /// オペモード
  @JsonKey(name: 'OpeMode', includeFromJson: true, includeToJson: true)
  int? _opeMode;

  /// 価格セットモード
  @JsonKey(name: 'PriceMode', includeFromJson: true, includeToJson: true)
  int? _priceMode;

  /// POS動作仕様
  @JsonKey(name: 'PosSpec', includeFromJson: true, includeToJson: true)
  int? _posSpec;

  /// ユーザ別情報
  @JsonKey(name: 'ArcsInfo', includeFromJson: true, includeToJson: true)
  ArcsInfo? _arcsInfo;

  /// クラウドPOSへ商品登録の結果
  @JsonKey(name: 'CalcResultItem', includeFromJson: true, includeToJson: true)
  CalcResultItem? _lastResultData;
  CalcResultItem get lastResultData => _lastResultData!;    // isExsitData関数で確認した後に使用すること！

  /// 警告商品のダイアログ表示実績
  @JsonKey(name: 'IsAlreadyWarning', includeFromJson: true, includeToJson: true)
  bool? _isAlreadyWarning;
  bool get isAlreadyWarning => _isAlreadyWarning ?? false;

  ///　コンストラクタ
  TransactionData();

  /// init
  factory TransactionData.init() => TransactionData.fromJson({});

  /// fromJson
  factory TransactionData.fromJson(Map<String, dynamic> json) => _$TransactionDataFromJson(json);

  /// toJson
  Map<String, dynamic> toJson() => _$TransactionDataToJson(this);

  /// リクエストデータの取得
  CalcRequestParaItem? getRequestData() {
    if (_lastResultData != null
        && _compCd != null
        && _streCd != null
        && _uuid != null) {
      CalcRequestParaItem requestData =  CalcRequestParaItem(
        compCd: _compCd!,
        streCd: _streCd!,
      );
      requestData.itemList = _itemList(_lastResultData!);
      requestData.custCode = _lastResultData!.custData?.custCode ?? '';
      requestData.subttlList = _subttlList(_lastResultData!);
      requestData.macNo = _macNo;
      requestData.uuid = _uuid!;
      requestData.refundFlag = _refundFlag;
      requestData.opeMode = _opeMode;
      requestData.priceMode = _priceMode;
      requestData.posSpec = _posSpec;
      requestData.arcsInfo = _arcsInfo;

      return requestData;
    } else {
      // レスポンスデータが存在しない時は、リクエストデータも存在しない
      return null;
    }
  }

  /// 商品情報リストの作成
  List<ItemData> _itemList(CalcResultItem lastResultData) {
    List<ItemData> list = [];

    List<ResultItemData>? calcResultItemList = lastResultData.calcResultItemList;
    if (calcResultItemList != null) {
      for (ResultItemData data in calcResultItemList) {
        if (data.seqNo != null
        && data.qty != null
        && data.orgBarcode1 != null) {
          list.add(
            ItemData(
              seqNo: data.seqNo!,
              qty: data.qty!,
              type: data.type ?? 0,
              barcode1: data.orgBarcode1!,
              barcode2: data.orgBarcode2 ?? '',
              cnctTime: data.scanTime!,
              itemDscType: data.itemDscType,
              itemDscVal: data.itemDscVal,
              itemDscCode: data.itemDscCode,
              prcChgVal: data.prcChgVal,
              clsNo: data.clsNo!,
              clsVal: data.clsVal,
              decimalVal: data.decimalVal ?? '',
            ),
          );
        }
      }
    }

    return list;
  }

  /// 小計値下情報の作成
  List<SubttlData> _subttlList(CalcResultItem lastResultData) {
    List<SubttlData> list = [];

    List<SubttlResData>? subttlList = lastResultData.subttlList;
    if (subttlList != null) {
      for (SubttlResData data in subttlList) {
        list.add(
            SubttlData(
              stlDscCode: data.stlDscCode,
              stlDscVal: data.stlDscVal,
            )
        );
      }
    }

    return list;
  }

  /// 更新
  void set({
    required CalcRequestParaItem lastRequestData,
    required CalcResultItem lastResultData,
    required String refundDate,
    required bool? isAlreadyWarning
  }) {
    // 企業コード
    _compCd = lastRequestData.compCd;

    // 店舗コード
    _streCd = lastRequestData.streCd;

    // マシン番号
    _macNo = lastRequestData.macNo;

    // 取引別のUUID
    _uuid = lastRequestData.uuid;

    // 返品操作フラグ
    _refundFlag = lastRequestData.refundFlag;

    // 返品操作日（YYYY-MM-DD）
    _refundDate = refundDate;

    // オペモード
    _opeMode = lastRequestData.opeMode;

    // 価格セットモード
    _priceMode = lastRequestData.priceMode;

    // POS動作仕様
    _posSpec = lastRequestData.posSpec;

    // ユーザ別情報
    _arcsInfo = lastRequestData.arcsInfo;

    // レスポンスデータ
    _lastResultData = lastResultData;

    if (isAlreadyWarning != null) {
      // 警告商品のダイアログ表示実績
      _isAlreadyWarning = isAlreadyWarning;
    }
  }

  /// トランザクションデータが存在するか
  bool isExsitData() {
    return _lastResultData != null;
  }
}
