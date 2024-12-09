/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///関連tprxソース:rxmemvoid.h - RXMEMVOID構造体
class RxMemVoid {
  int voidFlg = 0;		/* 1: 全訂正  2: 一部訂正 */
  int realQty = 0;		/* 訂正残点数             */
  int itemTtlQty = 0;	/* 訂正済み点数           */
  int nextFlg = 0;		/* 商品またぎフラグ(Temp) */
  int end_recFlg = 0;	/* 訂正完了フラグ  (Temp) */
  int prc_voidFlg = 0;	/* 置数訂正フラグ  (Temp) */
}