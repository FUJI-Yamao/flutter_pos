/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: rxmem_barcode_pay.h - 構造体RXMEM_BCDPAY_BCD
class RxmemBcdpayBcd {
  int	type = 0;
  String code = '';
}

/// 関連tprxソース: rxmem_barcode_pay.h - RXMEM_BCDPAY_TX
class RxmemBcdpayTx {
  int payType = 0; // 決済タイプ(1:Alipay 2:LINE Pay...)
  int tranType = 0; // 通信処理区分
  int retry = 0; // リトライ回数
  int reqId = 0; // 要求ID
  int barType = 0; // バーコードタイプ
  String barCode = ""; // バーコード [sizeof(((RXMEM_BCDPAY_BCD*)0)->code)]
  String tid = ""; // 端末ID [20+1]
  int slipNo = 0; // POS処理番号
  int staffCode = 0; // スタッフコード
  int macNo = 0; // レジNo
  int amount = 0; // 利用額
  int targetSlipNo = 0; // 取消対象取引のPOS処理番号
  String transNonce = ""; // トランザクションノンス [32+1]
  String orderId = ""; // オーダID [32+1]
  String transSerial = ""; // トランザクションシリアル [32+1]
  String token = ""; // トークン [128+1]
  String posTimestamp = ""; // POSタイムスタンプ [17+1]
  String branchCode = ""; // 店舗番号 [32+1]
  String terminalCode = ""; // 端末番号 [20+1]
  String posName = ""; // 商品名称 [128+1]
  int receiptNo = 0; // レシート番号
}

/// 関連tprxソース: rxmem_barcode_pay.h - 構造体RXMEM_BCDPAY_RX
class RxmemBcdpayRx {
  // TODO:00011 周 rc_key_cash.dartの実装に関係がないため、当クラスの実装は一旦保留
  // short	result;				/* 通信結果 */
  // char	paymentCode[15+1];		/* 決済事業者識別コード */
  // char	retStatus[2+1];		/* ステータス */
  String errCode = '';		/* エラーコード */
  // char	errMessage[256+1];	/* エラーメッセージ */
  // char	subErrCode[128+1];	/* サブエラーコード */
  //
  int	orderResult = 0;		/* 通信終了後のオーダー状態を保存 */
  // char	timestamp[17+1];	/* タイムスタンプ */
  // long	req_id;				/* 要求ID */
  // char	trans_no[10+1];		/* 取引番号 */
  // long	slip_no;		/* POS取引番号 */
  // long	amount;			/* 取扱金額 */
  //
  // long	before_bal;		/* 利用前残高 */
  // long	balance;		/* 残高 */
  // long	bal_limit;		/* 入金限度額 */
  // char	bal_exp[8+1];	/* 有効期限 */
  //
  // long	http_status_code;
  // char	qr_data[128];		/* QRデータ */
  // char	transNonce[32+1];	/* トランザクションノンス */
  // char	orderId[32+1];		/* オーダID */
  // char	transSerial[32+1];	/* トランザクションシリアル */
  // char	token[128+1];		/* トークン */
  // char	transStatus[2+1];	/* 支払ステータス*/
  // char	returnCode[4+1];		/* エラーコード */
  //
  // RXMEM_QUIZ_RX	quiz;		/* コード決済[QUIZ] レスポンスデータ */

}

/// 関連tprxソース: rxmem_barcode_pay.h - 構造体RXMEM_BCDPAY
class RxmemBcdpay {
  RxmemBcdpayBcd	bar= RxmemBcdpayBcd();
  RxmemBcdpayTx txData = RxmemBcdpayTx();
  RxmemBcdpayRx rxData = RxmemBcdpayRx();
}

/// 関連tprxソース: rxmem_barcode_pay.h - BCDPAY_TYPE
/// 決済の仕様タイプ
enum BCDPAY_TYPE{
  BCDPAY_TYPE_NONE(0),	       /* なし */
  BCDPAY_TYPE_ALIPAY(1),		   /* Alipay */
  BCDPAY_TYPE_LINEPAY(2),	     /* LINE Pay */
  BCDPAY_TYPE_WECHATPAY(3),	   /* WeChatPay */
  BCDPAY_TYPE_BARCODE_PAY1(4), /* JPQR */
  BCDPAY_TYPE_CANALPAY(5),	   /* ｺｰﾄﾞ決済[CANALPay] */
  BCDPAY_TYPE_FIP(6),	         /* コード決済[FIP] */
  BCDPAY_TYPE_MULTIONEPAY(7),  /* Onepay複数ブランド */
  BCDPAY_TYPE_NETSTARS(8),	   /* コード決済[Netstars] */
  BCDPAY_TYPE_QUIZ(9),	       /* コード決済[QUIZ] */
  BCDPAY_TYPE_ALL(99);	       /* すべて（チャージ商品チェック用 ) */

  final int id;
  const BCDPAY_TYPE(this.id);
}
/// 関連tprxソース: rxmem_barcode_pay.h - BCDPAY_ORDER
/// 通信タスクの状態タイプ別
enum BCDPAY_ORDER{
  BCDPAY_ODR_NONE,	        /* 未通信 */
  BCDPAY_ODR_TX,		        /* 送信 */
  BCDPAY_ODR_RX,	          /* 受信 */
  BCDPAY_ODR_ERR_END;	    /* エラー  */
}