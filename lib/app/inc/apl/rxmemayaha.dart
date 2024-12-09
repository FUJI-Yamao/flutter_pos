/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///関連tprxソース:rxmemayaha.h - struct RXMEMAYAHA
class RxMemAyaha {
  int mileagePoint = 0;		/* 累計マイレージポイント */
  int mileagePrintFlg = 0;	/* マイレージポイント印字フラグ */
  int brgnschPromNo1 = 0;		/* 特売企画ＮＯ１（１～９９９９９９） */
  int brgnschPromNo2 = 0;		/* 特売企画ＮＯ２（１～９９９９９９） */
  int brgnschPromNo3 = 0;		/* 特売企画ＮＯ３（１～９９９９９９） */
  int brgnschPromNo4 = 0;		/* 特売企画ＮＯ４（１～９９９９９９） */
  int brgnschPromNo5 = 0;		/* 特売企画ＮＯ５（１～９９９９９９） */
  int brgnschPromNo6 = 0;		/* 特売企画ＮＯ６（１～９９９９９９） */
  int brgnschPromNo7 = 0;		/* 特売企画ＮＯ７（１～９９９９９９） */
  int brgnschPromNo8 = 0;		/* 特売企画ＮＯ８（１～９９９９９９） */
  int pluschPromNo1 = 0;		/* 商品ポイント企画ＮＯ１（１～９９９９９９） */
  int pluschPromNo2 = 0;		/* 商品ポイント企画ＮＯ２（１～９９９９９９） */
  int pluschPromNo3 = 0;		/* 商品ポイント企画ＮＯ３（１～９９９９９９） */
  int pluschPromNo4 = 0;		/* 商品ポイント企画ＮＯ４（１～９９９９９９） */
  int pluschPromNo5 = 0;		/* 商品ポイント企画ＮＯ５（１～９９９９９９） */
  int pluschPromNo6 = 0;		/* 商品ポイント企画ＮＯ６（１～９９９９９９） */
  int pluschPromNo7 = 0;		/* 商品ポイント企画ＮＯ７（１～９９９９９９） */
  int pluschPromNo8 = 0;		/* 商品ポイント企画ＮＯ８（１～９９９９９９） */
  int immediatelyPromTicket = 0;	/* 即時発行販売販促チケットＮＯ（０～９９９９９９） */
  int joinStreNo = 0;		/* 登録店番号 */
  String joinStreName = "";	/* 登録店名 */
  String svsClsName = "";		/* サービス分類名 */
  String simsPqsOfflineFlg = "";	/* SIMS-PQSオフラインフラグ */
}