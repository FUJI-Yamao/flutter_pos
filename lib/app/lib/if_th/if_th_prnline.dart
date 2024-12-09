/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_prnline.c
//  このファイルは上記Cソースファイルを元にdart化したものです。

// ************************************************************************
// File:           if_th_prnline.c
// Contents:       if_th_PrintLine();
// ************************************************************************

import 'dart:convert';

import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/lib/if_th.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/sys/tmode/tmode2.dart';

import '../../if/common/interface_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_thlib.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_type.dart';
import 'if_th_com.dart';

class IfThPrnline {

  static const TRUE = 1;
  static const FALSE = 0;

  static ThPrnBuf tPrnBuf = ThPrnBuf();	/* Print buffer */

  /* Locals */
  static	List<int>	aBitResetChar = [	/* Mask data for reset one bit */
    0x7F, 0xBF, 0xDF, 0xEF, 0xF7, 0xFB, 0xFD, 0xFE
  ];
  static	List<int>	aBitSetChar = [	/* Mask data for set one bit */
    0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01
  ];

  static String moji_c = "";			/* Current modifing byte data */
  static int flg = 0;
  static int w_b_flg = 0;

  static int start_bit = 0;		/* X-start bit offset */
  static int end_bit = 0;		/* X-end bit offset */
  static int cnt = 0;			/* Loop byte counter(horizontal) */
  static int height = 0;			/* Loop line counter(vertical) */
  static int Ypos = 0;			/* Current top byte position of line */
  static int YT = 0;
  static int XT = 0;			/* Y and X loop counter */
  static int ten_flg = 0;		/* Status of dotted line drawing */
  static int style_cnt = 0;		/* Status of dotted line drawing */
  static int yoko_tate_flg = 0;		/* Kind of horizontal or vertical */
  static String moji_excl = "";		/* Current modifing one-byte data */
  static int byte_cnt = 0;		/* X size in bytes */
  static int YT_over = 0;		/* YT overflow value */

  //FILE *  DBG_FP = NULL;
  String DBG_HEADER = "<PRNLINE> ";

  static void DBG_PRINTF(String va_alist) {
    if (InterfaceDefine.DEBUG_UT) {
      debugPrint(va_alist);
    }
    return;
  }

  // /*-----------------------------------------------------------------------*/
  // /*
  // Usage:		if_th_PrintLine( TPRTID src, int wXpos, int wYpos, int wAttr, int wWidth,
  //          int wHeight, int wStyle )
  // Functions:	Setup bitmap data of line on print buffer
  // Parameters:	(IN)	src	: APL-ID
  //       wXpos	: Start X position
  //       wYpos	: Start Y position
  //       wAttr	: Print attribute(reverse,...)
  //       wWidth	: Line width in dots
  //       wHeight	: Line height in dots
  //       wStyle	: Line style(solid, dotted,...)
  // Return value:	IF_TH_POK	: Normal end
  //     IF_TH_PERPARAM	: Parameter error
  // */
  // /*-----------------------------------------------------------------------*/
  ///  関連tprxソース:if_th_prnline.c - if_th_PrintLine()
  static Future<int> ifThPrintLine(TprTID src, int wXpos, int wYpos, int wAttr, int wWidth, int wHeight, int wStyle) async {
    int x_length = 0, y_length = 0;		/* X,Y end position of the line */
    int moto_X_len = 0, moto_Y_len = 0;	/* Maximum X,Y size in dots */
    int x_position = 0;			/* X-start byte offset */

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    /* Adjust X offset */
    wXpos += tPrnBuf.x_offset;

    if (wHeight > wWidth) {		/* Check if vertical line or not */
      yoko_tate_flg = 1;
    } else {
      yoko_tate_flg = 0;
    }
    x_length   = wXpos + wWidth;
    moto_X_len = (tPrnBuf.crast * 8);     /* 1byte = 8dot */
    y_length   = wYpos + wHeight;
    moto_Y_len = tPrnBuf.cbtmline - tPrnBuf.ctopline;

    /* Check X and Y position */
    if ((wXpos < 0) || (wYpos < 0) || (wStyle < 0) || (wStyle > 2)) {
      debugPrint("IF_TH_PERPARAM : ERROR1");
      return (InterfaceDefine.IF_TH_PERPARAM);
    }
    if ((moto_X_len < wXpos) || (moto_X_len < x_length) ||
        (moto_Y_len < wYpos) || (moto_Y_len < y_length)) {
      debugPrint("IF_TH_PERPARAM : ERROR2");
      return (InterfaceDefine.IF_TH_PERPARAM);
    }

    if ((wWidth != 0) && (wHeight != 0)) {	/* acrose */
      if (moto_X_len < x_length) {
        DBG_PRINTF("crast=${tPrnBuf.crast}");
        DBG_PRINTF("IF_TH_PERPARAM : ERROR3");
        return (InterfaceDefine.IF_TH_PERPARAM);
      }
      if (wYpos != 0) {
        wXpos += ((tPrnBuf.crast * wYpos) % 80) * 8;
        if (wXpos > 80 * 8) {
          wXpos -= 640;
          wYpos = ((tPrnBuf.crast * wYpos) / 80).toInt();
          wYpos++;
        } else {
          wYpos = ((tPrnBuf.crast * wYpos) / 80).toInt();
        }
        // wYpos = (tPrnBuf.crast * wYpos) / 80;
      }

      x_length   = wXpos + wWidth;
      moto_X_len = (tPrnBuf.crast * 8);     /* 1byte = 8dot */
      y_length   = wYpos + wHeight;
      moto_Y_len = tPrnBuf.cbtmline - tPrnBuf.ctopline;

      byte_cnt   = (x_length / 8).toInt();
      end_bit    = x_length % 8;

      x_position = (wXpos / 8).toInt();
      start_bit  = wXpos % 8;

      DBG_PRINTF("byte_cnt = ${byte_cnt},end_bit = ${end_bit},"
          "x_position = ${x_position}, \start_bit = ${start_bit}");
      flg = 0;
      w_b_flg = 0;
      YT_over = 0;			/* 2002.02.07 */

      for (cnt = x_position ; cnt < byte_cnt + 1 ; cnt++) {
        if (cnt == x_position) {	/* START_acrose CASE 1 */
          startAcrose( wXpos, wYpos, wAttr, wWidth, wHeight, wStyle );
        } else if (cnt == byte_cnt) {	/* END_acrose CASE 2 */
          endAcrose( wXpos, wYpos, wAttr, wWidth, wHeight, wStyle );
        } else {			/* 8BIT_acrose CASE 3 */
          middleAcrose( wXpos, wYpos, wAttr, wWidth, wHeight, wStyle );
        }
      }
    } else {
      DBG_PRINTF("IF_TH_PERPARAM : ERROR4");
      return (InterfaceDefine.IF_TH_PERPARAM);
    }

    return (InterfaceDefine.IF_TH_POK);
  }

  ///  関連tprxソース:if_th_prnline.c - if_th_PrintLine()
  static Future<int> ifThPrintLineCloud(TprTID src,
        int pageWidth, int pageHeigth,
        int startX, int startY,
        int endX, int endY,
        int wAttr, int wThick, wStyle) async {

    String cmd = "";

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThPrintLineCloud　start");
      debugPrint("Start:(${startX},${startY}) End:(${endX},${endY})");
    }

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (((wStyle < Tmode2.SOLID_LINE) && (Tmode2.BROKEN_LINE < wStyle)) ||
        ((wThick < Tmode2.THIN_LINE)  && (Tmode2.THICK_LINE  < wThick))) {
      // 線種が異常値の場合はエラーとする。
      debugPrint("IF_TH_PERPARAM : ERROR1");
      return (InterfaceDefine.IF_TH_PERPARAM);
    }
    if ((startX < 0) || (startY < 0) || (endX < 0) || (endY < 0)) {
      // マイナス座標は線を引けない。
      debugPrint("IF_TH_PERPARAM : ERROR2");
      return (InterfaceDefine.IF_TH_PERPARAM);
    }
    if ((startX != endX) && (startY != endY)) {
      // 斜めの線は引かない。
      debugPrint("IF_TH_PERPARAM : ERROR3");
      return (InterfaceDefine.IF_TH_PERPARAM);
    }
    if ((startX == endX) && (startY == endY)) {
      // 始点と終点が同じ場合は線を引けない。
      debugPrint("IF_TH_PERPARAM : ERROR4");
      return (InterfaceDefine.IF_TH_PERPARAM);
    }

    // 始点側が大きければ終点側と入れ替える。
    if (startX > endX) {
      int tmp = startX;  startX = endX;  endX = tmp;
    }
    if (startY > endY) {
      int tmp = startY;  startY = endY;  endY = tmp;
    }

    // X軸方向にオフセットを加算する。
    startX += InterfaceDefine.IF_TH_LINE_X_OFFSET;
    endX   += InterfaceDefine.IF_TH_LINE_X_OFFSET;

    cmd += "\x1d" + "\x24";  // ページモードにおける縦方向絶対位置の指定
    cmd += latin1.decode([(startY & 0x00FF) >> 0]);
    cmd += latin1.decode([(startY & 0xFF00) >> 8]);
    cmd += "\x1b" + "\x24";  // 絶対位置の指定（左マージン位置を基準とした印字位置）
    cmd += "\x00" + "\x00";

    cmd += "\x13" + "\x28";  // DC3 + "("
    cmd += "\x41";           // "A" 罫線A選択
    cmd += "\x43";           // "C" 罫線のクリア
    cmd += "\x2B";           // "-" 罫線ON設定

    if (startY == endY) {
        cmd += "\x4c";       // "L" 罫線の設定（ﾄﾞｯﾄライン）
        cmd += latin1.decode([(startX >> 0) & 0xFF]);
        cmd += latin1.decode([(startX >> 8) & 0xFF]);
        cmd += latin1.decode([(endX >> 0) & 0xFF]);
        cmd += latin1.decode([(endX >> 8) & 0xFF]);
        cmd += "\x70";       // Line Print
        cmd += latin1.decode([(wThick >> 0) & 0xFF]);
        cmd += latin1.decode([(wThick >> 8) & 0xFF]);
    } else if (startX == endX) {
        cmd += "\x4c";       // "L" 罫線の設定（ﾄﾞｯﾄライン）
        cmd += latin1.decode([(startX >> 0) & 0xFF]);
        cmd += latin1.decode([(startX >> 8) & 0xFF]);
        cmd += latin1.decode([((startX + wThick) >> 0) & 0xFF]);
        cmd += latin1.decode([((startX + wThick) >> 8) & 0xFF]);
        cmd += "\x70";       // Line Print
        cmd += latin1.decode([((endY - startY) >> 0) & 0xFF]);
        cmd += latin1.decode([((endY - startY) >> 8) & 0xFF]);
    }
    cmd += "\x2D";           // "-" 罫線OFF設定
    cmd += "\x29";           // ")" 罫線命令の指定（解除）
    src = await IfThCom.ifThCmd(src, cmd, cmd.length, IfThLib.IF_TH_TYPE_CMD_BY_CHAR);

    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintCommand(cmd);
      debugPrint("ifThPrintLineCloud　end");
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  // オリジナル関数
  /// 罫線重ね合わせ選択　DCS3 ’#'
  static Future<int> ifThSuperPotision(TprTID src) async {
    int	ret = 0;
    int	prt_type = 0;
    List<String> cmd = List<String>.filled(3, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThSuperPotision　start");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    tPrnBuf.ctopline = tPrnBuf.cbtmline = 0;	/* Reset buffer */

    prt_type = await CmCksys.cmPrinterType();
    if (prt_type != CmSys.SUBCPU_PRINTER) {
      cmd[0] = "\x13";   // DCS3
      cmd[1] = "\x23";   // "#";
      cmd[2] = "\x00";   // OR重ね合わせモード;
      src = await IfThCom.ifThCmd(src, cmd.join(""), cmd.length, IfThLib.IF_TH_TYPE_CMD_BY_CHAR);
      if (InterfaceDefine.DEBUG_UT) {
        IfTh.debugPrintCommand(cmd.join());
        debugPrint("ifThSuperPotision　end");
      }
    }
    if ((src == Tpraid.TPRAID_PRN) || (src == Tpraid.TPRAID_QCJC_C_PRN)) {
      return (ret);
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  // オリジナル関数
  /// 罫線ON　DCS3 ’+'、　罫線OFF　DCS3 ’-'
  static Future<int> ifThRuleLineOnOff(TprTID src, bool onOff) async {
    int	ret = 0;
    int	prt_type = 0;
    List<String> cmd = List<String>.filled(2, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThRuleLineOnOff　start");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    tPrnBuf.ctopline = tPrnBuf.cbtmline = 0;	/* Reset buffer */

    prt_type = await CmCksys.cmPrinterType();
    if (prt_type != CmSys.SUBCPU_PRINTER) {
      cmd[0] = "\x13";   // DCS3
      if (onOff) {
        cmd[1] = "\x2B"; // "+";
      } else {
        cmd[1] = "\x2D"; // "-";
      }
      src = await IfThCom.ifThCmd(src, cmd.join(""), cmd.length, IfThLib.IF_TH_TYPE_CMD_BY_CHAR);
      if (InterfaceDefine.DEBUG_UT) {
        IfTh.debugPrintCommand(cmd.join());
        debugPrint("ifThRuleLineOnOff　end");
      }
    }
    if ((src == Tpraid.TPRAID_PRN) || (src == Tpraid.TPRAID_QCJC_C_PRN)) {
      return (ret);
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  // オリジナル関数
  /// 罫線バッファA選択　DCS3 ’A'、　罫線バッファB選択　DCS3 ’B'、　罫線クリア　DCS3 ’C'、
  static Future<int> ifThSelectRuleLine(TprTID src, String buf) async {
    int	ret = 0;
    int	prt_type = 0;
    List<String> cmd = List<String>.filled(2, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThSelectRuleLine　start");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    tPrnBuf.ctopline = tPrnBuf.cbtmline = 0;	/* Reset buffer */

    prt_type = await CmCksys.cmPrinterType();
    if (prt_type != CmSys.SUBCPU_PRINTER) {
      cmd[0] = "\x13";   // DCS3
      switch(buf) {
        case "A":
          cmd[1] = "\x41"; // "A";
          break;
        case "B":
          cmd[1] = "\x42"; // "B";
          break;
        case "C":
          cmd[1] = "\x43"; // "C";
          break;
      }
      src = await IfThCom.ifThCmd(src, cmd.join(""), cmd.length, IfThLib.IF_TH_TYPE_CMD_BY_CHAR);
      if (InterfaceDefine.DEBUG_UT) {
        IfTh.debugPrintCommand(cmd.join());
        debugPrint("ifThSelectRuleLine　end");
      }
    }
    if ((src == Tpraid.TPRAID_PRN) || (src == Tpraid.TPRAID_QCJC_C_PRN)) {
      return (ret);
    }
    return (InterfaceDefine.IF_TH_POK);
  }


  static (int wThick, int wStyle) getLineStyle(String sStyle) {
    int wThick = 0;
    int wStyle = 0;
    // 線種設定
    // 線種設定
    switch(sStyle) {
      case "Medium":  // 中太実線
        wStyle = Tmode2.SOLID_LINE;
        wThick = Tmode2.MIDIUM_LINE;
        break;
      case "Thin":  // 細実線
        wStyle = Tmode2.SOLID_LINE;
        wThick = Tmode2.THIN_LINE;
        break;
      case "Thick":  // 太実線
        wStyle = Tmode2.SOLID_LINE;
        wThick = Tmode2.THICK_LINE;
        break;
      default:
        break;
    }
    return (wThick, wStyle);
  }

  /*-----------------------------------------------------------------------*/
  /*
  Usage:		start_acrose( int wXpos, int wYpos, int wAttr, int wWidth, int wHeight, int wStyle )
  Functions:	Make one byte bitmap in start part
  Parameters:	(IN)	wXpos	: Start X position
        wYpos	: Start Y position
        wAttr	: Print attribute(reverse,...)
        wWidth	: Line width in dots
        wHeight	: Line height in dots
        wStyle	: Line style(solid, dotted,...)
  */
  /*-----------------------------------------------------------------------*/
  ///  関連tprxソース:if_th_prnline.c - start_acrose()
  static Future<void> startAcrose(int wXpos, int wYpos, int wAttr, int wWidth, int wHeight, int wStyle) async {
    List<List<String>> bitmap = List<List<String>>.filled(10, [""]);   //[Ypos][XT];

    bitmap[tPrnBuf.ctopline + wYpos][cnt] = tPrnBuf.bitmap[tPrnBuf.ctopline + wYpos][cnt];
    moji_c = tPrnBuf.bitmap[tPrnBuf.ctopline + wYpos][cnt];

    if (cnt == byte_cnt) {
      if (yoko_tate_flg == 1) { /* Column_Line */
        /* Exclusive_Line */
        ifBitBuffer(start_bit,end_bit - 1,0,wAttr ^ 0x02);
        moji_excl = moji_c;
        ifBitBuffer(start_bit,end_bit - 1,0,wAttr);
      } else {                    /* Acrose_Line */
        ifBitBuffer(start_bit,end_bit - 1,wStyle,wAttr);
      }
    } else {
      if (yoko_tate_flg == 1) { /* Column_Line */
        /* Exclusive_Line */
        ifBitBuffer(start_bit,7,0,wAttr ^ 0x02);
        moji_excl = moji_c;
        ifBitBuffer(start_bit,7,0,wAttr);
      } else {                    /* Acrose_Line */
        ifBitBuffer(start_bit,7,wStyle,wAttr);
      }
    }
    bitmap[tPrnBuf.ctopline + wYpos][cnt] = moji_c;
    if (wHeight != 1) {
      if ((wStyle != 0) && (yoko_tate_flg == 1)) {
        ten_flg = 0;
        style_cnt = 1;
        YT = 0;
        XT = cnt;
        for (height = 1; height < wHeight; height++) {
          if (tPrnBuf.crast != 80) {
            if (80 < XT + tPrnBuf.crast) {
              YT++;
              XT = (XT + tPrnBuf.crast) % 80;
              if ( 0 == XT ) {	/* 2002.2.7 */
                YT_over++;
              }
            } else {
              XT = XT + tPrnBuf.crast;
            }
            Ypos = tPrnBuf.ctopline + wYpos + YT;
          } else {
            Ypos = tPrnBuf.ctopline + wYpos + height;
          }
          /********************/
          /* 2dot - 2dot line */
          /********************/
          if (wStyle == 1) {
            if ((style_cnt == 2) && (ten_flg == 0)) {
              ten_flg = 1;
              style_cnt = 1;
              bitmap[Ypos][XT] = moji_excl;
            } else if ((style_cnt == 2) && (ten_flg == 1)) {
              ten_flg = 0;
              style_cnt = 1;
              bitmap[Ypos][XT] = moji_c;
            } else {
              if (ten_flg == 0) {
                bitmap[Ypos][XT] = moji_c;
              } else {
                bitmap[Ypos][XT] = moji_excl;
              }
              style_cnt++;
            }
          }
          /********************/
          /* 5dot - 3dot line */
          /********************/
          else {
            if ((style_cnt == 5) && (ten_flg == 0)) {
              ten_flg = 1;
              style_cnt = 1;
              bitmap[Ypos][XT] = moji_excl;
            } else if ((style_cnt == 3) && (ten_flg == 1)) {
              ten_flg = 0;
              style_cnt = 1;
              bitmap[Ypos][XT] = moji_c;
            } else {
              if (ten_flg == 0) {
                bitmap[Ypos][XT] = moji_c;
              } else {
                bitmap[Ypos][XT] = moji_excl;
              }
              style_cnt++;
            }
          }
        }
      }
      /********************/
      /* Straight line    */
      /********************/
      else {
        YT = 0;
        XT = cnt;
        for (height = 1; height < wHeight; height++) {
          if (tPrnBuf.crast != 80) {
            if (80 < XT + tPrnBuf.crast) {
              YT++;
              XT = (XT + tPrnBuf.crast) % 80;
              if ( 0 == XT ) {	/* 2002.2.7 */
                YT_over++;
              }
            } else {
              XT = XT + tPrnBuf.crast;
            }
            Ypos = tPrnBuf.ctopline + wYpos + YT;
          } else {
            Ypos = tPrnBuf.ctopline + wYpos + height;
          }
          bitmap[Ypos][XT] = moji_c;
        }
      }
    }
    if ((cnt == byte_cnt - 1) && (end_bit == 0)) {
      cnt++;
    }
    //tPrnBuf.bitmap[tPrnBuf.ctopline + wYpos] = bitmap[tPrnBuf.ctopline + wYpos].join("");
  }


  /*-----------------------------------------------------------------------*/
  /*
  Usage:		end_acrose( int wXpos, int wYpos, int wAttr, int wWidth, int wHeight, int wStyle )
  Functions:	Make one byte bitmap in end part
  Parameters:	(IN)	wXpos	: Start X position
        wYpos	: Start Y position
        wAttr	: Print attribute(reverse,...)
        wWidth	: Line width in dots
        wHeight	: Line height in dots
        wStyle	: Line style(solid, dotted,...)
  */
  /*-----------------------------------------------------------------------*/
  ///  関連tprxソース:if_th_prnline.c - end_acrose()
  static Future<void>	endAcrose( int wXpos, int wYpos, int wAttr, int wWidth, int wHeight, int wStyle ) async {
    List<List<String>> bitmap = List<List<String>>.filled(10, [""]);   //[Ypos][XT];

    bitmap[tPrnBuf.ctopline + wYpos][cnt] = tPrnBuf.bitmap[tPrnBuf.ctopline + wYpos][cnt];
    moji_c = tPrnBuf.bitmap[tPrnBuf.ctopline + wYpos][cnt];

    if (yoko_tate_flg == 1) {  /* Column_Line */
      /* Exclusive_Line */
      ifBitBuffer(0,end_bit - 1,0,wAttr ^ 0x02);
      moji_excl = moji_c;
      ifBitBuffer(0,end_bit - 1,0,wAttr);
    } else {                     /* Acrose_Line */
      ifBitBuffer(0,end_bit - 1,wStyle,wAttr);
    }
    bitmap[tPrnBuf.ctopline + wYpos][cnt] = moji_c;
    if (wHeight != 1) {
      if ((wStyle != 0) && (yoko_tate_flg == 1)) {
        ten_flg = 0;
        style_cnt = 1;
        YT = 0;
        XT = cnt;
        for (height = 1; height < wHeight; height++) {
          if (tPrnBuf.crast != 80) {
            if (80 < XT + tPrnBuf.crast) {
              YT++;
              XT = (XT + tPrnBuf.crast) % 80;
              if ( 0 == XT ) {	/* 2002.2.7 */
                YT_over++;
              }
            } else {
              XT = XT + tPrnBuf.crast;
            }
            Ypos = tPrnBuf.ctopline + wYpos + YT;
          } else {
            Ypos = tPrnBuf.ctopline + wYpos + height;
          }
          /********************/
          /* 2dot - 2dot line */
          /********************/
          if (wStyle == 1) {
            if ((style_cnt == 2) && (ten_flg == 0)) {
              ten_flg = 1;
              style_cnt = 1;
              bitmap[Ypos][XT] = moji_excl;
            } else if ((style_cnt == 2) && (ten_flg == 1)) {
              ten_flg = 0;
              style_cnt = 1;
              bitmap[Ypos][XT] = moji_c;
            } else {
              if (ten_flg == 0) {
                bitmap[Ypos][XT] = moji_c;
              } else {
                bitmap[Ypos][XT] = moji_excl;
              }
              style_cnt++;
            }
          }
          /********************/
          /* 5dot - 3dot line */
          /********************/
          else {
            if ((style_cnt == 5) && (ten_flg == 0)) {
              ten_flg = 1;
              style_cnt = 1;
              bitmap[Ypos][XT] = moji_excl;
            } else if ((style_cnt == 3) && (ten_flg == 1)) {
              ten_flg = 0;
              style_cnt = 1;
              bitmap[Ypos][XT] = moji_c;
            } else {
              if (ten_flg == 0) {
                bitmap[Ypos][XT] = moji_c;
              } else {
                bitmap[Ypos][XT] = moji_excl;
              }
              style_cnt++;
            }
          }
        }
      }
      /********************/
      /* Straight line    */
      /********************/
      else {
        YT = 0;
        XT = cnt;
        for (height = 1; height < wHeight; height++) {
          if (tPrnBuf.crast != 80) {
            if (80 < XT + tPrnBuf.crast) {
              YT++;
              XT = (XT + tPrnBuf.crast) % 80;
            } else {
              XT = XT + tPrnBuf.crast;
            }
            Ypos = tPrnBuf.ctopline + wYpos + YT;
          } else {
            Ypos = tPrnBuf.ctopline + wYpos + height;
          }
          bitmap[Ypos][XT] = moji_c;
        }
      }
    }
    //tPrnBuf.bitmap[tPrnBuf.ctopline + wYpos] = bitmap[tPrnBuf.ctopline + wYpos].join("");
  }


  /*-----------------------------------------------------------------------*/
  /*
  Usage:		middle_acrose( int wXpos, int wYpos, int wAttr, int wWidth, int wHeight, int wStyle )
  Functions:	Make one byte bitmap in middle part
  Parameters:	(IN)	wXpos	: Start X position
        wYpos	: Start Y position
        wAttr	: Print attribute(reverse,...)
        wWidth	: Line width in dots
        wHeight	: Line height in dots
        wStyle	: Line style(solid, dotted,...)
  */
  /*-----------------------------------------------------------------------*/
  ///  関連tprxソース:if_th_prnline.c - middle_acrose()
  static Future<void> middleAcrose( int wXpos, int wYpos, int wAttr, int wWidth, int wHeight, int wStyle ) async {
    List<List<String>> bitmap = List<List<String>>.filled(10, [""]);   //[Ypos][XT];

    bitmap[tPrnBuf.ctopline + wYpos][cnt] = tPrnBuf.bitmap[tPrnBuf.ctopline + wYpos][cnt];
    moji_c = tPrnBuf.bitmap[tPrnBuf.ctopline + wYpos][cnt];

    if (yoko_tate_flg == 1) {  /* Column_Line */
      /* Exclusive_Line */
      ifBitBuffer(0,7,0,wAttr ^ 0x02);
      moji_excl = moji_c;
      ifBitBuffer(0,7,0,wAttr);
    } else {                     /* Acrose_Line */
      ifBitBuffer(0,7,wStyle,wAttr);
    }
    bitmap[tPrnBuf.ctopline + wYpos][cnt] = moji_c;
    if (wHeight != 1) {
      if ((wStyle != 0) && (yoko_tate_flg == 1)) {
        ten_flg = 0;
        style_cnt = 1;
        YT = 0;
        XT = cnt;
        for (height = 1; height < wHeight; height++) {
          if (tPrnBuf.crast != 80) {
            if (80 < XT + tPrnBuf.crast) {
              YT++;
              XT = (XT + tPrnBuf.crast) % 80;
              if ( 0 == XT ) {	/* 2002.2.7 */
                YT_over++;
              }
            } else {
              XT = XT + tPrnBuf.crast;
            }
            Ypos = tPrnBuf.ctopline + wYpos + YT;
          } else {
            Ypos = tPrnBuf.ctopline + wYpos + height;
          }
          /********************/
          /* 2dot - 2dot line */
          /********************/
          if (wStyle == 1) {
            if ((style_cnt == 2) && (ten_flg == 0)) {
              ten_flg = 1;
              style_cnt = 1;
              bitmap[Ypos][XT] = moji_excl;
            } else if ((style_cnt == 2) && (ten_flg == 1)) {
              ten_flg = 0;
              style_cnt = 1;
              bitmap[Ypos][XT] = moji_c;
            } else {
              if (ten_flg == 0) {
                bitmap[Ypos][XT] = moji_c;
              } else {
                bitmap[Ypos][XT] = moji_excl;
              }
              style_cnt++;
            }
          }
          /********************/
          /* 5dot - 3dot line */
          /********************/
          else {
            if ((style_cnt == 5) && (ten_flg == 0)) {
              ten_flg = 1;
              style_cnt = 1;
              bitmap[Ypos][XT] = moji_excl;
            } else if ((style_cnt == 3) && (ten_flg == 1)) {
              ten_flg = 0;
              style_cnt = 1;
              bitmap[Ypos][XT] = moji_c;
            } else {
              if (ten_flg == 0) {
                bitmap[Ypos][XT] = moji_c;
              } else {
                bitmap[Ypos][XT] = moji_excl;
              }
              style_cnt++;
            }
          }
        }
      }
      /********************/
      /* Solid line       */
      /********************/
      else {
        YT = 0;
        XT = cnt;
        for (height = 1; height < wHeight; height++) {
          if (tPrnBuf.crast != 80) {
            if (80 < XT + tPrnBuf.crast) {
              YT++;
              XT = (XT + tPrnBuf.crast) % 80;
              if ( 0 == XT ) {	/* 2002.2.7 */
                YT_over++;
              }
            } else {
              XT = XT + tPrnBuf.crast;
            }
            Ypos = tPrnBuf.ctopline + wYpos + YT + YT_over;
          } else {
            Ypos = tPrnBuf.ctopline + wYpos + height;
          }
          bitmap[Ypos][XT] = moji_c;
        }
      }
    }
    if ((cnt == byte_cnt - 1) && (end_bit == 0)) {
      cnt++;
    }
    //tPrnBuf.bitmap[tPrnBuf.ctopline + wYpos] = bitmap[tPrnBuf.ctopline + wYpos].join("");
  }


  /*-----------------------------------------------------------------------*/
  /*
  Usage:		if_bit_buffer( int start_bit, int end_bit, int wStyle, int wAttr)
  Functions:	Set or reset bit in current modifing byte data
  Parameters:	(IN)	start_bit : Start bit position
        end_bit	: End bit position
        wAttr	: Print attribute(reverse,...)
        wStyle	: Line style(solid, dotted,...)
  Return value:	0	: Normal end(always)
  */
  /*-----------------------------------------------------------------------*/
  ///  関連tprxソース:if_th_prnline.c - if_bit_buffer()
  static Future<int> ifBitBuffer(int start_bit, int end_bit, int wStyle, int wAttr) async {
    int bit; /* Current bit position(loop counter) */
    int work; /* Bit set-reset flag */

    for (bit = start_bit; bit < end_bit + 1; bit++) {
      /********************/
      /* 2dot - 2dot line */
      /********************/
      if (wStyle == InterfaceDefine.IF_TH_LINE_DOTTED) {
        if ((w_b_flg == 2) && (flg == 0)) {
          work = 0;
          flg = 1;
          w_b_flg = 1;
          DBG_PRINTF("STYLE1 if work = ${work}");
        } else if ((w_b_flg == 2) && (flg == 1)) {
          work = 1;
          flg = 0;
          w_b_flg = 1;
          DBG_PRINTF("STYLE1 else if work =${work}");
        } else {
          if (flg == 0) {
            work = 1;
          } else {
            work = 0;
          }
          w_b_flg++;
          DBG_PRINTF("STYLE1 else work=${work}");
        }
      }
      /********************/
      /* 5dot - 3dot line */
      /********************/
      else if (wStyle == InterfaceDefine.IF_TH_LINE_BREAK) {
        if ((w_b_flg == 5) && (flg == 0)) {
          work = 0;
          flg = 1;
          w_b_flg = 1;
        } else if ((w_b_flg == 3) && (flg == 1)) {
          work = 1;
          flg = 0;
          w_b_flg = 1;
        } else {
          if (flg == 0) {
            work = 1;
          } else {
            work = 0;
          }
          w_b_flg++;
        }
      }
      /********************/
      /* Solid line       */
      /********************/
      else {
        work = 1;
      }
      /********************/
      /* Reverse attribute*/
      /********************/
      if ((wAttr & InterfaceDefine.IF_TH_PRNATTR_REVERSE) ==
          InterfaceDefine.IF_TH_PRNATTR_REVERSE) {
        if (work == 1) {
          work = 0;
        } else {
          work = 1;
        }
      }

      if ((bit < 0) || (7 < bit)) {
        /* Illegal parameter */
        continue; /* Nothing to do */
      } else {
        /* Right parameter */
        if (0 == work) {
        //moji_c &= aBitResetChar[bit];
          moji_c = latin1.decode([moji_c.codeUnitAt(0) & aBitResetChar[bit]]);
        } else {
        //moji_c |= aBitSetChar[bit];
          moji_c = latin1.decode([moji_c.codeUnitAt(0) | aBitSetChar[bit]]);
        }
      }
    }
    return 0;
  }
}
