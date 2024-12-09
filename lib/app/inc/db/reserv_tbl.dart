/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース:reserv_tbl.h
class reserv_tbl{
  String   number = "";          /* number */
  String   cust_no = "";         /* customer No. */
  String   cust_name = "";       /* customer name */
  String   telno = "";           /* telephone number */
  String   address = "";         /* address */
  String   recept_date = "";     /* recept date */
  String   ferry_date = "";      /* ferry date */
  String   arrival_date = "";    /* arrival date */
  int   qty = 0;                 /* quantity */
  int   ttl = 0;                 /* total amount */
  int   advance_money = 0;       /* advance money */
  String   memo1 = "";           /* memo 1 */
  String   memo2 = "";           /* memo 2 */
  int  finish = 0;               /* finish flag */
}