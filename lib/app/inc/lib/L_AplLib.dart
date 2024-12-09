/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class LAplLib {


/* for AplLib_BarPrn.c */
  static const String APLLIB_DBL_0 = "０";
  static const String APLLIB_DBL_1 = "１";
  static const String APLLIB_DBL_2 = "２";
  static const String APLLIB_DBL_3 = "３";
  static const String APLLIB_DBL_4 = "４";
  static const String APLLIB_DBL_5 = "５";
  static const String APLLIB_DBL_6 = "６";
  static const String APLLIB_DBL_7 = "７";
  static const String APLLIB_DBL_8 = "８";
  static const String APLLIB_DBL_9 = "９";

/* for calender.c */
  static const String APLLIB_START = "開始日入力";
  static const String APLLIB_END   = "終了日入力";

  static const String APLLIB_BEFORE_MONTH = "前月";
  static const String APLLIB_NEXT_MONTH   = "次月";

  static const String APLLIB_SMALL = "＜";
  static const String APLLIB_BIG   = "＞";

  static const String APLLIB_SELECT_0 = "日付選択";
  static const String APLLIB_SELECT_1 = "開始日 終了日 選択";

  static const String GUIDANCE_SELECT_0 = "日付を選択して「入力」をタッチして下さい。\n\n";
  static const String GUIDANCE_SELECT_1 = "1. 日付を選択して「開始日」をタッチします。\n2. 日付を選択して「終了日」をタッチします。\n3. 日付を確認の上、「確定」をタッチして下さい。";

  static const String APLLIB_MON_1  = "１ 月";
  static const String APLLIB_MON_2  = "２ 月";
  static const String APLLIB_MON_3  = "３ 月";
  static const String APLLIB_MON_4  = "４ 月";
  static const String APLLIB_MON_5  = "５ 月";
  static const String APLLIB_MON_6  = "６ 月";
  static const String APLLIB_MON_7  = "７ 月";
  static const String APLLIB_MON_8  = "８ 月";
  static const String APLLIB_MON_9  = "９ 月";
  static const String APLLIB_MON_10 = "10 月";
  static const String APLLIB_MON_11 = "11 月";
  static const String APLLIB_MON_12 = "12 月";

  static const String APLLIB_CALENDER = "ｶﾚﾝ\nﾀﾞｰ";

/*09.06.23 R.Kawamura*/
  static const String APLLIB_N_MONTH = "ｹ月";
  static const String APLLIB_TODAY   = "本  日";

  static const String APLLIB_SELECT = "選択";

  static const String APLLIB_PREPOP_CALENDER      = "カレンダー";
  static const String APLLIB_PREPOP_CHKDATE_TITLE =	"日付確認";
  static const String APLLIB_PREPOP_CHKDATE_MSG	  = "商品の売上日付を確認して下さい。\n"
                                                    "よろしければ「確定」を\n"
                                                    "変更する場合は「カレンダー」を押して下さい。";
  static const String APLLIB_PREPOP_EXEC          = "確定";
  static const String APLLIB_PREPOP_DATE_INPUT    = "※本日か過去日付のみ";

/* for rs232c_log.c */
  static const String APLLIB_ACX_LABEL          = "レシート情報";
  static const String APLLIB_ACX_NON            = "その他";
  static const String APLLIB_ACX_START          = "入金開始";
  static const String APLLIB_ACX_END            = "入金終了";
  static const String APLLIB_ACX_CINDATA        = "入金記録(確定)";
  static const String APLLIB_ACX_CINDATA_ERR    = "入金記録(エラー)";
  static const String APLLIB_ACX_CINDATA_OTH    = "入金記録(その他)";
  static const String APLLIB_ACX_CINDATA_CANCEL = "入金記録(返金)";
  static const String APLLIB_ACX_CHGOUT         = "出金    ";
//ラベル検索に使用。出金結果と誤認識しないよう、またこのラベル以降に続けて金額を表示するためスペースを記入;
  static const String APLLIB_ACX_CANCEL         = "返金";
  static const String APLLIB_ACX_SPECOUT        = "枚数出金";
  static const String APLLIB_ACX_OUT_OK         = "出金結果 : 正常終了";
  static const String APLLIB_ACX_OUT_NG         = "出金結果 : 異常終了";
  static const String APLLIB_ACX_RETRY          = "リトライ";

  /* TmnEjMake */
  static const APLLIB_TMN_MTITLE     = "取引不明一覧(日計処理)";
  static const APLLIB_TMN_STITLE     = "取引不明一覧(閉設処理)";
  static const APLLIB_TMN_QP_TITILE  = "＊＊＊＊＊＊ ＱＰ ＊＊＊＊＊＊＊";
  static const APLLIB_TMN_iD_TITILE  = "＊＊＊＊＊＊ ｉＤ ＊＊＊＊＊＊＊";
  static const APLLIB_TMN_AST      	= "＊＊＊＊";
  static const APLLIB_TMN_SEQUENCE   = "ｼｰｹﾝｽ番号";
  static const APLLIB_TMN_CODE1      = "ResultCode";
  static const APLLIB_TMN_CODE2      = "ResultCodeExtended";
  static const APLLIB_TMN_CODE3      = "CenterResultCode";
  static const APLLIB_DEAIL_RET_OK   = "正常";
  static const APLLIB_DEAIL_RET_NG   = "異常";
  static const APLLIB_DEAIL_RET_CNCL = "中止";
  static const APLLIB_TMN_QP         = "§ＱＰ日計処理";
  static const APLLIB_TMN_ID         = "§ｉＤ日計処理";
  static const APLLIB_TMN_Edy_TITILE = "＊＊＊＊＊＊ Ｅｄｙ ＊＊＊＊＊＊";
  static const APLLIB_TMN_Edy        = "§Ｅｄｙ日計処理";

  /* AplLib_Auto.c */
  static const String APLLIB_AUTO_PASS0 = "精算業務を開始します。\nパスワードを入力して下さい";
  static const String APLLIB_AUTO_PASS1 = "在高不確定ですが続行します。\nパスワードを入力して下さい";

  static const String APLLIB_AUTO_STROPN_START        = "*** 開店準備 開始 ***";
  static const String APLLIB_AUTO_STROPN_END          = "*** 開店準備 終了 ***";
  static const String APLLIB_AUTO_STROPN_STOP         = "*** 開店準備 中止 ***";
  static const String APLLIB_AUTO_STROPN_ERROR        = "*** 開店準備 エラー[%d] ***";
  static const String APLLIB_AUTO_STRCLS_START        = "*** 精算業務 開始 ***";
  static const String APLLIB_AUTO_STRCLS_END          = "*** 精算業務 終了 ***";
  static const String APLLIB_AUTO_STRCLS_STOP         = "*** 精算業務 中止 ***";
  static const String APLLIB_AUTO_STRCLS_ERROR        = "*** 精算業務 エラー[%d] ***";
  static const String APLLIB_AUTO_STRCLS_FORCE_TRY    = "*** 自動強制閉設 ***";
  static const String APLLIB_AUTO_STRCLS_FORCE_CANT   = "*** 自動強制閉設 エラー ***";
  static const String APLLIB_AUTO_STRCLS_FORCE_CNCL   = "*** 自動強制閉設 中止 ***";
  static const String APLLIB_AUTO_STRCLS_FORCE_START  = "*** 自動強制閉設 開始 ***";
  static const String APLLIB_CMAUTO_STRCLS_START      = "*** 精算業務(CM) 開始 ***";
  static const String APLLIB_CMAUTO_STRCLS_DLGSTOP    = "*** 精算業務(CM) 中止 ***";
  static const String APLLIB_CMAUTO_STRCLS_END        = "*** 精算業務(CM) 終了 ***";
  static const String APLLIB_CMAUTO_STRCLS_STEP_START = "*** %s 開始 ***";
  static const String APLLIB_CMAUTO_STRCLS_SKIP       = "*** %s スキップ ***";
  static const String APLLIB_CMAUTO_STRCLS_OK         = "*** %s 正常終了 ***";
  static const String APLLIB_CMAUTO_STRCLS_NG         = "*** %s 異常終了 ***";
  static const String APLLIB_CMAUTO_STRCLS_STOP       = "*** %s 中止 ***";

  static const APLLIB_CMAUTO_START = "精算業務(CM)";
  static const APLLIB_CMAUTO_RECALC = "釣機再精査";
  static const APLLIB_CMAUTO_RECALC2 = "釣機在高不確定解除";
  static const APLLIB_CMAUTO_BATREPO = "予約レポート";
  static const APLLIB_CMAUTO_OVERFLOW_MENTE	= "ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ";
  static const APLLIB_CMAUTO_DRWCHK	= "差異チェック";
  static const APLLIB_CMAUTO_PICK	= "売上回収";
  static const APLLIB_CMAUTO_CHGPICK = "釣機回収";
  static const APLLIB_CMAUTO_STAFFOPEN = "従業員オープン";
  static const APLLIB_CMAUTO_STAFFCLS = "従業員クローズ";
  static const APLLIB_CMAUTO_PBCHGUTIL = "収納業務";
  static const APLLIB_CMAUTO_STRCKS	= "閉設処理";
  static const APLLIB_CMAUTO_CHGOUT	= "キャッシュマネジメント出金";
  static const APLLIB_CMAUTO_CHGIN = "キャッシュマネジメント入金";
  static const APLLIB_CMAUTO_INFO_SEND = "売上情報送信";
  static const APLLIB_STAFF_INFO = "操作者No.";

  // acx_err_gui.c
  static const APLLIB_ERRDSP_NEXT = "次へ";
  static const APLLIB_ERRDSP_PREV = "前へ";
  static const APLLIB_ERRDSP_EXIT = "終了";
  static const APLLIB_ERRDSP_ERRCODE = "エラーコード";
  static const APLLIB_ERRDSP_PAGE = "ページ";
  static const APLLIB_ERRDSP_NOIMAGE = "画像データがありません";
  static const APLLIB_ERRDSP_NOIMAGE_CONF = "このページに画像はありません。\n以下の復旧手順テキストをご確認下さい。";
  static const APLLIB_ERRDSP_NOIMAGE_NOTEXT = "このページに画像、復旧手順テキストはありません。";
  static const APLLIB_ERRDSP_NOERRCODE = "未定義エラーが発生しました。\nこのエラーに対する復旧手順の表示はできません。";
  static const APLLIB_ERRDSP_COIN = "硬貨部";
  static const APLLIB_ERRDSP_BILL = "紙幣部";
  static const APLLIB_ERRDSP_CTRL = "ｺﾝﾄﾛｰﾙ部";
}