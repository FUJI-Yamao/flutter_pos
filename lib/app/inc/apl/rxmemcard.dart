/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class RxMemCard {
  int	typ = 0;     	/* card type 0:non 1:staff 2:member 3:crdt member 4:others */
  int	jis1flg = 0;	/* 0: non 1: set Teack 2 data    (jis1) */
  int	jis2flg = 0;	/* 0: non 1: set Additional data (jis2) */
  String	jis1 = ''; 	/* Track 2 data    */
  String	jis2 = ''; 	/* Additional data */
  String chkcd = '';  /* scan card check code */
}