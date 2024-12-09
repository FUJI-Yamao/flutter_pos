/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_com.c
//  このファイルは上記ヘッダーファイルを元にdart化したものです。

// ************************************************************************
// File:           if_th_com.c
//
// Contents:       if_th_Set_Char();
//                 if_th_Cmd();
//                 if_th_Cmd_LineChar();
//                 if_th_FontSet();
// ************************************************************************

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/apl/compflag.dart';
import 'package:flutter_pos/app/inc/lib/cm_sys.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/lib/if_th/if_th_init.dart';
import 'package:flutter_pos/app/lib/if_th/utf2shift.dart';

import '../../common/cmn_sysfunc.dart';
import '../../if/common/interface_define.dart';
import '../../inc/apl/rxmem.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/if_thlib.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../apllib/AplLib_EucAdjust.dart';
import '../apllib/competition_ini.dart';

class IfThCom {

  static ThPrnBuf tPrnBuf = ThPrnBuf();

  static const TRUE = 1;
  static const FALSE = 0;

  /// 関連tprxソース:if_th_com.c.c - if_th_Cmd()
  static Future<int> ifThCmd(TprTID src, String cmd, int len, int flg) async {
    String erlog = "";
//	int    web_type = 0;
    int    prt_type = 0;

    src = await CmCksys.cmQCJCCPrintAid(src);
    prt_type = await CmCksys.cmPrinterType();

    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return src;
    }

    if (prt_type != CmSys.SUBCPU_PRINTER) {
      if ((flg == IfThLib.IF_TH_TYPE_BMP) || (flg == IfThLib.IF_TH_TYPE_CMD_CHAR)) {
        await ifThSetChar(IfThLib.IF_TH_TYPE_CHAR);
      }
      if (len > 0) {
        int index = tPrnBuf.w_cnt;
        tPrnBuf.w_prn_data[index].cmd = cmd;
        tPrnBuf.w_prn_data[index].cmd_len = len;
        tPrnBuf.w_cnt++;
      }
      erlog = "if_th_Cmd( ${len} ), ${tPrnBuf.w_cnt}, ${flg}";
      TprLog().logAdd(src, LogLevelDefine.normal, erlog);
      if ((flg == IfThLib.IF_TH_TYPE_CMD) || (flg == IfThLib.IF_TH_TYPE_CMD_CHAR)) {
        src = await ifThSetChar(IfThLib.IF_TH_TYPE_CMD);
      } else if (flg == IfThLib.IF_TH_TYPE_CMD_BY_CHAR) {
        src = await ifThSetChar(IfThLib.IF_TH_TYPE_CMD_BY_CHAR);
      }
    }
    return src;
  }

  /// 関連tprxソース:if_th_com.c.c - if_th_Set_Char()
  static Future<int> ifThSetChar(int edit_type) async {
    int i = 0;
    int data_len = 0;
    String prn_data = "";
    String cmd_data = "";
    int    ret = 0;
    int    sp_cnt = 0;
    String sp_buf = "";
    int    prt_type = 0;

    ret = 0;
    prt_type = await CmCksys.cmPrinterType();
    if( prt_type != CmSys.SUBCPU_PRINTER) {
      if (tPrnBuf.w_cnt > 0) {
        if (edit_type == IfThLib.IF_TH_TYPE_CHAR) { 	   /* 文字列データ */
          /** 印字データ編集 **/
          data_len = 0;
          prn_data = "";
          for( i = 0; i < IfThLib.IF_TH_W_PRN_NUM; i++ ) {
            if( tPrnBuf.w_prn_data[i].cmd_len != 0 ) {
              sp_cnt = 0;
              if (i > 0) {
                sp_buf = "";
                sp_cnt = tPrnBuf.w_prn_data[i].x_pos - tPrnBuf.w_prn_data[i-1].x_pos - (tPrnBuf.w_prn_data[i-1].data).length;
                if( sp_cnt > 0 ){
                  sp_buf = ' ' * sp_cnt;
                } else {
                  sp_cnt = 0;
                }
              }
              prn_data += tPrnBuf.w_prn_data[i].cmd;
              data_len += tPrnBuf.w_prn_data[i].cmd_len;
              /* コマンド */

              if (sp_cnt > 0) {
                prn_data += sp_buf;
                data_len += sp_cnt;
              }

              prn_data += tPrnBuf.w_prn_data[i].data;
              data_len += (tPrnBuf.w_prn_data[i].data).length;
              /* 印字データ */
            } else {
              break;
            }
          }

          /* 印字データ */
          tPrnBuf.prn_type = IfThLib.IF_TH_TYPE_CHAR;
          tPrnBuf.prn_char += prn_data;
          tPrnBuf.prn_char_len += data_len;

          /* 印字・紙送り	*/
          if (edit_type == IfThLib.IF_TH_TYPE_CHAR) {
            tPrnBuf.prn_char += "\x0A";
            tPrnBuf.prn_char_len++;
            tPrnBuf.prn_cnt ++;
          }

          tPrnBuf.edit_type = IfThLib.IF_TH_TYPE_CHAR;
          tPrnBuf.w_cnt = 0;
          tPrnBuf.w_prn_data = List<ThPrnData>.generate(
              IfThLib.IF_TH_W_PRN_NUM, (index) => ThPrnData());
          ret = 1;
        } else if (edit_type == IfThLib.IF_TH_TYPE_CMD) {   /* コマンド編集 */
          /** 印字データ編集 **/
          data_len = 0;
          cmd_data = "";
          for( i = 0; i < IfThLib.IF_TH_W_PRN_NUM; i++ ) {
            if( tPrnBuf.w_prn_data[i].cmd_len != 0 ) {
              cmd_data += tPrnBuf.w_prn_data[i].cmd;
              data_len += tPrnBuf.w_prn_data[i].cmd_len;
              /* コマンド */
            } else {
              break;
            }
          }

          /* 印字データ（コマンド） */
          tPrnBuf.prn_type = IfThLib.IF_TH_TYPE_CMD;
          tPrnBuf.prn_cmd += cmd_data;
          tPrnBuf.prn_cmd_len += data_len;

          tPrnBuf.edit_type = IfThLib.IF_TH_TYPE_CMD;
          tPrnBuf.prn_cnt ++;

          tPrnBuf.w_cnt = 0;
          tPrnBuf.w_prn_data = List<ThPrnData>.generate(
              IfThLib.IF_TH_W_PRN_NUM, (index) => ThPrnData());
          ret = 1;
        } else if (edit_type == IfThLib.IF_TH_TYPE_CMD_BY_CHAR) { /* コマンド編集 */
          /** 印字データ編集 **/
          data_len = 0;
          cmd_data = "";
          for( i = 0; i < IfThLib.IF_TH_W_PRN_NUM; i++ ) {
            if( tPrnBuf.w_prn_data[i].cmd_len != 0 ) {
              cmd_data += tPrnBuf.w_prn_data[i].cmd;
              data_len += tPrnBuf.w_prn_data[i].cmd_len;
              /* コマンド */
            } else {
              break;
            }
          }

          // /* 印字データ（コマンド：ただし文字列扱い） */
          tPrnBuf.prn_type = IfThLib.IF_TH_TYPE_CHAR;
          tPrnBuf.prn_char += cmd_data;
          tPrnBuf.prn_char_len += data_len;
          tPrnBuf.prn_cnt ++;

          tPrnBuf.edit_type = IfThLib.IF_TH_TYPE_CHAR;
          tPrnBuf.w_cnt = 0;
          tPrnBuf.w_prn_data = List<ThPrnData>.generate(
            IfThLib.IF_TH_W_PRN_NUM, (index) => ThPrnData());
          ret = 1;
        }
      }
    }
    return (ret);
  }

  /// 関連tprxソース:if_th_com.c.c - if_th_Cmd_LineChar()
  static Future<int> ifThCmdLineChar(TprTID src, String cmd, int xposi, int iAFontId, int iKFontId, String ptString, int cut_len) async {
    String tmpbuf = "";
    String tmpbuf2 = "";
    String tmpbuf3 = "";
    EucAdj adj = EucAdj();
    int	   len = 0, num = 0, siz = 0, len2 = 0;
    int    char_tmp = 0;
    int    retFont = 0;

    src = await CmCksys.cmQCJCCPrintAid(src);

    (retFont, tmpbuf3, num, len, char_tmp) = await ifThFontSet(src, iAFontId, char_tmp, num, len, 0);
    if (retFont == -1) {
      return -1;
    }
    siz = (xposi / num).toInt();

    if(siz > 0) {
      tmpbuf2 = ' ' * siz;
    }
    AplLibEucAdjust();
    tmpbuf = ptString;
    adj = await AplLibEucAdjust.aplLibEucAdjust(tmpbuf, tmpbuf.length, cut_len);
    tmpbuf2 += tmpbuf;
    tmpbuf = "";
    switch (await CmCksys.cmPrinterType() != 0) {
      case CmSys.TPRTF :
        tmpbuf = await Utf2Shift.utf2shiftChg(tmpbuf2, 0);
        break;
      case CmSys.TPRTSS:
        tmpbuf = await Utf2Shift.utf2shiftChg(tmpbuf2, 2);
        break;
      default:
        tmpbuf = await Utf2Shift.utf2shiftChg(tmpbuf2, 1);
        break;

    }

    len2 = tmpbuf.length;
    cmd = "";

    return ( 2 + len + len2);
  }

  /// 関連tprxソース:if_th_com.c.c - if_th_FontSet()c
  static Future<(int ret, String cmd_buf, int num, int len, int sp_flg)>
      ifThFontSet(TprTID src, int iAFontId, int sp_flg, int num, int len, int wAttr) async {
    int     prt_type = 0;
    List<String> cmdBuf = List<String>.filled(100, "");

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (FALSE, "", 0, 0, 0);
    }
    RxCommonBuf pCom = xRet.object;

    src = await CmCksys.cmQCJCCPrintAid(src);

  //web_type = await CmCksys.cmWebType(pCom.iniSys);
    prt_type = await CmCksys.cmPrinterType();
    len = 0;

    if (prt_type == CmSys.TPRTS) {
  //	if( ( web_type == WEBTYPE_WEB2300 ) || ( web_type == WEBTYPE_WEB2500 ) || ( web_type == WEBTYPE_WEB2350 )
  //		|| (( web_type == WEBTYPE_WEB2800 )&&(cm_webspeeza_system() == 1)) )
      switch (IfThInit.prnInfNum(src, iAFontId)) {
        case PrnFontIdx.E24_16_1_1:	/* font 16 1x1 */
        case PrnFontIdx.E16_16_1_1:	/* font 16 1x1 */
          cmdBuf[len++] = "\x12"; cmdBuf[len++] = "\x46"; cmdBuf[len++] = "\x00"; /* フォントサイズ */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x57"; cmdBuf[len++] = "\x00"; /* 横倍拡大解除 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x77"; cmdBuf[len++] = "\x00"; /* 縦倍拡大解除 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x45";                         /* 強調文字指定 */

          if ((wAttr & InterfaceDefine.IF_TH_PRNATTR_LINESP0) == 0) {
            cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x33"; cmdBuf[len++] = "\x02"; /* 行間指定 */
          }
          num = (16 / 2).toInt();
          sp_flg = 0;
          break;

        case PrnFontIdx.E24_24_1_1:	/* font 24 1x1 */
        case PrnFontIdx.E16_24_1_1:	/* font 24 1x1 */
          cmdBuf[len++] = "\x12"; cmdBuf[len++] = "\x46"; cmdBuf[len++] = "\x01"; /* フォントサイズ */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x57"; cmdBuf[len++] = "\x00"; /* 横倍拡大解除 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x77"; cmdBuf[len++] = "\x00"; /* 縦倍拡大解除 */
          cmdBuf[len++] = "\x1b";
          if (await CompetitionIni.competitionIniGetShort(src,
              CompetitionIniLists.COMPETITION_INI_RCT_DNS,
              CompetitionIniType.COMPETITION_INI_GETMEM) == 1) {
            cmdBuf[len++] = "\x46"; /* 強調文字解除 */
          } else {
            cmdBuf[len++] = "\x45"; /* 強調文字指定 */
          }
          if((wAttr & InterfaceDefine.IF_TH_PRNATTR_LINESP0) == 0) {
            cmdBuf[len++] = "\x1b";
            cmdBuf[len++] = "\x33";
            cmdBuf[len++] = latin1.decode([tPrnBuf.rct_lf_plus]); /* 行間指定 */
          }

          num = (24 / 2).toInt();
          sp_flg = 1;
          break;

        case PrnFontIdx.E24_24_1_2:	/* font 24 1x2 */
        case PrnFontIdx.E24_48_1_1:	/* font 24 1x2 */
          cmdBuf[len++] = "\x12"; cmdBuf[len++] = "\x46"; cmdBuf[len++] = "\x01"; /* フォントサイズ */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x57"; cmdBuf[len++] = "\x00"; /* 横倍拡大解除 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x77"; cmdBuf[len++] = "\x01"; /* 縦倍拡大指定 */
          cmdBuf[len++] = "\x1b";
          if (await CompetitionIni.competitionIniGetShort(src,
              CompetitionIniLists.COMPETITION_INI_RCT_DNS,
              CompetitionIniType.COMPETITION_INI_GETMEM) == 1) {
            cmdBuf[len++] = "\x46"; /* 強調文字解除 */
          } else {
            cmdBuf[len++] = "\x45"; /* 強調文字指定 */
          }
          if((wAttr & InterfaceDefine.IF_TH_PRNATTR_LINESP0) == 0) {
            cmdBuf[len++] = "\x1b";
            cmdBuf[len++] = "\x33";
            cmdBuf[len++] = latin1.decode([tPrnBuf.rct_lf_plus]); /* 行間指定 */
          }

          num = (24 / 2).toInt();
          sp_flg = 2;
          break;

        case PrnFontIdx.E24_24_2_1:	/* fornt 24 2x1 */
          cmdBuf[len++] = "\x12"; cmdBuf[len++] = "\x46"; cmdBuf[len++] = "\x01"; /* フォントサイズ */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x57"; cmdBuf[len++] = "\x01"; /* 横倍拡大指定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x77"; cmdBuf[len++] = "\x00"; /* 縦倍拡大解除 */
          cmdBuf[len++] = "\x1b";
          if (await CompetitionIni.competitionIniGetShort(src,
              CompetitionIniLists.COMPETITION_INI_RCT_DNS,
              CompetitionIniType.COMPETITION_INI_GETMEM) == 1) {
            cmdBuf[len++] = "\x46"; /* 強調文字解除 */
          } else {
            cmdBuf[len++] = "\x45"; /* 強調文字指定 */
          }
          if((wAttr & InterfaceDefine.IF_TH_PRNATTR_LINESP0) == 0) {
            cmdBuf[len++] = "\x1b";
            cmdBuf[len++] = "\x33";
            cmdBuf[len++] = latin1.decode([tPrnBuf.rct_lf_plus]); /* 行間指定 */
          }

          num = (24 * 2 / 2).toInt();
          sp_flg = 1;
          break;

        case PrnFontIdx.E24_24_2_2:	/* font 24 2x2 */
          cmdBuf[len++] = "\x12"; cmdBuf[len++] = "\x46"; cmdBuf[len++] = "\x01"; /* フォントサイズ */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x57"; cmdBuf[len++] = "\x01"; /* 横倍拡大指定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x77"; cmdBuf[len++] = "\x01"; /* 縦倍拡大指定 */
          cmdBuf[len++] = "\x1b";
          if (await CompetitionIni.competitionIniGetShort(src,
              CompetitionIniLists.COMPETITION_INI_RCT_DNS,
              CompetitionIniType.COMPETITION_INI_GETMEM) == 1) {
            cmdBuf[len++] = "\x46"; /* 強調文字解除 */
          } else {
            cmdBuf[len++] = "\x45"; /* 強調文字指定 */
          }
          if ((wAttr & InterfaceDefine.IF_TH_PRNATTR_LINESP0) == 0) {
            cmdBuf[len++] = "\x1b";
            cmdBuf[len++] = "\x33";
            cmdBuf[len++] = latin1.decode([tPrnBuf.rct_lf_plus]); /* 行間指定 */
          }

          num = (24 * 2 / 2).toInt();
          sp_flg = 2;
          break;

        case PrnFontIdx.E16_16_2_2:	/* font 16 2x2 */
          cmdBuf[len++] = "\x12"; cmdBuf[len++] = "\x46"; cmdBuf[len++] = "\x00"; /* フォントサイズ */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x57"; cmdBuf[len++] = "\x01"; /* 横倍拡大指定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x77"; cmdBuf[len++] = "\x01"; /* 縦倍拡大指定 */
          cmdBuf[len++] = "\x1b";
          if (await CompetitionIni.competitionIniGetShort(src,
              CompetitionIniLists.COMPETITION_INI_RCT_DNS,
              CompetitionIniType.COMPETITION_INI_GETMEM) == 1) {
            cmdBuf[len++] = "\x46"; /* 強調文字解除 */
          } else {
            cmdBuf[len++] = "\x45"; /* 強調文字指定 */
          }

          if((wAttr & InterfaceDefine.IF_TH_PRNATTR_LINESP0) == 0) {
            cmdBuf[len++] = "\x1b";
            cmdBuf[len++] = "\x33";
            cmdBuf[len++] = "\x02"; /* 行間指定 */
          }

          num = (16 * 2 / 2).toInt();
          sp_flg = 0;
          break;

        default:
          TprLog().logAdd(src, LogLevelDefine.error, "if_th_FontSet : prnInfNum() Error");
          return (-1, "", num, len, sp_flg);
      }
    } else if ((prt_type == CmSys.TPRTF) && (CompileFlag.JPN)) {
  //	else if( web_type == WEBTYPE_WEBPLUS)

      switch(IfThInit.prnInfNum( src, iAFontId )) {
        case PrnFontIdx.E24_16_1_1:	/* font 16 1x1 */
        case PrnFontIdx.E16_16_1_1:	/* font 16 1x1 */
          cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x00"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x00"; /* 半角フォントサイズ */
          cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x00"; /* 全角 フォントサイズ */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x41"; cmdBuf[len++] = "\x02"; /* 行間指定 */
          num = (16 / 2).toInt();
          sp_flg = 0;
          break;

        case PrnFontIdx.E24_24_1_1:	/* font 24 1x1 */
        case PrnFontIdx.E16_24_1_1:	/* font 24 1x1 */
          cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x08"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x01"; /* 半角フォントサイズ */
          cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x01"; /* フォントサイズ */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x41"; cmdBuf[len++] = latin1.decode([tPrnBuf.rct_lf_plus]); /* 行間指定 */
          num = (24 / 2).toInt();
          sp_flg = 1;
          break;

        case PrnFontIdx.E24_24_1_2:	/* font 24 1x2 */
        case PrnFontIdx.E24_48_1_1:	/* font 24 1x2 */
          cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x08"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x11"; /* 半角フォントサイズ */
          cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x09"; /* フォントサイズ */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x41"; cmdBuf[len++] = latin1.decode([tPrnBuf.rct_lf_plus]); /* 行間指定 */
          num = (24 / 2).toInt();
          sp_flg = 2;
          break;

        case PrnFontIdx.E24_24_2_1:	/* fornt 24 2x1 */
          cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x08"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x21"; /* 半角フォントサイズ */
          cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x05"; /* フォントサイズ */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x41"; cmdBuf[len++] = latin1.decode([tPrnBuf.rct_lf_plus]); /* 行間指定 */
          num = (24 * 2 / 2).toInt();
          sp_flg = 1;
          break;

        case PrnFontIdx.E24_24_2_2:	/* font 24 2x2 */
          cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x08"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x31"; /* 半角フォントサイズ */
          cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x0d"; /* フォントサイズ */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x41"; cmdBuf[len++] = latin1.decode([tPrnBuf.rct_lf_plus]); /* 行間指定 */
          num = (24 * 2 / 2).toInt();
          sp_flg = 2;
          break;

        case PrnFontIdx.E16_16_2_2:	/* font 16 2x2 */
          cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x00"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x30"; /* 半角フォントサイズ */
          cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x0c"; /* フォントサイズ */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x41"; cmdBuf[len++] = "\x02"; /* 行間指定 */
          num = (16 * 2 / 2).toInt();
          sp_flg = 0;
          break;

        default:
          TprLog().logAdd(src, LogLevelDefine.error, "if_th_FontSet : prnInfNum() Error");
          return (-1, "", 0, 0, 0);
      }
    } else if ((prt_type == CmSys.TPRTSS) || (prt_type == CmSys.TPRTIM) || (prt_type == CmSys.TPRTHP)) {
//	else if (( web_type == WEBTYPE_WEB2800 )&&(cm_webspeeza_system() == 0))
      switch (IfThInit.prnInfNum(src, iAFontId)) {
        case PrnFontIdx.E24_16_1_1:	/* font 16 1x1 */
        case PrnFontIdx.E16_16_1_1:	/* font 16 1x1 */
        //TprLog().logAdd(src, LogLevelDefine.error, "16 1x1" );
          cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x00"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x01"; /* 半角フォントサイズ */

          if(prt_type == CmSys.TPRTHP) {
            // 全角 font16
            cmdBuf[len++] = "\x1c";
            cmdBuf[len++] = "\x28";
            cmdBuf[len++] = "\x41";
            cmdBuf[len++] = "\x02";
            cmdBuf[len++] = "\x00";
            cmdBuf[len++] = "\x30";
            cmdBuf[len++] = "\x01";
          }

          cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x01"; /* 全角 フォントサイズ */
          if (await CmCksys.cmRPPrinterChk() != 0) {
            cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x45"; cmdBuf[len++] = "\x00"; /* 強調文字解除 */
          } else {
            cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x45"; cmdBuf[len++] = "\x01"; /* 強調文字指定 */
          }

          if ((wAttr & InterfaceDefine.IF_TH_PRNATTR_LINESP0) == 0) {
            cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x33"; cmdBuf[len++] = latin1.decode([16 + 2]); /* 行間指定 */
          }

          num = (16 / 2).toInt();
          sp_flg = 0;
          break;

        case PrnFontIdx.E24_24_1_1:	/* font 24 1x1 */
        case PrnFontIdx.E16_24_1_1:	/* font 24 1x1 */
          //TprLog().logAdd(src, LogLevelDefine.error, "24 1x1");
          cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x00"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x00"; /* 半角フォントサイズ */
          cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x00"; /* フォントサイズ */

          if(prt_type == CmSys.TPRTHP)
          {	// 全角 font24
            cmdBuf[len++] = "\x1c";
            cmdBuf[len++] = "\x28";
            cmdBuf[len++] = "\x41";
            cmdBuf[len++] = "\x02";
            cmdBuf[len++] = "\x00";
            cmdBuf[len++] = "\x30";
            cmdBuf[len++] = "\x00";
          }

          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x45"; cmdBuf[len++] = "\x00"; /* 強調文字解除 */

          if((wAttr & InterfaceDefine.IF_TH_PRNATTR_LINESP0) == 0) {
            cmdBuf[len++] = "\x1b";
            cmdBuf[len++] = "\x33";
            cmdBuf[len++] = latin1.decode([24 + tPrnBuf.rct_lf_plus]); /* 行間指定 */
          }

          num = (24 / 2).toInt();
          sp_flg = 1;
          break;

        case PrnFontIdx.E24_24_1_2:	/* font 24 1x2 */
        case PrnFontIdx.E24_48_1_1:	/* font 24 1x2 */
        //TprLog().logAdd(src, LogLevelDefine.error, "24 1x1");
        //TprLog().logAdd(src, LogLevelDefine.error, "24 1x2" );
          cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x00"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x10"; /* 半角フォントサイズ */
          cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x08"; /* フォントサイズ */

          if(prt_type == CmSys.TPRTHP)
          {	// 全角 font24
            cmdBuf[len++] = "\x1c";
            cmdBuf[len++] = "\x28";
            cmdBuf[len++] = "\x41";
            cmdBuf[len++] = "\x02";
            cmdBuf[len++] = "\x00";
            cmdBuf[len++] = "\x30";
            cmdBuf[len++] = "\x00";
          }

          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x45"; cmdBuf[len++] = "\x00"; /* 強調文字解除 */

          if((wAttr & InterfaceDefine.IF_TH_PRNATTR_LINESP0) == 0) {
            cmdBuf[len++] = "\x1b";
            cmdBuf[len++] = "\x33";
            cmdBuf[len++] = latin1.decode([24 * 2 + tPrnBuf.rct_lf_plus]); /* 行間指定 */
          }

          num = (24 / 2).toInt();
          sp_flg = 1;
          break;

        case PrnFontIdx.E24_24_2_1:	/* fornt 24 2x1 */
        //TprLog().logAdd(src, LogLevelDefine.error, "24 2x1");
          cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x00"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x20"; /* 半角フォントサイズ */
          cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x04"; /* フォントサイズ */

          if(prt_type == CmSys.TPRTHP)
          {	// 全角 font24
            cmdBuf[len++] = "\x1c";
            cmdBuf[len++] = "\x28";
            cmdBuf[len++] = "\x41";
            cmdBuf[len++] = "\x02";
            cmdBuf[len++] = "\x00";
            cmdBuf[len++] = "\x30";
            cmdBuf[len++] = "\x00";
          }

          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x45"; cmdBuf[len++] = "\x00"; /* 強調文字解除 */

          if(prt_type != CmSys.TPRTHP)
          {
            cmdBuf[len++] = "\x1b";
            cmdBuf[len++] = "\x33";
            cmdBuf[len++] = latin1.decode([24 + tPrnBuf.rct_lf_plus]); /* 行間指定 */
          }

          num = (24 * 2 / 2).toInt();
          sp_flg = 1;
          break;

        case PrnFontIdx.E24_24_2_2:	/* font 24 2x2 */
        //TprLog().logAdd(src, LogLevelDefine.error, "24 2x2" );
          cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x00"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x30"; /* 半角フォントサイズ */
          cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x0c"; /* フォントサイズ */

          if(prt_type == CmSys.TPRTHP)
          {	// 全角 font24
            cmdBuf[len++] = "\x1c";
            cmdBuf[len++] = "\x28";
            cmdBuf[len++] = "\x41";
            cmdBuf[len++] = "\x02";
            cmdBuf[len++] = "\x00";
            cmdBuf[len++] = "\x30";
            cmdBuf[len++] = "\x00";
          }

          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x45"; cmdBuf[len++] = "\x00"; /* 強調文字解除 */

          if((wAttr & InterfaceDefine.IF_TH_PRNATTR_LINESP0) == 0)
          {
            cmdBuf[len++] = "\x1b";
            cmdBuf[len++] = "\x33";
            cmdBuf[len++] = latin1.decode([24 * 2 + tPrnBuf.rct_lf_plus]); /* 行間指定 */
          }

          num = (24 * 2 / 2).toInt();
          sp_flg = 1;
          //*sp_flg = 2;
          break;

        case PrnFontIdx.E16_16_2_2:	/* font 16 2x2 */
        //TprLog().logAdd(src, LogLevelDefine.error, "16 2x2" );
          cmdBuf[len++] = "\x1d"; cmdBuf[len++] = "\x4c"; cmdBuf[len++] = "\x00"; cmdBuf[len++] = "\x00"; /* 左マージン位置設定 */
          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x31"; /* 半角フォントサイズ */
          cmdBuf[len++] = "\x1c"; cmdBuf[len++] = "\x21"; cmdBuf[len++] = "\x0d"; /* フォントサイズ */

          if(prt_type == CmSys.TPRTHP)
          {	// 全角 font16
            cmdBuf[len++] = "\x1c";
            cmdBuf[len++] = "\x28";
            cmdBuf[len++] = "\x41";
            cmdBuf[len++] = "\x02";
            cmdBuf[len++] = "\x00";
            cmdBuf[len++] = "\x30";
            cmdBuf[len++] = "\x01";
          }

          cmdBuf[len++] = "\x1b"; cmdBuf[len++] = "\x45"; cmdBuf[len++] = "\x01"; /* 強調文字指定 */

          if((wAttr & InterfaceDefine.IF_TH_PRNATTR_LINESP0) == 0)
          {
            cmdBuf[len++] = "\x1b";
            cmdBuf[len++] = "\x33";
            cmdBuf[len++] = latin1.decode([16*2 + 2]); /* 行間指定 */
          }

          num = (16 * 2 / 2).toInt();
          sp_flg = 0;
          break;

        default:
          TprLog().logAdd(src, LogLevelDefine.error, "if_th_FontSet : prnInfNum() Error");
          return (-1, "", 0, 0, 0);
      }
    }
    return (0, cmdBuf.join(), num, len, sp_flg);
  }

  /// 関連tprxソース:if_th_com.c.c - if_th_event_chk
  int ifThEventChk(TprMID tid) {
    if((tid == TprDidDef.TPRDIDRECEIPT3) || (tid == TprDidDef.TPRDIDRECEIPT4)) {
      return 1;
    }
    return 0;
  }


  /// 関数名  ：ifThFileOutInit
  /// 機能概要：ファイル出力初期化
  /// 呼出方法：if_th_FileOutInit();
  /// 引数    ：pFile ファイル名（パス付）
  /// 戻り値  ：なし
  /// 関連tprxソース:if_th_com.c.c - if_th_FileOutInit
  void	ifThFileOutInit(String filePath) {
    final File file = File(filePath);
    if (!file.existsSync()) {
      // ファイルが存在しない場合、作成する。
      file.writeAsString("");
    }
    // ファイル名セット
    tPrnBuf.OutPutFileName = filePath;
    tPrnBuf.OutPutFileStop = FALSE;
    return;
  }

  /// 関数名  ：ifThFileOutFinish
  /// 機能概要：ファイル出力終了
  /// 引数    ：なし
  /// 戻り値  ：なし
  /// 関連tprxソース:if_th_com.c.c - if_th_FileOutFinish()
  void	ifThFileOutFinish() {
    if (tPrnBuf.OutPutFileName != "") {
      tPrnBuf.OutPutFileName = "";
    }
    return;
  }

  /// 関数名  ：ifThFileOutProc
  /// 機能概要：ファイル出力処理
  /// 引数    ：なし
  /// 戻り値  ：なし
  /// 関連tprxソース:if_th_com.c.c - if_th_FileOutProc()
  static void ifThFileOutProc(String pPrintString) {
    if (tPrnBuf.OutPutFileName == "") {
      return;
    }
    if (tPrnBuf.OutPutFileStop == TRUE) {
      return;
    }
    final File file = File(tPrnBuf.OutPutFileName);
    file.writeAsStringSync(pPrintString + "\n", mode:FileMode.append);
    return;
  }

  /// 関数名  ：ifThFileOutSuspend
  /// 機能概要：ファイル出力中断処理
  /// 引数    ：fStop TRUE(中断する)、FALSE(中断しない)
  /// 戻り値  ：なし
  /// 関連tprxソース:if_th_com.c.c - if_th_FileOutSuspend()
  void ifThFileOutSuspend(int fStop) {
    tPrnBuf.OutPutFileStop = fStop;
  }
}
