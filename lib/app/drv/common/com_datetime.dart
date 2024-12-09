/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:intl/intl.dart';

/// 現在時刻をテキストで返却する。
/// 引数:なし
/// 戻り値：現在時刻（String）
/// 関連tprxソース:com_datetime.c   drv_DateTime()
String drv_DateTime()
{
  DateTime dt = DateTime.now();
  var dtFormat = DateFormat("yyyy/MM/dd HH:mm:ss");
  String retm = dt.microsecond.toString();
  String ret = dtFormat.format(dt) + "." + retm;
  return ret;
}
