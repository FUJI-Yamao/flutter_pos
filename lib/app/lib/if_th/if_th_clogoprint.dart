/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_clogoprint.c
//  このファイルは上記ソースファイルを元にdart化したものです。

// ************************************************************************
// File:           if_th_clogoprint.c
// Contents:       if_th_cLogoPrint();
// ************************************************************************

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/sys/tpr_ipc.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../../drv/printer/ubuntu/drv_printer_def.dart';
import '../../if/common/interface_define.dart';
import '../../if/if_drv_control.dart';
import '../../if/if_print_isolate.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_type.dart';

class IfThCLogoPrint {

  static const List<String> aCmdL = ['L', "\x01"];	/* Cut & print Logo   */
                                                    /* 0x01 is dummy data */

  /// サーマルプリンタへのロゴ印刷コマンド送信
  ///
  /// 引数  src 	  : APL-ID
  ///
  ///      wLogo	: Logo number to print
  ///
  /// 戻り値：IF_TH_POK     : Normal end
  ///
  ///       IF_TH_PERPARAM : Parameter error
  ///
  ///       IF_TH_PERWRITE : Write error
  ///
  ///  関連tprxソース:if_th_clogoprint.c - if_th_cLogoPrint()
  static Future<int> ifThCLogoPrint(TprTID src, int wLogo, String loPath) async {
    TprMsgDevReq2 msgbuff = TprMsgDevReq2(); /* Message packet for driver */
    int datalen = 0;  /* Command data length */
    int prt_type = 0;
    List<String> tempData = List<String>.filled(5, "");

    src = await CmCksys.cmQCJCCPrintAid(src);
    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("*----  if_th_cLogoPrint start ----*");
    }

  	// int web_type = CmCksys.cmWebType(sysIni);

    /*----------------------------------*/
    /* A requirement message is edited. */
    /*----------------------------------*/
    msgbuff.mid = TprMidDef.TPRMID_DEVREQ;
    msgbuff.length = 4 + 4 + 4 + 4 + 4 + 2;  // tid + src + io + result + datalen + 2  (int uintは4byteと仮定）
                                             // src (Spec-N001) , Later, add variable part length

    if (await CmCksys.cmZHQSystem() != 0) {
      msgbuff.tid = await CmCksys.cmCheckZHQCouponRecieptShare(src);
    } else {
      msgbuff.tid = CmCksys.cmPrintCheck();
    }

    msgbuff.src = src; /* Spec-N001 */
    msgbuff.io = TprDidDef.TPRDEVOUT;
    msgbuff.result = 0;
    msgbuff.datalen = 0;
    tempData[0] = latin1.decode([DrvPrnDef.TPRT_KIND_CMD]); /* This is command packet */

    if ((InterfaceDefine.IF_TH_LOGO1 <= wLogo) && (wLogo <= InterfaceDefine.IF_TH_LOGO4)) {
      /* Logo printing */
      msgbuff.length += aCmdL.length;
      datalen = aCmdL.length;
      tempData[1] = latin1.decode([datalen]); /* Command length */
      tempData[2] = aCmdL[0];
      tempData[3] = latin1.decode([wLogo]);

      prt_type = await CmCksys.cmPrinterType();
      if( prt_type != CmSys.SUBCPU_PRINTER ) {
        msgbuff.length += 1;
        tempData[1] += latin1.decode([tempData[1].codeUnitAt(0) + 1]); /* Command length */
        tempData[4] = "\x02";   /* x-offset ( n * 8dot ) */
      }
      msgbuff.dataStr = tempData.join("");
    } else { /* Parameter out of range */
      return (InterfaceDefine.IF_TH_PERPARAM);
    }

    /*---------------------------------------*/
    /* A requirement command is transmitted. */
    /*---------------------------------------*/
    if (!InterfaceDefine.UNIT_TEST) {
      await IfDrvControl().printIsolateCtrl.printReceiptData2(msgbuff);
    }

    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintMsgBuff(msgbuff, datalen);
      debugPrint("*----  ifThCLogoPrint return(OK) ----*");
    }

    return (InterfaceDefine.IF_TH_POK);
  }
}