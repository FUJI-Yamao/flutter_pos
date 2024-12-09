/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:json_annotation/json_annotation.dart';

import '../../../../clxos/calc_api_data.dart';
import '../../../../clxos/calc_api_result_data.dart';

part 'semiself_response_socket_model.g.dart';

/// セミセルフ応答情報
@JsonSerializable()
class SemiSelfResponseInfo {
  /// 応答結果
  @JsonKey(name: 'Result')
  bool result;

  /// ステータス
  @JsonKey(name: 'Status')
  String status;

  /// ステータス
  @JsonKey(name: 'CautionStatus')
  String cautionStatus;

  // 取引番号（UUID）
  @JsonKey(name: 'Uuid')
  String uuid;

  // アイテムリスト
  @JsonKey(name: 'CalcResultPay')
  CalcResultPay? calcResultPay;

  // 支払いリクエストパラメータ
  @JsonKey(name: 'CalcRequestParaPay')
  CalcRequestParaPay? calcRequestParaPay;

  /// 支払い取りやめ
  @JsonKey(name: 'Cancel')
  bool cancel;

  /// エラー情報
  @JsonKey(name: 'ErrNo')
  int errNo;

  /// コンストラクタ
  SemiSelfResponseInfo({
    required this.result,
    required this.status,
    required this.cautionStatus,
    required this.uuid,
    required this.calcResultPay,
    required this.calcRequestParaPay,
    required this.cancel,
    required this.errNo,
  });

  factory SemiSelfResponseInfo.fromJson(Map<String, dynamic> json) => _$SemiSelfResponseInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SemiSelfResponseInfoToJson(this);
}
