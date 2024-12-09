/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_atct.dart';
import 'rc_atct.dart';

/// 関連tprxソース:rccrwp_com.c
class RcCrwpCom {

  /// 関連tprxソース:rccrwp_com.c rcCrwp_Write_MainProc()
  static void rcCrwpWriteMainProc(TendType? wTendType) {
    ///TODO:00014 日向 現計対応のため定義のみ先行追加
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース:rccrwp_com.c rcCrwp_Read_MainProc()
  static int rcCrwpReadMainProc() {
    return 0;
  }

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 排出/リセット処理（Point Card）
  ///  関連tprxソース: rccrwp_com.c - rcCrwp_Reset_Proc
  static void rcCrwpResetProc() {}
}