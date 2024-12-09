/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import '../inc/sys/tpr_def.dart';
import '../inc/sys/tpr_stat.dart';
import '../inc/sys/tpr_tib.dart';
import '../inc/sys/tpr_type.dart';
import 'tprlib_data.dart';

///  関連tprxソース:TprLibGeneric.c
class TprLibGeneric {
  ///  関連tprxソース:TprLibFindFds()
  static String tprLibFindFds(TprMID mid) {
    int i = 0;
    for (i = 0; i < TprDef.TPRMAXTCT; i++) {
      // MEMO :TprLibMakeDrvInitで初期化されている.
      TprTct data = TprLibData().sysTib.tct[i];
      // search for systask task management table
      if (data.did == mid && data.taskStat == TprStatDef.TPRTST_IDLE) {
        break;
      }
    }

    if (i == TprDef.TPRMAXTCT) {
      // max is ERROR return or pipe descriptor
      return '';
    }
    // 指定されたもののファイルディスクリプタを返す.
    return TprLibData().sysTib.tct[i].fds;
  }
}
