/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:json_annotation/json_annotation.dart';

part 'dual_response_socket_model.g.dart';

/// 2人制応答情報
@JsonSerializable()
class DualResponseInfo {
  /// 応答結果
  @JsonKey(name: 'Result')
  final bool result;

  /// 自動終了
  @JsonKey(name: 'IsAuto')
  final bool isAuto;

  /// エラー情報
  @JsonKey(name: 'Error')
  final int error;

  /// コンストラクタ
  DualResponseInfo({
    required this.result,
    required this.isAuto,
    required this.error,
  });

  factory DualResponseInfo.fromJson(Map<String, dynamic> json) => _$DualResponseInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DualResponseInfoToJson(this);
}
