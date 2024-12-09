/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/regs/checker/rc_passport_inf.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rfdopr.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_calc.dart';
import '../../inc/apl/rxmem_taxfree.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/db/c_ttllog.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/taxfree_comlib.dart';

class TaxfreeData {
  List<String> taxTyp = List.filled(10, '');	//税タイプ
  double taxPer = 0.0;	//税率
  int pluNum = 0;	//送信対象商品数
  // TODO:00011 周 下記C言語の構造体、必要になる時Dart側に都度追加実装する予定。最初は一旦コメントアウト
  // TAXFREE_PLU_DATA	pluData[ITEM_MAX];	//商品情報(V14はMEM->taxfree_plu)
  // TAXFREE_TTL_AMT		ttlData[TF_TTL_MAX];	//合計金額（履歴ファイルNo.284-301)
  int	line = 0;
}

class RcTaxFreeSvr{

  static int resChkCnt = 0;
  static int order = 0;
  static String log = '';
  // TODO:00011 周 変数名「__FUNCTION__」は暫定な命名
  static String __FUNCTION__ = '';
  static Function? returnFunc;
  static int dlgShow = 0;
  static TaxfreeData? rireki;

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_taxfree_svr.c - rc_TaxfreeNo_Get
  static Future<void> rcTaxfreeNoGet() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcTaxfreeNoGet：未実装");
  }

  ///  免税電子化関連データをクリア
  ///  関連tprxソース: rc_taxfree_svr.c - rc_Taxfree_Svr_Data_Clr
  static void rcTaxfreeSvrDataClr() {
    RegsMem().tTtllog.t109000.voucherNumber = '';
    RegsMem().tTtllog.t109000.cnceledVoucherNumber = '';
    RegsMem().tTtllog.t109000.number = '';
    RegsMem().tHeader.various_data = '';
    return;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_taxfree_svr.c - taxfree_timer_init
  static void taxfreeTimerInit() {
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_taxfree_svr.c - rc_Taxfree_Regs_File_Make
  static int rcTaxfreeRegsFileMake(int order) {
    return 0;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_taxfree_svr.c - rc_Taxfree_Dlg
  static void rcTaxfreeDlg(int errNo, String msg1, Function? func1, String msg2, Function? func2, String title, String msgBuf) {
    return;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  通信エラー「中止」ボタン処理
  ///  関連tprxソース: rc_taxfree_svr.c - rc_Taxfree_Dlg_Cncl
  static void rcTaxfreeDlgCncl() {
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_taxfree_svr.c - taxfree_timeradd
  static void taxfreeTimeradd(int timer, Function func) {
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_taxfree_svr.c - rc_Taxfree_Comm_Chk
  static int rcTaxfreeCommChk() {
    return 0;
  }

  ///  売上データを免税サーバーに送信する処理
  ///  order : オーダー（TAXFREE_ORDER）
  ///  func: エラー時強制ボタン処理
  ///  err_show:通信エラー発生時ダイヤログ表示　0：表示しない　1：表示する
  ///  関連tprxソース: rc_taxfree_svr.c - rc_Taxfree_Comm
  static Future<int> rcTaxfreeComm(int ord, Function? func, int errShow) async {
    int	errNo = 0;
    int	i;

    taxfreeTimerInit();
    resChkCnt = 0;
    order = ord;

    if (ord == TaxfreeOrder.TAXFREE_ORDER_MODECHG.id) {
      log = '$__FUNCTION__: order[$ord] ${RxTaskStatBuf().taxfree.regsTranMode}';
    } else if ((RckyRfdopr.rcRfdOprCheckRcptVoidMode()) && (ord == TaxfreeOrder.TAXFREE_ORDER_GET_SALES.id)) {
      log = '$__FUNCTION__: order[$ord][$errShow] cnclVoucherNum[${RxTaskStatBuf().taxfree.cnclVoucherNum}]';
    } else {
      log = '$__FUNCTION__: order[$ord][$errShow]tran[${RegsMem().tTtllog.t109000.voucherNumber}] orgSaleno[${RegsMem().tTtllog.t109000.cnceledVoucherNumber}]';
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    returnFunc = func;
    dlgShow = errShow;

    for(i = 0; i < 50; i ++) {//処理終了まで10s待つ
      if(ord == TaxfreeOrder.TAXFREE_ORDER_MODECHG.id) {
        errNo = TaxfreeComlib.TaxfreeCommStatChk2(
            await RcSysChk.getTid(), RxMemTaxfree.TAXFREE_TASK_LICE_DEMO_OK);
      } else {
        errNo = TaxfreeComlib.TaxfreeCommStatChk(await RcSysChk.getTid());
      }
      if(errNo == DlgConfirmMsgKind.MSG_TAXFREE_BUSY.dlgId) {
        sleep(const Duration(milliseconds: AplLib.TAXFREE_CHK_TIME));
      } else {
        break;
      }
    }
    if (errNo != 0) {
      log = '$__FUNCTION__: order[$ord] err[$errNo]';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);

      //売上データ登録オーダーはtaxfreeタスクが送信できない状態であってもファイル
      //作成し、自動再送信処理でデータを送信させる。
      //それ以外のオーダーは処理を中断する
      if(dlgShow == 1)
      {
        rcTaxfreeDlg(errNo, LTprDlg.BTN_CANCEL, rcTaxfreeDlgCncl, '', null, LTprDlg.BTN_ERR, '');
        return errNo;
      }
    }
    rireki = TaxfreeData();
    if(ord != TaxfreeOrder.TAXFREE_ORDER_MODECHG.id) {
      rcTaxfreeRegsFileMake(ord);
    }
    if (errNo != 0) {
      return errNo;
    }

    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      return errNo;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;
    RegsMem mem = SystemFunc.readRegsMem();
    if ((ord != TaxfreeOrder.TAXFREE_ORDER_MODECHG.id)	&&
    (!RckyRfdopr.rcRfdOprCheckRcptVoidMode() || (ord != TaxfreeOrder.TAXFREE_ORDER_GET_SALES.id))) {
      tsBuf.taxfree.voucherNum = mem.tTtllog.t109000.voucherNumber;
      tsBuf.taxfree.cnclVoucherNum = mem.tTtllog.t109000.cnceledVoucherNumber;
    }
    tsBuf.taxfree.order = ord;
    if (dlgShow == 1) {//処理結果をチェックする
      // TODO:00011 周 TprLibDlgCheck関数の利用について
      // TODO:00011 周 （上の行に続く）フロント側ですでにDart言語における最適化な処理が存在している可能性があるため一旦保留
      // if (!TprLibDlgCheck()) {  //ダイアログ表示中
      //   rcTaxfreeDlg(DlgConfirmMsgKind.MSG_TAXFREE_COMM.dlgId, '', null, '', null, ' ', '');
      // }
      taxfreeTimeradd(AplLib.TAXFREE_CHK_TIME, rcTaxfreeCommChk);
    }
    else {
      errNo = rcTaxfreeCommChk();
    }

    return errNo;
  }

  ///  免税電子化関連データをクリア
  ///  関連tprxソース: rc_taxfree_svr.c - rc_Taxfree_Clr
  static void rcTaxfreeClr() {
    RcPassportInf.rcPassportInfoClr();
    RegsMem().tTtllog.t109000 = T109000();
    RegsMem().tTtllog.calcData.taxfreeBk = TaxFreeBkData();
    RegsMem().tHeader.various_data = '';
  }
}