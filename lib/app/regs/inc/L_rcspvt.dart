/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース: L_rcspvt.h
class LRcSpvt {
/*-----------------------------------------------------------------------*
 *                      static const String Image Datas
 *-----------------------------------------------------------------------*/
  static const String POP_MSG_SPVT_START     = "カードをタッチして下さい";
  static const String POP_MSG_SPVT_AGAIN     = "もう一度同じカードを\nタッチして下さい";
  static const String POP_MSG_SPVT_AGAIN57_1 = "もう一度同じカードを";
  static const String POP_MSG_SPVT_AGAIN57_2 = "タッチして下さい";
  static const String POP_MSG_SPVT_SELECT    = "アプリを選択して下さい";
  static const String POP_MSG_SPVT_PASSCD    = "パスコードを解除して下さい";
  static const String SPVT_VOID_ENT          = "入力";
  static const String SPVT_VOID_CNCL         = "中止";
  static const String SPVT_VOID_RCPT1        = "元伝票番号を入力して下さい";
  static const String SPVT_VOID_RCPT2        = "元ＩＣ通番を入力して下さい";
  static const String SPVT_TR_TRAN           = "トレーニング";
  static const String SPVT_BTN_CAN_LAST      = "前日分";
  static const String SPVT_BTN_CAN_TODAY     = "本日分";
  static const String POP_MSG_SPVT_FIRST     = "最初にタッチしたカードを\nタッチして下さい";
  static const String POP_MSG_SPVT_FIRST57_1 = "最初にタッチしたカードを";
  static const String POP_MSG_SPVT_WAIT      = "処理中です。お待ち下さい";
  static const String SPVT_BTN_NOCARD        = "ｶｰﾄﾞなし";
  static const String POP_IC_ALARM           = "取引が不明な状態で終了しました\nアラームレシートを出力します\n所定の運用に従って下さい";
  
/* For QUICPay */
  static const String MSG_IC_UNKNOWN         = "取引は終了していません\n直前取引照会を行います";
  static const String MSG_ICTRAN_OK          = "取引が完了しました";
  static const String MSG_ICTRAN_NG          = "取引に失敗しました。再度\n小計画面から処理を行って下さい";
  static const String MSG_IC_AUTHORI         = "問い合わせ中";
  static const String BTN_IC_B_TRAN          = "直前照会";
  
/* For iD */
  static const String MSG_IC_PIN             = "暗証番号を入力して下さい";
  static const String MSG_IC_PIN_AGAIN       = "もう一度暗証番号を入力して下さい";
  static const String MSG_IC_PIN_ERROR       = "暗証番号が違います";
  static const String MSG_IC_PIN_LIMITOVER   = "暗証番号入力の制限回数オーバーです\n取引を中止します";
  static const String BTN_IC_RETRY           = "再実行";
  static const String BTN_IC_STOP            = "取引中止";
  
/* For Suica */
  static const String POP_SUICA_ALARM        = "取引が不明な状態で終了しました\n処理未了レシートを出力します\n残額照会でカード残額を確認し\n所定の運用に従って下さい";
  static const String	POP_SUICA_NEAR         = "二アフルです\n一件明細送信を行って下さい";
  static const String MSG_SUICA_MINUS        = "残額不足です";
  static const String MSG_SUICA_BAL_0        = "カード残額が０円です";
  static const String POP_SUICA_ALARM_DIF    = "処理未了中に別端末で取引を\n行った為、お取扱できません。\nしばらくお待ち下さい。\n";
  
  static const String POP_SUICA_ALARM2      = "取引が不明な状態で終了しました\n処理未了レシートを出力します\n残高照会でカード残高を確認し\n所定の運用に従って下さい";
  static const String MSG_SUICA_MINUS2      = "残高不足です";
  static const String MSG_SUICA_BAL_0_2     = "カード残高が０円です";

  static const String MSG_SUICA_PAY_RESULT    = "支払が完了しました";
  static const String MSG_SUICA_CNCL_RESULT   = "取消が完了しました";
  static const String POP_SUICA_ALARM2_CUST   = "取引が不明な状態で終了しました";

  static const String QC_PASSCODE_MSG1      = "暗証番号を";
  static const String QC_PASSCODE_MSG2      = "入力して下さい";
  

}
