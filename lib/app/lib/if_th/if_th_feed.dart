/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_ccut.c
//  このファイルは上記ソースファイルを元にdart化したものです。

// ************************************************************************
// File:      if_th_feed.c
// Contents:  if_th_Feed();
// ************************************************************************


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../../if/common/interface_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/if_thlib.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_type.dart';
import 'if_th_com.dart';
import 'if_th_flushb.dart';

class IfThFeed {

  static const TRUE = 1;
  static const FALSE = 0;

  static ThPrnBuf tPrnBuf = ThPrnBuf();

  /// 関数: Setup feed(blank) data on print buffer and send it
  /// 引数: src	  : APL-ID
  ///      wline	: Feed size in dots
  /// 戻値: IF_TH_POK	    : Normal end
  ///      IF_TH_PERPARAM	: Parameter error
  ///      IF_TH_PERWRITE	: Write error
  ///      IF_TH_YRANGE 	: Y range over error
  /// 関連tprxソース: if_th_feed.c - if_th_Feed
  static Future<int> ifThFeed(TprTID src, int wLine) async {
    int	ret = 0;			/* Return value */
    //	int	web_type;
    int	prt_type = 0;
    List<String> cmd = List<String>.filled(4, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThFeed　start");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    if ((wLine <= 0) || (InterfaceDefine.IF_TH_BITMAP_MAXLINE < wLine)) {
      return (InterfaceDefine.IF_TH_PERYRANGE);
    }

    tPrnBuf.ctopline = tPrnBuf.cbtmline = 0;	/* Reset buffer */

    if (InterfaceDefine.IF_TH_POK != (ret = await IfTh.ifThAllocArea(src, wLine))) {
      return( ret );
    }
    prt_type = await CmCksys.cmPrinterType();
    if (prt_type != CmSys.SUBCPU_PRINTER) {
      cmd[0] = 'F';
      cmd[1] = latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
      cmd[2] = latin1.decode([wLine & 0xff]);
      cmd[3] = latin1.decode([(wLine >> 8) & 0xff]);

      await IfThCom.ifThCmd(src, cmd.join(""), cmd.length, IfThLib.IF_TH_TYPE_CMD_CHAR);
      if (InterfaceDefine.DEBUG_UT) {
        IfTh.debugPrintCommand(cmd.join());
      }
    }

    if ((src == Tpraid.TPRAID_PRN) || (src == Tpraid.TPRAID_QCJC_C_PRN)) {
      /* if_th_FlushBuf()は、PrinterTaskで実行 */
      return (ret);
    }
    ret = await IfThFlushB.ifThFlushBuf(src, InterfaceDefine.IF_TH_FLUSHALL);	/* Send feed data to printer */
                                                                                /* FlushBuf calls if_th_cSendData inside */
    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThFeed　end");
    }

    return (InterfaceDefine.IF_TH_POK);
  }
}
