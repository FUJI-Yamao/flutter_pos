/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_acracb.dart';
import 'package:flutter_pos/app/regs/checker/rc_acracbdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_assist_mnt.dart';
import 'package:flutter_pos/app/regs/checker/rc_atct.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_flrd.dart';
import 'package:flutter_pos/app/regs/checker/rc_flrda.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifprint.dart';
import 'package:flutter_pos/app/regs/checker/rc_inout.dart';
import 'package:flutter_pos/app/regs/checker/rc_obr.dart';
import 'package:flutter_pos/app/regs/checker/rc_recno.dart';
import 'package:flutter_pos/app/regs/checker/rc_rfmdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rc_setdate.dart';
import 'package:flutter_pos/app/regs/checker/rc_sgdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_stl.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rckycpick.dart';
import 'package:flutter_pos/app/regs/checker/rcsg_com.dart';
import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/regs/checker/rxregstr.dart';
import 'package:postgres/postgres.dart';
import 'package:sprintf/sprintf.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../fb/fb_lib.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/apl/rxtbl_buff_keyopt.dart';
import '../../inc/db/c_ttllog.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../lib/apllib/apllib_staffpw.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_acx/acx_com.dart';
import '../../tprlib/TprLibDlg.dart';
import '../common/rx_log_calc.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/L_rc_sgdsp.dart';
import '../inc/rc_if.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

class Rcinoutdsp {
  static int unreadDspFlg = 0; // 未読現金画面表示フラグ
  static InOutInfo inOut = InOutInfo();
  static InOutCloseData inOutClose = InOutCloseData();
  static int autoNoStaff = 0;
  static RxTaskStatBuf tsBuf = RxTaskStatBuf();
  static KoptinoutBuff kortInOut = KoptinoutBuff();
  static int amtPrc = 0;
  static StaffData staffData = StaffData();
  static Function? chgPickFunc;
  static Function? chgPickQFunc;

  static int sumCash = 0;
  static int sumCha1 = 0;
  static int sumCha2 = 0;
  static int sumCha3 = 0;
  static int sumCha4 = 0;
  static int sumCha5 = 0;
  static int sumCha6 = 0;
  static int sumCha7 = 0;
  static int sumCha8 = 0;
  static int sumCha9 = 0;
  static int sumCha10 = 0;
  static int sumCha11 = 0;
  static int sumCha12 = 0;
  static int sumCha13 = 0;
  static int sumCha14 = 0;
  static int sumCha15 = 0;
  static int sumCha16 = 0;
  static int sumCha17 = 0;
  static int sumCha18 = 0;
  static int sumCha19 = 0;
  static int sumCha20 = 0;
  static int sumCha21 = 0;
  static int sumCha22 = 0;
  static int sumCha23 = 0;
  static int sumCha24 = 0;
  static int sumCha25 = 0;
  static int sumCha26 = 0;
  static int sumCha27 = 0;
  static int sumCha28 = 0;
  static int sumCha29 = 0;
  static int sumCha30 = 0;
  static int sumChk1 = 0;
  static int sumChk2 = 0;
  static int sumChk3 = 0;
  static int sumChk4 = 0;
  static int sumChk5 = 0;

  static const int OK = 0;
  static const int NG = 1;

  static const ALL_CASH = "all_cash";
  static const ALL_CHA1 = "all_cha1";
  static const ALL_CHA2 = "all_cha2";
  static const ALL_CHA3 = "all_cha3";
  static const ALL_CHA4 = "all_cha4";
  static const ALL_CHA5 = "all_cha5";
  static const ALL_CHA6 = "all_cha6";
  static const ALL_CHA7 = "all_cha7";
  static const ALL_CHA8 = "all_cha8";
  static const ALL_CHA9 = "all_cha9";
  static const ALL_CHA10 = "all_cha10";
  static const ALL_CHA11 = "all_cha11";
  static const ALL_CHA12 = "all_cha12";
  static const ALL_CHA13 = "all_cha13";
  static const ALL_CHA14 = "all_cha14";
  static const ALL_CHA15 = "all_cha15";
  static const ALL_CHA16 = "all_cha16";
  static const ALL_CHA17 = "all_cha17";
  static const ALL_CHA18 = "all_cha18";
  static const ALL_CHA19 = "all_cha19";
  static const ALL_CHA20 = "all_cha20";
  static const ALL_CHA21 = "all_cha21";
  static const ALL_CHA22 = "all_cha22";
  static const ALL_CHA23 = "all_cha23";
  static const ALL_CHA24 = "all_cha24";
  static const ALL_CHA25 = "all_cha25";
  static const ALL_CHA26 = "all_cha26";
  static const ALL_CHA27 = "all_cha27";
  static const ALL_CHA28 = "all_cha28";
  static const ALL_CHA29 = "all_cha29";
  static const ALL_CHA30 = "all_cha30";
  static const ALL_CHK1 = "all_chk1";
  static const ALL_CHK2 = "all_chk2";
  static const ALL_CHK3 = "all_chk3";
  static const ALL_CHK4 = "all_chk4";
  static const ALL_CHK5 = "all_chk5";
  static const LOAN_CASH = "loan_cash";
  static const LOAN_CHA = "loan_cha";
  static const LOAN_CHK = "loan_chk";
  static const CIN_CASH = "cin_cash";
  static const CIN_CHA = "cin_cha";
  static const CIN_CHK = "cin_chk";
  static const OUT_CASH = "out_cash";
  static const OUT_CHA = "out_cha";
  static const OUT_CHK = "out_chk";
  static const PICK_CASH = "pick_cash";
  static const PICK_CHA = "pick_cha";
  static const PICK_CHK = "pick_chk";


  static const SUM_CASH = "sum_cash";
  static const SUM_CHA1 = "sum_cha1";
  static const SUM_CHA2 = "sum_cha2";
  static const SUM_CHA3 = "sum_cha3";
  static const SUM_CHA4 = "sum_cha4";
  static const SUM_CHA5 = "sum_cha5";
  static const SUM_CHA6 = "sum_cha6";
  static const SUM_CHA7 = "sum_cha7";
  static const SUM_CHA8 = "sum_cha8";
  static const SUM_CHA9 = "sum_cha9";
  static const SUM_CHA10 = "sum_cha10";
  static const SUM_CHA11 = "sum_cha11";
  static const SUM_CHA12 = "sum_cha12";
  static const SUM_CHA13 = "sum_cha13";
  static const SUM_CHA14 = "sum_cha14";
  static const SUM_CHA15 = "sum_cha15";
  static const SUM_CHA16 = "sum_cha16";
  static const SUM_CHA17 = "sum_cha17";
  static const SUM_CHA18 = "sum_cha18";
  static const SUM_CHA19 = "sum_cha19";
  static const SUM_CHA20 = "sum_cha20";
  static const SUM_CHA21 = "sum_cha21";
  static const SUM_CHA22 = "sum_cha22";
  static const SUM_CHA23 = "sum_cha23";
  static const SUM_CHA24 = "sum_cha24";
  static const SUM_CHA25 = "sum_cha25";
  static const SUM_CHA26 = "sum_cha26";
  static const SUM_CHA27 = "sum_cha27";
  static const SUM_CHA28 = "sum_cha28";
  static const SUM_CHA29 = "sum_cha29";
  static const SUM_CHA30 = "sum_cha30";
  static const SUM_CHK1 = "sum_chk1";
  static const SUM_CHK2 = "sum_chk2";
  static const SUM_CHK3 = "sum_chk3";
  static const SUM_CHK4 = "sum_chk4";
  static const SUM_CHK5 = "sum_chk5";

  /// 関連tprxソース:C L_rcinoutdsp.h
  /// #define Image Datas
  static const INOUT_ZEROP = "        0枚";
  static const INOUT28_ZEROP = "       0枚";
  static const INOUT_ZEROP2	= "    0枚";
  static const INOUT_PIECE = "枚";
  static const INOUT_10000 = "万券";
  static const INOUT_5000 = "５千\n券";
  static const INOUT_CHIKET = "券";
  static const INOUT_2000 = "２千\n券";
  static const INOUT_1000 = "千券";
  static const INOUT_500 = "500";
  static const INOUT_100 = "100";
  static const INOUT_50 = "50";
  static const INOUT_10 = "10";
  static const INOUT_5 = "5";
  static const INOUT_1 = "1";
  static const PAGE_MAX = "/3";
  static const PAGEUP_LABEL = "前頁";
  static const PAGEDWN_LABEL = "次頁";
  static const INT_LABEL = "入力";
  static const CLOSE_LABEL = "閉じる";
  static const REFRESH_LABEL = "更新";
  static const ACX_REFRESH_LABEL = "釣機枚数更新";
  static const EXEC_LABEL = "実行";
  static const EXIT_LABEL = "終了";
  static const NEXT_LABEL = "次へ";
  static const STOP_LABEL = "中止";
  static const TTLPRS_MSG = "合計金額";
  static const DRAWPRC_MSG = "ドロア合計";
  static const ACRPRC_MSG = "釣機合計";
  static const AMTPRC_MSG = "理論在高合計";
  static const DIFFPRC_MSG = "違算金額";
  static const ACR_LABEL = "釣機";
  static const DRAW_LABEL = "ドロア";
  static const REFLECT_LABEL = "反映する";
  static const UNREFLECT_LABEL = "反映しない";
  static const DO_LABEL	= "する";
  static const NOT_DO_LABEL	= "しない";
  static const REFLECT_DATA = "売上回収に引き継ぐデータを\n選択して下さい";
  static const REFLECT_SUBDATA1 = "売上回収に引き継ぐデータを";
  static const REFLECT_SUBDATA2 = "選択して下さい";
  static const CLOSE_PICK_LABEL = "従業員精算(実在高作成)";
  static const BILL_LABEL = "紙幣全て";
  static const MAN_LABEL = "万券";
  static const COIN_LABEL = "硬貨全て";
  static const ALL_LABEL = "全回収";
  static const CNCL_LABEL = "中断";
  static const BTN_TXT_ADDDEC = "＋  \n  －";
  static const BTN_TXT_ADDDEC_SUB = "＋    －";
  static const BTN_TXT_CHGCIN = "釣機\n入金";
  static const BTN_TXT_CHGCIN2 = "釣機入金";
  static const LABEL_TXT_CHGCIN2 = "↓釣機へ入金して釣準備";
  static const MENTE_CIN_LABEL = "釣機合計\nのみ加算";
  static const BTN_TXT_CNCLCIN = "入金\n取消";
  static const BTN_TXT_CHGSTOCK = "釣機\n在高";
  static const BTN_TXT_CHGSTOCK2 = "釣機在高取得";
  static const LABEL_TXT_CHGSTOCK2 = "↓釣機の残置金で釣準備";
  static const DIALOG_CHGACT = "釣機動作中";
  static const CHGSTOCK_ENDLABEL = "  釣機在高取得  完了";
  static const CHGCIN_STARTLABEL = "  釣機状態：入金開始";
  static const CHGCIN_ACTLABEL = "  釣機状態：入金動作中";
  static const CHGCIN_WAITLABEL = "  釣機状態：入金待ち";
  static const CHGCIN_ENDLABEL = "  釣機状態：入金停止";
  static const CHGCIN_RESETLABEL = "  釣機状態：リセット中";
  static const NEXT_LABEL2 = "次ｽﾃｯﾌﾟへ";
  static const NEXT_LABEL_ACTDRW = "実在高\n作成のみ";		/* NEXT_LABEL2を自動精算でない場合に変更 */
  static const DRW_OPEN_BTN = "ﾄﾞﾛｱｰｵｰﾌﾟﾝ";
  static const INOUT_ING = "%s処理中";
  static const CHGSTAT_START = "入金開始";
  static const CHGSTAT_ACT = "入金動作中";
  static const CHGSTAT_WAIT	= "入金待ち";
  static const CHGSTAT_END = "入金停止";
  static const CHGSTAT_RESET = "リセット中";
  static const CHGSTAT_FORCE_END = "釣機 非連動";

  static const OFFSET_IN = "＋";
  static const OFFSET_OUT	= "－";
  static const OFFSET_IN_S = "入";
  static const OFFSET_OUT_S	= "出";
  static const OFFSET_NOWACCOUNT = "現在理論在高";
  static const OFFSET_ACCOUNT_ACT	= "独立現外処理中";

  static const ADD_TITLE_AUTO  = "[自動]";
  static const REXEC_LABEL = "継続\n出金";

  static const INOUT_DIV_LABEL = "区分選択";
  static const IN_DIV_TITLE	= "入金区分";
  static const OUT_DIV_TITLE = "出金区分";

  static const CLOSE_DLG_YES_BTN = "精算中止";
  static const CLOSE_DLG_NO_BTN	= "戻る";
  static const DRAWCHK_DLG_YES_BTN = "実行";
  static const DRAWCHK_DLG_NO_BTN	= "戻る";

  static const	INOUT_ENT1 = "１";
  static const	INOUT_ENT2 = "２";
  static const	INOUT_ENT3 = "３";
  static const	INOUT_ENT4 = "４";
  static const	INOUT_ENT5 = "５";
  static const	INOUT_ENT6 = "６";
  static const	INOUT_ENT7 = "７";
  static const	INOUT_ENT8 = "８";
  static const	INOUT_ENT9 = "９";
  static const	INOUT_ENT0 = "０";
  static const	INOUT_ENT00	= "00";
  static const	INOUT_CLR	= "ｸﾘｱ-";

  static const INOUT_LOAN_CNT_LABEL1 = "本日";
  static const INOUT_LOAN_CNT_LABEL2 = "累計";
  static const INOUT_COUNT_LABEL1	= "回目";
  static const INOUT_COUNT_LABEL2	= "回";
  static const INOUT_LOAN_DATA_GET = "取得中";
  static const INOUT_LOAN_DATA_NG	= "取得失敗";
  static const INOUT_MENTE_CIN_PRC_LABEL = "入金額";
  static const INOUT_MENTE_CIN_COMMENT = "※この機能はメンテナンス用入金機能です。\n  入金実績は作成されません。";
  static const INOUT_MENTE_CIN_GUIDANCE	= "貨幣を投入し、「実行」ボタンを押してください";
  static const DRAWCHK_STOCK_BTN = "在高内訳表示";
  static const DRAWCHK_STOCK_TITLE = "理論在高内訳";
  static const DRAWCHK_STOCK_EXIT	= "戻る";
  static const INOUT_DIVIDE_NEXT_BTN = "次金種へ";
  static const INOUT_DIVIDE_NAME = "区分名称";
  static const INOUT_DIVIDE_FACE = "券面額";
  static const INOUT_DIVIDE_SHEET	= "枚数";
  static const INOUT_DIVIDE_OTH	= "その他";
  static const INOUT_DIVIDE_TTL	= "合計";
  static const INOUT_ACX_NONCONNECT	= "未接続";
  static const INOUT_DIFF_REASON_OTH = "その他理由";
  static const INOUT_BTN_TYPE_CASH = "TYPE_CASH";
  static const INOUT_BTN_TYPE_CHA	= "TYPE_CHA";
  static const INOUT_BTN_TYPE_CHK	= "TYPE_CHK";

  /// 描画ボタン
  static List<MoneyButtonTbl> inOutBtnInf = [
    ///	{ 区分入力表示エリアとして 1頁目の1,1の位置は使用禁止			0, 1, 1 },
    MoneyButtonTbl(InoutDisp.INOUT_Y10000, InoutPayType.INOUT_TYPE_CASH, 0, 0,
        0, FbColorGroup.Yellow.index, " ", 0, 1, 2),
    MoneyButtonTbl(InoutDisp.INOUT_Y5000, InoutPayType.INOUT_TYPE_CASH, 0, 0, 0,
        FbColorGroup.Yellow.index, " ", 0, 1, 3),
    MoneyButtonTbl(InoutDisp.INOUT_Y2000, InoutPayType.INOUT_TYPE_CASH, 0, 0, 0,
        FbColorGroup.Yellow.index, " ", 0, 1, 4),
    MoneyButtonTbl(InoutDisp.INOUT_Y1000, InoutPayType.INOUT_TYPE_CASH, 0, 0, 0,
        FbColorGroup.Yellow.index, " ", 0, 1, 5),
    MoneyButtonTbl(InoutDisp.INOUT_Y500, InoutPayType.INOUT_TYPE_CASH, 0, 0, 0,
        FbColorGroup.Yellow.index, " ", 0, 2, 2),
    MoneyButtonTbl(InoutDisp.INOUT_Y100, InoutPayType.INOUT_TYPE_CASH, 0, 0, 0,
        FbColorGroup.Yellow.index, " ", 0, 2, 3),
    MoneyButtonTbl(InoutDisp.INOUT_Y50, InoutPayType.INOUT_TYPE_CASH, 0, 0, 0,
        FbColorGroup.Yellow.index, " ", 0, 2, 4),
    MoneyButtonTbl(InoutDisp.INOUT_Y10, InoutPayType.INOUT_TYPE_CASH, 0, 0, 0,
        FbColorGroup.Yellow.index, " ", 0, 2, 5),
    MoneyButtonTbl(InoutDisp.INOUT_Y5, InoutPayType.INOUT_TYPE_CASH, 0, 0, 0,
        FbColorGroup.Yellow.index, " ", 0, 2, 6),
    MoneyButtonTbl(InoutDisp.INOUT_Y1, InoutPayType.INOUT_TYPE_CASH, 0, 0, 0,
        FbColorGroup.Yellow.index, " ", 0, 2, 7),
    MoneyButtonTbl(InoutDisp.INOUT_CHA1, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA1.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 1, 1),
    MoneyButtonTbl(InoutDisp.INOUT_CHA2, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA2.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 1, 2),
    MoneyButtonTbl(InoutDisp.INOUT_CHA3, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA3.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 1, 3),
    MoneyButtonTbl(InoutDisp.INOUT_CHA4, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA4.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 1, 4),
    MoneyButtonTbl(InoutDisp.INOUT_CHA5, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA5.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 1, 5),
    MoneyButtonTbl(InoutDisp.INOUT_CHA6, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA6.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 1, 6),
    MoneyButtonTbl(InoutDisp.INOUT_CHA7, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA7.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 1, 7),
    MoneyButtonTbl(InoutDisp.INOUT_CHA8, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA8.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 1, 8),
    MoneyButtonTbl(InoutDisp.INOUT_CHA9, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA9.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 1, 9),
    MoneyButtonTbl(InoutDisp.INOUT_CHA10, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA10.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 1, 10),
    MoneyButtonTbl(InoutDisp.INOUT_CHA11, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA11.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 2, 1),
    MoneyButtonTbl(InoutDisp.INOUT_CHA12, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA12.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 2, 2),
    MoneyButtonTbl(InoutDisp.INOUT_CHA13, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA13.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 2, 3),
    MoneyButtonTbl(InoutDisp.INOUT_CHA14, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA14.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 2, 4),
    MoneyButtonTbl(InoutDisp.INOUT_CHA15, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA15.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 2, 5),
    MoneyButtonTbl(InoutDisp.INOUT_CHA16, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA16.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 2, 6),
    MoneyButtonTbl(InoutDisp.INOUT_CHA17, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA17.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 2, 7),
    MoneyButtonTbl(InoutDisp.INOUT_CHA18, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA18.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 2, 8),
    MoneyButtonTbl(InoutDisp.INOUT_CHA19, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA19.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 2, 9),
    MoneyButtonTbl(InoutDisp.INOUT_CHA20, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA20.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 2, 10),
    MoneyButtonTbl(InoutDisp.INOUT_CHA21, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA21.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 3, 1),
    MoneyButtonTbl(InoutDisp.INOUT_CHA22, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA22.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 3, 2),
    MoneyButtonTbl(InoutDisp.INOUT_CHA23, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA23.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 3, 3),
    MoneyButtonTbl(InoutDisp.INOUT_CHA24, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA24.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 3, 4),
    MoneyButtonTbl(InoutDisp.INOUT_CHA25, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA25.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 3, 5),
    MoneyButtonTbl(InoutDisp.INOUT_CHA26, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA26.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 3, 6),
    MoneyButtonTbl(InoutDisp.INOUT_CHA27, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA27.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 3, 7),
    MoneyButtonTbl(InoutDisp.INOUT_CHA28, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA28.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 3, 8),
    MoneyButtonTbl(InoutDisp.INOUT_CHA29, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA29.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 3, 9),
    MoneyButtonTbl(InoutDisp.INOUT_CHA30, InoutPayType.INOUT_TYPE_CHA,
        FuncKey.KY_CHA30.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 3, 10),
    MoneyButtonTbl(InoutDisp.INOUT_CHK1, InoutPayType.INOUT_TYPE_CHK,
        FuncKey.KY_CHK1.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 4, 1),
    MoneyButtonTbl(InoutDisp.INOUT_CHK2, InoutPayType.INOUT_TYPE_CHK,
        FuncKey.KY_CHK2.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 4, 2),
    MoneyButtonTbl(InoutDisp.INOUT_CHK3, InoutPayType.INOUT_TYPE_CHK,
        FuncKey.KY_CHK3.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 4, 3),
    MoneyButtonTbl(InoutDisp.INOUT_CHK4, InoutPayType.INOUT_TYPE_CHK,
        FuncKey.KY_CHK4.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 4, 4),
    MoneyButtonTbl(InoutDisp.INOUT_CHK5, InoutPayType.INOUT_TYPE_CHK,
        FuncKey.KY_CHK5.keyId, 0, 0, FbColorGroup.Yellow.index, " ", 1, 4, 5),
  ];

  /// 未読現金入力画面 表示中判定
  /// 関連tprxソース:C rcinoutdsp.c - rc28Lcd_UnReadCashDispShowing_Chk
  /// 引数   : なし
  /// 戻り値 : true :表示中, false :非表示
  static bool rc28LcdUnReadCashDispShowingChk() {
    if (unreadDspFlg != 0) {
      return true;
    } else {
      return false;
    }
  }

  /// 未読現金入力画面表示フラグOFF
  /// 関連tprxソース:C rcinoutdsp.c - rc28Lcd_UnReadCashDispFlgOff()
  /// 引数   : なし
  /// 戻り値 : なし
  static void rc28LcdUnReadCashDispFlgOff() {
    // snprintf(log, sizeof(log), "%s", __FUNCTION__ );
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
    unreadDspFlg = 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 未読現金の入力画面
  /// 関連tprxソース:C rcinoutdsp.c - rc28Lcd_UnRead_cash_Disp
  /// 引数   : なし
  /// 戻り値 : なし
  static void rc28LcdUnReadCashDisp() {
    return;
  }

  /// 関連tprxソース:C rcinoutdsp.c - rcSG_KeyImageText_Make
  static void rcSGKeyImageTextMake(int kyCd) {
    String log = '';

    AplLibImgRead.aplLibImgRead(kyCd);
    RcSgCom.mngPcLog = RcSgCom.mngPcLog + log;
    RcSgCom.rcSGManageLogSend(RcSgDsp.regLog);
    // TODO:00013 三浦 定義のみ実装されている
    RcAssistMnt.rcAssistSend(kyCd + 10000);
  }

  /// 関連tprxソース:C rcinoutdsp.c - rcForceExitChgCinLoan
  /// TODO:00010 長田 定義のみ追加
  static void rcForceExitChgCinLoan() {
    return;
  }

  /// 関連tprxソース:C rcinoutdsp.c - rcInOut_DifferentDisp
  static Future<void> rcInOutDifferentDisp(int dspMode) async {
    rc28MainWindowSizeChange(1);
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if (FbInit.subinitMainSingleSpecialChk() == true) {
      cMem.stat.dualTSingle = cBuf.devId;
    } else {
      cMem.stat.dualTSingle = 0;
    }
    autoNoStaff = 0;

    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        cMem.stat.dualTSingle = 0;
        await RcObr.rcScanDisable();
        if (await rcCheckInOutDspDispType(dspMode)) {
          rc28LcdDiffDisp();
        } else {
          rcLcdDiffDisp(dspMode);
        }
      }
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        if (await rcCheckInOutDspDispType(dspMode)) {
          rc28LcdDiffDisp();
        } else {
          rcLcdDiffDisp(dspMode);
        }
        break;
      case RcRegs.KY_SINGLE:
        rcLcdMsgDiffDisp();
        if (await rcCheckInOutDspDispType(dspMode)) {
          rc28LcdDiffDisp();
        } else {
          rcLcdDiffDisp(dspMode);
        }
        break;
      default:
    }

    return;
  }

  /// 関連tprxソース:C rcinoutdsp.c - rcInout_DrawOpen
  static Future<void> rcInoutDrawOpen(int openFlg) async {
    AcMem cMem = SystemFunc.readAcMem();
    KoptinoutBuff inoutBuff = KoptinoutBuff();
    if (inOut.fncCode > 0) {
      await RcFlrda.rcReadKoptinout(inOut.fncCode, inoutBuff);
    } else {
      String message =
          'rcInoutDrawOpen : rcReadKoptinout[$inOut.fncCode] -> fncCode nothing skip';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, message);
    }

    if (openFlg == 1) {
      await ifPrintDrowOpen(true);
    } else {
      if (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) {
        if (inoutBuff.acbDrwFlg != 0) {
          await ifPrintDrowOpen(true);
        } else {
          await ifPrintDrowOpen(false);
        }
      } else {
        await ifPrintDrowOpen(true);
      }
    }
    cMem.keyStat[cMem.stat.fncCode] = 0;
    return;
  }

  /// 引数   : openFlg true ファイルオープン　false ファイルクローズ
  static Future<void> ifPrintDrowOpen(bool openFlg) async {
    AcMem cMem = SystemFunc.readAcMem();

    if (openFlg) {
      await RcIfPrint.rcDrwopen();
      cMem.stat.clkStatus |= RcIf.OPEN_DRW;
      RxTaskStatDrw taskStatDrw = (await SystemFunc.statDrwGet(tsBuf));
      taskStatDrw.prnStatus |= RcIf.OPEN_DRW;
    } else {
      cMem.stat.clkStatus &= ~RcIf.OPEN_DRW;
    }
  }

  /// 関連tprxソース:C rcinoutdsp.c - rcInOut_Lump_AmtSet_Cmn
  static Future<void> rcInOutLumpAmtSetCmn(
      int sign, KoptinoutBuff pKoptInOut, int ldata1, int ldata2) async {
    int typ;

    if (sign >= 0) {
      sign = 1;
    }

    //一括入力時のファンクションキーコードに応じた在高作成処理
    typ = RxLogCalc.rcCheckFuncAmtTyp(pKoptInOut.kyTyp);
    if (typ == -1) {
      typ = AmtKind.amtCash.index;
    }

    //理論在高
    if (pKoptInOut.tranCreateFlg == 0) //理論在高作成する
    {
      RegsMem().tTtllog.t100200[typ].drwAmt = (ldata1 * sign);
      RegsMem().tTtllog.t100200[AmtKind.amtCash.index].drwAmt -=
          (ldata2 * sign); //お釣り分現金在高減算
    } else {
      String message =
          'rcInOutLumpAmtSetCmn : tran_create_flg[$pKoptInOut.tranCreateFlg] drw_amt no make';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, message);
    }

    //在高実績のky_cdとamt_cnt作成
    RcAtct.rcAmtKyCdMakeTtlLog();
  }

  /// 金種別登録仕様の在高実績メモリ作成
  /// 関連tprxソース:C rcinoutdsp.c - rcInOut_Diff_AmtSet_Cmn
  /// 引数   : sign			符号（回収、支払等在高を減らす時は-1をセット）
  ///         pKoptInOut		キーオプション
  ///         cash_amt		金額指定で在高実績を作成する場合に使用する金額メモリ
  ///         cash_amt_spcify_flg	上記金額メモリを使用するフラグ
  ///         0:金額メモリ使用しない(入出金画面の入力データを使用)
  ///         1:金額メモリ使用する
  /// 戻り値 : なし
  static Future<void> rcInOutDiffAmtSetCmn(int sign, KoptinoutBuff pKoptInOut,
      int cashAmt, int cashAmtSpcifyFlg) async {
    //InOutDispのEntryデータから計算することに注意。釣機回収は入出金画面でないので値が入っていない。
    int i;
    List<T100200> tmp =
        List<T100200>.generate(AmtKind.amtMax.index, (i) => T100200());

    if (sign >= 0) {
      sign = 1;
    }

    for (i = 0; i < AmtKind.amtMax.index; i++) {
      tmp[i].drwAmt = 0;
    }

    if (cashAmtSpcifyFlg == 1) {
      //金額指定で現金在高実績作成(入出金画面メモリを使用しない機能等でフラグ立てる)
      String message =
          'rcInOutDiffAmtSetCmn : %s: cashAmtSpcifyFlg[$cashAmtSpcifyFlg] -> cashAmt[$cashAmt] use';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, message);
      tmp[AmtKind.amtCash.index].drwAmt = cashAmt;
    } else {
      //入出金画面メモリから在高実績を作成。
      String message =
          'rcInOutDiffAmtSetCmn : %s: cashAmtSpcifyFlg[$cashAmtSpcifyFlg] -> InOut Disp InputData use';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, message);
      tmp[AmtKind.amtCash.index].drwAmt =
          (inOut.InOutBtn[InoutDisp.INOUT_Y10000].Amount +
              inOut.InOutBtn[InoutDisp.INOUT_Y5000].Amount +
              inOut.InOutBtn[InoutDisp.INOUT_Y2000].Amount +
              inOut.InOutBtn[InoutDisp.INOUT_Y1000].Amount +
              inOut.InOutBtn[InoutDisp.INOUT_Y500].Amount +
              inOut.InOutBtn[InoutDisp.INOUT_Y100].Amount +
              inOut.InOutBtn[InoutDisp.INOUT_Y50].Amount +
              inOut.InOutBtn[InoutDisp.INOUT_Y10].Amount +
              inOut.InOutBtn[InoutDisp.INOUT_Y5].Amount +
              inOut.InOutBtn[InoutDisp.INOUT_Y1].Amount);
      tmp[AmtKind.amtCha1.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA1].Amount;
      tmp[AmtKind.amtCha2.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA2].Amount;
      tmp[AmtKind.amtCha3.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA3].Amount;
      tmp[AmtKind.amtCha4.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA4].Amount;
      tmp[AmtKind.amtCha5.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA5].Amount;
      tmp[AmtKind.amtCha6.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA6].Amount;
      tmp[AmtKind.amtCha7.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA7].Amount;
      tmp[AmtKind.amtCha8.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA8].Amount;
      tmp[AmtKind.amtCha9.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA9].Amount;
      tmp[AmtKind.amtCha10.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA10].Amount;
      tmp[AmtKind.amtCha11.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA11].Amount;
      tmp[AmtKind.amtCha12.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA12].Amount;
      tmp[AmtKind.amtCha13.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA13].Amount;
      tmp[AmtKind.amtCha14.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA14].Amount;
      tmp[AmtKind.amtCha15.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA15].Amount;
      tmp[AmtKind.amtCha16.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA16].Amount;
      tmp[AmtKind.amtCha17.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA17].Amount;
      tmp[AmtKind.amtCha18.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA18].Amount;
      tmp[AmtKind.amtCha19.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA19].Amount;
      tmp[AmtKind.amtCha20.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA20].Amount;
      tmp[AmtKind.amtCha21.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA21].Amount;
      tmp[AmtKind.amtCha22.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA22].Amount;
      tmp[AmtKind.amtCha23.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA23].Amount;
      tmp[AmtKind.amtCha24.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA24].Amount;
      tmp[AmtKind.amtCha25.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA25].Amount;
      tmp[AmtKind.amtCha26.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA26].Amount;
      tmp[AmtKind.amtCha27.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA27].Amount;
      tmp[AmtKind.amtCha28.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA28].Amount;
      tmp[AmtKind.amtCha29.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA29].Amount;
      tmp[AmtKind.amtCha30.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHA30].Amount;
      tmp[AmtKind.amtChk1.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHK1].Amount;
      tmp[AmtKind.amtChk2.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHK2].Amount;
      tmp[AmtKind.amtChk3.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHK3].Amount;
      tmp[AmtKind.amtChk4.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHK4].Amount;
      tmp[AmtKind.amtChk5.index].drwAmt =
          inOut.InOutBtn[InoutDisp.INOUT_CHK5].Amount;
    }

    //理論在高
    if (pKoptInOut.tranCreateFlg == 0) //理論在高作成する
    {
      for (i = 0; i < AmtKind.amtMax.index; i++) {
        RegsMem().tTtllog.t100200[i].drwAmt = tmp[i].drwAmt * sign;
      }
    } else {
      String message =
          'rcInOutDiffAmtSetCmn : tranCreateFlg[$pKoptInOut.tranCreateFlg] drw_amt no make';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, message);
    }

    //在高実績のky_cdとamt_cnt作成
    RcAtct.rcAmtKyCdMakeTtlLog();
  }

  // TODO: 中間 釣機関数実装のため、定義のみ追加
  /// 関連tprxソース:C rcinoutdsp.c - rcInOut_DifferentDisp
  static void rc28MainWindowSizeChange(int flag) {
    return;
  }

  /// 関連tprxソース:C rcinoutdsp.c - rcCheck_InOutDsp_DispType
  /// 戻り値 : false:表示不可 true:表示可
  static Future<bool> rcCheckInOutDspDispType(int dspMode) async {
    if (dspMode == Inout_Disp_Type.INOUT_DISP_NOMAL) {
      if (await rcCheckInOutDsp28DispType()) {
        return true;
      }
    }
    return false;
  }

  /// 関連tprxソース:C rcinoutdsp.c - rcCheck_InOutDsp_28DispType
  /// 戻り値 : false:表示不可 true:表示可
  static Future<bool> rcCheckInOutDsp28DispType() async {
    if (await RcSysChk.rcChkDisplayType()) {
      return true;
    } else if (await CmCksys.cmWebType() == CmSys.WEBTYPE_WEB2500) {
      return true;
    }
    return false;
  }

  // TODO: 中間 釣機関数実装のため、定義のみ追加
  /// 関連tprxソース:C rcinoutdsp.c - rc28Lcd_DiffDisp
  static void rc28LcdDiffDisp() {
    return;
  }

  // TODO: 中間 釣機関数実装のため、定義のみ追加
  /// 関連tprxソース:C rcinoutdsp.c - rcLcd_DiffDisp
  static void rcLcdDiffDisp(int dspMode) {
    return;
  }

  // TODO: 中間 釣機関数実装のため、定義のみ追加
  /// 関連tprxソース:C rcinoutdsp.c - rcLcd_MsgDiffDisp
  static void rcLcdMsgDiffDisp() {
    return;
  }

  /// 関連tprxソース:C rcinoutdsp.c - rcChkNominalOpe
  static Future<int> rcChkNominalOpe() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkNominalOpe() : rxMemRead error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    switch (FuncKey.getKeyDefine(inOut.fncCode)) {
      case FuncKey.KY_CHG_MENTEOUT:
        return 1;
      case FuncKey.KY_CHGOUT:
        if (Rxkoptcmncom.rxChkKoptCmnChgoutSelectMoney(pCom) == 1) {
          return 1;
        }
        break;
      default:
        break;
    }
    return 0;
  }

  /// 関連tprxソース:C rcinoutdsp.c - rcCal_DifferentTtl
  static int rcCalDifferentTtl() {
    int cashAmt = 0;
    AcMem cMem = SystemFunc.readAcMem();

    inOut.Pdata.TotalPrice = 0;
    inOut.Pdata.Total_Cash = 0;
    inOut.Pdata.Total_Cha = 0;
    inOut.Pdata.Total_Chk = 0;
    if (inOut.dispType >= Inout_Disp_Type.INOUT_DISP_NEW_IN) {
      inOut.InOutBtn[InoutDisp.INOUT_Y2000].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_Y5000].Amount -
              inOut.InOutBtn[InoutDisp.INOUT_Y10000].Amount;
      inOut.Pdata.TotalPrice = inOut.InOutBtn[InoutDisp.INOUT_Y10000].Amount;
      cMem.scrData.price = inOut.Pdata.TotalPrice;
      return inOut.Pdata.TotalPrice;
    }

    inOut.InOutBtn[InoutDisp.INOUT_Y10000].Amount =
        inOut.InOutBtn[InoutDisp.INOUT_Y10000].Count * 10000;
    rcCalcInDatas(InoutDisp.INOUT_Y10000);
    inOut.InOutBtn[InoutDisp.INOUT_Y5000].Amount =
        inOut.InOutBtn[InoutDisp.INOUT_Y5000].Count * 5000;
    rcCalcInDatas(InoutDisp.INOUT_Y5000);
    inOut.InOutBtn[InoutDisp.INOUT_Y2000].Amount =
        inOut.InOutBtn[InoutDisp.INOUT_Y2000].Count * 2000;
    rcCalcInDatas(InoutDisp.INOUT_Y2000);
    inOut.InOutBtn[InoutDisp.INOUT_Y1000].Amount =
        inOut.InOutBtn[InoutDisp.INOUT_Y1000].Count * 1000;
    rcCalcInDatas(InoutDisp.INOUT_Y1000);
    inOut.InOutBtn[InoutDisp.INOUT_Y500].Amount =
        inOut.InOutBtn[InoutDisp.INOUT_Y500].Count * 500;
    rcCalcInDatas(InoutDisp.INOUT_Y500);
    inOut.InOutBtn[InoutDisp.INOUT_Y100].Amount =
        inOut.InOutBtn[InoutDisp.INOUT_Y100].Count * 100;
    rcCalcInDatas(InoutDisp.INOUT_Y100);
    inOut.InOutBtn[InoutDisp.INOUT_Y50].Amount =
        inOut.InOutBtn[InoutDisp.INOUT_Y50].Count * 50;
    rcCalcInDatas(InoutDisp.INOUT_Y50);
    inOut.InOutBtn[InoutDisp.INOUT_Y10].Amount =
        inOut.InOutBtn[InoutDisp.INOUT_Y10].Count * 10;
    rcCalcInDatas(InoutDisp.INOUT_Y10);
    inOut.InOutBtn[InoutDisp.INOUT_Y5].Amount =
        inOut.InOutBtn[InoutDisp.INOUT_Y5].Count * 5;
    rcCalcInDatas(InoutDisp.INOUT_Y5);
    inOut.InOutBtn[InoutDisp.INOUT_Y1].Amount =
        inOut.InOutBtn[InoutDisp.INOUT_Y1].Count;
    rcCalcInDatas(InoutDisp.INOUT_Y1);

    cashAmt = inOut.Pdata.TotalPrice;
    if (inOut.fncCode != FuncKey.KY_LOAN.keyId) {
      inOut.InOutBtn[InoutDisp.INOUT_CHA1].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA1].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA1);
      inOut.InOutBtn[InoutDisp.INOUT_CHA2].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA2].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA2);
      inOut.InOutBtn[InoutDisp.INOUT_CHA3].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA3].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA3);
      inOut.InOutBtn[InoutDisp.INOUT_CHA4].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA4].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA4);
      inOut.InOutBtn[InoutDisp.INOUT_CHA5].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA5].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA5);
      inOut.InOutBtn[InoutDisp.INOUT_CHA6].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA6].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA6);
      inOut.InOutBtn[InoutDisp.INOUT_CHA7].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA7].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA7);
      inOut.InOutBtn[InoutDisp.INOUT_CHA8].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA8].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA8);
      inOut.InOutBtn[InoutDisp.INOUT_CHA9].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA9].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA9);
      inOut.InOutBtn[InoutDisp.INOUT_CHA10].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA10].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA10);
      inOut.InOutBtn[InoutDisp.INOUT_CHK1].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHK1].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHK1);
      inOut.InOutBtn[InoutDisp.INOUT_CHK2].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHK2].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHK2);
      inOut.InOutBtn[InoutDisp.INOUT_CHK3].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHK3].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHK3);
      inOut.InOutBtn[InoutDisp.INOUT_CHK4].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHK4].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHK4);
      inOut.InOutBtn[InoutDisp.INOUT_CHK5].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHK5].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHK5);
      inOut.InOutBtn[InoutDisp.INOUT_CHA11].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA11].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA11);
      inOut.InOutBtn[InoutDisp.INOUT_CHA12].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA12].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA12);
      inOut.InOutBtn[InoutDisp.INOUT_CHA13].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA13].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA13);
      inOut.InOutBtn[InoutDisp.INOUT_CHA14].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA14].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA14);
      inOut.InOutBtn[InoutDisp.INOUT_CHA15].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA15].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA15);
      inOut.InOutBtn[InoutDisp.INOUT_CHA16].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA16].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA16);
      inOut.InOutBtn[InoutDisp.INOUT_CHA17].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA17].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA17);
      inOut.InOutBtn[InoutDisp.INOUT_CHA18].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA18].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA18);
      inOut.InOutBtn[InoutDisp.INOUT_CHA19].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA19].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA19);
      inOut.InOutBtn[InoutDisp.INOUT_CHA20].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA20].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA20);
      inOut.InOutBtn[InoutDisp.INOUT_CHA21].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA21].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA21);
      inOut.InOutBtn[InoutDisp.INOUT_CHA22].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA22].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA22);
      inOut.InOutBtn[InoutDisp.INOUT_CHA23].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA23].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA23);
      inOut.InOutBtn[InoutDisp.INOUT_CHA24].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA24].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA24);
      inOut.InOutBtn[InoutDisp.INOUT_CHA25].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA25].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA25);
      inOut.InOutBtn[InoutDisp.INOUT_CHA26].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA26].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA26);
      inOut.InOutBtn[InoutDisp.INOUT_CHA27].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA27].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA27);
      inOut.InOutBtn[InoutDisp.INOUT_CHA28].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA28].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA28);
      inOut.InOutBtn[InoutDisp.INOUT_CHA29].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA29].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA29);
      inOut.InOutBtn[InoutDisp.INOUT_CHA30].Amount =
          inOut.InOutBtn[InoutDisp.INOUT_CHA30].Count;
      rcCalcInDatas(InoutDisp.INOUT_CHA30);
    }
    cMem.scrData.price = inOut.Pdata.TotalPrice;
    return cashAmt;
  }

  /// 額面金額別の操作処理
  /// 関連tprxソース:C rcinoutdsp.c - rcProcNominalOpe
  /// 引数   : なし
  /// 戻り値 : エラーコード
  static Future<int> rcProcNominalOpe() async {
    int errNo = 0;
    String __FUNCTION__ = 'rcProcNominalOpe';
    int tId = await RcSysChk.getTid();
    AcMem cMem = SystemFunc.readAcMem();
    CommonLimitedInput comLtdInp = SystemFunc.readCommonLimitedInput();
    RxTaskStatBuf tStat = RxTaskStatBuf();

    TprLog().logAdd(tId, LogLevelDefine.normal, '$__FUNCTION__: Start \n');
    RcKyCpick.rcKindOutPrnClr();

    if ((cMem.stat.scrMode == RcRegs.RG_STL) ||
        (cMem.stat.scrMode == RcRegs.VD_STL) ||
        (cMem.stat.scrMode == RcRegs.TR_STL) ||
        (cMem.stat.scrMode == RcRegs.SR_STL)) {
      //rcStlLcdQuit(&Subttl);
      await RcRfmDsp.rcItemDispLCD();
      await RcSet.rcItmLcdScrMode();
    }

    if (cMem.ent.errNo != 0) {
      await RcExt.rxChkModeReset(__FUNCTION__);
      return cMem.ent.errNo;
    }

    //if( comLtdInp.window != null )
    //{
    //gtk_widget_destroy( ComLtdInp.window );
    //}
    //memset( &ComLtdInp, 0x00, sizeof(ComLtdInp) );

    //NomiOpeParts = (AcxNominalOperationParts *)malloc( sizeof(AcxNominalOperationParts) );
    //if( NomiOpeParts == NULL )
    //{
    //await RcExt.rxChkModeReset(__FUNCTION__);
    //return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    //}
    //memset( NomiOpeParts, 0x00, sizeof(AcxNominalOperationParts) );
    RcExt.cashStatSet(__FUNCTION__);
    tStat.cash.inout_flg = 1;
    RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId); // Set Bit 0 of KY_REG

    rcDrawNominalOpe();

    errNo = RcAcracb.rcChkChgStockState();
    if (errNo != OK) {
      await RcExt.rcErr(__FUNCTION__, errNo);
    }
    await RcExt.rxChkModeReset(__FUNCTION__);
    TprLog().logAdd(tId, LogLevelDefine.normal, '$__FUNCTION__: End \n');

    return 0;
  }

  /// 額面金額別の枚数を操作する画面表示
  /// 関連tprxソース:C rcinoutdsp.c - rcDrawNominalOpe
  /// 引数   : なし
  /// 戻り値 : エラーコード
  static Future<void> rcDrawNominalOpe() async {
    int num;
    int startPosition = 0;
    int posiY;
    int posiX;
    int y_offset;
    int color;
    String msg_buf;
    String BtnImage;
    String BtnImage2;
    String titleBuf;
    int ttlbt;
    int bt;
    int windowType = 0;
    int kindCd = 0;
    int tch_key_ctrl = 0;

    String __FUNCTION__ = 'rcDrawNominalOpe';
    int tId = await RcSysChk.getTid();
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    InOutInfo inOut = InOutInfo();
    CommonLimitedInput comLtdInp = SystemFunc.readCommonLimitedInput();
    EucAdj adj = AplLibImgRead.aplLibImgRead(inOut.fncCode);

    await RcFlrda.rcReadKoptinout(inOut.fncCode, kortInOut);
    if (FbInit.subinitMainSingleSpecialChk()) {
      cMem.stat.dualTSingle = cBuf.devId;
    } else {
      cMem.stat.dualTSingle = 0;
    }

    windowType = 0;
    if (cMem.stat.dualTSingle == 1) {
      windowType = 1;
    }
    kindCd = rcInOutDivideTypeSet(kindCd);

    y_offset = 0;

    // 別画面への表示
    await RcStlLcd.rcDrawMsgOtherDisp(inOut.fncCode, '');

    rc28MainWindowSizeChange(1);

    // GtkWidget系なのでコメントアウト

    // ウィンドウ (共通簡易入力関数を用いる)
    //comLtdInp.window = gtk_window_new_typ(GTK_WINDOW_POPUP, windowType );
    //gtk_object_set_data(GTK_OBJECT(comLtdInp.window), "window", comLtdInp.window);
    //gtk_widget_set_usize(comLtdInp.window, NOMINAL_WINDOW_X, NOMINAL_WINDOW_Y);
    //gtk_window_set_position(GTK_WINDOW(comLtdInp.window), GTK_WIN_POS_NONE);
    //gtk_container_border_width(GTK_CONTAINER(comLtdInp.window), NOMINAL_WINDOW_BORDER);
    //gtk_widget_show(comLtdInp.window);

    // 下地
    //NomiOpeParts->wFixed = gtk_fixed_new();
    //gtk_widget_set_usize(NomiOpeParts->wFixed, NOMINAL_FIXED_X, NOMINAL_FIXED_Y);
    //gtk_container_add(GTK_CONTAINER(comLtdInp.window), NomiOpeParts->wFixed);
    //ChgColor(NomiOpeParts->wFixed, &ColorSelect[MidiumGray], &ColorSelect[MidiumGray], &ColorSelect[MidiumGray]);
    //gtk_widget_show(NomiOpeParts->wFixed);

    // タイトル
    //memset( titleBuf, 0x00, sizeof(titleBuf) );
    //AplLib_ImgRead(inOut.fncCode, titleBuf, sizeof(titleBuf) - 1 );
    //NomiOpeParts->TitleBar = gtk_top_menu_new_with_size(titleBuf, NOMINAL_TITLEB_X, NOMINAL_TITLEB_Y, White, MidiumGray, White);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed),NomiOpeParts->TitleBar, NOMINAL_TITLEB_F_X, NOMINAL_TITLEB_F_Y);
    //gtk_widget_show(NomiOpeParts->TitleBar);

    // 終了ボタン
    //NomiOpeParts->ExitBtn = gtk_round_button_new_with_label((char *)EXIT_LABEL);
    //gtk_round_button_set_color(GTK_ROUND_BUTTON(NomiOpeParts->ExitBtn), Orange);
    //gtk_widget_set_usize(GTK_WIDGET(NomiOpeParts->ExitBtn), NOMINAL_BTN_S_X, NOMINAL_BTN_S_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->ExitBtn, NOMINAL_EXIT_F_X, NOMINAL_EXIT_F_Y);
    //gtk_widget_show(NomiOpeParts->ExitBtn);
    //gtk_signal_connect_object(GTK_OBJECT(NomiOpeParts->ExitBtn), "pressed", GTK_SIGNAL_FUNC(rcFuncQuitNominalOpe), NULL);

    // 実行ボタン
    //NomiOpeParts->ExecBtn = gtk_round_button_new_with_label((char *)EXEC_LABEL);
    //gtk_round_button_set_color(GTK_ROUND_BUTTON(NomiOpeParts->ExecBtn), SkyBlue);
    //gtk_widget_set_usize(GTK_WIDGET(NomiOpeParts->ExecBtn), NOMINAL_BTN_S_X, NOMINAL_BTN_S_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->ExecBtn, NOMINAL_EXEC_F_X, NOMINAL_EXEC_F_Y);
    //gtk_widget_show(NomiOpeParts->ExecBtn);
    //gtk_signal_connect_object(GTK_OBJECT(NomiOpeParts->ExecBtn), "pressed", GTK_SIGNAL_FUNC(rcFuncExecNominalOpe), GTK_OBJECT(comLtdInp.window));

    // 入力ボタン
    //NomiOpeParts->IntBtn = gtk_round_button_new_with_label((char *)INT_LABEL);
    //gtk_round_button_set_color(GTK_ROUND_BUTTON(NomiOpeParts->IntBtn), Red);
    //gtk_regsbutton_set_color_label(NomiOpeParts->IntBtn, White);
    //gtk_widget_set_usize(GTK_WIDGET(NomiOpeParts->IntBtn), NOMINAL_BTN_S_X, NOMINAL_BTN_S_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->IntBtn, NOMINAL_INT_F_X, NOMINAL_INT_F_Y);
    //gtk_widget_show(NomiOpeParts->IntBtn);
    //gtk_signal_connect_object(GTK_OBJECT(NomiOpeParts->IntBtn), "pressed", GTK_SIGNAL_FUNC(rcFuncInputNominalOpe),GTK_OBJECT(comLtdInp.window));

    // (釣機在高)更新ボタン
    //NomiOpeParts->RefreshBtn = gtk_round_button_new_with_label((char *)REFRESH_LABEL);
    //gtk_round_button_set_color(GTK_ROUND_BUTTON(NomiOpeParts->RefreshBtn), Navy);
    //gtk_regsbutton_set_color_label(NomiOpeParts->RefreshBtn, White);
    //gtk_widget_set_usize(GTK_WIDGET(NomiOpeParts->RefreshBtn), NOMINAL_BTN_S_X, NOMINAL_BTN_S_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->RefreshBtn, NOMINAL_REFRESH_F_X, NOMINAL_REFRESH_F_Y);
    //gtk_widget_show(NomiOpeParts->RefreshBtn);
    //gtk_signal_connect_object(GTK_OBJECT(NomiOpeParts->RefreshBtn), "pressed",
    //GTK_SIGNAL_FUNC(rcFuncRefreshNominalOpe),GTK_OBJECT(comLtdInp.window));

    // 合計金額 タイトル
    //NomiOpeParts->TtlMsg = gtk_round_entry_new();
    //gtk_widget_set_usize(NomiOpeParts->TtlMsg, NOMINAL_ENT2_X+NOMINAL_ENTRY_DIFF_X, NOMINAL_ENT2_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->TtlMsg,NOMINAL_TOTAL_F_X-NOMINAL_ENTRY_DIFF_X, NOMINAL_TOTAL_F_Y+y_offset);
    //gtk_round_entry_set_editable(GTK_ROUND_ENTRY(NomiOpeParts->TtlMsg), false);
    //gtk_round_entry_set_bgcolor(GTK_ROUND_ENTRY(NomiOpeParts->TtlMsg), MediumGray);
    //ChgStyle(NomiOpeParts->TtlMsg, &ColorSelect[Lime], &ColorSelect[BlackGray], &ColorSelect[BlackGray], FONTSZ_16);
    //gtk_widget_show(NomiOpeParts->TtlMsg);
    //snprintf( msg_buf, sizeof(msg_buf), "    %s", CHGOUT_TOTAL_LABEL );
    //gtk_round_entry_set_text(GTK_ROUND_ENTRY(NomiOpeParts->TtlMsg),msg_buf);

    // 合計金額表示部
    //NomiOpeParts->TtlPrice = gtk_round_entry_new();
    //gtk_widget_set_usize(NomiOpeParts->TtlPrice, NOMINAL_ENT2_X+NOMINAL_ENTRY_DIFF_X, NOMINAL_ENT_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->TtlPrice,NOMINAL_TOTAL_F_X-NOMINAL_ENTRY_DIFF_X, NOMINAL_TOTAL2_F_Y+y_offset);
    //gtk_round_entry_set_editable(GTK_ROUND_ENTRY(NomiOpeParts->TtlPrice), false);
    //gtk_round_entry_set_bgcolor(GTK_ROUND_ENTRY(NomiOpeParts->TtlPrice), MediumGray);
    //ChgStyle(NomiOpeParts->TtlPrice, &ColorSelect[Lime], &ColorSelect[BlackGray], &ColorSelect[BlackGray], FONTSZ_24);
    //gtk_widget_show(NomiOpeParts->TtlPrice);

    //if(inOut.fncCode == KY_CHG_MENTEOUT){
    //// 取引外払出の注意書き
    //NomiOpeParts->WarnMsg = gtk_label_new( CHGOUT_WARN_LABEL );
    //gtk_widget_set_usize(NomiOpeParts->WarnMsg, NOMINAL_WARN_X, NOMINAL_WARN_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->TitleBar), NomiOpeParts->WarnMsg, NOMINAL_WARN_F_X, NOMINAL_WARN_F_Y);
    //ChgStyle(NomiOpeParts->WarnMsg, &ColorSelect[Red],
    //&ColorSelect[MidiumGray], &ColorSelect[MidiumGray], FONTSZ_16);
    //gtk_misc_set_alignment(GTK_MISC(NomiOpeParts->WarnMsg), 0, 0.5);
    //gtk_widget_show(NomiOpeParts->WarnMsg);
    //}

    /* 区分選択ボタン作成 */
    //NomiOpeParts->DivBtn = gtk_round_button_new_with_label((char *)INOUT_DIV_LABEL);
    //gtk_round_button_set_color(GTK_ROUND_BUTTON(NomiOpeParts->DivBtn), TurquoiseBlue);
    //gtk_widget_ref(NomiOpeParts->DivBtn);
    //gtk_object_set_data_full(GTK_OBJECT(NomiOpeParts->wFixed), "DivSlctBtn", NomiOpeParts->DivBtn,
    //(GtkDestroyNotify)gtk_widget_unref);
    //gtk_widget_set_usize(GTK_WIDGET(NomiOpeParts->DivBtn), NOMINAL_BTN_W_X, NOMINAL_BTN_W_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->DivBtn, NOMINAL_DIV_F_X + NOMINAL_FIL + NOMINAL_WINDOW_BORDER, NOMINAL_DIV_F_Y);
    //gtk_widget_show(NomiOpeParts->DivBtn);
    //gtk_signal_connect(GTK_OBJECT(NomiOpeParts->DivBtn), "pressed",
    //GTK_SIGNAL_FUNC(rcinout_div_select_btn), (gpointer)kindCd);

    /* 区分選択エントリ作成 */
    //NomiOpeParts->DivEnt = gtk_round_entry_new();
    //gtk_widget_ref(NomiOpeParts->DivEnt);
    //gtk_object_set_data_full(GTK_OBJECT(NomiOpeParts->wFixed),"div_ent",NomiOpeParts->DivEnt,
    //(GtkDestroyNotify)gtk_widget_unref);
    //gtk_widget_set_usize(NomiOpeParts->DivEnt, NOMINAL_DIV_ENT_X, NOMINAL_DIV_ENT_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->DivEnt, NOMINAL_BTN_W_X + NOMINAL_F_X + NOMINAL_FIL + NOMINAL_WINDOW_BORDER + NOMINAL_F_X_FIL, NOMINAL_DIV_F_Y);
    //gtk_round_entry_set_editable(GTK_ROUND_ENTRY(NomiOpeParts->DivEnt), false);
    //gtk_round_entry_set_bgcolor(GTK_ROUND_ENTRY(NomiOpeParts->DivEnt), MediumGray);
    //ChgStyle(NomiOpeParts->DivEnt, &ColorSelect[Lime],&ColorSelect[MidiumGray],
    //&ColorSelect[MidiumGray], FONTSZ_24);
    //gtk_widget_show(NomiOpeParts->DivEnt);

    //posiY = NOMINAL_F_Y + NOMINAL_FIL + NOMINAL_WINDOW_BORDER + NOMINAL_DIV_ENT_Y + NOMINAL_FIL + y_offset;
    //posiX = NOMINAL_F_X + NOMINAL_FIL + NOMINAL_WINDOW_BORDER + NOMINAL_BTN_S_X + NOMINAL_F_X_FIL;
    //if(rcCheck_AcrAcb_ON(1) == ACR_COINBILL)
    //{
    //// 入力枚数 タイトル
    //NomiOpeParts->InputMsg = gtk_label_new( CHGOUT_INPUT_LABEL );
    //gtk_widget_set_usize(NomiOpeParts->InputMsg, NOMINAL_ENT_X, NOMINAL_COMMENT_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->InputMsg, posiX, posiY);
    //ChgStyle(NomiOpeParts->InputMsg, &ColorSelect[BlackGray],
    //&ColorSelect[MidiumGray], &ColorSelect[MidiumGray], FONTSZ_16);
    //gtk_widget_show(NomiOpeParts->InputMsg);

    // 在高枚数 タイトル
    //NomiOpeParts->NowMsg = gtk_label_new( CHGOUT_NOW_LABEL );
    //gtk_widget_set_usize(NomiOpeParts->NowMsg, NOMINAL_ENT_X, NOMINAL_COMMENT_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->NowMsg,
    //posiX+NOMINAL_F_X_FIL+NOMINAL_ENT_X, posiY);
    //ChgStyle(NomiOpeParts->NowMsg, &ColorSelect[BlackGray],
    //&ColorSelect[MidiumGray], &ColorSelect[MidiumGray], FONTSZ_16);
    //gtk_widget_show(NomiOpeParts->NowMsg);

    // 結果枚数 タイトル
    //NomiOpeParts->AfterMsg = gtk_label_new( CHGOUT_AFTER_LABEL );
    //gtk_widget_set_usize(NomiOpeParts->AfterMsg, NOMINAL_ENT_X, NOMINAL_COMMENT_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->AfterMsg,
    //posiX+NOMINAL_F_X_FIL*2+NOMINAL_ENT_X*2+NOMINAL_F_X_FIL+NOMINAL_ALLOW_X, posiY);
    //ChgStyle(NomiOpeParts->AfterMsg, &ColorSelect[BlackGray],
    //&ColorSelect[MidiumGray], &ColorSelect[MidiumGray], FONTSZ_16);
    //gtk_widget_show(NomiOpeParts->AfterMsg);
    //}

    //posiX = posiX*2 + NOMINAL_ENT_X + NOMINAL_F_X_FIL + NOMINAL_CALCENT_X + NOMINAL_F_X_FIL;
    // 入力枚数 タイトル
    //NomiOpeParts->InputMsg2 = gtk_label_new( CHGOUT_INPUT_LABEL );
    //gtk_widget_set_usize(NomiOpeParts->InputMsg2, NOMINAL_ENT_X, NOMINAL_COMMENT_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->InputMsg2, posiX, posiY);
    //ChgStyle(NomiOpeParts->InputMsg2, &ColorSelect[BlackGray],
    //&ColorSelect[MidiumGray], &ColorSelect[MidiumGray], FONTSZ_16);
    //gtk_widget_show(NomiOpeParts->InputMsg2);

    // 在高枚数 タイトル
    //NomiOpeParts->NowMsg2 = gtk_label_new( CHGOUT_NOW_LABEL );
    //gtk_widget_set_usize(NomiOpeParts->NowMsg2, NOMINAL_ENT_X, NOMINAL_COMMENT_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->NowMsg2,
    //posiX+NOMINAL_F_X_FIL+NOMINAL_ENT_X, posiY);
    //ChgStyle(NomiOpeParts->NowMsg2, &ColorSelect[BlackGray],
    //&ColorSelect[MidiumGray], &ColorSelect[MidiumGray], FONTSZ_16);
    //gtk_widget_show(NomiOpeParts->NowMsg2);

    // 結果枚数 タイトル
    //NomiOpeParts->AfterMsg2 = gtk_label_new( CHGOUT_AFTER_LABEL );
    //gtk_widget_set_usize(NomiOpeParts->AfterMsg2, NOMINAL_ENT_X, NOMINAL_COMMENT_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->AfterMsg2,
    //posiX+NOMINAL_F_X_FIL*2+NOMINAL_ENT_X*2+NOMINAL_F_X_FIL+NOMINAL_ALLOW_X, posiY);
    //ChgStyle(NomiOpeParts->AfterMsg2, &ColorSelect[BlackGray],
    //&ColorSelect[MidiumGray], &ColorSelect[MidiumGray], FONTSZ_16);
    //gtk_widget_show(NomiOpeParts->AfterMsg2);

    //startPosition = rcChkNominalOpeStartPosition();
    //for(num = startPosition; num < NOMINAL_MAX; num++)
    //{
    //cm_clr((char *)&BtnImage[0],sizeof(BtnImage));
    //cm_spc((char *)&BtnImage2[0],sizeof(BtnImage2));
    //switch(num)
    //{
    //case NOMINAL_Y10000:	memcpy(&BtnImage,INOUT_10000,strlen(INOUT_10000));	color = Yellow;	break;
    //case NOMINAL_Y5000:	memcpy(&BtnImage,INOUT_5000,strlen(INOUT_5000));	/*memset(&BtnImage[strlen(BtnImage)],0x0A,1);
    //					memcpy(&BtnImage[strlen(BtnImage)],INOUT_CHIKET,strlen(INOUT_CHIKET));*/	color = Yellow;	break;
    //case NOMINAL_Y2000:	memcpy(&BtnImage,INOUT_2000,strlen(INOUT_2000)) ;	/*memset(&BtnImage[strlen(BtnImage)],0x0A,1);
    //					memcpy(&BtnImage[strlen(BtnImage)],INOUT_CHIKET,strlen(INOUT_CHIKET));*/	color = Yellow;	break;
    //case NOMINAL_Y1000:  memcpy(&BtnImage,INOUT_1000,strlen(INOUT_1000));	color = Yellow;	break;
    //case NOMINAL_Y500:   memcpy(&BtnImage,INOUT_500,strlen(INOUT_500));    color = Yellow;             break;
    //case NOMINAL_Y100:   memcpy(&BtnImage,INOUT_100,strlen(INOUT_100));    color = Yellow;             break;
    //case NOMINAL_Y50:    memcpy(&BtnImage,INOUT_50,strlen(INOUT_50));     color = Yellow;             break;
    //case NOMINAL_Y10:    memcpy(&BtnImage,INOUT_10,strlen(INOUT_10));     color = Yellow;             break;
    //case NOMINAL_Y5:     memcpy(&BtnImage,INOUT_5,strlen(INOUT_5));      color = Yellow;             break;
    //case NOMINAL_Y1:     memcpy(&BtnImage,INOUT_1,strlen(INOUT_1));      color = Yellow;             break;
    //}
    //if(! cm_chk_spc((char *)&BtnImage2[0],sizeof(BtnImage2)))
    //{
    //if(4 < adj.count)
    //{
    //ttlbt = adj.byte;
    //memcpy(&BtnImage[0],&BtnImage2[0],sizeof(BtnImage2));
    //adj = AplLib_EucAdjust(BtnImage,strlen(BtnImage),4);
    //bt = adj.byte;
    //cm_clr((char *)&BtnImage[0],sizeof(BtnImage));
    //memcpy(&BtnImage[0],&BtnImage2[0],bt);
    //memset(&BtnImage[bt],0x0A,1);
    //memcpy(&BtnImage[bt+1],&BtnImage2[bt],(ttlbt - bt));
    //}
    //else
    //{
    //memcpy(&BtnImage[0],&BtnImage2[0],adj.byte);
    //}
    //*cm_BOA(BtnImage) = 0x00;
    //}
    //// 額面金額選択ボタン
    //NomiOpeParts->NominalData[num].SelectBtn = gtk_round_button_new_with_label(BtnImage);
    //gtk_round_button_set_color(GTK_ROUND_BUTTON(NomiOpeParts->NominalData[num].SelectBtn), color);
    //gtk_widget_set_usize(GTK_WIDGET(NomiOpeParts->NominalData[num].SelectBtn), NOMINAL_BTN_S_X, NOMINAL_BTN_S_Y);
    //if(num < NOMINAL_Y500)
    //{
    //posiX = NOMINAL_F_X + NOMINAL_FIL + NOMINAL_WINDOW_BORDER;
    //posiY = NOMINAL_COMMENT_Y + NOMINAL_F_Y + NOMINAL_FIL + NOMINAL_WINDOW_BORDER + NOMINAL_DIV_ENT_Y + NOMINAL_FIL + (NOMINAL_F_X_FIL * num) + (NOMINAL_BTN_S_Y * num) + y_offset;
    //}
    //else if((num >= NOMINAL_Y500) && (num < NOMINAL_MAX))
    //{
    //posiX = NOMINAL_F_X + NOMINAL_FIL + NOMINAL_WINDOW_BORDER + NOMINAL_BTN_S_X + NOMINAL_F_X_FIL + NOMINAL_ENT_X + NOMINAL_F_X_FIL + NOMINAL_CALCENT_X + NOMINAL_F_X_FIL * 2;
    //posiY = NOMINAL_COMMENT_Y + NOMINAL_F_Y + NOMINAL_FIL + NOMINAL_WINDOW_BORDER + NOMINAL_DIV_ENT_Y + NOMINAL_FIL + (NOMINAL_F_X_FIL * (num - NOMINAL_Y500)) + (NOMINAL_BTN_S_Y * (num - NOMINAL_Y500)) + y_offset;
    //}
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->NominalData[num].SelectBtn, posiX, posiY);
    //gtk_signal_connect(GTK_OBJECT(NomiOpeParts->NominalData[num].SelectBtn), "pressed", GTK_SIGNAL_FUNC(rcFuncSelectNominalOpe), (gpointer)&NomiOpeParts->NominalData[num]);
    //gtk_widget_show(NomiOpeParts->NominalData[num].SelectBtn);

    // 入力枚数
    //NomiOpeParts->NominalData[num].InputEntry = gtk_round_entry_new();
    //gtk_widget_set_usize(NomiOpeParts->NominalData[num].InputEntry, NOMINAL_ENT_X, NOMINAL_ENT_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->NominalData[num].InputEntry,
    //posiX+NOMINAL_BTN_S_X+NOMINAL_F_X_FIL, posiY);
    //gtk_round_entry_set_editable(GTK_ROUND_ENTRY(NomiOpeParts->NominalData[num].InputEntry), false);
    //gtk_round_entry_set_bgcolor(GTK_ROUND_ENTRY(NomiOpeParts->NominalData[num].InputEntry), MediumGray);
    //ChgStyle(NomiOpeParts->NominalData[num].InputEntry, &ColorSelect[Lime],
    //&ColorSelect[MidiumGray], &ColorSelect[MidiumGray], FONTSZ_16);
    //gtk_widget_show(NomiOpeParts->NominalData[num].InputEntry);

    // 計算枠
    //NomiOpeParts->NominalData[num].CalcFrame = gtk_round_frame_new();
    //gtk_widget_set_usize(NomiOpeParts->NominalData[num].CalcFrame, NOMINAL_CALCENT_X, NOMINAL_ENT_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->NominalData[num].CalcFrame,
    //posiX+NOMINAL_BTN_S_X+NOMINAL_F_X_FIL+NOMINAL_ENT_X+NOMINAL_F_X_FIL, posiY);
    //gtk_round_frame_set_color(GTK_ROUND_FRAME(NomiOpeParts->NominalData[num].CalcFrame), Navy);
    //gtk_widget_show(NomiOpeParts->NominalData[num].CalcFrame);

    // 現在枚数
    //NomiOpeParts->NominalData[num].StockLabel = gtk_label_new("");
    //gtk_widget_set_usize(NomiOpeParts->NominalData[num].StockLabel, NOMINAL_ENT_X, NOMINAL_ENT_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->NominalData[num].StockLabel,
    //posiX+NOMINAL_BTN_S_X+NOMINAL_F_X_FIL+NOMINAL_ENT_X+NOMINAL_F_X_FIL, posiY);
    //ChgStyle(NomiOpeParts->NominalData[num].StockLabel, &ColorSelect[White],
    //&ColorSelect[MidiumGray], &ColorSelect[MidiumGray], FONTSZ_16);
    //gtk_widget_show(NomiOpeParts->NominalData[num].StockLabel);

    // →ラベル
    //NomiOpeParts->NominalData[num].AllowLabel = gtk_label_new( CHGOUT_ALLOW_LABEL );
    //gtk_widget_set_usize(NomiOpeParts->NominalData[num].AllowLabel, NOMINAL_ALLOW_X, NOMINAL_BTN_S_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->NominalData[num].AllowLabel,
    //posiX+NOMINAL_BTN_S_X+NOMINAL_F_X_FIL+NOMINAL_ENT_X*2+NOMINAL_F_X_FIL*2, posiY);
    //ChgStyle(NomiOpeParts->NominalData[num].AllowLabel, &ColorSelect[White],
    //&ColorSelect[MidiumGray], &ColorSelect[MidiumGray], FONTSZ_16);
    //gtk_widget_show(NomiOpeParts->NominalData[num].AllowLabel);

    // 結果枚数
    //NomiOpeParts->NominalData[num].AfterLabel = gtk_label_new("");
    //gtk_widget_set_usize(NomiOpeParts->NominalData[num].AfterLabel, NOMINAL_ENT_X, NOMINAL_ENT_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->NominalData[num].AfterLabel,
    //posiX+NOMINAL_BTN_S_X+NOMINAL_F_X_FIL+NOMINAL_ENT_X*2+NOMINAL_F_X_FIL*3+NOMINAL_ALLOW_X, posiY);
    //ChgStyle(NomiOpeParts->NominalData[num].AfterLabel, &ColorSelect[White],
    //&ColorSelect[MidiumGray], &ColorSelect[MidiumGray], FONTSZ_16);
    //gtk_widget_show(NomiOpeParts->NominalData[num].AfterLabel);

    //NomiOpeParts->NominalData[num].SetPosition = num;
    //rcDrawEachDataNominalOpe( num, ACX_NOMINALDISP_ENTRY );
    //}

    // セルフ用の数値入力ボタンを表示
    //if( (rcSG_Chk_SelfGate_System()) || (rcQC_Chk_Qcashier_System()) )
    //{
    //tch_key_ctrl = 1;
    //}
    //else
    //{
    //if (rcsyschk_happy_smile())
    //{
    //tch_key_ctrl = 1;
    //}
    //else if(cBuf.db_trm.easy_ui_mode)
    //{
    //tch_key_ctrl = 1;
    //}
    //else
    //{
    //tch_key_ctrl = 0;
    //}
    //}

    //if (tch_key_ctrl == 1)
    //{
    //struct	selfFuncList		// キーコードとキー名称のリスト
    //    {
    //int	Key;
    //char	*Name;
    //} funcList[SELF_NUM_BTN_MAX] =
    //{
    //{ KY_1, SG_ENT1 },
    //{ KY_2, SG_ENT2 },
    //{ KY_3, SG_ENT3 },
    //{ KY_4, SG_ENT4 },
    //{ KY_5, SG_ENT5 },
    //{ KY_6, SG_ENT6 },
    //{ KY_7, SG_ENT7 },
    //{ KY_8, SG_ENT8 },
    //{ KY_9, SG_ENT9 },
    //{ KY_0, SG_ENT0 },
    //{ KY_CLR, SG_CLEAR },
    //};
    //int	plusPosiX = 0;
    //int	plusPosiY = 0;
    //short	color = LightGray;

    //posiX = NOMINAL_F_X + NOMINAL_FIL + NOMINAL_WINDOW_BORDER;
    //posiY = NOMINAL_COMMENT_Y + NOMINAL_F_Y + NOMINAL_FIL + NOMINAL_WINDOW_BORDER + NOMINAL_DIV_ENT_Y + NOMINAL_FIL + (NOMINAL_F_X_FIL * 4) + (NOMINAL_BTN_S_Y * 4) + y_offset;

    //for( num = 0; num < SELF_NUM_BTN_MAX; num++ )
    //{
    //if( num == 5 )
    //{
    //plusPosiY = NOMINAL_BTN_S_Y + NOMINAL_F_Y_FIL;
    //plusPosiX = 0;
    //}
    //if( funcList[num].Key == KY_CLR )
    //{
    //color = Red;
    //}
    //NomiOpeParts->SelfNumBtn[num] = gtk_round_button_new_with_label( funcList[num].Name );
    //gtk_round_button_set_color(GTK_ROUND_BUTTON(NomiOpeParts->SelfNumBtn[num]), color);
    //gtk_widget_set_usize(GTK_WIDGET(NomiOpeParts->SelfNumBtn[num]), NOMINAL_BTN_S_X, NOMINAL_BTN_S_Y);
    //gtk_fixed_put(GTK_FIXED(NomiOpeParts->wFixed), NomiOpeParts->SelfNumBtn[num], posiX + plusPosiX, posiY + plusPosiY);
    //gtk_signal_connect(GTK_OBJECT(NomiOpeParts->SelfNumBtn[num]), "pressed", GTK_SIGNAL_FUNC(rcBtnFncDetect), (gpointer)funcList[num].Key);
    //gtk_widget_show(NomiOpeParts->SelfNumBtn[num]);

    //plusPosiX += NOMINAL_BTN_S_X + NOMINAL_F_X_FIL;
    //}
    //}
    // 各データの初期表示処理
    rcRefreshProcNominalOpe();
    rcDrawAfterLabelNominalOpe(0);
    rcDrawEachDataNominalOpe(
        startPosition, AcxNominaldispLabelType.ACX_NOMINALDISP_ENTRY_SELECT);

    // Now Position Set
    //NomiOpeParts->NowPosition = startPosition;

    // 簡易入力モードの設定値をセット(入力が出来るようになる)
    comLtdInp.keyEvent = 1;
    comLtdInp.keyFunc = rcEntryProcNominalOpe;
    comLtdInp.inpFunc = rcFuncInputNominalOpe;
    if (tch_key_ctrl == 1) {
      comLtdInp.tchEvent = 1;
      comLtdInp.tchFunc = rcEntryProcNominalOpe;
    }

    //理由選択先入力設定時、入金理由選択表示
    rcInOutDivideFirstDisp();

    return;
  }

  /// 関連tprxソース: rcinoutdsp.c - rcInOut_DivideType_Set
  static int rcInOutDivideTypeSet(int kindAns) {
    //c_divide_mstの理由タイプ判定 1:入金 2:支払
    InOutInfo inOut = InOutInfo();

    switch (FuncKey.values[inOut.fncCode]) {
      //入金
      case FuncKey.KY_CIN1:
      case FuncKey.KY_CIN2:
      case FuncKey.KY_CIN3:
      case FuncKey.KY_CIN4:
      case FuncKey.KY_CIN5:
      case FuncKey.KY_CIN6:
      case FuncKey.KY_CIN7:
      case FuncKey.KY_CIN8:
      case FuncKey.KY_CIN9:
      case FuncKey.KY_CIN10:
      case FuncKey.KY_CIN11:
      case FuncKey.KY_CIN12:
      case FuncKey.KY_CIN13:
      case FuncKey.KY_CIN14:
      case FuncKey.KY_CIN15:
      case FuncKey.KY_CIN16:
      case FuncKey.KY_CHGCIN:
        kindAns = 1;
        break;
      //支払
      case FuncKey.KY_OUT1:
      case FuncKey.KY_OUT2:
      case FuncKey.KY_OUT3:
      case FuncKey.KY_OUT4:
      case FuncKey.KY_OUT5:
      case FuncKey.KY_OUT6:
      case FuncKey.KY_OUT7:
      case FuncKey.KY_OUT8:
      case FuncKey.KY_OUT9:
      case FuncKey.KY_OUT10:
      case FuncKey.KY_OUT11:
      case FuncKey.KY_OUT12:
      case FuncKey.KY_OUT13:
      case FuncKey.KY_OUT14:
      case FuncKey.KY_OUT15:
      case FuncKey.KY_OUT16:
      case FuncKey.KY_CHGOUT:
      case FuncKey.KY_CHG_MENTEOUT:
        kindAns = 2;
        break;
      default:
        break;
    }
    return kindAns;
  }

  /// 関連tprxソース: rcinoutdsp.h - rcCalc_InDatas
  static Future<void> rcCalcInDatas(int kind) async {
    inOut.Pdata.TotalPrice += inOut.InOutBtn[kind].Amount;
    int btnType = rcCheckInOutBtnType(rcInOutBtnInfPosiChk(kind));
    switch (btnType) {
      case InoutPayType.INOUT_TYPE_CASH:
        inOut.Pdata.Total_Cash += inOut.InOutBtn[kind].Amount;
        break;
      case InoutPayType.INOUT_TYPE_CHA:
        inOut.Pdata.Total_Cha += inOut.InOutBtn[kind].Amount;
        break;
      case InoutPayType.INOUT_TYPE_CHK:
        inOut.Pdata.Total_Chk += inOut.InOutBtn[kind].Amount;
        break;
      default:
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcCalcInDatas : btnType[$btnType] amount[${inOut.InOutBtn[kind].Amount}] case default");
        break;
    }
  }

  // TODO: 中間 釣機関数実装のため、定義のみ追加
  /// 更新処理実行部
  /// 関連tprxソース: rcinoutdsp.c - rcRefreshProcNominalOpe
  static Future<void> rcRefreshProcNominalOpe() async {
    return;
  }

  // TODO: 中間 釣機関数実装のため、定義のみ追加
  /// 枚数の入力データ処理
  /// 関連tprxソース: rcinoutdsp.c - rcEntryProcNominalOpe
  static int rcEntryProcNominalOpe() {
    return 0;
  }

  // TODO: 中間 釣機関数実装のため、定義のみ追加
  /// 入力ボタン押下処理 (移動するだけ)
  /// 関連tprxソース: rcinoutdsp.c - rcFuncInputNominalOpe
  static int rcFuncInputNominalOpe() {
    return 0;
  }

  /// 理由選択先入力制御
  /// 関連tprxソース: rcinoutdsp.c - rcInOut_Divide_FirstDisp
  static void rcInOutDivideFirstDisp() {
    InOutInfo inOut = InOutInfo();
    KoptinoutBuff kortInOut = KoptinoutBuff();
    //short	err_no = 0;

    //理由選択先入力設定時、入金理由選択表示
    if (!((inOut.fncCode == FuncKey.KY_LOAN.keyId) ||
        (inOut.fncCode == FuncKey.KY_PICK.keyId))) {
      if (kortInOut.divideFlg == 1) //先入力設定
      {
        // GtkWidget系なのでコメントアウト
        //err_no = rcGtkTimerAdd(NORMAL_EVENT, (GtkFunction)rcInOut_Divide_Disp);
      }
    }
  }

  /// 接続機器別のスタート位置をチェック
  /// 関連tprxソース: rcinoutdsp.c - rcChkNominalOpeStartPosition
  static Future<int> rcChkNominalOpeStartPosition() async {
    int startPosition;

    if (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) {
      startPosition = AcxNominaldispNominalType.NOMINAL_Y10000.index;
    } else {
      startPosition = AcxNominaldispNominalType.NOMINAL_Y500.index;
    }
    return (startPosition);
  }

  // TODO: 中間 釣機関数実装のため、定義のみ追加
  /// 額面金額別の枚数表示処理
  /// 関連tprxソース: rcinoutdsp.c - rcDrawEachDataNominalOpe
  static void rcDrawEachDataNominalOpe(int num, AcxNominaldispLabelType type) {
    return;
  }

  // (釣銭機内データ - 入力データ) の結果データ作成と表示処理
  /// (釣銭機内データ - 入力データ) の結果データ作成と表示処理
  /// 関連tprxソース: rcinoutdsp.c - rcDrawAfterLabelNominalOpe
  static void rcDrawAfterLabelNominalOpe(int num) {
    // GtkWidget系なのでコメントアウト
    //NomiOpeParts->NominalData[num].AfterCount = NomiOpeParts->NominalData[num].StockCount - NomiOpeParts->NominalData[num].InputCount;
    rcDrawEachDataNominalOpe(
        num, AcxNominaldispLabelType.ACX_NOMINALDISP_AFTER);
  }

  /// 関連tprxソース: rcinoutdsp.c - rcSG_ExitLogText_Make
  static void rcSGExitLogTextMake() {
    if (CompileFlag.SELF_GATE) {
      RcSgCom.mngPcLog += LRcScdsp.SG_END;
      RcSgCom.rcSGManageLogButton();
      RcSgCom.rcSGManageLogSend(SgDsp.REG_LOG);
      RcAssistMnt.rcAssistSend(23040);
    }
  }

  /// 関連tprxソース: rcinoutdsp.c - rcChk_InOut_EntryData
  static bool rcChkInOutEntryData() {
    return(inOut.InOutBtn[InoutDisp.INOUT_Y10000].Count != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_Y5000].Count  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_Y2000].Count  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_Y1000].Count  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_Y500].Count   != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_Y100].Count   != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_Y50].Count    != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_Y10].Count    != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_Y5].Count     != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_Y1].Count     != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA1].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA2].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA3].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA4].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA5].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA6].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA7].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA8].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA9].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA10].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA11].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA12].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA13].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA14].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA15].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA16].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA17].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA18].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA19].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA20].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA21].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA22].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA23].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA24].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA25].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA26].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA27].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA28].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA29].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHA30].Amount != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHK1].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHK2].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHK3].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHK4].Amount  != 0 ||
           inOut.InOutBtn[InoutDisp.INOUT_CHK5].Amount  != 0 );
  }

  /// 処理概要：金種ボタンを指定し、現金／会計／品券タイプを返す
  /// 関連tprxソース: rcinoutdsp.h - rcCheck_InOut_BtnType
  static int rcCheckInOutBtnType(int i) {
    return inOutBtnInf[i].btnType;
  }

  /// 処理概要：InOutBtnの位置(btn_no)を指定し、InOutBtnInfの位置を返す
  /// 関連tprxソース: rcinoutdsp.h - rcInOutBtnInf_PosiChk
  static int rcInOutBtnInfPosiChk(int btnNo) {
    int i;
    for (i = 0; i < InoutDisp.INOUT_DIF_MAX; i++) {
      if (inOutBtnInf[i].btnNo == btnNo) {
        break;
      }
    }
    return i;
  }

  /// 関連tprxソース: rcinoutdsp.h - rcAcrAcb_MakeShtData
  static Future<void> rcAcrAcbMakeShtData() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    inOut.InOutBtn[InoutDisp.INOUT_Y10000].Count =
        cMem.coinData.holder.bill10000 + cMem.coinData.overflow.bill10000;
    inOut.InOutBtn[InoutDisp.INOUT_Y5000].Count =
        cMem.coinData.holder.bill5000 + cMem.coinData.overflow.bill5000;
    inOut.InOutBtn[InoutDisp.INOUT_Y2000].Count =
        cMem.coinData.holder.bill2000 + cMem.coinData.overflow.bill2000;
    inOut.InOutBtn[InoutDisp.INOUT_Y1000].Count =
        cMem.coinData.holder.bill1000 + cMem.coinData.overflow.bill1000;
    inOut.InOutBtn[InoutDisp.INOUT_Y500].Count =
        cMem.coinData.holder.coin500 + cMem.coinData.overflow.coin500;
    inOut.InOutBtn[InoutDisp.INOUT_Y100].Count =
        cMem.coinData.holder.coin100 + cMem.coinData.overflow.coin100;
    inOut.InOutBtn[InoutDisp.INOUT_Y50].Count =
        cMem.coinData.holder.coin50 + cMem.coinData.overflow.coin50;
    inOut.InOutBtn[InoutDisp.INOUT_Y10].Count =
        cMem.coinData.holder.coin10 + cMem.coinData.overflow.coin10;
    inOut.InOutBtn[InoutDisp.INOUT_Y5].Count =
        cMem.coinData.holder.coin5 + cMem.coinData.overflow.coin5;
    inOut.InOutBtn[InoutDisp.INOUT_Y1].Count =
        cMem.coinData.holder.coin1 + cMem.coinData.overflow.coin1;

    if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
        cBuf.iniMacInfo.acx_flg.chgdrw_loan_tran == 0) {
      inOut.InOutBtn[InoutDisp.INOUT_Y500].Count +=
          cMem.coinData.drawData.coin500;
      inOut.InOutBtn[InoutDisp.INOUT_Y100].Count +=
          cMem.coinData.drawData.coin100;
      inOut.InOutBtn[InoutDisp.INOUT_Y50].Count +=
          cMem.coinData.drawData.coin50;
      inOut.InOutBtn[InoutDisp.INOUT_Y10].Count +=
          cMem.coinData.drawData.coin10;
      inOut.InOutBtn[InoutDisp.INOUT_Y5].Count += cMem.coinData.drawData.coin5;
      inOut.InOutBtn[InoutDisp.INOUT_Y1].Count += cMem.coinData.drawData.coin1;
    }
  }

  /// flg 1: セット
  /// 関連tprxソース: rcinoutdsp.h - rcNoStaffGetSet
  static int rcNoStaffGetSet(int flg, int data) {
    if (flg != 0) {
      autoNoStaff = data;
    }

    return autoNoStaff;
  }

  /// 関連tprxソース: rcinoutdsp.h - rcInOut_CloseLine_Update
  static Future<void> rcInOutCloseLineUpdate(String func) async {
    String log = '';
    int cnt = 0;
    int i = 0;

    log = "$func: Call rcInOut_CloseLine_Update(${inOutClose.updateFlg})";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    //締め精算終了の区切り線(ope_mode_flg)を実績上げ
    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); /* Total Reicept Clear */
    if (!RcSysChk.rcTROpeModeChk()) {
      //訓練であればope_mode_flg変更しない->実在高がサマられてしまうので訓練では精算処理としない
      RegsMem().tHeader.ope_mode_flg = OpeModeFlagList.OPE_MODE_CLOSE_LINE;
    }
    RegsMem().tHeader.inout_flg = RcInOut.TTLLOG_ACKPICK_FLAG; /* 実在高 */
    RegsMem().tHeader.prn_typ =
        PrnterControlTypeIdx.TYPE_CLOSE_PICK_ENDLOG.index;
    if (AplLibAuto.getForceClsRunMode(await RcSysChk.getTid()) != 0) {
      await rcMakeAmtData();
      RegsMem().tTtllog.t100200[0].actDrwAmt = amtPrc;
      if (RegsMem().tTtllog.t100200[0].actDrwAmt != 0) {
        RegsMem().tTtllog.t100200[0].kyCd = FuncKey.KY_CASH.keyId;
      }

      for (i = InoutDisp.INOUT_CHA1; i < InoutDisp.INOUT_DIF_MAX; i++) {
        if (inOut.InOutBtn[i].Count != 0) {
          switch (i) {
            case InoutDisp.INOUT_CHA1:
            case InoutDisp.INOUT_CHA2:
            case InoutDisp.INOUT_CHA3:
            case InoutDisp.INOUT_CHA4:
            case InoutDisp.INOUT_CHA5:
            case InoutDisp.INOUT_CHA6:
            case InoutDisp.INOUT_CHA7:
            case InoutDisp.INOUT_CHA8:
            case InoutDisp.INOUT_CHA9:
            case InoutDisp.INOUT_CHA10:
              cnt = (i - InoutDisp.INOUT_CHA1);
              RegsMem().tTtllog.t100200[AmtKind.amtCha1.index + cnt].actDrwAmt =
                  inOut.InOutBtn[i].Count;
              inOut.InOutBtn[i].Amount = inOut.InOutBtn[i].Count = 0;
              inOut.InOutBtn[i].minus_flg = 0;
              RegsMem().tTtllog.t100200[AmtKind.amtCha1.index + cnt].kyCd =
                  FuncKey.KY_CHA1.keyId + cnt;
              break;
            case InoutDisp.INOUT_CHK1:
            case InoutDisp.INOUT_CHK2:
            case InoutDisp.INOUT_CHK3:
            case InoutDisp.INOUT_CHK4:
            case InoutDisp.INOUT_CHK5:
              cnt = (i - InoutDisp.INOUT_CHK1);
              RegsMem().tTtllog.t100200[AmtKind.amtCha1.index + cnt].actDrwAmt =
                  inOut.InOutBtn[i].Count;
              inOut.InOutBtn[i].Amount = inOut.InOutBtn[i].Count = 0;
              inOut.InOutBtn[i].minus_flg = 0;
              RegsMem().tTtllog.t100200[AmtKind.amtCha1.index + cnt].kyCd =
                  FuncKey.KY_CHK1.keyId + cnt;
              break;
            case InoutDisp.INOUT_CHA11:
            case InoutDisp.INOUT_CHA12:
            case InoutDisp.INOUT_CHA13:
            case InoutDisp.INOUT_CHA14:
            case InoutDisp.INOUT_CHA15:
            case InoutDisp.INOUT_CHA16:
            case InoutDisp.INOUT_CHA17:
            case InoutDisp.INOUT_CHA18:
            case InoutDisp.INOUT_CHA19:
            case InoutDisp.INOUT_CHA20:
            case InoutDisp.INOUT_CHA21:
            case InoutDisp.INOUT_CHA22:
            case InoutDisp.INOUT_CHA23:
            case InoutDisp.INOUT_CHA24:
            case InoutDisp.INOUT_CHA25:
            case InoutDisp.INOUT_CHA26:
            case InoutDisp.INOUT_CHA27:
            case InoutDisp.INOUT_CHA28:
            case InoutDisp.INOUT_CHA29:
            case InoutDisp.INOUT_CHA30:
              cnt = (i - InoutDisp.INOUT_CHA11);
              RegsMem()
                  .tTtllog
                  .t100200[AmtKind.amtCha11.index + cnt]
                  .actDrwAmt = inOut.InOutBtn[i].Count;
              inOut.InOutBtn[i].Amount = inOut.InOutBtn[i].Count = 0;
              inOut.InOutBtn[i].minus_flg = 0;
              RegsMem().tTtllog.t100200[AmtKind.amtCha11.index + cnt].kyCd =
                  FuncKey.KY_CHA11.keyId + cnt;
              break;
            default:
              break;
          }
        }
      }
    } else {
      RegsMem().tTtllog.t100200[0] = inOutClose.drawChk[0];
      RegsMem().tTtllog.t100210[0] = inOutClose.divData[0];
    }

    RegsMem().tTtllog.t100001Sts.amtCnt = AmtKind.amtMax.index;
    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();
    RcIfEvent.rcSendUpdate();

    await RcRecno.rcIncRctJnlNo(false);
    await RcSet.rcClearDataReg();
    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); /* Total Reicept Clear */
    Rxregstr.rxSetTranOpeMode();
  }

  /// 関連tprxソース: rcinoutdsp.h - rcMakeAmtData
  static Future<void> rcMakeAmtData() async {
    int tuples = 0;
    int chkrStartNo = 0;
    int cshrStartNo = 0;
    int startNo = 0;
    int recNo = 0;
    TprMID aid;
    String sql = '';
    String compareSql = '';
    String log = '';
    String keyChaBuf = '';
    String keyChkBuf = '';
    String tmpBuf = '';
    Result? res;
    DbManipulationPs db = DbManipulationPs();
    int web28Type = 0;
    int i = 0;
    int btnType = 0;
    int cnt = 0;
    String opeModeBuf = '';
    String sumCashBuf = '';

    String headerName = ''; // SQLに使用するテーブル名(c_header_log系)
    String dataName = ''; // SQLに使用するテーブル名(c_data_log系)
    String sqlMacNo = ''; // SQLに使用するMAC_NO
    String callFunc = 'rcMakeAmtData';

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    SysJsonFile sysJson = pCom.iniSys;

    aid = await RcFlrd.rcGetProcessID();
    recNo = await Counter.competitionGetRcptNo(await RcSysChk.getTid());

    web28Type = CmCksys.cmWeb2800Type(sysJson);

    //現在のreceipt_noから在高の抽出範囲（従業員精算もしくは従業員オープン）を求める
    if (pCom.dbTrm.drawCashChk == 1) {
      //比較対象となる在高合計
      // クローズレポート

      sql =
      "select chkr_start_no, cshr_start_no from c_staffopen_mst where mac_no='${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}';\n";

      try {
        res = await db.dbCon.execute(sql);
      } catch (e) {
        //Cソース「db_PQexec() == NULL」時に相当
        return;
      }

      tuples = res.length;

      if (tuples == 0) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcMakeAmtData() start_no nothing"); //オープンしていない?
        return;
      }

      Map<String, dynamic> data = res.elementAt(0).toColumnMap();
      chkrStartNo = data["chkr_start_no"] ?? 0;
      cshrStartNo = data["cshr_start_no"] ?? 0;

      if (await RcSysChk.rcCheckQCJCChecker()) {
        startNo = chkrStartNo;
      } else {
        startNo = cshrStartNo;
      }

      log =
      "rcMakeAmtData() : StaffCloseRept start_no($startNo) receipt_no($recNo)\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      if (recNo < startNo) {
        //一周している
        compareSql =
        " and (receipt_no >= '$startNo' or  receipt_no <= '$recNo') ";
      } else {
        compareSql =
        " and (receipt_no >= '$startNo' and receipt_no <= '$recNo') ";
      }
    } else {
      //従業員精算が行われている->比較対象は従業員精算レポート以降とする
      sql =
      "select receipt_no from c_header_log where mac_no='${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}' and ope_mode_flg ='${OpeModeFlagList.OPE_MODE_CLOSE_LINE}' order by endtime desc LIMIT 1;\n";

      try {
        res = await db.dbCon.execute(sql);
      } catch (e) {
        //Cソース「db_PQexec() == NULL」時に相当
        return;
      }

      tuples = res.length;
      if (tuples > 0) {
        //従業員精算の実績有り
        Map<String, dynamic> data = res.elementAt(0).toColumnMap();
        startNo = data["receipt_no"] ?? 0;

        log =
        "rcMakeAmtData() : ClosePick start_no($startNo) receipt_no($recNo)\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        if (recNo < startNo) {
          //一周している
          compareSql =
          "and ( receipt_no >= '$startNo' or  receipt_no <= '$recNo') ";
        } else {
          compareSql =
          " and (receipt_no >= '$startNo' and receipt_no <= '$recNo') ";
        }
      } else {
        //従業員精算の実績無し
        startNo = 0;

        log =
        "rcMakeAmtData() : ClosePick start_no($startNo)->NoData receipt_no($recNo)\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        compareSql = '';
      }
    }

    log = "rcMakeAmtData() : compare_sql[$compareSql]\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    //キーコードbuf作成
    if (pCom.dbTrm.kyChaDivideKoptCrdt != 0) {
      for (i = 0; i < InoutDisp.INOUT_DIF_MAX; i++) {
        btnType = rcCheckInOutBtnType(i);
        switch (btnType) {
          case InoutPayType.INOUT_TYPE_CHA:
            if (keyChaBuf.isNotEmpty) {
              tmpBuf = ", ${inOutBtnInf[i].fncCd}";
            } else {
              tmpBuf = "${inOutBtnInf[i].fncCd}";
            }
            keyChaBuf = keyChaBuf + tmpBuf;
            break;
          case InoutPayType.INOUT_TYPE_CHK:
            if (keyChkBuf.isNotEmpty) {
              tmpBuf = ", ${inOutBtnInf[i].fncCd}";
            } else {
              tmpBuf = "${inOutBtnInf[i].fncCd}";
            }
            keyChkBuf = keyChkBuf + tmpBuf;
            break;
          default:
            break;
        }
      }

      //キーコードセット完了後一つもキーコードが無い場合はsqlエラーとなるので0セット
      if (keyChaBuf.isEmpty) {
        keyChaBuf = "0";
      }

      if (keyChkBuf.isEmpty) {
        keyChkBuf = "0";
      }

      log = "$callFunc : KY_CHA LIST[$keyChaBuf]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      log = "$callFunc : KY_CHK LIST[$keyChkBuf]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    } else {
      keyChaBuf = sprintf(
          "'%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i'",
          [
            FuncKey.KY_CHA1.keyId,
            FuncKey.KY_CHA2.keyId,
            FuncKey.KY_CHA3.keyId,
            FuncKey.KY_CHA4.keyId,
            FuncKey.KY_CHA5.keyId,
            FuncKey.KY_CHA6.keyId,
            FuncKey.KY_CHA7.keyId,
            FuncKey.KY_CHA8.keyId,
            FuncKey.KY_CHA9.keyId,
            FuncKey.KY_CHA10.keyId,
            FuncKey.KY_CHA11.keyId,
            FuncKey.KY_CHA12.keyId,
            FuncKey.KY_CHA13.keyId,
            FuncKey.KY_CHA14.keyId,
            FuncKey.KY_CHA15.keyId,
            FuncKey.KY_CHA16.keyId,
            FuncKey.KY_CHA17.keyId,
            FuncKey.KY_CHA18.keyId,
            FuncKey.KY_CHA19.keyId,
            FuncKey.KY_CHA20.keyId,
            FuncKey.KY_CHA21.keyId,
            FuncKey.KY_CHA22.keyId,
            FuncKey.KY_CHA23.keyId,
            FuncKey.KY_CHA24.keyId,
            FuncKey.KY_CHA25.keyId,
            FuncKey.KY_CHA26.keyId,
            FuncKey.KY_CHA27.keyId,
            FuncKey.KY_CHA28.keyId,
            FuncKey.KY_CHA29.keyId,
            FuncKey.KY_CHA30.keyId
          ]);
      keyChkBuf = sprintf("'%i', '%i', '%i', '%i', '%i'", [
        FuncKey.KY_CHK1.keyId,
        FuncKey.KY_CHK2.keyId,
        FuncKey.KY_CHK3.keyId,
        FuncKey.KY_CHK4.keyId,
        FuncKey.KY_CHK5.keyId
      ]);
    }

    rcMakeAmtDtlClr();

    // SQLで使用するテーブル名を指定
    (headerName, dataName) = getResultsHeaderLogTableName(
        headerName, dataName); // RF様仕様の場合には本日のテーブル名、標準の場合は固定テーブル名を返す
    // SQLで使用するMAC_NOを指定
    sqlMacNo = await getMacNo(); // RF様仕様の場合はmac_noのSQL文は空白、標準の場合はmac_noのSQL分を返す
    for (cnt = 0; cnt < 2; cnt++) {
      // オペモード
      switch (cnt) {
        case 0: // 登録、訂正
          opeModeBuf =
          "ope_mode_flg in ('${OpeModeFlagList.OPE_MODE_REG}', '${OpeModeFlagList.OPE_MODE_VOID}')";
          sumCashBuf =
          "sum(case when data.func_cd='100200' and data.n_data1='${FuncKey.KY_CASH.keyId}' then data.n_data5 else 0 end)::integer as $ALL_CASH, ";
          break;
        default: // お会計券(登録、訂正)
        // db_PQgetvalue(ALL_CASH)が実行されるので念のため条件に関わらず、bufを作成
          sumCashBuf =
          "sum(case when data.func_cd='100200' and data.n_data1='${FuncKey.KY_CASH.keyId}' then 0 else 0 end)::integer as $ALL_CASH, "; //お会計券実績の現金はサマラない (釣りあり品券のお釣りは精算機->登録機側で過不足となるから 2022/02/04三宮さんから坂本さん追加仕様の修正依頼)
          if (inOut.fncCode == FuncKey.KY_DRWCHK.keyId // 差異チェック
              &&
              RcRegs.rcInfoMem.rcRecog.recogReceiptQrSystem != 0 // 登録機
              &&
              (await CmCksys.cmYunaitoHdSystem() != 0 // ユナイトホールディングス様仕様
                  ||
                  pCom.dbKfnc[inOut.fncCode].opt.drwChk.drwchkSpDrawAmt != 0)) {
            // キーオプション
            opeModeBuf =
            "ope_mode_flg in ('${OpeModeFlagList.OPE_MODE_REG_SP_TCKT}', '${OpeModeFlagList.OPE_MODE_VOID_SP_TCKT}')";
          } else {
            continue; // お会計券実績は対象外
          }
          break;
      }

      log =
      "$callFunc : MAC_NO[${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}]  OPE_MODE$opeModeBuf]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      //回収(105100)の精算フラグ(n_data14=1)は理論在高から除外すること (従業員精算処理)
      sql = sprintf(
          "select "
              "%s "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and header.inout_flg = 2 and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and header.inout_flg = 2 and data.n_data1 in (%s) then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and header.inout_flg = 2 and data.n_data1 in (%s) then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and header.inout_flg = 3 and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and header.inout_flg = 3 and data.n_data1 in (%s) then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and header.inout_flg = 3 and data.n_data1 in (%s) then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and header.inout_flg = 4 and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and header.inout_flg = 4 and data.n_data1 in (%s) then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and header.inout_flg = 4 and data.n_data1 in (%s) then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and header.inout_flg = 5 and data.n_data1='%d' then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and header.inout_flg = 5 and data.n_data1 in (%s) then data.n_data5 else 0 end)::integer as %s, "
              "sum(case when data.func_cd='100200' and header.inout_flg = 5 and data.n_data1 in (%s) then data.n_data5 else 0 end)::integer as %s "
              "from %s as data left outer join %s as header on (data.serial_no = header.serial_no)"
              "where "
              "data.serial_no in (select header1.serial_no from %s as header1 where header1.serial_no not in "
              "(select case when data2.func_cd='105100' and data2.n_data14='1' then header2.serial_no else 0 end from %s as header2 left outer join %s as data2 on (data2.serial_no = header2.serial_no) where comp_cd='%ld' and stre_cd='%ld' %s and %s) "
              "and comp_cd='%ld' and stre_cd='%ld' %s and %s %s);\n",
          [
            sumCashBuf,
            FuncKey.KY_CHA1.keyId,
            ALL_CHA1,
            FuncKey.KY_CHA2.keyId,
            ALL_CHA2,
            FuncKey.KY_CHA3.keyId,
            ALL_CHA3,
            FuncKey.KY_CHA4.keyId,
            ALL_CHA4,
            FuncKey.KY_CHA5.keyId,
            ALL_CHA5,
            FuncKey.KY_CHA6.keyId,
            ALL_CHA6,
            FuncKey.KY_CHA7.keyId,
            ALL_CHA7,
            FuncKey.KY_CHA8.keyId,
            ALL_CHA8,
            FuncKey.KY_CHA9.keyId,
            ALL_CHA9,
            FuncKey.KY_CHA10.keyId,
            ALL_CHA10,
            FuncKey.KY_CHA11.keyId,
            ALL_CHA11,
            FuncKey.KY_CHA12.keyId,
            ALL_CHA12,
            FuncKey.KY_CHA13.keyId,
            ALL_CHA13,
            FuncKey.KY_CHA14.keyId,
            ALL_CHA14,
            FuncKey.KY_CHA15.keyId,
            ALL_CHA15,
            FuncKey.KY_CHA16.keyId,
            ALL_CHA16,
            FuncKey.KY_CHA17.keyId,
            ALL_CHA17,
            FuncKey.KY_CHA18.keyId,
            ALL_CHA18,
            FuncKey.KY_CHA19.keyId,
            ALL_CHA19,
            FuncKey.KY_CHA20.keyId,
            ALL_CHA20,
            FuncKey.KY_CHA21.keyId,
            ALL_CHA21,
            FuncKey.KY_CHA22.keyId,
            ALL_CHA22,
            FuncKey.KY_CHA23.keyId,
            ALL_CHA23,
            FuncKey.KY_CHA24.keyId,
            ALL_CHA24,
            FuncKey.KY_CHA25.keyId,
            ALL_CHA25,
            FuncKey.KY_CHA26.keyId,
            ALL_CHA26,
            FuncKey.KY_CHA27.keyId,
            ALL_CHA27,
            FuncKey.KY_CHA28.keyId,
            ALL_CHA28,
            FuncKey.KY_CHA29.keyId,
            ALL_CHA29,
            FuncKey.KY_CHA30.keyId,
            ALL_CHA30,
            FuncKey.KY_CHK1.keyId,
            ALL_CHK1,
            FuncKey.KY_CHK2.keyId,
            ALL_CHK2,
            FuncKey.KY_CHK3.keyId,
            ALL_CHK3,
            FuncKey.KY_CHK4.keyId,
            ALL_CHK4,
            FuncKey.KY_CHK5.keyId,
            ALL_CHK5,
            FuncKey.KY_CASH.keyId,
            LOAN_CASH,
            keyChaBuf,
            LOAN_CHA,
            keyChkBuf,
            LOAN_CHK,
            FuncKey.KY_CASH.keyId,
            CIN_CASH,
            keyChaBuf,
            CIN_CHA,
            keyChkBuf,
            CIN_CHK,
            FuncKey.KY_CASH.keyId,
            OUT_CASH,
            keyChaBuf,
            OUT_CHA,
            keyChkBuf,
            OUT_CHK,
            FuncKey.KY_CASH.keyId,
            PICK_CASH,
            keyChaBuf,
            PICK_CHA,
            keyChkBuf,
            PICK_CHK,
            dataName,
            headerName,
            headerName,
            headerName,
            dataName,
            pCom.dbRegCtrl.compCd,
            pCom.dbRegCtrl.streCd,
            sqlMacNo,
            opeModeBuf,
            pCom.dbRegCtrl.compCd,
            pCom.dbRegCtrl.streCd,
            sqlMacNo,
            opeModeBuf,
            compareSql
          ]);

      await rcMakeAmtDtlData(sql);
    }
  }

  /// 各在高バッファクリア
  /// 関連tprxソース: rcinoutdsp.h - rcMakeAmtDtlClr
  static int rcMakeAmtDtlClr() {
    int i = 0;
    int sumPtr = 0;

    // クリアをrcMakeAmtDtlData()から移動した
    inOut.Pdata.DrwAmt_Cash = 0;
    inOut.Pdata.DrwAmt_Cha = 0;
    inOut.Pdata.DrwAmt_Chk = 0;

    inOut.Pdata.Loan_Cash = 0;
    inOut.Pdata.Loan_Cha = 0;
    inOut.Pdata.Loan_Chk = 0;
    inOut.Pdata.Cin_Cash = 0;
    inOut.Pdata.Cin_Cha = 0;
    inOut.Pdata.Cin_Chk = 0;
    inOut.Pdata.Out_Cash = 0;
    inOut.Pdata.Out_Cha = 0;
    inOut.Pdata.Out_Chk = 0;
    inOut.Pdata.Pick_Cash = 0;
    inOut.Pdata.Pick_Cha = 0;
    inOut.Pdata.Pick_Chk = 0;

    inOut.Pdata.DrwAmt_Total = 0;

    // 理論現金在高クリア
    sumCash = 0;

    // 理論会計在高クリア
    for (i = InoutDisp.INOUT_CHA1; i <= InoutDisp.INOUT_CHA30; i++) {
      switch (i) {
        case InoutDisp.INOUT_CHA1:
          sumPtr = sumCha1;
          break;
        case InoutDisp.INOUT_CHA2:
          sumPtr = sumCha2;
          break;
        case InoutDisp.INOUT_CHA3:
          sumPtr = sumCha3;
          break;
        case InoutDisp.INOUT_CHA4:
          sumPtr = sumCha4;
          break;
        case InoutDisp.INOUT_CHA5:
          sumPtr = sumCha5;
          break;
        case InoutDisp.INOUT_CHA6:
          sumPtr = sumCha6;
          break;
        case InoutDisp.INOUT_CHA7:
          sumPtr = sumCha7;
          break;
        case InoutDisp.INOUT_CHA8:
          sumPtr = sumCha8;
          break;
        case InoutDisp.INOUT_CHA9:
          sumPtr = sumCha9;
          break;
        case InoutDisp.INOUT_CHA10:
          sumPtr = sumCha10;
          break;
        case InoutDisp.INOUT_CHA11:
          sumPtr = sumCha11;
          break;
        case InoutDisp.INOUT_CHA12:
          sumPtr = sumCha12;
          break;
        case InoutDisp.INOUT_CHA13:
          sumPtr = sumCha13;
          break;
        case InoutDisp.INOUT_CHA14:
          sumPtr = sumCha14;
          break;
        case InoutDisp.INOUT_CHA15:
          sumPtr = sumCha15;
          break;
        case InoutDisp.INOUT_CHA16:
          sumPtr = sumCha16;
          break;
        case InoutDisp.INOUT_CHA17:
          sumPtr = sumCha17;
          break;
        case InoutDisp.INOUT_CHA18:
          sumPtr = sumCha18;
          break;
        case InoutDisp.INOUT_CHA19:
          sumPtr = sumCha19;
          break;
        case InoutDisp.INOUT_CHA20:
          sumPtr = sumCha20;
          break;
        case InoutDisp.INOUT_CHA21:
          sumPtr = sumCha21;
          break;
        case InoutDisp.INOUT_CHA22:
          sumPtr = sumCha22;
          break;
        case InoutDisp.INOUT_CHA23:
          sumPtr = sumCha23;
          break;
        case InoutDisp.INOUT_CHA24:
          sumPtr = sumCha24;
          break;
        case InoutDisp.INOUT_CHA25:
          sumPtr = sumCha25;
          break;
        case InoutDisp.INOUT_CHA26:
          sumPtr = sumCha26;
          break;
        case InoutDisp.INOUT_CHA27:
          sumPtr = sumCha27;
          break;
        case InoutDisp.INOUT_CHA28:
          sumPtr = sumCha28;
          break;
        case InoutDisp.INOUT_CHA29:
          sumPtr = sumCha29;
          break;
        case InoutDisp.INOUT_CHA30:
          sumPtr = sumCha30;
          break;
        default:
          break;
      }
      sumPtr = 0;
    }

    // 理論品検在高クリア
    for (i = InoutDisp.INOUT_CHK1; i <= InoutDisp.INOUT_CHK5; i++) {
      switch (i) {
        case InoutDisp.INOUT_CHK1:
          sumPtr = sumChk1;
          break;
        case InoutDisp.INOUT_CHK2:
          sumPtr = sumChk2;
          break;
        case InoutDisp.INOUT_CHK3:
          sumPtr = sumChk3;
          break;
        case InoutDisp.INOUT_CHK4:
          sumPtr = sumChk4;
          break;
        case InoutDisp.INOUT_CHK5:
          sumPtr = sumChk5;
          break;
        default:
          break;
      }
      sumPtr = 0;
    }
    return sumPtr;
  }

  /// 機能概要     : 実績ヘッダログ、データログ名取得処理
  /// パラメータ  : char *header_name
  ///                char *data_name
  /// 戻り値       :  なし
  /// 関連tprxソース: rcinoutdsp.h - GetResultsHeaderLogTableName
  static (String, String) getResultsHeaderLogTableName(String headerName, String dataName) {
    headerName = "${headerName}c_header_log"; // 標準の場合のヘッダファイル名を設定
    dataName = "${dataName}c_data_log"; // 標準の場合のデータファイル名を設定
    return (headerName, dataName);
  }

  /// 機能概要     : MacNo取得処理 RF様仕様の場合には""、標準の場合はMacNo(SQL文)
  /// 呼び出し方法 : static void GetMacNo (char *Sql_mac_no);
  /// パラメータ  : char *Sql_mac_no
  /// 戻り値       :  なし
  /// 関連tprxソース: rcinoutdsp.h - GetMacNo
  static Future<String> getMacNo() async {
    return " and mac_no='${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid()))}'";
  }

  /// 理論在高算出
  /// 関連tprxソース: rcinoutdsp.h - rcMakeAmtDtlData
  static Future<void> rcMakeAmtDtlData(String sql) async {
    TprMID aid;
    Result? res;
    DbManipulationPs db = DbManipulationPs();
    String log = '';
    String data = '';
    String koptBuf = '';
    int i = 0;
    int nTuples = 0;
    int lData = 0;
    int fncCd = 0;
    int btnNo = 0;
    int koptData = 0;
    int forceFlg = 0;
    int web28Type = 0;
    int btnType = 0;
    String? sumLabel = '';
    int? sumPtr = 0;
    int reservePrc = 0;
    String callFunc = 'rcMakeAmtDtlData';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    SysJsonFile sysJson = pCom.iniSys;

    web28Type = CmCksys.cmWeb2800Type(sysJson);

    aid = await RcFlrd.rcGetProcessID();
    if (sql.isEmpty) {
      log = "rcMakeAmtDtlData Error[$sql]\n";
      TprLog().logAdd(aid, LogLevelDefine.error, log);
      return;
    }

    try {
      res = await db.dbCon.execute(sql);
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      TprLog().logAdd(
          aid, LogLevelDefine.error, "rcMakeAmtDtlData get data Error!");
      return;
    }

    nTuples = res.length;

    if (nTuples == 0) {
      TprLog().logAdd(aid, LogLevelDefine.normal, "rcMakeAmtDtlData no data");
      return;
    }

    log = "rcMakeAmtDtlData";
    TprLog().logAdd(aid, LogLevelDefine.normal, log);
    amtPrc = 0;
    forceFlg = AplLibAuto.getForceClsRunMode(await RcSysChk.getTid());

    //現金
    log = "   CASH  ";

    Map<String, dynamic> sqlData = res.elementAt(0).toColumnMap();

    sumCash += int.tryParse(sqlData[ALL_CASH]) ?? 0;
    data = "[$sumCash]";
    log = log + data;

    //理論現金在高
    inOut.Pdata.DrwAmt_Cash = sumCash;
    if (await rcInoutUC251Chk() != 0) {
      //補充基準値から残置金額を計算
      reservePrc = rcInOutReservPrcCalc();
      inOut.Pdata.DrwAmt_Cash += reservePrc;

      data = " + RESERV_PRC[$reservePrc]  = [${inOut.Pdata.DrwAmt_Cash}]";
      log = log + data;
    }

    TprLog().logAdd(aid, LogLevelDefine.normal, log);
    inOut.Pdata.DrwAmt_Cha = 0;
    inOut.Pdata.DrwAmt_Chk = 0;

    //会計
    sumPtr = null;
    sumLabel = null;
    for (i = InoutDisp.INOUT_CHA1; i <= InoutDisp.INOUT_CHA30; i++) {
      switch (i) {
        case InoutDisp.INOUT_CHA1:
          sumPtr = sumCha1;
          sumLabel = ALL_CHA1;
          break;
        case InoutDisp.INOUT_CHA2:
          sumPtr = sumCha2;
          sumLabel = ALL_CHA2;
          break;
        case InoutDisp.INOUT_CHA3:
          sumPtr = sumCha3;
          sumLabel = ALL_CHA3;
          break;
        case InoutDisp.INOUT_CHA4:
          sumPtr = sumCha4;
          sumLabel = ALL_CHA4;
          break;
        case InoutDisp.INOUT_CHA5:
          sumPtr = sumCha5;
          sumLabel = ALL_CHA5;
          break;
        case InoutDisp.INOUT_CHA6:
          sumPtr = sumCha6;
          sumLabel = ALL_CHA6;
          break;
        case InoutDisp.INOUT_CHA7:
          sumPtr = sumCha7;
          sumLabel = ALL_CHA7;
          break;
        case InoutDisp.INOUT_CHA8:
          sumPtr = sumCha8;
          sumLabel = ALL_CHA8;
          break;
        case InoutDisp.INOUT_CHA9:
          sumPtr = sumCha9;
          sumLabel = ALL_CHA9;
          break;
        case InoutDisp.INOUT_CHA10:
          sumPtr = sumCha10;
          sumLabel = ALL_CHA10;
          break;
        case InoutDisp.INOUT_CHA11:
          sumPtr = sumCha11;
          sumLabel = ALL_CHA11;
          break;
        case InoutDisp.INOUT_CHA12:
          sumPtr = sumCha12;
          sumLabel = ALL_CHA12;
          break;
        case InoutDisp.INOUT_CHA13:
          sumPtr = sumCha13;
          sumLabel = ALL_CHA13;
          break;
        case InoutDisp.INOUT_CHA14:
          sumPtr = sumCha14;
          sumLabel = ALL_CHA14;
          break;
        case InoutDisp.INOUT_CHA15:
          sumPtr = sumCha15;
          sumLabel = ALL_CHA15;
          break;
        case InoutDisp.INOUT_CHA16:
          sumPtr = sumCha16;
          sumLabel = ALL_CHA16;
          break;
        case InoutDisp.INOUT_CHA17:
          sumPtr = sumCha17;
          sumLabel = ALL_CHA17;
          break;
        case InoutDisp.INOUT_CHA18:
          sumPtr = sumCha18;
          sumLabel = ALL_CHA18;
          break;
        case InoutDisp.INOUT_CHA19:
          sumPtr = sumCha19;
          sumLabel = ALL_CHA19;
          break;
        case InoutDisp.INOUT_CHA20:
          sumPtr = sumCha20;
          sumLabel = ALL_CHA20;
          break;
        case InoutDisp.INOUT_CHA21:
          sumPtr = sumCha21;
          sumLabel = ALL_CHA21;
          break;
        case InoutDisp.INOUT_CHA22:
          sumPtr = sumCha22;
          sumLabel = ALL_CHA22;
          break;
        case InoutDisp.INOUT_CHA23:
          sumPtr = sumCha23;
          sumLabel = ALL_CHA23;
          break;
        case InoutDisp.INOUT_CHA24:
          sumPtr = sumCha24;
          sumLabel = ALL_CHA24;
          break;
        case InoutDisp.INOUT_CHA25:
          sumPtr = sumCha25;
          sumLabel = ALL_CHA25;
          break;
        case InoutDisp.INOUT_CHA26:
          sumPtr = sumCha26;
          sumLabel = ALL_CHA26;
          break;
        case InoutDisp.INOUT_CHA27:
          sumPtr = sumCha27;
          sumLabel = ALL_CHA27;
          break;
        case InoutDisp.INOUT_CHA28:
          sumPtr = sumCha28;
          sumLabel = ALL_CHA28;
          break;
        case InoutDisp.INOUT_CHA29:
          sumPtr = sumCha29;
          sumLabel = ALL_CHA29;
          break;
        case InoutDisp.INOUT_CHA30:
          sumPtr = sumCha30;
          sumLabel = ALL_CHA30;
          break;
        default:
          log = "$callFunc : ALL_CHA[${i + 1}] case default";
          TprLog().logAdd(aid, LogLevelDefine.normal, log);
          break;
      }

      if (i == InoutDisp.INOUT_CHA1) {
        log = "   CHA1  ";
      } else if (i == InoutDisp.INOUT_CHA11) {
        log = "   CHA11 ";
      } else if (i == InoutDisp.INOUT_CHA21) {
        log = "   CHA21 ";
      }
      if (sumPtr == null || sumLabel == null) {
        continue;
      }

      sumPtr += int.tryParse(sqlData[sumLabel]) ?? 0;
      data = "[$sumPtr]";
      log = log + data;
      if (i == InoutDisp.INOUT_CHA10 ||
          i == InoutDisp.INOUT_CHA20 ||
          i == InoutDisp.INOUT_CHA30) {
        TprLog().logAdd(aid, LogLevelDefine.normal, log);
      }

      //理論会計在高
      if (pCom.dbTrm.kyChaDivideKoptCrdt != 0) {
        //会計・品券をキーコードでなく、キーオプション「掛売登録する(会計)/しない(品券)」で区別
        btnType = rcCheckInOutBtnType(i);
        switch (btnType) {
          case InoutPayType.INOUT_TYPE_CHA:
            inOut.Pdata.DrwAmt_Cha += sumPtr;
            break;
          case InoutPayType.INOUT_TYPE_CHK:
            inOut.Pdata.DrwAmt_Chk += sumPtr;
            break;
          default:
            break;
        }
      } else {
        inOut.Pdata.DrwAmt_Cha += sumPtr;
      }
    }

    //品券
    sumPtr = null;
    sumLabel = null;
    for (i = InoutDisp.INOUT_CHK1; i <= InoutDisp.INOUT_CHK5; i++) {
      switch (i) {
        case InoutDisp.INOUT_CHK1:
          sumPtr = sumChk1;
          sumLabel = ALL_CHK1;
          break;
        case InoutDisp.INOUT_CHK2:
          sumPtr = sumChk2;
          sumLabel = ALL_CHK2;
          break;
        case InoutDisp.INOUT_CHK3:
          sumPtr = sumChk3;
          sumLabel = ALL_CHK3;
          break;
        case InoutDisp.INOUT_CHK4:
          sumPtr = sumChk4;
          sumLabel = ALL_CHK4;
          break;
        case InoutDisp.INOUT_CHK5:
          sumPtr = sumChk5;
          sumLabel = ALL_CHK5;
          break;
        default:
          log = "$callFunc : ALL_CHK[${i + 1}] case default";
          TprLog().logAdd(aid, LogLevelDefine.normal, log);
          break;
      }

      if (i == InoutDisp.INOUT_CHK1) {
        //最初にラベル
        log = "   CHK   ";
      }

      if (sumPtr == null || sumLabel == null) {
        continue;
      }

      sumPtr += int.tryParse(sqlData[sumLabel]) ?? 0;
      data = "[$sumPtr]";
      log = log + data;
      if (i == InoutDisp.INOUT_CHK5) {
        //最後に出力
        TprLog().logAdd(aid, LogLevelDefine.normal, log);
      }

      //理論品券在高
      if (pCom.dbTrm.kyChaDivideKoptCrdt != 0) {
        //会計・品券をキーコードでなく、キーオプション「掛売登録する(会計)/しない(品券)」で区別
        btnType = rcCheckInOutBtnType(i);
        switch (btnType) {
          case InoutPayType.INOUT_TYPE_CHA:
            inOut.Pdata.DrwAmt_Cha += sumPtr;
            break;
          case InoutPayType.INOUT_TYPE_CHK:
            inOut.Pdata.DrwAmt_Chk += sumPtr;
            break;
          default:
            break;
        }
      } else {
        inOut.Pdata.DrwAmt_Chk += sumPtr;
      }
    }

    // 複数回実行する為、加算型に変更
    inOut.Pdata.Loan_Cash += int.tryParse(sqlData[LOAN_CASH]) ?? 0;
    inOut.Pdata.Loan_Cha += int.tryParse(sqlData[LOAN_CHA]) ?? 0;
    inOut.Pdata.Loan_Chk += int.tryParse(sqlData[LOAN_CHK]) ?? 0;
    inOut.Pdata.Cin_Cash += int.tryParse(sqlData[CIN_CASH]) ?? 0;
    inOut.Pdata.Cin_Cha += int.tryParse(sqlData[CIN_CHA]) ?? 0;
    inOut.Pdata.Cin_Chk += int.tryParse(sqlData[CIN_CHK]) ?? 0;
    inOut.Pdata.Out_Cash += int.tryParse(sqlData[OUT_CASH]) ?? 0;
    inOut.Pdata.Out_Cha += int.tryParse(sqlData[OUT_CHA]) ?? 0;
    inOut.Pdata.Out_Chk += int.tryParse(sqlData[OUT_CHK]) ?? 0;
    inOut.Pdata.Pick_Cash += int.tryParse(sqlData[PICK_CASH]) ?? 0;
    inOut.Pdata.Pick_Cha += int.tryParse(sqlData[PICK_CHA]) ?? 0;
    inOut.Pdata.Pick_Chk += int.tryParse(sqlData[PICK_CHK]) ?? 0;

    if (inOut.fncCode == FuncKey.KY_DRWCHK_CASH.keyId || forceFlg != 0) {
      amtPrc = inOut.Pdata.DrwAmt_Cash;
    } else if (await rcInoutUC224096Chk() != 0) {
      amtPrc = inOut.Pdata.DrwAmt_Cash + sumChk3;
    } else {
      amtPrc = inOut.Pdata.DrwAmt_Cash //現金
          +
          inOut.Pdata.DrwAmt_Cha //会計
          +
          inOut.Pdata.DrwAmt_Chk; //品券
    }
    inOut.Pdata.DrwAmt_Total = amtPrc;
    rcMakeAmtDtlCalc();

    log = sprintf("DrwAmt[%9i] : cash[%9i] cha[%9i] chk[%9i] chk3[%9i]\n", [
      inOut.Pdata.DrwAmt_Total,
      inOut.Pdata.DrwAmt_Cash,
      inOut.Pdata.DrwAmt_Cha,
      inOut.Pdata.DrwAmt_Chk,
      sumChk3
    ]);
    TprLog().logAdd(aid, LogLevelDefine.normal, log);
    log = sprintf("Loan  [%9ld] : cash[%9ld] cha[%9ld] chk[%9ld]\n", [
      inOut.Pdata.Loan_Total,
      inOut.Pdata.Loan_Cash,
      inOut.Pdata.Loan_Cha,
      inOut.Pdata.Loan_Chk
    ]);
    TprLog().logAdd(aid, LogLevelDefine.normal, log);
    log = sprintf("Cin   [%9ld] : cash[%9ld] cha[%9ld] chk[%9ld]\n", [
      inOut.Pdata.Cin_Total,
      inOut.Pdata.Cin_Cash,
      inOut.Pdata.Cin_Cha,
      inOut.Pdata.Cin_Chk
    ]);
    TprLog().logAdd(aid, LogLevelDefine.normal, log);
    log = sprintf("Out   [%9ld] : cash[%9ld] cha[%9ld] chk[%9ld]\n", [
      inOut.Pdata.Out_Total,
      inOut.Pdata.Out_Cash,
      inOut.Pdata.Out_Cha,
      inOut.Pdata.Out_Chk
    ]);
    TprLog().logAdd(aid, LogLevelDefine.normal, log);
    log = sprintf("Pick  [%9ld] : cash[%9ld] cha[%9ld] chk[%9ld]\n", [
      inOut.Pdata.Pick_Total,
      inOut.Pdata.Pick_Cash,
      inOut.Pdata.Pick_Cha,
      inOut.Pdata.Pick_Chk
    ]);
    TprLog().logAdd(aid, LogLevelDefine.normal, log);
    log = sprintf("Oth   [%9ld] : cash[%9ld] cha[%9ld] chk[%9ld]\n", [
      inOut.Pdata.Oth_Total,
      inOut.Pdata.Oth_Cash,
      inOut.Pdata.Oth_Cha,
      inOut.Pdata.Oth_Chk
    ]);
    TprLog().logAdd(aid, LogLevelDefine.normal, log);

//	if((rc_Check_Inout_NonCash_Show())	//現外データ自動セット
//	    || (force_flg))
    if (true) {
      for (i = 0; i < InoutDisp.INOUT_DIF_MAX; i++) {
        btnNo = inOutBtnInf[i].btnNo;
        fncCd = inOutBtnInf[i].fncCd;

//			if(i < INOUT_DIF_CASH)
        if (rcCheckInOutCashBtn(i, Inout_Cash_Type.INOUT_CASH_ALL) != 0) {
          continue;
        }

        switch (btnNo) {
          case InoutDisp.INOUT_CHA1:
            lData = sumCha1;
            break;
          case InoutDisp.INOUT_CHA2:
            lData = sumCha2;
            break;
          case InoutDisp.INOUT_CHA3:
            lData = sumCha3;
            break;
          case InoutDisp.INOUT_CHA4:
            lData = sumCha4;
            break;
          case InoutDisp.INOUT_CHA5:
            lData = sumCha5;
            break;
          case InoutDisp.INOUT_CHA6:
            lData = sumCha6;
            break;
          case InoutDisp.INOUT_CHA7:
            lData = sumCha7;
            break;
          case InoutDisp.INOUT_CHA8:
            lData = sumCha8;
            break;
          case InoutDisp.INOUT_CHA9:
            lData = sumCha9;
            break;
          case InoutDisp.INOUT_CHA10:
            lData = sumCha10;
            break;
          case InoutDisp.INOUT_CHK1:
            lData = sumCha1;
            break;
          case InoutDisp.INOUT_CHK2:
            lData = sumCha2;
            break;
          case InoutDisp.INOUT_CHK3:
            lData = sumCha3;
            break;
          case InoutDisp.INOUT_CHK4:
            lData = sumCha4;
            break;
          case InoutDisp.INOUT_CHK5:
            lData = sumCha5;
            break;
          case InoutDisp.INOUT_CHA11:
            lData = sumCha11;
            break;
          case InoutDisp.INOUT_CHA12:
            lData = sumCha12;
            break;
          case InoutDisp.INOUT_CHA13:
            lData = sumCha13;
            break;
          case InoutDisp.INOUT_CHA14:
            lData = sumCha14;
            break;
          case InoutDisp.INOUT_CHA15:
            lData = sumCha15;
            break;
          case InoutDisp.INOUT_CHA16:
            lData = sumCha16;
            break;
          case InoutDisp.INOUT_CHA17:
            lData = sumCha17;
            break;
          case InoutDisp.INOUT_CHA18:
            lData = sumCha18;
            break;
          case InoutDisp.INOUT_CHA19:
            lData = sumCha19;
            break;
          case InoutDisp.INOUT_CHA20:
            lData = sumCha20;
            break;
          case InoutDisp.INOUT_CHA21:
            lData = sumCha21;
            break;
          case InoutDisp.INOUT_CHA22:
            lData = sumCha22;
            break;
          case InoutDisp.INOUT_CHA23:
            lData = sumCha23;
            break;
          case InoutDisp.INOUT_CHA24:
            lData = sumCha24;
            break;
          case InoutDisp.INOUT_CHA25:
            lData = sumCha25;
            break;
          case InoutDisp.INOUT_CHA26:
            lData = sumCha26;
            break;
          case InoutDisp.INOUT_CHA27:
            lData = sumCha27;
            break;
          case InoutDisp.INOUT_CHA28:
            lData = sumCha28;
            break;
          case InoutDisp.INOUT_CHA29:
            lData = sumCha29;
            break;
          case InoutDisp.INOUT_CHA30:
            lData = sumCha30;
            break;
          default:
            lData = 0;
            break;
        }
        koptData = Rxkoptcmncom.rxChkKoptCmnDrwChkAutoSetKeyOpt(pCom, fncCd);

        //キーオプション設定のログ作成
        data = "[$koptData]";
        koptBuf = koptBuf + data;
        if (btnNo == InoutDisp.INOUT_CHA10) {
          log = sprintf("   CHA1  auto_set : %s", koptBuf);
          TprLog().logAdd(aid, LogLevelDefine.normal, log);
          koptBuf = '';
        } else if (btnNo == InoutDisp.INOUT_CHA20) {
          log = sprintf("   CHA11 auto_set : %s", koptBuf);
          TprLog().logAdd(aid, LogLevelDefine.normal, log);
          koptBuf = '';
        } else if (btnNo == InoutDisp.INOUT_CHA30) {
          log = sprintf("   CHA21 auto_set : %s", koptBuf);
          TprLog().logAdd(aid, LogLevelDefine.normal, log);
          koptBuf = '';
        } else if (btnNo == InoutDisp.INOUT_CHK5) {
          log = sprintf("   CHK   auto_set : %s", koptBuf);
          TprLog().logAdd(aid, LogLevelDefine.normal, log);
          koptBuf = '';
        }

        //理論在高のセット条件でないものは0に変更
        if (await rcInoutUC224096Chk() != 0 &&
            i != InoutDisp.INOUT_CHK3 &&
            lData != 0) {
          data = "[$lData->0]";
          lData = 0;
        } else if ((lData < -9999999) || (lData > 99999999)) {
/* 8桁以上０にリセット*/
          data = "[$lData->0]";
          lData = 0;
        } else if (koptData == 0) {
/* 自動セットしない設定 */
          data = "[$lData->0]";
          lData = 0;
        } else {
          if (lData < 0) {
            inOut.InOutBtn[btnNo].minus_flg = 1;
          } else {
            inOut.InOutBtn[btnNo].minus_flg = 0; // ２周実行する対応でフラグクリアが必要となった
          }
          data = "[$lData]";
        }

        //理論在高をセット
        if (koptData != 0 || forceFlg != 0) {
          //理論在高のセット条件でないものは0に変更
          if (await rcInoutUC224096Chk() != 0 &&
              i != InoutDisp.INOUT_CHK3 &&
              lData != 0) {
            lData = 0;
          } else if ((lData < -9999999) || (lData > 99999999)) {
/* 8桁以上０にリセット */
            lData = 0;
          } else {
            if (lData < 0) {
              inOut.InOutBtn[btnNo].minus_flg = 1;
            } else {
              inOut.InOutBtn[btnNo].minus_flg = 0; // ２周実行する対応でフラグクリアが必要となった
            }
          }
//				snprintf(log, sizeof(log), "fnc_cd[%d] kopt_data[%d] pdata%s", fnc_cd, kopt_data, data);
          // 				TprLibLogWrite(aid, TPRLOG_NORMAL, 0, log);
          inOut.InOutBtn[btnNo].Amount = inOut.InOutBtn[btnNo].Count;
          inOut.InOutBtn[btnNo].Count = lData;
        }
      }
    }
  }

  /// 関連tprxソース: rcinoutdsp.h - rcInout_UC25_1_Chk
  static Future<int> rcInoutUC251Chk() async {
    // 14verからマージ
    int web28Type = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.dbTrm.includeDiffChkCash != 0) {
      if (await RcSysChk.rcCheckQCJCChecker()) {
        return 0;
      }

      SysJsonFile sysJson = cBuf.iniSys;
      web28Type = CmCksys.cmWeb2800Type(sysJson);
      if ((web28Type == CmSys.WEB28TYPE_SPP) ||
          (web28Type == CmSys.WEB28TYPE_SP3)) {
        if ((await CmCksys.cmPrinterTypeMain(0) == CmSys.TPRTSS &&
            await CmCksys.cm2ndPrinterType() == CmSys.TPRTSS) ||
            (await CmCksys.cmPrinterTypeMain(0) == CmSys.TPRTSS &&
                await CmCksys.cm2ndPrinterType() == CmSys.TPRTIM)) {
          return 1;
        } else {
          return 0;
        }
      }
      return 1;
    }
    return 0;
  }

  /// 補充基準値から残置金額を計算
  /// 関連tprxソース: rcinoutdsp.h - rcInOut_ReservPrc_Calc
  static int rcInOutReservPrcCalc() {
    String log = '';
    int reservePrc = 0;
    int reserveAcb5000 = 0;
    int reserveAcb2000 = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (inOut.fncCode != FuncKey.KY_DRWCHK.keyId) {
      return reservePrc;
    }

    if ((AcxCom.ifAcbSelect() & CoinChanger.ACB_20) != 0 ||
        (AcxCom.ifAcbSelect() & CoinChanger.ACB_50_X) != 0) {
      if (cBuf.dbTrm.bothAcrClrFlg == 1) {
        reserveAcb5000 = 0;
        reserveAcb2000 = cBuf.dbTrm.acxS2000;
      } else {
        reserveAcb5000 = cBuf.dbTrm.acxS5000;
        reserveAcb2000 = 0;
      }
    } else {
      reserveAcb5000 = cBuf.dbTrm.acxS5000;
      reserveAcb2000 = cBuf.dbTrm.acxS2000;
    }
    reservePrc = reserveAcb5000 * 5000 +
        reserveAcb2000 * 2000 +
        cBuf.dbTrm.acxS1000 * 1000 +
        cBuf.dbTrm.acxS500 * 500 +
        cBuf.dbTrm.acxS100 * 100 +
        cBuf.dbTrm.acxS50 * 50 +
        cBuf.dbTrm.acxS10 * 10 +
        cBuf.dbTrm.acxS5 * 5 +
        cBuf.dbTrm.acxS1 * 1;

    return reservePrc;
  }

  /// 関連tprxソース: rcinoutdsp.h - rcCheck_InOut_CashBtn
  static int rcCheckInOutCashBtn(int btnKind, int chkType) {
    switch (btnKind) {
      case InoutDisp.INOUT_Y10000:
      case InoutDisp.INOUT_Y5000:
      case InoutDisp.INOUT_Y2000:
      case InoutDisp.INOUT_Y1000:
        if (chkType == Inout_Cash_Type.INOUT_CASH_ALL || chkType == Inout_Cash_Type.INOUT_CASH_BILL) {
          return 1;
        } else {
          return 0;
        }

      case InoutDisp.INOUT_Y500:
      case InoutDisp.INOUT_Y100:
      case InoutDisp.INOUT_Y50:
      case InoutDisp.INOUT_Y10:
      case InoutDisp.INOUT_Y5:
      case InoutDisp.INOUT_Y1:
        if (chkType == Inout_Cash_Type.INOUT_CASH_ALL || chkType == Inout_Cash_Type.INOUT_CASH_COIN) {
          return 1;
        } else {
          return 0;
        }
      default:
        break;
    }
    return 0;
  }

  /// 関連tprxソース: rcinoutdsp.h - rcInout_UC22_4096_Chk
  static Future<int> rcInoutUC224096Chk() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    if (inOut.fncCode == FuncKey.KY_DRWCHK.keyId &&
        cBuf.dbTrm.chkDiffCashChk3 != 0 &&
        await CmCksys.cmReceiptQrSystem() == 0) {
      return 1;
    } else {
      return 0;
    }
  }

  /// 関連tprxソース: rcinoutdsp.h - rcMakeAmtDtlCalc
  static void rcMakeAmtDtlCalc() {
    inOut.Pdata.Loan_Total =
        inOut.Pdata.Loan_Cash + inOut.Pdata.Loan_Cha + inOut.Pdata.Loan_Chk;
    inOut.Pdata.Cin_Total =
        inOut.Pdata.Cin_Cash + inOut.Pdata.Cin_Cha + inOut.Pdata.Cin_Chk;
    inOut.Pdata.Out_Total =
        inOut.Pdata.Out_Cash + inOut.Pdata.Out_Cha + inOut.Pdata.Out_Chk;
    inOut.Pdata.Pick_Total =
        inOut.Pdata.Pick_Cash + inOut.Pdata.Pick_Cha + inOut.Pdata.Pick_Chk;

    inOut.Pdata.Oth_Cash = (inOut.Pdata.DrwAmt_Cash -
        inOut.Pdata.Loan_Cash -
        inOut.Pdata.Cin_Cash -
        inOut.Pdata.Out_Cash -
        inOut.Pdata.Pick_Cash);

    inOut.Pdata.Oth_Cha = (inOut.Pdata.DrwAmt_Cha -
        inOut.Pdata.Loan_Cha -
        inOut.Pdata.Cin_Cha -
        inOut.Pdata.Out_Cha -
        inOut.Pdata.Pick_Cha);

    inOut.Pdata.Oth_Chk = (inOut.Pdata.DrwAmt_Chk -
        inOut.Pdata.Loan_Chk -
        inOut.Pdata.Cin_Chk -
        inOut.Pdata.Out_Chk -
        inOut.Pdata.Pick_Chk);

    inOut.Pdata.Oth_Total =
        inOut.Pdata.Oth_Cash + inOut.Pdata.Oth_Cha + inOut.Pdata.Oth_Chk;
  }

  /// 関連tprxソース: rcinoutdsp.c - rcInOut_Staff_EntChk
  static Future<int> rcInOutStaffEntChk() async {
    AcMem cMem = SystemFunc.readAcMem();

    if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) == 0) {
      return 0;
    }

    if (await RcFncChk.rcCheckChgInOutMode()) {
      /*釣機回収*/

      if ((int.tryParse(cMem.staffInfo!.entFlg) ?? 0 & 0x04) != 0) {
        return 0;
      }

      if (CmCksys.cmCashRecycleInoutSequence() == 0 &&
          RegsMem().prnrBuf.opeStaffCd != 0) {
        cMem.staffInfo!.entFlg =
            (int.tryParse(cMem.staffInfo!.entFlg) ?? 0 | 0x04).toString();
        return 0;
      } else {
        RegsMem().prnrBuf.opeStaffCd = 0;
        return 1;
      }
    } else if (await RcFncChk.rcCheckInOutMode()) {
      if (rcCheckKyDrawChk()) {
        if ((int.tryParse(cMem.staffInfo!.entFlg) ?? 0 & 0x01) == 0) {
          RegsMem().prnrBuf.opeStaffCd = 0;
          return 1;
        }
      }
      if (inOut.fncCode == FuncKey.KY_PICK.keyId) {
        if (await AplLibAuto.strOpnClsSetChk(
            await RcSysChk.getTid(), StrOpnClsCodeList.STRCLS_DRWCHK) >
            0 &&
            (int.tryParse(cMem.staffInfo!.entFlg) ?? 0 & 0x01) != 0 &&
            RegsMem().prnrBuf.opeStaffCd != 0) {
          cMem.staffInfo!.entFlg =
              (int.tryParse(cMem.staffInfo!.entFlg) ?? 0 | 0x02).toString();
          return 0;
        }
        if ((int.tryParse(cMem.staffInfo!.entFlg) ?? 0 & 0x02) == 0) {
          RegsMem().prnrBuf.opeStaffCd = 0;
          return 1;
        }
      }
    }
    return 0;
  }

  /// 関連tprxソース: rcinoutdsp.c - rcCheck_Ky_DrawChk
  static bool rcCheckKyDrawChk() {
    return (inOut.fncCode == FuncKey.KY_DRWCHK.keyId || inOut.fncCode == FuncKey.KY_DRWCHK_CASH.keyId);
  }

  /// 関連tprxソース: rcinoutdsp.c - rcAutoExec
  static Future<void> rcAutoExec(Function quitFunc, Function exeFunc) async {
    // rcAutoExe_GtkTimerRemove();
    staffData = StaffData();
    AcMem cMem = SystemFunc.readAcMem();

    chgPickFunc = null;
    chgPickQFunc = null;
    if (AplLibAuto.strCls(await RcSysChk.getTid()) != 0) {
      if (!RcFncChk.rcChkErrNon() ||
          cMem.ent.errNo != 0 ||
          TprLibDlg.tprLibDlgCheck2(1) != 0) {
        await AplLibAuto.aplLibCmAutoMsgSend(
            await RcSysChk.getTid(), AutoMsg.AUTO_MSG_OPERAT);
        if (await RcFncChk.rcCheckChgInOutMode()) {
          /*釣機回収*/
          await RcKyCpick.rcCPickAutoFlgSet(0);
        } else {
          inOut.exeFlg = 0;
        }
        return;
      }
      if (await RcFncChk.rcCheckChgInOutMode()) {
        /*釣機回収*/
        if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0) {
          await RcKyCpick.rcCPickAutoFlgSet(0);
          return;
        }
        chgPickFunc = exeFunc;
        chgPickQFunc = quitFunc;
        if (await rcInOutStaffEntChk() != 0) {
          // TODO:10164 自動閉設 必要であれば実装
          // rcInOut_Staff_Show(window, 0);
          await RcKyCpick.rcCPickAutoFlgSet(0);
          return;
        } else {
          // rcAutoExe_GtkTimerAdd(EXEC_TIMER, (GtkFunction)rcAutoExec_main);
        }
      } else if (await RcFncChk.rcCheckInOutMode()) {
        if (rcCheckKyDrawChk()) {
          if (await AplLibAuto.strOpnClsSetChk(
              Tpraid.TPRAID_SYST, StrOpnClsCodeList.STRCLS_DRWCHK) >=
              2) {
            if (await Rcinoutdsp.rcInOutStaffEntChk() != 0) {
              autoNoStaff = 1;
            }
            // rcAutoExe_GtkTimerAdd( EXEC_TIMER, (GtkFunction)rcAutoExec_main );
          } else {
            if (await Rcinoutdsp.rcInOutStaffEntChk() != 0) {
              // TODO:10164 自動閉設 必要であれば実装
              // rcInOut_Staff_Show(inOut.Disp.window, 0);
            } else {
              await AplLibAuto.aplLibCmAutoMsgSend(
                  await RcSysChk.getTid(), AutoMsg.AUTO_MSG_OPERAT);
            }
            inOut.exeFlg = 0;
          }
          return;
        } else if (inOut.fncCode == FuncKey.KY_PICK.keyId) {
          if (await AplLibAuto.strOpnClsSetChk(await RcSysChk.getTid(),
              StrOpnClsCodeList.STRCLS_PICK_AUTO) !=
              0) {
            if (await Rcinoutdsp.rcInOutStaffEntChk() != 0) {
              autoNoStaff = 1;
            }
            // rcAutoExe_GtkTimerAdd( EXEC_TIMER, (GtkFunction)rcAutoExec_main );
          } else {
            if (await Rcinoutdsp.rcInOutStaffEntChk() != 0) {
              // TODO:10164 自動閉設 必要であれば実装
              // rcInOut_Staff_Show(inOut.Disp.window, 0);
            } else {
              await AplLibAuto.aplLibCmAutoMsgSend(
                  await RcSysChk.getTid(), AutoMsg.AUTO_MSG_OPERAT);
            }
            inOut.exeFlg = 0;
          }
          return;
        } else {
          inOut.exeFlg = 0;
        }
      }
    } else if (await RcFncChk.rcCheckChgInOutMode()) {
      await RcKyCpick.rcCPickAutoFlgSet(0);
    } else {
      inOut.exeFlg = 0;
    }
  }
}

/// 関連tprxソース: rcinoutdsp.c - money_button_tbl
class MoneyButtonTbl {
  final int btnNo;
  final int btnType; //タイプ 現金／会計／品券
  final int fncCd; //ファンクションキー番号
  final int notUseFlg; //0:使用可 1:使用不可
  final int divideCnt; //区分設定件数
  final int btnColor; //ボタン色
  final String btnImage; //ボタン文言
  final int btnPage; //配置ページ	0～
  final int btnXposi; //配置列(最大4列)
  final int btnYposi; //配置行(最大10行)

  const MoneyButtonTbl(
    this.btnNo,
    this.btnType,
    this.fncCd,
    this.notUseFlg,
    this.divideCnt,
    this.btnColor,
    this.btnImage,
    this.btnPage,
    this.btnXposi,
    this.btnYposi,
  );
}
