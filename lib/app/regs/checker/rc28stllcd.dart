/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'rcstllcd.dart';

///  関連tprxソース: rc28stllcd.c
class Rc28StlLcd {
  // TODO:00002 佐野 - rcClr2ndMbrClr()実装の為、定義のみ追加
  /// Subtotal Display Function (Change part)
  /// 引数:[wChgCtrl] Change Control
  /// 引数:[pSubttl] サブタイトル部のデータ
  ///  関連tprxソース: rc28stllcd.c - rc28StlLcd_Change
  static void rc28StlLcdChange(int wChgCtrl, SubttlInfo pSubttl) {}
}
