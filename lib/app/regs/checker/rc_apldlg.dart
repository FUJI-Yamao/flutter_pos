/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../inc/rc_mem.dart';

class RcApldlg {
  static const WIN_BIG = 70;
  static const LINE_MAX = 6;
  static const CONF_POJI_X_LEFT = 25;
  static const CONF_POJI_X_CENTER = 148;
  static const CONF_POJI_X_RIGHT = 273;
  static const APLDLG_INPUT_MAX = 20;

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側）
  /// ダイアログを表示する
  /// 引数: ダイアログパラメータ
  ///  関連tprxソース: rc_apldlg.c - rcAplDlg
  static void rcAplDlg(DlgParamMem param) {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側）
  /// ダイアログを消去する
  ///  関連tprxソース: rc_apldlg.c - rcAplDlgClear
  static void rcAplDlgClear() {}
}