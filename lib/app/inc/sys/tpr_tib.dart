/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:io';

import 'tpr_def.dart';
import 'tpr_type.dart';

///
/// 関連tprxソース:tprtid.h
///
class TprTib {
  int sysPi = 0;
  List<TprTct> tct = List.generate(TprDef.TPRMAXTCT, (_) => TprTct());
}

/// 関連tprxソース:tprtct.h - tprtct
class TprTct {
  String fds = '';  //既存はファイルディスクリプタ dart置き換え後はファイルパスに変更
  TprTID tid = 0;
  TprTID did = 0;
  TprTST taskStat = 0;
  // pid_t		pid;		/* process id */ // pid_tの定義が見つからず.intかStringだと思われる.
  int pid = 0;
}
