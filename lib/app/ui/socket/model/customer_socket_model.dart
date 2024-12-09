/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:json_annotation/json_annotation.dart';

part 'customer_socket_model.g.dart';

/// 自動従業員情報
@JsonSerializable()
class AutoStaffInfo {
  /// 企業コード
  @JsonKey(name: 'CompCd')
  final int compCd;

  /// 店舗コード
  @JsonKey(name: 'StreCd')
  final int streCd;

  /// マシン番号
  @JsonKey(name: 'MacNo')
  final int macNo;

  /// 従業員コード
  @JsonKey(name: 'StaffCd')
  final String staffCd;

  /// コンストラクタ
  AutoStaffInfo({
    required this.compCd,
    required this.streCd,
    required this.macNo,
    required this.staffCd,
  });

  factory AutoStaffInfo.fromJson(Map<String, dynamic> json) => _$AutoStaffInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AutoStaffInfoToJson(this);
}
