/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'rcstllcd.dart';

class RcSptendInfo {
  /// TODO:00010 長田 定義のみ追加 必要か検討
  ///  関連tprxソース: rcsptendinfo.c - rcSptendInfo_Quit
  // static void	rcSptendInfo_Quit(Subttl_Info pSubttl) {
  //   return ;
  // }

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// スプリットの選択枠を表示／非表示する
  ///  関連tprxソース: rcsptendinfo.c - rcSptendInfo_SelectFrmDsp
  static void rcSptendInfoSelectFrmDsp(SubttlInfo? pSubttl, int selectNo, int dspFlg) {}
}