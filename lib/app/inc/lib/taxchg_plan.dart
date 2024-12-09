/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../sys/tpr_type.dart';

///  関連tprxソース: taxchg_plan.c
class TacchgPlan{
  //---------------------------------------------------------------------------------
  //	Values
  //---------------------------------------------------------------------------------
  static const PLAN_RESULT_LOG_NAME	= "taxchg_plan_log.txt";	// 開設 印字用実行結果ログファイル
  static const	PLAN_PRINT_LOG_NAME	= "taxchg_plan_print.txt";	// 開設 印字用実行結果ログファイル (印字対象となる)
}

// 予約変更の結果印字のためのタイプ
///  関連tprxソース: taxchg_plan.c - TAXCHG_PLAN_LOG_TYPE
enum TaxchgPlanLogType {
  TAXCHG_PLAN_LOG_CHECK(0), // 印字すべきファイルがあるかチェック
  TAXCHG_PLAN_LOG_RENAME(1), // 印字対象のファイル名称に変更 (ループで確認しているため名称を変更する)
  TAXCHG_PLAN_LOG_PRINT_CHECK(2), // 印字対象のファイルがあるかチェック
  TAXCHG_PLAN_LOG_REMOVE(3); // 印字すべきファイル, 印字対象のファイルを削除

  final int typ;
  const TaxchgPlanLogType(this.typ);
}

/// 税種予約変更を実行・終了時に渡す構造体
///  関連tprxソース: taxchg_plan.c - TaxChgPlanStruct
class TaxChgPlanStruct {
  int result = 0; // 終了時の戻り値
  int afterFunc = 0; // 実行後の戻り関数
  TprMID tid = 0; // 実行タスクID
  String date = ''; // 実行する時の営業日(YYYYMMDD)  NULLの場合はシステム日付を使用
  String logPath = ''; // 実行結果ファイル名称
}
