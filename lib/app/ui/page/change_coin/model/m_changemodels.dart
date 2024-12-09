/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';

import '../../../../inc/lib/if_acx.dart';

/// 紙幣/硬貨の種別
enum BillCoinType {
  bill,  // 紙幣
  coin, // 硬貨
}

/// 各金種の状態表示種別
enum HolderViewType {
  normal,       // 通常表示
  empty,        // 空
  nearEnd,      // ニアエンド
  needSupply,   // 補充してください
  needCollect,  // 回収してください
}

/// 各金種の在高情報
class ChangeData {
  /// 紙幣/硬貨の種別
  BillCoinType billCoinType;

  /// 金額
  int amount;

  /// 枚数
  int count;

  /// 状態表示の種別
  HolderFlagList kindFlg;

  /// 各金種の在高割合
  int percentage;

  /// 状態表示の文字色
  Color color;

  /// 在高割合のバー表示色
  Color barColor;

  /// コンストラクタ
  ChangeData({
    required this.billCoinType,
    required this.amount,
    required this.count,
    required this.kindFlg,
    required this.percentage,
    required this.color,
    required this.barColor,
  });
}
