/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:tmode2.h
//  このファイルは上記ヘッダーファイルを元にdart化したものです。

// ************************************************************************
// File:      tmode2.h
// Contents:  if_th_AllocArea();
// ************************************************************************

class Tmode2 {


/*define use print test*/

  static const int STATUS_TIME = 2000;
/* continue pprint wait timer */
/*
  static const int CONT_TIME = 0;
*/
  static const int CONT_TIME = 500;

  static const int MAX_WIDTH = 424; /*448*/
  static const int MAX_HEIGHT = 3200;

  static const int FEED_LINE = 328; /* 464 */ /* Test Feed Area */
  static const int FEED_LINE_TMP = 12;

  static const int PRINT_LINE1 = 49; /*Line1 Area */
  static const int PRINT_LINE2 = 205; /*Line2 Area */

  static const int PRINT_STR1 = 160; /*string1 Area*/
  static const int PRINT_STR2 = 250; /*string2 Area*/

  static const int TEST_STARTX = 0;
  static const int TEST_STARTY = 0;

  static const int FEED_WATTR = 0;
  static const int FEED_SE_WIDTH = 1;
  static const int FEED_LINE_WIDTH = 40;
  static const int FEED_LINE_HEIGHT = 12;

  static const int TEST1_LINE_WIDTH = 60;
  static const int TEST1_LINE_HEIGHT = 24;
  static const int TEST1_LINE_SPACE = 15;
  static const int TEST1_WATTR = 0;

  static const int TEST2_LINE_WIDTH = 96;
  static const int TEST2_LINE_HEIGHT = 24; /*24*/
  static const int TEST2_WATTR = 0;

  static const int TEST_LINE_WATTR = 0;
  static const int TEST_LINE_HEIGHT1 = 1;
  static const int TEST_LINE_HEIGHT2 = 2;

  static const int SOLID_LINE = 0;
  static const int DOTTED_LINE = 1;
  static const int BROKEN_LINE = 2;

  static const int THIN_LINE = 1;   // 細線
  static const int MIDIUM_LINE = 2; // 中太線
  static const int THICK_LINE = 3;  // 太線

  static const int MAX_BUF8_16 = 40; /* string Line */
  static const int MAX_BUF12_24 = 28;

  static const int START_BUF = 0x30; /* '0' */
  static const int END_BUF = 0x60; /* '`' */
  static const int MAX_LINE = 10;

  static const int VF_FONT1 = 16;
  static const int VF_FONT2 = 24;

  static const int CHAR_HEIGHT1 = 16;
  static const int CHAR_HEIGHT2 = 25;
  static const int TEST_CHAR_WATTR = 0;

  static const int Y_SPACE8_16 = 4;
  static const int Y_SPACE12_24 = 7;

/*
  static const String DEFAULT_FONT = "timR18.pcf";
  static const String DEFAULT_FONT = "k14goth.pcf";
*/
/*
  static const String DEFAULT_FONT_E = "cour.pfa";
  static const String DEFAULT_FONT_J = "wadalab-gothic.ttf";
*/
  static const String DEFAULT_FONT_E = "rgmhhc24.bdf";

  static const int CUT_FEED = 200;

}
