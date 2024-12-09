/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/sys/tpr_type.dart';

///関連tprxソース: qcjc_lib.c
class QCJCLib {
  /// QCasherJC仕様かどうか
  /// 関連tprxソース: qcjc_lib.c - qcjc_system()
  static bool qcjcSystem(TprTID tid) {
    // TODO:10023 QCJC仕様

    return false;
  }

  /// 関連tprxソース: qcjc_lib.c - qcjc_c_setini_macno()
  static bool qcjcCSetiniMacno(TprTID tid) {
    // TODO:10023 QCJC仕様

    return false;
  }
}
