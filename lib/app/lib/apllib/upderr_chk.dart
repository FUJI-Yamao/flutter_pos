/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

/// 関連tprxソース: UpdErr_Chk.c
class UpdErrChk {
  static int updErrChkFlgSave = 0;

  /// 関連tprxソース: UpdErr_Chk.c - UpdErrSaveReset
  static void updErrSaveReset(TprMID tid) {
    TprLog().logAdd(tid, LogLevelDefine.normal, "UpdErrSaveReset\n");
    updErrChkFlgSave = 0;
  }
}