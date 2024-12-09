/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース: L_rc_preca.h
class LRcPreca {
  static const CARDREAD_MSG_READGUIDE = "カードを読ませてください。";
  static const BARCODEREAD_MSG_READGUIDE = "バーコードを読み込ませてください。";
  static const BARCODEREAD_MSG_READGUIDE_NEWCODE = "新しいバーコードを読み込ませてください。";
  /* for checker & print & update(EJ) */
  static const String MSG_KEYINQ_PRECA = "プリカ  鍵配信処理";

  static const String TTL_PRECA = "プリカ支払";
  static const String TTL_PRECA_VOIID = "プリカ取消";
  static const String TTL_PRECA_CIN = "プリカ釣銭チャージ";
  static const String TTL_PRECA_CIN_VOID = "プリカ釣銭チャージ取消";
  static const String TTL_PRECA_DEPOSIT = "プリカチャージ";
  static const String TTL_PRECA_DEPOSIT_VOID = "プリカチャージ取消";
  static const String TTL_PRECA_BALANCE = "プリカ残高";
  static const String TTL_PRECA_LACK = "プリカ残高不足";
  static const String CONF_PRECA_BALANCE = "プリカ残高\n［%s］\nお買い物を続けますか？";
  static const String CONF_PRECA_SLCT = "プリカ残高\n［%s］";
  static const String CONF_PRECA_CHANGE = "釣銭有り\n［%s］\n釣銭金額を入金しますか？";
  static const String CONF_PRECA_SLCT_QC = "金券類があれば先に登録し\n最後に、QC指定をしてください。";
  static const String CONF_PRECA_SHORTFALL = "[%s]不足しています。";
  static const String CONF_PRECA_LACKBALANCE = "残高不足: 残高[%s]";

  static const String PRECA_LIMIT = "有効期限";
  static const String PRECA_USE_DAY = "お取扱日";
  static const String PRECA_YEAR = "年";
  static const String PRECA_MONTH = "月";
  static const String PRECA_DAY = "日";
  static const String PRECA_SLIP_NUM = "伝票番号";
  static const String PRECA_SLIP_NUM_ORG = "元伝票番号";
  static const String PRECA_LAST_ZAN = "前回残高";
  static const String PRECA_AMOUNT = "金額";
  static const String PRECA_ZAN = "残高";
  static const String PRECA_CARDID = "カードID";

  static const String PRECA_CARD_NUM = "カード番号";
  static const String PRECA_USE_BEFORE = "利用前残高";
  static const String PRECA_USE_AMOUNT = "支払い";
  static const String PRECA_USE_AFTER = "利用後残高";
  static const String PRECA_CHARGE_BEFORE = "チャージ前残高";
  static const String PRECA_CHARGE_AMOUNT = "チャージ額";
  static const String PRECA_CHARGE_AFTER = "チャージ後残高";
  static const String PRECA_AUTH_NUM = "承認番号";
  static const String PRECA_AUTH_NUM_ORG = "元承認番号";
  static const String PRECA_INQ_NUM = "お問い合わせ番号";
  static const String PRECA_INQ_NUM_ORG = "元お問い合わせ番号";
  static const String PRECA_PREMIUM = "プレミアム";
  static const String PRECA_PRESENT = "プレゼント";
  static const String PRECA_PREMIUM_PRESENT = "ﾌﾟﾚﾐｱﾑ・ﾌﾟﾚｾﾞﾝﾄ";

  static const String PRECA_TC_OLD_NUM = "元カード番号";
  static const String PRECA_TC_NEW_NUM = "新カード番号";
  static const String PRECA_TC_ALL_BAL = "残高合計";
  static const String PRECA_TC_CHARGE_BAL = "チャージ残高";
  static const String PRECA_TC_PREMIUM_BAL = "プレミアム残高";
  static const String PRECA_TC_PRESENT_BAL = "プレゼント残高";

  static const String TTL_REPICA = "電子マネー情報";
  static const String REPICA_USE_BEFORE = "ご利用前残高合計";
  static const String REPICA_USE_AFTER = "ご利用後残高合計";
  static const String REPICA_USE_AMOUNT = "ご利用額";
  static const String REPICA_USE_CHARGE = "（内 チャージ分）";
  static const String REPICA_USE_PREMIUM = "（内   プレミアム分）";
  static const String REPICA_USE_PRESENT = "（内   プレゼント分）";
  static const String REPICA_MNT_TC = "カード付替";
  static const String REPICA_MNT_ACT = "カード　アクティベート";
  static const String REPICA_REQUEST_ID = "リクエストID[request_id]";
  static const String REPICA_POS_RCT_CD = "POSﾚｼｰﾄｺｰﾄﾞ[pos_receipt_code]";

  static const String PRECA_UNKNOWN_1 = "▼▼▼▼プリカ不明取引発生　センタへ要確認▼▼▼▼";
  static const String PRECA_UNKNOWN_2 = "▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲";
}
