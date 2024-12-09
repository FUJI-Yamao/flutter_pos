/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_csnddata.c
//  このファイルは上記ヘッダーファイルを元にdart化したものです。

// ************************************************************************
// File:           if_th_cSendData.c
// Contents:       if_th_cSendData();
// ************************************************************************

// import  *******************

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/cls_conf/configJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/sysJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/tprtfJsonFile.dart';
import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_pos/app/inc/sys/tpr_ipc.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import '../../drv/printer/ubuntu/drv_printer_def.dart';
import '../../if/common/interface_define.dart';
import '../../if/if_drv_control.dart';
import '../../if/if_print_isolate.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/if_thlib.dart';
import '../../inc/lib/cm_sys.dart';
import '../apllib/competition_ini.dart';
import 'if_th_com.dart';
import 'if_th_init.dart';

// #include	<sys/ipc.h>
// #include	<tpr.h>


class TprtShmBufT {			/* tprt shm */
  int  wptr = 0;				/* write pointer(offset in data[]) */
  int  rptr = 0;				/* read pointer(offset in data[]) */
  String data = "";	    /* print data */
}


class IfThCSenddata {

  static const TRUE  = 1;
  static const FALSE = 0;

/* system include */
/* in linux/msg.h */
  static const MSGMAX = 4056;

/* followed are must included into global header */
//#define TPRT_FTOK_PATHNAME	"apl/drv/tprdrv_tprt"	/* ftok parameter */
  static const TPRT_FTOK_SHM = 's';			/* ftok shm parameter */
  static const TPRT_FTOK_SEM = 'f';			/* ftok sem parameter */

  static const TPRT_X_DOTS = 640;	/* 8[dot/mm] x 80[mm] */
  static const TPRT_Y_DOTS = 3200;	/* 8[dot/mm] x 400[mm] */
  static const TPRT_SHM_HEADSIZE = 4;	/* [bytes] */
  static const TPRT_SHM_DATASIZE = (TPRT_X_DOTS * TPRT_Y_DOTS / 8) + TPRT_SHM_HEADSIZE; /* [bytes] */
  static const TPRT_SHM_DATAMAX = TPRT_SHM_DATASIZE + 4;	/* [bytes] */
  static const TPRT_SHM_DATABUF = TPRT_SHM_DATAMAX + 4;	/* [bytes] */

  static const TPRT_SHM_DIRTY = 1;	/* shm dirty */
  static const TPRT_SHM_CLEAN = 0;	/* shm clean */

  static const TPRT_SEM_FIRST = 0;	/* first semapho number */
  static const TPRT_SEM_GET = -1;	/* first semapho number */
  static const TPRT_SEM_PUT = 1;	/* first semapho number */

  static const LOGMSGLEN = 128;	/* Log message buffer length */
  /* WebPrimePlus 1st version add start */
  static const TPRT_PATH = "conf/tprtf.ini"; /* IniFile path */
  static const PRINT_WIDE_54 = 0;
  static const PRINT_WIDE_72 = 1;
  /* WebPrimePlus 1st version add end */

  /* External variables */

  static String SysHomeDirp = EnvironmentData().sysHomeDir;		/* System home directory */
  static int if_th_jr = 0;			/* Web2100 Jr */

  static TprMsgDevReq2 msgbuff = TprMsgDevReq2();	/* Message packet for driver */

  /* Local function(s) */
  // static	int	check_buf( int tSize, tprt_shmbuf_t *shmbuf );
  /* Check free space on shared memory */

  /* ********************************************* */

  static const IF_TH_WAIT       = 1;
  static const IF_TH_WAIT_COUNT = 0;

  static const IF_TH_JR_RECIPT_WIDE      = 432;		/* 54mm x 8 [dot] */
  static const IF_TH_WEB2100_RECIPT_WIDE = 464;		/* 58mm x 8 [dot] */
  static const IF_TH_JR_RECIPT_CUT       = 2;		  /* cut size for left [byte] */

  static const IF_TH_COUPON_PRINT_WIDE   = 576;
  static const IF_TH_COUPON_RECIPT_WIDE  = 600;

  static void debugPrintIfTh(bool valid, String text) {
    if (valid) {
      debugPrint(text);
    }
  }

  /// Send parameter command to thermal printer
  ///
  /// 引数:   src       : APL-ID
  ///
  ///        ptData    : Pointer to send data
  ///
  ///        wSize     : Size of the send data in bytes
  ///
  ///        wCtl      : Condition of start printing
  ///
  ///        event_flg : return event
  ///
  /// 戻り値：IF_TH_POK  : Normal end
  ///
  ///        IF_TH_IF_TH_PERPARAM  : Parameter error
  ///
  ///        IF_TH_IF_TH_PERWRITE  : Write error
  ///
  ///  関連tprxソース:if_th_csndpara.c - if_th_cSendData
  static Future<int> ifThCSendData(TprTID src, String ptData0, int wSize, int wCtl, int event_flg) async {
    String ptData = "";		  /* ptData for WebJr */
    int datalen = 0;	      /* Data length */
    int	total_size = 0;	    /* Total size of data(data+header) to write */
    int wait_count = 0;	/* Wait counter to use shm */
    int	u_part_size = 0;		/* Upper part size of shm */
    int	usplit_size = 0;		/* Upper part size of ptData */
    int	lsplit_size = 0;		/* Lower part size of ptData */
    int receipt_high = 0;		/* Receipt height */
    String i_ptData = "", o_ptData = "";	/* ptData pointers */
    int	i = 0, j = 0, k = 0;			/* work */
    int	prt_type = 0;
    String tempParamLen = "";
    int lineCntFlag = 0;
    int	receipt_width = 0;
    int	print_width = 0;

    src = await CmCksys.cmQCJCCPrintAid(src);

    if ((await CmCksys.cmZHQSystem() != 0) && (src == Tpraid.TPRAID_KITCHEN1_PRN)) {	// ZHQクーポン
      receipt_width = IF_TH_COUPON_RECIPT_WIDE;
      print_width = IF_TH_COUPON_PRINT_WIDE;
    } else {
      receipt_width = IF_TH_WEB2100_RECIPT_WIDE;
      print_width = IF_TH_JR_RECIPT_WIDE;
    }

    if ( wSize <= 0 ) {
      TprLog().logAdd(src, LogLevelDefine.error, "if_th_cSendData : wSize is under ZERO");
      return (InterfaceDefine.IF_TH_PERPARAM);	/* wSize is wrong */
    }

    if ((InterfaceDefine.IF_TH_PRINTBYCMD != wCtl) && (InterfaceDefine.IF_TH_PRINTBYCMD != wCtl)) {
      TprLog().logAdd(src, LogLevelDefine.error, "if_th_cSendData : wCtl Error");
      return (InterfaceDefine.IF_TH_PERPARAM);	/* wCtl is wrong */
    }

    //	web_type = cm_WebType( );
    //	if( web_type == WEBTYPE_WEBPLUS )
    prt_type = await CmCksys.cmPrinterType();
    if (prt_type == CmSys.TPRTF) {
      TprtfJsonFile sSysIni = TprtfJsonFile();
      try {
        sSysIni.load();
        lineCntFlag = sSysIni.settings.prime_plus_flag;
      } catch(e) {
        TprLog().logAdd(src, LogLevelDefine.error, "if_th_cSendData : TprtfJsonFile.load Error");
        lineCntFlag = 0;
      }
    } else if ((prt_type == CmSys.TPRTS)  ||
               (prt_type == CmSys.TPRTSS) ||
               (prt_type == CmSys.TPRTIM) ||
               (prt_type == CmSys.TPRTHP)) {
      lineCntFlag = PRINT_WIDE_54;
    } else {
      lineCntFlag = -1;
    }

    /* Web2100 Jr */
    if ((IfThInit.ifThJr != 0) || (lineCntFlag == PRINT_WIDE_54)) {
    /* Web2100 Jr */
      ptData = ptData0;

      if (!((await CmCksys.cmZHQSystem() != 0) && (src == Tpraid.TPRAID_KITCHEN1_PRN))) { // ZHQクーポンではない
        /* check size */
        if ((wSize % (receipt_width/8)) == 0) {
          /* assumed receipt_wide 464 */
          receipt_high = (wSize / (receipt_width / 8)).toInt();
          i_ptData = ptData;
          o_ptData = ptData;

          for (i = 0; i < receipt_high; i++) {
            /* for all rows */
            for (j = 0; j < (receipt_width / 8); j++) {
            /* for all columns */
              if (j < IF_TH_JR_RECIPT_CUT) {
                /* left side cut area */
                k = TRUE;
              } else if (j > (IF_TH_JR_RECIPT_CUT + print_width/8 - 1)) {
                /* right side cut arer */
                k = TRUE;
              } else {
                /* leave */
                k = FALSE;
              }

              if (k != FALSE) {
                /* cut */
                i_ptData = i_ptData.substring(1);
              } else {
                /* leave */
                o_ptData = o_ptData + i_ptData.padLeft(1);
                i_ptData = i_ptData.substring(1);
              }
            }
          }
          wSize = ((print_width / 8) * receipt_high).toInt();
        } else {
          TprLog().logAdd(src, LogLevelDefine.error, "if_th_cSendData : Logical Error");
        }
      }
    } else if (lineCntFlag == PRINT_WIDE_72) {
      /* check size */
      if ((wSize % (receipt_width / 8)) != 0) {
        print("size Error!!!!\n");
      }
      /* assumed receipt_wide 464 */
      receipt_high = (wSize / (receipt_width / 8)).toInt();
      wSize += receipt_high * 14;

      ptData = ptData0.substring(0, wSize - (receipt_high * 14));

      debugPrintIfTh(InterfaceDefine.DEBUG_IF_TH, "if_th_cSendData (in WebJr) wSize ${wSize}\n");
      debugPrintIfTh(InterfaceDefine.DEBUG_IF_TH, "if_th_cSendData receipt_high ${receipt_high} [dot]\n");

      i_ptData = ptData0;
      o_ptData = ptData;

      for (i = 0; i < receipt_high; i++) {
        /* add 14Byte to front of Line */
        o_ptData = "";
        /* for all rows */
        o_ptData = i_ptData.substring(0, (receipt_width / 8).toInt());
      }
    } else {
      /* normal */
      ptData = ptData0;
    }

    /* Check if previous print data is still exist or not */
    wait_count = 0;
    total_size = wSize + TPRT_SHM_HEADSIZE;

    /* Copy Print data to shm */
    u_part_size = (TPRT_SHM_DATAMAX - msgbuff.payloadlen).toInt();
    // String tempSize = wSize.toRadixString(16).padLeft(8, "0");
    // tempParamLen =
    //     latin1.decode([int.parse(tempSize.substring(6, 8))]) +
    //     latin1.decode([int.parse(tempSize.substring(4, 6))]) +
    //     latin1.decode([int.parse(tempSize.substring(2, 4))]) +
    //     latin1.decode([int.parse(tempSize.substring(0, 2))]);

    if (total_size <= u_part_size) {
      msgbuff.payloadlen += tempParamLen.length;   // sizeof(int);
      msgbuff.payload += ptData.substring(0, wSize);
      msgbuff.payloadlen += wSize;
    } else if (u_part_size < 4) {    /*sizeof(int)*/
      msgbuff.payload += ptData;
      msgbuff.payloadlen = wSize;
    } else {
      msgbuff.payloadlen += tempParamLen.length;   // sizeof(int);
      usplit_size = (TPRT_SHM_DATAMAX - msgbuff.payloadlen).toInt();
      lsplit_size = wSize - usplit_size;
      msgbuff.payload += ptData.substring(0, usplit_size);
      msgbuff.payload += ptData.substring(usplit_size, usplit_size + lsplit_size);
      msgbuff.payloadlen = lsplit_size;
    }

    if ( TPRT_SHM_DATAMAX <= msgbuff.payloadlen ) {
      msgbuff.payloadlen = 0;
    }

    /*----------------------------------*/
    /* A requirement message is edited. */
    /*----------------------------------*/
    msgbuff.mid	= TprMidDef.TPRMID_DEVREQ;
    msgbuff.length = 4 + 4 + 4 + 4 + 4;  // tid + src + io + result + datalen  (intとuintは4byteと仮定）

    if (await CmCksys.cmZHQSystem() != 0) {
      msgbuff.tid	= await CmCksys.cmCheckZHQCouponRecieptShare(src);
    }    else    {
      msgbuff.tid	= CmCksys.cmPrintCheck();
    }

    msgbuff.src = src;				/* Spec-N001 */
    msgbuff.io = TprDidDef.TPRDEVOUT;
    if( prt_type != CmSys.SUBCPU_PRINTER ) {
      msgbuff.result	= event_flg;
    } else {
      msgbuff.result	= 0;
    }
    msgbuff.datalen = 0;

    msgbuff.dataStr = "";
    msgbuff.dataStr += "\x01";                 /* [0] Packet kind = extend command */
    msgbuff.dataStr += "\x02";                 /* [1] Command length */
    msgbuff.dataStr += "D";                    /* [2] Command */
    msgbuff.dataStr += latin1.decode([wCtl]);  /* [3] Way to print */
    /* for dummy interface */
    msgbuff.dataStr += "\x00";                 /* [4] Print data file name (NULL) */
    datalen	= 4 + 1;                        /* [Command part] + [Last null code] */
    msgbuff.length += datalen;              /* Add to message length */

    /*---------------------------------------*/
    /* A requirement command is transmitted. */
    /*---------------------------------------*/

    if ((if_th_jr != 0) && (ptData.isNotEmpty)) {
      ptData = "";
    }
    return (InterfaceDefine.IF_TH_POK);
  }


  /*-----------------------------------------------------------------------*/
  /*
  Usage:          check_buf( int tSize, tprt_shmbuf_t *shmbuf )
  Functions:      Check free space on shared memory
  Parameters:     (IN)    tSize   : Size of the send data in bytes
  Return value:    0 : OK - There is enough space on shared memory
                  -1 : NG - Not enough space on shared memory
  */
  /*-----------------------------------------------------------------------*/
  static int check_buf(int tSize, TprtShmBufT shmbuf) {
    int free_size = 0;    /* Size of free space on shm */

    if (msgbuff.payloadlen == shmbuf.rptr) {	/* Shm empty */
      if (tSize <= TPRT_SHM_DATASIZE) {
        return (0);	    /* Data size can fit shm */
      }
    } else {			      /* Some data on shm */
      if (msgbuff.payloadlen < shmbuf.rptr) {
        free_size = shmbuf.rptr - msgbuff.payloadlen;
      } else {
        free_size = (TPRT_SHM_DATAMAX - msgbuff.payloadlen).toInt() + shmbuf.rptr;
      }
      if (tSize <= free_size) {
        return (0);     /* Data size can fit shm */
      }
    }
    return (-1);        /* Not enough space on shm */
  }

  /*-----------------------------------------------------------------------*/
  /*
  Usage:          if_th_ShmInit( TPRTID src, int wCtl )
  Functions:      Init Shared memory
  Parameters:     (IN)    src     : APL-ID
                          wCtl    : Condition of start printing(unused)
  Return value:   IF_TH_POK       : Normal end
                  IF_TH_PERPARAM  : Parameter error
                  IF_TH_PERWRITE  : Write error (Not used)
  */
  /*-----------------------------------------------------------------------*/
  static Future<int> if_th_ShmInit(TprTID src, int wCtl) async {
    return (InterfaceDefine.IF_TH_POK);
  }

  /*-----------------------------------------------------------------------*/
  /*
  Usage:          if_th_cSendData_s( TPRTID src, char *ptData, long wSize, int wCtl )
  Functions:      Send parameter command to thermal printer
  Parameters:     (IN)    src     : APL-ID
                          ptData  : Pointer to send data
                          wSize   : Size of the send data in bytes
                          wCtl    : Condition of start printing
                          event_flg : return event
  Return value:   IF_TH_POK       : Normal end
                  IF_TH_IF_TH_PERPARAM  : Parameter error
                  IF_TH_IF_TH_PERWRITE  : Write error
  */
  /*-----------------------------------------------------------------------*/
  static Future<int> ifThCSendDataS(TprTID src, String ptData0,
          int wSize, int wCtl, String cmd, int event_flg) async {

    String ptData = "";		/* ptData for WebJr */
    int	datalen = 0;	/* Data length */
    String tempParamLen = "";
    int total_size = 0;	/* Total size of data(data+header) to write */
    int u_part_size = 0;		/* Upper part size of shm */
    int usplit_size = 0;		/* Upper part size of ptData */
    int lsplit_size = 0;		/* Lower part size of ptData */
    int prt_type = 0;

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (ptData0.isEmpty) {
      TprLog().logAdd(src, LogLevelDefine.error, "if_th_cSendData_s : data is NULL");
      return (InterfaceDefine.IF_TH_PERPARAM);	/* ptData is wrong */
    }

    if (wSize <= 0) {
      TprLog().logAdd(src, LogLevelDefine.error, "if_th_cSendData_s : wSize is under ZERO");
      return (InterfaceDefine.IF_TH_PERPARAM);	/* wSize is wrong */
    }

    if ((InterfaceDefine.IF_TH_PRINTBYCMD != wCtl) && (InterfaceDefine.IF_TH_PRINTBYCMD != wCtl)) {
      TprLog().logAdd(src, LogLevelDefine.error, "if_th_cSendData_s : wCtl Error");
      return (InterfaceDefine.IF_TH_PERPARAM);	/* wCtl is wrong */
    }

    //	web_type = cm_WebType( );

    ptData = ptData0;

    u_part_size = (TPRT_SHM_DATAMAX - msgbuff.payloadlen).toInt();
    // String tempSize = wSize.toRadixString(16).padLeft(8, "0");
    // tempParamLen =
    //     latin1.decode([int.parse(tempSize.substring(6, 8))]) +
    //     latin1.decode([int.parse(tempSize.substring(4, 6))]) +
    //     latin1.decode([int.parse(tempSize.substring(2, 4))]) +
    //     latin1.decode([int.parse(tempSize.substring(0, 2))]);

    msgbuff.payload = "";
    msgbuff.payloadlen = 0;
    if (total_size <= u_part_size) {
      msgbuff.payload += tempParamLen;
      msgbuff.payloadlen += tempParamLen.length; // sizeof(int);
      msgbuff.payload += ptData;
      msgbuff.payloadlen += wSize;
    } else if (u_part_size < 4) {
      msgbuff.payload = ptData;
      msgbuff.payloadlen = wSize;
    } else {
      msgbuff.payload += tempParamLen;
      msgbuff.payloadlen += tempParamLen.length; //sizeof(int);
      usplit_size = (TPRT_SHM_DATAMAX - msgbuff.payloadlen).toInt();
      lsplit_size = wSize - usplit_size;
      msgbuff.payload = ptData.substring(0, usplit_size);
      msgbuff.payload = ptData.substring(usplit_size, lsplit_size);
      msgbuff.payloadlen = lsplit_size;
    }

    if (TPRT_SHM_DATAMAX <= msgbuff.payloadlen) {
      msgbuff.payloadlen = 0;
    }

    /*----------------------------------*/
    /* A requirement message is edited. */
    /*----------------------------------*/
    msgbuff.mid	= TprMidDef.TPRMID_DEVREQ;
    msgbuff.length = 4 + 4 + 4 + 4 + 4;  // tid + src + io + result + datalen  (intとuintは4byteと仮定）

    if (await CmCksys.cmZHQSystem() != 0) {
      msgbuff.tid	= await CmCksys.cmCheckZHQCouponRecieptShare(src);
    } else {
      msgbuff.tid	= CmCksys.cmPrintCheck();
    }

    msgbuff.src	= src;				/* Spec-N001 */
    msgbuff.io	= TprDidDef.TPRDEVOUT;
    prt_type = await CmCksys.cmPrinterType();
    if( prt_type != CmSys.SUBCPU_PRINTER ) {
      msgbuff.result	= event_flg;
    } else {
      msgbuff.result	= 0;
    }
    msgbuff.datalen = 0;

    List<String> tempData = List<String>.filled(5, "");
    tempData[0] += latin1.decode([DrvPrnDef.TPRT_KIND_ECMD]); /* [0] Packet kind = extend command */
    tempData[1] += "\x02";                 /* [1] Command length */
    tempData[2] += cmd;                    /* [2] Command */
    tempData[3] += latin1.decode([wCtl]);	/* [3] Way to print */
    tempData[4] += '\x00';                  /* [4] Print data file name (NULL) for dummy interface */
    datalen	= 4 + 1;                        /* [Command part] + [Last null code] */
    msgbuff.dataStr = tempData.join("");
    msgbuff.length += datalen;              /* Add to message length */

    /*---------------------------------------*/
    /* A requirement command is transmitted. */
    /*---------------------------------------*/
    await IfDrvControl().printIsolateCtrl.printReceiptData2(msgbuff);

    if (InterfaceDefine.DEBUG_UT) {
      String tempStr1 = "";
      String tempStr2 = "";
      for(int i = 0; i < msgbuff.dataStr.length; i++) {
        tempStr1 += "[0x${msgbuff.dataStr.codeUnitAt(i).toRadixString(16).padLeft(2, "0")}]";
      }
      for(int i = 0; i < msgbuff.payload.length; i++) {
        tempStr2 += "[0x${msgbuff.payload.codeUnitAt(i).toRadixString(16).padLeft(2, "0")}]";
      }

      debugPrint("##### Output massage ---->");
      debugPrint("mid     = (${msgbuff.mid.toRadixString(16)}H)");
      debugPrint("length  = (${msgbuff.length})");
      debugPrint("tid     = (${msgbuff.tid.toRadixString(16)}H)");
      debugPrint("src     = (${msgbuff.src.toRadixString(16)}H)");
      debugPrint("io      = (${msgbuff.io.toRadixString(16)}H)");
      debugPrint("result  = (${msgbuff.result.toRadixString(16)}H)");
      debugPrint("datalen = (${msgbuff.datalen.toRadixString(16)}H)");
      debugPrint("dataStr(${datalen}) ==> ");
      debugPrint("   " + msgbuff.dataStr + " => " + tempStr1);
      debugPrint("payloadlen = (${msgbuff.payloadlen.toRadixString(16)}H)");
      debugPrint("param(${msgbuff.payloadlen}) ==> ");
      debugPrint("   " + msgbuff.payload + " => " + tempStr2);
      debugPrint("*----  if_th_cSendData_s return(OK) ----*");
    }

    if ((if_th_jr != 0) && (ptData.isNotEmpty)) {
      ptData = "";
    }
    return (InterfaceDefine.IF_TH_POK);
  }
}
