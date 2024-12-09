/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
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
import 'aa/if_th_prnstr.dart';
import 'if_th_com.dart';
import 'if_th_flushb.dart';

class IfThPageMode {

  static const TRUE = 1;
  static const FALSE = 0;

  static ThPrnBuf tPrnBuf = ThPrnBuf();

  // オリジナル関数
  /// ページモードの選択　ESC ’L'
  static Future<int> ifThChangePageMode(TprTID src) async {
    int	ret = 0;
    int	prt_type = 0;
    List<String> cmd = List<String>.filled(2, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThChangePageMode　start");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    prt_type = await CmCksys.cmPrinterType();
    if (prt_type != CmSys.SUBCPU_PRINTER) {
      cmd[0] = "\x1B";   // ESC
      cmd[1] = "\x4C";   // "L";

      src = await IfThCom.ifThCmd(src, cmd.join(), cmd.length, IfThLib.IF_TH_TYPE_CMD_BY_CHAR);
      if (InterfaceDefine.DEBUG_UT) {
        IfTh.debugPrintCommand(cmd.join());
        debugPrint("ifThChangePageMode　end");
      }
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  static Future<int> ifThPrintPageMode(TprTID src) async {
    int	ret = 0;
    int	prt_type = 0;
    List<String> cmd = List<String>.filled(2, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThPrintPageMode　start");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    prt_type = await CmCksys.cmPrinterType();
    if (prt_type != CmSys.SUBCPU_PRINTER) {
      cmd[0] = "\x1B"; // ESC
      cmd[1] = "\x0C"; // FF

      src = await IfThCom.ifThCmd(src, cmd.join(), cmd.length, IfThLib.IF_TH_TYPE_CMD_BY_CHAR);
      if (InterfaceDefine.DEBUG_UT) {
        IfTh.debugPrintCommand(cmd.join());
        debugPrint("ifThPrintPageMode　end");
      }
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  /// スタンダードモードの選択　ESC ’S'
  static Future<int> ifThChangeStanderdMode(TprTID src) async {
    int	ret = 0;
    int	prt_type = 0;
    List<String> cmd = List<String>.filled(2, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThChangeStanderdMode　start");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    prt_type = await CmCksys.cmPrinterType();
    if (prt_type != CmSys.SUBCPU_PRINTER) {
      cmd[0] = "\x1B";   // ESC
      cmd[1] = "\x53";   //"S";

      src = await IfThCom.ifThCmd(src, cmd.join(), cmd.length, IfThLib.IF_TH_TYPE_CMD_BY_CHAR);
      if (InterfaceDefine.DEBUG_UT) {
        IfTh.debugPrintCommand(cmd.join());
        debugPrint("ifThChangeStanderdMode　end");
      }
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  /// ページモードに置ける印字領域の設定の設定　ESC ’W'
  static Future<int> ifThPageAreaSet(TprTID src, int x, int y, int dx, int dy) async {
    int	ret = 0;
    int	prt_type = 0;
    List<String> cmd = List<String>.filled(10, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThPageAreaSet　start");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    prt_type = await CmCksys.cmPrinterType();
    if (prt_type != CmSys.SUBCPU_PRINTER) {
      cmd[0] = "\x1B";   // ESC
      cmd[1] = "\x57";   //"W";
      cmd[3] = latin1.decode([( x & 0xFF00) >> 8]);
      cmd[2] = latin1.decode([( x & 0x00FF) >> 0]);
      cmd[4] = latin1.decode([( y & 0x00FF) >> 0]);
      cmd[5] = latin1.decode([( y & 0xFF00) >> 8]);
      cmd[6] = latin1.decode([(dx & 0x00FF) >> 0]);
      cmd[7] = latin1.decode([(dx & 0xFF00) >> 8]);
      cmd[8] = latin1.decode([(dy & 0x00FF) >> 0]);
      cmd[9] = latin1.decode([(dy & 0xFF00) >> 8]);

      src = await IfThCom.ifThCmd(src, cmd.join(), cmd.length, IfThLib.IF_TH_TYPE_CMD_BY_CHAR);
      if (InterfaceDefine.DEBUG_UT) {
        IfTh.debugPrintCommand(cmd.join());
        debugPrint("ifThPageAreaSet　end");
      }
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  /// ページモードに置ける印字方向の設定　ESC ’T'
  static Future<int> ifThPrintDirection(TprTID src, int direction) async {
    int	ret = 0;
    int	prt_type = 0;
    List<String> cmd = List<String>.filled(3, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThPrintDirection　start");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    prt_type = await CmCksys.cmPrinterType();
    if (prt_type != CmSys.SUBCPU_PRINTER) {
      cmd[0] = "\x1B";   // ESC
      cmd[1] = "\x54";   // "T";
      switch(direction) {
        case InterfaceDefine.IF_TH_PRNATTR_ROTATE270:
          cmd[2] = "0x03";  // 上 → 下
          break;
        case InterfaceDefine.IF_TH_PRNATTR_ROTATE90:
          cmd[2] = "0x01";  // 下 → 上
          break;
        case InterfaceDefine.IF_TH_PRNATTR_ROTATE180:
        case InterfaceDefine.IF_TH_PRNATTR_REVERSE:
          cmd[2] = "0x02";  // 右 → 左
          break;
        case InterfaceDefine.IF_TH_PRNATTR_NO_OPTION:
          cmd[2] = "0x00";  // 左 → 右
          break;
      }

      src = await IfThCom.ifThCmd(src, cmd.join(), cmd.length, IfThLib.IF_TH_TYPE_CMD_BY_CHAR);
      if (InterfaceDefine.DEBUG_UT) {
        IfTh.debugPrintCommand(cmd.join());
        debugPrint("ifThPrintDirection　end");
      }
    }
    return (InterfaceDefine.IF_TH_POK);
  }
}
