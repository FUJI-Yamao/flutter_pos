/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:json_annotation/json_annotation.dart';

part 'unlock_possibility_socket_model.g.dart';

/// ロック解除可否情報
@JsonSerializable()
class UnlockPossibilityInfo {
  /// ロック状態
  @JsonKey(name: 'UnlockPossibility')
  final bool unlockPossibility;

  /// コンストラクタ
  UnlockPossibilityInfo({
    required this.unlockPossibility,
  });

  factory UnlockPossibilityInfo.fromJson(Map<String, dynamic> json) => _$UnlockPossibilityInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UnlockPossibilityInfoToJson(this);
}
