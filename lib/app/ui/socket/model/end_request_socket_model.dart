/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:json_annotation/json_annotation.dart';

part 'end_request_socket_model.g.dart';

/// 2人制終了要求情報
@JsonSerializable()
class EndRequestInfo {
  /// 自動終了
  @JsonKey(name: 'IsAuto')
  final bool isAuto;

  /// コンストラクタ
  EndRequestInfo({
    required this.isAuto,
  });

  factory EndRequestInfo.fromJson(Map<String, dynamic> json) => _$EndRequestInfoFromJson(json);
  Map<String, dynamic> toJson() => _$EndRequestInfoToJson(this);
}
