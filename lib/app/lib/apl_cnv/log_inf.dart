/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/db/c_itemlog_sts.dart';
import '../../inc/lib/apl_cnv.dart';
import 'log_mref.dart';


///  関連tprxソース:log_inf.c
class LogInf {
  static const only_0field = 0;
  static const only_1field = 1;

  static RegsMem mem = SystemFunc.readRegsMem();

  // TODO:10123 ログデータチェック (log_inf.c)
  static List<TFuncData> tItemlogData = [];
  static List<TFuncData> tBdllogData = [];
  static List<TFuncData> tStmlogData = [];
  static List<TFuncData> tCrdtlogData = [];
  static List<TFuncData> tTtllogData = [];
}
