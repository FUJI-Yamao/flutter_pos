/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_macro.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28stlinfo.dart';
import 'rc_crdt_fnc.dart';
import 'rc_qc_dsp.dart';
import 'rc_timer.dart';
import 'rcfncchk.dart';
import 'rcky_cha.dart';
import 'rcky_stl.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';

class RcfSelf {
  static int fself_cash_ct1 = 0;
  static int fself_cash_ct2 = 0;
  static int fself_auto_cash = 0;
  static int fself_cash_time = 0;
  static int fself_settlterm_flg = 0;//決済端末操作フラグ
  static int err_no_local = 0;		/* timerエラー用 */

  // TODO:00005 田中 rcATCT_Print実装のため、定義のみ追加
  /// 関連tprxソース: rc_fself.c - rc_fself_tranfinish_create
  static void rcfSelfTranFinishCreate(int result) {
  }

  /// 関連tprxソース: rc_fself.c - rc_fself_movie_stop
  static Future<void> rcFselfMovieStop() async {
    int i, j = 0;
    String log = '';
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    await rcGtkTimerRemoveFself();

    if (rcFselfMoviePlaycheck()) {
      log = "rcFselfMovieStop : movie_name[${tsBuf.chk.color_fip_movie_path}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      for (j = 0; j < 10; j++) {
        if (j > 0) {
          log = "rcFselfMovieStop : Retry !!\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        }
        for (i = 0; i < 100; i++) {
          if (cBuf.scrmsgFlg == 0) {
            log = "rcFselfMovieStop : Success[$i] !!\n";
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
            break;
          } else {
            cBuf.scrmsgFlg = 1;
            TprMacro.usleep(50000);
          }
        }
        if (cBuf.scrmsgFlg == 0) {
          break;
        }
      }
      if (cBuf.scrmsgFlg != 0) {
        log = "rcFselfMovieStop : cBuf.scrmsgFlg[${cBuf.scrmsgFlg}] != 0 !!\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      }
    }
  }

  /// 関連tprxソース: rc_fself.c - rc_fself_tranend_create
  static Future<void> rcFselfTranendCreate() async {
    int result = 0;
    int btn_cnt = 0;
    String fname = '';
    // static GtkWidget *colordsp_qr = NULL;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    RxMemRet tRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (tRet.isInvalid()) {
      return ;
    }
    RxCommonBuf cBuf = tRet.object;

    if(Rc28StlInfo.colorFipChk() != 1) {
      return;
    }
    if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
      return;
    }
    if ((!RcSysChk.rcRGOpeModeChk()) && (!RcSysChk.rcTROpeModeChk())) {
      return;
    }
    if((await RcFncChk.rcCheckERefSMode())
        || (await RcFncChk.rcCheckERefIMode())
        || (await RcFncChk.rcCheckESVoidSMode())
        || (await RcFncChk.rcCheckESVoidCMode())
        || (await RcFncChk.rcCheckESVoidIMode())
        || (await RcFncChk.rcCheckESVoidMode())
        || (await RcFncChk.rcCheckCrdtVoidSMode())
        || (await RcFncChk.rcCheckPrecaVoidSMode())) {
      return;
    }

    if (RcRegs.rcInfoMem.rcRecog.recogReservsystem != RecogValue.RECOG_NO.index) {
      if ((RcFncChk.rcCheckReservMode()) || (await RcFncChk.rcCheckBkScrReservMode())) {
        return;
      }
    }

    if (await RcSysChk.rcSysChkHappySmile()) {
      if (! await RcFncChk.rcChkFselfPayMode()) {
        return;
      }
    }

    fself_settlterm_flg = RckyCha.rcChkSettltermKeybtn(); // 決済端末の操作か確認

    if (await RcFncChk.rcChkFselfPayMode()) {
      if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
        tsBuf.chk.kycash_redy_flg = -1;
      }
      rcFselfAutocashtimeClear();
      if (Rxkoptcmncom.rxChkKoptCmnAutoCashType(cBuf) != 0) {
        // TODO timesの実装
        // fself_cash_ct1 = times(fself_cash_tp);
        fself_cash_time = Rxkoptcmncom.rxChkKoptCmnAutoCashTime(cBuf);
        if (fself_cash_time > 0) {
          fself_auto_cash = 1;
        }
      }

      if (await RcSysChk.rcSysChkHappySmile()) {
        if ((cMem.acbData.totalPrice - RcCrdtFnc.payPrice()) >= 0) {
          await RcfSelf.rcFselfMovieStop();
          if (Rxkoptcmncom.rxChkKoptCmnStlVoice(cBuf) != 0) {
            if (Rxkoptcmncom.rxChkKoptCmnCashBtnNameChange(cBuf) == 0) {
              RckyStl.rckyStlFselfVoiceProc(1);
            } else {
              RckyStl.rckyStlFselfVoiceProc(2);
            }
          }
          RcQcDsp.rcQCDspColorFipCashBtn(FuncKey.KY_CASH.keyId);
        }
        RcQcDsp.rcQCCashDspBodyParts(2);
        return;
      }
      // TODO:10154 釣銭機UI関連
      // if (tColorFipItemInfo.window != NULL) {
      //   await RcfSelf.rcFselfMovieStop();
      //   gtk_widget_destroy(tColorFipItemInfo.window);
      //   tColorFipItemInfo.window = NULL;
      // }
      // memset(&tColorFipItemInfo, 0x0, sizeof(tColorFipItemInfo));
      //
      // if (tColorFipItemInfo.window == NULL) {
      //   tColorFipItemInfo.window = gtk_window_new_typ(GTK_WINDOW_POPUP, 2);
      //   gtk_widget_set_usize(tColorFipItemInfo.window, tColorFipDt.XMax, tColorFipDt.YMax);
      //   ChgColor(tColorFipItemInfo.window, &ColorSelect[LightGray], &ColorSelect[LightGray], &ColorSelect[LightGray]);

        // if (rxChkKoptCmn_LangChg_NoYes(cBuf) != FSELF_LANGCHG_NO_USE) /* 言語切替を行う場合 */ {
        //   if (rcky_Get_Kopt_Lang_Qty(NULL) > 0) /* キーオプションで切替可能言語が設定されている場合 */ {
        //     if ((rxChkKoptCmn_LangChg_NoYes(cBuf) != FSELF_LANGCHG_SELECT) /* 選択切替ではない場合 */
        //         || (atSing.qcSelectWinFlg == 1)) /* 釣銭チャージ画面の場合 */ {
        //       /* 選択切替の時は言語ボタン表示中フラグを倒したくない */
        //       rc_fself_lang_btn_destroy();
        //     }
        //     if (rxChkKoptCmn_LangChg_NoYes(cBuf) == FSELF_LANGCHG_DIRECT) /* 直接切替を行う場合 */ {
        //       if (atSing.qcSelectWinFlg != 1) /* 釣銭チャージ画面ではない場合 */ {
        //         rc_fself_lang_btn_dsp(1); /* ボタンを見えなくさせるため、先にボタンの表示処理だけを行う */
        //       }
        //     }
        //   }
        // }
        //
        // memset(fname, 0x0, sizeof(fname));
        // snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_base);
        // tColorFipItemInfo.fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
        // gtk_fixed_put(tColorFipItemInfo.window, tColorFipItemInfo.fixed,
        //     tColorFipDt.f_self_imgdata_posi.offset_zero_x,
        //     tColorFipDt.f_self_imgdata_posi.offset_zero_y);
        // gtk_widget_show(tColorFipItemInfo.fixed);
        //
        // memset(fname, 0x0, sizeof(fname));
        // snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_ttl);
        // tColorFipItemInfo.f_self_total_fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
        // gtk_fixed_put(
        //     tColorFipItemInfo.window, tColorFipItemInfo.f_self_total_fixed,
        //     tColorFipDt.f_self_imgdata_posi.offset_zero_x,
        //     tColorFipDt.f_self_imgdata_posi.offset_zero_y);
        // gtk_widget_show(tColorFipItemInfo.f_self_total_fixed);
        //
        // if (rc_fself_check_paylack()) {
        //   memset(fname, 0x0, sizeof(fname));
        //   if ((rxChkKoptCmn_LangChg_NoYes(cBuf) != FSELF_LANGCHG_NO_USE) /* 言語切替を行う場合 */
        //       && (rcky_Get_Lang_Typ() != FSELF_LANG_JPN)) /* 日本語以外の場合 */ {
        //     snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_amt);
        //   }
        //   else {
        //     snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_chg);
        //   }
        //   tColorFipItemInfo.f_self_tend_fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
        //   gtk_fixed_put(
        //       tColorFipItemInfo.window, tColorFipItemInfo.f_self_tend_fixed,
        //       tColorFipDt.f_self_imgdata_posi.offset_stl2_tend_x,
        //       tColorFipDt.f_self_imgdata_posi.offset_stl2_tend_y);
        //   gtk_widget_show(tColorFipItemInfo.f_self_tend_fixed);
        //
        //   memset(fname, 0x0, sizeof(fname));
        //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_lack);
        //   tColorFipItemInfo.f_self_change_fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
        //   gtk_fixed_put(
        //       tColorFipItemInfo.window, tColorFipItemInfo.f_self_change_fixed,
        //       tColorFipDt.f_self_imgdata_posi.offset_stl2_chg_x,
        //       tColorFipDt.f_self_imgdata_posi.offset_stl2_chg_y);
        //   gtk_widget_show(tColorFipItemInfo.f_self_change_fixed);
        //
        //   memset(fname, 0x0, sizeof(fname));
        //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_img_2);
        //   tColorFipItemInfo.f_self_movie_fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
        //   gtk_fixed_put(
        //       tColorFipItemInfo.window, tColorFipItemInfo.f_self_movie_fixed,
        //       tColorFipDt.f_self_imgdata_posi.offset_btn1_x,
        //       tColorFipDt.f_self_imgdata_posi.offset_btn1_y);
        //   gtk_widget_show(tColorFipItemInfo.f_self_movie_fixed);
        // }
        // else {
        //   memset(fname, 0x0, sizeof(fname));
        //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_tnd);
        //   tColorFipItemInfo.f_self_tend_fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
        //   gtk_fixed_put(
        //       tColorFipItemInfo.window, tColorFipItemInfo.f_self_tend_fixed,
        //       tColorFipDt.f_self_imgdata_posi.offset_stl2_tend_x,
        //       tColorFipDt.f_self_imgdata_posi.offset_stl2_tend_y);
        //   gtk_widget_show(tColorFipItemInfo.f_self_tend_fixed);
        //
        //   memset(fname, 0x0, sizeof(fname));
        //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_chg);
        //   tColorFipItemInfo.f_self_change_fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
        //   gtk_fixed_put(
        //       tColorFipItemInfo.window, tColorFipItemInfo.f_self_change_fixed,
        //       tColorFipDt.f_self_imgdata_posi.offset_stl2_chg_x,
        //       tColorFipDt.f_self_imgdata_posi.offset_stl2_chg_y);
        //   gtk_widget_show(tColorFipItemInfo.f_self_change_fixed);
        //
        //   result = rc_fself_pay_btn_create();
        // }
        //
        // memset(fname, 0x0, sizeof(fname));
        // snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_message);
        // tColorFipItemInfo.f_self_message_fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
        // gtk_fixed_put(
        //     tColorFipItemInfo.window, tColorFipItemInfo.f_self_message_fixed,
        //     tColorFipDt.f_self_imgdata_posi.offset_message_x,
        //     tColorFipDt.f_self_imgdata_posi.offset_message_y);
        // gtk_widget_show(tColorFipItemInfo.f_self_message_fixed);
        //
        // rc_fself_stltend_create(NULL, 1, NULL, 0, 0);
        //
        // gtk_widget_show(tColorFipItemInfo.window);

      //   if (result == DlgConfirmMsgKind.MSG_NOMALEND.dlgId) {
      //     if (rxChkKoptCmn_StlVoice(cBuf)) {
      //       if (rxChkKoptCmn_CashBtn_NameChange(cBuf) == 0) {
      //         rcky_stl_fself_voice_proc(1);
      //       }
      //       else {
      //         rcky_stl_fself_voice_proc(2);
      //       }
      //     }
      //
      //     await rcGtkTimerRemoveFself();
      //     btn_cnt = rc_fself_cashend_btncnt_check();
      //     switch (btn_cnt) {
      //       case 1 :
      //         err_no_local = rcGtkTimerAdd_fself(
      //             FSELF_BTN_BRINK, (GtkFunction)rc_fself_bigbtn_brink_show);
      //         break;
      //       case 2 :
      //         err_no_local = rcGtkTimerAdd_fself(
      //             FSELF_BTN_BRINK, (GtkFunction)rc_fself_2btn_brink_show);
      //         break;
      //       default :
      //         err_no_local = rcGtkTimerAdd_fself(
      //             FSELF_BTN_BRINK, (GtkFunction)rc_fself_3btn_brink_show);
      //         break;
      //     }
      //     if (err_no_local != 0) {
      //       rc_fself_timer_error();
      //     }
      //   }
      //   else {
      //     if (result == DlgConfirmMsgKind.MSG_NOTACCEPT.dlgId) {
      //       await rcGtkTimerRemoveFself();
      //     }
      //   }
      // }
    }
    else if ((await RcFncChk.rcChkFselfOtherpayMode ()) || (fself_settlterm_flg == 1)) {
      if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
        tsBuf.chk.kycash_redy_flg = -1;
      }
      rcFselfAutocashtimeClear();

      // if (tColorFipItemInfo.window != NULL) {
      //   await RcfSelf.rcFselfMovieStop();
      //   gtk_widget_destroy(tColorFipItemInfo.window);
      //   tColorFipItemInfo.window = NULL;
      // }
      // memset(&tColorFipItemInfo, 0x0, sizeof(tColorFipItemInfo));

      // if (tColorFipItemInfo.window == NULL) {
      //   tColorFipItemInfo.window = gtk_window_new_typ(GTK_WINDOW_POPUP, 2);
      //   gtk_widget_set_usize(
      //       tColorFipItemInfo.window, tColorFipDt.XMax, tColorFipDt.YMax);
      //   ChgColor(tColorFipItemInfo.window, &
      //       ColorSelect[LightGray], &ColorSelect[LightGray], &ColorSelect[
      //       LightGray]);
      //
      //   if (rxChkKoptCmn_LangChg_NoYes(cBuf) != FSELF_LANGCHG_NO_USE) /* 言語切替を行う場合 */ {
      //     if (rcky_Get_Kopt_Lang_Qty(NULL) > 0) /* キーオプションで切替可能言語が設定されている場合 */ {
      //       if ((rxChkKoptCmn_LangChg_NoYes(cBuf) != FSELF_LANGCHG_SELECT) /* 選択切替ではない場合 */
      //           || (atSing.qcSelectWinFlg == 1)) /* 釣銭チャージ画面の場合 */ {
      //         /* 選択切替の時は言語ボタン表示中フラグを倒したくない */
      //         rc_fself_lang_btn_destroy();
      //       }
      //       if (rxChkKoptCmn_LangChg_NoYes(cBuf) ==
      //           FSELF_LANGCHG_DIRECT) /* 直接切替を行う場合 */ {
      //         if (atSing.qcSelectWinFlg != 1) /* 釣銭チャージ画面ではない場合 */ {
      //           rc_fself_lang_btn_dsp(1); /* ボタンを見えなくさせるため、先にボタンの表示処理だけを行う */
      //         }
      //       }
      //     }
      //   }
      //
      //   memset(fname, 0x0, sizeof(fname));
      //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_base);
      //   tColorFipItemInfo.fixed =
      //       create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
      //   gtk_fixed_put(tColorFipItemInfo.window, tColorFipItemInfo.fixed,
      //       tColorFipDt.f_self_imgdata_posi.offset_zero_x,
      //       tColorFipDt.f_self_imgdata_posi.offset_zero_y);
      //   gtk_widget_show(tColorFipItemInfo.fixed);
      //
      //   memset(fname, 0x0, sizeof(fname));
      //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_ttl);
      //   tColorFipItemInfo.f_self_total_fixed =
      //       create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
      //   gtk_fixed_put(
      //       tColorFipItemInfo.window, tColorFipItemInfo.f_self_total_fixed,
      //       tColorFipDt.f_self_imgdata_posi.offset_zero_x,
      //       tColorFipDt.f_self_imgdata_posi.offset_zero_x);
      //   gtk_widget_show(tColorFipItemInfo.f_self_total_fixed);
      //
      //   memset(fname, 0x0, sizeof(fname));
      //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_chg);
      //   tColorFipItemInfo.f_self_tend_fixed =
      //       create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
      //   gtk_fixed_put(
      //       tColorFipItemInfo.window, tColorFipItemInfo.f_self_tend_fixed,
      //       tColorFipDt.f_self_imgdata_posi.offset_stl2_tend_x,
      //       tColorFipDt.f_self_imgdata_posi.offset_stl2_tend_y);
      //   gtk_widget_show(tColorFipItemInfo.f_self_tend_fixed);
      //
      //   memset(fname, 0x0, sizeof(fname));
      //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_message);
      //   tColorFipItemInfo.f_self_message_fixed =
      //       create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
      //   gtk_fixed_put(
      //       tColorFipItemInfo.window, tColorFipItemInfo.f_self_message_fixed,
      //       tColorFipDt.f_self_imgdata_posi.offset_message_x,
      //       tColorFipDt.f_self_imgdata_posi.offset_message_y);
      //   gtk_widget_show(tColorFipItemInfo.f_self_message_fixed);
      //
      //   if (!rcsyschk_happy_smile() && rcCheck_Barcode_Pay_QR_Mode()) {
      //     /* バーコード決済 スマイルセルフQR表示 */
      //     colordsp_qr = gtk_fixed_new();
      //     gtk_widget_set_usize(colordsp_qr, 240, 240);
      //     ChgColor(colordsp_qr, &ColorSelect[White], &ColorSelect[White], &
      //         ColorSelect[White]);
      //     rcBarcode_Pay_Draw_QRBar(colordsp_qr, 20, 20, 6);
      //     gtk_fixed_put(tColorFipItemInfo.window, colordsp_qr, 525, 80);
      //     gtk_widget_show(colordsp_qr);
      //   }
      //
      //   rc_fself_stltend_create(NULL, 1, NULL, 0, 0);
      //
      //   gtk_widget_show(tColorFipItemInfo.window);
      // }
    }
    else {
      // if (tColorFipItemInfo.window != NULL) {
      //   await RcfSelf.rcFselfMovieStop();
      //   gtk_widget_destroy(tColorFipItemInfo.window);
      //   tColorFipItemInfo.window = NULL;
      // }
      // memset(&tColorFipItemInfo, 0x0, sizeof(tColorFipItemInfo));
      //
      // if (tColorFipItemInfo.window == NULL) {
      //   tColorFipItemInfo.window = gtk_window_new_typ(GTK_WINDOW_POPUP, 2);
      //   gtk_widget_set_usize(
      //       tColorFipItemInfo.window, tColorFipDt.XMax, tColorFipDt.YMax);
      //   ChgColor(tColorFipItemInfo.window, &
      //       ColorSelect[LightGray], &ColorSelect[LightGray], &ColorSelect[
      //       LightGray]);
      //
      //   if (rxChkKoptCmn_LangChg_NoYes(cBuf) != FSELF_LANGCHG_NO_USE) /* 言語切替を行う場合 */ {
      //     if (rcky_Get_Kopt_Lang_Qty(NULL) > 0) /* キーオプションで切替可能言語が設定されている場合 */ {
      //       if ((rxChkKoptCmn_LangChg_NoYes(cBuf) != FSELF_LANGCHG_SELECT) /* 選択切替ではない場合 */
      //           || (atSing.qcSelectWinFlg == 1)) /* 釣銭チャージ画面の場合 */ {
      //         /* 選択切替の時は言語ボタン表示中フラグを倒したくない */
      //         rc_fself_lang_btn_destroy();
      //       }
      //       if (rxChkKoptCmn_LangChg_NoYes(cBuf) == FSELF_LANGCHG_DIRECT) /* 直接切替を行う場合 */ {
      //         if (atSing.qcSelectWinFlg != 1) /* 釣銭チャージ画面ではない場合 */ {
      //           rc_fself_lang_btn_dsp(1); /* ボタンを見えなくさせるため、先にボタンの表示処理だけを行う */
      //         }
      //       }
      //     }
      //   }
      //
      //   memset(fname, 0x0, sizeof(fname));
      //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_base);
      //   tColorFipItemInfo.fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
      //   gtk_fixed_put(tColorFipItemInfo.window, tColorFipItemInfo.fixed,
      //       tColorFipDt.f_self_imgdata_posi.offset_zero_x,
      //       tColorFipDt.f_self_imgdata_posi.offset_zero_y);
      //   gtk_widget_show(tColorFipItemInfo.fixed);
      //
      //   memset(fname, 0x0, sizeof(fname));
      //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_ttl);
      //   tColorFipItemInfo.f_self_total_fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
      //   gtk_fixed_put(
      //       tColorFipItemInfo.window, tColorFipItemInfo.f_self_total_fixed,
      //       tColorFipDt.f_self_imgdata_posi.offset_zero_x,
      //       tColorFipDt.f_self_imgdata_posi.offset_zero_y);
      //   gtk_widget_show(tColorFipItemInfo.f_self_total_fixed);
      //
      //   memset(fname, 0x0, sizeof(fname));
      //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_tnd);
      //   tColorFipItemInfo.f_self_tend_fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
      //   gtk_fixed_put(
      //       tColorFipItemInfo.window, tColorFipItemInfo.f_self_tend_fixed,
      //       tColorFipDt.f_self_imgdata_posi.offset_stl2_tend_x,
      //       tColorFipDt.f_self_imgdata_posi.offset_stl2_tend_y);
      //   gtk_widget_show(tColorFipItemInfo.f_self_tend_fixed);
      //
      //   memset(fname, 0x0, sizeof(fname));
      //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_stl_chg);
      //   tColorFipItemInfo.f_self_change_fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
      //   gtk_fixed_put(
      //       tColorFipItemInfo.window, tColorFipItemInfo.f_self_change_fixed,
      //       tColorFipDt.f_self_imgdata_posi.offset_stl2_chg_x,
      //       tColorFipDt.f_self_imgdata_posi.offset_stl2_chg_y);
      //   gtk_widget_show(tColorFipItemInfo.f_self_change_fixed);
      //
      //   memset(fname, 0x0, sizeof(fname));
      //   snprintf(fname, sizeof(fname), tColorFipDt.Fname.f_self_message);
      //   tColorFipItemInfo.f_self_message_fixed = create_pixmap_nochg(tColorFipItemInfo.window, fname, 0);
      //   gtk_fixed_put(
      //       tColorFipItemInfo.window, tColorFipItemInfo.f_self_message_fixed,
      //       tColorFipDt.f_self_imgdata_posi.offset_message_x,
      //       tColorFipDt.f_self_imgdata_posi.offset_message_y);
      //   gtk_widget_show(tColorFipItemInfo.f_self_message_fixed);
      //
      //   rc_fself_stltend_create(NULL, 1, NULL, 0, 2);
      //
      //   gtk_widget_show(tColorFipItemInfo.window);
      // }
    }
  }

  /// 処理概要：HappySelf<対面>釣り銭機エラーが発生した場合に、入金画面を再作成する
  /// パラメータ：なし
  /// 戻り値：なし
  /// 関連tprxソース: rc_fself.c - rc_fself_qc_cash_disp_remake
  static Future<void> rcFselfQcCashDispRemake() async {
    int modeChk = 0;
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();

    if (await RcSysChk.rcChkSmartSelfSystem()) {
      if ((atSing.rckySelfMnt == 1) &&
          (RcFncChk.rcCheckChgErrMode())) { //客側ディスプレイに釣銭機エラー復旧ガイダンス表示中である場合
        return; //ガイダンスを上書きさせないためリターンする
      }
    }
    if (await RcSysChk.rcSysChkHappySmile()) {
      if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
        if (await RcFncChk.rcChkFselfPayMode()) {
          if ((cMem.stat.bkScrMode == RcRegs.RG_STL) ||
              (cMem.stat.bkScrMode == RcRegs.VD_STL) ||
              (cMem.stat.bkScrMode == RcRegs.TR_STL) ||
              (cMem.stat.bkScrMode == RcRegs.SR_STL)) {
            modeChk = 1;

            if (modeChk == 0) {
              //ターミナル：釣機入金キーでの入金処理を入金実績に加算する設定の場合に画面崩れが発生していた不具合の対応
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                  "rcFselfQcCashDispRemake : no action! stat.BkScrMode[${cMem.stat.bkScrMode}]");
              return;
            }

            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "rcFselfQcCashDispRemake : start acbdata.total_price[${cMem.acbData.totalPrice}]");

            RcQcDsp.rcQCAllTimerRemove();
            RcQcDsp.rcQCDspDestroy();
//            gtk_widget_destroy(tColorFipItemInfo.window);
            Fb2Gtk.gtkWidgetDestroy(Dummy.tColorFipItemInfo);
//            tColorFipItemInfo.window = NULL;
            Dummy.tColorFipItemInfo = null;
            RcQcDsp.rcQCCashDsp();
          }
        }
      }
    }
  }

  /// 関連tprxソース: rc_fself.c - rc_fself_movie_playcheck
  static bool rcFselfMoviePlaycheck() {
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRetC.object;
    if ((cBuf.scrmsgFlg == 13) || (cBuf.scrmsgFlg == 14)) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rc_fself.c - rcGtkTimerRemove_fself
  static Future<int> rcGtkTimerRemoveFself() async {
    await RcTimer.rcTimerListRemove(RC_TIMER_LISTS.RC_GTK_FSELF_TIMER.id);
    return 0;
  }

  /// 機能：自動現計監視用のメモリをクリアする
  /// 関連tprxソース: rc_fself.c - rc_fself_autocashtime_clear
  static void rcFselfAutocashtimeClear() {
    fself_cash_ct1 = 0;
    fself_cash_ct2 = 0;
    fself_auto_cash = 0;
    fself_cash_time = 0;
  }

  // TODO: FIP関連のため定義のみ追加
  /// 関連tprxソース: rc_fself.c - rc_fself_stltend_create
  static void rcFselfStltendCreate(
      SubttlInfo? pSubttl, int ttldraw, String? img, int imgsiz, int flg) {
    return;
  }
}
