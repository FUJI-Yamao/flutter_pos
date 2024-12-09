/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_csndpara.c
//  このファイルは上記ソースファイルを元にdart化したものです。

// ************************************************************************
// File:           if_th_csndpara.c
// Contents:       if_th_cSendParam();
// ************************************************************************



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/lib/if_th.dart';
import 'package:flutter_pos/app/inc/sys/tpr_ipc.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cktwr.dart';

import '../../if/common/interface_define.dart';
import '../../if/if_drv_control.dart';
import '../../if/if_print_isolate.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_type.dart';

class IfThCSndPara {

  /// Send parameter command to thermal printer
  ///
  /// 引数:   src     : APL-ID
  ///
  ///        num     : Number of parameters to send
  ///
  ///        ptParam : Pointer to parameter structure
  ///
  /// 戻り値：IF_TH_POK     : Normal end
  ///
  ///       IF_TH_PERWRITE : Write error
  ///
  ///  関連tprxソース:if_th_csndpara.c - if_th_cSendParam
  static Future<int> ifThCSendParam(TprTID src, int num, List<IfThParam> ptParam) async {
    TprMsgDevReq2 msgbuff = TprMsgDevReq2();  /* Message packet for driver */
    int fds = 0;       /* File descripter of driver's pipe */
    int ret = 0;       /* Return value */
    int w_length = 0;  /* Data length to write pipe */
    int i = 0;         /* Loop counter */
    int prt_type = 0;
    List<String> data = List<String>.filled(10, "");
    String tmp = "";
    int data1len = 0;

    src = await CmCksys.cmQCJCCPrintAid(src);

    //web_type = cm_WebType( );
    prt_type = await CmCksys.cmPrinterType();

    /*----------------------------------*/
    /* A requirement message is edited. */
    /*----------------------------------*/
    msgbuff.mid = TprMidDef.TPRMID_DEVREQ;
    msgbuff.length = 4 + 4 + 4 + 4 + 4;  // tid + src + io + result + datalen  (int uintは4byteと仮定）

    if (await CmCksys.cmZHQSystem() != 0) {
      msgbuff.tid = await CmCksys.cmCheckZHQCouponRecieptShare(src);
    } else {
      msgbuff.tid = CmCksys.cmPrintCheck();
    }

    msgbuff.src = src;                              /* Spec-N001 */
    msgbuff.io = TprDidDef.TPRDEVOUT;
    msgbuff.result = 0;
    msgbuff.datalen = 0;
    data[0] = "\x00";                              /* Packet kind = command */
    data[1] = latin1.decode([2 + (3 * num)]);/* Command length */
    data[2] = 'P';/* Command */
    debugPrint("${data[1].codeUnitAt(0)}");
    debugPrint("${msgbuff.length}");

    switch(prt_type) {
      case CmSys.TPRTS:
      data[1] = latin1.decode([2 + 1]);              /* Command length */
      data[3] = latin1.decode([ptParam[0].wData]);  /* Number of parameters */
      msgbuff.length += (2 + data[1].codeUnitAt(0));   /* Add data length */
      break;
    case CmSys.TPRTF:
      data[1] = latin1.decode([2 + 1 + 1]);         /* Command length */
      data[3] = latin1.decode([ptParam[0].wData]);  /* Number of parameters */
      data[4] = latin1.decode([ptParam[1].wData]);  /* Number of parameters */
      msgbuff.length += (2 + data[1].codeUnitAt(0));   /* Add data length */
      break;
    case CmSys.TPRTSS:
    case CmSys.TPRTIM:
    case CmSys.TPRTHP:
      data[1] = latin1.decode([2 + 1 + 1]);         /* Command length */
      data[3] = "\x00";
      data[4] = latin1.decode([ptParam[1].wData]);  /* Number of parameters */
      msgbuff.length += (2 + data[1].codeUnitAt(0));   /* Add data length */
      break;
    default:
      data[3] = latin1.decode([num]);               /* Number of parameters */
      data[4] = "\x00";
      msgbuff.length += (2 + data[1].codeUnitAt(0));   /* Add data length */
      for (i = 0 ; i < num ; i++) {                 /* Set parameters */
        ret = (i + 1) * 3;
        data[ret + 1] = latin1.decode([ptParam[i].paraNum]);
        data[ret + 2] = latin1.decode([(ptParam[i].wData & 0xFF00) >> 8]);
        data[ret + 3] = latin1.decode([(ptParam[i].wData & 0x00FF) >> 0]);
      }
      break;
    }
    msgbuff.dataStr = data.join();
    w_length = msgbuff.length + 4 + 4; //sizeof(tprcommon_t) = 4 + 4;

    /*---------------------------------------*/
    /* A requirement command is transmitted. */
    /* Isolate間通信で指示する。                */
    /*---------------------------------------*/
    if (!InterfaceDefine.UNIT_TEST) {
      await IfDrvControl().printIsolateCtrl.printReceiptData2(msgbuff);
    }

    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintMsgBuff(msgbuff, w_length);
      debugPrint("*----  ifThCSendParam return(OK) ----*");
    }

    return (InterfaceDefine.IF_TH_POK);
  }
/********************   End of if_th_cSendParam.c  ********************************************/

}
