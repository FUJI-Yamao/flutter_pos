/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'rcstllcd.dart';

/// 関連tprxソース:rcky_extkey.c
class RcKyExtKey {
  /// 拡張小計画面を終了
  /// 関連tprxソース:rcky_extkey.c - rcKyExtKey_End
  static void rcKyExtKeyEnd(){
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース:rcky_extkey.c - rcChk_Ky_ExtKey_Act
  static int rcChkKyExtKeyAct(){
    return 0;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース:rcky_extkey.c - rcKyExtKey_Com
  static void rcKyExtKeyCom(ExtkyType type) {
    return;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース:rcky_extkey.c - rcKyExtKey_Quit
  static void rcKyExtKeyQuit(SubttlInfo subTtl) {
  }
}