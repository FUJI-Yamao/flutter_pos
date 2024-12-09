/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース:rxmembdl.h - RXMEMBDL
class RxMemBdl {
  int bdlCd = 0;
  int limitCnt = 0;
  int limit = 0;
  int dspFlg = 0;
  int bdlPrc = 0;
  int mbdlPrc = 0;
  int limitPrc = 0;
  int saleQty = 0;
}

/// 関連tprxソース:rxmembdl.h - RXMEMBDL_TAXFREE_ORG
class RxMemBdlTaxFreeOrg {
  int formPrc1 = 0; // 成立金額1
  int formPrc2 = 0; // 成立金額2
  int formPrc3 = 0; // 成立金額3
  int formPrc4 = 0; // 成立金額4
  int formPrc5 = 0; // 成立金額5
  int avPrc = 0; // 成立後平均単価
  int custFormPrc1 = 0; // 会員成立金額1
  int custFormPrc2 = 0; // 会員成立金額2
  int custFormPrc3 = 0; // 会員成立金額3
  int custFormPrc4 = 0; // 会員成立金額4
  int custFormPrc5 = 0; // 会員成立金額5
  int custAvPrc = 0; // 成立後会員平均単価
}
