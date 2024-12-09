/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 顧客種別
enum MemberKind {
  none(''),                      // 会員なし
  rara('会員RARA'),               // RARA会員
  raraPreca('RARAプリカ'),        // RARAプリカ会員
  raraHouse('RARAハウス'),        // RARAハウス会員
  employee('社員'),               // 社員
  raraCredit('会員RARA'),         // RARAクレジット会員
  raraCreditEmployee('社員 RARA'), // RARAクレジット会員＋社員
  memberPrice('会員売価'),         // 会員売価
  employeePrice('社員売価');       // 社員売価

  const MemberKind(this.memberKindName);

  /// 起動パラメータで指定される文字列
  final String memberKindName;
}
