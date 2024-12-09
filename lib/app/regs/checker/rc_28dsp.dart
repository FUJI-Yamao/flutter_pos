/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_59dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_tab.dart';
import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/rxmem_define.dart';
import 'rc_59dsp.dart';
import 'rc_chgassortplu.dart';
import 'rc_tab.dart';
import 'rcdetect.dart';
import 'rcfncchk.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';

class Rc28dsp {
  /// 関連tprxソース: rc_28dsp.c - rc28MenuBarDisp
  // TODO:00007 梶原 コメントアウトした部分要確認　表示で指定されている関数なので、コピーだけしてコメントアウトしている
  // void rc28MenuBarDisp( int tab_num, Subttl_Info *pSubttl )
  // {
  // // int		firstFlg = 0;
  // // char		menuBarName[128];
  // // GtkWidget	*window;
  // // GtkWidget	*windowFixed;
  // // GtkWidget	**menuButton;
  // // GtkWidget	**macno_entry;
  // // GtkWidget	**cshr_name;
  // // GtkWidget	**mmdd_lbl;
  // // GtkWidget	**hhmm_lbl;
  // // GtkWidget	**tr_hhmm_lbl;
  // // MenubarData	*Set;
  // // char		IpAddr[32];
  // // struct	hostent	*servhost;
  // // PartsElement	MenuBarElement;
  // // PartsElement	MenuBtnElement;
  // // PartsElement	MacNoElement;
  // // PartsElement	StaffIconElement;
  // // PartsElement	CshrNameElement;
  // // PartsElement	SysDateElement;
  // // PartsElement	SaleDateElement;
  // // PartsElement	TimeElement;
  // // PartsElement	TrTimeElement;
  // // PartsElement	OnlineBtnElement;
  // double		partsRatio = 1.00;
  //
  // // #if !(RM3800_DSP)
  // // // 新RM-3800の場合、最上段のメニューバーを下段に表示
  // // if ( C_BUF->vtcl_rm5900_regs_on_flg )
  // // {
  // // rc59MenuBarDisp( tab_num, pSubttl );
  // // return;
  // // }
  // // #endif
  //
  // menuBtnPressFlg = 0;
  //
  // if (rcSG_Chk_SelfGate_System())
  // return;
  //
  // if( pSubttl == NULL )
  // {
  // // Set 		= &Tran.Menubar;
  // // window		= Tran.window;
  // // windowFixed	= Tran.windowFixed;
  // menuButton	= &Tran.menuButton;
  // // macno_entry	= &Tran.macno_entry;
  // // cshr_name	= &Tran.cshr_name;
  // // mmdd_lbl	= &Tran.mmdd_lbl;
  // // hhmm_lbl	= &Tran.hhmm_lbl;
  // // tr_hhmm_lbl	= &Tran.tr_hhmm_lbl;
  // }
  // else
  // {
  // // Set 		= &pSubttl->Menubar;
  // // window		= pSubttl->window;
  // // windowFixed	= pSubttl->windowFixed;
  // menuButton	= &pSubttl->menuButton;
  // // macno_entry	= &pSubttl->macno_entry;
  // // cshr_name	= &pSubttl->cshr_name;
  // // mmdd_lbl	= &pSubttl->mmdd_lbl;
  // // hhmm_lbl	= &pSubttl->hhmm_lbl;
  // // tr_hhmm_lbl	= &pSubttl->tr_hhmm_lbl;
  // }
  //
  // // if( Set->pix_menu_bar != NULL )
  // // {
  // // gtk_widget_destroy(Set->pix_menu_bar);
  // // Set->pix_menu_bar = NULL;
  // // }
  // // else
  // // {
  // // firstFlg = 1;
  // // }
  //
  //
  // // // メニューバー
  // // if ( rcChk_2800_System() == 0 )
  // // {
  // // snprintf( menuBarName, sizeof(menuBarName), "svga_sk1_menu_back01.png" );
  // // if( rc_28dsp_Check_NoTab_Disp() )
  // // {
  // // snprintf( menuBarName, sizeof(menuBarName), "svga_com_share_top.png" );
  // // }
  // // }
  // // else if( rc_28dsp_Check_NoTab_Disp() )
  // // {
  // // snprintf( menuBarName, sizeof(menuBarName), "com_share_top.png" );
  // // }
  // // else if( rcChk_2800_TabOrder() == TRUE )
  // // {
  // // snprintf( menuBarName, sizeof(menuBarName), "%s_menu_back0%d.png", Tab_Info.SkinName, rcTabOrderPixmapNum(tab_num) );
  // // }
  // // else if( tab_num == FIRST_TAB )
  // // {
  // // sprintf( menuBarName, "%s_menu_back01.png", Tab_Info.SkinName );
  // // }
  // // else if( tab_num == SECOND_TAB )
  // // {
  // // sprintf( menuBarName, "%s_menu_back02.png", Tab_Info.SkinName );
  // // }
  // // else if( tab_num == THIRD_TAB )
  // // {
  // // sprintf( menuBarName, "%s_menu_back03.png", Tab_Info.SkinName );
  // // }
  // // Set->pix_menu_bar = create_pixmap_nochg(window, menuBarName, 0);
  // // gtk_widget_ref(Set->pix_menu_bar);
  // // gtk_object_set_data_full(GTK_OBJECT(window), "pix_menu_bar", Set->pix_menu_bar, (GtkDestroyNotify)gtk_widget_unref);
  // // gtk_widget_set_usize(Set->pix_menu_bar, MenuBarElement.Width, MenuBarElement.Height);
  // // gtk_fixed_put(GTK_FIXED(windowFixed), Set->pix_menu_bar, MenuBarElement.Xposi, MenuBarElement.Yposi);
  // // gtk_widget_show(Set->pix_menu_bar);
  // // メインメニューボタン
  // *menuButton = DrawWidgetTool( DWT_BTN, Set->pix_menu_bar, MenuBtnElement.Width, MenuBtnElement.Height, MenuBtnElement.Xposi, MenuBtnElement.Yposi, Navy, FONT14 );
  // gtk_signal_connect(GTK_OBJECT(*menuButton), "clicked", GTK_SIGNAL_FUNC(quitFunc), (gpointer)pSubttl );
  // // // メインメニュー画像
  // // rc28CreateParts_PixMenu( Set, 0 );	// メニューボタン画像の描画
  // //
  // if(rcChk_Desktop_Cashier()) {
  // switch(rcKy_Self())
  // {
  // case KY_DUALCSHR :
  // break;
  // default          :
  // gtk_widget_hide(*menuButton);
  // // gtk_widget_hide(Set->PixMenu);
  // break;
  // }
  // }
  // if ( rc_28dsp_Check_Info_Slct() )
  // {
  // gtk_widget_hide(*menuButton);
  // // gtk_widget_hide(Set->PixMenu);
  // }
  //
  // // // レジ番号
  // // *macno_entry = gtk_label_new(" ");
  // // ChgStyle(*macno_entry, &ColorSelect[White], &ColorSelect[None], &ColorSelect[None], MacNoElement.Font);
  // // gtk_widget_set_usize(*macno_entry, MACNO_X_SIZE * partsRatio, MACNO_Y_SIZE * partsRatio);
  // // gtk_misc_set_alignment(GTK_MISC(*macno_entry), 0, 0.5);
  // // if(rcQC_PresetMkey())
  // // gtk_fixed_put(GTK_FIXED(Set->pix_menu_bar), *macno_entry, MACNO_X_POSI * partsRatio, MACNO_Y_POSI2 * partsRatio);
  // // else
  // // gtk_fixed_put(GTK_FIXED(Set->pix_menu_bar), *macno_entry, MACNO_X_POSI * partsRatio, MACNO_Y_POSI * partsRatio);
  // // gtk_widget_show(*macno_entry);
  // // // スタッフアイコン
  // // Set->pix_staff = create_pixmap_nochg(window, StaffIconElement.PictName, 0);
  // // gtk_widget_ref(Set->pix_staff);
  // // gtk_object_set_data_full(GTK_OBJECT(window), "pix_staff", Set->pix_staff, (GtkDestroyNotify)gtk_widget_unref);
  // // gtk_widget_set_usize(Set->pix_staff, STAFFPIX_X_SIZE * partsRatio, STAFFPIX_Y_SIZE * partsRatio);
  // // gtk_fixed_put(GTK_FIXED(Set->pix_menu_bar), Set->pix_staff, StaffIconElement.Xposi, StaffIconElement.Yposi);
  // // gtk_widget_show(Set->pix_staff);
  // // // 従業員名
  // // *cshr_name = gtk_label_new(" ");
  // // ChgStyle(*cshr_name, &ColorSelect[White], &ColorSelect[None], &ColorSelect[None], CshrNameElement.Font);
  // // gtk_widget_set_usize(*cshr_name, CshrNameElement.Width, CshrNameElement.Height);
  // // gtk_misc_set_alignment(GTK_MISC(*cshr_name), 0, 0.5);
  // // gtk_fixed_put(GTK_FIXED(Set->pix_menu_bar), *cshr_name, CshrNameElement.Xposi, CshrNameElement.Yposi);
  // // gtk_widget_show(*cshr_name);
  // // // オフライン表示ボタン
  // // Set->online_btn = DrawWidgetTool( DWT_BTN, Set->pix_menu_bar, OnlineBtnElement.Width, OnlineBtnElement.Height, OnlineBtnElement.Xposi, OnlineBtnElement.Yposi, Navy, FONT14 );
  // // if( pSubttl == NULL )
  // // {
  // // gtk_signal_connect(GTK_OBJECT(Set->online_btn), "clicked", GTK_SIGNAL_FUNC(rcUpdateCnt_Func), GTK_OBJECT(window));
  // // }
  // // else
  // // {
  // // gtk_signal_connect(GTK_OBJECT(Set->online_btn), "clicked", GTK_SIGNAL_FUNC(rcUpdateCnt_StlFunc), GTK_OBJECT(window));
  // // }
  // // // オフライン画像表示
  // // rc28CreateParts_pix_online( Set, OfflineDspFlag );
  // // // 現在日付
  // // *mmdd_lbl = gtk_label_new(" ");
  // // ChgStyle(*mmdd_lbl, &ColorSelect[White], &ColorSelect[None], &ColorSelect[None], SysDateElement.Font);
  // // gtk_widget_set_usize(*mmdd_lbl, SysDateElement.Width, SysDateElement.Height);
  // // gtk_fixed_put(GTK_FIXED(Set->pix_menu_bar), *mmdd_lbl, SysDateElement.Xposi, SysDateElement.Yposi);
  // // gtk_widget_show(*mmdd_lbl);
  // // if(4 == C_BUF->ini_macinfo.mode)
  // // {
  // // /* 訓練モードの場合 */
  // //
  // // /* 訓練日ボタン関連 */
  // // if( pSubttl == NULL )
  // // {
  // // Tran.Menubar.tr_date_btn = NULL;
  // // rc_TrDate_Button_draw(0, &Tran);
  // // }
  // // else
  // // {
  // // pSubttl->Menubar.tr_date_btn = NULL;
  // // rc_TrDate_Button_draw(1, pSubttl);
  // // }
  // // }
  // // // 営業日付
  // // Set->mmdd_open_lbl = gtk_label_new(" ");
  // // ChgStyle(Set->mmdd_open_lbl, &ColorSelect[White], &ColorSelect[None], &ColorSelect[None], SaleDateElement.Font);
  // // gtk_widget_set_usize(Set->mmdd_open_lbl, SaleDateElement.Width, SaleDateElement.Height);
  // // gtk_fixed_put(GTK_FIXED(Set->pix_menu_bar), Set->mmdd_open_lbl, SaleDateElement.Xposi, SaleDateElement.Yposi);
  // // gtk_widget_show(Set->mmdd_open_lbl);
  // // // 時刻
  // // *hhmm_lbl = gtk_label_new(" ");
  // // ChgStyle(*hhmm_lbl, &ColorSelect[White], &ColorSelect[None], &ColorSelect[None], TimeElement.Font);
  // // gtk_widget_set_usize(*hhmm_lbl, TimeElement.Width, TimeElement.Height);
  // // gtk_fixed_put(GTK_FIXED(Set->pix_menu_bar), *hhmm_lbl, TimeElement.Xposi, TimeElement.Yposi);
  // // gtk_widget_show(*hhmm_lbl);
  // //
  // // // 訓練時刻
  // // if (C_BUF->ini_macinfo.mode == 4)
  // // {
  // // *tr_hhmm_lbl = gtk_label_new(" ");
  // // ChgStyle(*tr_hhmm_lbl, &ColorSelect[White], &ColorSelect[None], &ColorSelect[None], TrTimeElement.Font);
  // // gtk_widget_set_usize(*tr_hhmm_lbl, TrTimeElement.Width, TrTimeElement.Height);
  // // gtk_fixed_put(GTK_FIXED(Set->pix_menu_bar), *tr_hhmm_lbl, TrTimeElement.Xposi, TrTimeElement.Yposi);
  // // gtk_widget_show(*tr_hhmm_lbl);
  // // }
  // //
  // //
  // // //	if(cm_Receipt_QR_system() == 1){
  // // memset( &IpAddr, 0, sizeof(IpAddr));
  // //
  // // /*  2010/12/15  出荷状態時でも未精算件数を表示しないようIP判定を修正
  // // 	AplLib_GetHostsIPAddr( TPRAID_REPT, "spqc", IpAddr ); */
  // // servhost = gethostbyname("spqc");
  // // if( servhost == NULL ){
  // // snprintf( IpAddr, sizeof(IpAddr), "0.0.0.0" );
  // // TprLibLogWrite( TPRAID_CHK, TPRLOG_ERROR, -1, "rc28MenuBarDisp SPQC IP Get Error");
  // // }
  // // else{
  // // snprintf( IpAddr, sizeof(IpAddr),
  // // "%d.%d.%d.%d",
  // // (uchar)servhost->h_addr[0],
  // // (uchar)servhost->h_addr[1],
  // // (uchar)servhost->h_addr[2],
  // // (uchar)servhost->h_addr[3]);
  // // }
  // //
  // // // 2010/10/19 QC用カウント表示 承認キーQRレシート発行かつ登録or訓練かつお会計券管理SVが設定されているときのみ
  // // // 2012/03/06 ２台連結状態のみ, 表示に変更
  // // // 2012/07/31 分割精算表示と件数表示を別々にした
  // // Set->DivAdjEntry = NULL;
  // // if( strncmp(IpAddr, ZERO_IPADDR, strlen(IpAddr)) != 0 )
  // // {
  // // // 分割精算表示はお会計券サーバー設定時に表示
  // // Set->DivAdjEntry = gtk_round_entry_new();
  // // gtk_widget_set_usize(Set->DivAdjEntry, SPQC_X_SIZE, SPQC_Y_SIZE);
  // // gtk_fixed_put( GTK_FIXED(Set->pix_menu_bar), Set->DivAdjEntry, SPQC_X_POSI, SPQC_Y_POSI );
  // // gtk_misc_set_alignment(GTK_MISC(Set->DivAdjEntry), 0.5, 0.5);
  // // ChgStyle( Set->DivAdjEntry, &ColorSelect[Red], &ColorSelect[PapayaWhip], &ColorSelect[PapayaWhip], FONT18 );
  // // if( (firstFlg == 0) || (pSubttl != NULL) )
  // // {
  // // rcDispDivAdjEntry( ON );
  // // }
  // // }
  // //
  // // Set->MemoBtn.memo_btn = NULL;
  // // Set->MemoBtn.pix_memo = NULL;
  // // Set->MemoBtn.new_icon = NULL;
  // // Set->MemoBtn.status = 0;
  // // if( C_BUF->memo_read_flg > 0 )	// ボタン表示するか
  // //     {
  // // // 常駐メモボタン表示
  // // if( pSubttl == NULL )
  // // {
  // // rc28CreateParts_memo_btn( Set, NULL );
  // // }
  // // else
  // // {
  // // rc28CreateParts_memo_btn( Set, pSubttl );
  // // }
  // // }
  // //
  // // Set->TMemoBtn.memo_btn = NULL;
  // // Set->TMemoBtn.pix_memo = NULL;
  // // Set->TMemoBtn.new_icon = NULL;
  // // Set->TMemoBtn.status = 0;
  // // if( C_BUF->tmemo_read_flg > 0 )	// ボタン表示するか
  // //     {
  // // // 連絡メモボタン表示
  // // if( pSubttl == NULL )
  // // {
  // // rc28CreateParts_tmemo_btn( Set, NULL );
  // // }
  // // else
  // // {
  // // rc28CreateParts_tmemo_btn( Set, pSubttl );
  // // }
  // // }
  // //
  // // if( pSubttl == NULL )
  // // {
  // // // メモリが確保されていない場合があるため
  // // if(firstFlg == 0)
  // // {
  // // rcDspMacNo_28LCD();
  // // rcDspStaffName_28LCD();
  // // chk_display_time_offline();
  // // }
  // // }
  // // else
  // // {
  // // rcDspMacNo_28StlLCD(pSubttl);
  // // rc28StlLcd_Staff(pSubttl);
  // // stl_display_time_offline(pSubttl);
  // // }
  // //
  // // Set->auto_stop_lbl = NULL;
  // // if((firstFlg == 0) || (pSubttl != NULL))
  // // rcAuto_Stop_Dsp();
  // }

  /// 関連tprxソース: rc_28dsp.c - quitFunc
  static Future<void> quitFunc() async{
    if (await RcSysChk.rcSGChkSelfGateSystem()) return;

    if ((await RcFncChk.rcCheckESVoidSMode())
        || (await RcFncChk.rcCheckERefSMode())) {
      return;
    }

    if (await RcChgAssortPlu.rcCheckChgAsoortPluMode()) {
      return;
    }

    // TODO:00007 梶原 UI関係だと思われるのでコメントアウト　不要であれば消す
    // // タッチキーではデバイスが正確に取れていないための対応
    //     if( widget == Dual_Subttl.menuButton )
    //     {
    //       C_BUF->dev_id = 1;
    //   }
    //   else
    //     {
    //     C_BUF->dev_id = 2;
    //     }
    //     rc28MenuButtonChange( 1 );

    RcDetect.rcMenuDetect();
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_28dsp.c - rcTabData_Display
  static void rcTabDataDisplay(int tabNum) {
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_28dsp.c - rcTabCounter_DataSet
  static void rcTabCounterDataSet(int tabNum) {
    return ;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  /// 関数:	rc_28dsp_Check_Info_Slct()
  /// 機能:	明細選択画面での動作か判断するためのもの
  /// 関連tprxソース: rc_28dsp.c - rc_28dsp_Check_Info_Slct
  static bool rc28dspCheckInfoSlct() {
    return false;
  }

  /// 関連tprxソース: rc_28dsp.c - rcChk_UseMem_TabNum
  static int rcChkUseMemTabNum(TabInfo tabInfo){/* 使用中メモリ(CMEM)のタブ */
    int	tabNum = 0;

    if(tabInfo.tabStep == TabStep.TabStepR.num){
      tabNum = tabInfo.nextDspTab;
    }else{
      tabNum = tabInfo.dspTab;
    }
    return tabNum;
  }

  /// 関連tprxソース: rc_28dsp.c - rc28MainWindow_SizeChange
  static void rc28MainWindowSizeChange(int flag) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    FbInit.fbXgaDispControl(flag);

    // RM-5900の場合、画面の横幅が広いので網掛けを行う
    if (cBuf.vtclRm5900RegsOnFlg) {
      Rc59dsp.rc59HalfWindow(flag);
    }
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 顧客情報表示部を元にもどすための処理
  /// 関連tprxソース: rc_28dsp.c - rc28Mbr_Clear_Disp
  static void	rc28MbrClearDisp(MbrDispData mbrParts) {
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 会員状態のマーク表示
  /// 引数:[zoomFlg] 拡大フラグ（MBRINFO_ZOOM=拡大  それ以外=通常）
  /// 引数:[pSubttl] 小計画像バッファ（NULLの時は登録バッファ）
  /// 引数:[clrFlg] 初期化フラグ（0=通常  1=初期化）
  /// 関連tprxソース: rc_28dsp.c - rcMbrInfo_Icon_Disp
  static void	rcMbrInfoIconDisp(int zoomFlg, SubttlInfo? subTtl, int clrFlg) {
  }

  // TODO:00016 佐藤 定義のみ追加
  ///関連tprxソース: rc_28dsp.c - rc28dsp_rcpt_btn_destroy
  static void	rc28DspRcptBtnDestroy(SubttlInfo subttl) {
  }

  // TODO:00016 佐藤 定義のみ追加
  ///関連tprxソース: rc_28dsp.c - rc_ModeFrameDisp
  static void	rcModeFrameDisp(int clearFlg) {
  }

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// サブ顧客表示部の描画処理
  /// 引数:[pSubttl] 小計画像バッファ（NULLの時は登録バッファ）
  /// 引数:[actFlg] 現在の状態フラグ
  /// 引数:[clrFlg] 初期化フラグ（0=通常  1=初期化）
  /// 関連tprxソース: rc_28dsp.c - rcDisp_MbrSubInfo
  static void rcDispMbrSubInfo(SubttlInfo? pSubttl, int actFlg, int clrFlg) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 通番訂正 差額返金中は小計画面に描画するようにする
  /// 引数:[pSubttl] 小計画像バッファ（NULLの時は登録バッファ）
  /// 関連tprxソース: rc_28dsp.c - rc28CreateParts_rcpt_btn
  static void rc28CreatePartsRcptBtn(SubttlInfo? pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 関連tprxソース: rc_28dsp.c - rcCardForgot_28StlLCD
  static void rcCardForgot28StlLCD(SubttlInfo? pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 関連tprxソース: rc_28dsp.c - rcTabData_StlDisplay
  static void rcTabDataStlDisplay(int tabNum, SubttlInfo? pSubttl, int dspFlg) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 関連tprxソース: rc_28dsp.c - rcTabCounter_StlDataSet
  static void rcTabCounterStlDataSet(int tabNum, SubttlInfo? pSubttl) {}
}

class InfoSlctData {
  static int keyCd = 0;
  static int AllChg = 0;
//   INFO_SLCT_MODE	Mode;
//   GtkWidget	*hfWindow;
//   GtkWidget	*AllBtn;
//   GtkWidget	*QuitBtn;
//   GtkWidget	*QuitMsg;
//   QtyChgData	QtyChg;
//   REGSMEM		bkMem;
//   int		Win_Col;	//画面色
// //以下免税関連
//   GtkWidget	*ConfBtn;	//確定ボタン
//   GtkWidget	*Entry_Amt1;	//免税消耗品合計金額
//   GtkWidget	*Entry_Amt2;	//免税一般物品合計金額
//   GtkWidget	*Taxfree_Pack_Gud;	//免税梱包ガイダンス
//   GtkWidget	*Taxfree_NotUp_Gud;	//基準に達してないガイダンス
//   GtkWidget	*Taxfree_Do_Gud;	//操作ガイダンス
//   GtkWidget	*TaxItemBtn;	//課税変更ボタン
//   GtkWidget	*TaxItem_Gud;	//課税変更ガイダンス
//   GtkWidget	*tlWindow;	//明細したにAllBtn表示
//   TaxFreeNumData	Taxfree_OrgNo;	//免税元伝票
}

enum InfoSlctMode {
  INFO_SLCT_NOT,
  INFO_SLCT_CHGTAX,
  INFO_SLCT_TAXFREE,
}