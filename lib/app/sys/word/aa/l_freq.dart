/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース:  src\sys\word\aa\L_freq.h
class LFreq{
  static const  TITLE	=	"ファイルリクエスト";
  static const TITLE_MM	= "データ吸い上げ"; /* 2002/03/01 H.Sakamoto */
  static const TITLE_FINIT =	"ファイル初期設定";
  static const  TITLE_FINIT_2	=	"クイックセットアップ";

  static const UNSELECT = "未選択";
  static const MSG_SKIP2 = "ｽｷｯﾌﾟ(個別)";
  static const MSG_FILENOTEXISTERR = "ﾌｧｲﾙなし";
  static const DISP_SELECTED = "■";
  static const ALL_NO_EXEC = "全項目未実行";
  static const NO_EXEC = "未実行";

  static const EXECUTE = "ファイルリクエスト 実行中....";
  static const FINISH  = "ファイルリクエスト 完了";
  static const EXECUTE_MM = "データ吸い上げ 実行中....";  /* 2002/03/01 H.Sakamoto */
  static const FINISH_MM  = "データ吸い上げ 完了";    /* 2002/03/01 H.Sakamoto */
  static const EXECUTE_FINIT = "ファイル初期設定 実行中....";
  static const FINISH_FINIT = "ファイル初期設定 完了";
  static const FINISH_ERROR = "(NGあり、NG項目を確認して下さい)";
  static const FINISH_OK = "(正常終了)";

  static const MSG_ARGERR	= "接続ｴﾗｰ";
  static const MSG_COPYGETLINEERR = "読込みｴﾗｰ";
  static const MSG_COPYPUTLINEERR = "書込みｴﾗｰ";
  static const MSG_SKIP	= "ｽｷｯﾌﾟ";
  static const MSG_COMMANDERR	= "ｺﾏﾝﾄﾞｴﾗｰ";

  static const MSG_FILEDELERR	= "削除ｴﾗｰ";
  static const MSG_FILECOPYERR = "ﾌｧｲﾙｺﾋﾟｰｴﾗｰ";
  static const MSG_FILECPYERR	= "読込みｴﾗｰ";
  static const MSG_TABLENOTFOUND = "読込みｴﾗｰ";
  static const MSG_TBLDELERR = "書込みｴﾗｰ";

  static const DISP_OK = "OK";
  static const DISP_OK_NO_CNT = "OK(%d件)";
  static const DISP_NG = "NG";
  static const DISP_NG_NO = "NG(%d)";
  static const DISP_SKIP = "＊＊";
  static const DISP_UNKOWN = "不明";

  /* error dialog */
  static const	FREQ_ERR_TITLE = "エラー";
  static const	FREQ_ERR_DIALOG_OFFLINE = "ｴﾗｰ：ｵﾌﾗｲﾝ";
  static const	FREQ_ERR_DIALOG_NONEXISTDATA = "ｴﾗｰ：ﾃﾞｰﾀなし";
  static const	FREQ_ERR_DIALOG_VERUNMATCH = "ｴﾗｰ：ﾊﾞｰｼﾞｮﾝ不一致";

  static const NG_RST_B	= " NG \n確認";
  static const MSG_RESULT_TITLE	= "下記のリクエストに失敗しました %d/%d";
  static const BTN_HIST_ERR	= "履歴\n失敗";
  static const MSG_HIST_ERR_TITLE	= "下記の履歴ログ取得に失敗しています %d/%d";

  static const MSG_WAITING = "しばらくお待ちください";

  static const SPEC_OK = "OK";
  static const SPEC_NG = "NG";
}
