/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../inc/apl/compflag.dart';
import '../inc/sys/tpr_dlg.dart';

///  関連tprxソース: TprLibDig.c
class TprLibDlg {
//  static  GtkWidget       *win_err = NULL;
  static Object? winErr;
//  static  GtkWidget       *Back_Win = NULL;
  static Object? backWin;
//  static  GtkWidget       *dual_win_err = NULL;
  static Object? dualWinErr;
//  static  GtkWidget       *dual_Back_Win = NULL;
  static Object? dualBackWin;
  static int aplDlgDisp = 0;	// 登録画面用アプリダイアログ表示  0:非表示  1:表示
  static	BackUpDlg	nowBackUpDlg = BackUpDlg();		// 通常ダイアログバックアップ用ポインタ
  static	int		rrCode = 0;

  ///  関連tprxソース: TprLibDig.c - TprLibDlgClear2
  // TODO:00008 宮家 中身の実装予定　
  static int tprLibDlgClear2(String callFunc) {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return 0;
  }

  /// 関数:  TprLibDlgGetDlgParam( BackUpDlg *backUpDlg )
  ///
  /// 機能:  現在表示中のダイアログ内容を取得する
  ///
  /// 戻値:  0: 取得出来ない(表示中では無い)  1:取得OK
  ///
  ///  関連tprxソース: TprLibDig.c - TprLibDlg_Get_DlgParam
  static int TprLibDlgGetDlgParam(BackUpDlg backUpDlg) {
    if (nowBackUpDlg == null)
    {
      return (0);
    }
    backUpDlg.ttl_cnt	= nowBackUpDlg.ttl_cnt;
    backUpDlg.msg_no	= nowBackUpDlg.msg_no;
    backUpDlg.read_tbl	= nowBackUpDlg.read_tbl;
    backUpDlg.er_code	= nowBackUpDlg.er_code;
    backUpDlg.dialog_ptn	= nowBackUpDlg.dialog_ptn;
    backUpDlg.func1	= nowBackUpDlg.func1;
    backUpDlg.func2	= nowBackUpDlg.func2;
    backUpDlg.func3	= nowBackUpDlg.func3;
    backUpDlg.func4	= nowBackUpDlg.func4;
    backUpDlg.func5	= nowBackUpDlg.func5;
    backUpDlg.user_code	= nowBackUpDlg.user_code;
    backUpDlg.dual_dsp	= nowBackUpDlg.dual_dsp;
    backUpDlg.dual_dev	= nowBackUpDlg.dual_dev;
    backUpDlg.plan_cd = nowBackUpDlg.plan_cd;
    backUpDlg.msg1 = nowBackUpDlg.msg1;
    backUpDlg.msg2 = nowBackUpDlg.msg2;
    backUpDlg.msg3 = nowBackUpDlg.msg3;
    backUpDlg.msg4 = nowBackUpDlg.msg4;
    backUpDlg.msg5 = nowBackUpDlg.msg5;
    backUpDlg.title = nowBackUpDlg.title;
    backUpDlg.user_code_2 = nowBackUpDlg.user_code_2;
    backUpDlg.user_code_3 = nowBackUpDlg.user_code_3;
    backUpDlg.user_code_4 = nowBackUpDlg.user_code_4;
    backUpDlg.msg_buf = nowBackUpDlg.msg_buf;
    return (1);
  }

  ///  関連tprxソース: TprLibDig.c - TprLibDlgNoCheck
  static int tprLibDlgNoCheck() {
    if(tprLibDlgCheck() != 0) {
      return(rrCode);
    }
    return(0);
  }

  ///  関連tprxソース: TprLibDig.c - TprLibDlgCheck()
  static int tprLibDlgCheck() {
    return tprLibDlgCheck2(1);
  }

  ///  関連tprxソース: TprLibDig.c - TprLibDlgCheck()　-> tprLibDlgCheck2(1)
  static int tprLibDlgCheck2(int aplDlgChk) {
    /* Widget Check */
    if (winErr != null) {
      return 1;
    }
    if (backWin != null) {
      return 1;
    }
    if (CompileFlag.FB2GTK) {
      if (dualWinErr != null) {
        return 1;
      }
      if (dualBackWin != null) {
        return 1;
      }
    }
    if ((aplDlgChk != 0) &&
        (aplDlgDisp == 1 )) {
      return 1;
    }
    return 0;
  }

  // TODO:00016　佐藤　定義のみ追加
  ///  関連tprxソース: TprLibDig.c - TprLibDlg(a) -> TprLibDlg2(__FUNCTION__, a)
  static int tprLibDlg2(String callFunc, tprDlgParam_t param) {
    return 0;
  }

  // TODO:00002 佐野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: TprLibDig.c - TprLibDlgSnd
  static void TprLibDlgSnd(tprDlgParam_t param) {}
}