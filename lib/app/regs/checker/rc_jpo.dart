/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: rc_jpo.h
enum EDY_PAGE {
  EDY_NODSP(0),
  EDY_START(1),
  EDY_AFTER(2),
  EDY_RETRY(3),
  EDY_RETCH(4),
  EDY_AGAIN(5);

  final int id;
  const EDY_PAGE(this.id);
}