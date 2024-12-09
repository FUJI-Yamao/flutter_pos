/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import 'rc_ext.dart';
import 'rcsyschk.dart';

/// 関連tprxソース: rc_netreserv.h
class NetReservDefine {
  static int MAIN_TITLE_X_SIZ	= 578;
  static int MAIN_TITLE_X_SIZ_FIND = 578;
  static int MAIN_TITLE_Y_SIZ	= 40;
  static int MAIN_TEXT_SIZ = 99;

  static int NETRESERV_NO	= 1;
  static int NETRESERV_CUSTNO	= 2;
  static int NETRESERV_ADDRESS = 3;
  static int NETRESERV_TEL = 4;
  static int NETRESERV_CUSTNAME	= 5;
  static int NETRESERV_FERRY = 6;
  static int NETRESERV_ARRIVAL = 7;
  static int NETRESERV_ADVANCE = 8;
  static int NETRESERV_MEMO1 = 9;
  static int NETRESERV_MEMO2 = 10;
  static int NETRESERV_RECEPT = 11;
  static int NETRESERV_TTL = 12;
  static int NETRESERV_QTY = 13;

  static int NETRESERV_NON = 0;
  static int NETRESERV_CALL = 2;
  static int NETRESERV_IN = 5;
  static int NETRESERV_ITMLST = 7;

  static int NETRESERV_LINE1 = 44;
  static int NETRESERV_LINE2 = NETRESERV_LINE1+40;
  static int NETRESERV_LINE3 = NETRESERV_LINE2+40;
  static int NETRESERV_LINE4 = NETRESERV_LINE3+40;
  static int NETRESERV_LINE5 = NETRESERV_LINE4+20;
  static int NETRESERV_LINE6 = NETRESERV_LINE5+40;
  static int NETRESERV_LINE7 = NETRESERV_LINE6+40;
  static int NETRESERV_LINE8 = NETRESERV_LINE7+40;
  static int NETRESERV_LINE9 = NETRESERV_LINE8+40;
  static int NETRESERV_LINE10 = NETRESERV_LINE9+40;

  static int NETRESERV_RIGHT = 0;
  static int NETRESERV_LEFT = 1;
  static int NETRESERV_ENT_HALF = 20;
  static int NETRESERV_ENT_HALFW = 21;
  static int NETRESERV_ENT_ALL = 22;
  static double NETRESERV_R_BTN = MAIN_TITLE_X_SIZ / 2 + 1;
  static double NETRESERV_R_ENT = MAIN_TITLE_X_SIZ / 2 + 1 + 94 + 1;
  static int NETRESERV_L_BTN = 1;
  static int NETRESERV_L_ENT = 1 + 94 + 1;
  static int NETRESERV_BTN_TYP = 0;
  static int NETRESERV_ENT_TYP = 1;

  static int NETRESERV_BTN = 36;
  static int NETRESERV_BTN2 = 37;

  static int NETRESERV_PRINTEND = 99;
}

/// 関連tprxソース:C:rc_netreserv.h
class NetReserv {
  int mode = 0;
  int bk_mode = 0;
  int act_flg = 0;
  int end_flg = 0;
  int msg_dsp_flg = 0;
  int inp_cnt = 0;
  int inp_filed = 0;
  int inp_max = 0;
  String inp_buf = '';
  String bkinp_buf = '';
  String serch_buf = '';
  int serch_cnt = 0;
  String number = '';
  String cust_no = '';
  String cust_name = '';
  String cust_telno = '';
  String cust_address = '';
  String recept_date = '';
  String ferry_date = '';
  String arrival_date = '';
  String qty = '';
  String ttl = '';
  String advance_money = '';
  String memo1 = '';
  String memo2 = '';
  // c_reserve_enq_tbl net_enq_tbl[202];
  int	rec_cnt = 0;
  String plu_name = '';
  int page_no = 0;
  int page_max = 0;
  int sel_flg = 0;
  int sel_cash_fnc = 0;
  int cncl_flg = 0;
  int conf_dsp_flg = 0;
  int plu_err_flg = 0;
// GtkWidget *window;
// GtkWidget *win_fix;
// GtkWidget *win_fix2;
// GtkWidget *title;
// GtkWidget *inp;
// GtkWidget *itm;
// GtkWidget *serch;
// GtkWidget *exec;
// GtkWidget *cncl;
// GtkWidget *ky_reservno;
// GtkWidget *ky_reservno_ent;
// GtkWidget *ky_cust_no;
// GtkWidget *ky_cust_no_ent;
// GtkWidget *ky_address;
// GtkWidget *ky_address_ent;
// GtkWidget *ky_tel;
// GtkWidget *ky_tel_ent;
// GtkWidget *ky_recept_day;
// GtkWidget *ky_recept_day_ent;
// GtkWidget *ky_cust_name;
// GtkWidget *ky_cust_name_ent;
// GtkWidget *ky_ferry_date;
// GtkWidget *ky_ferry_date_ent;
// GtkWidget *ky_arrival_date;
// GtkWidget *ky_arrival_date_ent;
// GtkWidget *ky_qty;
// GtkWidget *ky_qty_ent;
// GtkWidget *ky_ttl;
// GtkWidget *ky_ttl_ent;
// GtkWidget *ky_advance_money;
// GtkWidget *ky_advance_money_ent;
// GtkWidget *ky_advance_money_sel;
// GtkWidget *ky_memo1;
// GtkWidget *ky_memo1_ent;
// GtkWidget *ky_memo2;
// GtkWidget *ky_memo2_ent;
// GtkWidget *in_window;
// GtkWidget *in_win_fix;
// GtkWidget *in_win_fix2;
// GtkWidget *in_title;
// GtkWidget *in_inp;
// GtkWidget *in_upd;
// GtkWidget *in_cncl;
// GtkWidget *in_end;
// GtkWidget *in;
// GtkWidget *in_lbl;
// GtkWidget *in_lbl_ttl;
// GtkWidget *in_lbl_after;
// GtkWidget *in_lbl_chgout;
// GtkWidget *in_time;
// GtkWidget *in_cashbtn;
// GtkWidget *in_calendar;
// GtkWidget *itm_window;
// GtkWidget *itm_win_fix;
// GtkWidget *itm_title;
// GtkWidget *itm_end;
// GtkWidget *itm_next;
// GtkWidget *itm_befor;
// GtkWidget *itm_no[21];
// GtkWidget *itm_name[21];
// GtkWidget *itm_qty[21];
// GtkWidget *itm_money[21];
}

class RcNetReserv {
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C:rc_netreserv.c - rcNetReserv_ChkReservTbl()
  static int rcNetReservChkReservTbl(){
    return 0;
  }
  /// 関連tprxソース:C:rc_netreserv.c - rcNetReserv_PopUp()
  static Future<void> rcNetReservPopUp(int errNo) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,"rcNetReserv_PopUp");
    await rcNetReservDialogErr(errNo, 1, null);
  }

  /// 関連tprxソース:C:rc_netreserv.c - rcNetReserv_DialogErr()
  static Future<int> rcNetReservDialogErr(int erCode, int userCode, String? msg) async {
    tprDlgParam_t param = tprDlgParam_t();
    NetReserv netReserv = NetReserv();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "NetReserv Err($erCode) [${netReserv.msg_dsp_flg}][${netReserv.conf_dsp_flg}]");

    if ((netReserv.msg_dsp_flg == 1) || (netReserv.conf_dsp_flg == 1)) {
      rcNetReservDialogClear();
    }
    // TODO:10121 QUICPay、iD 202404実装対象外　エラーメッセージの設定をする
    if(userCode == 1) {
      MsgDialog.show(
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message: 'コード $erCode',),
      );

    } else {
      MsgDialog.show(
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.info,
          message: 'コード $erCode',),
      );

    }
    netReserv.msg_dsp_flg = 1;
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcNetReserv_DialogErr end");
    return 0;
  }

  /// 関連tprxソース: rc_netreserv.c - rcNetReserv_DialogClear()
  static Future<int> rcNetReservDialogClear() async {
    NetReserv netReserv = NetReserv();
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcNetReserv DialogClear");
    const callFunction = "rcNetReservDialogClear"; //＿FUNCTION＿
    netReserv.msg_dsp_flg = 0;
    netReserv.conf_dsp_flg = 0;
    await RcExt.rcClearErrStat(callFunction);

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcNetReserv DialogClear End");
    return 0;
  }
}
