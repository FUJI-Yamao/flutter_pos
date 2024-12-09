/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース:rxmemajsemoney.h - RXMEM_AJS_EMONEY_TX
class RxMemAjsEmoneyTx {
  /* ヘッダ部 */
  int execType = 0;		/* 業務区分 (2001:アクティベート 2002:加算 2003:減算 2004:照会 2005:取消 2011-2013:予約済み 9001-9002:予約済み) */
  int execOrder = 0;		/* 電文種別 (0:要求 1:応答) */
  int failCanType = 0;		/* 障害取消フラグ (0:OFF 1:ON 障害取消) */
  int testType = 0;		/* テストフラグ (0:OFF 1:テスト電文) */
  int trailerLeng = 0;		/* トレーラレングス (電文ヘッダ以降の電文長) */
  /* 予備1 */
  /* 予備2 */
  /* データ部(要求) */
  String insideArea = "";	/* 内部使用領域 (スペース3桁固定) */
  String companyCode = "";	/* 仕向け会社コード */
  String terminalCode = "";	/* 端末識別コード */
  /* 店舗コード */
  String paymentNo = "";		/* 伝票番号 (クレジットアクチュアルログの通番) */
  String execDate = "";		/* 端末処理日付 */
  String execTime = "";		/* 端末処理時刻 */
  int cardInput = 0;		/* カード入力区分 (1:JIS1 2:JIS2) */
  /* 予備1 */
  String cardInfo = "";		/* カード情報 */
  String cardPin = "";		/* 端末入力暗証番号 (手入力しないのであれば、All 0) */
  /* 商品コード */
  int money = 0;			/* 利用額 (有効桁 00000000-09999999 照会/アクティベートは All0) */
  String freeSpace = "";	/* 貴社使用領域 (何を入れても無視される領域) */
  String orgPaymentNo = "";	/* 元伝票番号 (クレジットアクチュアルログの通番) */
  int cancelType = 0;		/* 取消区分 (0:非取消 1:取消) */
  String grantType = "";		/* キャンペーン付与拒否フラグ (1:拒否 スペース:付与) */
  /* 予備2 */
}

/// 関連tprxソース:rxmemajsemoney.h - RXMEM_AJS_EMONEY_RX
class RxMemAjsEmoneyRx {
  /* 結果セット部 */
  int result = 0;			/* 処理結果 */
  /* データ部(要求) */
  String paymentNo = "";		/* 伝票番号 (クレジットアクチュアルログの通番) */
  int money = 0;			/* 利用額 (有効桁 00000000-09999999 照会/アクティベートは All0) */
  /* データ部(応答) */
  int orderResult = 0;		/* 通信のオーダー結果を保存 */
  String errCode = "";		/* エラーコード (承認(許可)はAllスペース) */
  String suberrCode = "";	/* サブエラーコード (承認(許可)はAllスペース) */
  String approvalNo = "";	/* 承認番号 (非承認(拒否)はAllスペース) */
  String befMoney = "";		/* 利用前残高 (エラーはAllスペース) */
  String aftMoney = "";		/* 利用後残高 (エラーはAllスペース) */
  String cardStatusCode = "";	/* カードステータス (1桁目=0:未アクティベート 1:アクティベート 2:初回利用アクティベート
		 					 2桁目=0:有効期限内 1:有効期限切れ 2:利用開始前 スペース:有効期限未設定
							 3桁目=0:有効 1:失効
							 4桁目=予備(0:Web利用可 1:Web利用非) )
							 (エラーはAllスペース) */
  String expDate = "";		/* 有効期限 (エラーはAllスペース) */
  String grantMoney = "";	/* キャンペーン付与額 (エラーはAllスペース) */
  String cardTypeCode = "";	/* 券種コード (照会(正常)以外はAllスペース) */
  String crdtLimit = "";		/* 残高限界額 (照会(正常)以外はAllスペース) */
  String chargeType = "";	/* チャージ可否フラグ (0:チャージ不可 1:チャージ可 照会(正常)以外はAllスペース) */
  /* 予備3 */
}

/// 関連tprxソース:rxmemajsemoney.h - RXMEM_AJS_EMONEY_CARD構造体
class RxMemAjsEmoneyCard {
  int typ = 0;    /* card type 0:non 1:磁気 2:IC 3:ワンタイムバーコード */
  int jisTyp = 0;    /* card type 1:JIS1 2:JIS2 */
  String jis1 = "";    /* JIS1カード情報 */
  String jis2 = "";    /* JIS2カード情報 */
  String precaCd = "";    /* プリカ番号 */
  String expDate = "";    /* 有効期限 (エラーはAllスペース) 紅屋特注 */
}