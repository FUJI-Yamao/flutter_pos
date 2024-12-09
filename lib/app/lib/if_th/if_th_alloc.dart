/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_ccut.c
//  このファイルは上記ソースファイルを元にdart化したものです。

// ************************************************************************
// File:      if_th_alloc.c
// Contents:  if_th_AllocArea();
// ************************************************************************


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../../if/common/interface_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/if_thlib.dart';
import '../../inc/sys/tpr_type.dart';

class IfThAlloc {

  static ThPrnBuf tPrnBuf = ThPrnBuf();


/*-----------------------------------------------------------------------*/
/*
Usage:		if_th_AllocArea( TPRTID src, int lines )
Functions:	Allocate area on print buffer
Parameter:	(IN)	src	: APL-ID
			lines	: Number of lines to allocate
Return value:	IF_TH_POK	: Normal end
		IF_TH_PERPARAM	: Parameter error
*/
/*-----------------------------------------------------------------------*/
  /// change mode
  ///
  /// 引数:      char_flg: 0:Bitmap 1:Character 2:Command
  ///
  /// 戻り値：IF_TH_POK  : Normal end
  ///
  ///  関連tprxソース:if_th_alloc.c - if_th_ChgMode
  static int ifThChgMode(String char_flg) {
    tPrnBuf.ctopline = tPrnBuf.cbtmline = 0;
    return (InterfaceDefine.IF_TH_POK);
  }

  // static Future<int> ifThAllocArea(int a, int b) async {
  //   return await ifThAllocArea2(a, b, 1);
  // }

  /// Allocate area on print buffer
  ///
  /// 引数:   src     : APL-ID
  ///
  ///        lines   : Number of lines to allocate
  ///
  ///        char_flg: 0:Bitmap 1:Character 2:Command
  ///
  /// 戻り値：IF_TH_POK     : Normal end
  ///
  ///       IF_TH_PERWRITE : Write error
  ///
  ///  関連tprxソース:if_th_alloc.c - ifThAllocArea2
  static Future<int> ifThAllocArea(TprTID src, int lines,[int char_flg = 1]) async {
    int newbtmline = 0; /* New bottom line */
    int prt_type= 0;

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThAllocArea : Enter. lines=${lines}");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);
    /* Check incoming parameter */
    newbtmline = tPrnBuf.cbtmline + lines;

    if ((lines <= 0) || (IfThLib.MAXLINE < newbtmline)) {
      if (InterfaceDefine.DEBUG_UT) {
        debugPrint("ifThAllocArea : Error return. newbtmline=${newbtmline}");
      }
      return (InterfaceDefine.IF_TH_PERPARAM);
    }

    /* Update top position */
    tPrnBuf.ctopline = tPrnBuf.cbtmline;

    /* Clear new allocate area */
    tPrnBuf.bitmap = "";

    /* Update bottom position */
    tPrnBuf.cbtmline = newbtmline;

    /** **/
    prt_type = await CmCksys.cmPrinterType();
    if( prt_type != CmSys.SUBCPU_PRINTER ) {
      tPrnBuf.prn_mode = char_flg; /* 0:Bitmap 1:Character 2:Command */
    } else {
      tPrnBuf.prn_mode = IfThLib.IF_TH_TYPE_BMP;
    }

    /** **/

    if( lines == tPrnBuf.cbtmline ){
      tPrnBuf.prn_char_len = 0;
      tPrnBuf.prn_char = "";

      tPrnBuf.prn_cmd_len = 0;
      tPrnBuf.prn_cmd = "";

      tPrnBuf.y_pos = -1;
      tPrnBuf.w_cnt = 0;
      tPrnBuf.w_prn_data = List<ThPrnData>
          .generate(IfThLib.IF_TH_W_PRN_NUM, (index) => ThPrnData());

      tPrnBuf.edit_type = IfThLib.IF_TH_TYPE_NONE;
      tPrnBuf.prn_cnt = 0;
      // tPrnBuf.prn_order = List<ThPrnOrder>
      //     .generate(IfThLib.IF_TH_PRN_ORDER_NUM, (index) => ThPrnOrder()) ;
    }

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("if_th_AllocArea : Normal return. "
                 "topline=${tPrnBuf.ctopline}, btmline=${tPrnBuf.cbtmline}");
    }

    return (InterfaceDefine.IF_TH_POK);
  }
}
