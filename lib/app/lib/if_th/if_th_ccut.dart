/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_ccut.c
//  このファイルは上記ソースファイルを元にdart化したものです。

// ************************************************************************
// File:      if_th_ccut.c
// Contents:  if_th_cCut();
// ************************************************************************

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/sys/tpr_ipc.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../../common/cmn_sysfunc.dart';
import '../../drv/printer/ubuntu/drv_printer_def.dart';
import '../../if/common/interface_define.dart';
import '../../if/if_drv_control.dart';
import '../../if/if_print_isolate.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_type.dart';
import '../apllib/competition_ini.dart';

class IfThCCut {

  static const TRUE = 1;
  static const FALSE = 0;


  /* Constants */
  static const List<String> aCmdC = ['C', "\x01"];	/* Cut & print Logo   */
  /* 0x01 is dummy data */
  static const List<String> aCmdT = ['T'];          /* Cut only */
  static const List<String> aCmdM = ['M', "\x01", "\x01", "\x01"];	/* Cut & print Logo   */

// /*-----------------------------------------------------------------------*/
// /*
// Usage:		if_th_cCut( TPRTID src, int wLogo )
// Functions:	Send cut command to thermal printer
// Parameters:	(IN)	src	: APL-ID
// 			wLogo	: Logo number to print
// Return value:	IF_TH_POK	: Normal end
// 		IF_TH_PERPARAM	: Parameter error
// 		IF_TH_PERWRITE	: Write error
// */
// /*-----------------------------------------------------------------------*/
  static Future<int> ifThCCut(TprTID src, int wLogo) async {
    TprMsgDevReq2 msgbuff = TprMsgDevReq2();    /* Message packet for driver */
    int datalen = 0;   /* Command data length */
  //   int fds = 0;		   /* File descripter of driver's pipe */
  //   int ret = 0;		   /* Return value */
  //   int w_length = 0;	 /* Data length to write pipe */
  // //int web_type = 0;
    int prt_type = 0;
    List<String> tempData = List<String>.filled(5, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("*----  ifThCCut start ----*");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    // web_type = cm_WebType( );
    prt_type = await CmCksys.cmPrinterType();

    /*----------------------------------*/
    /* A requirement message is edited. */
    /*----------------------------------*/
    msgbuff.mid = TprMidDef.TPRMID_DEVREQ;
    msgbuff.length = 4 + 4 + 4 + 4 + 4 + 2;  // tid + src + io + result + datalen + 2  (int uintは4byteと仮定）
                                             // src (Spec-N001) , Later, add variable part length

    if (await CmCksys.cmZHQSystem() != 0) {
      msgbuff.tid	= await CmCksys.cmCheckZHQCouponRecieptShare(src);
    } else {
      msgbuff.tid	= CmCksys.cmPrintCheck();
    }

    msgbuff.src	= src;				/* Spec-N001 */
    msgbuff.io	= TprDidDef.TPRDEVOUT;
    msgbuff.result	= 0;
    msgbuff.datalen = 0;
    msgbuff.dataStr = "";
    tempData[0] = latin1.decode([DrvPrnDef.TPRT_KIND_CMD]); 		/* This is command packet */
    if ((InterfaceDefine.IF_TH_NOLOGO == wLogo) || (InterfaceDefine.IF_TH_NOLOGO2 == wLogo)) {	/* Cut without Logo printing */
      msgbuff.length	+= aCmdT.length;
      datalen = aCmdT.length;
      tempData[1] = latin1.decode([datalen]);	/* Command length */
      tempData[2] = aCmdT.join("");
      // if( web_type == WEBTYPE_WEB2800 )
      if ((prt_type == CmSys.TPRTSS) || (prt_type == CmSys.TPRTIM) || (prt_type == CmSys.TPRTHP)) {
        msgbuff.length += 1;
        tempData[1] = latin1.decode([tempData[1].codeUnitAt(0) + 1]);
        if (InterfaceDefine.IF_TH_NOLOGO2 == wLogo) {
          tempData[2 + datalen] = "\x01";
        } else {
          tempData[2 + datalen] = "\x00";
        }
      }
      msgbuff.dataStr = tempData.join("");
    } else if ((InterfaceDefine.IF_TH_LOGO1 <= wLogo) && (wLogo <= InterfaceDefine.IF_TH_LOGO3)) {
      /* Cut with Logo printing */
      msgbuff.length	+= aCmdC.length;
      datalen = aCmdC.length;
      tempData[1] = latin1.decode([datalen]);	/* Command length */
      tempData[2] = aCmdC[0];
      tempData[3] = latin1.decode([wLogo]);
      if( prt_type != CmSys.SUBCPU_PRINTER ) {
        msgbuff.length += 1;
        tempData[1] = latin1.decode([tempData[1].codeUnitAt(0) + 1]);	 /* Command length */
        tempData[4] = "\x02";	 /* x-offset ( n * 8dot ) */
      }
      msgbuff.dataStr = tempData.join("");
    } else {			/* Parameter out of range */
      return (InterfaceDefine.IF_TH_PERPARAM);
    }

    /*---------------------------------------*/
    /* A requirement command is transmitted. */
    /* Isolate間通信で指示する。                */
    /*---------------------------------------*/
    if (!InterfaceDefine.UNIT_TEST) {
      await IfDrvControl().printIsolateCtrl.printReceiptData2(msgbuff, syncFlag: true);
    }

    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintMsgBuff(msgbuff, datalen);
      debugPrint("*----  ifThCCut return(OK) ----*");
    }

    return (InterfaceDefine.IF_TH_POK);
  }


  //　wLogo : Logo 番号
  //  kind  : 1:途中カット　0:最後のカット
  static Future<int> ifThCCut2(TprTID src, int wLogo, int kind ) async {
    TprMsgDevReq2 msgbuff = TprMsgDevReq2();   /* Message packet for driver */
    int datalen = 0;	/* Command data length */
    int fds = 0;		/* File descripter of driver's pipe */
    int ret = 0;		/* Return value */
    int w_length = 0;	/* Data length to write pipe */
    List<String> tempData = List<String>.filled(6, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("*----  ifThCCut2 start ----*");
    }

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (await CmCksys.cm2800Printer() == 0) {
      return (ifThCCut(src, wLogo));
    }

    msgbuff.mid = TprMidDef.TPRMID_DEVREQ;
    msgbuff.length = 4 + 4 + 4 + 4 + 4 + 2;  // tid + src + io + result + datalen + 2  (int uintは4byteと仮定）
                                             // src (Spec-N001) , Later, add variable part length
    if (await CmCksys.cmZHQSystem() != 0) {
      msgbuff.tid	= await CmCksys.cmCheckZHQCouponRecieptShare(src);
    } else {
      msgbuff.tid	= CmCksys.cmPrintCheck();
    }

    msgbuff.src	= src;				/* Spec-N001 */
    msgbuff.io	= TprDidDef.TPRDEVOUT;
    msgbuff.result	= 0;
    msgbuff.datalen = 0;
    tempData[0] = latin1.decode([DrvPrnDef.TPRT_KIND_CMD]); 	 	/* This is command packet */
    msgbuff.length += aCmdM.length;
    datalen = aCmdM.length;
    tempData[1] = latin1.decode([(datalen + 1)]);	/* Command length */
    tempData[2] = aCmdM[0];
    msgbuff.length += 1;
    tempData[3] = latin1.decode([wLogo]);
    tempData[4] = latin1.decode([await printCutTyp(src, kind)]);
    if ((InterfaceDefine.IF_TH_NOLOGO == wLogo) || (InterfaceDefine.IF_TH_NOLOGO2 == wLogo)) {	/* Cut without Logo printing */
      tempData[3] = "\x00";
      if(InterfaceDefine.IF_TH_NOLOGO2 == wLogo) {
        tempData[1 + datalen] = "\x01";
      } else {
        tempData[1 + datalen] = "\x00";
      }
    } else if ((InterfaceDefine.IF_TH_LOGO1 <= wLogo) && (wLogo <= InterfaceDefine.IF_TH_LOGO3)) {
      tempData[1 + datalen] = "\x02";	   /* x-offset ( n * 8dot ) */
    } else {
      /* Parameter out of range */
      return (InterfaceDefine.IF_TH_PERPARAM);
    }
    msgbuff.dataStr = tempData.join("");

    /*---------------------------------------*/
    /* A requirement command is transmitted. */
    /* Isolate間通信で指示する。                */
    /*---------------------------------------*/
    if (!InterfaceDefine.UNIT_TEST) {
      await IfDrvControl().printIsolateCtrl.printReceiptData2(msgbuff);
    }

    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintMsgBuff(msgbuff, datalen);
      debugPrint("*----  ifThCCut2 return(OK) ----*");
    }

    return (InterfaceDefine.IF_TH_POK);
  }

  // print_cut_typ
  static Future<int> printCutTyp(TprTID src, int kind) async {
    int cut_typ  = -1;
    int cut_typ2 = 0;
    int prt_type = 0;

    if (kind != 0) {
      cut_typ = 0;
      cut_typ2 = await CompetitionIni.competitionIniGetShort(src,
                          CompetitionIniLists.COMPETITION_INI_RCT_CUT_TYPE2,
                          CompetitionIniType.COMPETITION_INI_GETMEM);
      if (cut_typ2 == 1) {
        cut_typ = 2;
      }
    } else {
      cut_typ = await CompetitionIni.competitionIniGetShort(src,
                          CompetitionIniLists.COMPETITION_INI_RCT_CUT_TYPE,
                          CompetitionIniType.COMPETITION_INI_GETMEM);
      prt_type = await CmCksys.cmPrinterType();
      cut_typ2 = await CompetitionIni.competitionIniGetShort(src,
                          CompetitionIniLists.COMPETITION_INI_RCT_CUT_TYPE2,
                          CompetitionIniType.COMPETITION_INI_GETMEM);
      if (((prt_type == CmSys.TPRTIM) || (prt_type == CmSys.TPRTHP)) && (cut_typ2 == 1)) {
        cut_typ = 1;
      }
    }
    return (cut_typ);
  }
}
