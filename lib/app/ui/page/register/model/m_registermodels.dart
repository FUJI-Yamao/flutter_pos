/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

// 商品一覧（値引きエリア(discount)は動的に増やす予定String→Listに変更予定）

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../inc/apl/t_item_log.dart';
import '../../../../ui/language/l_languagedbcall.dart';

/// Purchase discountの詳細
class Purchase {
  /// itemLogのindex
  int itemLogIndex;

  /// 購入商品データ.
  TItemLog itemLog;

  ///登録商品削除されてるかどうか
  bool isDeleted;

  ///　コンストラクタ
  Purchase(
      {required this.itemLog, required this.itemLogIndex, this.isDeleted = false});
}

/// Purchase discountの詳細
class Discount {
  /// タイトル
  String title;

  ///　割引率
  String percent;

  ///　割引額
  String discountAmount;

  ///　コンストラクタ
  Discount({
    required this.title,
    required this.percent,
    required this.discountAmount,
  });
}

/// 精算機待機状態管理
class PaymachineState {
  ///　タイトル
  final RxString title;

  /// インデックス
  final RxInt idx;

  ///　ニアエンド状態ステータス
  final RxString nearstate;

  ///　状態ステータス
  final RxString state;

  final Function function;

  ///コンストラクタ
  PaymachineState({required String title,
    required int idx,
    required String nearstate,
    required String state,
    required this.function
  }) : title = title.obs,
        idx = idx.obs,
        nearstate = nearstate.obs,
        state = state.obs;
}

/// 精算機状態種類
class PayStatusInfo {
  ///　インデックス
  final int idx;

  ///　ニアエンド状態ステータス
  final String nearstatus;

  ///　状態ステータス
  final String status;

  ///　コンストラクタ
  PayStatusInfo(
      {required this.idx, required this.nearstatus, required this.status});

  ///　休止中
  static final pause = PayStatusInfo(
      idx: 1, nearstatus: '釣銭不足', status: '休止中');

  ///　使用中
  static final use = PayStatusInfo(
      idx: 2, nearstatus: '釣銭不足', status: '使用中');

  ///　ニアエンド待機中
  static final nearend = PayStatusInfo(
      idx: 3, nearstatus: '釣銭不足', status: '休止中');

  ///　待機中
  static final standby = PayStatusInfo(
      idx: 4, nearstatus: '', status: '待機中');
}

/// 状態判定
enum PaymentStatus {
  /// 休止中
  pause(1),

  /// 使用中
  use(2),

  /// ニアエンド待機中
  nearend(3),

  /// 待機中
  standby(4);

  ///コンストラクタ
  const PaymentStatus(this.idx);

  ///インデックス
  final int idx;
}

/// PLUタブコンストラクター
class PluTabData {
  ///　タイトル
  final String title;

  ///　色
  final Color color;

  ///　コンストラクタ
  const PluTabData({required this.title, required this.color});
}
