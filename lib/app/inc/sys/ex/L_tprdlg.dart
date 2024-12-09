/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class LTprDlg{
/// 関連tprxソース:L_tprdlg.h
/*---------judge messeage----------------------------*/
  static const String BTN_YES = "はい";
  static const String BTN_CANCEL = "Cancel";
  static const BTN_CONTINUE = "Cont";
  static const BTN_EXEC	= "実行";
  static const BTN_END = "End";
//   #define BTN_SALE_CHECK			"X-Report"
//   #define BTN_SALE_ACCURATE		"Z-Report"
//   #define BTN_FL1				"FL-1"
//   #define BTN_CARD			"Card"
//   #define BTN_RESULT			"Data"
//   #define BTN_NORESULT			"No data"
//   #define BTN_INPRT			"Built-in Printer"
//   #define BTN_LASERPRT			"Laser printer"
  static const BTN_INTERRUPT = "中断";
  static const BTN_NO = "いいえ";
  static const String BTN_CONF = "Confirm";
// /* Append by K.Makino 00.11.06 */
  static const BTN_FORCESTART = "Force";
// /* Append End */
// /* Append K.Tomioka '01.03.08 */
//   #define	BTN_FORCECLOSE			"Force"
// /* Append K.Tomioka '01.06.08 */
  static const BTN_RETRY = "再試行";
//   #define	BTN_IGNORE			"Disregard"
// /* Append T.Kanno '02.02.27 */
  static const BTN_FORCE = "強制";
// /* Append T.Sangu '02.06.26 */
//   #define	BTN_START			"Start"
// /* Append T.Kanno '03.08.22 */
//   #define BTN_FINISH                      "Complete"
//   #define BTN_ADD                         "Add"
// /* Append M.Nishihara '04.05.06 */
//   #define BTN_REPRINT                     "Reprint"
//
     static const String BTN_ERR = "Error";
  static const BTN_RETURN = "Return";
//   #define BTN_NEXT			"次へ"/* @@@ */
//
//   #define BTN_SUS                         "休止"          /* @@@ */
//
//   #define	BTN_REGI			"登録" /* @@@ */
//   #define	BTN_INP				"入力" /* @@@ */
//
//   #define	BTN_YEAR			"年" /* @@@ */
//   #define	BTN_MONTH			"月" /* @@@ */
//   #define	BTN_DAY				"日" /* @@@ */
//   #define	BTN_HOUR			"時" /* @@@ */
//   #define	BTN_MIN				"分" /* @@@ */
//   #define	BTN_SEC				"秒" /* @@@ */
//
//   #define	BTN_UP_TRI			"△" /* @@@ */
//   #define	BTN_DOWN_TRI		"▽" /* @@@ */
//
//   #define BTN_EDY                         "Edy"
//   #define BTN_SUICA                       "Suica"
//   #define BTN_PASMO                       "PASMO"
//   #define	QC_BTN_ID                       "iD"
//   #define	QC_BTN_QUICPAY                  "QUICPay"
//   #define	QC_BTN_WAON                     "WAON"
//   #define	QC_BTN_NANACO                   "nanaco"
//   #define	QC_BTN_UNIONPAY                 "銀聯" /* @@@ */
//   #define QC_BTN_PRECA                    "プリペイド\nカード" /* @@@ */
//
//   #define	BTN_REDUCE                      "減算" /* @@@ */
//   #define BTN_CNCL                        "取消"  /* @@@ */
//   #define BTN_CONF2                       "年齢確認"   /* @@@ */
//   #define	BTN_SAVE_YES			"する"	/* @@@ */
//   #define	BTN_SAVE_NO			"しない"	/* @@@ */
//
//   #define	BTN_CHANGE			"変更"	/* @@@ */
//   #define	BTN_SELECT			"選択"	/* @@@ */
//   #define BTN_POWEROFF                    "電源OFF" /* @@@ */
//
//   #define	BTN_RECALC			"再精査" /* @@@ */
//   #define	BTN_ALLREG			"全レジ" /* @@@ */
//
//   #define BTN_QR_PRN                      "QR発券"	/* @@@ */
//
//   #define BTN_C_TYPE                      "登録機"   /* @@@ */
//   #define BTN_J_TYPE                      "精算機"   /* @@@ */
//
//   #define	BTN_ICHIYAMA_ADD		"小計戻し"	/* @@@ */
//
//   #define	BTN_CLOSE			"とじる"	/* @@@ */
//   #define	MSG_NEXT_WARN			"あと%d件のメッセージがあります"	/* @@@ */
//   #define	BTN_STROPN_START		"開  店"	 /* @@@ */
//   #define	BTN_FORCEEND			"強制終了"	/* @@@ */
//   #define	BTN_FORCEDO			"強制実行"	/* @@@ */
//   #define	BTN_AUTOSTRCLS_STOP		"精算中止"	/* @@@ */
/************************************************************************/

/* 6000～6999:オリジナルメッセージ系 */

/* ========== Message Text 7000 ================================== */

  static const String ER_MSG_TEXT104 = "日計処理が行われておりません。\n本日中に締め処理を行ってください";

/*-------message for after 15Ver. (10000番以降を使用)--------------*/
/* =============== 10000 =============== */
/* ========== judge messeage ===================================== */
  static const BTN_CASH_PAYMENT = "現金支払";
}