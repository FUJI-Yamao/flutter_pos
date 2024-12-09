/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'rcstllcd.dart';

///  関連tprxソース: rc28addparts.c
class Rc28AddParts {
  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// ガイダンスメッセージ部のテキストセット
  ///  関連tprxソース: rc28addparts.c - rc28GuidanceMsgBoxTextSet
  static void rc28GuidanceMsgBoxTextSet() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// ガイダンス表示部のリセット処理
  /// 引数: サブタイトルデータ
  ///  関連tprxソース: rc28addparts.c - rc28GuidanceDestroy
  static void rc28GuidanceDestroy(SubttlInfo pSubTtl) {}
}
