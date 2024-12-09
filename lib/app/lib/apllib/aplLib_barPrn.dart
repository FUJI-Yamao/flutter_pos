/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/cls_conf/mac_infoJsonFile.dart';
import 'package:flutter_pos/app/inc/lib/drv_com.dart';
import 'package:flutter_pos/app/lib/apllib/qr2txt.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cktwr.dart';
import 'package:get/get.dart';
import 'package:flutter_pos/app/lib/if_th/utf2shift.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../if/barcode_print.dart';
import '../../if/common/interface_define.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/lib/L_AplLib.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/if_thlib.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../cm_ean/mk_cdig.dart';
import '../cm_sys/cm_cksys.dart';
import '../if_th/aa/if_th_prnstr.dart';
import '../if_th/if_th_com.dart';
import '../if_th/if_th_prnline.dart';

/// 関連tprxソース: AplLib_BarPrn.c
class AplLibBarPrn {

  static const int XWIDTH = 3;
//static const int YHEIGHT = 67;
  static const int YHEIGHT = 80;
  static const int GUARD_YHEIGHT = 80;
//static const int NUM_YPOS = 93;
  static const int NUM_YPOS = 107;

  static const int SIZ128 = 26;
  static const int SIZ128_TYPEB = 42;
  static const int RESERV_SIZ128 = 24;
  static const int X128W = 2;
  static const int Y128H = 60;
  static const int START_A = 103;
  static const int START_B = 104;
  static const int START_C = 105;
  static const int STOP128 = 106;
  static const int SHIFT128 = 98; /* only A and B */
  static const int CODE_A = 101; /* only B and C */
  static const int CODE_B = 100; /* only A and C */
  static const int CODE_C = 99; /* only A and B */
  static const int FUNC_1 = 102; /* all of them */
  static const int FUNC_2 = 97; /* only A and B */
  static const int FUNC_3 = 96; /* only A and B */
  static const int RCT_WIDTH = 0; /* 58mm */

  static const List<List<int>> addon_typ = [
    [0, 0, 1, 1, 1], /* 0 */
    [0, 1, 0, 1, 1], /* 1 */
    [0, 1, 1, 0, 1], /* 2 */
    [0, 1, 1, 1, 0], /* 3 */
    [1, 0, 0, 1, 1], /* 4 */
    [1, 1, 0, 0, 1], /* 5 */
    [1, 1, 1, 0, 0], /* 6 */
    [1, 0, 1, 0, 1], /* 7 */
    [1, 0, 1, 1, 0], /* 8 */
    [1, 1, 0, 1, 0], /* 9 */
  ];

  static const List<List<int>> bar_typ = [
    [0, 0, 0, 0, 0, 0], /* 0 */
    [0, 0, 1, 0, 1, 1], /* 1 */
    [0, 0, 1, 1, 0, 1], /* 2 */
    [0, 0, 1, 1, 1, 0], /* 3 */
    [0, 1, 0, 0, 1, 1], /* 4 */
    [0, 1, 1, 0, 0, 1], /* 5 */
    [0, 1, 1, 1, 0, 0], /* 6 */
    [0, 1, 0, 1, 0, 1], /* 7 */
    [0, 1, 0, 1, 1, 0], /* 8 */
    [0, 1, 1, 0, 1, 0], /* 9 */
  ];

  static const List<List<int>> bar_a = [
    [0, 0, 0, 1, 1, 0, 1], /* 0 */
    [0, 0, 1, 1, 0, 0, 1], /* 1 */
    [0, 0, 1, 0, 0, 1, 1], /* 2 */
    [0, 1, 1, 1, 1, 0, 1], /* 3 */
    [0, 1, 0, 0, 0, 1, 1], /* 4 */
    [0, 1, 1, 0, 0, 0, 1], /* 5 */
    [0, 1, 0, 1, 1, 1, 1], /* 6 */
    [0, 1, 1, 1, 0, 1, 1], /* 7 */
    [0, 1, 1, 0, 1, 1, 1], /* 8 */
    [0, 0, 0, 1, 0, 1, 1]  /* 9 */
  ];

  static const List<List<int>> bar_b = [
    [0, 1, 0, 0, 1, 1, 1], /* 0 */
    [0, 1, 1, 0, 0, 1, 1], /* 1 */
    [0, 0, 1, 1, 0, 1, 1], /* 2 */
    [0, 1, 0, 0, 0, 0, 1], /* 3 */
    [0, 0, 1, 1, 1, 0, 1], /* 4 */
    [0, 1, 1, 1, 0, 0, 1], /* 5 */
    [0, 0, 0, 0, 1, 0, 1], /* 6 */
    [0, 0, 1, 0, 0, 0, 1], /* 7 */
    [0, 0, 0, 1, 0, 0, 1], /* 8 */
    [0, 0, 1, 0, 1, 1, 1]  /* 9 */
  ];

  static const List<List<int>> bar_c = [
    [1, 1, 1, 0, 0, 1, 0], /* 0 */
    [1, 1, 0, 0, 1, 1, 0], /* 1 */
    [1, 1, 0, 1, 1, 0, 0], /* 2 */
    [1, 0, 0, 0, 0, 1, 0], /* 3 */
    [1, 0, 1, 1, 1, 0, 0], /* 4 */
    [1, 0, 0, 1, 1, 1, 0], /* 5 */
    [1, 0, 1, 0, 0, 0, 0], /* 6 */
    [1, 0, 0, 0, 1, 0, 0], /* 7 */
    [1, 0, 0, 1, 0, 0, 0], /* 8 */
    [1, 1, 1, 0, 1, 0, 0]  /* 9 */
  ];

  /// 関連tprxソース: AplLib_BarPrn.c - chk_asc
  static (int, String) chkAsc(String asc) {
    int num = -1;
    String multi = "";
    switch(asc) {
      case '0': multi = LAplLib.APLLIB_DBL_0; num = 0; break;
      case '1': multi = LAplLib.APLLIB_DBL_1; num = 1; break;
      case '2': multi = LAplLib.APLLIB_DBL_2; num = 2; break;
      case '3': multi = LAplLib.APLLIB_DBL_3; num = 3; break;
      case '4': multi = LAplLib.APLLIB_DBL_4; num = 4; break;
      case '5': multi = LAplLib.APLLIB_DBL_5; num = 5; break;
      case '6': multi = LAplLib.APLLIB_DBL_6; num = 6; break;
      case '7': multi = LAplLib.APLLIB_DBL_7; num = 7; break;
      case '8': multi = LAplLib.APLLIB_DBL_8; num = 8; break;
      case '9': multi = LAplLib.APLLIB_DBL_9; num = 9; break;
    }
    return (num, multi);
  }

  /// 関連tprxソース: AplLib_BarPrn.c - BarCode128C
  static Future<int> barCode128C(TprTID src, int wXpos, int wYpos, int wAttr,
      String barCode, int bar_siz, PrnterControlTypeIdx prn_type) async {
    int barSize = bar_siz;
    int	i = 0, j = 0;
    String code = "";
    String one = "";
    int	hex_code;
    String codeset_all = ""; //[(6 + SIZ128*6 + 6 + 7 + 1)]; /* start + code + stop + filler */
    int checksum = 0;
    int	ret;
    String erlog = "";
    int	start_posi;
  //	int	web_type, len, x1, x2;
    int	prt_type, len, x1, x2;
  //String cmd = "";
    int	sp_width;
    List<String> tempCmd = List<String>.filled(20, "");
    barCode = await Utf2Shift.utf2shift(barCode);

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("barCode128C　start");
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(src, LogLevelDefine.error, "Can't Get rct_sp_width from mac_info.json");
      sp_width = 0;
    } else {
      RxCommonBuf pCom = xRet.object;
      try {
        Mac_infoJsonFile macInfo = pCom.iniMacInfo;
        sp_width = macInfo.printer.rct_sp_width;
      } catch (e) {
        TprLog().logAdd(src, LogLevelDefine.error, "Can't Get rct_sp_width from mac_info.json");
        sp_width = 0;
      }
    }

    if ((wAttr & InterfaceDefine.IF_TH_PRNATTR_BITMAP) == 0) {
    //web_type = await CmCksys.cmWebType();
      prt_type = await CmCksys.cmPrinterType();
  	//if ((web_type == CmSys.WEBTYPE_WEB2300) || (web_type == CmSys.WEBTYPE_WEB2800) || (web_type == CmSys.WEBTYPE_WEB2500) || (web_type == CmSys.WEBTYPE_WEB2350))
      if ((prt_type == CmSys.TPRTS)  || (prt_type == CmSys.TPRTSS) ||
          (prt_type == CmSys.TPRTIM) || (prt_type == CmSys.TPRTHP)) {
        len = 0;

      //if (web_type == CmSys.WEBTYPE_WEB2800)
        if ((prt_type == CmSys.TPRTSS) || (prt_type == CmSys.TPRTIM) ||
            (prt_type == CmSys.TPRTHP) ||
            ((prt_type == CmSys.TPRTS) && (sp_width != RCT_WIDTH))) {
          if ((await CmCksys.cmZHQSystem() != 0) &&
              (src == Tpraid.TPRAID_KITCHEN1_PRN)) {
            x1 = 38; /* barcode top line x start position */
            x2 = 393; /* barcode top line x stop position */
          } else {
            x1 = 28; /* barcode top line x start position */
            x2 = 383; /* barcode top line x stop position */
          }
        } else {
          x1 = 38; /* barcode top line x start position */
          x2 = 393; /* barcode top line x stop position */
        }
        tempCmd[len++] = 'B'; /* Barcode */
        tempCmd[len++] = latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
        tempCmd[len++] = 'C'; /* Code128 */
        if ((prn_type == PrnterControlTypeIdx.TYPE_QC_TCKT) ||
            (prn_type == PrnterControlTypeIdx.TYPE_QC_TCKT_RPR)) {
          tempCmd[len++] = 'L'; /* Code Stoper Type C */
        } else {
          tempCmd[len++] = 'C'; /* Code Stoper Type C */
        }
        tempCmd[len++] = latin1.decode([x1 & 0xff]);
        tempCmd[len++] = latin1.decode([(x1 >> 8) & 0xff]);
        tempCmd[len++] = latin1.decode([x2 & 0xff]);
        tempCmd[len++] = latin1.decode([(x2 >> 8) & 0xff]);
        if (CompileFlag.RESERV_SYSTEM) {
          tempCmd[len++] = latin1.decode([bar_siz & 0xff]);
          tempCmd[len++] = latin1.decode([(bar_siz >> 8) & 0xff]);
          tempCmd[len] = barCode;
          len += bar_siz;
        } else {
          tempCmd[len++] = latin1.decode([BarcodePrint.siz128 & 0xff]);
          tempCmd[len++] = latin1.decode([(BarcodePrint.siz128 >> 8) & 0xff]);
          tempCmd[len] = barCode;
          len += BarcodePrint.siz128;
        }
        await IfThCom.ifThCmd(src, tempCmd.join(), len, IfThLib.IF_TH_TYPE_CMD_CHAR);
        if (InterfaceDefine.DEBUG_UT) {
          IfTh.debugPrintCommand(tempCmd.join());
          debugPrint("barCode128C　end");
        }
        return (InterfaceDefine.IF_TH_POK);
  //	else if( web_type == WEBTYPE_WEBPLUS )
      } else if (CompileFlag.JPN) {
        if (prt_type == CmSys.TPRTF) {
          len = 0;

          tempCmd[len++] = 'B'; /* Barcode */
          tempCmd[len++] = latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
          tempCmd[len++] = 'C'; /* Code128 */
          tempCmd[len++] = 'C'; /* Code Stoper Type C */
          if (CompileFlag.RESERV_SYSTEM) {
            tempCmd[len++] = latin1.decode([bar_siz & 0xff]);
            tempCmd[len++] = latin1.decode([(bar_siz >> 8) & 0xff]);
            tempCmd[len] = barCode;
            len += bar_siz;
          } else {
            tempCmd[len++] = latin1.decode([BarcodePrint.siz128 & 0xff]);
            tempCmd[len++] = latin1.decode([(BarcodePrint.siz128 >> 8) & 0xff]);
            tempCmd[len] = barCode;
            len += BarcodePrint.siz128;
          }
          await IfThCom.ifThCmd(src, tempCmd.join(), len, IfThLib.IF_TH_TYPE_CMD_CHAR);
          if (InterfaceDefine.DEBUG_UT) {
            IfTh.debugPrintCommand(tempCmd.join());
            debugPrint("barCode128C　end");
          }
          return (InterfaceDefine.IF_TH_POK);
        }
      }
    }
    start_posi = wXpos;
    /* START (CODE C) 211232 */
    checksum = START_C;

    //codeset_all = codeset[START_C];
    /* CODE */
    if (!CompileFlag.RESERV_SYSTEM) {
      barSize = BarcodePrint.siz128;
    }
    i = 0;
    j = 0;
//   for(i = 0; i < barSize; i += 2) {
//     code = "";
//
//     strncpy(code, &Bi->Code[i], 2);
//     checksum += (atoi(code) * (j + 1));
//   //		printf("+(%d * %d)", atoi(code), (j+1));
//     strcat(codeset_all, codeset[atoi(code)]);
//   }
//   /* CHECK DIGIT */
// //	printf("\n checksum[%ld][%ld]\n", checksum, (checksum % 103));
//   strcat(codeset_all, codeset[(checksum % 103)]);
//
//   strcat(codeset_all, codeset[STOP128]);

//	printf("code[%s]size[%d]checksum[%ld]\n", codeset_all, strlen(codeset_all), (checksum % 103));

    i = 0;
    j = 0;
    for(i = 0; i < (6 + ((barSize / 2) * 6) + 6 + 7); i++) {
      one = codeset_all[i];
      hex_code = one.codeUnitAt(0) - 0x30; //one - '0';
    //		printf("hex_code[%x]\n", hex_code);
      if(((hex_code+48) >= 65) && ((hex_code+48) <= 70)) {
        hex_code -= (65 - 48 - 1);
      } else if (((hex_code+48) >= 97) && ((hex_code+48) <=102)) {
        hex_code -= (97 - 48 - 1);
      }
      if(!((hex_code >= 1) && (hex_code <= 4))) {
        erlog = "BarCode128C() error!! -> i[$i]hex_code[" + hex_code.toRadixString(16) + "][${hex_code}]wXpos[${wXpos}]";
        TprLog().logAdd(src, LogLevelDefine.error, erlog);
        return (InterfaceDefine.IF_TH_PERPARAM);
      }
  //		printf("[%d][%x][%d][%d][%d]  ", i, hex_code, hex_code, wXpos, X128W*hex_code);
      if(j == 0) {
        if ((ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos + X128W * 2 + 10,
            0, X128W * hex_code, Y128H, 0)) != InterfaceDefine.IF_TH_POK) {
          erlog = "BarCode128C() IfThPrnline.ifThPrintLine error!!";
          TprLog().logAdd(src, LogLevelDefine.error, erlog);
          return (ret);
        }
        j = 1;
        wXpos += (X128W * hex_code);
      } else {
        wXpos += (X128W * hex_code);
        j = 0;
      }
    }
    if ((ret = await IfThPrnline.ifThPrintLine(src, start_posi, wYpos, 0, wXpos,
        X128W * 2, 0)) != InterfaceDefine.IF_TH_POK) {
      erlog = "BarCode128C() IfThPrnline.ifThPrintLine BarLine error!!";
      TprLog().logAdd(src, LogLevelDefine.error, erlog);
      return (ret);
    }
  //	printf("\n");
    return (InterfaceDefine.IF_TH_POK);
  }

  /// 関連tprxソース: AplLib_BarPrn.c - BarUPCE
  static Future<int> barUPCE(TprTID src, int wXpos, int wYpos, int wAttr,
      int iAFontId, int iKFontId, String biCode) async {
    int i = 0, j = 0;
    String code = ""; //[13 + 1];
    String multi = ""; //[4];
    int num = 0;
    int ret = 0;
    String upc_a = ""; // [13 + 1];
    int chkd = 0;
  //   int len, web_type;
    int len = 0, prt_type = 0, e13_siz = 0;
    List<String> tempCmd = List<String>.filled(256, ""); // [256];

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("barUPCE　start");
    }

    biCode = await Utf2Shift.utf2shift(biCode);

    code = biCode;
    upc_a = "";
    multi = "";

    (ret, upc_a) = await AplLib_UPCE_Chk(src, code);
    debugPrint("upc_a:" + upc_a);
    if (ret == -1) {
     return (-1);
    }
    if ((wAttr & InterfaceDefine.IF_TH_PRNATTR_BITMAP) == 0 ) {
      if (CompileFlag.JPN) {
        //   web_type = cm_WebType( );
        //   if( web_type == WEBTYPE_WEBPLUS )
        prt_type = await CmCksys.cmPrinterType();
        if ((prt_type == CmSys.TPRTS)  || (prt_type == CmSys.TPRTSS) ||
            (prt_type == CmSys.TPRTIM) || (prt_type == CmSys.TPRTHP)) {
          len = 0;
          e13_siz = 11;

          tempCmd[len++] = 'B'; /* Barcode */
          tempCmd[len++] = latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
          tempCmd[len++] = 'C'; /*  */
          tempCmd[len++] = 'E'; /* UPC-E */
          tempCmd[len++] = "\x00";
          tempCmd[len++] = "\x00";
          tempCmd[len++] = "\x00";
          tempCmd[len++] = "\x00";
          tempCmd[len++] = latin1.decode([e13_siz & 0xff]);
          tempCmd[len++] = latin1.decode([(e13_siz >> 8) & 0xff]);
          tempCmd[len] = upc_a.substring(1, 1 + e13_siz);
          len += e13_siz;

          await IfThCom.ifThCmd(src, tempCmd.join(), len, IfThLib.IF_TH_TYPE_CMD_CHAR);
          if (InterfaceDefine.DEBUG_UT) {
            IfTh.debugPrintCommand(tempCmd.join());
            debugPrint("barUPCE　end");
          }
          return (InterfaceDefine.IF_TH_POK);
        } else if (prt_type == CmSys.TPRTF) {
          len = 0;
          tempCmd[len++] = 'B'; /* Barcode */
          tempCmd[len++] = latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
          tempCmd[len++] = 'E';
          tempCmd[len] = upc_a.substring(1, 1 + 12);
          len += 12;
          await IfThCom.ifThCmd(src, tempCmd.join(), len, IfThLib.IF_TH_TYPE_CMD_CHAR);
          if (InterfaceDefine.DEBUG_UT) {
            IfTh.debugPrintCommand(tempCmd.join());
            debugPrint("barUPCE　end");
          }
          return (InterfaceDefine.IF_TH_POK);
        }
      }
    }
    chkd = upc_a.codeUnitAt(12) - 0x30;
  //printf("UPCE Check Digit [%d]\n", chkd);

  //cm_clr(multi, sizeof(multi));
    (num, multi) = chkAsc('0');

    ret = await IfThPrnStr.ifThPrintString(src, wXpos, wYpos + NUM_YPOS, wAttr, iAFontId, iKFontId, multi);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH * 10);
    /* guard line */
    ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if((ret) != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH*2), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if(ret != InterfaceDefine.IF_TH_POK)
    return (ret);
    wXpos += (XWIDTH*2);
    /* high rank of 4 figure */
    for(i = 0; i < 6; i++) {
      (num, multi) = chkAsc(code[i]);
      if(num == -1) {
        return (-1);
      }
      ret = await IfThPrnStr.ifThPrintString(src, wXpos + XWIDTH, wYpos + NUM_YPOS, wAttr, iAFontId, iKFontId, multi);
      if(ret != InterfaceDefine.IF_TH_POK) {
        return (ret);
      }
      for(j = 0; j < 7; j++) {
        wXpos += XWIDTH;
        if(bar_typ[chkd][i] == 0) {
          if(bar_b[num][j] == 1) {
            ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, YHEIGHT, 0);
            if(ret != InterfaceDefine.IF_TH_POK) {
              return (ret);
            }
          } else {
            if(bar_a[num][j] == 1) {
              ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, YHEIGHT, 0);
              if(ret!= InterfaceDefine.IF_TH_POK) {
                return (ret);
              }
            }
          }
        }
      }
    }
    wXpos += (XWIDTH * 2);
    ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if(ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH * 2);
    ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if(ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH * 2);
    ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if(ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH * 6);
    //cm_clr(multi, sizeof(multi));
    (num, multi) = chkAsc(upc_a[12]);
    ret = await IfThPrnStr.ifThPrintString(src, wXpos, wYpos + NUM_YPOS, wAttr, iAFontId, iKFontId, multi);
    if(ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  /// 関連tprxソース: AplLib_BarPrn.c - AplLib_BarQR
  static Future<int> aplLibBarQR(TprTID src, String qrData, int datalen) async {
    String cmd = "";
    String erlog = "";
    String fname = "";
    String buf = "";
    int	len = 0, i = 0, SellNum = 0, webType = 0, sell_size = 0, x = 0;
    File?	fp;
    int errno = 0;

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("aplLibBarQR　start");
    }

    qrData = await Utf2Shift.utf2shift(qrData);

    webType = await CmCksys.cmWebType();
    if ((webType != CmSys.WEBTYPE_WEB2800)
        && (webType != CmSys.WEBTYPE_WEB2500)
        && (webType != CmSys.WEBTYPE_WEBPLUS2)) {
      erlog = "aplLibBarQR WebType Error length[$datalen]\n";
      TprLog().logAdd(src, LogLevelDefine.error, erlog);
      return InterfaceDefine.IF_TH_PERPARAM;
    }

    if (webType == CmSys.WEBTYPE_WEB2500) {
      fname = "${EnvironmentData.TPRX_HOME}/tmp/qr_in.dat";
      fp = File(fname);
      if (!fp.existsSync()) {
        erlog = "aplLibBarQR fopen w($fname) Error[$errno]\n";
        TprLog().logAdd(src, LogLevelDefine.error, erlog);
        return InterfaceDefine.IF_TH_PERPARAM;
      }
      fp.writeAsString("MA,$qrData");
      /// TODO 長田 cm_qr_main未実装
      // cm_qr_main();
      fname = "${EnvironmentData.TPRX_HOME}/tmp/qr_out.dat";
      fp = File(fname);
      if (!fp.existsSync()) {
        erlog = "aplLibBarQR fopen r($fname) Error[$errno]\n";
        TprLog().logAdd(src, LogLevelDefine.error, erlog);
        return InterfaceDefine.IF_TH_PERPARAM;
      }

      buf = await fp.readAsString();
      if (buf.isEmpty) {
        erlog = "aplLibBarQR fgets 0() Error[$errno]\n";
        TprLog().logAdd(src, LogLevelDefine.error, erlog);
        return InterfaceDefine.IF_TH_PERPARAM;
      }
      SellNum = buf.length - 1;
      if(SellNum > 93) {	/* Upper Version 19 */
        erlog = "aplLibBarQR size Error[$SellNum][93]\n";
        TprLog().logAdd(src, LogLevelDefine.error, erlog);
        return InterfaceDefine.IF_TH_PERPARAM;
      }

      /* Version 19 */
      sell_size = QR_4_DOT;

      x = 210 - ((SellNum * sell_size) ~/2);

      cmd += 'B';
      cmd += latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
      cmd += 'Q';
      cmd += 'R';
      cmd += (x & 0xff).toString();	/* x position */
      cmd += ((x >> 8) & 0xff).toString();
      cmd += (sell_size & 0xff).toString();
      cmd += ((sell_size >> 8) & 0xff).toString();
      cmd += (SellNum & 0xff).toString();
      cmd += ((SellNum >> 8) & 0xff).toString();
      len = cmd.length;
      await IfThCom.ifThCmd(src, cmd, len, IfThLib.IF_TH_TYPE_BMP);
      if (InterfaceDefine.DEBUG_UT) {
        IfTh.debugPrintCommand(cmd);
      }

      for (i = 0; i < SellNum; i++) {
        if (i != 0) {
          buf = await fp.readAsString();
          if (buf.isEmpty) {
            erlog = "aplLibBarQR fgets 0() Error[$errno]\n";
            TprLog().logAdd(src, LogLevelDefine.error, erlog);
            return InterfaceDefine.IF_TH_PERPARAM;
          }
        }
        cmd = buf;
        len = SellNum;
        await IfThCom.ifThCmd(src, cmd, len, IfThLib.IF_TH_TYPE_CHAR);
        if (InterfaceDefine.DEBUG_UT) {
          IfTh.debugPrintCommand(cmd);
        }
      }
      await IfThCom.ifThCmd(src, "", 0, IfThLib.IF_TH_TYPE_CMD);
      if (InterfaceDefine.DEBUG_UT) {
        debugPrint("aplLibBarQR　end");
      }
      return InterfaceDefine.IF_TH_POK;
    }

    if(await CmCksys.cmReceiptQrSystem() != 0 ||
        (await CmCksys.cmLeaveQrSystem(src) != 0)) {
      if(datalen >= 4100) {
        erlog = "aplLibBarQR length Over Error[QR] length[$datalen]\n";
        TprLog().logAdd(src, LogLevelDefine.error, erlog);
        return InterfaceDefine.IF_TH_PERPARAM;
      }
    }
    else {
      if(datalen >= 300) {
        erlog = "aplLibBarQR length Over Error length[$datalen]\n";
        TprLog().logAdd(src, LogLevelDefine.error, erlog);
        return InterfaceDefine.IF_TH_PERPARAM;
      }
    }
    erlog = "aplLibBarQR start [$datalen]\n";
    TprLog().logAdd(src, LogLevelDefine.normal, erlog);
    cmd += 'B';
    cmd += latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
    cmd += 'q';
    cmd += 'r';
    cmd += 'M';
    cmd += qrData;
    len = cmd.length;
    len += datalen;
    await IfThCom.ifThCmd(src, cmd, len, IfThLib.IF_TH_TYPE_CMD_CHAR);
    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintCommand(cmd);
      debugPrint("aplLibBarQR　end");
    }
    return InterfaceDefine.IF_TH_POK;
  }

  /// 関連tprxソース: AplLib_BarPrn.c - BarEan8
  static Future<int> barEan8(TprTID src, int wXpos, int wYpos,
    int wAttr, int iAFontId, int iKFontId, String biCode) async {
    int i = 0, j = 0;
    String code = ""; // [8];
    String multi = ""; //[4];
    int num = 0;
    int ret = 0;
  //   int len, web_type;
    int len = 0, prt_type = 0, e13_siz = 0;
    List<String> cmd = List<String>.filled(256, ""); //[256];

    if (InterfaceDefine.DEBUG_UT) {
      IfTh.debugPrintCommand(cmd.join());
      debugPrint("barEan8　end");
    }

    biCode = await Utf2Shift.utf2shift(biCode);

    if ((wAttr & InterfaceDefine.IF_TH_PRNATTR_BITMAP ) == 0) {
      if (CompileFlag.JPN) {
        //   web_type = cm_WebType( );
        //   if( web_type == WEBTYPE_WEBPLUS ) {
        prt_type = await CmCksys.cmPrinterType();
        if ((prt_type == CmSys.TPRTS)  || (prt_type == CmSys.TPRTSS) ||
            (prt_type == CmSys.TPRTIM) || (prt_type == CmSys.TPRTHP)) {
          len = 0;
          e13_siz = 7;

          cmd[len++] = 'B'; /* Barcode */
          cmd[len++] = latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
          cmd[len++] = 'C'; /*  */
          cmd[len++] = '8'; /* EAN 8 */
          cmd[len++] = "\x00";
          cmd[len++] = "\x00";
          cmd[len++] = "\x00";
          cmd[len++] = "\x00";
          cmd[len++] = latin1.decode([e13_siz & 0xff]);
          cmd[len++] = latin1.decode([(e13_siz >> 8) & 0xff]);
          cmd[len] = biCode.substring(0, 0 + e13_siz);
          len += e13_siz;

          await IfThCom.ifThCmd(src, cmd.join(), len, IfThLib.IF_TH_TYPE_CMD_CHAR);
          if (InterfaceDefine.DEBUG_UT) {
            IfTh.debugPrintCommand(cmd.join());
            debugPrint("barEan8　end");
          }
          return (InterfaceDefine.IF_TH_POK);
        } else if (prt_type == CmSys.TPRTF) {
          len = 0;
          cmd[len++] = 'B'; /* Barcode */
          cmd[len++] = latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
          cmd[len++] = '8';
          cmd[len] = biCode.substring(0, 0 + 8);
          len += 8;
          await IfThCom.ifThCmd(src, cmd.join(), len, IfThLib.IF_TH_TYPE_CMD_CHAR);
          if (InterfaceDefine.DEBUG_UT) {
            IfTh.debugPrintCommand(cmd.join());
            debugPrint("barEan8　end");
          }
          return (InterfaceDefine.IF_TH_POK);
        }
      }
    }
    code = biCode;
  //cm_clr(multi, sizeof(multi));

    /* guard line */
    ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH*2), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH*2);
    /* high rank of 4 figure */
    for (i = 0; i < 4; i++) {
      (num, multi) = chkAsc(code[i]);
      if (num == -1) {
        return (-1);
      }
      ret = await IfThPrnStr.ifThPrintString(src, wXpos + XWIDTH, wYpos + NUM_YPOS, wAttr, iAFontId, iKFontId, multi);
      if (ret != InterfaceDefine.IF_TH_POK) {
        return (ret);
      }
      for (j = 0; j < 7; j++) {
        wXpos += XWIDTH;
        if(bar_a[num][j] == 1) {
          ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, YHEIGHT, 0);
          if(ret != InterfaceDefine.IF_TH_POK) {
            return (ret);
          }
        }
      }
    }
    /* center line */
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH * 2), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH * 4), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH * 5);
    /* low rank of 4 figure */
    for(i = 4; i < 8; i++) {
      (num, multi) = chkAsc(code[i]);
      if (num == -1) {
        return (-1);
      }
      ret = await IfThPrnStr.ifThPrintString(src, wXpos + XWIDTH, wYpos + NUM_YPOS, wAttr, iAFontId, iKFontId, multi);
      if (ret != InterfaceDefine.IF_TH_POK) {
        return (ret);
      }
      for (j = 0; j < 7; j++) {
        wXpos += XWIDTH;
        if(bar_c[num][j] == 1) {
          ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, YHEIGHT, 0);
          if (ret!= InterfaceDefine.IF_TH_POK) {
            return (ret);
          }
        }
      }
    }
    /* guard line */
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+XWIDTH, wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if(ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH*3), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  /// 関連tprxソース: AplLib_BarPrn.c - BarUPCA
  static Future<int> BarUPCA(TprTID src, int wXpos, int wYpos, int wAttr,
      int iAFontId, int iKFontId, String biCode) async {

    int i = 0, j = 0;
    String code = ""; //[12];
    String multi = ""; //[4];
    int num = 0, top_num = 0, ysiz = 0;
    int  ret = 0;

  //   int len, web_type;
    int len, prt_type, e13_siz;
    List<String> cmd = List<String>.filled(256, "");

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("BarUPCA　start");
    }

    biCode = await Utf2Shift.utf2shift(biCode);

    if ((wAttr & InterfaceDefine.IF_TH_PRNATTR_BITMAP) == 0) {
      if (CompileFlag.JPN) {
        //   web_type = cm_WebType( );
        //   if( web_type == WEBTYPE_WEBPLUS )
        prt_type = await CmCksys.cmPrinterType();
        if ((prt_type == CmSys.TPRTS)  || (prt_type == CmSys.TPRTSS) ||
            (prt_type == CmSys.TPRTIM) || (prt_type == CmSys.TPRTHP)) {
          len = 0;
          e13_siz = 11;

          cmd[len++] = 'B'; /* Barcode */
          cmd[len++] = latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
          cmd[len++] = 'C'; /*  */
          cmd[len++] = 'A'; /* UPC-A */
          cmd[len++] = "\x00";
          cmd[len++] = "\x00";
          cmd[len++] = "\x00";
          cmd[len++] = "\x00";
          cmd[len++] = latin1.decode([e13_siz & 0xff]);
          cmd[len++] = latin1.decode([(e13_siz >> 8) & 0xff]);
          cmd[len] = biCode.substring(0, e13_siz);
          len += e13_siz;

          await IfThCom.ifThCmd(src, cmd.join(), len, IfThLib.IF_TH_TYPE_CMD_CHAR);
          if (InterfaceDefine.DEBUG_UT) {
            IfTh.debugPrintCommand(cmd.join());
            debugPrint("BarUPCA　end");
          }
          return (InterfaceDefine.IF_TH_POK);
        } else if( prt_type == CmSys.TPRTF) {
          len = 0;
          cmd[len++] = 'B'; /* Barcode */
          cmd[len++] = latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
          cmd[len++] = 'A';
          cmd[len] = biCode.substring(0, 12);
          len += 12;
          await IfThCom.ifThCmd(src, cmd.join(), len, IfThLib.IF_TH_TYPE_CMD_CHAR);
          if (InterfaceDefine.DEBUG_UT) {
            IfTh.debugPrintCommand(cmd.join());
            debugPrint("BarUPCA　end");
          }
          return (InterfaceDefine.IF_TH_POK);
        }
      }
    }
    code = biCode;
    multi = "";

    (top_num, multi) = chkAsc(code[0]);
    if (top_num == -1) {
      return (-1);
    }
    ret = await IfThPrnStr.ifThPrintString(src, wXpos, wYpos + NUM_YPOS, wAttr, iAFontId, iKFontId, multi);
    if(ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH * 10);
    /* guard line */
    ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH*2), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH*2);
    /* high rank of 4 figure */
    for (i = 0; i < 6; i++) {
      (num, multi) = chkAsc(code[i]);
      if (num == -1) {
        return (-1);
      }
      if (i == 0) {
        ysiz = GUARD_YHEIGHT;
      } else {
        ysiz = YHEIGHT;
        ret = await IfThPrnStr.ifThPrintString(src, wXpos + XWIDTH, wYpos + NUM_YPOS, wAttr, iAFontId, iKFontId, multi);
        if (ret != InterfaceDefine.IF_TH_POK) {
          return (ret);
        }
      }
      for (j = 0; j < 7; j++) {
        wXpos += XWIDTH;
        if (bar_a[num][j] == 1) {
          ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, ysiz, 0);
          if (ret != InterfaceDefine.IF_TH_POK) {
            return (ret);
          }
        }
      }
    }
    /* center line */
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH * 2), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH * 4), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH * 5);
    /* low rank of 4 figure */
    for (i = 6; i < 12; i++) {
      (num, multi) = chkAsc(code[i]);
      if (num == -1) {
        return (-1);
      }
      if (i == 11) {
        ysiz = GUARD_YHEIGHT;
      } else {
        ysiz = YHEIGHT;
        ret = await IfThPrnStr.ifThPrintString(src, wXpos + XWIDTH, wYpos + NUM_YPOS, wAttr, iAFontId, iKFontId, multi);
        if (ret != InterfaceDefine.IF_TH_POK) {
          return (ret);
        }
      }
      for (j = 0; j < 7; j++) {
        wXpos += XWIDTH;
        if (bar_c[num][j] == 1) {
          ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, ysiz, 0);
          if (ret != InterfaceDefine.IF_TH_POK) {
            return (ret);
          }
        }
      }
    }
    /* guard line */
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+XWIDTH, wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH*3), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH * 5);
    (num, multi) = chkAsc(code[11]);
    if (num == -1) {
      return (-1);
    }
    ret = await IfThPrnStr.ifThPrintString(src, wXpos, wYpos + NUM_YPOS, wAttr, iAFontId, iKFontId, multi);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  /// 関連tprxソース: AplLib_BarPrn.c - BarEan13
  static Future<int> barEan13(TprTID src, int wXpos, int wYpos, int wAttr,
    int iAFontId, int iKFontId, String biCode, PrnterControlTypeIdx prn_type) async {

    int i = 0, j = 0;
    String code = ""; //[13];
    String multi = ""; //[4];
    int num = 0, top_num = 0;
    int ret = 0;

  //	int	web_type, len, x1, x2, e13_siz;
    int	prt_type, len, x1, x2, e13_siz;
    List<String> cmd = List<String>.filled(256, ""); // [256];

    if (InterfaceDefine.DEBUG_UT) {
      debugPrint("barEan13　start");
    }

    if ((wAttr & InterfaceDefine.IF_TH_PRNATTR_BITMAP) == 0) {

    //	web_type = cm_WebType( );
    //	if(( web_type == WEBTYPE_WEB2300 ) || ( web_type == WEBTYPE_WEB2800 ) || ( web_type == WEBTYPE_WEB2500 ) || ( web_type == WEBTYPE_WEB2350 ))
      prt_type = await CmCksys.cmPrinterType();
      if ((prt_type == CmSys.TPRTS)  || (prt_type == CmSys.TPRTSS) ||
          (prt_type == CmSys.TPRTIM) || (prt_type == CmSys.TPRTHP)) {
        len = 0;
        e13_siz = 12;

  //		x1 = 38;		/* barcode top line x start position */
  //		x2 = 393;		/* barcode top line x stop position */
  //		x1 = 100;		/* barcode top line x start position */
  //		x2 = 320;		/* barcode top line x stop position */
        x1 = 125;		/* barcode top line x start position */
        x2 = 315;		/* barcode top line x stop position */
        cmd[len++] = 'B';	/* Barcode */
        cmd[len++] = latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
        cmd[len++] = 'C';	/* Code128 */
        if (prn_type == PrnterControlTypeIdx.TYPE_ZHQ_COUPON) {
          cmd[len++] = 'D';	// HRI(可読文字)を印字しない
        } else {
          cmd[len++] = 'J';	/* Code Stoper Type C */
        }
        cmd[len++] = latin1.decode([x1 & 0xff]);
        cmd[len++] = latin1.decode([(x1 >> 8) & 0xff]);
        cmd[len++] = latin1.decode([x2 & 0xff]);
        cmd[len++] = latin1.decode([(x2 >> 8) & 0xff]);
        cmd[len++] = latin1.decode([e13_siz & 0xff]);
        cmd[len++] = latin1.decode([(e13_siz >> 8) & 0xff]);
        cmd[len] =  biCode.substring(0, e13_siz);
        len += e13_siz;

        await IfThCom.ifThCmd(src, cmd.join(), len, IfThLib.IF_TH_TYPE_CMD_CHAR);
        if (InterfaceDefine.DEBUG_UT) {
          IfTh.debugPrintCommand(cmd.join());
          debugPrint("barEan13　end");
        }
        return (InterfaceDefine.IF_TH_POK);
      }
      if (CompileFlag.JPN) {
    //	else if( web_type == WEBTYPE_WEBPLUS )
        if( prt_type == CmSys.TPRTF ) {
          len = 0;
          cmd[len++] = 'B';
          cmd[len++] = latin1.decode([InterfaceDefine.IF_TH_CMD_SEPA]);
          cmd[len++] = 'J';
          cmd[len] = biCode.substring(0, 13);
          len += 13;
          await IfThCom.ifThCmd(src, cmd.join(), len, IfThLib.IF_TH_TYPE_CMD_CHAR);
          if (InterfaceDefine.DEBUG_UT) {
            IfTh.debugPrintCommand(cmd.join());
            debugPrint("barEan13　end");
          }
          return (InterfaceDefine.IF_TH_POK);
        }
      }
    }
    //printf("13 code[%s][%d][%d]\n", Bi->Code, wXpos, wYpos);
    code = biCode;
    multi = "";
  
    (top_num, multi) = chkAsc(code[0]);
    if (top_num == -1) {
      return (-1);
    }
    ret = await IfThPrnStr.ifThPrintString(src, wXpos, wYpos + NUM_YPOS, wAttr, iAFontId, iKFontId, multi);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH * 10);
    /* guard line */
    ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if(ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH*2), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH*2);
    /* high rank of 4 figure */
    //printf("aaaaa[%d][%d]\n", wXpos, wYpos);
    for (i = 1; i < 7; i++) {
      (num, multi) = chkAsc(code[i]);
      if (num == -1) {
        return (-1);
      }
      ret = await IfThPrnStr.ifThPrintString(src, wXpos + XWIDTH, wYpos + NUM_YPOS, wAttr, iAFontId, iKFontId, multi);
      if (ret != InterfaceDefine.IF_TH_POK) {
        return (ret);
      }
      if (bar_typ[top_num][i - 1] == 0) {
        for (j = 0; j < 7; j++) {
          wXpos += XWIDTH;
          if (bar_a[num][j] == 1) {
            ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, YHEIGHT, 0);
            if(ret != InterfaceDefine.IF_TH_POK) {
              return (ret);
            }
          }
        }
      } else {
        for (j = 0; j < 7; j++) {
          wXpos += XWIDTH;
          if(bar_b[num][j] == 1) {
            ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, YHEIGHT, 0);
            if (ret != InterfaceDefine.IF_TH_POK) {
              return (ret);
            }
          }
        }
      }
    }
    //printf("bbbb[%d][%d]\n", wXpos, wYpos);
    /* center line */
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH * 2), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH * 4), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    wXpos += (XWIDTH * 5);
    /* low rank of 4 figure */
    //printf("cccc[%d][%d]\n", wXpos, wYpos);
    for (i = 7; i < 13; i++) {
      (num, multi) = chkAsc(code[i]);
      if (num == -1) {
        return (-1);
      }
      ret = await IfThPrnStr.ifThPrintString(src, wXpos + XWIDTH, wYpos + NUM_YPOS, wAttr, iAFontId, iKFontId, multi);
      if (ret != InterfaceDefine.IF_TH_POK) {
        return (ret);
      }
      for (j = 0; j < 7; j++) {
        wXpos += XWIDTH;
        if (bar_c[num][j] == 1) {
          ret = await IfThPrnline.ifThPrintLine(src, wXpos, wYpos, 0, XWIDTH, YHEIGHT, 0);
          if (ret != InterfaceDefine.IF_TH_POK) {
            return (ret);
          }
        }
      }
    }
    //printf("dddd[%d][%d]\n", wXpos, wYpos);
    /* guard line */
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+XWIDTH, wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    ret = await IfThPrnline.ifThPrintLine(src, wXpos+(XWIDTH*3), wYpos, 0, XWIDTH, GUARD_YHEIGHT, 0);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return (ret);
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  static String barCode2Bin(String barCode) {
    List tempBar = barCode.split("");
    String ret = "";
    for (int i = 0; i < tempBar.length; i++) {
      ret += latin1.decode([int.parse(tempBar[i])]);
    }
    return ret;
  }

  static Future<(int, String)> AplLib_UPCE_Chk(TprTID src, String upce) async {
    List<String> upc_a = List<String>.filled(13 + 1, "0"); //[13 + 1];
    int x6 = 0;
    String upca = "";

    switch(upce.length) {
      case 6:
        break;
      default:
        TprLog().logAdd(src, LogLevelDefine.error, "AplLib_UPCE_Chk length error!!");
        return (-1, "");
    }

    x6 = (upce[5].codeUnitAt(0) - 0x30);
    debugPrint("x6:" + x6.toRadixString(16));
    switch(x6) {
      case 0:
      case 1:
      case 2:
        upc_a[1] = '0';
        upc_a[2] = upce[0];
        upc_a[3] = upce[1];
        upc_a[4] = latin1.decode ([x6 + 0x30]);
        upc_a[5] = '0';
        upc_a[6] = '0';
        upc_a[7] = '0';
        upc_a[8] = '0';
        upc_a[9] = upce[2];
        upc_a[10] = upce[3];
        upc_a[11] = upce[4];
        break;
      case 3:
        upc_a[1] = '0';
        upc_a[2] = upce[0];
        upc_a[3] = upce[1];
        upc_a[4] = upce[2];
        upc_a[5] = '0';
        upc_a[6] = '0';
        upc_a[7] = '0';
        upc_a[8] = '0';
        upc_a[9] = '0';
        upc_a[10] = upce[3];
        upc_a[11] = upce[4];
        break;
      case 4:
        upc_a[1] = '0';
        upc_a[2] = upce[0];
        upc_a[3] = upce[1];
        upc_a[4] = upce[2];
        upc_a[5] = upce[3];
        upc_a[6] = '0';
        upc_a[7] = '0';
        upc_a[8] = '0';
        upc_a[9] = '0';
        upc_a[10] = '0';
        upc_a[11] = upce[4];
        break;
      default:
        upc_a[1] = '0';
        upc_a[2] = upce[0];
        upc_a[3] = upce[1];
        upc_a[4] = upce[2];
        upc_a[5] = upce[3];
        upc_a[6] = upce[4];
        upc_a[7] = '0';
        upc_a[8] = '0';
        upc_a[9] = '0';
        upc_a[10] = '0';
        upc_a[11] = latin1.decode([x6 + 0x30]);
        break;
    }
    upca = MkCdig.cmMkCdigit(upc_a.join());
    return (0, upca);
  }
}