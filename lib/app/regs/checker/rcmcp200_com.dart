/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'rc_atct.dart';

/// 関連tprxソース: rcmcp200_com.c
class RcMcp200Com {
  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcmcp200_com - rcMcp200_Write_Proc()
  static void rcMcp200WriteProc(TendType? wTendType) {
    return;
  }

  // TODO:00002 佐野 - rcCrdtVoidEnd()実装の為、定義のみ追加
  /// 排出/リセット処理
  ///  関連tprxソース: rcmcp200_com.c - rcMcp200_Reset_Proc
  static void rcMcp200ResetProc() {}
}