/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_creset.c
//  このファイルは上記ソースファイルを元にdart化したものです。

// ************************************************************************
// File:           if_th_creset.c
// Contents:       if_th_cReset();
// ************************************************************************

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/sys/tpr_ipc.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../../drv/printer/ubuntu/drv_printer_def.dart';
import '../../if/common/interface_define.dart';
import '../../if/if_drv_control.dart';
import '../../if/if_print_isolate.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_mid.dart';

class IfThCReset {

/* Constants */
  static const List<String> aCmd = ['R'];

  /// サーマルプリンタへのリセットコマンド送信
  ///
  /// 引数  src 	  : APL-ID
  ///
  /// 戻り値：IF_TH_POK     : Normal end
  ///
  ///       IF_TH_PERWRITE	: Write error
  ///
  ///       IF_TH_PERWRITE : Write error
  ///
  ///  関連tprxソース:if_th_creset.c - if_th_cReset()
  static Future<int> ifThCReset(int src) async {
    TprMsgDevReq2 msgbuff = TprMsgDevReq2(); /* Message packet for driver */
    int datalen = 0; /* Data length */
    List<String> tempData = List<String>.filled(5, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("*----  if_th_cReset start ----*");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    /*----------------------------------*/
    /* A requirement message is edited. */
    /*----------------------------------*/
    msgbuff.mid = TprMidDef.TPRMID_DEVREQ;
    msgbuff.length = 4 + 4 + 4 + 4 + 4 + 2 + aCmd.length;
          // tid + src + io + result + datalen + 2 + aCmd  (int uintは4byteと仮定）
          // src (Spec-N001) , Later, add variable part length

    msgbuff.tid = CmCksys.cmPrintCheck();
    msgbuff.src = src; /* Spec-N001 */
    msgbuff.io = TprDidDef.TPRDEVOUT;
    msgbuff.result = 0;
    msgbuff.datalen = 0;
    tempData[0] = latin1.decode([DrvPrnDef.TPRT_KIND_CMD]); /* This is command packet */
    datalen = aCmd.length;
    tempData[1] = latin1.decode([datalen]); /* Command length */
    tempData[2] = aCmd.join("");
    msgbuff.dataStr = tempData.join("");

    /*---------------------------------------*/
    /* A requirement command is transmitted. */
    /*---------------------------------------*/
    if (!InterfaceDefine.UNIT_TEST) {
      await IfDrvControl().printIsolateCtrl.printReceiptData2(msgbuff);
    }

    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintMsgBuff(msgbuff, datalen);
      debugPrint("*----  ifThCReset return(OK) ----*");
    }

    return (InterfaceDefine.IF_TH_POK);
  }
}
