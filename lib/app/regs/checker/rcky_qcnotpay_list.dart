/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/tprlib/TprLibDlg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/lib/qcConnect.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/page/semi_self/basepage/p_unpaidlist_page.dart';
import '../../ui/page/semi_self/controller/c_unpaid_controller.dart';



/// 未清算一覧
/// 関連tprxソース: rcky_qcnotpay_list.c
class RckyQcNotPayList {

  static QcNotPayListParam qcNotPayListParam = QcNotPayListParam();
  static const int MAX_QCNOTPAY_LIST = 5;	// 履歴最大表示数
  static const int MAX_QCNOTPAY_EJ_LINE = 32;	// EJ最大表示行数
  static const String QCNOTPAY_ARROW_NAME = "qc_notpay_new_old_arrow.png";	// new-oldが表示された画像
  static const String QCNOTPAY_ARROW_NAME2 = "qc_notpay_new_old_arrow2.png";	// new-oldが表示された画像

  static const int QCNOTPAY_TOUCH_COLOR_CHG_TIME = 120000000;	// nsec 移動操作ボタンを押下した時の選択色の戻り時間
  static const int QCNOTPAY_KEEP_TOUCH_ACT_TIMER = 100;		// msec 移動操作ボタンを押下維持した時の自動スクロール時間
  static const int QCNOTPAY_KEEP_TOUCH_INTERVAL = 10;		// msec QCNOTPAY_KEEP_TOUCH_START_CNTをチェックする時のインターバル
  static const int QCNOTPAY_KEEP_TOUCH_START_CNT = 30;		// count 自動スクロール開始のためのカウント値

  /// 関連tprxソース: rcky_qcnotpay_list.c - rcKy_QcNotPayList
  static void rcKyQcNotPayList() async {
    // TODO: 未清算一覧の処理.画面によって機能が変わったり特定の画面だけ動かす場合は画面分岐を入れること
    debugPrint("call rcKyQcNotPayList");
    Get.to(() => UnpaidListPage());
  }

  /// 関連tprxソース: rcky_qcnotpay_list.c - rcBtnClickedQcNotPayList()の中の ( type == FUNC_QCNOTPAY_LIST_EXEC )を抽出
  static Future<void> rcBtnClickedQcNotPayListExec() async {
    // 呼戻ボタン処理
    TprLog().logAdd(Tpraid.TPRAID_QCSELECT_SVR, LogLevelDefine.normal, "rcBtnClickedQcNotPayList: Exec Key");

    tprDlgParam_t param = tprDlgParam_t();
    param.erCode = DlgConfirmMsgKind.MSG_WAIT.dlgId;
    param.dialogPtn = DlgPattern.TPRDLG_PT2.dlgPtnId;
    rcWaitRemoveQcNotPayList();

    String callFunction = "rcBtnClickedQcNotPayListExec";
    await RcExt.rxChkModeSet(callFunction);
    param.erCode = DlgConfirmMsgKind.MSG_QCNOTPAY_WAIT.dlgId;	// [お待ち下さい] -> ダイアログ変更.
    TprLibDlg.tprLibDlg2(callFunction, param);  // TODO:定義のみで動かない。別のものを使用する。
    UnPaidListController cls = Get.find();
    qcNotPayListParam.WaitTimer = Fb2Gtk.gtkTimeoutAdd(100, cls.setUnpaidPluData, 0);
  }

// タイマーの解放
  static void rcWaitRemoveQcNotPayList() {
    if (qcNotPayListParam.WaitTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(qcNotPayListParam.WaitTimer);
      qcNotPayListParam.WaitTimer = -1;
    }
  }

  static void rcExecIntrpDataQcNotPayList() {

  }

}

class QcNotPayListParam {
  int		MaxPage = 0;			// 最大頁数
  int		NowPage = 0;			// 現在の頁数
  int		SelectNum = 0;			// 選択履歴の番号
  int		MaxEjLine = 0;			// 最大EJ表示行数
  int		NowEjLine = 0;			// 現在のEJ表示行数
  int		KeepTouchCount = 0;			//
  int		AgainLoadFlag = 0;			// 強制呼出機能  0:通常呼出  1:強制で呼出すことを選択している状態
  int		AgainLoadNum = 0;			// 強制呼出した番号を保持する変数
  int		WaitTimer = 0;			// お待ち下さい表示のためのタイマー
  // GtkWidget	*PrevButton;			// 前ボタン
  // GtkWidget	*NextButton;			// 次ボタン
  // GtkWidget	*ExecButton;			// 呼び戻しボタン
  // GtkWidget	*EJText;			// EJ表示欄
  // GtkWidget	*EJMoveFrame;			// EJ移動操作表示の枠
  // GtkWidget	*EJMoveButton[QCNOTPAY_LIST_EJ_MOVE_BTN_MAX];		// EJ移動操作ボタン
  // GtkWidget	*EJMoveFixed[QCNOTPAY_LIST_EJ_MOVE_BTN_MAX];		// EJ移動操作ラベル表示エリア
  // GtkWidget	*EJMoveLabel[QCNOTPAY_LIST_EJ_MOVE_BTN_MAX];		// EJ移動操作ラベル
  // GtkWidget	*Button[MAX_QCNOTPAY_LIST];	// 各履歴選択ボタン
  // GtkWidget	*Frame[MAX_QCNOTPAY_LIST];	// 各履歴表示の枠
  // GtkWidget	*NumFixed[MAX_QCNOTPAY_LIST];	// 各履歴表示の番号エリア
  // GtkWidget	*NumLabel[MAX_QCNOTPAY_LIST];	// 各履歴表示の番号ラベル
  // GtkWidget	*DataFixed[MAX_QCNOTPAY_LIST];	// 各履歴表示の取引情報エリア
  // GtkWidget	*DataLabel[MAX_QCNOTPAY_LIST];	// 各履歴表示の取引情報ラベル
  // GtkWidget	*SendFixed[MAX_QCNOTPAY_LIST];	// 各履歴表示の送信先エリア
  // GtkWidget	*SendLabel[MAX_QCNOTPAY_LIST];	// 各履歴表示の送信先ラベル
  List<QcslctActType> QcActInfo = List.generate(RckyQcNotPayList.MAX_QCNOTPAY_LIST, (index) => QcslctActType.QCSLCT_ACT_NORMAL);	// 非表示項目: このデータの精算機動作情報
  List<int> TtlOpeMode = List.generate(RckyQcNotPayList.MAX_QCNOTPAY_LIST, (index) => 0);	// 各履歴のトータルログのオペモード
  List<int> OpeMode = List.generate(RckyQcNotPayList.MAX_QCNOTPAY_LIST, (index) => 0);	// 各履歴のINIオペモード
  List<int> MacNo = List.generate(RckyQcNotPayList.MAX_QCNOTPAY_LIST, (index) => 0);	// 各履歴の送信先マシン番号
  List<int> RecNo = List.generate(RckyQcNotPayList.MAX_QCNOTPAY_LIST, (index) => 0);	// 各履歴のレシート番号
  List<int> ConMacNo = List.generate(RckyQcNotPayList.MAX_QCNOTPAY_LIST, (index) => 0);	// 非表示項目: このデータの呼び出しレジ番号 (基本は送信先レジ番号と同じだが中断したりすると異なる場合あり)
  String SaleDate = "";			// 営業日
  String SaleTime = "";			// 作成時刻
  List<String> FileName = List.generate(RckyQcNotPayList.MAX_QCNOTPAY_LIST, (index) => "");// 各履歴表示の元になったファイル名称
}

