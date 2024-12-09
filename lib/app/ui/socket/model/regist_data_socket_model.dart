/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:json_annotation/json_annotation.dart';

part 'regist_data_socket_model.g.dart';

/// 登録データ情報
@JsonSerializable()
class RegistDataInfo {
  /// todo ダミー　後で削除
  @JsonKey(name: 'Dummy')
  final int dummy;

  /// コンストラクタ
  RegistDataInfo({
    required this.dummy,
  });

  factory RegistDataInfo.fromJson(Map<String, dynamic> json) => _$RegistDataInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RegistDataInfoToJson(this);
}
