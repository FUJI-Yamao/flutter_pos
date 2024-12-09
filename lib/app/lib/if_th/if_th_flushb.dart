/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th.c
//  このファイルは上記Cソースファイルを元にdart化したものです。

// ************************************************************************
// File:           if_th_flushb.c
// Contents:       if_th_FlushBuf();
// ************************************************************************

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_pos/app/inc/lib/if_thlib.dart';
import 'package:flutter_pos/app/lib/if_th/if_th_alloc.dart';
import 'package:flutter_pos/app/lib/if_th/if_th_ccut.dart';
import 'package:flutter_pos/app/lib/if_th/if_th_com.dart';
import 'package:flutter_pos/app/lib/if_th/utf2shift.dart';
import 'package:get/get.dart';

import '../../../clxos/calc_api_result_data.dart';
import '../../drv/ffi/library.dart';
import '../../drv/printer/drv_print_isolate.dart';
import '../../drv/printer/ubuntu/drv_printer_def.dart';
import '../../if/common/interface_define.dart';
import '../../if/if_drv_control.dart';
import '../../inc/apl/rxmem.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../sys/tmode/tmode2.dart';
import '../apllib/aplLib_barPrn.dart';
import '../cm_sys/cm_cksys.dart';
import 'aa/if_th_prnstr.dart';
import 'if_th_cflush.dart';
import 'if_th_clogoprint.dart';
import 'if_th_csnddata.dart';
import 'if_th_csndlogo.dart';
import 'if_th_init.dart';
import 'if_th_pagemode.dart';
import 'if_th_prnline.dart';
import 'if_th_prnrect.dart';

class IfThFlushB {

  /// 電子レシート情報タグ（開始側）
  static const _rcptTagFontSize     = "@fontsize";
  static const _rcptTagFontSizeV_S  = "@fontsizeV@";
  static const _rcptTagFontSizeH_S  = "@fontsizeH@";
  static const _rcptTagFontSizeVH_S = "@fontsizeVH@";
  static const _rcptTagBitmap_S     = "@bitmap@";
  static const _rcptTagQrCode_S     = "@qrcode@";
  static const _rcptTagBar          = "@bar";
  static const _rcptTagBar8_S       = "@bar8_HNC@";
  static const _rcptTagBar_S        = "@bar_HNC@";
  static const _rcptTagBarC128_S    = "@barC128_HNC@";

  /// 電子レシート情報タグ（終了側）
  static const _rcptTagFontSizeV_E  = "@/fontsizeV@";
  static const _rcptTagFontSizeH_E  = "@/fontsizeH@";
  static const _rcptTagFontSizeVH_E = "@/fontsizeVH@";
  static const _rcptTagBitmap_E     = "@/bitmap@";
  static const _rcptTagQrCode_E     = "@/qrcode@";
  static const _rcptTagBar8_E       = "@/bar8_HNC@";
  static const _rcptTagBar_E        = "@/bar_HNC@";
  static const _rcptTagBarC128_E    = "@/barC128_HNC@";

  static ThPrnBuf tPrnBuf = ThPrnBuf();

  static const RETRY_DELAY = 20000;	/* 20ms */
  static const MAX_RETRY   = 250;	  /* 5sec */

  /// クラウドPOSからのデータを、プリンタへ送るメッセージデータに変換し、送信する
  //  名称を変えたい。クラウドPOSからのれシード印字に特価した処理とする。
  //  Future<void> printCloudReceipt(CalcResultPay sndData) async {
  static Future<void> printSendMessage(TprTID src, PayDigitalReceipt? sndData, {bool ejConfModeT = false}) async {
    bool isWin = Platform.isWindows && !isLinuxDebugByWin();
    String str = "";
    int wAttr = InterfaceDefine.IF_TH_PRNATTR_NO_OPTION;
    int lines = 0;
    int font_e = -1;
    int font_j = -1;
    int wThick = 0;
    int wStyle = 0;
    bool bodyBuf = false;
    String barcode = "";
    String bitmap = "";

    tPrnBuf = ThPrnBuf();

    int receiptLen = sndData?.transaction?.trkReceiptImageList?.length ?? 0;
    if (receiptLen == 0) {
      debugPrint("Digital Receipt is Empty");
      return;
    }

    List<PayTRKReceiptImage> trkReceiptImageList =
        sndData!.transaction!.trkReceiptImageList!;

    for (int i = 0; i < receiptLen; i++) {
      String printType = trkReceiptImageList[i].printType ?? "";
      String cutType = trkReceiptImageList[i].cutType ?? "";
      int partsLen = trkReceiptImageList[i].pageParts?.partsDataList?.length ?? 0;
      int lineLen = trkReceiptImageList[i].receiptLineList?.length ?? 0;

      switch(printType) {
        case "":
          break;
        case "Line":
          wAttr = InterfaceDefine.IF_TH_PRNATTR_NO_OPTION;
          await IfThAlloc.ifThAllocArea(src, Tmode2.PRINT_LINE1);
          await IfThPageMode.ifThChangeStanderdMode(src);
          await ifThFlushBuf(src, lines * 30);

          for (int j = 0; j < lineLen; j++) {
            String tgt = trkReceiptImageList[i].receiptLineList![j] ?? "";
            str = "";
            // ビットマップ
            if (tgt.startsWith(_rcptTagBitmap_S)) {
              if (bodyBuf) {
                await ifThFlushBuf(src, lines * 30);
                bodyBuf = false;
              }
              await IfThCFlush.ifThCFlush(src);
              await IfThAlloc.ifThAllocArea(src, Tmode2.PRINT_LINE1);
              bitmap = replaceTags(isWin, tgt, _rcptTagBitmap_S, "", _rcptTagBitmap_E, "", "Logo\/", "Logo/");
              if (bitmap.contains("Logo")) {
                await IfThCSndlogo.ifThLogoPrint2(src, InterfaceDefine.IF_TH_LOGO1);
              } else {
                await IfThCSndlogo.ifThLogoPrint2(src, InterfaceDefine.IF_TH_LOGO2);
              }
              await ifThFlushBuf(src, lines * 30);
            } else if(tgt.startsWith(_rcptTagBar)) {
              if (bodyBuf) {
                await ifThFlushBuf(src, lines * 30);
                bodyBuf = false;
              }
              await IfThAlloc.ifThAllocArea(src, Tmode2.PRINT_LINE1);
              if (tgt.startsWith(_rcptTagBar_S)) {
                // EAN13バーコード
                barcode = replaceTags(isWin, tgt, _rcptTagBar_S, "", _rcptTagBar_E, "");
                await AplLibBarPrn.barEan13(src, 0, 0, wAttr, PrnFontIdx.E16_16_1_1.id,
                    PrnFontIdx.E16_16_1_1.id, barcode, PrnterControlTypeIdx.TYPE_RCPT);
              } else if (tgt.startsWith(_rcptTagBar8_S)) {
                // EAN8バーコード
                barcode = replaceTags(isWin, tgt, _rcptTagBar8_S, "", _rcptTagBar8_E, "");
                await AplLibBarPrn.barEan8(src, 0, 0, wAttr,
                    PrnFontIdx.E16_16_1_1.id, PrnFontIdx.E16_16_1_1.id, barcode);
              } else if (tgt.startsWith(_rcptTagBarC128_S)) {
                // CODE128バーコード
                barcode = replaceTags(isWin, tgt, _rcptTagBarC128_S, "", _rcptTagBarC128_E, "");
                await AplLibBarPrn.barCode128C(src, 0, 0, wAttr, barcode,
                    barcode.length, PrnterControlTypeIdx.TYPE_RCPT);
              } else if (tgt.startsWith(_rcptTagQrCode_S)) {
                // QRコード
                barcode = replaceTags(isWin, tgt, _rcptTagQrCode_S, "", _rcptTagQrCode_E, "");
                await AplLibBarPrn.aplLibBarQR(src, barcode, barcode.length);
              }
              await ifThFlushBuf(src, lines * 30);
            } else if ((tgt.startsWith(_rcptTagFontSize)) || (!tgt.startsWith("@"))) {
              await IfThAlloc.ifThAllocArea(src, Tmode2.PRINT_LINE1);
              if (tgt.startsWith(_rcptTagFontSizeV_S)) {
                // 高さ2倍
                str = replaceTags(isWin, tgt, _rcptTagFontSizeV_S, "", _rcptTagFontSizeV_E, "", "@@", "@");
                await IfThPrnStr.ifThPrintString(src, 0, j, wAttr,
                    PrnFontIdx.E24_24_1_2.id, PrnFontIdx.E24_24_1_2.id, str);
                bodyBuf = true;
              } else if (tgt.startsWith(_rcptTagFontSizeH_S)) {
                // 幅2倍
                str = replaceTags(isWin, tgt, _rcptTagFontSizeH_S, "", _rcptTagFontSizeH_E, "", "@@", "@");
                await IfThPrnStr.ifThPrintString(src, 0, j, wAttr,
                    PrnFontIdx.E24_24_2_1.id, PrnFontIdx.E24_24_2_1.id, str);
                bodyBuf = true;
              } else if (tgt.startsWith(_rcptTagFontSizeVH_S)) {
                // 幅＋高さ2倍
                str = replaceTags(isWin, tgt, _rcptTagFontSizeVH_S, "", _rcptTagFontSizeVH_E, "", "@@", "@");
                await IfThPrnStr.ifThPrintString(src, 0, j, wAttr,
                    PrnFontIdx.E24_24_2_2.id, PrnFontIdx.E24_24_2_2.id, str);
                bodyBuf = true;
              } else if (!tgt.startsWith("@")) {
                // タグ無し
                str = replaceTags(isWin, tgt, "", "", "", "", "@@", "@");
                if (ejConfModeT) {
                  // 記録確認の印字、フォントサイズは小さめ
                  await IfThPrnStr.ifThPrintString(src, 0, j, wAttr,
                      PrnFontIdx.E24_16_1_1.id, PrnFontIdx.E24_16_1_1.id, str);
                } else {
                  await IfThPrnStr.ifThPrintString(src, 0, j, wAttr,
                      PrnFontIdx.E24_24_1_1.id, PrnFontIdx.E24_24_1_1.id, str);
                }
                bodyBuf = true;
              }
              lines ++;
            }
          }
          if (bodyBuf) {
            await ifThFlushBuf(src, lines * 30);
            bodyBuf = false;
          }
          break;
        case "Page":
          PayPageParts? parts = trkReceiptImageList![i].pageParts;
          int pageWidth    = parts?.width ?? 0;
          int pageHeigth   = parts?.height ?? 0;
          String direction = parts?.direction ?? "";

          // ページモード設定
          wAttr = getTorateAttr(direction);
          await IfThAlloc.ifThAllocArea(src, Tmode2.PRINT_LINE1);
          await IfThPageMode.ifThChangePageMode(src);
          await IfThPageMode.ifThPageAreaSet(src, 0, 0, pageWidth, pageHeigth);
          await ifThFlushBuf(src, lines * 30);

          for (int j = 0; j < partsLen; j++) {
            String text      = parts?.partsDataList?[j].text ?? "";
            String partsType = parts?.partsDataList?[j].partsType ?? "";
            int    startX    = parts?.partsDataList?[j].startX ?? 0;
            int    startY    = parts?.partsDataList?[j].startY ?? 0;
            int    endX      = parts?.partsDataList?[j].endX ?? 0;
            int    endY      = parts?.partsDataList?[j].endY ?? 0;
            String font      = parts?.partsDataList?[j].font ?? "";
            String scale     = parts?.partsDataList?[j].scale ?? "";
            String lineStyle = parts?.partsDataList?[j].lineStyle ?? "";
            switch (partsType) {
              case "Text":
                (font_e, font_j) = getFontType(scale, font);
                await IfThAlloc.ifThAllocArea(src, Tmode2.PRINT_LINE1);
                await IfThPrnStr.ifThPrintString(src, startX, startY, wAttr, font_e, font_j, text);
                bodyBuf = true;
                break;
              case "Line":
                if (bodyBuf) {
                  await ifThFlushBuf(src, lines * 30);
                  bodyBuf = false;
                }
                (wThick, wStyle) = IfThPrnline.getLineStyle(lineStyle);
                await IfThAlloc.ifThAllocArea(src, Tmode2.PRINT_LINE1);
                await IfThPrnline.ifThPrintLineCloud(src, pageWidth, pageHeigth,
                    startX, startY, endX, endY, wAttr, wThick, wStyle);
                await ifThFlushBuf(src, lines * 30);
                break;
              case "Rectangle":
                if (bodyBuf) {
                  await ifThFlushBuf(src, lines * 30);
                  bodyBuf = false;
                }
                (wThick, wStyle) = IfThPrnline.getLineStyle(lineStyle);
                await IfThAlloc.ifThAllocArea(src, Tmode2.PRINT_LINE1);
                await IfThPrnRect.ifThPrintRectangleCloud(src, pageWidth, pageHeigth,
                    startX, startY, endX, endY, wAttr, wThick, wStyle);
                await ifThFlushBuf(src, lines * 30);
                break;
              default:
                break;
            }
            lines ++;
          }
          await IfThAlloc.ifThAllocArea(src, Tmode2.PRINT_LINE1);
          await IfThPageMode.ifThPrintPageMode(src);
          await ifThFlushBuf(src, lines * 30);
          break;
        default:
          break;
      }
      if ((lineLen > 0) || (partsLen > 0)) {
        switch (cutType) {
          case "PartialCut": // パーシャルカット（一部残し）
            await IfThCCut.ifThCCut2(src, InterfaceDefine.IF_TH_NOLOGO, InterfaceDefine.IF_TH_PARTIALCUT);
            break;
          case "FullCut": // フルカット
            await IfThCCut.ifThCCut2(src, InterfaceDefine.IF_TH_NOLOGO, InterfaceDefine.IF_TH_FULLCUT);
            break;
          case "NotCut": // なにもしない
          default:
            break;
        }
      }
    }
  }

  static int getTorateAttr(String direction) {
    int wAttr = -1;
    switch (direction) {
      case "TopToBottom":  // 上から下
        wAttr = InterfaceDefine.IF_TH_PRNATTR_ROTATE270;
        break;
      case "BottomToTop":  // 下から上
        wAttr = InterfaceDefine.IF_TH_PRNATTR_ROTATE90;
        break;
      case "RightToLeft":  // 右から左
        wAttr = InterfaceDefine.IF_TH_PRNATTR_ROTATE180;
//      wAttr = InterfaceDefine.IF_TH_PRNATTR_REVERSE;
        break;
      case "LeftToRight":  // 左から右
      default:
        wAttr = InterfaceDefine.IF_TH_PRNATTR_NO_OPTION;
        break;
    }
    return wAttr;
  }
  static (int font_e, int font_j) getFontType(String scale, String font) {
    int font_e = -0;
    int font_j = -0;
    switch (scale) {
      case "V1H1":
        if (font == "Small") {
          font_e = PrnFontIdx.E16_16_1_1.id;
          font_j = PrnFontIdx.E16_16_1_1.id;
          } else if (font == "Normal") {
          font_e = PrnFontIdx.E24_24_1_1.id;
          font_j = PrnFontIdx.E24_24_1_1.id;
        }
        break;
      case "V1H2":
        font_e = PrnFontIdx.E24_24_1_2.id;
        font_j = PrnFontIdx.E24_24_1_2.id;
        break;
      case "V2H1":
        font_e = PrnFontIdx.E24_24_2_1.id;
        font_j = PrnFontIdx.E24_24_2_1.id;
        break;
      case "V2H2":
        if (font == "Small") {
          font_e = PrnFontIdx.E16_16_2_2.id;
          font_j = PrnFontIdx.E16_16_2_2.id;
        } else if (font == "Normal") {
          font_e = PrnFontIdx.E24_24_2_2.id;
          font_j = PrnFontIdx.E24_24_2_2.id;
        }
        break;
      default:
        break;
    }
    return (font_e, font_j);
  }

  /// クラウドPOSから受信した電子レシート中の対象文字列を指定文字列に置き換える。
  static String replaceTags(bool isWin, String tgt, String tag1, String replace1, String tag2, String replace2, [String tag3 = "", String replace3 = ""]) {
    tgt = tgt.replaceAll(tag1, replace1);
    tgt = tgt.replaceAll(tag2, replace2);
    tgt = tgt.replaceAll(tag3, replace3);
    return tgt;
  }

  static Future<int> ifThFlushBuf(TprTID src, int lines) async {
    int size = 0; /* Size of send data in bytes */
    int ret = 0; /* Return value */
    int retry = 0; /* retry counter */
    int prt_type = 0;

    src = await CmCksys.cmQCJCCPrintAid(src);

    ret = InterfaceDefine.IF_TH_POK;

    if (await CmCksys.cmDummyPrintMyself() == 1) {
      return InterfaceDefine.IF_TH_POK;
    }

    prt_type = await CmCksys.cmPrinterType();

    /* Send print data to driver */
    if (lines < 0) {
      /* Parameter error */
      ret = InterfaceDefine.IF_TH_PERPARAM;
    } else {
      if (tPrnBuf.ctopline < tPrnBuf.cbtmline) {
        if (0 == lines) {
          /* Flush all lines */
          size = tPrnBuf.cbtmline * tPrnBuf.crast;
        } else {
          /* Flush specified lines */
          if (tPrnBuf.cbtmline < lines) {
            size = tPrnBuf.cbtmline * tPrnBuf.crast;
          } else {
            size = lines * tPrnBuf.crast;
          }
        }
        while (true) {
          if ((prt_type != CmSys.SUBCPU_PRINTER) &&
              ((tPrnBuf.prn_cnt != 0) || (tPrnBuf.w_cnt != 0))) {  // prn_cnt:印字順序数   w_cnt:同一行の編集データ数
            ret = await ifThFlushBufBmpChar(src, lines);
            return (ret);
          } else {
            ret = await IfThCSenddata.ifThCSendData(src, tPrnBuf.bitmap, size, InterfaceDefine.IF_TH_PRINTBYCMD, 0);
          }
          if (ret == 0) {
            /* successfully */
            break;
          } else {
            /* fail */
            if ((src == Tpraid.TPRAID_PRN) || (src == Tpraid.TPRAID_QCJC_C_PRN)) {
              return (1); /* Retry at printer task */
            }
            // リトライしない
            // break;
            retry++;
            if (retry < MAX_RETRY) {
              if (InterfaceDefine.DEBUG_UT) {
                debugPrint("if_th_FlushBuf : retry ${retry}");
              }
              sleep(Duration(microseconds: RETRY_DELAY));
              continue;
            } else {
              break;
            }
          }
        }
        /* Reset print buffer */
        tPrnBuf.ctopline = tPrnBuf.cbtmline = 0;
      }
    }
    return (ret);
  }

/*-----------------------------------------------------------------------*/
/*
Usage:		if_th_FlushBuf_BmpChar( TPRTID src, int lines )
Functions:	Send print buffer data to driver
Parameters:	(IN)	src	: APL-IDswqa
			lines	: Number of lines to flush
Return value:	IF_TH_POK	: Normal end
		IF_TH_PERPARAM	: Parameter error
		IF_TH_PERWRITE	: Write error
*/
/*-----------------------------------------------------------------------*/
  /// プリントデータをドライバに送信する。
  /// 戻り値：-1:MMシステムではない  0:S  1:BS  2:M  3:ｽﾀﾝﾄﾞｱﾛﾝ only
  /// 関連tprxソース:if_th_flushb.c - if_th_FlushBuf_BmpChar()
  static Future<int> ifThFlushBufBmpChar(TprTID src, int lines) async {
    int size = 0; /* Size of send data in bytes */
    int retry = 0; /* retry counter */
    int ret = 0; /* Return value */
    int i = 0;
    int event_flg = 0;

    src = await CmCksys.cmQCJCCPrintAid(src);

    ret = InterfaceDefine.IF_TH_POK;

    /* Send print data to driver */
    if ( lines < 0 ) {		/* Parameter error */
      ret = InterfaceDefine.IF_TH_PERPARAM;
    } else {
      if (tPrnBuf.w_cnt != 0) {	/* 編集エリアにデータあり */
        if( tPrnBuf.edit_type == IfThLib.IF_TH_TYPE_CHAR ) { /* 文字列 */
          await IfThCom.ifThSetChar(IfThLib.IF_TH_TYPE_CHAR);
        }
        else if( tPrnBuf.edit_type == IfThLib.IF_TH_TYPE_CMD ) { /* コマンド */
          await IfThCom.ifThSetChar(IfThLib.IF_TH_TYPE_CMD);
        }
      }

      event_flg = 1;
      // for( i = 0; i < tPrnBuf.prn_cnt; i++ ) {
      //   if( ( i + 1 ) == tPrnBuf.prn_cnt ) {	/* 最終 */
      //     event_flg = 0;
      //   }
        while (true){
          switch (tPrnBuf.prn_type /*tPrnBuf.prn_order[i].prn_type*/) {
            case IfThLib.IF_TH_TYPE_CHAR:	/* 文字列 */
              ret = await IfThCSenddata.ifThCSendDataS(src, tPrnBuf.prn_char, tPrnBuf.prn_char.length, InterfaceDefine.IF_TH_PRINTBYCMD, "A", event_flg);
              break;
            case IfThLib.IF_TH_TYPE_CMD:	/* コマンド */
              ret = await IfThCSenddata.ifThCSendDataS(src, tPrnBuf.prn_cmd, tPrnBuf.prn_cmd.length, InterfaceDefine.IF_TH_PRINTBYCMD, "X", event_flg);
              break;
            default:				/* ビットマップ */
              if ( 0 == lines ) {	/* Flush all lines */
                size = tPrnBuf.cbtmline * tPrnBuf.crast;
              } else {	/* Flush specified lines */
                if ( tPrnBuf.cbtmline < lines ) {
                  size = tPrnBuf.cbtmline * tPrnBuf.crast;
                } else {
                  size = lines * tPrnBuf.crast;
                }
              }
              ret = await IfThCSenddata.ifThCSendData(src, tPrnBuf.bitmap, size, InterfaceDefine.IF_TH_PRINTBYCMD, event_flg);
              break;
          }

          if (ret == InterfaceDefine.IF_TH_POK) {
            /* successfully */
            size = 0;
            break;
          } else {
            /* fail */
            if ((src == Tpraid.TPRAID_PRN) || (src == Tpraid.TPRAID_QCJC_C_PRN)) {
              return (1);						/* Retry at printer task */
            }
            retry++;
            if (retry < MAX_RETRY) {
              sleep(Duration(microseconds: RETRY_DELAY));
              continue;
            } else {
              /* retry over */
              break;
            }
          }
        }
      //}

      /* Reset print buffer */
      tPrnBuf.ctopline = tPrnBuf.cbtmline = 0;

      tPrnBuf.prn_char_len = 0;
      tPrnBuf.prn_char = "";

      tPrnBuf.prn_cmd_len = 0;
      tPrnBuf.prn_cmd = "";

      tPrnBuf.y_pos = -1;
      tPrnBuf.w_cnt = 0;

      tPrnBuf.w_prn_data = List<ThPrnData>.generate(
          IfThLib.IF_TH_W_PRN_NUM, (index) => ThPrnData());
      tPrnBuf.edit_type = IfThLib.IF_TH_TYPE_NONE;
      tPrnBuf.prn_cnt = 0;
    }
    return (ret);
  }

  // static Future<int> ExecPrintInit() {
  //   int		ret;
  //   String logStr = "";  //[256];
  //   String vflibcap = "";
  //
  //   // rmstTimerRemove();
  //   // rmstPrnTimerRemove( );
  //
  //   /* 2006/03/06 >>> */
  //   /* フォント初期化 */
  //   if ((ret = VF_Init(vflibcap, NULL)) < 0) {
  //     logStr = "Error on VF_Init. ret(${ret})\n";
  //     TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, logStr);
  //   }
  //
  //   /* フォントオープン (couri.pfa 8X16) */
  //   if ((font_e = VF_OpenFont2("rgmhhc24.bdf", 24, 1, 1)) < 0 ) {
  //     logStr = "Error on VF_OpenFont2. (rgmhhc24.1:${font_e})\n";
  //     TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, logStr);
  //   }
  //   PrnInf_Set(TPRAID_STR, font_e, E24_24_1_1);
  //
  //   if ((font_e2 = VF_OpenFont2("rgmhhc24.bdf", 24, 1, 2)) < 0 ) {
  //     logStr = "Error on VF_OpenFont2. (rgmhhc24.2:${font_e2})\n";
  //     TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, logStr);
  //   }
  //   PrnInf_Set(TPRAID_STR, font_e2, E24_24_1_2);
  //
  //   if ((font_j = VF_OpenFont2("rgmj0124.bdf", 24, 1, 1)) < 0 ) {
  //     logStr = "Error on VF_OpenFont2. (wadalab-gothic.1:${font_j})\n";
  //     TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, logStr);
  //   }
  //
  //   if ((font_j2 = VF_OpenFont2("rgmj0124.bdf", 24, 1, 2)) < 0 ) {
  //     logStr = "Error on VF_OpenFont2. (rgmj0124.2:${font_j2})\n";
  //     TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, logStr);
  //   }
  //
  //   stopncls_printError = 0;
  //   stopncls_printStep = 0;
  //   /* <<< 2006/03/06 */
  //
  //   /* プリンター初期化 */
  //   if ((ret = if_th_Init(TPRAID_STR)) < 0) {
  //     debugPrint("Error on if_th_Init. ret(${ret})\n");
  //   }
  //
  //   rmstPrnTimerInit( ); /* 2007/03/29 */
  //
  //   /* プリンターチェックへ */
  //   rmstTimerAdd(NEXT_GO_TIME, (GtkFunction)ExecPrintChk);
  //   TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "ExecPrintInit End");
  //   return 0;
  //}

}
