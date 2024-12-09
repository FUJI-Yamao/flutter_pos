/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: rxmemcogca.h - struct RXMEM_COGCA_TX
class RxMemCogaTx {
  String execDate = "";		/* 処理日付 */
  String execTime = "";		/* 処理時刻 */
  int paymentNo = 0;		/* 端末処理通番 */
  int cancelType = 0;		/* 取消指定区分（0:通常 2:再送） */
  int execType = 0;		/* 処理区分（2:加算 3:減算 4:照会 11(B):加算取消 12(C):減算取消） */
  int cardType = 0;		/* カード種類 */
  int money = 0;			/* 取扱金額（決済金額） */
  int tax = 0;			/* 税送料 */
  int orgPaymentNo = 0;		/* 元端末処理通番（取消時のみ） */
  String orgTradeDate = "";	/* 元取引日（取消時のみ） */
  String cardInput = "";		/* カード入力区分（2:JIS2 U:非接触 3:マニュアル手入力） */
  String cardInfo = "";		/* カード情報 */
  int staffCode = 0;		/* スタッフコード */
  int pluCode = 0;		/* 商品コード */
  int macNo = 0;			/* レジNo */
}

/// 関連tprxソース: rxmemcogca.h - struct RXMEM_COGCA_RX
class RxMemCogcaRx {
  int orderResult = 0;		/* 通信のオーダー結果を保存 */
  String execDate = "";		/* 処理日付 */
  String execTime = "";		/* 処理時刻 */
  String termIdNo = "";		/* 端末識別番号 */
  int paymentNo = 0;		/* 端末処理通番 */
  int result = 0;			/* 処理結果 */
  String errCode = "";		/* エラーコード */
  String msg1 = "";		/* メッセージ１ */
  String msg2 = "";		/* メッセージ２ */
  int recogNo = 0;		/* 承認番号 */
  String recogDate = "";		/* 承認取得日 */
  String cardId = "";		/* CardID */
  int statusCode = 0;		/* ステータスコード */
  int pointType = 0;		/* ポイント種別 */
  String memberRank = "";	/* 会員ランク */
  int buyType = 0;		/* 購入種別 */
  int payType = 0;		/* 決済方式 */
  String lastUseDate = "";	/* 最終利用日 */
  String lastUseTime = "";	/* 最終利用時刻 */
  String tranId = "";		/* トランザクションID */
  String s1adjValue = "";	/* S1加減算値 */
  int s1adjClass = 0;		/* S1加減算値区分 */
  String s1bfrBalance = "";	/* S1利用前残高 */
  String s1aftBalance = "";	/* S1利用後残高 */
  String s1limitDate = "";	/* S1有効期限 */
  String s2adjValue = "";	/* S2加減算値 */
  int s2adjClass = 0;		/* S2加減算値区分 */
  String s2bfrBalance = "";	/* S2利用前残高 */
  String s2aftBalance = "";	/* S2利用後残高 */
  String s2limitDate = "";	/* S2有効期限 */
  String s3adjValue = "";	/* S3加減算値 */
  int s3adjClass = 0;		/* S3加減算値区分 */
  String s3bfrBalance = "";	/* S3利用前残高 */
  String s3aftBalance = "";	/* S3利用後残高 */
  String s3limitDate = "";	/* S3有効期限 */
  String s4adjValue = "";	/* S4加減算値 */
  int s4adjClass = 0;		/* S4加減算値区分 */
  String s4bfrBalance = "";	/* S4利用前残高 */
  String s4aftBalance = "";	/* S4利用後残高 */
  String s4limitDate = "";	/* S4有効期限 */
  String s5adjValue = "";	/* S5加減算値 */
  int s5adjClass = 0;		/* S5加減算値区分 */
  String s5bfrBalance = "";	/* S5利用前残高 */
  String s5aftBalance = "";	/* S5利用後残高 */
  String s5limitDate = "";	/* S5有効期限 */
  String basicValuePremium = "";	/* 基本Valueプレミアム */
  String thisAddPoint = "";	/* 今回還元ポイント値 */
  String useBasicValue = "";	/* 今回利用基本Value値 */
  String useBonusValue = "";	/* 今回利用ボーナスValue値 */
  String useCouponValue = "";	/* 今回利用クーポンValue値 */
  String bfrTotalBalance = "";	/* Value利用前残高合計値 */
  String useTotalValue = "";	/* 今回Value利用合計値 */
  String aftTotalBalance = "";	/* Value利用後残高合計値 */
  String lastTotalPoint = "";	/* 前回ポイント合計値 */
  String thisTotalPoint = "";	/* 今回ポイント合計値 */
  String sumTotalPoint = "";	/* 累計ポイント合計値 */
  String issueBasicValue = "";	/* 今回発行基本Value値 */
  String issueBonusValue = "";	/* 今回発行ボーナスValue値 */
  String issueCouponValue = "";	/* 今回発行クーポンValue値 */
  String issueBonusPoint = "";	/* 今回発行ボーナスポイント値 */
  String thisMonthValue = ""; 	/* 今月Value累計値 */
  String saleMsg1 = "";		/* 販促メッセージ1 */
  String saleMsg2 = "";		/* 販促メッセージ2 */
  String saleMsg3 = "";		/* 販促メッセージ3 */
  String saleMsg4 = "";		/* 販促メッセージ4 */
}

/// 関連tprxソース: rxmemcogca.h - struct RXMEM_COGCA_CARD
class RxMemCogcaCard {
  int typ = 0;    /* card type 0:non 1:磁気 2:IC */
  String jis2 = "";    /* Additional data */
  String precaCd = "";    /* プリカ番号 */
  String storeCd = "";    /* 加盟社コード */
  String memberRsv = "";    /* 会員番号（リザーブ） */
  String memberCd = "";    /* 会員番号（１３桁） */
}

/// 関連tprxソース: rxmemcogca.h - struct RXMEM_COGCA_BFR_BAL
class RxMemCogcaBfrBal {
  int inFlg = 0;		/* 取消、仮締の際にwork_in_typeがクリアされない
			　　　　　このフラグでCoGCa残高の表示する／しないを制御*/
  int s1bfrBalance = 0;	/* S1利用前残高 */
  int s2bfrBalance = 0;	/* S2利用前残高 */
  int s3bfrBalance = 0;	/* S3利用前残高 */
}