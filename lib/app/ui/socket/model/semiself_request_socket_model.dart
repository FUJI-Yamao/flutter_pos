/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:json_annotation/json_annotation.dart';

import '../../../../clxos/calc_api_data.dart';
import '../../../../clxos/calc_api_result_data.dart';

part 'semiself_request_socket_model.g.dart';

/// 2人制終了要求情報
@JsonSerializable()
class SemiSelfRequestInfo {

  /// レジ番号
  @JsonKey(name: 'MacNo')
  final int macNo;

  // 取引番号（UUID）
  @JsonKey(name: 'Uuid')
  final String uuid;

  // 呼び戻し
  @JsonKey(name: 'Cancel')
  final bool cancel;

  // p_cart_logインサートクエリ
  @JsonKey(name: 'CartLogQuery')
  final List<String>? cartLogQuery;

  // アイテムリスト
  @JsonKey(name: 'CalcResultPay')
  final CalcResultPay? calcResultPay;

  // 支払いリクエストパラメータ
  @JsonKey(name: 'CalcRequestParaPay')
  final CalcRequestParaPay? requestParaPay;

  /// コンストラクタ
  SemiSelfRequestInfo({
    required this.macNo,
    required this.uuid,
    required this.cancel,
    this.cartLogQuery,
    this.calcResultPay,
    this.requestParaPay,
  });

  factory SemiSelfRequestInfo.fromJson(Map<String, dynamic> json) => _$SemiSelfRequestInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SemiSelfRequestInfoToJson(this);
}
