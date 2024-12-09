/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース:  src\sys\word\aa\L_rmstclsfcl.h
class LRmstclsfcl {
  static const STCLS_FCL_CMD_MLTSRVSTATREQ = "状態要求";
  static const STCLS_FCL_CMD_ENCRYPTREQ2 = "版数要求2";
  static const STCLS_FCL_CMD_MUTUAL1 = "通信認証1";
  static const STCLS_FCL_CMD_MUTUAL2 = "通信認証2";
  static const STCLS_FCL_CMD_MLTSRVTRANEND = "取引完了";
  static const STCLS_FCL_CMD_OPEMODECONTROL = "動作ﾓｰﾄﾞ制御";
  static const STCLS_FCL_CMD_MAINTENANCEPWCHK = "保守用ﾊﾟｽﾜｰﾄﾞ確認";
  static const STCLS_FCL_CMD_MAINTENANCE_IN = "保守入";
  static const STCLS_FCL_CMD_MAINTENANCE_OUT = "保守出";
  static const STCLS_FCL_CMD_MLTSRVDLLREQ = "ＤＬＬ要求指示";
  static const STCLS_FCL_CMD_MLTSRVDLLREQCHK = "ＤＬＬ要求指示状況確認";
  static const STCLS_FCL_CMD_MLTSRVDATAGETSTART = "端末ﾃﾞｰﾀ取得開始";
  static const STCLS_FCL_CMD_MLTSRVDATAGET = "端末ﾃﾞｰﾀ取得";
  static const STCLS_FCL_CMD_MLTSRVDATAGETEND = "端末ﾃﾞｰﾀ取得終了";
  static const STCLS_FCL_CMD_EDY_DAILY = "Ｅｄｙ-締め";
  static const STCLS_FCL_CMD_EDY_DAILYCHK = "Ｅｄｙ-締め状況確認";
  static const STCLS_FCL_CMD_EDY_DATA_REQ = "Ｅｄｙ固定ﾃﾞｰﾀ要求";
  static const STCLS_FCL_CMD_QP_DAILY = "ＱＰ日計";
  static const STCLS_FCL_CMD_QP_DAILYCHK = "ＱＰ日計状況確認";
  static const STCLS_FCL_MUL_DAILY = "ﾏﾙﾁｻｰﾋﾞｽ日計";
  static const STCLS_FCL_MUL_DAILYCHK = "ﾏﾙﾁｻｰﾋﾞｽ日計状況確認";
  static const STCLS_FCL_MUL_DAILYEND = "ﾏﾙﾁｻｰﾋﾞｽ日計完了";
  static const STCLS_FCL_MUL_KEYREQ = "ﾏﾙﾁｻｰﾋﾞｽ鍵配信要求指示";
  static const STCLS_FCL_MUL_KEYREQ_CHK = "ﾏﾙﾁｻｰﾋﾞｽ鍵配信要求指示状況確認";
  static const STCLS_FCL_MUL_NEGAREQ = "ﾏﾙﾁｻｰﾋﾞｽﾈｶﾞ配信要求指示";
  static const STCLS_FCL_MUL_NEGAREQ_CHK = "ﾏﾙﾁｻｰﾋﾞｽﾈｶﾞ配信要求指示状況確認";
  static const STCLS_FCL_DATE_SET = "日付・時刻設定";

  static const STCLS_FCL_MSG1 = "端末処理中";
  static const STCLS_FCL_MSG2 = "端末故障〔故障ｺｰﾄﾞ：%06ld〕";
  static const STCLS_FCL_MSG3 = "端末暗号化不適";
  static const STCLS_FCL_MSG4 = "通信認証ｴﾗｰ〔乱数の不一致〕";
  static const STCLS_FCL_MSG5 = "通信認証ｴﾗｰ";
  static const STCLS_FCL_MSG6 = "端末閉塞中";
  static const STCLS_FCL_MSG7 = "動作ﾓｰﾄﾞ制御ｴﾗｰ";
  static const STCLS_FCL_MSG8 = "保守用ﾊﾟｽﾜｰﾄﾞｴﾗｰ";
  static const STCLS_FCL_MSG9 = "保守入異常";
  static const STCLS_FCL_MSG10 = "保守出異常";
  static const STCLS_FCL_MSG11 = "ＤＬＬ要求ｴﾗｰ 理由ｺｰﾄﾞ：%.*s";
  static const STCLS_FCL_MSG12 = "取得ﾃﾞｰﾀなし";
  static const STCLS_FCL_MSG13 = "ﾃﾞｰﾀ取得ｴﾗｰ";
  static const STCLS_FCL_MSG14 = "取得ﾃﾞｰﾀなし〔ﾌﾞﾛｯｸ数 0〕";
  static const STCLS_FCL_MSG15 = "取得ﾃﾞｰﾀなし〔ﾊﾞｲﾄ数 0〕";
  static const STCLS_FCL_MSG16 = "送信ｴﾗｰ";
  static const STCLS_FCL_MSG17 = "ｵﾌﾗｲﾝ";
  static const STCLS_FCL_MSG18 = "ﾘﾄﾗｲｴﾗｰ";
  static const STCLS_FCL_MSG19 = "ｼｽﾃﾑｴﾗｰ";
  static const STCLS_FCL_MSG20 = "処理中";
  static const STCLS_FCL_MSG21 = "受信ﾃﾞｰﾀ異常";
  static const STCLS_FCL_MSG22 = "初期化中";
  static const STCLS_FCL_MSG23 = "処理中";
  static const STCLS_FCL_MSG24 = "ﾓｰﾄﾞ不適";
  static const STCLS_FCL_MSG25 = "ｼｽﾃﾑ異常";
  static const STCLS_FCL_MSG26 = "端末故障";
  static const STCLS_FCL_MSG27 = "ﾈｶﾞ配信要求異常終了〔理由ｺｰﾄﾞ：%.*s〕";
  static const STCLS_FCL_MSG28 = "鍵配信要求異常終了〔理由ｺｰﾄﾞ：%.*s〕";
  static const STCLS_FCL_MSG29 = "日計処理異常終了〔理由ｺｰﾄﾞ：%.*s〕";
  static const STCLS_FCL_MSG30 = "ﾀｲﾑｱｳﾄ";
  static const STCLS_FCL_MSG31 = "締め処理異常終了";
  static const STCLS_FCL_MSG32 = "日時設定ｴﾗｰ";

  static const STCLS_FCL_NORMAL = "正常終了";
}