/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'cnct.dart';
import 'recog.dart';

/// 関連tprxソース: qcjccom.c
class QCJCCom {
  /// QCJC仕様の各種チェックフラグをONにする
  /// 引数: タスクID
  /// 関連tprxソース: qcjc_com.c - qcjc_jc_chk_on()
  static void qcjcJcChkOn(TprTID tid) {
    TprLog().logAdd(tid, LogLevelDefine.normal, "QCJCCom.qcjcJcChkOn()");

    Cnct.cnctTypeOn();
    Cnct.cnctChkSioOn();
    Recog().recog_type_on();
  }
}
