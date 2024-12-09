/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///関連tprxソース:rxmemassort.h - RXMEMASSORT
class RxMemAssort {
  int mark = 0;
  int typ = 0;        /* 1:qty ZERO 2: amt ZERO  3: mbr amt ZERO (bit)*/
  int flg = 0;        /* 1:assort 2:start 3:end (bit)*/
  int qty = 0;        /* qty */
  int amt = 0;        /* amt */
  int mamt = 0;       /* member amt */
  List<String> name = List.filled(201, ''); /* name       */
  int repetFlg = 0;
  int mulCnt = 0;
  int taxDiff = 0;    /* セット商品内の税コードの差異  0:無し 1:有り */
  int orgAmt = 0;     /* amt        */
  int orgMamt = 0;    /* member amt */
  int invoiceFlg = 0; /* 免税事業者商品　0:課税商品　1：全セット商品免税事業者商品　2：一部セット商品が免税事業者商品（混在）*/
}