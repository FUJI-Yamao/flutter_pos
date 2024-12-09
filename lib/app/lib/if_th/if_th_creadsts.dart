/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_creadsts.c
//  このファイルは上記ソースファイルを元にdart化したものです。

// ************************************************************************
// File:      if_th_creadsts.c
// Contents:  if_th_cReadStatus();
// ************************************************************************

import 'dart:convert';

import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';

import '../../drv/printer/ubuntu/drv_printer_def.dart';
import '../../if/common/interface_define.dart';
import '../../if/if_drv_control.dart';
import '../../if/if_print_isolate.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_type.dart';
import '../cm_sys/cm_cksys.dart';

class IfThCReadSts {

  static Future<int> ifThCReadStatus(int src) async {
    int ret = await ifThCReadStatusType(src, 0);
    return (ret);
  }

/*-----------------------------------------------------------------------*/
/*
Usage:		if_th_cReadStatus( TPRTID src )
Functions:	Send ReadStatus command to thermal printer
Parameters:	(IN)	src	: APL-ID
Return value:	IF_TH_POK	: Normal end
		IF_TH_PERWRITE	: Write error
*/
/*-----------------------------------------------------------------------*/
  static Future<int> ifThCReadStatusType(TprTID src, TprDID did) async {
    TprMsgDevReq2 msgbuff = TprMsgDevReq2();    /* Message packet for driver */

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("*----  if_th_cReadStatus start ----*");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    /*----------------------------------*/
    /* A requirement message is edited. */
    /*----------------------------------*/
    msgbuff.mid = TprMidDef.TPRMID_DEVREQ;
    msgbuff.length = 4 + 4 + 4 + 4 + 4 + 1;  // tid + src + io + result + datalen + 1  (int uintは4byteと仮定）
                                             // src (Spec-N001)

    if (did != 0) {
      msgbuff.tid = did;
    } else {
      if (await CmCksys.cmZHQSystem() != 0) {
        msgbuff.tid = await CmCksys.cmCheckZHQCouponRecieptShare(src);
      } else {
        msgbuff.tid = CmCksys.cmPrintCheck();
      }
    }
    msgbuff.src = src; /* Spec-N001 */
    msgbuff.io = TprDidDef.TPRDEVIN;
    msgbuff.result = 0;
    msgbuff.datalen = 0;
    msgbuff.dataStr = latin1.decode([DrvPrnDef.TPRT_KIND_STATUS]); /* This is status request packet */

    /*---------------------------------------*/
    /* A requirement command is transmitted. */
    /*---------------------------------------*/
    if (!InterfaceDefine.UNIT_TEST) {
      await IfDrvControl().printIsolateCtrl.printReceiptData2(msgbuff);
    }

    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintMsgBuff(msgbuff, 1);
      debugPrint("*----  ifThCReadStatusType return(OK) ----*");
    }

    return (InterfaceDefine.IF_TH_POK);
  }
}
