/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/apl/compflag.dart';

import '../../if/common/interface_define.dart';
import '../../if/if_drv_control.dart';
import '../../if/if_print_isolate.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_type.dart';
import '../cm_sys/cm_cksys.dart';

/// 関連tprxソース:if_th_cflush.c
class IfThCFlush {
  /* Constants */
  static const List<String> aCmd = ['S'];

  /// Parameters:	(IN)	src	: APL-ID
  /// Return value:	IF_TH_POK	: Normal end
  ///               IF_TH_PERWRITE	: Write error
  /// 関連tprxソース:if_th_cflush.c - if_th_cFlush
  static Future<int> ifThCFlush(TprTID src) async {
    TprMsgDevReq2_t msgBuff = TprMsgDevReq2_t(); /* Message packet for driver */
    int datalen = 0; /* Command length */
    DateTime  tv = DateTime.now(), tv2;
    String msgbuf = "";
    List<String> tempData = List<String>.filled(5, "");

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (InterfaceDefine.PERFORMANCE00) {
      msgbuf = "PERFORMANCE ifThCFlush start ${tv.second} ${tv.microsecond}\n";
      TprLog().logAdd(src, LogLevelDefine.normal, msgbuf);
    }

    if (await CmCksys.cmDummyPrintMyself() != 0) {
      return InterfaceDefine.IF_TH_POK;
    }

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("*----  if_th_cFlush start ----*");
    }

    /*----------------------------------*/
    /* A requirement message is edited. */
    /*----------------------------------*/
    msgBuff.mid = TprMidDef.TPRMID_DEVREQ;
    msgBuff.length = 4 + 4 + 4 + 4 + 4 + 2 + 1;
            // tid + src + io + result + datalen + 2 + aCmd (int uintは4byteと仮定）
            // src (Spec-N001)

    if (await CmCksys.cmZHQSystem() != 0) {
      msgBuff.tid = await CmCksys.cmCheckZHQCouponRecieptShare(src);
    } else {
      msgBuff.tid = CmCksys.cmPrintCheck();
    }

    msgBuff.src = src; /* Spec-N001 */
    msgBuff.io = TprDidDef.TPRDEVOUT;
    msgBuff.result = 0;
    msgBuff.datalen = 0;
    tempData[0] = "\x00";
    tempData[1] = latin1.decode([aCmd.length]);
    tempData[2] = aCmd.join();
    msgBuff.dataStr = tempData.join();

    /*---------------------------------------*/
    /* A requirement command is transmitted. */
    /*---------------------------------------*/
    if (!InterfaceDefine.UNIT_TEST) {
      await IfDrvControl().printIsolateCtrl.printReceiptData2(msgBuff,syncFlag: true);
    }

    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintMsgBuff(msgBuff, datalen);
      debugPrint("*----  ifThCFlush return(OK) ----*");
    }

    if (InterfaceDefine.PERFORMANCE00) {
      tv2 = DateTime.now();
      String msgbuf = "PERFORMANCE if_th_PrintString end   ${tv2.second} ${tv2.microsecond} diff ${(tv2.microsecond - tv.microsecond)} \n";
      TprLog().logAdd(0, LogLevelDefine.normal, msgbuf);
    }

    return (InterfaceDefine.IF_TH_POK);
  }
}