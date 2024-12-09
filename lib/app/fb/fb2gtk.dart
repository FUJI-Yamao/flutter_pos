/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../regs/checker/rcquicpay_com.dart';
import '../ui/colorfont/c_basefont.dart';
import 'fb_init.dart';
import 'fb_label.dart';
import 'fb_lib.dart';
import 'fb_machin.dart';
import 'fb_parts.dart';

///  FrameBuffer to Gtk Library
///  関連tprxソース: fb2gtk.h
class Fb2Gtk {

  static const EL_FIXED_MAX = 10;

  ///  関連tprxソース: fb2gtk.h - typedef	gint(*GtkFunction) (gpointer data);
  static int gtkFunction_rcMultiQPReduceAct() {
    // TODO:00008 宮家 単純置き換えではないため保留
    RcQuicPayCom.rcMultiQPReduceAct();
    return 0;
  }

  ///  関連tprxソース: fb2gtk.h - typedef	gint(*GtkFunction) (gpointer data);
  static int gtkFunction_rcChkFapQPStatR() {
    // TODO:00008 宮家 単純置き換えではないため保留
    RcQuicPayCom.rcChkFapQPStatR();
    return 0;
  }

  static void gtk_init() {
    FbMachin.timeoutInit();

    // #ifdef FB_MEMO
    // FBMemo_Init();
    // #endif
    // #if FB_DPER
    // FB_dPerSetting();
    // #endif

    FbInit.fbVerticalFhdSet(); /* 縦型21.5インチであれば識別フラグセット */
    FbInit.fbVtclFhdFselfSet(); /* 15.6インチ対面セルフであれば識別フラグセット */
    FbInit.fbVerticalRm5900Set();
  }

  ///  関連tprxソース: fb2gtk.h - typedef	gint(*GtkFunction) (gpointer data);
  static int gtkFunction_rcMultiQPTREndProc() {
    // TODO:00008 宮家 単純置き換えではないため保留
    RcQuicPayCom.rcMultiQPTREndProc();
    return 0;
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_timeout_add(a,b,c)			Timeout_Add(a,b,c)
  static int gtkTimeoutAdd(int timer, Function func, Object data) {
    return FbMachin.timeoutAdd(timer, func, data);
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_timeout_remove(a)			Timeout_Remove(a)
  static void gtkTimeoutRemove(int tag) {
    FbMachin.timeoutRemove(tag);
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_object_set_data_full(a,b,c,d)	gtk_object_set_data(a,b,c)
  static void gtkObjectSetDataFull(
      Object? object, String key, Object? data, int unUse) {
    gtkObjectSetData(object, key, data);
    return;
  }

  ///  関連tprxソース: fb2gtk.c - gtk_object_set_data
  static void gtkObjectSetData(Object? object, String key, Object? data) {
    return;
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_container_border_width(a,b)		Parts_Border(a,b)
  static void gtkContainerBorderWidth(Object? parts, int borderSiz) {
    FbParts.partsBorder(parts, borderSiz);
    return;
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_select_button_set_color(a,b)	ChgColor(a,NULL,&ColorSelect[b],NULL)
  static void gtkSelectButtonSetColor(Object? widget, int bgColorIndex) {
    FbLib.chgColor(
        widget,
        Color_Select[FbColorGroup.FB_ColorMax.index],
        Color_Select[bgColorIndex],
        Color_Select[FbColorGroup.FB_ColorMax.index]);
    return;
  }

  ///  関連tprxソース: fb2gtk.h - gtk_top_menu_new_with_size(a,b,c,d,e,f)	gtk_top_menu_new_with(a,b,c,d,e,f,-1,-1,FONT16)
  static Object? gtkTopMenuNewWithSize(
      String title, int w, int h, int lColor, int fillColor, int backColor) {
    return gtkTopMenuNewWith(title, w, h, lColor, fillColor, backColor, 1, 1,
        BaseFont.font16px.toInt());
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_top_menu_new_with
  static Object? gtkTopMenuNewWith(String title, int w, int h, int lColor,
      int fillColor, int backColor, int Fw, int Fh, int fontTyp) {
    return Object();
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_widget_show(a)  gtk_widget_memchk_show(a, __FUNCTION__, __LINE__)
  static void gtkWidgetShow(Object? widget, String function) {
    int __LINE__ = 0;
    gtkWidgetMemchkShow(widget, function, __LINE__);
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_widget_memchk_show
  static void gtkWidgetMemchkShow(Object? widget, stringfunc, int line) {
    return;
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_widget_hide(a)			Parts_Hide(a)
  static void gtkWidgetHide(Object? parts) {
    FbParts.partsHide(parts);
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_grab_add
  static void gtkGrabAdd(Object? widget) {
    return;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_grab_get_current
  static Object? gtkGrabGetCurrent() {
    return null;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_grab_remove
  static void gtkGrabRemove(Object? widget) {
    return;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_window_new
  static Object? gtkWindowNew(int type) {
    return null;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_window_set_title
  static void gtkWindowSetTitle(Object? window, String title) {
    return;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_window_set_position
  static void gtkWindowSetPosition(Object? window, int position) {
    return;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_widget_set_usize
  static void gtkWidgetSetUsize(Object? widget, int width, int height) {
    return;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_container_add
  static void gtkContainerAdd(Object? container, Object? widget) {
    return;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_widget_ref
  static void gtkWidgetRef(Object? widget) {
    return;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_fixed_put
  static void gtkFixedPut(Object? fixed, Object? widget, int x, int y) {
    return;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_signal_connect
  static int gtkSignalConnect(
      Object? object, String name, Function func, Object? funcData) {
    return 0;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_widget_set_sensitive
  static void gtkWidgetSetSensitive(Object? widget, bool sensitive) {
    return;
  }

  ///  関連tprxソース: fb2gtk.c - sysCursorOff
  static int sysCursorOff(Object? window) {
    return 0;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_widget_destroy
  static void gtkWidgetDestroy(Object? widget) {
    return;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_window_new_typ
  static Object? gtkWindowNewTyp(int type, int flg) {
    return gtkWindowNewTypMain(type, flg, 0);
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_window_new_typ_main
  static Object? gtkWindowNewTypMain(int type, int flg, int drawTyp) {
    return Object();
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_fixed_new()				gtk_draw_new(0)
  static Object? gtkFixedNew() {
    return gtkDrawNew(0);
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_draw_new
  static Object? gtkDrawNew(int type) {
    return Object();
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_round_button_new_with_label(a)	gtk_button_new_with_label(a)
  static Object? gtkRoundButtonNewWithLabel(String name) {
    return gtkButtonNewWithLabel(name);
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_button_new_with_label(a)		gtk_round_button_new_with_size(a, -1)
  static Object? gtkButtonNewWithLabel(String name) {
    return gtkRoundButtonNewWithSize(name, -1);
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_round_button_new_with_size(a,b)	gtk_button_new_with_size(a,b)
  static Object? gtkRoundButtonNewWithSize(String name, int size) {
    return gtkButtonNewWithSize(name, size);
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_button_new_with_size(a,b)		gtk_button_new_with_size_group(a,b,0,0)
  static Object? gtkButtonNewWithSize(String name, int size) {
    return gtkButtonNewWithSizeGroup(name, size, 0, 0);
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_button_new_with_size_group
  static Object? gtkButtonNewWithSizeGroup(
      String name, int size, int group, int typ) {
    return gtkButtonNewWithSizeGroupMain(name, size, group, typ, 0);
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_button_new_with_size_group_main
  static Object? gtkButtonNewWithSizeGroupMain(
      String name, int size, int group, int typ, int fontSize) {
    return FbParts.partsNew(3, Object(), 0, Object());
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_round_button_set_color
  static void gtkRoundButtonSetColor(Object? roundButton, int colNo) {
    return;
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_regsbutton_set_color_label(a,b)	Label_Change(a,NULL,b,-1)
  static void gtkRegsbuttonSetColorLabel(Object? lblInf, int lColor) {
    return FbLabel.labelChange(lblInf, '', lColor, 1);
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_signal_connect_object(a,b,c,d)	gtk_signal_connect(a,b,c,d)
  static int gtkSignalConnectObject(
      Object? object, String name, Function func, Object? funcData) {
    return gtkSignalConnect(object, name, func, funcData);
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_round_entry_new()			gtk_entry_new()
  static Object? gtkRoundEntryNew() {
    return gtkEntryNew();
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_entry_new()				gtk_entry_new_with_max_length(0)
  static Object? gtkEntryNew() {
    return gtkEntryNewWithMaxLength(0);
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_entry_new_with_max_length
  static Object? gtkEntryNewWithMaxLength(int max) {
    return Object();
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_round_entry_set_editable(a,b)	gtk_entry_set_editable(a,b)
  static void gtkRoundEntrySetEditable(Object? entry, bool editable) {
    return gtkEntrySetEditable(entry, editable);
  }

  ///  関連tprxソース: fb2gtk.c - gtk_entry_set_editable
  static void gtkEntrySetEditable(Object? entry, bool editable) {
    /// 処理なし
    return;
  }

  ///  関連tprxソース: fb2gtk.c - gtk_round_entry_set_bgcolor
  static void gtkRoundEntrySetBgcolor(Object? entry, int colNo) {
    /// 処理なし
    return;
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_round_entry_set_text(a,b)		gtk_entry_set_text(a,b)
  static void gtkRoundEntrySetText(Object? lblInf, String image) {
    return gtkEntrySetText(lblInf, image);
  }

  ///  関連tprxソース: fb2gtk.h - #define	gtk_entry_set_text(a,b)			Label_Change(a,b,-1,-1)
  static void gtkEntrySetText(Object? lblInf, String image) {
    return FbLabel.labelChange(lblInf, image, -1, -1);
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_label_new
  static Object? gtkLabelNew(String str) {
    return Object();
  }

  ///  関連tprxソース: fb2gtk.h - define	gtk_misc_set_alignment(a,b,c)		gtk_label_set_align(a,b,c)
  static void gtkMiscSetAlignment(Object? widget, double x, double y) {
    return gtkLabelSetAlign(widget, x, y);
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_label_set_align
  static void gtkLabelSetAlign(Object? widget, double x, double y) {
    return;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_widget_show_all
  static void gtkWidgetShowAll(Object? widget) {
    return;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: fb2gtk.c - gtk_label_line_new
  static Object? gtkLabelLineNew(String str, int labelColor, int lineColor,
      int backColor, int lineType, int fontSize) {
    return Object();
  }
}
