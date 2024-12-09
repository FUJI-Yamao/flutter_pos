/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'fb_style.dart';

/// 共通メモリ定義
///  関連tprxソース:fb_lib.h
///

enum FbPosiXGroup {
  L_XCenter(0),
  L_XRight(1),
  L_XLeft(2);

  final int value;
  const FbPosiXGroup(this.value);
  static int get FB_XPosiMax => FbPosiXGroup.values.last.value + 1;
}

enum FbPosiYGroup {
  L_YCenter(0),
  L_YTop(1);

  final int value;
  const FbPosiYGroup(this.value);
  static int get FB_YPosiMax => FbPosiYGroup.values.last.value + 1;
}

enum FbEventGroup {
  FB_MOUSEDOWN(0),
  FB_KEYDOWN(1);

  final int value;
  const FbEventGroup(this.value);
  static int get EventGroupMax => FbEventGroup.values.last.value + 1;
}

enum TimerControl {
  FB_TIME_STOP(0),
  FB_TIME_START(1),
  FB_TIME_CONTINUE(2);

  final int value;
  const TimerControl(this.value);
  static int get FB_TIME_CONTROL_MAX => TimerControl.values.last.value + 1;
}
// enum TimerControl {
//   FB_TIME_STOP,
//   FB_TIME_START,
//   FB_TIME_CONTINUE;
// }


enum FbAttachOptions {
  FB_EXPAND(1 << 0),
  FB_SHRINK(1 << 1),
  FB_FILL(1 << 2);

  final int value;
  const FbAttachOptions(this.value);
}

/// define
class FbLibDef {
  static const FALSE = 0;
  static const TIMER_MAX = 12;
  static const SAVEMAX = 5;
  static const FB_MEMO_MAX = 5;
  static const FB_ALLMEMO_MAX = (FB_MEMO_MAX * 2) + 1;
}

/// PLUS_DRV_CHK
class PlusDrvChk {
  static const PLUS_SCAN_D = 0;
  static const PLUS_SCAN_T = 1;
  static const PLUS_FIP_D = 2;
  static const PLUS_FIP_T = 3;
  static const PLUS_TPANEL_D = 4;
  static const PLUS_TPANEL_T = 5;
  static const PLUS_MKEY_D = 6;
  static const PLUS_MKEY_T = 7;
  static const PLUS_MSR_D = 8;
  static const PLUS_MSR_T = 9;
  static const PLUS_TPRTF = 10;
  static const PLUS_SMSCLSC = 11;
  static const PLUS_SIGNP = 12;
  static const PLUS_FIP_3 = 13;
  static const PLUS_TPRTF2 = 14;
  static const PLUS_TPANEL_A = 15;
  static const PLUS_ICCARD = 16;
  static const PLUS_MST = 17;
  static const PLUS_CPNPRN = 18;
  static const PLUS_POWLI = 19;
  static const PLUS_SCAN_P = 20;
  static const PLUS_APBF = 21;
  static const PLUS_SCALERM = 22;
  static const PLUS_TPANEL_N = 23;
  static const PLUS_EXC = 24;
  static const PLUS_HITOUCH = 25;
  static const PLUS_AMI = 26;
  static const PLUS_SCALE_SKS = 27;
  static const PLUS_DRV_CHK_MAX = 28;
}

///  PLUS_DRV_STAT
class PlusDrvStat {
  static const PLUS_STS_NOT_ACT = '0';
  static const PLUS_STS_COM_REQ_REOPEN = '1';
  static const PLUS_STS_MNG_SET_OK = '2';
  static const PLUS_STS_MNG_REOPEN_NG = '3';
  static const PLUS_STS_COM_REQ_CLOSE = '4';
  static const PLUS_STS_MSG_SET_CLOSE = '5';
  static const PLUS_STS_COM_REQ_REOPEN2 = '6';
  static const PLUS_STS_MNG_REOPEN2_NG = '7';
  static const PLUS_STS_NOW_OFFLINE8 = '8';
}

/// FB_Rect
class FbRect {
  int x = 0;
  int y = 0;
  int w = 0;
  int h = 0;
}

/// FB_Kanji14, FB_Kanji16, FB_Kanji24
class FbKanji {
  int k_size = 0;
  int a_size = 0;
}

///  関連tprxソース: fb_lib.h - FB_Timer
class FbTimer {
  int          timer = 0;
  Function?    func;
  Object?      data;
  TimerControl flag = TimerControl.FB_TIME_STOP;
  int          first = 0;
  DateTime?    ct1;
}

///  関連tprxソース: fb_lib.h - FB_ColorGroup
enum FbColorGroup {
  Yellow,
  Orange,
  Pink,
  Purple,
  SkyBlue,
  TurquoiseBlue,
  LightGreen,
  Navy,
  Red,
  Lime,
  DarkNavy,
  BlackGray,
  DarkGray,
  MediumGray,
  LightGray,
  White,
  Black,
  Silver,
  LightGray2,
  Silver2,
  Silver3,
  Green,
  LightYellow,
  DarkBlue,
  DarkPink,
  Silver4,
  ColorNone,
  DarkBrown,
  CreamYellow,
  Salmon,
  SeaGreen,
  LightPurple,
  LightBlue,
  LightBrown,
  SandyBrown,
  MidNightBlue,
  DarkRed,
  PalePink,
  LightOrange,
  NaturalOrange,
  EmeraldGreen,
  PaleGreen,
  MintGreen,
  BabyYellow,
  PapayaWhip,
  PalePurple,
  GrayishBrown,
  DarkPurple,
// #ifdef FB_EL
  // TODO:10055 コンパイルスイッチ(FB_EL) IDをDBにセットしているとかがあるとずれるため、要確認
  ELAll,
  ELHalf,
  ELNone,
// #endif
  TrueRed,
  TrueBlue,
  ReddishBrown,
  IceBlue,
  BeansBrown,
  LightGray3,
  SkyBlue2,
  DeepOrange,
  GrayishNavy,
  LightBlue2,
  CreamYellow2,
  DeepSalmon,
  DarkGreen,
  White2, // RM-3800で追加
  EmeraldGreen2, // RM-3800で追加
  LightGray4, // RM-3800で追加
  White3, // RM-3800で追加
  LightGray5, // RM-3800で追加
  DarkTurquoise,
  LightNavy,
  LightBlue3, // RM-3800で追加 (灰みの青緑系の色)
  LightBlue4, // RM-3800で追加 (やや灰色い青緑系の色)
  CreamYellow3, // RM-3800で追加 (淡い黄系の色3)
  CreamYellow4, // RM-3800で追加 (淡い黄系の色4)
  ColorAuto,
  FB_ColorMax
}

///-----  共通メモリ構造体  ----
/// FB_MEM
class FbMem {
  int now_pid = 0;
  List<int> bfre_pid =
  List.generate(FbLibDef.SAVEMAX, (_) => 0); //pid_t[SAVE_MAX]
  int sub_now_pid = 0;
  List<int> sub_bfre_pid =
  List.generate(FbLibDef.SAVEMAX, (_) => 0); //pid_t[SAVE_MAX]
  int lock_pid = 0;
  FbKanji font_14 = FbKanji();
  FbKanji font_16 = FbKanji();
  FbKanji font_24 = FbKanji();
  int kbd_stop = 0;
  int show_up = 0;
//	Widget_Parts 	*fbMemo_m;
//	Widget_Parts 	*fbMemo_s;
  int fbMemo_stop = 0;
  int fbMemo_sound = 0;
  int fbMemo_sound_stop = 0;
//	time_t 		fbMemo_tm[FB_MEMO_MAX * 2];
  var fbMemo_tm = <Timer>[]; //time_t[FB_ALLMEMO_MAX]
  String fbMemo_not_read = ""; //char[FB_MEMO_MAX]
  int fbSoftmkey_stop = 0;
  List<String> drv_stat = List.generate(
      PlusDrvChk.PLUS_DRV_CHK_MAX, (_) => ""); //char[PLUS_DRV_CHK_MAX]
  List<int> drv_err = List.generate(
      PlusDrvChk.PLUS_DRV_CHK_MAX, (_) => 0); //int[PLUS_DRV_CHK_MAX]
  int rpt_rec = 0;
  int rpt_play = 0;
  int ftdi_sio_mediation = 0;
  int kbd_entry_flg = 0;
  int kbd_value1 = 0;
  int kbd_value2 = 0;
  String usb_stat = "";
  int mouse_control = 0; /* test */
  FbRect MovieNotDraw = FbRect();
  FbRect MovieNotDrawOpt = FbRect();
  int print_screen = 0;
  int fbPresetkey_start = 0;
  int Movie_Ctrl = 0;
  int softkey_noshow = 0;
  int fbCashRecycle_start = 0;
  int FBvnc = 0;
  int X_x = 0;
  int Y_y = 0;
  int optwin_def_dsp = 0;
  int vtcl_rm5900_flg = 0;
  int vtcl_fhd_flg = 0; /* 縦型21.5インチフラグ */
  int vtcl_fhd_fself_flg = 0; /* 縦型15.6インチ対面フラグ */

  static final FbMem _instance = FbMem._internal();
  factory FbMem() {
    return _instance;
  }
  FbMem._internal();
}

///  関連tprxソース: fb_lib.h - Color_Select
class ColorSelect {
  int pixel = 0;
  int red = 0;
  int green = 0;
  int blue = 0;
  ColorSelect(this.pixel, this.red, this.green, this.blue);
}

///  関連tprxソース: fb_lib.h - Color_Select
final List<ColorSelect> Color_Select = [
  ColorSelect(0, 0xff, 0xcc, 0x66), /* YE Yellow         */
  ColorSelect(0, 0xff, 0x99, 0x66), /* OR Orange         */
  ColorSelect(0, 0xff, 0x99, 0x99), /* PI Pink           */
  ColorSelect(0, 0xcc, 0x99, 0xcc), /* PU Purple         */
  ColorSelect(0, 0x99, 0x99, 0xff), /* SB Sky Blue       */
  ColorSelect(0, 0x66, 0x99, 0xcc), /* TB Turquoise Blue */
  ColorSelect(0, 0x66, 0xcc, 0x99), /* LG Light Green    */
  ColorSelect(0, 0x66, 0x66, 0x99), /* NA Navy           */
  ColorSelect(0, 0xff, 0x33, 0x00), /* RE Red            */
  ColorSelect(0, 0xcc, 0xff, 0x66), /* LI Lime           */
  ColorSelect(0, 0x00, 0x00, 0x33), /* DN Dark Navy      */
  ColorSelect(0, 0x33, 0x33, 0x33), /* BG Black Gray     */
  ColorSelect(0, 0x66, 0x66, 0x66), /* DG Dark Gray      */
  ColorSelect(0, 0x99, 0x99, 0x99), /* MG Midium Gray    */
  ColorSelect(0, 0xcc, 0xcc, 0xcc), /* LG Light Gray     */
  ColorSelect(0, 0xff, 0xff, 0xff), /* WH White          */
  ColorSelect(0, 0x01, 0x01, 0x01), /* BK Black          */
  ColorSelect(0, 0xc0, 0xc0, 0xc0), /* Silver	       */
  ColorSelect(0, 0xe5, 0xe5, 0xe5), /* LG2 Light Gray2   */
  ColorSelect(0, 0xff, 0x44, 0x00), /* Silver2(Red)      */
  ColorSelect(0, 0x00, 0x00, 0xfe), /* Silver3(Blue)     */
  ColorSelect(0, 0x00, 0xff, 0x00), /* Green             */
  ColorSelect(0, 0xfa, 0xf4, 0x6e), /* LY Light Yellow   */
  ColorSelect(0, 0x0b, 0x43, 0xf6), /* DB Dark Blue      */
  ColorSelect(0, 0xfe, 0x60, 0xec), /* DP Dark Pink      */
  ColorSelect(0, 0xf0, 0x06, 0x7b), /* Silver4(Purple)   */
  ColorSelect(0,   0,   0,   0), /* ColorNone */
  ColorSelect(0,  79,  39,   0), /* DarkBrown */
  ColorSelect(0, 251, 220, 137), /* CreamYellow */
  ColorSelect(0, 240, 188, 166), /* Salmon */
  ColorSelect(0, 168, 210, 160), /* SeaGreen */
  ColorSelect(0, 180, 166, 201), /* LightPurple */
  ColorSelect(0, 189, 222, 231), /* LightBlue */
  ColorSelect(0, 216, 190, 165), /* LightBrown */
  ColorSelect(0, 232, 183, 124), /* SandyBrown */
  ColorSelect(0,   8,  51, 102), /* MidNightBlue */
  ColorSelect(0, 204,   0,   1), /* DarkRed */
  ColorSelect(0, 250, 215, 221), /* PalePink */
  ColorSelect(0, 247, 224, 145), /* LightOrange */
  ColorSelect(0, 247, 116,  36), /* NaturalOrange */
  ColorSelect(0,  84, 177, 179), /* EmeraldGreen */
  ColorSelect(0, 231, 239, 190), /* PaleGreen */
  ColorSelect(0, 217, 240, 233), /* MintGreen */
  ColorSelect(0, 255, 255, 206), /* BabyYellow */
  ColorSelect(0, 253, 239, 204), /* PapayaWhip */
  ColorSelect(0, 217, 188, 215), /* PalePurple */
  ColorSelect(0, 206, 189, 178), /* GrayishBrown */
  ColorSelect(0, 102,   0,  51), /* DarkPurple */
  ColorSelect(0, 0xff, 0x0c, 0x00), /* ELAll             */
  ColorSelect(0, 0x00, 0x04, 0xff), /* ELHalf            */
  ColorSelect(0, 0x00, 0x00, 0x33), /* ELNone            */
  ColorSelect(0, 0xff, 0x00, 0x00), /* TrueRed           */
  ColorSelect(0, 0x00, 0x00, 0xff), /* TrueBlue          */
  ColorSelect(0, 154,   1,   1),    /* ReddishBrown      */
  ColorSelect(0, 210, 255, 255),    /* IceBlue           */
  ColorSelect(0,  63,  31,   0),    /* BeansBrown        */
  ColorSelect(0, 216, 218, 220),    /* LightGray3        */
  ColorSelect(0,  78, 166, 255),    /* SkyBlue2          */
  ColorSelect(0, 255,  63,   0),    /* DeepOrange        */
  ColorSelect(0,  51,  71,  94),    /* GrayishNavy       */
  ColorSelect(0, 225, 240, 255),    /* LightBlue2        */
  ColorSelect(0, 255, 255, 153),    /* CreamYellow2      */
  ColorSelect(0, 255, 118, 71),     /* DeepSalmon        */
  ColorSelect(0, 0, 100, 0),     /* DarkGreen        */
  ColorSelect(0, 239, 239, 239),     /* White2		*/ /* rgba(239, 239, 239, 1) */ /* RM-3800のプリセットで使用 */
  ColorSelect(0, 211, 227, 227),     /* EmeraldGreen2	*/ /* rgba(211, 227, 227, 1) */ /* RM-3800の緑帯で使用 */
  ColorSelect(0, 237, 237, 232),     /* LightGray4	*/ /* rgba(237, 237, 232, 1) */ /* RM-3800の小計、スプリットで使用 */
  ColorSelect(0, 245, 245, 245),     /* White3		*/ /* rgba(245, 245, 245, 1) */ /* RM-3800の明細表示(奇数段)で使用 */
  ColorSelect(0, 228, 228, 228),     /* LightGray5	*/ /* rgba(228, 228, 228, 1) */ /* RM-3800の明細表示(偶数段)で使用 */
  ColorSelect(0,   0, 204, 204),    /* DarkTurquoise     */
  ColorSelect(0, 102, 102, 255),    /* LightNavy         */
  ColorSelect(0, 153, 208, 208),     /* LightBlue3	*/ /* rgba(153, 208, 208, 1) */ /* RM-3800の登録置数欄 */
  ColorSelect(0, 229, 239, 239),     /* LightBlue4	*/ /* rgba(229, 239, 239, 1) */ /* RM-3800の小計置数欄 */
  ColorSelect(0, 255, 248, 185),     /* CreamYellow3	*/ /* rgba(255, 248, 185, 1) */ /* RM-3800のお釣り欄 */
  ColorSelect(0, 255, 248, 220),     /* CreamYellow4	*/ /* rgba(255, 248, 220, 1) */ /* RM-3800のハイタッチボタン */

  ColorSelect(-1, -1  , -1  , -1  )  /* none             */
];

/// 関連tprxソース:fb_lib.h fb_lib.c
class FbLib {
  ///  関連tprxソース: fb_lib.h - #define	ChgColor(a,b,c,d)	ChgStyle(a,b,c,d,-1)
  static void chgColor(Object? widget, ColorSelect fg, ColorSelect bg,
      ColorSelect base) {
    FbStyle.chgStyle(widget,fg,bg,base,-1);
    return;
  }
}

/// 関連tprxソース:fb_lib.h FB_Group
class FBGroup {
  int groupNo = 0;
  int no = 0;
}