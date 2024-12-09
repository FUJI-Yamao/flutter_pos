/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_atct.dart';

/// 関連tprxソース:rcpw410_com.c
class RcPW410Com {

  /// 関連tprxソース:rcpw410_com.c rcPW410_Write_Proc()
  static void rcPW410WriteProc(TendType? wTendType) {
    ///TODO:00014 日向 現計対応のため定義のみ先行追加
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:rcpw410_com.c rcAbsPrepaid_MainProc(short)
  static void rcAbsPrepaidMainProc(int){
    return;
  }

}