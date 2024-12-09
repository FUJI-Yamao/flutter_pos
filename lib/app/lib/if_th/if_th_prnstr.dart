/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';

import 'package:flutter_pos/app/lib/if_th/utf2shift.dart';
import '../../inc/lib/if_thlib.dart';

import '../../inc/sys/tpr_type.dart';
import '../apllib/mm_reptlib.dart';
import 'if_th_init.dart';

// /// 関連tprxソース:if_th_prnstr.c
// class IfThPrnStr {
//
//   /* Local defines */
//   static ThPrnBuf tPrnBuf = ThPrnBuf();   /* Print buffer */
//
//    //TOOD 仮.
//   static List<String> printBuff = [];
//
//   static void clearBuff(){
//     printBuff.clear();
//   }
//
//   /// Parameter:	(IN)	src	: APL-ID
//   /// 			wXpos	: X position of the string
//   /// 			wYpos	: Y position of the string
//   /// 			Attr	: Attribute of the string
//   /// 			iAFontId: Font id for ASCII character
//   /// 			iKFontId: Font id for KANJI character
//   /// 			ptString: Pointer to string
//   /// Return value:	IF_TH_POK	: Normal end
//   /// 		IF_TH_PERPARAM	: Generic parameter error
//   /// 		IF_TH_PERXYSTART: X or Y start position error
//   /// 		IF_TH_PERCNVSJIS: Character code conversion error
//   /// 		IF_TH_PERGETBITMAP : Error on VF_GetBitmap2
//   /// 		IF_TH_PERALLOC	: Memory allocation error
//   /// 		IF_TH_PERXRANGE	: X range over error
//   /// 		IF_TH_PERYRANGE	: Y range over error
//   /// 		IF_TH_PERROTATE	: Error on VF_RotatedBitmap
//   /// 関連tprxソース:if_th_prnstr.c - if_th_PrintString
//   /// TODO:00015 江原 定義のみ追加
//   static ifThPrintString( TprTID src, int wXpos, int wYpos, int wAttr, int iAFontId, int iKFontId, String ptString ) {
//     String textSjis = Utf2Shift.utf2shift(ptString);
// /*  // 一旦無効化する
//     List<String> cmdBuf = List<String>.generate(20, (index) => "");
//     int len = 0;
//     switch(IfThInit.prnInfNum(src, iAFontId)) {
//       case PrnFontIdx.E24_16_1_1:	/* font 16 1x1 */
//       case PrnFontIdx.E16_16_1_1:	/* font 16 1x1 */
//         cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x00"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
//         cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x00"; /* 半角フォントサイズ */
//         cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x00"; /* 全角 フォントサイズ */
//         cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x41"; cmdBuf[len++] = "\x02"; /* 行間指定 */
//         break;
//       case PrnFontIdx.E24_24_1_1:	/* font 24 1x1 */
//       case PrnFontIdx.E16_24_1_1:	/* font 24 1x1 */
//         cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x08"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
//         cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x01"; /* 半角フォントサイズ */
//         cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x01"; /* フォントサイズ */
//         cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x41"; cmdBuf[len++] = latin1.decode([tPrnBuf.rct_lf_plus]); /* 行間指定 */
//         break;
//       case PrnFontIdx.E24_24_1_2:	/* font 24 1x2 */
//       case PrnFontIdx.E24_48_1_1:	/* font 24 1x2 */
//         cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x08"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
//         cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x11"; /* 半角フォントサイズ */
//         cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x09"; /* フォントサイズ */
//         cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x41"; cmdBuf[len++] = latin1.decode([tPrnBuf.rct_lf_plus]); /* 行間指定 */
//         break;
//       case PrnFontIdx.E24_24_2_1:	/* fornt 24 2x1 */
//         cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x08"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
//         cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x21"; /* 半角フォントサイズ */
//         cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x05"; /* フォントサイズ */
//         cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x41"; cmdBuf[len++] = latin1.decode([tPrnBuf.rct_lf_plus]); /* 行間指定 */
//         break;
//       case PrnFontIdx.E24_24_2_2:	/* font 24 2x2 */
//         cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x08"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
//         cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x31"; /* 半角フォントサイズ */
//         cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x0d"; /* フォントサイズ */
//         cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x41"; cmdBuf[len++] = latin1.decode([tPrnBuf.rct_lf_plus]); /* 行間指定 */
//         break;
//       case PrnFontIdx.E16_16_2_2:	/* font 16 2x2 */
//         cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x00"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
//         cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x30"; /* 半角フォントサイズ */
//         cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x0c"; /* フォントサイズ */
//         cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x41"; cmdBuf[len++] = "\x02"; /* 行間指定 */
//         break;
//       default:
//         return (-1, "", 0, 0);
//     }
//     String fontSet = cmdBuf.join("");
//
//     printBuff.add(fontSet + textSjis);
// */
//     printBuff.add(textSjis);
//     return 0;
//   }
// }
