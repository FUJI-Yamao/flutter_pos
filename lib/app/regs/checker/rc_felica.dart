/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_atct.dart';

/// 関連tprxソース:rc_felica.c
class RcFeliCa {

  /// 関連tprxソース:rc_felica.c rcFeliCa_Write_Proc()
  static void rcFeliCaWriteProc() {
    ///TODO:00014 日向 現計対応のため定義のみ先行追加
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース:rc_felica.c rcFeliCa_Read_Proc()
  static int rcFeliCaReadProc() {
    return 0;
  }
}