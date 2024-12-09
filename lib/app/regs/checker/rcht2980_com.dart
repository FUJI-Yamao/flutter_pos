/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_atct.dart';
import 'rc_atct.dart';

/// 関連tprxソース: rcht2980_com.c
class RcHt2980Com {
  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcht2980_com - rcHt2980_Write_Proc()
  static void rcHt2980WriteProc(TendType? wTendType) {
    return;
  }

  // TODO:00002 佐野 - rcCrdtVoidEnd()実装の為、定義のみ追加
  /// 排出/リセット処理（Hitachi BlueChip Card）
  ///  関連tprxソース: rcht2980_com.c - rcHt2980_Reset_Proc
  static void rcHt2980ResetProc() {}
}