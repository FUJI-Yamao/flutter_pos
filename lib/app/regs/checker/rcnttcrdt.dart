/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../../common/cmn_sysfunc.dart';
import '../inc/rc_mem.dart';

/// 関連tprxソース: rcnttcrdt.c
class RcNttCrdt{
  /// 関連tprxソース: rcnttcrdt.c - rcChk_NttCrdtAutoCan
  static Future<bool> rcChkNttCrdtAutoCan() async {
    AcMem cMem = SystemFunc.readAcMem();

    return ((await CmCksys.cmNttaspSystem() != 0) &&
        ((cMem.working.crdtReg.stat & 0x0002) != 0));
  }
}

