/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class LRmstOpnCls{
  static const SUM_POINT = "……………………………………";
}

///  関連tprxソース:  src\sys\word\aa\L_rmstopncls.h
enum LRmstopncls {

  ITEM_FAP_QP_TXT('§ＱＰ日計処理'),
  ITEM_FAP_ID_TXT1('§ｉＤ日計処理'),
  PROC_EDY_RSLT('処理結果・・・・・・・・・・・・・・'),
  FCL_QP_TITLE('ＱＰ日計処理'),
  FCL_ID_TITLE1('ｉＤ日計処理'),
  VEGA_EDY_TITLE('Ｅｄｙ日計処理'),
  ENTRY_NORMAL('正常'),
  ENTRY_ABNORMAL('異常'),
  CANCEL('中止'),

  TAXFREE_RES_TXT("送信異常の免税データがあります"),
  TAXFREE_RES_TXT2("コールセンターにご連絡ください"),
  TAXFREE_SND_CNT("未送信件数     %4i件"),
  TAXFREE_ERR_CNT("送信異常件数   %4i件"),
  EJ_ASTER("＊＊＊＊＊＊＊＊＊＊"),
  EJ_ASTER2("＊＊＊＊＊＊＊"),
  PRINT_ASTER("＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊"),
  OPN_PROC_END("レジ開設処理  終了"),
  MOPENDIFF('Ｍレジの営業日で開設していないレジがあります。'),

  ITEM_FAP_ID_TXT2('§ｉＤセンタ通信'),
  FCL_KEY_REQ('鍵配信・・・・・・・・・・・・・・・'),
  FCL_NEGA_REQ('ネガ配信・・・・・・・・・・・・・・'),
  RMST_OK('ＯＫ'),
  STCLS_STERA_POP1('【ｸﾚｼﾞｯﾄ】'),
  STCLS_STERA_POP2('【NFCｸﾚｼﾞｯﾄ】'),
  STCLS_STERA_POP3('【iD】'),
  STCLS_STERA_POP4('【交通系IC】'),
  FCL_ID_TITLE2('ｉＤセンタ通信'),
  PROC5_RETRY('・・・・・・・再試行'),
  SUICA_TITLE('交通系ＩＣ開局処理'),
  PITAPA_TITLE('ＰｉＴａＰａセンタ通信'),
  EDY_DATESET('§Ｅｄｙ日時送信'),
  ITEM_PFM_SUICA_TXT('§交通系ＩＣ開局処理'),
  ITEM_PFM_PITAPA_TXT('§ＰｉＴａＰａセンタ通信'),
  INTERRUPT('・・・・・・中断'),
  FORCE_OPEN('・・・・・・強制開設'),
  BS_REQUEST6_TXT("実績再集計を行って下さい。"),
  PRINT_OPNPROCEND("レジ開設処理  終了"),
  BASPNT_MAGN('1.ﾎﾟｲﾝﾄ基本倍率          %5.2f倍'),
  BUYPNT_MAGN('2.ﾎﾟｲﾝﾄ買上倍率  '),
  BUYPNT_MAGN1('%5.2f倍'),

  /* rmstntt.c */
  CLS_VESCA_CUTOFF_HERE(" ＊＊この部分はお捨て下さい＊＊"),

  NTT_HEAD_1("＊＊＊＊＊ 取引未完了 ＊＊＊＊＊"),
  NTT_HEAD_2("＊＊＊＊ カウンタ不一致 ＊＊＊＊"),
  NTT_ASP_RDTTM('取扱日・時刻 :'),
  NTT_STO_NO('処理通番     :'),
  NTT_ASP_CRDTNO('伝票番号     :'),
  NTT_INFBTN('取引\n情報'),
  NTT_SEND_DATE('端末送信日時 :'),
  NTT_PAY_PRI('金額         :'),
  NTT_PAY_DIV('取扱区分     :'),
  NTT_ASP_RECNO('承認番号     :'),
  NTT_MBR_NO('会員番号     :'),
  NTT_NODATE("該当データなし"),

  FORCE_CLOSE("・・・・・・強制閉設"),

  GET_HISTLOG_STOP('履歴ログ取得◇◇◇中断◇◇◇'),
  GET_HISTLOG('★履歴ログ取得件数・・・・・・・・・・'),
  GET_HISTLOG_PRN('★履歴ログ取得件数'),

  TUO_TRN_HEADER('★ 本部指示取込結果'),
  TUO_TRN_NEG('    無効カード指示受信  '),
  TUO_TRN_TAN('    単品指示受信        '),
  TUO_TRN_OK('      正常件数          '),
  TUO_TRN_NG('      エラー件数        '),
  TUO_TRN_TOTAL('      合計件数          '),

  LAST_SALE_DATE('前回営業日：'),
  NOW_SALE_DATE('今回営業日：'),
  L_CNT('件'),

  HIST_FREQ_ERR('リクエストエラー'),

  HIST_FTP_ERR('(FTP接続)'),
  FTP_GET_NG('ＦＴＰ取得失敗'),

  PRESET_IMG_XPM('画像ﾌﾟﾘｾｯﾄﾌｧｲﾙ'),

  TUO_NEGA('TUO用ネガファイル'),

  ENTRY_TXT_OK('ＯＫ'),
  ENTRY_TXT_NG('ＮＧ'),

  SAG_GET_WEBAPI_PRN_OK('★webapi設定取得処理…………ＯＫ'),
  SAG_GET_WEBAPI_PRN_NG('★webapi設定取得処理…………ＮＧ'),
  SAG_GET_WEBAPI_PRN_SKIP('★webapi設定取得処理…………SKIP'),
  SAG_GET_WEBAPI_EJ_OK('    ★webapi設定取得処理・・・・・・・・・ＯＫ'),
  SAG_GET_WEBAPI_EJ_NG('    ★webapi設定取得処理・・・・・・・・・ＮＧ'),
  SAG_GET_WEBAPI_EJ_SKIP('    ★webapi設定取得処理・・・・・・・・・SKIP'),

  AUTORUN_LABEL2('%2i分後、開設処理を実行します'),

  EQUALDATE("※前回指定した営業日です!!"),

  NOW_DATETIME('現在日付'),

  REG_DAILYLOG_CLR('★レジ日計クリアー・・・・・・・・・・'),
  REG_DAILYLOG_CLR_PRN('★レジ日計クリアー処理'),
  STR_DAILYLOG_CLR('★店舗日計クリアー'),
  STOPENFAILED('開設処理が異常終了しました。'),

  SALE_DATE('営 業 日：'),
  TODAY_DATE('現在日付：'),
  OPEN_OK('よろしいですか？'),
  HIST_CNT('件数：'),
  FREQ_MSG('★ファイルリクエスト・・・・・・・・・'),
  FREQ_MSG_PRN('★ファイルリクエスト'),
  FREQ_ERR_ITEM('更新失敗項目'),

  L_YEAR('年'),
  L_MONTH('月'),
  L_DAY('日'),
  L_SUN('日'),
  L_MON('月'),
  L_TUE('火'),
  L_WED('水'),
  L_THU('木'),
  L_FRI('金'),
  L_SAT('土'),

  HIST_TASK_ERR('コールセンターにお問合せください'),

  GET_HISTLOG_FAIL('※履歴ログ取得失敗!!'),

  HQ_HIST_CNT('上位取得件数：'),

  NGFILE_SENDERR_SPC(' '),
  NGFILE_SENDERR_DIV('ーーーーーーーーーーーーーーーーーーーーーーーーーー'),
  NGFILE_SENDERR1('テキストデータ送信エラー(本部への実績送信ｴﾗｰ)が発生。'),
  NGFILE_SENDERR2('再送信は、次の手順で実行可能です。'),
  NGFILE_SENDERR3('※  再送信前に  ※'),
  NGFILE_SENDERR4(' 本部で準備が必要な場合があります。'),
  NGFILE_SENDERR5(' 本部に再送信を行う旨をご連絡の上、再送信して下さい。'),
  NGFILE_SENDERR6('再送信の手順：'),
  NGFILE_SENDERR7(' 1)「ユーザーセットアップ」をタッチします。'),
  NGFILE_SENDERR8(' 2)「テキストデータ関連」をタッチします。'),
  NGFILE_SENDERR9(' 3)「テキストデータ再送信」をタッチします。'),
  NGFILE_SENDERR10(' 4) NGと表示されている日付をタッチして反転させます。'),
  NGFILE_SENDERR11(' 5)「実行」をタッチします。'),
  NGFILE_SENDERR12(' 6)「実行中・・・」が消えたら再送信は完了です。'),
  NGFILE_SENDERR13('   メインメニューを表示するまで'),
  NGFILE_SENDERR14('   「終了」をタッチしてください。'),

  REGCTR_FAIL('レジコントロールマスタが存在しません。'),
  REGCTR_FAIL2('    設定を確認して下さい。'),
  GET_NEW_INFO('最新情報は取得できません。よろしいですか？'),

  NOBTN_PROC('・・・・・・いいえ'),

  FORCE_END('強制終了');

  final String val;
  const LRmstopncls(this.val);
}

///  関連tprxソース: L_jmups_sales.h
class LJmupsSales{
  static const START_TIME =	"処理開始時間：";
  static const OPEN_EXC =	"<OPEN>";
  static const CLOSE_EXC = "<CLOSE>";
  static const RESEND_SALEDATE = "売上計上日";
  static const JMUPS_STAFF_CD	= "担当者コード";
  static const OPEN_DATETIME = "開設処理日時";
  static const CLOSE_DATETIME	= "閉設処理日時";
  static const OTHER_CHA_AMT = "その他会計売上";
}