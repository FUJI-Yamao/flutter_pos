/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_prnrect.c
//  このファイルは上記Cソースファイルを元にdart化したものです。

// ************************************************************************
// File:           if_th_prnrect.c
// Contents:       if_th_PrintRectangle();
// ************************************************************************

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/if/common/interface_define.dart';
import 'package:flutter_pos/app/inc/apl/compflag.dart';
import 'package:flutter_pos/app/inc/sys/tpr_type.dart';

import '../../inc/lib/if_th.dart';
import '../../inc/lib/if_thlib.dart';
import '../../sys/tmode/tmode2.dart';
import '../cm_sys/cm_cksys.dart';
import 'if_th_prnline.dart';

class IfThPrnRect {

  static ThPrnBuf tPrnBuf = ThPrnBuf();

/*-----------------------------------------------------------------------*/
/*
Usage:		if_th_PrintRectangle( TPRTID src, int wXpos, int wYpos, int wAttr, int wWidth,
				      int wHeight, int wThick, int wStyle )
Functions:	Setup bitmap data of Rectangle on print buffer
Parameters:	(IN)	src	: APL-ID
			wXpos	: X origin position
			wYpos	: Y origin position
			wAttr	: Print attribute(normal, reverse)
			wWidth	: Width of the rectangle in dots
			wHeight	: Height of the rectangle in dots
			wThick	: Line thickness in dots
			wStyle	: Line style(solid, dotted,..)
Return value	IF_TH_POK	: Normal end
		IF_TH_PERPARAM	: Parameter error
*/
/*-----------------------------------------------------------------------*/

  ///  関連tprxソース:if_th_prnrect.c - if_th_PrintRectangle()
  static Future<int> ifThPrintRectangle(TprTID src, int wXpos, int wYpos, int wAttr,
      int wWidth, int wHeight, int wThick, int wStyle) async {
    int yi = 0, xj = 0; /* Loop counter for debug */
    src = await CmCksys.cmQCJCCPrintAid(src);


    /* Parameter Error */
    if ((wThick < 1) || (wWidth < (wThick * 2))) {
      debugPrint("IF_TH_PERPARAM : ERROR1");
      return(InterfaceDefine.IF_TH_PERPARAM);
    }

    /* UP_LINE Create */
    if (InterfaceDefine.IF_TH_POK !=
        IfThPrnline.ifThPrintLine(src, wXpos, wYpos,
            wAttr, wWidth, wThick, wStyle)) { /* Spec-N001 */
      debugPrint("IF_TH_PERPARAM : UP_LINE ERROR");
      return(InterfaceDefine.IF_TH_PERPARAM);
    }
    /* LEFT_LINE Create */
    /* Spec-N001 */
    if (InterfaceDefine.IF_TH_POK !=
        IfThPrnline.ifThPrintLine(src, wXpos, wYpos + wThick,
            wAttr, wThick, wHeight - wThick, wStyle)) {
      debugPrint("IF_TH_PERPARAM : LEFT_LINE ERROR");
      return(InterfaceDefine.IF_TH_PERPARAM);
    }
    /* RIGHT_LINE Create */
    if (InterfaceDefine.IF_TH_POK !=
      IfThPrnline.ifThPrintLine(src, wXpos + wWidth - wThick, wYpos + wThick,
          wAttr, wThick, wHeight - wThick, wStyle)) {  /* Spec-N001 */
      debugPrint("IF_TH_PERPARAM : RIGHT_LINE ERROR");
      return(InterfaceDefine.IF_TH_PERPARAM);
    }
    /* DOWN_LINE Create */
    if (InterfaceDefine.IF_TH_POK !=
        IfThPrnline.ifThPrintLine(src, wXpos, wYpos + wHeight - wThick,
            wAttr, wWidth, wThick, wStyle)) { /* Spec-N001 */
      debugPrint("IF_TH_PERPARAM : DOWN_LINE ERROR\n");
      return(InterfaceDefine.IF_TH_PERPARAM);
    }

    if (InterfaceDefine.DEBUG_UT) {
      for (yi = tPrnBuf.ctopline; yi < tPrnBuf.ctopline + tPrnBuf.cbtmline; yi++) {
        for (xj = 0; xj < tPrnBuf.crast; xj++) {
          debugPrint("yi=${yi}, xj=${xj}[${tPrnBuf.bitmap[yi][xj]}]");
        }
      }
    }
    return(InterfaceDefine.IF_TH_POK);
  }

  static Future<int> ifThPrintRectangleCloud(TprTID src,
      int pageWidth, int pageHeigth,
      int startX, int startY,
      int endX, int endY,
      int wAttr, int wThick, int wStyle) async {

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThPrintRectangleCloud　start");
      debugPrint("Start(${startX},${startY}) End(${endX},${endY})");
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
    if ((wThick < 1) ||
        ((startX - endX).abs() < (wThick * 2)) ||
        ((startY - endY).abs() < (wThick * 2))) {
      // 線太さが1より小さい、または、線太さの2倍より幅、高さが小さい、
      debugPrint("IF_TH_PERPARAM : ERROR3");
      return (InterfaceDefine.IF_TH_PERPARAM);
    }
    if ((startX == endX) || (startY == endY)) {
      // 始点と終点のX座標か、Y座標が同じ場合は、線であって四角ではない。
      debugPrint("IF_TH_PERPARAM : ERROR4");
      return (InterfaceDefine.IF_TH_PERPARAM);
    }

    /* UP_LINE Create */
    if (InterfaceDefine.IF_TH_POK !=
        await IfThPrnline.ifThPrintLineCloud(src, pageWidth, pageHeigth,
            startX, startY, endX, startY, wAttr, wThick, wStyle)) {
      debugPrint("IF_TH_PERPARAM : UP_LINE ERROR");
      return(InterfaceDefine.IF_TH_PERPARAM);
    }
    /* LEFT_LINE Create */
    if (InterfaceDefine.IF_TH_POK !=
        await IfThPrnline.ifThPrintLineCloud(src, pageWidth, pageHeigth,
            startX, startY, startX, endY, wAttr, wThick, wStyle)) {
      debugPrint("IF_TH_PERPARAM : LEFT_LINE ERROR");
      return(InterfaceDefine.IF_TH_PERPARAM);
    }
    /* RIGHT_LINE Create */
    if (InterfaceDefine.IF_TH_POK !=
        await IfThPrnline.ifThPrintLineCloud(src, pageWidth, pageHeigth,
            endX, startY, endX, endY, wAttr, wThick, wStyle)) {
      debugPrint("IF_TH_PERPARAM : RIGHT_LINE ERROR");
      return(InterfaceDefine.IF_TH_PERPARAM);
    }
    /* DOWN_LINE Create */
    if (InterfaceDefine.IF_TH_POK !=
        await IfThPrnline.ifThPrintLineCloud(src, pageWidth, pageHeigth,
            startX, endY, endX, endY, wAttr, wThick, wStyle)) {
      debugPrint("IF_TH_PERPARAM : DOWN_LINE ERROR\n");
      return(InterfaceDefine.IF_TH_PERPARAM);
    }

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThPrintRectangleCloud　end");
    }
    return(InterfaceDefine.IF_TH_POK);
  }
}
