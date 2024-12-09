/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_atct.dart';
import 'rc_atct.dart';

/// 関連tprxソース: rcabs_v31.c
class RcAbsV31 {
  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcabs_v31 - rcAbs_V31_Write_Proc()
  static void rcAbsV31WriteProc(TendType? wTendType) {
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rcabs_v31.c - rcAbs_V31_Read_Proc()
  static int rcAbsV31ReadProc() {
    return 0;
  }

  // TODO:00002 佐野 -checker関数実装の為、定義のみ追加
  /// 排出/リセット処理（ABS_v31 R/W System）
  ///  関連tprxソース: rcorc_com.c - rcAbs_V31_Reset_Proc
  static void rcAbsV31ResetProc() {}
}