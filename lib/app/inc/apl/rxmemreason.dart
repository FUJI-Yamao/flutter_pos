/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../db_library/src/db_manipulation.dart';

///関連tprxソース:rxmemreason.h - RXMEMREASON構造体
class RxMemReason {
  int stat = 0;
  int reasonCd = 0;  // 理由区分
  int kindCd = 0;  // 区分コード
  String name = "";  // 理由区分名称
  int reasonStat = 0;
  CDivideMstColumns reasonMst = CDivideMstColumns();      // 選択結果格納
}

///関連tprxソース:rxmemreason.h - RXMEMSTFRELEASE構造体
class RxMemStfRelease {
  int stfReleaseStat = -1;  // 1:入力有り  -1:入力なし
  int fncCode = 0;  // キー押下情報保持
  String name = "";  // 権限解除を行った従業員名
  CStaffMst tmpStaff = CStaffMst();	// 権限解除を行った従業員
  CStaffMst	staff = CStaffMst();		// オープンした従業員
}