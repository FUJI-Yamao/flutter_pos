/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/*
 * rc_59hitouch.dart - RM-5900 Main Display Program((Hi-Touch)
 * 関連tprxソース: rc_59hitouch.c
 */
// TODO:いったんrcky_hitouch.cの全コードを持ってきた。そのうち使う分だけdart化した。


// ハイタッチ商品
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rc_59dsp.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/regs/checker/regs_preset_def.dart';

import '../../inc/sys/tpr_log.dart';

const int HI_TOUCH_MAX = 18;

// ハイタッチ商品
///  関連tprxソース: rcky_hitouch.c -  typedef	struct RM59_HI_TOUCH_PLU
class Rm59HiTouchPlu {
  int plu_exist_flg = 0;	// 商品割振り
  int no_plu_mst = 0;			// PLUマスタの未登録
  int plu_select = 0;
  String plu_cd = "";			// 商品コード
  String pos_name = "";		// レシート名称
  String date_time = ""; 	// 受信日時
}

// ハイタッチ画面
///  関連tprxソース: rcky_hitouch.c -  typedef	struct RM59_HI_TOUCH
class Rm59HiTouch {
  // 表示部
  //GSList			*group;
  //GtkWidget		*button[HI_TOUCH_MAX];

  // 商品情報
  List<Rm59HiTouchPlu> PluInf = List.generate(HI_TOUCH_MAX, (index) => Rm59HiTouchPlu());

  // GtkWidget		*exit_btn;
  // GtkWidget		*err_list_btn;
  // GtkWidget		*del_btn;
  // GtkWidget		*staff_btn;

}

// ハイタッチ表示エラー一覧
const int HI_TOUCH_ERR_LIST_MAX = 10;

///  関連tprxソース: rcky_hitouch.c -  typedef	struct RM59_HI_TOUCH_ERR_LIST_DSP
class Rm59HiTouchErrListDsp {
  // GtkWidget		*ent_dtime;
  // GtkWidget		*end_plu;
}

///  関連tprxソース: rcky_hitouch.c -  typedef	struct RM59_HI_TOUCH_ERR_LIST
class Rm59HiTouchErrList {
  List<Rm59HiTouchErrListDsp> ErrList = List.generate(HI_TOUCH_ERR_LIST_MAX, (index) => Rm59HiTouchErrListDsp());

  // GtkWidget		*Window;
  // GtkWidget		*Fixed;
  // GtkWidget		*Title;
  //
  // GtkWidget		*text;
  //
  // GtkWidget		*end_btn;

}

const String RM59_HITOUCH_NO_PLU_TXT = "log/hitouch_no_plu.txt";

/*----------------------------------------------------------------------*
 * Main Window Display
 *----------------------------------------------------------------------*/

class Rc59Hitouch {

  static int rm59_hitouch_btn = 0;
  static int rm59_hitouch_dsp = 0;
  static int rm59_hitouch_del_plu = 0;
  static int rm59_hitouch_del_flg = 0;
  static int rm59_hitouch_err_list_dsp = 0;
  static int rm59_hitouch_disp_typ = 0; // アイテム画面 0:プリセット 1:ハイタッチ
  static int rm59_hitouch_ope_no = 0;  // ハイタッチ受信情報のオペレーションNo.
  static int rm59_hitouch_timer = -1; // フローティング件数タイマーハンドル
  static int rm59_hitouch_select_plu = 0; // ハイタッチの商品選択

  static Rm59HiTouch rm59_Hi_Touch_Info = Rm59HiTouch();
  static Rm59HiTouchErrList rm59_Hi_Touch_Info_ErrList = Rm59HiTouchErrList();


// /*
//  * 関数名       : rc59_Scale_Hitouch_InitDisp
//  * 機能概要     : ハイタッチ接続の初期表示
//  * 呼び出し方法 : rc59_Scale_Hitouch_InitDisp ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// extern	void	rc59_Scale_Hitouch_Init ( void )
// {
// char	log[128];
//
// if ( cm_chk_rm5900_hitouch_mac_no() == 0 )
// {
// return;
// }
//
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : Start", __FUNCTION__ );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// rm59_hitouch_btn = 0;
// rm59_hitouch_dsp = 0;
// rm59_hitouch_err_list_dsp = 0;
// rm59_hitouch_del_flg = 0;
// rm59_hitouch_disp_typ = 1;
// rm59_hitouch_ope_no = 1;
// //	rc59_Scale_Hitouch_Ope_No ( );
//
// memset ( &rm59_Hi_Touch_Info, 0, sizeof(rm59_Hi_Touch_Info) );
//
// }
//
// #if 0
// /*
//  * 関数名       : rc59_Scale_Hitouch_Ope_No
//  * 機能概要     : ハイタッチ受信ログのオペレーションNo,
//  * 呼び出し方法 : rc59_Scale_Hitouch_Ope_No ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	void	rc59_Scale_Hitouch_Ope_No ( void )
// {
// PGresult	*pRes;		// DBの結果
// char		sql[1024+1];
// int		ntuples;
// int		i;
// long		mac_no;
// char		log[128];
//
// memset ( sql, 0x0, sizeof(sql) );
// snprintf ( sql, sizeof(sql)-1, "SELECT row_number() over(order by mac_no) AS ope_no, mac_no FROM c_reginfo_mst WHERE comp_cd='%ld' AND stre_cd='%ld' ORDER BY mac_no;"
// , C_BUF->db_regctrl.comp_cd
// , C_BUF->db_regctrl.stre_cd);
// pRes = db_PQexec ( GetTid(), DB_ERRLOG, chkr_con, sql );
// if ( pRes )
// {
// ntuples = db_PQntuples ( GetTid(), pRes);
// }
// else
// {
// ntuples = 0;
// }
//
// if ( ntuples )
// {
// for ( i = 0; i > ntuples; i ++ )
// {
// mac_no = atol( db_PQgetvalue( GetTid(), pRes, i, db_PQfnumber (GetTid(), pRes, "mac_no") ) );
// if ( mac_no == C_BUF->db_regctrl.mac_no )
// {
// rm59_hitouch_ope_no = atoi( db_PQgetvalue( GetTid(), pRes, i, db_PQfnumber (GetTid(), pRes, "ope_no") ) );
// break;
// }
// }
// }
// db_PQclear ( GetTid(), pRes );
//
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : OpeNo[%d]", __FUNCTION__, rm59_hitouch_ope_no);
// TprLibLogWrite ( GetTid(), TPRLOG_NORMAL, 1, log );
//
// }
// #endif
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Rcv_GetDB
//  * 機能概要     : ハイタッチ受信ログの読込み
//  * 呼び出し方法 : rc59_Scale_Hitouch_Rcv_GetDB ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	void	rc59_Scale_Hitouch_Rcv_GetDB ( void )
// {
// PGconn		*pCon;		// ハイタッチDBコネクション
// PGresult	*pRes;		// DBの結果
// char		sql[SQL_MAX+1];
// int		ntuples;
// int		i, cnt;
//
// char		rcv_datetime[128];		// 日時
// char		where_buf[128];
//
// char		plu_cd[21];			// 商品コード
// char		date_time[128];			// 受信日時
// char		now_date_time[128];			// 受信日時
// int		ret;
// double		difSec;
//
// int		upd_flg;
//
// int		same_plu;
//
// //	char		log[128];
//
// pCon = db_HitouchLogin ( GetTid(), DB_ERRLOG );	// DB接続（ハイタッチサーバ）
// if ( pCon )
// {
// memset ( now_date_time, 0, sizeof(now_date_time) );
// // 現在日時を取得
// memset ( sql, 0, sizeof(sql) );
// snprintf ( sql, sizeof(sql)-1, "SELECT timestamp 'now';" );
// pRes = db_PQexec ( GetTid(), DB_ERRLOG, chkr_con, sql );
// if ( pRes )
// {
// strncpy ( now_date_time, db_PQgetvalue( GetTid(), pRes, 0, 0 ), 19 );
// db_PQclear ( GetTid(), pRes );
// }
//
// // 受信時間が過ぎている商品を削除
// for ( cnt = 0; cnt < HI_TOUCH_MAX ; cnt++ )
// {
// if ( strlen(rm59_Hi_Touch_Info.PluInf[cnt].date_time) )
// {
// // 受信日時
// ret = GetDiffSec ( rm59_Hi_Touch_Info.PluInf[cnt].date_time, now_date_time, &difSec );
// if ( ret != -1 )
// {
// if ( (long)difSec >= C_BUF->db_trm.hi_touch_plu_disp_time )
// {
// memset ( &rm59_Hi_Touch_Info.PluInf[cnt], 0, sizeof(rm59_Hi_Touch_Info.PluInf[cnt]) );
// }
// }
// }
// }
//
// memset ( rcv_datetime, 0, sizeof(rcv_datetime) );
// // 現在日時 - 表示時間(秒)
// if (C_BUF->db_trm.hi_touch_plu_disp_time)
// {
// memset ( sql, 0, sizeof(sql) );
// snprintf ( sql, sizeof(sql)-1, "SELECT timestamp 'now' - interval '%d sec';", C_BUF->db_trm.hi_touch_plu_disp_time );
// pRes = db_PQexec ( GetTid(), DB_ERRLOG, chkr_con, sql );
// if ( pRes )
// {
// strncpy ( rcv_datetime, db_PQgetvalue( GetTid(), pRes, 0, 0 ), 19 );
// db_PQclear ( GetTid(), pRes );
// }
// }
// else
// {
// //datetime_change(NULL, rcv_datetime, 1, FT_YYYYMMDD_HYPHEN_SPACE_HHMMSS_COLON, 1);	// 現在日時(YYYY-MM-DD HH:MM:SS)
// }
//
// #if 0 // debug
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : now_date_time[%s] rcv_datetime[%s]", __FUNCTION__, now_date_time, rcv_datetime);
// TprLibLogWrite ( GetTid(), TPRLOG_NORMAL, 1, log );
// #endif
//
// if ( strlen (rcv_datetime) )
// {
// memset ( where_buf, 0, sizeof(where_buf) );
// snprintf ( where_buf, sizeof(where_buf), "WHERE rcv_datetime >='%s'", rcv_datetime );
// }
//
// // ハイタッチサーバからハイタッチ受信ログをピックアップ
// memset ( sql, 0, sizeof(sql) );
// snprintf ( sql, sizeof(sql)-1, "SELECT * FROM c_hitouch_rcv_log %s ORDER BY rcv_datetime;", where_buf );
//
// pRes = db_PQexec ( GetTid(), DB_ERRLOG, pCon, sql );
// if ( pRes )
// {
// ntuples = db_PQntuples ( GetTid(), pRes);
// }
// else
// {
// ntuples = 0;
// }
//
// if ( ntuples )
// {
// for ( i = 0; i < ntuples; i ++ )
// {
// //OpeNo = atoi( db_PQgetvalue( GetTid(), pRes, i, db_PQfnumber (GetTid(), pRes, "upd_flg") ) );
// //				if ( OpeNo == 0 )	// 商品加算及び削除していない
//     {
//
// upd_flg = atoi( db_PQgetvalue( GetTid(), pRes, i, db_PQfnumber (GetTid(), pRes, "upd_flg") ) );
//
// memset ( date_time, 0, sizeof(date_time) );
// strncpy ( date_time, db_PQgetvalue( GetTid(), pRes, i, db_PQfnumber (GetTid(), pRes, "rcv_datetime") ), sizeof(date_time) );
//
// memset ( plu_cd, 0, sizeof(plu_cd) );
// strncpy ( plu_cd, db_PQgetvalue( GetTid(), pRes, i, db_PQfnumber (GetTid(), pRes, "plu_cd") ), sizeof(plu_cd) );
//
// // 同一受信情報商品検索
// same_plu = 0;
// for ( cnt = 0; cnt < HI_TOUCH_MAX ; cnt++ )
// {
// if ( rm59_Hi_Touch_Info.PluInf[cnt].plu_exist_flg == 1 )	// 商品格納
//     {
// // 同一時間のPLUあり
// if ( ( strncmp( plu_cd,    rm59_Hi_Touch_Info.PluInf[cnt].plu_cd,    sizeof(plu_cd) ) == 0 )
// && ( strncmp( date_time, rm59_Hi_Touch_Info.PluInf[cnt].date_time, sizeof(date_time) ) == 0 ) )
// {
// same_plu = 1;
// break;
// }
// }
// }
//
// if ( ( upd_flg )	// 更新済み
// && ( same_plu) )	// 同一商品
//     {
// memset ( &rm59_Hi_Touch_Info.PluInf[cnt], 0, sizeof(rm59_Hi_Touch_Info.PluInf[cnt]) );
// continue;
// }
//
// if ( upd_flg )		// 更新済み
//     {
// continue;
// }
//
// // 同一商品の場合、セットしない
// if ( same_plu )
// {
// continue;
// }
//
// // 受信情報格納処理
// for ( cnt = 0; cnt < HI_TOUCH_MAX ; cnt++ )
// {
// if ( rm59_Hi_Touch_Info.PluInf[cnt].plu_exist_flg == 0 )	// 商品未格納
//     {
// ret = rcRead_plu_FL_NameGet ( plu_cd, rm59_Hi_Touch_Info.PluInf[cnt].pos_name, sizeof(rm59_Hi_Touch_Info.PluInf[i].pos_name) );	// 商品名
// if (ret == OK )
// {
// rm59_Hi_Touch_Info.PluInf[cnt].no_plu_mst = 0;
// }
// else
// {
// strncpy ( rm59_Hi_Touch_Info.PluInf[cnt].pos_name, plu_cd, ASC_EAN_13 );						// 商品名(仮)
// rm59_Hi_Touch_Info.PluInf[cnt].no_plu_mst = 1;
// }
// strncpy ( rm59_Hi_Touch_Info.PluInf[cnt].plu_cd, plu_cd, ASC_EAN_13 );							// 商品コード
// strncpy ( rm59_Hi_Touch_Info.PluInf[cnt].date_time, date_time, sizeof(date_time) );
// rm59_Hi_Touch_Info.PluInf[cnt].plu_exist_flg = 1;
// break;
// }
// }
// }
// }
// }
// db_PQclear ( GetTid(), pRes );
// db_PQfinish ( GetTid(), pCon );
// }
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Rcv_UpdateDB
//  * 機能概要     : ハイタッチ受信情報更新
//  * 呼び出し方法 : rc59_Scale_Hitouch_Rcv_UpdateDB ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	int	rc59_Scale_Hitouch_Rcv_UpdateDB ( short idx )
// {
// PGconn		*pCon;		// ハイタッチDBコネクション
// PGresult	*pRes;		// DBの結果
// char		sql[SQL_MAX+1];
//
// //char		ope_buf[16];			// オペレーションNo.バッファ
//
// int		ret = OK;
//
// char		log[128];
//
// pCon = db_HitouchLogin ( GetTid(), DB_ERRLOG );	// DB接続（ハイタッチサーバ）
// if ( pCon )
// {
//
// // オペレーションNo.
// //memset ( ope_buf, 0, sizeof(ope_buf) );
// //snprintf ( ope_buf, sizeof(ope_buf), "upd_flg='1'" );
//
// // c_hitouch_rcv_logの更新
// memset ( sql, 0, sizeof(sql) );
// snprintf ( sql, sizeof(sql)-1, "UPDATE c_hitouch_rcv_log SET upd_flg='1' WHERE rcv_datetime='%s' AND plu_cd='%s';"
// //, ope_buf
// , rm59_Hi_Touch_Info.PluInf[idx].date_time
// , rm59_Hi_Touch_Info.PluInf[idx].plu_cd );
// //printf("%s():SQL[%s]\n", __FUNCTION__, sql);
// pRes = db_PQexec ( GetTid(), DB_ERRLOG, pCon, sql );
// if ( pRes == NULL )
// {
// memset ( log, 0x0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s():[c_hitouch_rcv_log] UPDATE Error", __FUNCTION__ );
// TprLibLogWrite ( GetTid(), TPRLOG_ERROR, -1, log );
// ret = MSG_HITOUCH_RCV_UPDATE_ERROR;
// }
//
// db_PQclear ( GetTid(), pRes );
// db_PQfinish ( GetTid(), pCon );
// }
//
// return ( ret );
//
// }
//
// /*
//  * 関数名       : rc59_hitouch_watch_start
//  * 機能概要     : ハイタッチのプリセット更新監視開始
//  * 呼び出し方法 : rc59_hitouch_watch_start ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// extern	void	rc59_hitouch_watch_timer_start ( void )
// {
// int	gtim;
//
// if ( rm59_hitouch_timer == -1 )
// {
// gtim = C_BUF->db_trm.hi_touch_rcv_chk_time * 1000;
//
// rm59_hitouch_timer = gtk_timeout_add ( gtim, (GtkFunction)rc59_Scale_Hitouch_Plu_Button_Disp, 0 );
// }
// }
//
// /*
//  * 関数名       : rc59_hitouch_watch_timer_end
//  * 機能概要     : ハイタッチのプリセット更新監終了
//  * 呼び出し方法 : rc59_hitouch_watch_timer_end ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// extern	void	rc59_hitouch_watch_timer_end ( void )
// {
// if ( rm59_hitouch_timer != -1 )
// {
// gtk_timeout_remove ( rm59_hitouch_timer );
// rm59_hitouch_timer = -1;
// }
// }

  /// 関数名       : rc59_Scale_Hitouch_Disp_Typ
  /// 機能概要     : ハイタッチ接続の表示条件
  /// 呼び出し方法 : rc59_Scale_Hitouch_Disp_Typ ()
  /// パラメータ   : なし
  /// 戻り値       : なし
  ///  関連tprxソース: rcky_hitouch.c -  rc59_Scale_Hitouch_Disp_Typ
  static Future<int> rc59ScaleHitouchDispTyp() async {
    if (await CmCksys.cmChkRm5900HiTouchMacNo() == 0)
    {
      return (0);
    }
    return (rm59_hitouch_disp_typ);
  }

// /*
//  * 関数名       : rc59_Scale_Hitouch_Set_Disp_Typ
//  * 機能概要     : ハイタッチ接続の表示状態セット
//  * 呼び出し方法 : rc59_Scale_Hitouch_Set_Disp_Typ ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// extern	void	rc59_Scale_Hitouch_Set_Disp_Typ ( short dsp_flg )
// {
// if ( cm_chk_rm5900_hitouch_mac_no() == 0 )
// {
// dsp_flg = 0;
// }
//
// rm59_hitouch_disp_typ = dsp_flg;
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Disp
//  * 機能概要     : ハイタッチ接続のハイタッチ画面
//  * 呼び出し方法 : rc59_Scale_Hitouch_Disp ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// extern	void	rc59_Scale_Hitouch_Disp ( void )
// {
// char		log[128];
//
// if ( cm_chk_rm5900_hitouch_mac_no() == 0 )
// {
// return;
// }
//
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : Start ", __FUNCTION__ );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// if ( rm59_hitouch_dsp == 0 )
// {
// if (Tran.rm59_hitouch_pix == NULL)
// {
// Tran.rm59_hitouch_pix = create_pixmap_nochg (Tran.window, "scale/rm59_hitouch_back.png", 0);
// gtk_fixed_put (GTK_FIXED(Tran.pix_lst_area), Tran.rm59_hitouch_pix, PRESET_PUT_X, 0);
// gtk_widget_show ( Tran.rm59_hitouch_pix );
//
// rm59_hitouch_dsp = 1;	// ハイタッチ画面作成済み
//
// // 「エラー一覧」ボタン
// rc59_Scale_Hitouch_ErrListt_Button ( );
//
// rc59_Scale_Hitouch_Delete_Button ( );	// 「削除」ボタン
//
// // 「閉じる」ボタン
// rm59_Hi_Touch_Info.exit_btn = rcDrawButton(Tran.window, Red, White, IMG_RM59_CLOSE_BTN, "", 903);
// ChgStyle(rm59_Hi_Touch_Info.exit_btn, &ColorSelect[None], &ColorSelect[None], &ColorSelect[None], 20);
// gtk_fixed_put(GTK_FIXED(Tran.rm59_hitouch_pix), rm59_Hi_Touch_Info.exit_btn, 738, 318);
// gtk_signal_connect(GTK_OBJECT(rm59_Hi_Touch_Info.exit_btn), "pressed", GTK_SIGNAL_FUNC(rc59_Scale_Hitouch_Exit_Button), (gpointer)0);
//
// }
//
// }
// rc59_hitouch_watch_timer_start ( );
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_ErrListt_Button
//  * 機能概要     : 「エラー一覧」ボタン作成
//  * 呼び出し方法 : rc59_Scale_Hitouch_ErrListt_Button ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	void	rc59_Scale_Hitouch_ErrListt_Button ( void )
// {
// char	*tpr_path;
// char	file_name[256];
// char	log[128];
//
// // ハイタッチ接続が「しない」場合は戻る
// if ( cm_chk_rm5900_hitouch_mac_no() == 0 )
// {
// return;
// }
//
// // ハイタッチの画面が未作成の場合は戻る
// if (rm59_hitouch_dsp == 0)
// {
// return;
// }
//
// // [TPRX_HOME]の指定がない場合は戻る
// if ((tpr_path = getenv("TPRX_HOME")) == NULL)
// {
// return;
// }
//
// // 「hitouch_no_plu.txt」がレジ内に存在しない場合は戻る
// memset ( file_name, 0, sizeof(file_name) );
// snprintf ( file_name, sizeof(file_name), "%s/%s", tpr_path, RM59_HITOUCH_NO_PLU_TXT );
// if( access( file_name, F_OK ) != 0 )
// {
// return;
// }
//
//
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : Start ", __FUNCTION__ );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// if ( rm59_hitouch_err_list_dsp == 0 )
// {
// // 「エラー一覧」ボタン
// rm59_Hi_Touch_Info.err_list_btn = rcDrawButton(Tran.window, Red, White, IMG_RM59_ERR_LIST_BTN, "", 903);
// ChgStyle(rm59_Hi_Touch_Info.err_list_btn, &ColorSelect[None], &ColorSelect[None], &ColorSelect[None], 20);
// gtk_fixed_put(GTK_FIXED(Tran.rm59_hitouch_pix), rm59_Hi_Touch_Info.err_list_btn, 738, 56);
// gtk_signal_connect(GTK_OBJECT(rm59_Hi_Touch_Info.err_list_btn), "pressed", GTK_SIGNAL_FUNC(rc59_Scale_Hitouch_ErrListt_Disp), (gpointer)0);
// }
//
// rm59_hitouch_err_list_dsp = 1;
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_ErrListt_Disp
//  * 機能概要     : 「エラー一覧」選択
//  * 呼び出し方法 : rc59_Scale_Hitouch_ErrListt_Disp ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	void	rc59_Scale_Hitouch_ErrListt_Disp (GtkWidget *widget, gpointer data)
// {
// char	log[128];
//
// // ハイタッチ接続が「しない」場合は戻る
// if ( cm_chk_rm5900_hitouch_mac_no() == 0 )
// {
// return;
// }
//
// // エラー一覧ボタン未作成の場合は戻る
// if (rm59_hitouch_err_list_dsp == 0)
// {
// return;
// }
//
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : Start ", __FUNCTION__ );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// rc28MainWindow_SizeChange(1);
//
// rm59_Hi_Touch_Info_ErrList.Window = gtk_window_new( GTK_WINDOW_POPUP );
// gtk_object_set_data(GTK_OBJECT(rm59_Hi_Touch_Info_ErrList.Window), "Window", rm59_Hi_Touch_Info_ErrList.Window);
// gtk_window_set_title(GTK_WINDOW(rm59_Hi_Touch_Info_ErrList.Window), "Window");
// gtk_widget_set_usize(rm59_Hi_Touch_Info_ErrList.Window , 360, 240);
// gtk_window_set_position(GTK_WINDOW(rm59_Hi_Touch_Info_ErrList.Window), GTK_WIN_POS_CENTER);
// gtk_container_border_width(GTK_CONTAINER(rm59_Hi_Touch_Info_ErrList.Window ), 1);
// ChgColor(rm59_Hi_Touch_Info_ErrList.Window, &ColorSelect[BlackGray], &ColorSelect[BlackGray], &ColorSelect[BlackGray]);
//
// rm59_Hi_Touch_Info_ErrList.Fixed = gtk_fixed_new();
// gtk_widget_ref(rm59_Hi_Touch_Info_ErrList.Fixed);
// gtk_object_set_data_full(GTK_OBJECT(rm59_Hi_Touch_Info_ErrList.Window), "name", rm59_Hi_Touch_Info_ErrList.Fixed, (GtkDestroyNotify)gtk_widget_unref);
// ChgColor(rm59_Hi_Touch_Info_ErrList.Fixed, &ColorSelect[LightGray], &ColorSelect[LightGray], &ColorSelect[LightGray]);
// gtk_container_add( GTK_CONTAINER(rm59_Hi_Touch_Info_ErrList.Window ), rm59_Hi_Touch_Info_ErrList.Fixed);
//
// rm59_Hi_Touch_Info_ErrList.Title = gtk_top_menu_new_with_size(IMG_RM59_NO_PLU_MST, 356, 40, White, MidiumGray, White);
// gtk_fixed_put(GTK_FIXED(rm59_Hi_Touch_Info_ErrList.Fixed), rm59_Hi_Touch_Info_ErrList.Title, 1, 1);
// gtk_widget_show(rm59_Hi_Touch_Info_ErrList.Title);
//
// rm59_Hi_Touch_Info_ErrList.text = rcDrawEntry(rm59_Hi_Touch_Info_ErrList.Window, BlackGray, White, "text", 900, 0);
// gtk_fixed_put(GTK_FIXED(rm59_Hi_Touch_Info_ErrList.Fixed), rm59_Hi_Touch_Info_ErrList.text, 3, 45);
// gtk_widget_show(rm59_Hi_Touch_Info_ErrList.text);
// ChgStyle(rm59_Hi_Touch_Info_ErrList.text, &ColorSelect[DarkNavy], &ColorSelect[White], &ColorSelect[White], 16);
// gtk_misc_set_alignment( GTK_MISC(rm59_Hi_Touch_Info_ErrList.text), PRG_ALIGN_LEFT, PRG_ALIGN_TOP );	// 左上寄せ
//
// rm59_Hi_Touch_Info_ErrList.end_btn = rcDrawButton(rm59_Hi_Touch_Info_ErrList.Window, Red, White, BTN_END, "", 1);
// gtk_fixed_put(GTK_FIXED(rm59_Hi_Touch_Info_ErrList.Fixed), rm59_Hi_Touch_Info_ErrList.end_btn, 312, 190);
// gtk_widget_show(rm59_Hi_Touch_Info_ErrList.end_btn);
// gtk_signal_connect(GTK_OBJECT(rm59_Hi_Touch_Info_ErrList.end_btn), "pressed", GTK_SIGNAL_FUNC(rc59_Scale_Hitouch_ErrListt_End), GTK_OBJECT(rm59_Hi_Touch_Info_ErrList.Window));
//
// gtk_widget_show( rm59_Hi_Touch_Info_ErrList.Fixed );
// gtk_widget_show( rm59_Hi_Touch_Info_ErrList.Window );
//
// rc59_Scale_Hitouch_ErrListt_Text ( );
//
// rm59_win_dsp_flg = 1;
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_ErrListt_Text
//  * 機能概要     : ＮＯ商品マスタテキストの中身を表示
//  * 呼び出し方法 : rc59_Scale_Hitouch_ErrListt_Text ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	void	rc59_Scale_Hitouch_ErrListt_Text ( void )
// {
// char	*tpr_path;
// char	file_name[256];
// FILE	*fp;
// char	buf[40];
// char	txt_buf[10*40];
// int	i;
//
//
// // [TPRX_HOME]の指定がない場合は戻る
// if ((tpr_path = getenv("TPRX_HOME")) == NULL)
// {
// return;
// }
//
// // 「hitouch_no_plu.txt」の中身を最大10行分読み出す
// memset ( file_name, 0, sizeof(file_name) );
// snprintf ( file_name, sizeof(file_name), "%s/%s", tpr_path, RM59_HITOUCH_NO_PLU_TXT );
// if ( ( fp = fopen ( file_name, "r" ) ) != NULL)
// {
// i = 0;
// memset (buf, 0x00, sizeof(buf) );
// memset (txt_buf, 0x00, sizeof(txt_buf) );
// while ( fgets( buf, sizeof(buf), fp ) != NULL )
// {
// strncat ( txt_buf, buf, sizeof(buf) );
// i++;
// if ( i > 10 )
// {
// break;
// }
// memset ( buf, 0x00, sizeof(buf) );
// }
// fclose ( fp );
// }
//
// gtk_round_entry_set_text(rm59_Hi_Touch_Info_ErrList.text, txt_buf);
//
// }
//
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_ErrListt_End
//  * 機能概要     : ハイタッチエラー一覧を閉じる
//  * 呼び出し方法 : rc59_Scale_Hitouch_ErrListt_End ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	void	rc59_Scale_Hitouch_ErrListt_End (GtkWidget *widget, gpointer data)
// {
// gtk_widget_destroy ( rm59_Hi_Touch_Info_ErrList.Window );
// memset ( &rm59_Hi_Touch_Info_ErrList, 0x00, sizeof(rm59_Hi_Touch_Info_ErrList) );
//
// rm59_win_dsp_flg = 0;
// rc28MainWindow_SizeChange(0);
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Delete_Button
//  * 機能概要     : 「削除」ボタン作成
//  * 呼び出し方法 : rc59_Scale_Hitouch_Delete_Button ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	void	rc59_Scale_Hitouch_Delete_Button ( void )
// {
// char	log[128];
//
// // ハイタッチ接続が「しない」場合は戻る
// if ( cm_chk_rm5900_hitouch_mac_no() == 0 )
// {
// return;
// }
//
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : Start ", __FUNCTION__ );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// // 「削除」ボタン
// rm59_Hi_Touch_Info.del_btn = rcDrawButton(Tran.window, TurquoiseBlue, White, IMG_RM59_DEL_BTN, "", 903);
// ChgStyle(rm59_Hi_Touch_Info.del_btn, &ColorSelect[None], &ColorSelect[None], &ColorSelect[None], 20);
// gtk_fixed_put(GTK_FIXED(Tran.rm59_hitouch_pix), rm59_Hi_Touch_Info.del_btn, 738, 218);
// gtk_signal_connect(GTK_OBJECT(rm59_Hi_Touch_Info.del_btn), "pressed", GTK_SIGNAL_FUNC(rc59_Scale_Hitouch_Delete_Btn_Push), (gpointer)0);
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Delete_Btn_Push
//  * 機能概要     : 「削除」ボタン押下
//  * 呼び出し方法 : rc59_Scale_Hitouch_Delete_Btn_Push ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	void	rc59_Scale_Hitouch_Delete_Btn_Push (GtkWidget *widget, gpointer data)
// {
// char	log[128];
//
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : Start ", __FUNCTION__ );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// rm59_hitouch_del_flg = (rm59_hitouch_del_flg ? 0 : 1) ;
//
// if (rm59_hitouch_del_flg)
// {
// gtk_round_button_set_color(GTK_ROUND_BUTTON(rm59_Hi_Touch_Info.del_btn), Red);
// }
// else
// {
// gtk_round_button_set_color(GTK_ROUND_BUTTON(rm59_Hi_Touch_Info.del_btn), TurquoiseBlue);
// }
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Exit
//  * 機能概要     : ハイタッチ画面の閉じるボタン処理(プリセット表示)
//  * 呼び出し方法 : rc59_Scale_Hitouch_Exit ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	void	rc59_Scale_Hitouch_Exit_Button (GtkWidget *widget, gpointer data)
// {
//
// rc59_Scale_Hitouch_Select_Clear ( );	// 商品ボタン選択中の場合は解除する。
// rc59_Scale_Hitouch_Exit ( 1 );
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Exit
//  * 機能概要     : ハイタッチ画面の終了(プリセット表示)
//  * 呼び出し方法 : rc59_Scale_Hitouch_Exit ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// extern	void	rc59_Scale_Hitouch_Exit ( short	no_floating_chg )
// {
// int	i;
// char	log[128];
//
// if ( cm_chk_rm5900_hitouch_mac_no() == 0 )
// {
// return;
// }
//
//
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : Start ", __FUNCTION__ );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// if ( rm59_hitouch_dsp )
// {
// rm59_hitouch_disp_typ = 0;
//
// // エラー一覧ボタン作成済み
// if (rm59_hitouch_err_list_dsp)
// {
// gtk_object_destroy( GTK_OBJECT(rm59_Hi_Touch_Info.err_list_btn) );
// rm59_Hi_Touch_Info.err_list_btn = NULL;
// }
// rm59_hitouch_err_list_dsp = 0;
//
// // ハイタッチボタン作成済み
// if ( rm59_hitouch_btn )
// {
// for ( i = 0; i < HI_TOUCH_MAX; i++ )
// {
// gtk_object_destroy( GTK_OBJECT(rm59_Hi_Touch_Info.button[i]) );
// rm59_Hi_Touch_Info.button[i] = NULL;
// }
// }
// rm59_hitouch_btn = 0;
//
// {
// gtk_widget_destroy ( rm59_Hi_Touch_Info.exit_btn );
// gtk_widget_destroy ( Tran.rm59_hitouch_pix );
// Tran.rm59_hitouch_pix = NULL;
// }
// rm59_hitouch_dsp = 0;
//
// // フローティング仕様の場合、プリセット表示は別のところで行うのでここでは実施しない
// if ( no_floating_chg )
// {
// // 「閉じる」を選択したのでプリセットを表示
// preset_display(Tran.pix_lst_area, 0, PRESET_PAGE_NUM, &Tran.preset);
// }
//
// }
//
// }

  /// TODO:定義のみ生かす
  /// 関数名       : rc59_Scale_Hitouch_Chg_Disp
  /// 機能概要     : プリセットからハイタッチへの表示切替え
  /// 呼び出し方法 : rc59_Scale_Hitouch_Chg_Disp ()
  /// パラメータ   : なし
  /// 戻り値       : なし
  ///  関連tprxソース: rcky_hitouch.c -  rc59_Scale_Hitouch_Chg_Disp
  static Future<void> rc59ScaleHitouchChgDisp() async {
    // PresetData preset = PresetData();
    // String log = "";
    //
    // if (await CmCksys.cmChkRm5900HiTouchMacNo() == 0 )
    // {
    //   return;
    // }
    //
    // // ハイタッチ画面表示中の場合は戻る
    // if (Rc59hitouch.rm59_hitouch_disp_typ != 0)
    // {
    //   return;
    // }
    //
    // TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rc59ScaleHitouchChgDisp : Start ");
    //
    // // フローティング仕様の場合、プリセットからハイタッチ画面に切替えた時、従業員ボタンの買上点数更新を止める
    // if (CmCksys.cmChkRm5900FloatingSystem() != 0)
    // {
    //   Rc59dsp.rc59FloatingWatchTimerEnd();
    // }
    //
    // // ハイタッチ画面の表示
    // rm59_hitouch_disp_typ = 1;
    // rm59_hitouch_dsp = 0;
    //
    // // プリセット画面の削除
    // preset = &Tran.preset;
    // preset_destroy(preset);
    //
    // gtk_signal_disconnect(GTK_OBJECT(regs_page_note), regs_page_connect_id);
    // preset_clearpage();
    // gtk_widget_destroy(regs_page_note);
    // regs_page_note = NULL;
    //
    // rc59_Scale_Hitouch_Disp ( );
    // rc59_Scale_Hitouch_Plu_Button_Disp ( );

  }

// /*
//  * 関数名       : rc59_Scale_Hitouch_Plu_Button
//  * 機能概要     : ハイタッチからプリセットへの表示切替え
//  * 呼び出し方法 : rc59_Scale_Hitouch_Plu_Button ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static gshort   BtnWidth2[] = {BTN10_XSIZE+3, BTN10_XSIZE+3, BTN10_XSIZE+3};
// static gshort   BtnHeight2[] = {BTN10_YSIZE+1, BTN11_YSIZE+1, BTN11_YSIZE+1};
//
// static	void	rc59_Scale_Hitouch_Make_Plu_Button (void)
// {
// int	btnno;
// int	x, y;
// int	x_posi, y_posi;
// short	size = 0;
// short	line = 0, column = 0;
// short	colno;
//
// if ( cm_chk_rm5900_hitouch_mac_no() == 0 )
// {
// return;
// }
//
// btnno = 0;
// x = 0;
// y = 0;
// size = BTN_BIG;
//
// C_BUF->vtcl_rm5900_regs_preset_flg = 1;	// 登録プリセットの調整：する
//
// for (  x = 0; x < 6; x++ )
// {
// for (  y = 0; y < 3; y++ )
// {
// if (btnno != 0)
// {					/* ボタンを生成／表示 */
// rm59_Hi_Touch_Info.group = gtk_preset_button_group(GTK_PRESET_BUTTON(rm59_Hi_Touch_Info.button[btnno-1]));
// }
// rm59_Hi_Touch_Info.button[btnno] = gtk_button_new_with_size_group_main(" ", size, 1, 2, 20);
//
// line = y * size;
// column = x * size;
//
// x_posi = column * BtnWidth2[size] + PRESET_GAP;;
// y_posi = line   * BtnHeight2[size] + PRESET_GAP;
//
// gtk_fixed_put(GTK_FIXED(Tran.rm59_hitouch_pix), rm59_Hi_Touch_Info.button[btnno], x_posi, y_posi);	/* resize button */
// colno = CreamYellow4;
// gtk_select_button_set_color(GTK_SELECT_BUTTON(rm59_Hi_Touch_Info.button[btnno]), colno);
// gtk_signal_connect(GTK_OBJECT(rm59_Hi_Touch_Info.button[btnno]), "pressed", GTK_SIGNAL_FUNC(rc59_Scale_Hitouch_Select_Plu_Button), (gpointer)(btnno + 1));
// gtk_widget_show(rm59_Hi_Touch_Info.button[btnno]);
//
// btnno ++;
// }
// }
//
// C_BUF->vtcl_rm5900_regs_preset_flg = 0;	// 登録プリセットの調整：しない
//
// rm59_hitouch_btn = 1;	// ハイタッチボタン作成済み
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Select_Plu_Button
//  * 機能概要     : ハイタッチ商品選択
//  * 呼び出し方法 : rc59_Scale_Hitouch_Select_Plu_Button ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	void	rc59_Scale_Hitouch_Select_Plu_Button (GtkWidget *widget, gpointer data)
// {
// char	log[128];
// int	btn;
// int	i;
// char	pos_name[301];
// EucAdj	adj;
//
// btn = (int)data;
// btn -= 1;
//
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : Start button[%d]", __FUNCTION__, btn );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// rm59_hitouch_del_plu = 0;
//
// // 選択状態の解除
// for ( i = 0; i < HI_TOUCH_MAX; i++ )
// {
// rm59_Hi_Touch_Info.PluInf[i].plu_select = 0;		// 未選択
// }
//
// rm59_hitouch_select_plu = 0;
//
// if ( rm59_Hi_Touch_Info.PluInf[btn].plu_exist_flg == 1 )	// 商品あり
//     {
// if ( rm59_Hi_Touch_Info.PluInf[btn].no_plu_mst )
// {
// rm59_hitouch_del_plu = btn + 1;
// rc59_ScaleDlgDsp1 ( MSG_NO_PLU_MST, TPRDLG_PT5, (void *)rc59_Scale_Hitouch_Del_Plu_Btn, BTN_YES, NULL, NULL, rm59_Hi_Touch_Info.PluInf[btn].plu_cd );
//
// rc59_Scale_Hitouch_NoPlu_MakeTxt ( btn );
// rc59_Scale_Hitouch_ErrListt_Button ( );
//
// }
// else
// {
// if (rm59_hitouch_del_flg)
// {
// rm59_hitouch_del_plu = btn + 1;
// memset ( pos_name, 0, sizeof(pos_name) );
// strncpy ( pos_name, rm59_Hi_Touch_Info.PluInf[btn].pos_name, sizeof(pos_name) );
// adj = AplLib_EucAdjust ( pos_name, sizeof(pos_name)-1, 40 );
// rc59_ScaleDlgDsp1 ( MSG_SELECT_PLU_DELETEE, TPRDLG_PT5, (void *)rc59_Scale_Hitouch_Del_Plu_Btn, BTN_YES, (void *)rc59_Scale_Hitouch_Dlg_No_Btn, BTN_NO, pos_name );
//
// }
// else
// {
// rm59_Hi_Touch_Info.PluInf[btn].plu_select = 1;	// 選択
// rm59_hitouch_select_plu = 1;
//
// // フローティング仕様の場合、商品選択でハイタッチ画面を閉じてプリセットに切り替える
// if ( ( cm_chk_rm5900_floating_system ( ) )		// フローティング仕様
// && ( rcRfdOprCheckManualRefundMode() == FALSE ) )	// 手動返品以外
//     {
// rc59_Scale_Hitouch_Exit ( 1 );
// }
//
// // 商品の呼出
// memset ( CMEM->ent.entry, 0, sizeof(CMEM->ent.entry) );
// CMEM->ent.tencnt = 13;
// cm_asctobcd( (char *)CMEM->ent.entry,
// (char *)rm59_Hi_Touch_Info.PluInf[btn].plu_cd,
// sizeof(CMEM->ent.entry), ASC_EAN_13);
// CMEM->stat.FncCode = KY_PLU ;
// rcKyPlu();
//
// }
// }
//
// }
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Del_Plu_Btn
//  * 機能概要     : ハイタッチ商品の削除
//  * 呼び出し方法 : rc59_Scale_Hitouch_Del_Plu_Btn ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	int	rc59_Scale_Hitouch_Del_Plu_Btn ( GtkWidget *widget, gpointer data )
// {
// char	log[128];
// int	btn;
//
// TprLibDlgClear ( );
//
// if (rm59_hitouch_del_plu)
// {
// btn = rm59_hitouch_del_plu -1;
//
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : Start button[%d]", __FUNCTION__, rm59_hitouch_del_plu );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// // ハイタッチサーバ更新「削除する為、使用済みにする」
// rc59_Scale_Hitouch_Rcv_UpdateDB ( btn );
//
// gtk_preset_button_off( GTK_PRESET_BUTTON(rm59_Hi_Touch_Info.button[btn]) );
// memset ( &rm59_Hi_Touch_Info.PluInf[btn], 0, sizeof(rm59_Hi_Touch_Info.PluInf[btn]) );
// rc59_Scale_Hitouch_Plu_Button_Disp ( );
//
// rm59_hitouch_del_plu = 0;
// }
//
// if (rm59_hitouch_del_flg)
// {
// rc59_Scale_Hitouch_Delete_Btn_Push (NULL, NULL);
// }
//
//
// return( 0 );
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Dlg_No_Btn
//  * 機能概要     : ダイアログメッセージの「いいえ」選択
//  * 呼び出し方法 : rc59_Scale_Hitouch_Dlg_No_Btn ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	int	rc59_Scale_Hitouch_Dlg_No_Btn ( GtkWidget *widget, gpointer data )
// {
// char	log[128];
//
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : Start button[%d]", __FUNCTION__, rm59_hitouch_del_plu );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// TprLibDlgClear ( );
//
// if (rm59_hitouch_del_plu)
// {
// rm59_hitouch_del_plu = 0;
// }
//
// if (rm59_hitouch_del_flg)
// {
// rc59_Scale_Hitouch_Delete_Btn_Push (NULL, NULL);
// }
//
// return( 0 );
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_No_Select_Plu_Button
//  * 機能概要     : ハイタッチ商品選択
//  * 呼び出し方法 : rc59_Scale_Hitouch_No_Select_Plu_Button ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// extern	void	rc59_Scale_Hitouch_No_Select_Plu_Button ( void )
// {
// int	i;
// char	log[128];
//
// memset ( log, 0, sizeof(log) );
// snprintf ( log, sizeof(log), "%s : Start ", __FUNCTION__ );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// // 選択状態の解除
// for ( i = 0; i < HI_TOUCH_MAX; i++ )
// {
// rm59_Hi_Touch_Info.PluInf[i].plu_select = 0;		// 未選択
// }
//
// rm59_hitouch_select_plu = 0;
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Plu_Button_Disp
//  * 機能概要     : ハイタッチからプリセットへの表示切替え
//  * 呼び出し方法 : rc59_Scale_Hitouch_Plu_Button_Disp ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
//
// static	void	rc59_Scale_Hitouch_Plu_Button_Disp (void)
// {
// int	i;
// char	buf[512];
// int	name_siz;
//
// rc59_hitouch_watch_timer_end ( );
//
// if ( rm59_hitouch_disp_typ == 0 )
// {
// rc59_hitouch_watch_timer_start ( );
// return;
// }
//
// // ボタン未作成の場合は作成する。
// if ( rm59_hitouch_btn == 0 )
// {
// rc59_Scale_Hitouch_Make_Plu_Button ( );
// }
//
// if ( rm59_hitouch_select_plu == 0 )						// ハイタッチの商品ボタン：未選択
//     {
// rc59_Scale_Hitouch_Rcv_GetDB ( );
//
// name_siz = sizeof(rm59_Hi_Touch_Info.PluInf[i].pos_name) - 1;
//
// for ( i = 0; i < HI_TOUCH_MAX; i++ )
// {
// if ( rm59_Hi_Touch_Info.PluInf[i].plu_exist_flg == 1 )			// 商品あり
//     {
// gtk_widget_show( rm59_Hi_Touch_Info.button[i] );			// ボタン状態を：表示
// gtk_widget_set_sensitive( rm59_Hi_Touch_Info.button[i], TRUE );	// ボタン状態を：有効
//
// // 商品名をボタンに合わせて編集
// memset ( buf, 0, sizeof(buf) );
// strncpy ( buf, rm59_Hi_Touch_Info.PluInf[i].pos_name, name_siz );
// prg_preset_set_return2 ( buf, strlen(buf), BTN_BIG);		// 商品名に４倍角サイズに合わせた改行コードをセット
//
// gtk_regsbutton_set_text( rm59_Hi_Touch_Info.button[i], buf );	// ボタンに文字をセット
// }
// else
// {
// gtk_widget_hide( rm59_Hi_Touch_Info.button[i] );			// ボタン状態を：表示
// gtk_widget_set_sensitive( rm59_Hi_Touch_Info.button[i], FALSE );	// ボタン状態：無効
//
// gtk_regsbutton_set_text( rm59_Hi_Touch_Info.button[i], " " );	// ボタンに表示した商品名をクリア
//
// }
// //rm59_Hi_Touch_Info.PluInf[i].plu_select = 0;					// 未選択
// }
// }
//
// rc59_hitouch_watch_timer_start ( );
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Plu_Add_After_Clear
//  * 機能概要     : ハイタッチ商品の商品加算後クリア
//  * 呼び出し方法 : rc59_Scale_Hitouch_Plu_Add_After_Clear ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// extern	int	rc59_Scale_Hitouch_Plu_Add_After_Clear (void)
// {
// int	i;
// int	btn;
// int	ret = OK;
//
// btn = -1;
// // 選択した商品情報をクリア
// for ( i = 0; i < HI_TOUCH_MAX; i++ )
// {
// if ( rm59_Hi_Touch_Info.PluInf[i].plu_select == 1 )
// {
// btn = i;
// //memset ( &rm59_Hi_Touch_Info.PluInf[i], 0, sizeof(rm59_Hi_Touch_Info.PluInf[i]) );
// break;
// }
// }
//
// if ( btn != -1 )
// {
// // ハイタッチサーバ更新(使用済み)
// ret = rc59_Scale_Hitouch_Rcv_UpdateDB ( btn );
//
// // ハイタッチ情報更新
// memset ( &rm59_Hi_Touch_Info.PluInf[btn], 0, sizeof(rm59_Hi_Touch_Info.PluInf[btn]) );
// rm59_hitouch_select_plu = 0;
//
//
// // ボタンの状態を戻す
// gtk_preset_button_off( GTK_PRESET_BUTTON(rm59_Hi_Touch_Info.button[btn]) );
//
// // ボタンの再表示
// rc59_Scale_Hitouch_Plu_Button_Disp ( );
// }
//
// return ( ret );
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Select_Plu_Clear
//  * 機能概要     : ハイタッチ商品の商品算を解除
//  * 呼び出し方法 : rc59_Scale_Hitouch_Select_Plu_Clear ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// extern	void	rc59_Scale_Hitouch_Select_Plu_Clear (void)
// {
// int	i;
// int	btn;
//
// btn = -1;
// // 選択した商品情報を検索
// for ( i = 0; i < HI_TOUCH_MAX; i++ )
// {
// if ( rm59_Hi_Touch_Info.PluInf[i].plu_select == 1 )
// {
// btn = i;
// rm59_Hi_Touch_Info.PluInf[i].plu_select = 0;
// rm59_hitouch_select_plu = 0;
// break;
// }
// }
//
// if ( btn != -1 )
// {
//
// // ハイタッチサーバ更新(使用済み)
// rc59_Scale_Hitouch_Rcv_UpdateDB ( btn );
//
//
// // ボタンの状態を戻す
// gtk_preset_button_off( GTK_PRESET_BUTTON(rm59_Hi_Touch_Info.button[btn]) );
//
// // ボタンの再表示
// rc59_Scale_Hitouch_Plu_Button_Disp ( );
// }
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_Select_Clear
//  * 機能概要     : ハイタッチ商品の選択を解除
//  * 呼び出し方法 : rc59_Scale_Hitouch_Select_Clear ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// extern	void	rc59_Scale_Hitouch_Select_Clear (void)
// {
// int	i;
// int	btn;
//
// btn = -1;
// // 選択した商品情報を検索
// for ( i = 0; i < HI_TOUCH_MAX; i++ )
// {
// if ( rm59_Hi_Touch_Info.PluInf[i].plu_select == 1 )
// {
// btn = i;
// rm59_Hi_Touch_Info.PluInf[i].plu_select = 0;
// rm59_hitouch_select_plu = 0;
// break;
// }
// }
//
// if ( btn != -1 )
// {
//
// // ボタンの状態を戻す
// gtk_preset_button_off( GTK_PRESET_BUTTON(rm59_Hi_Touch_Info.button[btn]) );
//
// // ボタンの再表示
// rc59_Scale_Hitouch_Plu_Button_Disp ( );
// }
//
// }
//
// /*
//  * 関数名       : rc59_Scale_Hitouch_NoPlu_MakeTxt
//  * 機能概要     : ハイタッチ商品のＮｏＰＬＵテキスト書込み
//  * 呼び出し方法 : rc59_Scale_Hitouch_NoPlu_MakeTxt ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// static	void	rc59_Scale_Hitouch_NoPlu_MakeTxt ( int idx )
// {
// char	*tpr_path;
// char	file_name[256];
// FILE	*fp;
// char	buf[40];
//
// if ( cm_chk_rm5900_hitouch_system ( ) == 0 )
// {
// return;
// }
//
// if ((tpr_path = getenv("TPRX_HOME")) == NULL)
// {
// return;
// }
//
// memset ( file_name, 0, sizeof(file_name) );
// snprintf ( file_name, sizeof(file_name), "%s/%s", tpr_path, RM59_HITOUCH_NO_PLU_TXT );
// if ( ( fp = fopen ( file_name, "a" ) ) != NULL)
// {
// memset ( buf, 0, sizeof(buf) );
// snprintf ( buf, sizeof(buf), "%.19s\t%s\n", rm59_Hi_Touch_Info.PluInf[idx].date_time, rm59_Hi_Touch_Info.PluInf[idx].plu_cd );
//
// fputs ( buf, fp );
// fclose ( fp );
// }
//
//
// }
//
// #if 0	// ハイタッチ受信は別タスクで対応
// /*
//  * 関数名       : rc59_Scale_Hitouch_Event
//  * 機能概要     : ハイタッチ商品イベント
//  * 呼び出し方法 : rc59_Scale_Hitouch_Event ()
//  * パラメータ   : なし
//  * 戻り値       : なし
//  */
// extern	void	rc59_Scale_Hitouch_Event (RX_INPUT_BUF *input)
// {
// int	i;
// short	ret;
// short	no_plu_flg;
// short	no_plu_txt_flg;
// char	plu_cd[21];			// 商品コード
// char	log[128];
//
// if ( (input->DevInf.dev_id != TPRDIDHITOUCH1)
// && (input->DevInf.dev_id != TPRDIDHITOUCH2)
// && (input->DevInf.dev_id != TPRDIDHITOUCH3)
// && (input->DevInf.dev_id != TPRDIDHITOUCH4)
// && (input->DevInf.dev_id != TPRDIDHITOUCH5)
// && (input->DevInf.dev_id != TPRDIDHITOUCH6) )
// {
// return;
// }
//
// if ( rc59_ScaleRM_Window_Disp ( ) )	// 画面表示中の為イベントを抑止
//     {
// return;
// }
//
//
// memset (log, 0, sizeof(log));
// snprintf (log, sizeof(log), "Hi-Touch >>>>> : rc59_Scale_Hitouch_Event() : INP STS[%d] INP DATA[%s]"
// , input->DevInf.stat
// , &input->DevInf.data[1]
// );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// if ( C_BUF->db_trm.hi_touch_mac_no != C_BUF->db_regctrl.mac_no )
// {
// memset (log, 0, sizeof(log));
// snprintf (log, sizeof(log), "Hi-Touch : rc59_Scale_Hitouch_Event() not mac_no[%ld][%ld]", C_BUF->db_trm.hi_touch_mac_no, C_BUF->db_regctrl.mac_no);
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
// return;
// }
//
// no_plu_flg = 1;
// no_plu_txt_flg = 0;
//
// switch( input->DevInf.stat )
// {
// case TPRDEVRESULTOK:
// // 商品コードの取出し
// memset ( plu_cd, 0, sizeof(plu_cd) );
// strncpy ( plu_cd, &input->DevInf.data[11], ASC_EAN_13 );
//
// // 受信情報保存
// for ( i = 0; i < HI_TOUCH_MAX; i++ )
// {
// if ( rm59_Hi_Touch_Info.PluInf[i].plu_exist_flg == 0 )
// {
// ret = rcRead_plu_FL_NameGet ( plu_cd, rm59_Hi_Touch_Info.PluInf[i].pos_name, sizeof(rm59_Hi_Touch_Info.PluInf[i].pos_name) );	// 商品名
// if (ret == OK )
// {
// strncpy ( rm59_Hi_Touch_Info.PluInf[i].plu_cd, plu_cd, ASC_EAN_13 );							// 商品コード
// rm59_Hi_Touch_Info.PluInf[i].no_plu_mst = 0;
// no_plu_flg = 0;
// }
// else
// {
// strncpy ( rm59_Hi_Touch_Info.PluInf[i].plu_cd, plu_cd, ASC_EAN_13 );							// 商品コード
// strncpy ( rm59_Hi_Touch_Info.PluInf[i].pos_name, plu_cd, ASC_EAN_13 );						// 商品名(仮)
// rm59_Hi_Touch_Info.PluInf[i].no_plu_mst = 1;
// no_plu_txt_flg = 1;
// }
// rm59_Hi_Touch_Info.PluInf[i].plu_exist_flg = 1;
//
// datetime_change(NULL, rm59_Hi_Touch_Info.PluInf[i].date_time, 1, FT_YYYYMMDD_HYPHEN_SPACE_HHMMSS_COLON, 1);			// 受信日時(YYYY-MM-DD HH:MM:SS)
// // 現在日時から受信日時の差を算出すれば「経過日時」が求められる
//
// memset (log, 0, sizeof(log));
// snprintf (log, sizeof(log), "%s : PluInf[%d] PLU_CD[%s] RCV DATE[%s]", __FUNCTION__, i, rm59_Hi_Touch_Info.PluInf[i].plu_cd, rm59_Hi_Touch_Info.PluInf[i].date_time );
// TprLibLogWrite (GetTid(), TPRLOG_NORMAL, 1, log);
//
// // 受信音
// if (no_plu_flg == 0)
// {
// if_bz ( );
// }
// else
// {
// if_bzerr ( BUZZER_PIPIPI );
// }
//
// if ( no_plu_txt_flg )
// {
// rc59_Scale_Hitouch_NoPlu_MakeTxt ( i );
// rc59_Scale_Hitouch_ErrListt_Button ( );
// }
// break;
// }
// }
//
// if (no_plu_flg == 1)
// {
// if_bzerr ( BUZZER_PIPIPI );
// }
//
// if ( rm59_hitouch_disp_typ == 1 )
// {
// rc59_Scale_Hitouch_Plu_Button_Disp ( );	// 商品ボタンの更新
// }
//
// rc59_Scale_Hitouch_Read ( );		// ハイタッチリードが停止しているので、ハイタッチリードを再起動
// break;
//
// default:	// エラー
// memset (log, 0, sizeof(log));
// snprintf (log, sizeof(log), "%s : Read Error stat[%d]", __FUNCTION__, input->DevInf.stat );
// TprLibLogWrite (GetTid(), TPRLOG_ERROR, -1, log);
//
// if_bzerr ( BUZZER_PI_PO );
//
// break;
// }
// }
// #endif
}