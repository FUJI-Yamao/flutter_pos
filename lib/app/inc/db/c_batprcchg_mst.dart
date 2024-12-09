/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース: c_batprcchg_mst.h - c_batprcchg_mst
class CBatprcchgMst{
  int	prcchgCd = 0;		/* 予約 */
  int	orderCd = 0;		/* 予約順 */
  int	compCd = 0;		/* 企業コード */
  int	streCd = 0;		/* 店舗コード */
  String pluCd = '';		/* ＰＬＵコード */
  int	flg = 0;			/* flag */
  int	posPrc = 0;		/* 売単価 */
  int	custPrc = 0;		/* 会員単価 */
  String startDatetime = '';	/* 開始日時 */
  String endDatetime = '';	/* 終了日時 */
  int	timeschFlg = 0;		/* タイムスケジュール実行フラグ */
  int	sunFlg = 0;		/* 曜日フラグ・日 */
  int	monFlg = 0;		/* 曜日フラグ・月 */
  int	tueFlg = 0;		/* 曜日フラグ・火 */
  int	wedFlg = 0;		/* 曜日フラグ・水 */
  int	thuFlg = 0;		/* 曜日フラグ・木 */
  int	friFlg = 0;		/* 曜日フラグ・金 */
  int	satFlg = 0;		/* 曜日フラグ・土 */
  int	stopFlg = 0;		/* 中断フラグ */
  String insDatetime = '';	/* 作成日時 */
  String updDatetime = '';	/* 更新日時 */
  int	status = 0;			/* 状態 */
  int	sendFlg = 0;		/* 送信フラグ */
  int	updUser = 0;	/* 最終更新者 */
  int	updSystem = 0;		/* 更新元システム */
}

