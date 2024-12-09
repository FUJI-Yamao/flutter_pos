/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_csndlogo.c
//  このファイルは上記Cソースファイルを元にdart化したものです。

// ************************************************************************
// File:           if_th_csndlogo.c
// Contents:       if_th_cSendLogo();
// ************************************************************************

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/sys/tpr_ipc.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../../drv/printer/ubuntu/drv_printer_def.dart';
import '../../if/common/interface_define.dart';
import '../../if/if_drv_control.dart';
import 'package:flutter_pos/app/inc/lib/if_th.dart';
import 'package:flutter_pos/app/inc/lib/if_thlib.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_type.dart';
import 'if_th_com.dart';


class IfThCSndlogo {

  static const TRUE = 1;
  static const FALSE = 0;

  static int ifthLogoprn = 0;

  /// Send parameter command to thermal printer（ロゴ登録）
  ///
  /// 引数:  src            : APL-ID
  ///
  ///       wLogoNo        : Logo number
  ///
  /// 	    sLogoFileName  : Logo file name to send
  ///
  ///       did            :
  ///
  /// 戻り値：IF_TH_POK      : Normal end
  ///
  /// 		  IF_TH_PERPARAM  : Parameter error
  ///
  ///  関連tprxソース:if_th_csndlogo.c - if_th_cSendLogo_type()
  static Future<int> ifThCSendLogoType(TprTID src, int wLogoNo, String sLogoFileName, TprDID did) async {
    TprMsgDevReq2 msgbuff = TprMsgDevReq2(); /* Message packet for driver */
    int datalen = 0; /* Command data length */
    String aFileName = ""; /* Logo file name(full path) */
    int wLen = 0;
    List<String> tempData = List<String>.filled(6, "");

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("*----  if_th_cSendLogo start ----*");
    }

    if ((wLogoNo <= 0) || (InterfaceDefine.IF_TH_LOGO3 < wLogoNo)) {
      return (InterfaceDefine.IF_TH_PERPARAM); /* Can't get home path */
    }
    /* Make full-path name */
    aFileName = "${AppPath().path}/$sLogoFileName";
    final File file = File(aFileName);

    if (!file.existsSync()) {
      return (InterfaceDefine.IF_TH_PERPARAM); /* Can't get file information */
    }
    /* Check file size */
    var temp = file.readAsBytesSync();
    if (InterfaceDefine.USHRT_MAX < temp.length) {
      return (InterfaceDefine.IF_TH_PERPARAM); /* File size too big */
    } else {
      wLen = temp.length;
    }

    /*----------------------------------*/
    /* A requirement message is edited. */
    /*----------------------------------*/
    msgbuff.mid = TprMidDef.TPRMID_DEVREQ;
    msgbuff.length = 4 + 4 + 4 + 4 + 4;  // tid + src + io + result + datalen  (int uintは4byteと仮定）
                                         // src (Spec-N001)

    if(did != 0) {
      msgbuff.tid = did;
    } else {
      if (await CmCksys.cmZHQSystem() != 0) {
        msgbuff.tid = await CmCksys.cmCheckZHQCouponRecieptShare(src);
      } else {
        msgbuff.tid = CmCksys.cmPrintCheck();
      }
    }

    msgbuff.src = src; /* Spec-N001 */
    msgbuff.io = TprDidDef.TPRDEVOUT;
    msgbuff.result = 0;
    msgbuff.datalen = 0;

    tempData[0] = latin1.decode([DrvPrnDef.TPRT_KIND_ECMD]); /* Packet kind = extend command */
    tempData[1] = latin1.decode([4]);                  /* Command length */
    tempData[2] = 'B';                                 /* Command */
    tempData[3] = latin1.decode([wLogoNo]);            /* Logo number */
    tempData[4] = latin1.decode([wLen & 0xff]);        /* Upper byte of file size */
    tempData[5] = latin1.decode([(wLen >> 8) & 0xff]); /* Lower byte of file size */
    datalen = 6;                                       /* Data length */
    msgbuff.dataStr = tempData.join("") + aFileName;      // フルパスを渡す。

    datalen += aFileName.length + 1;                   /* File name length */
    msgbuff.length += datalen;                         /* Add to message length */

    /*---------------------------------------*/
    /* A requirement command is transmitted. */
    /*---------------------------------------*/
    if (!InterfaceDefine.UNIT_TEST) {
      await IfDrvControl().printIsolateCtrl.printReceiptData2(msgbuff);
    }

    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintMsgBuff(msgbuff, datalen);
      debugPrint("*----  ifThCSendLogoType return(OK) ----*");
    }

    return (InterfaceDefine.IF_TH_POK);
  }

  /// Send parameter command to thermal printer（ロゴ印字）
  ///
  /// 引数:  src            : APL-ID
  ///
  ///       wLogoNo        : Logo number
  ///
  /// 戻り値：IF_TH_POK      : Normal end
  ///
  /// 		  IF_TH_PERPARAM  : Parameter error
  ///
  ///  関連tprxソース:if_th_csndlogo.c - ifThLogoPrint()
  static Future<int> ifThLogoPrint(TprTID src, int wLogoNo) async {
    TprMsgDevReq2 msgbuff = TprMsgDevReq2(); /* Message packet for driver */
    int datalen = 0; /* Command data length */
    List<String> tempData = List<String>.filled(4, "");

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    if (!ifThLogoPrintChk()) {
      return (InterfaceDefine.IF_TH_POK);
    }

    if ((wLogoNo <= 0) || (InterfaceDefine.IF_TH_LOGO3 < wLogoNo)) {
      return (InterfaceDefine.IF_TH_PERPARAM); /* Can't get home path */
    }

    /*----------------------------------*/
    /* A requirement message is edited. */
    /*----------------------------------*/
    msgbuff.mid = TprMidDef.TPRMID_DEVREQ;
    msgbuff.length = 4 + 4 + 4 + 4 + 4 + 2;  // tid + src + io + result + datalen  (int uintは4byteと仮定）
                                             // src (Spec-N001)

    if (await CmCksys.cmZHQSystem() != 0) {
      msgbuff.tid = await CmCksys.cmCheckZHQCouponRecieptShare(src);
    } else {
      msgbuff.tid = CmCksys.cmPrintCheck();
    }

    msgbuff.src = src; /* Spec-N001 */
    msgbuff.io = TprDidDef.TPRDEVOUT;
    msgbuff.result = 0;
    msgbuff.datalen = 0;

    tempData[0] = latin1.decode([DrvPrnDef.TPRT_KIND_CMD]); /* Packet kind = extend command */
    tempData[1] = latin1.decode([2]);       /* Command length */
    tempData[2] = 'O';                      /* Command */
    tempData[3] = latin1.decode([wLogoNo]); /* Logo number */
    datalen = 4;                            /* Data length */

    msgbuff.length += datalen;              /* Add to message length */
    msgbuff.dataStr = tempData.join("");

    /*---------------------------------------*/
    /* A requirement command is transmitted. */
    /*---------------------------------------*/
    await IfDrvControl().printIsolateCtrl.printReceiptData2(msgbuff);

    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintMsgBuff(msgbuff, datalen);
    }

    return (InterfaceDefine.IF_TH_POK);
  }

  /// Send parameter command to thermal printer（ロゴ印字）
  ///
  /// 引数:  src            : APL-ID
  ///
  ///       wLogoNo        : Logo number
  ///
  /// 戻り値：IF_TH_POK      : Normal end
  ///
  /// 		  IF_TH_PERPARAM  : Parameter error
  ///
  ///  関連tprxソーなsi
  ///
  static Future<int> ifThLogoPrint2(TprTID src, int wLogoNo) async {
    String cmd = "";

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("ifThLogoPrint2　start");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    if (!ifThLogoPrintChk()) {
      return (InterfaceDefine.IF_TH_POK);
    }

    if ((wLogoNo <= 0) || (InterfaceDefine.IF_TH_LOGO3 < wLogoNo)) {
      return (InterfaceDefine.IF_TH_PERPARAM); /* Can't get home path */
    }

    /*----------------------------------*/
    /* A requirement message is edited. */
    /*----------------------------------*/
    // 左マージン設定（ロゴセンタリング）
    cmd += "\x1d" "\x4c";
    cmd += "\x14" "\x00";  // nl nh

    // 指定されたNVグラフィックスの印字
    cmd += "\x1d" "\x28" "\x4c";
    cmd += "\x06" "\x00";  // pL pH（データ数:6）
    cmd += "\x30";  // 固定値
    cmd += "\x45";  // fn（機能選択番号:69）
    switch(wLogoNo) {
      case InterfaceDefine.IF_TH_LOGO1:
        cmd += "\x20";  // kc1（キーコード:32～）
        cmd += "\x20";  // kc2（キーコード:32～）
        break;
      case InterfaceDefine.IF_TH_LOGO2:
        cmd += "\x21";  // kc1（キーコード:32～）
        cmd += "\x21";  // kc2（キーコード:32～）
        break;
    }
    cmd += "\x01";  // x（横倍数:1～2）
    cmd += "\x01";  // y（縦倍数:1～2）

    src = await IfThCom.ifThCmd(src, cmd, cmd.length, IfThLib.IF_TH_TYPE_CMD_BY_CHAR);

    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintCommand(cmd);
      debugPrint("ifThLogoPrint2　end");
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  ///  関連tprxソース:if_th_csndlogo.c - if_th_LogoPrintOn()
  static void ifThLogoPrintOn() {
    ifthLogoprn = 0;
  }

  ///  関連tprxソース:if_th_csndlogo.c - if_th_LogoPrintOff()
  static void ifThLogoPrintOff() {
    ifthLogoprn = -99;
  }

  ///  関連tprxソース:if_th_csndlogo.c - ifThLogoPrintChk()
  static bool ifThLogoPrintChk() {
    return (ifthLogoprn != -99);
  }
}

