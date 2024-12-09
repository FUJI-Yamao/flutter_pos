/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: rxmemvaluecard.h - struct RXMEM_VALUECARD_TX
class RxMemValueCardTx {
  int execType = 0;		/* 処理区分（2:加算 3:減算 4:照会 11(B):加算取消 12(C):減算取消） */
  int retry = 0;			/* リトライ回数 */
  int reqId = 0;			/* 要求ID */
  String cardNo = "";		/* カード番号 */
  String cardNo2 = "";		/* カード番号(トークン用) */
  String cardJis2 = "";	/* カード情報JIS2 */
  String tid = "";		/* 端末ID(13桁) */
  int slipNo = 0;		/* POS処理番号 */
  int beforeBal = 0;		/* 利用前残高総額 */
  int amount = 0;			/* 利用額 */
  int targetSlipNo = 0;		/* 取消対象取引のPOS処理番号 */
  String targetTransNo = "";	/* 取消対象取引の取引番号 */
  String targetTransNo2 = "";	/* 取消対象取引の取引番号(API仕様用) */
  int staffCode = 0;		/* スタッフコード */
  int macNo = 0;			/* レジNo */
}

/// 関連tprxソース: rxmemvaluecard.h - struct RXMEM_VALUECARD_RX
class RxMemValueCardRx {
  int orderResult = 0;		/* 通信のオーダー結果を保存 */
  int result = 0;			/* 通信結果 */
  String errCode = "";		/* エラーコード */
  String timestamp = "";	/* タイムスタンプ */
  int reqId = 0;			/* 要求ID */
  String transNo = "";		/* 取引番号 */
  String transNo2 = "";	/* 取引番号 */
  int slipNo = 0;		/* POS取引番号 */
  int beforeBal = 0;		/* 利用前残高総額 */
  int amount = 0;			/* 取扱金額 */
  int bonusAmt = 0;		/* ボーナス額 */
  int couponAmt = 0;		/* クーポン額 */
  int pointAmt = 0;		/* ポイント額 */
  int balance = 0;		/* 残高総額 */
  int balLimit = 0;		/* 入金限度額 */
  int pointLimit = 0;		/* ポイント上限額 */
  int baseBal = 0;		/* 基本バリュー残高 */
  int bonusBal = 0;		/* ボーナス残高 */
  int couponBal = 0;		/* クーポン残高 */
  int pointBal = 0;		/* ポイント残高 */
  String baseExp = "";		/* 基本バリュー有効期限 */
  String bonusExp = "";		/* ボーナス有効期限 */
  String couponExp = "";	/* クーポン有効期限 */
  String pointExp = "";		/* ポイント有効期限 */
  int cardNumMaskFg = 0;		/* カード番号マスクフラグ */
  int cardNumMaskDigit = 0;	/* カード番号マスク桁数 */
}

/// 関連tprxソース: rxmemvaluecard.h - struct RXMEM_VALUECARD_CARD
class RxMemValueCardCard {
  int typ = 0;		/* card type 0:non 1:磁気 2:IC */
  String jis2 = "";				/* Additional data */
  String precaCd = "";	/* プリカ番号 */
  String precaCd2 = "";	/* プリカ番号 */
  int pointTyp = 0;      /* point type 0:ポイント機能なし 1:ポイント機能付き */
  int bcdTyp = 0;		/* bcd type 0:16桁 1:24桁 */
}

/// 関連tprxソース: rxmemvaluecard.h - struct RXMEM_VALUECARD
class RxMemValueCard {
  RxMemValueCardCard card = RxMemValueCardCard();
  RxMemValueCardTx txData = RxMemValueCardTx();
  RxMemValueCardRx rxData = RxMemValueCardRx();
}