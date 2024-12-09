/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_prnstr.c
//  このファイルは上記Cソースファイルを元にdart化したものです。

// ************************************************************************
// File:           if_th_prnstr.c
// Contents:       if_th_PrintString();
// ************************************************************************

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/if/common/interface_define.dart';
import 'package:flutter_pos/app/inc/apl/compflag.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/lib/if_th/utf2shift.dart';

import '../../../inc/apl/rxmem.dart';
import '../../../inc/lib/if_thlib.dart';
import '../../../inc/lib/cm_sys.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../inc/sys/tpr_type.dart';
import '../../apllib/apllib_strutf.dart';
import '../if_th_com.dart';
import '../if_th_init.dart';


class VF_BITMAP {
  int bbx_width = 0;    /* in pixels */
  int bbx_height = 0;   /* in pixels */
  int off_x = 0;        /* in pixels */
  int off_y = 0;        /* in pixels */
  int mv_x = 0;         /* in pixels */
  int mv_y = 0;         /* in pixels */
  Uint8List? bitmap;
  int raster = 0;
}

class IfThPrnStr {

  /* Local defines */
  static const String ANK_SPACE	= "\x20";		/* Character code of ANK space */
  static const String ANK_A     = "\x41";		/* Character code of ANK 'A' */

  /****** Note : Set 1 to either JIS_FONT or SJIS_FONT *******/
  static const int JIS_FONT  = 1;	/* Set 1 if font file uses JIS code */
  static const int SJIS_FONT = 0;	/* Set 1 if font file uses SHIFT JIS code */

//  static String utf8_trail(c) ((c) >= 0x80 && (c) <= 0xBF)

  /* Externals */
  static ThPrnBuf tPrnBuf = ThPrnBuf();   /* Print buffer */
  //int	euc2shift( char *ptString, char *tSJisBuf, int tofullsize );

  /* Constants */
  static List<String> tTopMask = [	/* Clear mask table(top) */
    "\x00", "\x80", "\xC0", "\xE0", "\xF0", "\xF8", "\xFC", "\xFE"
  ];

  /* Static values */
  static	VF_BITMAP tCBM = VF_BITMAP();		/* Composed bitmap data(all characters) : Windows標準形式の構造体 */
  static	int	iXBBYOF = 0;
  static	int	iXBBIOF = 0;
  static	int	iXEBIOF = 0;
  static	int	iYTBIOF = 0;
  static	int	iPXBCNT = 0;
  static	String sMsgBuf = "";  //[TPRMAXPATHLEN];	/* Buffer for error message */

    static void testPrintBinary(String str) {
      String bin = "binary:";
      for (int i = 0; i < str.length; i++) {
        bin += "[" + str.codeUnitAt(i).toRadixString(16) + "]";
      }
      debugPrint(bin);
    }

    static void testFileOutput(String mode, [String str = ""]) {
    switch(mode) {
      case "start":
        Utf2Shift.textOutput("\n");
        Utf2Shift.textOutput("================================" "\n");
        Utf2Shift.textOutput(Utf2Shift.utf2shift("|||    レシートテスト印刷    |||") + "\n");
        Utf2Shift.textOutput("================================" "\n");
        break;
      case "logo1":
        Utf2Shift.textOutput("--------------------------------" "\n");
        Utf2Shift.textOutput(Utf2Shift.utf2shift("|||          店舗ロゴ          |||") + "\n");
        Utf2Shift.textOutput("--------------------------------" "\n");
        break;
      case "body":
        Utf2Shift.textOutput(tPrnBuf.prn_char);
        break;
      case "barcode":
        Utf2Shift.textOutput("--------------------------------" "\n");
        Utf2Shift.textOutput("||| BARCODE : ${str}  |||" "\n");
        Utf2Shift.textOutput("--------------------------------" "\n");
        break;
      case "logo2":
        Utf2Shift.textOutput("--------------------------------" "\n");
        Utf2Shift.textOutput(Utf2Shift.utf2shift("|||        ビットマップ        |||") + "\n");
        Utf2Shift.textOutput("--------------------------------" "\n");
        break;
      case "pcut":
        Utf2Shift.textOutput("--------< PARTIAL CUT >---------" "\n");
        break;
      case "fcut":
        Utf2Shift.textOutput("----------< FULL CUT >----------" "\n");
        break;
      case "ncut":
        Utf2Shift.textOutput("-----------< NO CUT >-----------" "\n");
        break;
      case "any":
        Utf2Shift.textOutput(str + "\n");
        break;
      default:
        break;
    }
  }

  /// Setup font bitmap data of string on print buffer
  ///
  /// 引数:	(IN)
  ///     src	: APL-ID
  ///     wXpos	: X position of the string
  ///     wYpos	: Y position of the string
  ///     Attr	: Attribute of the string
  ///     iAFontId: Font id for ASCII character
  ///     iKFontId: Font id for KANJI character
  ///     ptString: Pointer to string
  /// 戻り値:
  /// 	  IF_TH_POK	: Normal end
  ///     IF_TH_PERPARAM	: Generic parameter error
  ///     IF_TH_PERXYSTART: X or Y start position error
  ///     IF_TH_PERCNVSJIS: Character code conversion error
  ///     IF_TH_PERGETBITMAP : Error on VF_GetBitmap2
  ///     IF_TH_PERALLOC	: Memory allocation error
  ///     IF_TH_PERXRANGE	: X range over error
  ///     IF_TH_PERYRANGE	: Y range over error
  ///     IF_TH_PERROTATE	: Error on VF_RotatedBitmap
  ///  関連tprxソース:if_th_alloc.c - if_th_PrintString
  static Future<int> ifThPrintString( TprTID src, int wXpos, int wYpos, int wAttr, int iAFontId, int iKFontId, String ptString ) async {
    int	ret = InterfaceDefine.IF_TH_POK;
    String tSJisBuf = "";  //* String buffer(SJIS code) */
    int	prt_type = 0, h_num = 0;
    String cmd_buf = "";
    String rt_buf = "";
    int	num = 0;
    int	space_count = 0;
    int	spLen = 0;
    int first_space = 0;
    int	LineFeedDot = 0;
    DateTime  tv = DateTime.now(), tv2;
    String msgbuf = "";
    int retFont = 0;

    src = await CmCksys.cmQCJCCPrintAid(src);

    if (InterfaceDefine.PERFORMANCE00) {
      msgbuf = "PERFORMANCE if_th_PrintString start ${tv.second} ${tv.microsecond}\n";
      TprLog().logAdd(src, LogLevelDefine.normal, msgbuf);
    }

    /* Add x offset */
    wXpos += tPrnBuf.x_offset;

    prt_type = await CmCksys.cmPrinterType();
    if ((prt_type != CmSys.SUBCPU_PRINTER) &&
        (tPrnBuf.prn_mode == IfThLib.IF_TH_TYPE_CHAR)) { 		/* 印字モード：文字列 */
      /* 文字列用データ編集 */
      tPrnBuf.edit_type = IfThLib.IF_TH_TYPE_CHAR;

      /* コマンド編集 */
      first_space = 0;
      cmd_buf = "";
      rt_buf = "";

      (retFont, cmd_buf, num, h_num, first_space) =
          await IfThCom.ifThFontSet(src, iAFontId, first_space, num, h_num, wAttr);
      if(retFont == -1) {
        return (InterfaceDefine.IF_TH_PERCNVSJIS);	/* Can't convert character code */
      }

      rt_buf = getRotateCommand(src, wAttr, wXpos, wYpos, iAFontId, iKFontId);

      IfThCom.ifThFileOutProc(ptString);

      /* 文字列変換（シフトＪＩＳ） */
      tSJisBuf = "";
      switch(prt_type) {
        case CmSys.TPRTF  : tSJisBuf = await Utf2Shift.utf2shiftChg(ptString, 0); break;
        case CmSys.TPRTSS : tSJisBuf = await Utf2Shift.utf2shiftChg(ptString, 2); break;
        case CmSys.TPRTIM : tSJisBuf = await Utf2Shift.utf2shiftChg(ptString, 0); break;
        case CmSys.TPRTHP : tSJisBuf = await Utf2Shift.utf2shiftChg(ptString, 0); break;
        default           : tSJisBuf = await Utf2Shift.utf2shiftChg(ptString, 1); break;
      }

      wYpos += tPrnBuf.ctopline;	/* 指定開始行数 */
      wXpos -= tPrnBuf.x_offset;	/* 指定開始桁数 */

      /* 空白文字数 */
      List<String> ptTest = ptString.split("");
      for (space_count = 0; space_count < ptString.length; space_count++) {
        if (ptTest[space_count] != ' ') {
          break;
        }
      }

      /* 前回と同一行で、すべて空白の場合は */
      if ((wYpos == tPrnBuf.y_pos) &&
          (tPrnBuf.y_pos != -1) &&
          (space_count == ptString.length)) {
        return (InterfaceDefine.IF_TH_POK);
      }

      /* すべて空白行 */
      if (space_count == ptString.length) {
        await IfThCom.ifThSetChar(IfThLib.IF_TH_TYPE_CHAR);

        tPrnBuf.w_prn_data[tPrnBuf.w_cnt].x_pos = 0;

        tPrnBuf.w_prn_data[tPrnBuf.w_cnt].cmd_len = h_num;
        tPrnBuf.w_prn_data[tPrnBuf.w_cnt].cmd = rt_buf + cmd_buf;

        /* コマンド保存 */
        tPrnBuf.w_prn_data[tPrnBuf.w_cnt].data = tSJisBuf;
        List<String> tempData = tPrnBuf.w_prn_data[tPrnBuf.w_cnt].data.split("");
        /* 印字データ */
        tPrnBuf.w_cnt++;

        await IfThCom.ifThSetChar(IfThLib.IF_TH_TYPE_CHAR);

        return (InterfaceDefine.IF_TH_POK);
      }

      if ((wYpos != tPrnBuf.y_pos) && (tPrnBuf.y_pos != -1)) {	/* 印字バッファにデータをコピー */
        await IfThCom.ifThSetChar(IfThLib.IF_TH_TYPE_CHAR);
        tPrnBuf.y_pos = -1;		/* 同一行はなし */
      }

      if ((await CmCksys.cmZHQSystem() != 0) && (src == Tpraid.TPRAID_KITCHEN1_PRN)) {// ZHQクーポンは最初の空白をセットしない
        first_space = 0;
      }

      /* 最初の場合は、開始位置調整のため、最初に空白をセットする */
      List<String> spCmd = List<String>.filled(20, "");
      spLen = 0;

      if ((wAttr & InterfaceDefine.IF_TH_PRNATTR_ROTATE270) == 0) { /* 回転なし */
        if (tPrnBuf.y_pos == -1) {
          tPrnBuf.y_pos = wYpos;
          switch (first_space) {
            case 1:
            /* 通常 */
              tPrnBuf.w_prn_data[tPrnBuf.w_cnt].x_pos = 0;
              if (prt_type == CmSys.TPRTS) {
                spCmd[spLen++] = "\x12"; spCmd[spLen++] = "\x46"; spCmd[spLen++] = "\x01";  /* フォントサイズ */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x57"; spCmd[spLen++] = "\x00";  /* 横倍拡大解除 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x77"; spCmd[spLen++] = "\x00";  /* 縦倍拡大解除 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x46";                           /* 強調文字解除 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x33";
                spCmd[spLen++] = latin1.decode([tPrnBuf.rct_lf_plus]);                    /* 行間指定 */
              } else if ((prt_type == CmSys.TPRTF) && (CompileFlag.JPN)) {
                spCmd[spLen++] = "\x1d"; spCmd[spLen++] = "\x4c"; spCmd[spLen++] = "\x08"; spCmd[spLen++] = "\x00";                /* 左マージン位置設定 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x21"; spCmd[spLen++] = "\x00"; /* 印字モード指定 */
                spCmd[spLen++] = "\x1c"; spCmd[spLen++] = "\x21"; spCmd[spLen++] = "\x00"; /* 漢字印字モード一括指定 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x41"; spCmd[spLen++] = "\x06"; /* 印字モード一括指定 */
              } else if ((prt_type == CmSys.TPRTSS) || (prt_type == CmSys.TPRTIM) ||
                  (prt_type == CmSys.TPRTHP)) {
                if ((await CmCksys.cmZHQSystem() != 0) &&
                    (src == Tpraid.TPRAID_KITCHEN1_PRN)) {
                  LineFeedDot = 0;
                } else {
                  LineFeedDot = tPrnBuf.rct_lf_plus; /* 行間指定 */
                }
             // spCmd[spLen++] = "\x1d"; spCmd[spLen++] = "\x4c"; spCmd[spLen++] = "\x08"; spCmd[spLen++] = "\x00"; /* 左マージン位置設定 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x21"; spCmd[spLen++] = "\x00"; /* 印字モード指定 */
                spCmd[spLen++] = "\x1c"; spCmd[spLen++] = "\x21"; spCmd[spLen++] = "\x00"; /* 漢字印字モード一括指定 */
                if ((wAttr != 0) & (InterfaceDefine.IF_TH_PRNATTR_LINESP0 != 0)) {
                  spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x33"; spCmd[spLen++] = "\x00"; /* 改行量の設定 */
                } else {
                  spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x33";
                  spCmd[spLen++] = latin1.decode([24 + tPrnBuf.rct_lf_plus]);                /* 改行量の設定 */
                }
              }
              tPrnBuf.w_prn_data[tPrnBuf.w_cnt].cmd = spCmd.join();
              tPrnBuf.w_prn_data[tPrnBuf.w_cnt].cmd_len = spLen;
              tPrnBuf.w_prn_data[tPrnBuf.w_cnt].data = '';
              tPrnBuf.w_cnt++;
              break;

            case 2:
            /* 横倍 */
              tPrnBuf.w_prn_data[tPrnBuf.w_cnt].x_pos = 0;
              if (prt_type == CmSys.TPRTS) {
                spCmd[spLen++] = "\x12"; spCmd[spLen++] = "\x46"; spCmd[spLen++] = "\x01"; /* フォントサイズ */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x57"; spCmd[spLen++] = "\x00"; /* 横倍拡大解除 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x77"; spCmd[spLen++] = "\x01"; /* 縦倍拡大指定 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x46";                          /* 強調文字解除 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x33";
                spCmd[spLen++] = latin1.decode([tPrnBuf.rct_lf_plus]);                     /* 行間指定 */
              } else if ((prt_type == CmSys.TPRTF) && (CompileFlag.JPN)) {
                spCmd[spLen++] = "\x1d"; spCmd[spLen++] = "\x4c"; spCmd[spLen++] = "\x08"; spCmd[spLen++] = "\x00"; /* 左マージン位置設定 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x21"; spCmd[spLen++] = "\x10"; /* 印字モード指定 */
                spCmd[spLen++] = "\x1c"; spCmd[spLen++] = "\x21"; spCmd[spLen++] = "\x08"; /* 漢字印字モード一括指定 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x41"; spCmd[spLen++] = "\x06"; /* 印字モード一括指定 */
              } else if ((prt_type == CmSys.TPRTSS) ||
                       (prt_type == CmSys.TPRTIM) ||
                       (prt_type == CmSys.TPRTHP)) {
                if ((await CmCksys.cmZHQSystem() != 0) &&
                    (src == Tpraid.TPRAID_KITCHEN1_PRN)) {
                  LineFeedDot = 0;
                } else {
                  LineFeedDot = tPrnBuf.rct_lf_plus; /* 行間指定 */
                }
             // spCmd[spLen++] = "\x1d"; spCmd[spLen++] = "\x4c"; spCmd[spLen++] = "\x08"; spCmd[spLen++] = "\x00"; /* 左マージン位置設定 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x21"; spCmd[spLen++] = "\x20"; /* 印字モード指定 */
                spCmd[spLen++] = "\x1c"; spCmd[spLen++] = "\x21"; spCmd[spLen++] = "\x04"; /* 漢字印字モード一括指定 */
                spCmd[spLen++] = "\x1b"; spCmd[spLen++] = "\x33";
                spCmd[spLen++] = latin1.decode([24 + LineFeedDot]); /* 行間指定 */
              }
              tPrnBuf.w_prn_data[tPrnBuf.w_cnt].cmd = spCmd.join();
              tPrnBuf.w_prn_data[tPrnBuf.w_cnt].cmd_len = spLen;
              tPrnBuf.w_prn_data[tPrnBuf.w_cnt].data = '';
              first_space = 0;

              tPrnBuf.w_cnt++;
              break;
          }
        }
      } else {
        tPrnBuf.y_pos = wYpos;
        first_space = 0;
      }

      /* 同一行データのため、編集エリアに格納 */
//    if ((wYpos == tPrnBuf.y_pos) || (wAttr == InterfaceDefine.IF_TH_PRNATTR_ROTATE270)) {
      if (wYpos == tPrnBuf.y_pos) {
        if (tPrnBuf.w_cnt == 0) {	/* 先頭の場合は、空白文字数を使用しない */
          space_count = 0;
        }
        tPrnBuf.w_prn_data[tPrnBuf.w_cnt].x_pos = (((wXpos + 7) / num)).toInt() + space_count + first_space - space_count;
        /* 桁 = ( x-pixel + 7 ) / 8 + 半角スペース */

        tPrnBuf.w_prn_data[tPrnBuf.w_cnt].cmd_len = rt_buf.length + h_num;
        tPrnBuf.w_prn_data[tPrnBuf.w_cnt].cmd = rt_buf + cmd_buf;
        /* コマンド保存 */

        tPrnBuf.w_prn_data[tPrnBuf.w_cnt].data = tSJisBuf;
        /* 印字データ */
        tPrnBuf.w_cnt++;
        if (wAttr == InterfaceDefine.IF_TH_PRNATTR_ROTATE270) {
          await IfThCom.ifThSetChar(IfThLib.IF_TH_TYPE_CHAR);
        }
      }

      return (InterfaceDefine.IF_TH_POK);
    }

    /* First check of x and y start position */
    if ( (wXpos < 0) || ((tPrnBuf.crast * 8) <= wXpos) ||
        (wYpos < 0) || (tPrnBuf.cbtmline <= (wYpos + tPrnBuf.ctopline)) ) {
      sMsgBuf = "if_th_PrintString : X or Y position error! "
          "wXpos(${wXpos}) wYpos(${wYpos}) crast(${tPrnBuf.crast}) "
          "cbtmline(${tPrnBuf.cbtmline}) ctopline(${tPrnBuf.ctopline})";
      TprLog().logAdd(0, LogLevelDefine.error, sMsgBuf);
      debugPrint("${sMsgBuf}");
      return (InterfaceDefine.IF_TH_PERXYSTART);
    }

    if (IfThPrnStr.SJIS_FONT != 0) {
      tSJisBuf = await Utf2Shift.utf2shift(ptString);
      if (tSJisBuf != 0) { //  utf2shift(ptString, tSJisBuf, 0)) {
        return (InterfaceDefine.IF_TH_PERCNVSJIS); /* Can't convert character code */
      }
    }

    if (ret != 0) {				/* Error happened */
      return( ret );
    }

    if( prt_type != CmSys.SUBCPU_PRINTER ) {

      tPrnBuf.prn_mode = IfThLib.IF_TH_TYPE_BMP;		/* 印字タイプ：文字列 */

      if( tPrnBuf.edit_type == IfThLib.IF_TH_TYPE_CMD) { /* コマンド編集あり */
        await IfThCom.ifThSetChar(IfThLib.IF_TH_TYPE_CMD);
      }

      if (tPrnBuf.edit_type != IfThLib.IF_TH_TYPE_BMP) {
        tPrnBuf.edit_type = IfThLib.IF_TH_TYPE_BMP;

        /** 印字順序セット */
        tPrnBuf.prn_type = IfThLib.IF_TH_TYPE_BMP;
      //tPrnBuf.prn_order[tPrnBuf.prn_cnt].prn_type = IfThLib.IF_TH_TYPE_BMP;
        tPrnBuf.prn_cnt++;
      }
    }

    // TODO:
    //VF_FreeBitmap( tCBM );			/* Free composed bitmap */

    if (InterfaceDefine.PERFORMANCE00) {
      tv2 = DateTime.now();

      // gettimeofday(&tv2, &tz);
      // if (tv2.tv_usec < tv.tv_usec) {
      //   tv2.tv_usec += 1000000;
      // }
      String msgbuf = "PERFORMANCE if_th_PrintString end   ${tv2.second} ${tv2.microsecond} diff ${(tv2.microsecond - tv.microsecond)} \n";
      TprLog().logAdd(0, LogLevelDefine.normal, msgbuf);
    }

    return (InterfaceDefine.IF_TH_POK);
  }

  static (int offsetY, int timeY) getOffsetYPosition(int src, int iAFontId, int iKFontId) {
    int offsetY = 0;
    int timeY = 1;

    switch (IfThInit.prnInfNum(src, iAFontId)) {
      case PrnFontIdx.E24_16_1_1:	/* font 16 1x1 */
      case PrnFontIdx.E16_16_1_1:	/* font 16 1x1 */
        offsetY = 16;
        timeY = 1;
        break;
      case PrnFontIdx.E16_16_2_2:	/* font 16 2x2 */
        offsetY = 16;
        timeY = 2;
        break;
      case PrnFontIdx.E24_24_1_1:	/* font 24 1x1 */
      case PrnFontIdx.E16_24_1_1:	/* font 24 1x1 */
      case PrnFontIdx.E24_24_1_2:	/* font 24 1x2 */
      case PrnFontIdx.E24_48_1_1:	/* font 24 1x2 */
        offsetY = 24;
        timeY = 1;
        break;
      case PrnFontIdx.E24_24_2_1:	/* fornt 24 2x1 */
      case PrnFontIdx.E24_24_2_2:	/* font 24 2x2 */
        offsetY = 24;
        timeY = 2;
        break;
      default:
        offsetY = 24;
        timeY = 1;
        break;
    }
    return (offsetY, timeY);
  }

  static String getRotateCommand(int src, int wAttr, int wXpos, int wYpos, int iAFontId, int iKFontId) {
    List<String> rtCmd = List<String>.filled(20, "");
    int rtLen = 0;

    switch (wAttr) {
      case InterfaceDefine.IF_TH_PRNATTR_ROTATE270:
        rtCmd[rtLen++] = "\x1b"; rtCmd[rtLen++] = "\x54"; rtCmd[rtLen++] = "\x03"; // 印字方向
        rtCmd[rtLen++] = "\x1d"; rtCmd[rtLen++] = "\x24";
        rtCmd[rtLen++] = latin1.decode([(wYpos & 0x00FF) >> 0]);
        rtCmd[rtLen++] = latin1.decode([(wYpos & 0xFF00) >> 8]); // Y座標
        rtCmd[rtLen++] = "\x1b"; rtCmd[rtLen++] = "\x24";
        rtCmd[rtLen++] = latin1.decode([(wXpos & 0x00FF) >> 0]);
        rtCmd[rtLen++] = latin1.decode([(wXpos & 0xFF00) >> 8]); // X座標
        break;
      case InterfaceDefine.IF_TH_PRNATTR_NO_OPTION:
      case InterfaceDefine.IF_TH_PRNATTR_ROTATE90:
      case InterfaceDefine.IF_TH_PRNATTR_ROTATE180:
      case InterfaceDefine.IF_TH_PRNATTR_REVERSE:
        break;
      default:
        break;
    }
    return rtCmd.join();
  }


// /*-----------------------------------------------------------------------*/
// #if SJIS_FONT
// static void sjis2jis( int *p1, int *p2 )
// {
//         unsigned char c1 = *p1;
//         unsigned char c2 = *p2;
//         int adjust = c2 < 159;
//         int rowOffset = c1 < 160 ? 112 : 176;
//         int cellOffset = adjust ? (c2 > 127 ? 32 : 31) : 126;
//         *p1 = ((c1 - rowOffset) << 1) - adjust;
//         *p2 -= cellOffset;
// }
// #endif

  (int kanji, int code, int size)	pickup_code(String str, int kanji, int code) {

    int size = 0;

    size = AplLibStrUtf.aplLibEucGetSize(str);
    String buff = str;
//  List<String> buff = str.split("");

    switch (size) {
      case 1:
        if((0x20 <= buff[0].codeUnitAt(0)) && (buff[0].codeUnitAt(0) < 0x80)) {
          kanji = 0;	/* 半角英数 */
          code = buff.codeUnitAt(0);
        }
        break;
      case 2:
        kanji = 1;		/* 全角 */
        code = (buff.codeUnitAt(0) << 8) + buff.codeUnitAt(1);
        break;
      case 3:
        code = (buff.codeUnitAt(0) << 16) + (buff.codeUnitAt(1) << 8) + buff.codeUnitAt(2);
        if((0xefbda0 < code) && (code < 0xefbfa0)) {
          kanji = 0;	/* 半角カナ */
        } else {
          kanji = 1;	/* 全角 */
        }

        break;
      case 4:
        kanji = 1;		/* 全角 */
        code = (buff.codeUnitAt(0) << 24) + (buff.codeUnitAt(1) << 16) +
               (buff.codeUnitAt(2) <<  8) + (buff.codeUnitAt(3) <<  0);
        break;
      default:
        break;
    }

    return (kanji, code, size);
  }


  /*-----------------------------------------------------------------------*/
  static Future<int> get_ank_space( TprTID src, int iAFontId, VF_BITMAP tBM ) async {
    int	ret;		/* Return code */


    src = await CmCksys.cmQCJCCPrintAid(src);

    //TODO:
    //tBM = VF_GetBitmap2( iAFontId, ANK_SPACE, 1, 1);
    if (null == tBM) {

      sMsgBuf = "get_ank_space : Error on VF_GetBitmap2( code = 0x20 )";
      TprLog().logAdd(src, LogLevelDefine.error, sMsgBuf);

      if (InterfaceDefine.DEBUG_UT) {
        debugPrint("${sMsgBuf}");
      }
          /* Try to get fake bitmap data of space */
      ret = await get_alt_ank_space( src, iAFontId, tBM );
      return (ret);
    } else {
      return (InterfaceDefine.IF_TH_POK);
    }
  }


  /*-----------------------------------------------------------------------*/
  static Future<int> get_alt_ank_space(TprTID src, int iAFontId, VF_BITMAP tBM ) async {

    /* Make fake VF_BITMAP data of space character	*/
    /*  from bitmap data of 'A'			*/
    src = await CmCksys.cmQCJCCPrintAid(src);

    // TODO:
    //tBM = VF_GetBitmap2( iAFontId, ANK_A, 1, 1 );
    if (null == tBM) {

      sMsgBuf = "get_alt_ank_space : Error on VF_GetBitmap2( code = 'A' )";
      TprLog().logAdd(src, LogLevelDefine.error,  sMsgBuf);
      if (InterfaceDefine.DEBUG_UT) {
        debugPrint("${sMsgBuf}");
      }
      return (InterfaceDefine.IF_TH_PERGETBITMAP);	/* Can't get bitmap data of 'A' */
    }

    Uint8List dmy_space = Uint8List(1);	/* Dummy bitmap data for ANK space(=0x20) */
    if (0 == dmy_space.length) {
      sMsgBuf = "get_alt_ank_space : Error on calloc() for dummy space.";
      TprLog().logAdd(src, LogLevelDefine.error,  sMsgBuf);
      if (InterfaceDefine.DEBUG_UT) {
        debugPrint("${sMsgBuf}");
      }
      return (InterfaceDefine.IF_TH_PERALLOC);	/* Can't allocate bitmap space */
    }

    tBM.bbx_width  = 1;
    tBM.bbx_height = 1;
    tBM.off_x  = 0;
    tBM.off_y  = 1;
    tBM.bitmap = dmy_space;
    tBM.raster = 1;

    return (InterfaceDefine.IF_TH_POK);
  }
}
