/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/sys/syst/sys_data.dart';

import '../../inc/sys/tpr_log.dart';

/// 関連tprxソース: sysIdol.c
class SysIdol {
  /// Usage:    int  sysIdolbufInit( void )
  /// Functions: mecha-key buffer initialize
  /// /// 関連tprxソース: sysIdol.c - sysIdolbufInit
  static int sysIdolBufInit() {
    TprLog().logAdd(0, LogLevelDefine.fCall, "sysIdolbufInit() ....done\n");

    SysData().sysTouKyCalCnt = 0;
    SysData().tprIdolKeyBuf = ''; // 初期化

    return 0;
  }
}
