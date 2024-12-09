/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_atct.dart';
import 'rc_atct.dart';

/// 関連tprxソース:rcsapporo_pana_com.c
class RcSapporoPanaCom {

  /// 関連tprxソース:rcsapporo_pana_com.c rcSapporo_Pana_Write_Proc()
  static void rcSapporoPanaWriteProc(TendType? wTendType) {
    ///TODO:00014 日向 現計対応のため定義のみ先行追加
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース:rcsapporo_pana_com.c rcSapporo_Pana_Read_Proc()
  static int rcSapporoPanaReadProc() {
    return 0;
  }

  // TODO:00002 佐野 - rcCrdtVoidEnd()実装の為、定義のみ追加
  /// 排出/リセット処理（Sapporo Pana Card）
  ///  関連tprxソース: rcsapporo_pana_com.c - rcSapporo_Pana_Reset_Proc
  static void rcSapporoPanaResetProc() {}
}