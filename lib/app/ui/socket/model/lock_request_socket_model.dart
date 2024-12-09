/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:json_annotation/json_annotation.dart';

part 'lock_request_socket_model.g.dart';

/// ロック要求情報
@JsonSerializable()
class LockRequestInfo {
  /// ロック状態
  @JsonKey(name: 'LockStatus')
  final bool lockStatus;

  /// コンストラクタ
  LockRequestInfo({
    required this.lockStatus,
  });

  factory LockRequestInfo.fromJson(Map<String, dynamic> json) => _$LockRequestInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LockRequestInfoToJson(this);
}
