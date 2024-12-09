/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ffi/ffi.dart';
import 'package:flutter_pos/app/lib/apllib/image_label_dbcall.dart';
import 'package:sprintf/sprintf.dart';

import '../../../db_library/src/db_manipulation.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../if/common/interface_define.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmem_msg.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/apl/trm_list.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_str_molding_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../regs/checker/rcsyschk.dart';
import '../apllib/aplLib_barPrn.dart';
import '../apllib/apllib_strutf.dart';
import '../apllib/competition_ini.dart';
import '../cm_sys/cm_cksys.dart';
import 'aa/if_th_prnstr.dart';
import 'get_recmsg_mst.dart';
import '../cm_sys/cm_mkdat.dart';
import '../cm_sys/cm_stf.dart';
import '../cm_sys/sysdate.dart';
import '../pr_sp/cm_str_molding.dart';
import 'if_th_alloc.dart';
import 'if_th_cflush.dart';
import 'if_th_feed.dart';
import 'if_th_flushb.dart';
import 'if_th_gridstr.dart';
import 'if_th_prnbit.dart';
import 'if_th_prnstr.dart';
import 'if_thlib.dart';

/// 関連tprxソース: if_th_prerct.c
class IfThPreRct{
  static const DUMMY_DOTS =	24;	/* Dummy space in dots(=3mm) */
  static const PRINT_MAX_LEN = 32;
  static const HEADER_IMG_LEN	= 12;	// 店No:、ﾚｼｰﾄNo:、ﾚｼﾞNo:、ｼﾞｬｰﾅﾙNo:のタイトルの最大半角文字数
  static const STAFF_DATA_LEN	= PRINT_MAX_LEN / 2;	// staff_cd = X countのため, 印字幅の半分が従業員情報
  static const RECJNL_DATA_LEN = 4 + HEADER_IMG_LEN;	// receipt_no or print_no + イメージ文字数
  static const SLINE_MAX = 5;

  /// Usage:		if_th_PreReceipt( TPRTID tid, IF_TH_HEAD *ptIfThHead, int Kind,
  /// 				  int Print, int iAFontId, int iKFontId )
  /// Functions:	Setup receipt or report header
  /// Parameters:	(IN)	tid	: Task id
  /// 			ptIfThHead : Pointer to structure of header datas
  /// 			Kind	: Kind of receipt or report
  /// 			Print	: Print control(print shop name,...)
  /// 			iAFontId: Font id for ASCII character
  /// 			iKFontId: Font id for KANJI character
  /// Return value:	IF_TH_POK	: Normal end
  /// 		IF_TH_PERWRITE	: Write error
  /// 		IF_TH_PERALLOC	: Memory allocate error
  /// 		IF_TH_PERREAD	: Table read error
  /// 関連tprxソース: if_th_prerct.c - if_th_PreReceipt
  static Future<int> ifThPreReceipt(TprTID tid, IfThHead ptIfThHead, int kind,
      int print, int iAFontId, int iKFontId) async {
    TrmList ptTrm = TrmList(); /* Pointer to terminal(15ver) */
    CMsgMstColumns tRecMsg = CMsgMstColumns(); /* Store name buffer */
    CMsgMstColumns tRecMsg2 = CMsgMstColumns(); /* Store name buffer for streno2_prn */
    int strenoPrn = 0; /* Record number of store name */
    int totalLines = 1; /* Total print lines of header */
    int storeLines = 0; /* Print lines of store name */
    int storeLines1 = 0; /* Print lines of store name 1 */
    int storeLines2 = 0; /* Print lines of store name 2 */
    int storePrintedLines = 0; /* Printed lines of store name */
    int nameLines = 0; /* Print line of chkr, cshr name */
    int ret = 0; /* Return value */
    String sLogMsg = ''; /* Log message */
    String msgData1 = '';
    String msgData2 = '';
    String msgData3 = '';
    String msgData4 = '';
    String msgData5 = '';
    String msgData6 = '';
    String msgData7 = '';
    String msgData8 = '';
    String msgData9 = '';
    String msgData10 = '';
    int prtType = 0;
    HeaderPrintParam headParam = HeaderPrintParam();
    tid = await CmCksys.cmQCJCCPrintAid(tid);
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.warning,
          "if_th_PreReceipt : Error on rxMemPtr! NULL is returned.");
      return InterfaceDefine.IF_TH_PERREAD; /* Can't read, error return */
    }
    RxCommonBuf pCom = xRet.object; /* Pointer to shared memory */

    ptTrm = pCom.dbTrm; /* get terminal memory address */

    prtType = await CmCksys.cmPrinterType();

    if ((((prtType == CmSys.TPRTIM) || (prtType == CmSys.TPRTHP)) &&
            (await CompetitionIni.competitionIniGetShort(tid,
                    CompetitionIniLists.COMPETITION_INI_RCT_TB_CUT,
                    CompetitionIniType.COMPETITION_INI_GETMEM) == 1)) ||
        ((CmCksys.cmPrintCheck() == TprDidDef.TPRDIDRECEIPT3) &&
            ((await CompetitionIni.competitionIniGetShort(
                    await CmCksys.cmQCJCCPrintAid(Tpraid.TPRAID_PRN),
                    CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE,
                    CompetitionIniType.COMPETITION_INI_GETMEM_JC_J)) == 1)) ||
        ((CmCksys.cmPrintCheck() == TprDidDef.TPRDIDRECEIPT4) &&
            ((await CompetitionIni.competitionIniGetShort(
                    await CmCksys.cmQCJCCPrintAid(Tpraid.TPRAID_PRN),
                    CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE,
                    CompetitionIniType.COMPETITION_INI_GETMEM_JC_C)) == 1))) {
      if (!CompileFlag.RF1_SYSTEM) {
        // TODO:00013 三浦 if_th_LogoPrint未実装
        // ret = if_th_LogoPrint(tid, InterfaceDefine.IF_TH_LOGO1);
        // if (ret != 0) {
        //   sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_LogoPrint( )! ret(%i)", [ret]);
        //   TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
        //   return InterfaceDefine.IF_TH_PERWRITE;
        // }
      }

      // #if RF1_SYSTEM
      // if (0 == pCom->vtcl_rm5900_flg)
      // {
      // /* RM3800でない場合 */
      // if ((ret = if_th_LogoPrint (tid, IF_TH_LOGO1)))
      // {
      // sprintf (sLogMsg, "if_th_PreReceipt : Error on if_th_LogoPrint( )! ret(%i)", [ret]);
      // TprLibLogWrite (tid, 0, -1, sLogMsg);
      // return (IF_TH_PERWRITE);
      // }
      // }
      // else
      // {
      // if (!if_th_chkSpecificationPrint ())
      // {
      // // 明細書印字がなしの場合はロゴ印字
      // if ((ret = if_th_LogoPrint (tid, IF_TH_LOGO1)))
      // {
      // sprintf (sLogMsg, "if_th_PreReceipt : Error on if_th_LogoPrint( )! ret(%i)", [ret]);
      // TprLibLogWrite (tid, 0, -1, sLogMsg);
      // return (IF_TH_PERWRITE);
      // }
      // }
      // }
      // #endif	/* #if RF1_SYSTEM */
    }

    /* Check if have to print store-name lines or not */
    if (print & InterfaceDefine.IF_TH_PRT_SHOP != 0) {
      /* Check store-name number for report or receipt */
      /* Switch report or receipt */
      //streno_prn = ( IF_TH_REPORT == Kind ) ? ptTrm->rep_streno_prn : ptTrm->streno_prn;
      strenoPrn = InterfaceDefine.IF_TH_REPORT == kind
          ? pCom.dbRecMsg[DbMsgMstId.DB_MSGMST_RPRTHEADER.id].msg_cd
          : pCom.dbRecMsg[DbMsgMstId.DB_MSGMST_RCPTHEADER1.id].msg_cd;

      /* Count number of store-name lines */
      // if ((strenoPrn != 0) &&
      //     ((print & InterfaceDefine.IF_TH_PRT_SHOP2_ONLY) == 0)) {
        /* Get store-names */
        tRecMsg.msg_cd = strenoPrn;
        /* Initialize store-name buffer */
        tRecMsg.msg_data_1 = '';
        tRecMsg.msg_data_2 = '';
        tRecMsg.msg_data_3 = '';
        tRecMsg.msg_data_4 = '';
        tRecMsg.msg_data_5 = '';

         ret = await GetRecMsgMst.getRecmsgMst(tid, tRecMsg);
         if (ret != 0) {
         sLogMsg =  sprintf("if_th_PreReceipt : Error on get_recmsg_mst! ret(%i)", [ret]);
         TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);

         // #ifdef DEBUG_UT
         // printf( "%s", sLogMsg );
         // #endif
         }

        msgData1 = tRecMsg.msg_data_1!;
        msgData2 = tRecMsg.msg_data_2!;
        msgData3 = tRecMsg.msg_data_3!;
        msgData4 = tRecMsg.msg_data_4!;
        msgData5 = tRecMsg.msg_data_5!;

        if(msgData1.isNotEmpty) {
          var (eucAdj1, msg1) = AplLibStrUtf.aplLibEucAdjust(msgData1, utf8.encode(msgData1).reduce(max), 1536);
          msgData1 = msg1;
        }
        if(msgData2.isNotEmpty) {
        var (eucAdj2, msg2) = AplLibStrUtf.aplLibEucAdjust(msgData2, utf8.encode(msgData2).reduce(max), 192);
        msgData2 = msg2;
        }
        if(msgData3.isNotEmpty) {
        var (eucAdj3, msg3) = AplLibStrUtf.aplLibEucAdjust(msgData3, utf8.encode(msgData3).reduce(max), 192);
        msgData2 = msg3;
        }
        if(msgData4.isNotEmpty) {
        var (eucAdj4, msg4) = AplLibStrUtf.aplLibEucAdjust(msgData4, utf8.encode(msgData4).reduce(max), 192);
        msgData2 = msg4;
        }
        if(msgData5.isNotEmpty) {
        var (eucAdj5, msg5) = AplLibStrUtf.aplLibEucAdjust(msgData5, utf8.encode(msgData5).reduce(max), 192);
        msgData2 = msg5;
        }

        /* Check length of each store-names and count line of store-names */
        if (msgData1.isNotEmpty) {
          storeLines1 = 1;
          if (msgData2.isNotEmpty) {
            storeLines1 += 1;
            if (msgData3.isNotEmpty) {
              storeLines1 += 1;
              if (msgData4.isNotEmpty) {
                storeLines1 += 1;
                if (msgData5.isNotEmpty) {
                  storeLines1 += 1;
                }
              }
            }
          }
        }
        storeLines = storeLines1;
      //}

      /* Need to print shop_name_2 ? */
      if ((InterfaceDefine.IF_TH_RECEIPT == kind) && /* Receipt printing */
          (pCom.dbRecMsg[DbMsgMstId.DB_MSGMST_RCPTHEADER2.id].msg_cd != 0)) {
        /*  and shop_name_2 number is set */

        if ((print & InterfaceDefine.IF_TH_PRT_SHOP1_ONLY) == 0) {
          /* Get store-names */
          tRecMsg2.msg_cd = pCom.dbRecMsg[DbMsgMstId.DB_MSGMST_RCPTHEADER2.id].msg_cd;
          /* Initialize store-name buffer */
          tRecMsg2.msg_data_1 = '';
          tRecMsg2.msg_data_2 = '';
          tRecMsg2.msg_data_3 = '';
          tRecMsg2.msg_data_4 = '';
          tRecMsg2.msg_data_5 = '';

          ret = await GetRecMsgMst.getRecmsgMst(tid, tRecMsg2);
          if (ret != 0) {sLogMsg = sprintf("if_th_PreReceipt : Error on get_recmsg_mst(streno2_prn)! ret(%i)", [ret]);
           TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
           // #ifdef DEBUG_UT
           // printf( "%s", sLogMsg );
           // #endif
          }

          msgData6 = tRecMsg2.msg_data_1!;
          msgData7 = tRecMsg2.msg_data_2!;
          msgData8 = tRecMsg2.msg_data_3!;
          msgData9 = tRecMsg2.msg_data_4!;
          msgData10 = tRecMsg2.msg_data_5!;
          if(msgData6.isNotEmpty) {
            var (eucAdj6, msg6) = AplLibStrUtf.aplLibEucAdjust(msgData6, utf8.encode(msgData6).reduce(max), 1536);
            msgData6 = msg6;
          }
          if(msgData7.isNotEmpty) {
            var (eucAdj7, msg7) = AplLibStrUtf.aplLibEucAdjust(msgData7, utf8.encode(msgData7).reduce(max), 192);
            msgData7 = msg7;
          }
          if(msgData8.isNotEmpty) {
            var (eucAdj8, msg8) = AplLibStrUtf.aplLibEucAdjust(msgData8, utf8.encode(msgData8).reduce(max), 192);
            msgData8 = msg8;
          }
          if(msgData9.isNotEmpty) {
            var (eucAdj9, msg9) = AplLibStrUtf.aplLibEucAdjust(msgData9, utf8.encode(msgData9).reduce(max), 192);
            msgData9 = msg9;
          }
          if(msgData10.isNotEmpty) {
            var (eucAdj10, msg10) = AplLibStrUtf.aplLibEucAdjust(msgData10, utf8.encode(msgData10).reduce(max), 192);
            msgData10 = msg10;
          }

          /* Check length of each store-names and count line of store-names */
          if (msgData6.isNotEmpty) {
            storeLines2 = 1;
            if (msgData7.isNotEmpty) {
              storeLines2 += 1;
              if (msgData8.isNotEmpty) {
                storeLines2 += 1;
                if (msgData9.isNotEmpty) {
                  storeLines2 += 1;
                  if (msgData10.isNotEmpty) {
                    storeLines2 += 1;
                  }
                }
              }
            }
          }
          storeLines += storeLines2;
        }
      }
    }
    /* else store_lines = 0 */

    /* Check if have to print chkr-cshr-name line or not */
    if (InterfaceDefine.IF_TH_RECEIPT == kind) {
      /* Receipt printing */
      if (print & InterfaceDefine.IF_TH_PRT_RCTNO != 0) {
        /* Need to print receipt no */
        nameLines = 1;
        if (ptIfThHead.iChkrCode != 0 && ptIfThHead.iCshrCode != 0) {
          nameLines += 1; /* Need to print both chkr and cshr name */
        }
      } else if (ptIfThHead.iChkrCode != 0 || (ptIfThHead.iCshrCode != 0)) {
        nameLines = 1; /* Need to print chkr and-or cshr name */
      }
    } else if (InterfaceDefine.IF_TH_REPORT == kind) {
      /* Report printing */
      nameLines = 1; /* Always print report number */
      if (ptIfThHead.iChkrCode != 0 && ptIfThHead.iCshrCode != 0) {
        nameLines += 1; /* Need to print both chkr and cshr name */
      }
    }

    /* Calculate total line number of header parts */
    totalLines += storeLines + nameLines;

    /* Setup store-name line(s) */
    if (storeLines >= 1) {
      /* Print 1st line */

      // #if 0 /* 2008/03/24 */
      // if( web_type == WEBTYPE_WEBPLUS ) {
      // if ( ( ret = if_th_Feed( tid, 10 ) ) ) {
      // sprintf( sLogMsg, "if_th_PreReceipt : Error on if_th_Feed( )! ret(%i)", [ret]);
      // TprLibLogWrite( tid, 0, -1, sLogMsg );
      // return( IF_TH_PERWRITE );
      // }
      // }
      // #endif

      /* Allocate dummy space top of store name */
      ret = await IfThAlloc.ifThAllocArea(tid, DUMMY_DOTS);
      if (ret != 0) {
        sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_AllocArea(dummy on store name) ret(%i)", [ret]);
        TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
        // #ifdef DEBUG_UT
        // printf( "%s", sLogMsg );
        // #endif
        return InterfaceDefine.IF_TH_PERALLOC;
      }

      // #if 0
      // /* 2006/02/08 */
      // if( ( web_type == WEBTYPE_WEB2300 )
      // #if JPN
      // ||( web_type == WEBTYPE_WEBPLUS )
      // #endif
      // ||( web_type == WEBTYPE_WEB2800 )
      // ||( web_type == WEBTYPE_WEB2350 )
      // ||( web_type == WEBTYPE_WEB2500 )
      // )
      // #endif

      if (prtType != CmSys.SUBCPU_PRINTER) {
        ret = await IfThPrnStr.ifThPrintString(tid, 0, 0, 0, iAFontId, iKFontId, '');
        if (ret != 0) {
          sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_PrintString(DUMMY)! ret(%i)", [ret]);
          TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
          return InterfaceDefine.IF_TH_PERWRITE;
        }
      }

      /* Allocate bitmap area of store name */
      ret = await IfThAlloc.ifThAllocArea(tid, storeLines * IfThLib.IF_TH_Y_12);
      if (ret != 0) {
        sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_AllocArea of store name. ret(%i)", [ret]);
        TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
        // #ifdef DEBUG_UT
        // printf( "%s", sLogMsg );
        // #endif
        return InterfaceDefine.IF_TH_PERALLOC;
      }

      if (storeLines1 >= 1) {
        /* Need tp print messeage of streno_prn */
        storePrintedLines++;
        ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, storePrintedLines, 0, 0, 0, iAFontId, iKFontId, msgData1);
        if (ret != 0) {
          sLogMsg = sprintf("if_th_PreReceipt : Error on ifThGridString(1)! ret(%i)", [ret]);
          TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
          // #ifdef DEBUG_UT
          // printf( "%s", sLogMsg );
          // #endif
          return InterfaceDefine.IF_TH_PERWRITE;
        }
        if (storeLines1 >= 2) {
          /* Print 2nd line */
          storePrintedLines++;
          ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, storePrintedLines, 0, 0, 0, iAFontId, iKFontId, msgData2);
          if (ret != 0) {
            sLogMsg = sprintf("if_th_PreReceipt : Error on ifThGridString(2)! ret(%i)", [ret]);
            TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
            // #ifdef DEBUG_UT
            // printf( "%s", sLogMsg );
            // #endif
            return InterfaceDefine.IF_TH_PERWRITE;
          }
          if (storeLines1 >= 3) {
            /* Print 3rd line */
            storePrintedLines++;
            ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, storePrintedLines, 0, 0, 0, iAFontId,iKFontId, msgData3);
            if (ret != 0) {
              sLogMsg = sprintf("if_th_PreReceipt : Error on ifThGridString(3)! ret(%i)", [ret]);
              TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
              // #ifdef DEBUG_UT
              // printf( "%s", sLogMsg );
              // #endif
              return InterfaceDefine.IF_TH_PERWRITE;
            }
            if (storeLines1 >= 4) {
              /* Print 4th line */
              storePrintedLines++;
              ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, storePrintedLines, 0, 0, 0, iAFontId, iKFontId, msgData4);
              if (ret != 0) {
                sLogMsg = sprintf("if_th_PreReceipt : Error on ifThGridString(4)! ret(%i)", [ret]);
                TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
                // #ifdef DEBUG_UT
                // printf( "%s", sLogMsg );
                // #endif
                return InterfaceDefine.IF_TH_PERWRITE;
              }
              if (storeLines1 >= 5) {
                /* Print 5th line */
                storePrintedLines++;
                ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, storePrintedLines, 0, 0, 0, iAFontId, iKFontId, msgData5);
                if (ret != 0) {
                  sLogMsg = sprintf("if_th_PreReceipt : Error on ifThGridString(5)! ret(%i)", [ret]);
                  TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
                  // #ifdef DEBUG_UT
                  // printf( "%s", sLogMsg );
                  // #endif
                  return InterfaceDefine.IF_TH_PERWRITE;
                }
              }
            }
          }
        }
      }

      if (storeLines2 >= 1) {
        /* Need to print message of streno2_prn */
        storePrintedLines++;
        ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, storePrintedLines, 0, 0, 0, iAFontId, iKFontId, msgData6);
        if (ret != 0) {
          sLogMsg = sprintf("if_th_PreReceipt : Error on ifThGridString(6)! ret(%i)", [ret]);
          TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
          // #ifdef DEBUG_UT
          // printf( "%s", sLogMsg );
          // #endif
          return InterfaceDefine.IF_TH_PERWRITE;
        }
        if (storeLines2 >= 2) {
          /* Print 2nd line */
          storePrintedLines++;
          ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, storePrintedLines, 0, 0, 0, iAFontId, iKFontId, msgData7);
          if (ret != 0) {
            sLogMsg = sprintf("if_th_PreReceipt : Error on ifThGridString(7)! ret(%i)", [ret]);
            TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
            // #ifdef DEBUG_UT
            // printf( "%s", sLogMsg );
            // #endif
            return InterfaceDefine.IF_TH_PERWRITE;
          }
          if (storeLines2 >= 3) {
            /* Print 3rd line */
            storePrintedLines++;
            ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, storePrintedLines, 0, 0, 0, iAFontId, iKFontId, msgData8);
            if (ret != 0) {
              sLogMsg = sprintf("if_th_PreReceipt : Error on ifThGridString(8)! ret(%i)", [ret]);
              TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
              // #ifdef DEBUG_UT
              // printf( "%s", sLogMsg );
              // #endif
              return InterfaceDefine.IF_TH_PERWRITE;
            }
            if (storeLines2 >= 4) {
              /* Print 4th line */
              storePrintedLines++;
              ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, storePrintedLines, 0, 0, 0, iAFontId, iKFontId, msgData9);
              if (ret != 0) {
                sLogMsg = sprintf("if_th_PreReceipt : Error on ifThGridString(9)! ret(%i)", [ret]);
                TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
                // #ifdef DEBUG_UT
                // printf( "%s", sLogMsg );
                // #endif
                return InterfaceDefine.IF_TH_PERWRITE;
              }
              if (storeLines2 >= 5) {
                /* Print 5th line */
                storePrintedLines++;
                ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, storePrintedLines, 0, 0, 0, iAFontId, iKFontId, msgData10);
                if (ret != 0) {
                  sLogMsg = sprintf("if_th_PreReceipt : Error on ifThGridString(10)! ret(%i)", [ret]);
                  TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
                  // #ifdef DEBUG_UT
                  // printf( "%s", sLogMsg );
                  // #endif
                  return InterfaceDefine.IF_TH_PERWRITE;
                }
              }
            }
          }
        }
      }
    }

    /* Allocate dummy space top of date */
    ret = await IfThAlloc.ifThAllocArea(tid, DUMMY_DOTS);
    if (ret != 0) {
      sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_AllocArea(dummy on date) ret(%i)", [ret]);
      TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
      // #ifdef DEBUG_UT
      // printf( "%s", sLogMsg );
      // #endif
      return InterfaceDefine.IF_TH_PERALLOC;
    }

    if (prtType != CmSys.SUBCPU_PRINTER) {
      ret = await IfThPrnStr.ifThPrintString(tid, 0, 0, 0, iAFontId, iKFontId, '');
      if (ret != 0) {
        sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_PrintString(DUMMY)! ret(%i)", [ret]);
        TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
        return InterfaceDefine.IF_TH_PERWRITE;
      }
    }

    // マシン番号などのヘッダー印字
    headParam.ptIfThHead = ptIfThHead;
    headParam.kind = kind;
    headParam.print = print;
    headParam.ptDateParam = null;
    headParam.iAFontId = iAFontId;
    headParam.iKFontId = iKFontId;

    ret = await ifThHeaderCommonPrint(tid, pCom, headParam);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return ret;
    }

    ret = await IfThFlushB.ifThFlushBuf(tid, InterfaceDefine.IF_TH_FLUSHALL);
    if (ret != 0) {
      sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_FlushBuf()! ret(%i)", [ret]);
      TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
      // #ifdef DEBUG_UT
      // printf( "%s", sLogMsg );
      // #endif
      return InterfaceDefine.IF_TH_PERWRITE;
    }

    ret = await IfThCFlush.ifThCFlush(tid);
    if (ret != 0) {
      sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_cFlush()! ret(%i)", [ret]);
      TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
      // #ifdef DEBUG_UT
      // printf( "%s", sLogMsg );
      // #endif
      return InterfaceDefine.IF_TH_PERWRITE;
    }

    return InterfaceDefine.IF_TH_POK;
  }

  /// 関数: if_th_MsgDataCommonPrint()
  /// 機能: メッセージコード内容を印字する部分
  /// 引数: tid	タスクID
  /// 関連tprxソース:if_th_prerct.c - if_th_MsgDataCommonPrint
  static Future<int> ifThMsgDataCommonPrint( TprTID tid, MsgMstData? msgData, MsgMstPrintParam? param) async {
    int ret;
    int line;
    int urlString;
    int startStep;

    if (msgData == null
        || param == null) {
      TprLog().logAdd(tid, LogLevelDefine.warning, "ifThMsgDataCommonPrint : argument error " );
      return InterfaceDefine.IF_TH_POK;
    }

    if (msgData.msg_typ <= 0
        || msgData.msg_typ >= DbMsgMstId.DB_MSGMST_MAX) {
      return InterfaceDefine.IF_TH_POK;
    }

    TprLog().logAdd(tid, LogLevelDefine.warning, 
        "ifThMsgDataCommonPrint : [${msgData.msg_typ}][${msgData.msg_cd}][${msgData.target_typ}][${msgData.msg_kind}][${param.custFlg}]");

    if (msgData.target_typ == 1	// 顧客以外
        && param.custFlg == 1) {
      return InterfaceDefine.IF_TH_POK;
    } else if (msgData.target_typ == 2	// 顧客のみ
        && param.custFlg == 0) {
      return InterfaceDefine.IF_TH_POK;
    }

    urlString = 0;
    if ( msgData.msg_kind == 1 )	// bitmap
    {
      if (await CmCksys.cmDummyPrintMyself() == 1 )
      {
        return InterfaceDefine.IF_TH_POK;
      }

      ret = IfThPrnbit.ifThPrintBitmapCmLogo( tid, msgData.msg_cd, Typ.OFF );
      if ( ret != 0 ) {
        TprLog().logAdd(tid, LogLevelDefine.warning,
            "ifThMsgDataCommonPrint : Error ifThPrintBitmapCmLogo! ret($ret) [${msgData.msg_typ}]",
            errId: -1);
        return InterfaceDefine.IF_TH_PERWRITE;
      }
    }
    if ( msgData.msg_kind == 2 )	// URL
    {
      if (await CmCksys.cmDummyPrintMyself() != 1 ) {
        ret = await IfThAlloc.ifThAllocArea(tid, IfThLib.IF_TH_Y_12);
        if (ret != 0) {
          TprLog().logAdd(tid, LogLevelDefine.warning,
              "ifThMsgDataCommonPrint : Error ifThAllocArea if_th_AllocArea of store name. ret($ret)[${msgData.msg_typ}]",
              errId: -1);
          return InterfaceDefine.IF_TH_PERALLOC;
        }
        ret = await AplLibBarPrn.aplLibBarQR( tid, msgData.msg_data_1, msgData.msg_data_1.length );
        if ( ret != 0 ) {
          TprLog().logAdd(tid, LogLevelDefine.warning,
              "ifThMsgDataCommonPrint : Error aplLibBarQR! ret($ret) [${msgData.msg_typ}]",
              errId: -1);
          return InterfaceDefine.IF_TH_PERWRITE;
        }
      }

      if ( await CmCksys.cmWsSystem() != 0) {
        urlString = 1; // URL & string
      }
    }
    if ( msgData.msg_kind == 0 || urlString != 0 )	// string
    {
      List<String> msgDataList = [
        msgData.msg_data_1,
        msgData.msg_data_2,
        msgData.msg_data_3,
        msgData.msg_data_4,
        msgData.msg_data_5
      ];

      startStep = 0;
      if ( urlString != 0 ) {
        startStep = 1;
      }
      line = 0;
      line = msgDataList.where((element) => element.isNotEmpty).length;

      if (line > 0) {
        ret = await IfThAlloc.ifThAllocArea(tid, line * IfThLib.IF_TH_Y_12);
        if (ret != 0) {
          TprLog().logAdd(tid, LogLevelDefine.warning,
              "ifThMsgDataCommonPrint : Error on if_th_AllocArea of store name. ret($ret)[${msgData.msg_typ}]",
              errId: -1);
          return InterfaceDefine.IF_TH_PERALLOC;
        }

        line = 0;
        for (int msgStep = 0; msgStep < InterfaceDefine.IF_TH_MSG_STEP; msgStep++) {
          if ( startStep <= msgStep && msgDataList[msgStep].isNotEmpty ) {
            line ++;
            ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, line, 0, 0, 0, param.iAFontId, param.iKFontId, msgDataList[msgStep]);
            if (ret != 0) {
              TprLog().logAdd(tid, LogLevelDefine.warning,
                  "ifThMsgDataCommonPrint : Error on ifThGridString! ret($ret)[${msgData.msg_typ}] [${msgDataList[msgStep]}]",
                  errId: -1);
              return InterfaceDefine.IF_TH_PERWRITE;
            }
          }
        }
      }
    }
    return InterfaceDefine.IF_TH_POK;
  }

  /// Usage:		if_th_PreReceipt2( TPRTID tid, IF_TH_HEAD *ptIfThHead, int Kind,
  /// 				   int Print, int iAFontId, int iKFontId,
  /// 				   struct tm *ptDateParam )
  /// Functions:	Setup receipt or report header
  /// Parameters:	(IN)	tid	: Task id
  /// 			ptIfThHead : Pointer to structure of header datas
  /// 			Kind	: Kind of receipt or report
  /// 			Print	: Print control(print shop name,...)
  /// 			iAFontId: Font id for ASCII character
  /// 			iKFontId: Font id for KANJI character
  /// 			ptDateParam: Date & time of transaction
  /// Return value:	IF_TH_POK	: Normal end
  /// 		IF_TH_PERWRITE	: Write error
  /// 		IF_TH_PERALLOC	: Memory allocate error
  /// 		IF_TH_PERREAD	: Table read error
  /// 関連tprxソース:if_th_prerct.c - if_th_PreReceipt2
  static Future<int> ifThPreReceipt2(TprTID tid, IfThHead ptIfThHead, int kind,
      int print, int iAFontId, int iKFontId, DateTime ptDateParam) async {
    return await ifThPreReceipt2Main(
        tid, ptIfThHead, kind, print, iAFontId, iKFontId, -1, -1, ptDateParam);
  }

  /// 関連tprxソース:if_th_prerct.c - if_th_PreReceipt2_Main
  static Future<int> ifThPreReceipt2Main(TprTID tid, IfThHead ptIfThHead, int kind,
      int print, int iAFontId, int iKFontId, int iAFontId2, int iKFontId2, DateTime ptDateParam) async {
    TrmList ptTrm = TrmList(); /* Pointer to terminal(15ver) */
    int storePrintedLines = 0; /* Printed lines of store name */
    int ret = 0; /* Return value */
    String sLogMsg = ''; /* Log message */
    List<int> msgTypList = List.filled(InterfaceDefine.IF_TH_MSG_TYPE, 0);
    int prtType = 0;
    int planNum = 0;
    int stepNum = 0;
    HeaderPrintParam headParam = HeaderPrintParam();
    int num = 0;
    int printMsgFlg;
    MsgMstPrintParam msgParam = MsgMstPrintParam();
    RxMemRet xRet1 = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    RxMemRet xRet2 = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet1.isInvalid()) {
      TprLog().logAdd(
          0,
          LogLevelDefine.error,
          sprintf(
              "if_th_PreReceipt : Error on rxMemPtr(STAT)! ret(%i)\n", [ret]));
      return InterfaceDefine.IF_TH_PERREAD;
    }
    if (xRet2.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error,
          "if_th_PreReceipt : Error on rxMemPtr! NULL is returned.");
      return InterfaceDefine.IF_TH_PERREAD;
    }
    RxCommonBuf pCom = xRet2.object; /* Pointer to shared memory */

    tid = await CmCksys.cmQCJCCPrintAid(tid);

    ptTrm = pCom.dbTrm; /* get terminal memory address */

    prtType = await CmCksys.cmPrinterType();

    /* Init recmsg_grp_cd & msg_cd */

    if ((((prtType == CmSys.TPRTIM) || (prtType == CmSys.TPRTHP)) &&
            (await CompetitionIni.competitionIniGetShort(
                    tid,
                    CompetitionIniLists.COMPETITION_INI_RCT_TB_CUT,
                    CompetitionIniType.COMPETITION_INI_GETMEM) == 1)) ||
        ((CmCksys.cmPrintCheck() == TprDidDef.TPRDIDRECEIPT3) &&
            ((await CompetitionIni.competitionIniGetShort(
                    await CmCksys.cmQCJCCPrintAid(Tpraid.TPRAID_PRN),
                    CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE,
                    CompetitionIniType.COMPETITION_INI_GETMEM_JC_J)) == 1)) ||
        ((CmCksys.cmPrintCheck() == TprDidDef.TPRDIDRECEIPT4) &&
            ((await CompetitionIni.competitionIniGetShort(
                    await CmCksys.cmQCJCCPrintAid(Tpraid.TPRAID_PRN),
                    CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE,
                    CompetitionIniType.COMPETITION_INI_GETMEM_JC_C)) == 1))) {
      if (!CompileFlag.RF1_SYSTEM) {
        // TODO:00013 三浦 if_th_LogoPrint未実装
        // if ((ret = if_th_LogoPrint(tid, InterfaceDefine.IF_TH_LOGO1))) {
        //       sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_LogoPrint( )! ret(%i)", [ret]);
        //       TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
        //       return InterfaceDefine.IF_TH_PERWRITE;
        // }
      } /* #if !RF1_SYSTEM */

      // #if RF1_SYSTEM
      // if (0 == pCom->vtcl_rm5900_flg)
      // {
      // /* RM3800でない場合 */
      // if ((ret = if_th_LogoPrint (tid, IF_TH_LOGO1)))
      // {
      // sprintf (sLogMsg, "if_th_PreReceipt : Error on if_th_LogoPrint( )! ret(%i)", [ret]);
      // TprLibLogWrite (tid, 0, -1, sLogMsg);
      // return (IF_TH_PERWRITE);
      // }
      // }
      // else
      // {
      // if (!if_th_chkSpecificationPrint ())
      // {
      // if ((ret = if_th_LogoPrint (tid, IF_TH_LOGO1)))
      // {
      // sprintf (sLogMsg, "if_th_PreReceipt : Error on if_th_LogoPrint( )! ret(%i)", [ret]);
      // TprLibLogWrite (tid, 0, -1, sLogMsg);
      // return (IF_TH_PERWRITE);
      // }
      // }
      // }
      // #endif	/* #if RF1_SYSTEM */
    }

    if ((prtType == CmSys.TPRTSS) ||
        (prtType == CmSys.TPRTIM) ||
        (prtType == CmSys.TPRTHP)) {
      ret = await IfThFeed.ifThFeed(tid, 5);
      if (ret != 0) {
        sLogMsg =
            sprintf("if_th_PreReceipt : Error on ifThFeed( )! ret(%i)", [ret]);
        TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
        return InterfaceDefine.IF_TH_PERWRITE;
      }
    }

    /* Check if have to print store-name lines or not */
    if (print & InterfaceDefine.IF_TH_PRT_SHOP != 0) {
      /* Check store-name number for report or receipt */
      /* Switch report or receipt */

      if (InterfaceDefine.IF_TH_REPORT == kind) {
        // レポートヘッダー印字
        msgTypList[0] = DbMsgMstId.DB_MSGMST_RPRTHEADER.id;
      } else if (ptIfThHead.HeadMsgTyp == HeadMsgList.HEADMSG_MBR_TCKT.id) {
        // サービスチケット印字
        msgTypList[0] = DbMsgMstId.DB_MSGMST_SVCHEADER1.id;
        msgTypList[1] = DbMsgMstId.DB_MSGMST_SVCHEADER2.id;
      } else if (ptIfThHead.HeadMsgTyp == HeadMsgList.HEADMSG_INOUT.id) {
        // 入出金ヘッダー印字
        msgTypList[0] = DbMsgMstId.DB_MSGMST_INOUTHEADER.id;
      } else {
        // レシート印字
        if ((print & InterfaceDefine.IF_TH_PRT_SHOP1_ONLY != 0) ||
            (print & InterfaceDefine.IF_TH_PRT_SHOP2_ONLY != 0)) {
          if ((print & InterfaceDefine.IF_TH_PRT_SHOP1_ONLY != 0)) {
            msgTypList[0] = DbMsgMstId.DB_MSGMST_RCPTHEADER1.id;
          } else if ((print & InterfaceDefine.IF_TH_PRT_SHOP2_ONLY != 0)) {
            msgTypList[0] = DbMsgMstId.DB_MSGMST_RCPTHEADER2.id;
          }
        } else {
          msgTypList[0] = DbMsgMstId.DB_MSGMST_RCPTHEADER1.id;
          msgTypList[1] = DbMsgMstId.DB_MSGMST_RCPTHEADER2.id;
        }
        msgTypList[2] = DbMsgMstId.DB_MSGMST_RCPTHEADER3.id;
      }

      // #if 0	//@@@V15	メッセージ間の改行
      // if((IF_TH_RECEIPT == Kind) &&		/* Receipt printing */
      // (iAFontId2 != -1      ) &&
      // (iKFontId2 != -1      ) &&
      // (((RX_TASKSTAT_PRN *)STAT_print_get(tsBuf))->prnrbuf_type != TYPE_DELIV_RCT) ) {
      // len = 16;
      // memset(img_data, 0x0, sizeof(img_data));
      // AplLib_ImgRead(IMG_RCPT_HEAD1, img_data, len);
      // if(strlen(img_data) > 0) {
      // len = (strlen(img_data) < len) ? strlen(img_data) : len;
      //
      // for(i = 0; i < len; i++) {
      // if(img_data[i] != ' ') {
      // store_lines1_2 = 1;
      // break;
      // }
      // }
      // }
      // store_lines += store_lines1_2;
      // }
      // #endif	//@@@V15
    }

    // 店舗メッセージ印字のチェック
    printMsgFlg = 0;
    if (ptIfThHead.HeadMsgPrnFlg == 0) {
      for (num = 0; num < InterfaceDefine.IF_TH_MSG_TYPE; num++) {
        if ((msgTypList[num] > 0) &&
            (msgTypList[num] < DbMsgMstId.DB_MSGMST_MAX)) {
          if (pCom.dbRecMsg[msgTypList[num]].msg_data_1.isNotEmpty ||
              pCom.dbRecMsg[msgTypList[num]].msg_data_2.isNotEmpty ||
              pCom.dbRecMsg[msgTypList[num]].msg_data_3.isNotEmpty ||
              pCom.dbRecMsg[msgTypList[num]].msg_data_4.isNotEmpty ||
              pCom.dbRecMsg[msgTypList[num]].msg_data_5.isNotEmpty) {
            printMsgFlg = 1;
            break;
          }
        }
      }
    }

    // ターゲットメッセージ印字のチェック
    storePrintedLines = 0;
    if (ptIfThHead.HeadMsgPrnFlg == 0) {
      for (planNum = 0;
          planNum < InterfaceDefine.IF_TH_TGT_MSG_PLAN_NUM;
          planNum++) {
        for (stepNum = 0;
            stepNum < InterfaceDefine.IF_TH_TGT_MSG_STEP_NUM;
            stepNum++) {
          if (ptIfThHead.tgtMsg[planNum][stepNum].isNotEmpty) {
            storePrintedLines++;
          }
        }
      }
    }

    // ヘッダー印字の開始
    if ((printMsgFlg == 1) ||
        (ptIfThHead.Title.isNotEmpty) ||
        (storePrintedLines > 0)) {
      if (CompileFlag.JPN) {
        if (prtType == CmSys.TPRTF) {
          ret = await IfThFeed.ifThFeed(tid, 10);
          if (ret != 0) {
            sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_Feed( )! ret(%i)", [ret]);
            TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
            return InterfaceDefine.IF_TH_PERWRITE;
          }
        }
      }

      /* Allocate dummy space top of store name */
      ret = await IfThAlloc.ifThAllocArea(tid, DUMMY_DOTS);
      if (ret != 0) {
        sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_AllocArea(dummy on store name) ret(%i)", [ret]);
        TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
        // #ifdef DEBUG_UT
        // printf( "%s", sLogMsg );
        // #endif
        return InterfaceDefine.IF_TH_PERALLOC;
      }

      if (prtType == CmSys.TPRTS) {
        ret = await IfThPrnStr.ifThPrintString(tid, 0, 0, 0, iAFontId, iKFontId, '');
        if (ret != 0) {
          sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_PrintString(DUMMY)! ret(%i)", [ret]);
          TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
          return InterfaceDefine.IF_TH_PERWRITE;
        }
      }
    }

    if (printMsgFlg == 1) {
      msgParam.iAFontId = iAFontId;
      msgParam.iKFontId = iKFontId;
      msgParam.custFlg = ptIfThHead.CustFlg;

      for (num = 0; num < InterfaceDefine.IF_TH_MSG_TYPE; num++) {
        // メッセージデータの印字
        ret = await ifThMsgDataCommonPrint(tid, pCom.dbRecMsg[msgTypList[num]], msgParam);
        if (ret != InterfaceDefine.IF_TH_POK) {
          return ret;
        }
      }
    }

    if (storePrintedLines != 0) {
      ret = await IfThAlloc.ifThAllocArea(
          tid, storePrintedLines * IfThLib.IF_TH_Y_12);
      if (ret != 0) {
        sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_AllocArea of store plan. ret(%i)", [ret]);
        TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
        return InterfaceDefine.IF_TH_PERALLOC;
      }

      storePrintedLines = 0;
      for (planNum = 0; planNum < InterfaceDefine.IF_TH_TGT_MSG_PLAN_NUM; planNum++) {
        for (stepNum = 0; stepNum < InterfaceDefine.IF_TH_TGT_MSG_STEP_NUM; stepNum++) {
          if (ptIfThHead.tgtMsg[planNum][stepNum].isNotEmpty) {
            storePrintedLines++;
            ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1,
                storePrintedLines, 0, 0, 0, iAFontId, iKFontId, ptIfThHead.tgtMsg[planNum][stepNum]);
            if (ret != 0) {
              sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_GridString[%i][%i]! ret(%i)", [planNum, stepNum, ret]);
              TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
              return InterfaceDefine.IF_TH_PERWRITE;
            }
          }
        }
      }
    }

    if (ptIfThHead.Title.isNotEmpty) {
      //タイトル印字
      ret = await IfThAlloc.ifThAllocArea(tid, 4 * IfThLib.IF_TH_Y_12);
      if (ret != 0) {
        sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_AllocArea of Title. ret(%i)", [ret]);
        TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
        return InterfaceDefine.IF_TH_PERALLOC;
      }
      ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1,
          1, 0, 0, 0, iAFontId, iKFontId, " ");
      if (ret != 0) {
        sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_GridString Title space! ret(%i)", [ret]);
        TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
        return InterfaceDefine.IF_TH_PERWRITE;
      }
      ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, 1,
          0, 0, 0, ptIfThHead.T_iAFontId, ptIfThHead.T_iKFontId, ptIfThHead.Title);
      if (ret != 0) {
        sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_GridString Title! ret(%i)", [ret]);
        TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
        return InterfaceDefine.IF_TH_PERWRITE;
      }
    }

    /* Allocate dummy space top of date */
    ret = await IfThAlloc.ifThAllocArea(tid, DUMMY_DOTS);
    if (ret != 0) {
      sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_AllocArea(dummy on date) ret(%i)", [ret]);
      TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
      // #ifdef DEBUG_UT
      // printf( "%s", sLogMsg );
      // #endif
      return InterfaceDefine.IF_TH_PERALLOC;
    }

    if (prtType != CmSys.SUBCPU_PRINTER) {
      ret = await IfThPrnStr.ifThPrintString(tid, 0, 0, 0, iAFontId, iKFontId, '');
      if (ret != 0) {
        sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_PrintString(DUMMY)! ret(%i)", [ret]);
        TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
        return InterfaceDefine.IF_TH_PERWRITE;
      }
    }

    // マシン番号などのヘッダー印字
    headParam.ptIfThHead = ptIfThHead;
    headParam.kind = kind;
    headParam.print = print;
    headParam.ptDateParam = ptDateParam;
    headParam.iAFontId = iAFontId;
    headParam.iKFontId = iKFontId;
    ret = await ifThHeaderCommonPrint(tid, pCom, headParam);
    if (ret != InterfaceDefine.IF_TH_POK) {
      return ret;
    }

    if ((tid == Tpraid.TPRAID_PRN) || (tid == Tpraid.TPRAID_QCJC_C_PRN)) {
      /* if_th_FlushBufは、PrinterTaskで実行 */
      return InterfaceDefine.IF_TH_POK;
    }

    ret = await IfThFlushB.ifThFlushBuf(tid, InterfaceDefine.IF_TH_FLUSHALL);
    if (ret != 0) {
      sLogMsg = sprintf("if_th_PreReceipt : Error on if_th_FlushBuf()! ret(%i)", [ret]);
      TprLog().logAdd(tid, LogLevelDefine.warning, sLogMsg);
      // #ifdef DEBUG_UT
      // printf( "%s", sLogMsg );
      // #endif
      return InterfaceDefine.IF_TH_PERWRITE;
    }

    return InterfaceDefine.IF_TH_POK;
  }

  /// 日付とマシン番号情報印字部分
  /// 引数のmac_noに値が入ってくるのは, クレジット買上票印字のとき
  /// 関連tprxソース:if_th_prerct.c - if_th_HeaderCommonPrint
  static Future<int> ifThHeaderCommonPrint( TprTID tid, RxCommonBuf pCom, HeaderPrintParam headParam ) async {
    int setMacNo;
    String dateBuf = "";
    String timeBuf = "";
    String macBuf = "";
    String streBuf = "";
    List<String> sLine = List.filled(SLINE_MAX, "");
    EucAdj? cshrAdj;
    EucAdj? chkrAdj;
    EucAdj recAdj;
    EucAdj jnlAdj;
    EucAdj? macAdj;
    EucAdj prnNoAdj;
    EucAdj? timeAdj;
    String tempBuf = "";
    String cshrBuf = "";
    String chkrBuf = "";
    String recNoBuf = "";
    String jnlNoBuf = "";
    String prnNoBuf = "";
    String imgData1 = "";
    String imgData2 = "";
    late DateTime tDate;
    int	ret;
    TprTID	pTid;
    int recNo;
    int jnlNo;
    int	spaceCnt;
    int	num;
    TImgDataAdd	iMgDataAdd;
    TImgDataAddAns	ans;
    String ejData = "";
    File? ejFp;

    pTid = await CmCksys.cmQCJCCPrintAid(tid);

    // 店舗番号のセット部
    if ( pCom.dbTrm.loasonNw7mbr == 0 )
    {
      imgData1 = ImageDefinitions.IMG_STRE_NO.imageData;

      if ( await CmCksys.cmZHQSystem() != 0 )
      {
        streBuf = sprintf("%s%07i", [imgData1, (pCom.dbRegCtrl.streCd % 10000000)]);
      }
      else
      {
        streBuf = sprintf("%s%09i", [imgData1, pCom.dbRegCtrl.streCd]);
      }
    }

    // 日付のセット部
    if (   (headParam.kind == InterfaceDefine.IF_TH_REPORT)
        || (   (headParam.kind == InterfaceDefine.IF_TH_RECEIPT)
      && (pCom.dbTrm.datePrn == 1)) )
    {
      if (   (headParam.kind == InterfaceDefine.IF_TH_RECEIPT)
          && (headParam.ptDateParam != null) )
      {
        if  (headParam.print & InterfaceDefine.IF_TH_PRT_UNDATED != 0)
        {
          // くろがねや様特注  空の年月日印字
          (ret, dateBuf) = CmMkDat.cmMkDate( CmSys.DATE_TYPE9, headParam.ptDateParam!);	/* Use parameter */
        }
        else if (pCom.dbTrm.jpnDatePrn != 0)
        {
          (ret, dateBuf) = CmMkDat.cmMkDate( 8, headParam.ptDateParam! );	/* Use parameter */
        }
        else
        {
          (ret, dateBuf) = CmMkDat.cmMkDate( 10, headParam.ptDateParam! );	/* Use parameter */
        }

        /* Put time into line buffer */
        if ( pCom.dbTrm.loasonNw7mbr == 0)
        {
          imgData1 = ImageDefinitions.IMG_PRN_MON.imageData;
          imgData2 = ImageDefinitions.IMG_PRN_DAY.imageData;
          timeBuf = sprintf("%02i%s%02i%s", [headParam.ptDateParam!.hour, imgData1, headParam.ptDateParam!.minute, imgData2]);
          (timeAdj, timeBuf) = AplLibStrUtf.aplLibEucAdjust( timeBuf, utf8.encode(timeBuf).length, 2+2+2+2 );
        }
      }
      else if (   (headParam.kind == InterfaceDefine.IF_TH_REPORT)
              && (headParam.ptDateParam != null) )
      {
        (ret, dateBuf) = CmMkDat.cmMkDate( 10, headParam.ptDateParam! );
        imgData1 = ImageDefinitions.IMG_PRN_MON.imageData;
        imgData2 = ImageDefinitions.IMG_PRN_DAY.imageData;
        timeBuf = sprintf("%02i%s%02i%s", [headParam.ptDateParam!.hour, imgData1, headParam.ptDateParam!.minute, imgData2] );
        (timeAdj, timeBuf) = AplLibStrUtf.aplLibEucAdjust( timeBuf, utf8.encode(timeBuf).length, 2+2+2+2 );
      }
      else 
      {
        // レポートの場合は現在日付
        tDate = SysDate().cmReadSysdate(  );	/* Read system date & time */
        //ret = cm_mkdate( (char)3, &tDate, dateBuf );
        (ret, dateBuf) = CmMkDat.cmMkDate( 10, tDate );
        imgData1 = ImageDefinitions.IMG_PRN_MON.imageData;
        imgData2 = ImageDefinitions.IMG_PRN_DAY.imageData;
        timeBuf = sprintf("%02i%s%02i%s", [tDate.hour, imgData1, tDate.minute, imgData2] );
        (timeAdj, timeBuf) = AplLibStrUtf.aplLibEucAdjust( timeBuf, utf8.encode(timeBuf).length, 2+2+2+2 );
      }

      if ( ret == 0 )
      {
        TprLog().logAdd(tid, LogLevelDefine.warning, "if_th_DateMacNoPrint : Error cm_mkdate", errId: -1);
        return InterfaceDefine.IF_TH_PERWRITE;
      }
    }

    // マシン番号のセット部
    if ( pCom.dbTrm.loasonNw7mbr == 0 )
    {
      if( headParam.ptIfThHead.iMacNo == 0 )
      {
        setMacNo = (await CompetitionIni.competitionIniGetRcptNo(pTid)).value;
      }
      else
      {
        setMacNo = headParam.ptIfThHead.iMacNo;
      }

      // くろがねや仕様時は店舗番号とセット印字する
      if( await CmCksys.cmHc2KuroganeyaSystem(pTid) == 1 )
      {
        macBuf = sprintf("#%03i%03i", [(pCom.dbRegCtrl.streCd % 1000), (setMacNo % 1000)] );
      }
      else
      {
        imgData1 = ImageDefinitions.IMG_MAC_NO.imageData;
        macBuf = sprintf("%s%06i", [imgData1, setMacNo] );
        (macAdj, macBuf) = AplLibStrUtf.aplLibEucAdjust( macBuf, utf8.encode(macBuf).length, 8+6 );
      }
    }

    // 従業員名称, 番号のセット部
    if(pCom.dbTrm.loasonNw7mbr != 0)
    {
      // セット無し
    }
    else
    {
      // 標準仕様印字
      if ( headParam.ptIfThHead.iCshrCode != 0 )
      {
        /* Setup casher number and name */
        if ( pCom.dbTrm.cshrNamePrn == 3)
        {
          cshrBuf = headParam.ptIfThHead.szCshrName;
        }
        else if ( CmCksys.cmMatugenSystem() != 0 )
        {
          cshrBuf = sprintf("No.%03i%s", [(headParam.ptIfThHead.iCshrCode % 1000), headParam.ptIfThHead.szCshrName] );
        }
        // #if 0
        // /* ZHQは削除 apllib_staffcd_edit()で吸収 */
        //       else if ( cm_ZHQ_system() )
        //       {
        //         snprintf( cshrBuf, sizeof(cshrBuf), "%03lld%s", (headParam.ptIfThHead.iCshrCode % 1000), headParam.ptIfThHead.szCshrName );
        //       }
        // #endif
        else
        {
          tempBuf =  CmStf().apllibStaffcdEdit(tid, 1, tempBuf, headParam.ptIfThHead.iCshrCode, 128, 0).toString();
          if (!CompileFlag.RF1_SYSTEM) {
            cshrBuf = sprintf("%s%s", [tempBuf, headParam.ptIfThHead.szCshrName]);
          }
          // コンパイルスイッチがfalseのためコメントアウト
          // #if RF1_SYSTEM
          // if ((cm_rf1_hs_System ()) 
          //   && (pCom->db_trm.staff_prn))
          // {
          //   // 従業員コードの前に「担当」印字
          //   memset (img_data1, 0x00, sizeof (img_data1));
          //   AplLib_ImgRead (IMG_RCTFM_STAFF_PRN, img_data1, 5);	// イメージマスタから「担当」文字列取得
          //   snprintf (cshrBuf, sizeof (cshrBuf), "%s%s%s", img_data1, tempBuf, headParam->ptIfThHead->szCshrName);
          // }
          // else
          // {
          //   snprintf (cshrBuf, sizeof (cshrBuf), "%s%s", tempBuf, headParam->ptIfThHead->szCshrName);
          // }
          // #endif	/* #if RF1_SYSTEM */
        }
      }

      if ( headParam.ptIfThHead.iChkrCode != 0 )
      {
        /* Setup checker number and name */
        if ( pCom.dbTrm.cshrNamePrn == 3)
        {
          chkrBuf = headParam.ptIfThHead.szChkrName;
        }
        else if ( CmCksys.cmMatugenSystem() != 0)
        {
          chkrBuf = sprintf("No.%03i%s", [(headParam.ptIfThHead.iChkrCode % 1000), headParam.ptIfThHead.szChkrName] );
        }
        // #if 0
        // /* ZHQは削除 apllib_staffcd_edit()で吸収 */
        //       else if ( cm_ZHQ_system() )
        //       {
        //         snprintf( chkrBuf, sizeof(chkrBuf), "%03lld%s", (headParam.ptIfThHead.iChkrCode % 1000), headParam.ptIfThHead.szChkrName );
        //       }
        // #endif
        else
        {
          tempBuf = CmStf().apllibStaffcdEdit(tid, 1, tempBuf, headParam.ptIfThHead.iChkrCode, 128, 0).toString();
  				chkrBuf = sprintf("%s%s", [tempBuf, headParam.ptIfThHead.szChkrName]);
        }
      }
    }

    if ( cshrBuf.isNotEmpty )
    {
      if (!CompileFlag.RF1_SYSTEM) {
          (cshrAdj, cshrBuf) = AplLibStrUtf.aplLibEucAdjust( cshrBuf, utf8.encode(cshrBuf).length, STAFF_DATA_LEN.toInt() );
      }	/* #if !RF1_SYSTEM */
      // コンパイルスイッチがfalseのためコメントアウト
      // #if RF1_SYSTEM
      //     if ((cm_rf1_hs_System ()) 
      //       && (pCom.dbTrm.staff_prn))
      //     {
      //       // 従業員情報印字エリア拡張
      //       cshrAdj = AplLibStrUtf.aplLibEucAdjust (cshrBuf, utf8.encode(cshrBuf).length, PRINT_MAX_LEN);
      //     }
      //     else
      //     {
      //       cshrAdj = AplLibStrUtf.aplLibEucAdjust (cshrBuf, utf8.encode(cshrBuf).length, STAFF_DATA_LEN);
      //     }
      // #endif	/* #if RF1_SYSTEM */
    }

    if (chkrBuf.isNotEmpty)
    {
      (chkrAdj, chkrBuf) = AplLibStrUtf.aplLibEucAdjust( chkrBuf, utf8.encode(chkrBuf).length, STAFF_DATA_LEN.toInt() );
    }

    // レシート番号(ジャーナル番号)のセット部
    recNo = 0;
    jnlNo = 0;
    if (pCom.dbTrm.loasonNw7mbr == 0)
    {
      recNo = headParam.ptIfThHead.iReceiptNo;
      jnlNo = headParam.ptIfThHead.iJournalNo;
    }

    recAdj = EucAdj();
    jnlAdj = EucAdj();
    prnNoAdj = EucAdj();
    if (   (recNo > 0)
        || (jnlNo > 0) )
    {
      if ( CmCksys.cmMatugenSystem() != 0)
      {
        if ( recNo > 0 )
        {
          recNoBuf = sprintf("No.%04i", recNo );
        }
        if ( jnlNo > 0 )
        {
          jnlNoBuf = sprintf("No.%04i", jnlNo );
        }
      }
      else
      {
        if ( recNo > 0 )
        {
          imgData1 = ImageDefinitions.IMG_RCPT_NO.imageData;
          recNoBuf = sprintf("%s%04i", [imgData1, recNo]);
        }
        if ( jnlNo > 0 )
        {
          jnlNoBuf = sprintf("%s%04i", [imgData1, jnlNo]);
        }
      }
      (recAdj, recNoBuf) = AplLibStrUtf.aplLibEucAdjust( recNoBuf, utf8.encode(recNoBuf).length, RECJNL_DATA_LEN );
      (jnlAdj, jnlNoBuf) = AplLibStrUtf.aplLibEucAdjust( jnlNoBuf, utf8.encode(jnlNoBuf).length, RECJNL_DATA_LEN );

      spaceCnt = 0;
      tempBuf = "";

      spaceCnt = PRINT_MAX_LEN - recAdj.count - jnlAdj.count;
      if (spaceCnt < 0)
      {
        spaceCnt = 0;
      }

      if (   (recAdj.count != 0)
          && (jnlAdj.count != 0) )
      {
        // RRRR  +  JJJJ
        if (spaceCnt > 0)
        {
          tempBuf = ''.padLeft(spaceCnt, " "); // Rec と Jnlの間のスペース作成
        }

        if(pCom.dbTrm.recieptnoPrn == 0)	// レシートNoの印字する場合の時はレシートNo.は右寄せ
        {
          prnNoBuf = sprintf("%s%s%s", [jnlNoBuf, tempBuf, recNoBuf]);
        }
        else
        {
          prnNoBuf = sprintf("%s%s%s", [recNoBuf, tempBuf, jnlNoBuf]);
        }
      }
      else if (recAdj.count > 0)
      {
        prnNoBuf = recNoBuf;
      }
      else if (jnlAdj.count > 0)
      {
        prnNoBuf = jnlNoBuf;
      }

      (prnNoAdj, prnNoBuf) = AplLibStrUtf.aplLibEucAdjust( prnNoBuf, utf8.encode(prnNoBuf).length, PRINT_MAX_LEN );
    }

    //
    // 印字文字列の作成
    //
    num = 0;

    //
    // (img)mac_no_____(img)rec_no	のセット
    //
    if (streBuf.isNotEmpty
        || macBuf.isNotEmpty)
    {
      iMgDataAdd = TImgDataAdd();
      ans = TImgDataAddAns();
      iMgDataAdd.imgData[0].ptn = CmStrMolding.DATA_PTN_NONE;
      iMgDataAdd.imgData[0].posi = 0;
      iMgDataAdd.imgData[0].typ = DataTyps.DATA_TYP_CHAR.id;
      iMgDataAdd.imgData[0].count = CmStrMolding.RCPTWIDTH;
      iMgDataAdd.imgData[0].data = int.parse(streBuf);
      iMgDataAdd.imgData[1].ptn = CmStrMolding.DATA_PTN_NONE;
      iMgDataAdd.imgData[1].posi = CmStrMolding.RCPTWIDTH - macAdj!.count;
      iMgDataAdd.imgData[1].typ = DataTyps.DATA_TYP_CHAR.id;
      iMgDataAdd.imgData[1].count = CmStrMolding.RCPTWIDTH - macAdj.count;
      iMgDataAdd.imgData[1].data = int.parse(macBuf);
      CmStrMolding.cmMultiImgDataAdd(tid, iMgDataAdd, ans);
      sLine[num] += ans.line[0];
      num ++;
    }

    //
    // YYYY年MM月DD日(Wk)HH:MM__#cccccc.	のセット
    //
    // 	YYYY年MM月DD日(Wk) = 18count
    // 	HH:MM = 5count
    // 	__#cccccc = 9count (2space)
    //
    if (dateBuf.isNotEmpty
        || timeBuf.isNotEmpty)
        //|| (strlen(macBuf) != 0) )
    {
      //snprintf( sLine[num], sizeof(sLine[num]), "%*s%*s%*s", 18, dateBuf, 5, timeBuf, 9, macBuf );
      iMgDataAdd = TImgDataAdd();
      ans = TImgDataAddAns();
      iMgDataAdd.imgData[0].ptn = CmStrMolding.DATA_PTN_NONE;
      iMgDataAdd.imgData[0].posi = 0;
      iMgDataAdd.imgData[0].typ = DataTyps.DATA_TYP_CHAR.id;
      iMgDataAdd.imgData[0].count = CmStrMolding.RCPTWIDTH;
      iMgDataAdd.imgData[0].data = int.parse(dateBuf);
      iMgDataAdd.imgData[1].ptn = CmStrMolding.DATA_PTN_NONE;
      iMgDataAdd.imgData[1].posi = CmStrMolding.RCPTWIDTH - timeAdj!.count;
      iMgDataAdd.imgData[1].typ = DataTyps.DATA_TYP_CHAR.id;
      iMgDataAdd.imgData[1].count = CmStrMolding.RCPTWIDTH - timeAdj.count;
      iMgDataAdd.imgData[1].data = int.parse(timeBuf);
      CmStrMolding.cmMultiImgDataAdd(tid, iMgDataAdd, ans);
      sLine[num] += ans.line[0];
      num ++;
    }

    //
    // セットされたバッファにより下記のいずれかとなる
    // ssssssCshrName    kkkkkkChkrName.	パターン1 のセット
    //                             RRRR.
    // 
    // ssssssCshrName              RRRR.	パターン2 のセット
    //
    //                             RRRR.	パターン3 のセット
    //
    // Any(行無し or Cshrのみ or 両方)	パターン4 のセット
    // RRRR                        JJJJ.
    //
    spaceCnt = 0;
    if (chkrAdj!.count != 0
        && cshrAdj!.count != 0)
    {
      // ssssssCshrName  + kkkkkkChkrName
      tempBuf = "";
      if ( cshrAdj.count > 0 )
      {
        spaceCnt = (STAFF_DATA_LEN - cshrAdj.count).toInt();
      }

      if (spaceCnt > 0)
      {
        tempBuf = ''.padLeft(spaceCnt, " "); // Cshr と Chkrの間のスペース作成
      }
      sLine[num] = sprintf("%s%s%s", [cshrBuf, tempBuf, chkrBuf]);
      num ++;

      // RRRR  or  JJJJ  or  RRRR + JJJJ
      if (prnNoBuf.isNotEmpty
          && prnNoAdj.count > 0)
      {
        tempBuf = "";
        if (prnNoAdj.count < PRINT_MAX_LEN)
        {
          tempBuf = ''.padLeft(PRINT_MAX_LEN - prnNoAdj.count, " " );	// レシートNoやジャーナルNoは右寄せ
        }
        sLine[num] = sprintf("%s%s", [tempBuf, prnNoBuf]);
        num ++;
      }
    }
    else if (cshrAdj!.count != 0)
    {
      tempBuf = "";
      if ( cshrAdj.count > 0 )
      {
        spaceCnt = PRINT_MAX_LEN - prnNoAdj.count - cshrAdj.count;
      }

      if (spaceCnt > 0)
      {
        // ssssssCshrName + RRRR
        tempBuf = ''.padLeft(spaceCnt, " ");	// Cshr と prnNoの間のスペース作成
        sLine[num] = sprintf("%s%s%s", [cshrBuf, tempBuf, prnNoBuf]);
        num ++;
      }
      else
      {
        // ssssssCshrName
        sLine[num] = cshrBuf;
        num ++;

        // RRRR  or  JJJJ  or  RRRR + JJJJ
        if (prnNoBuf.isNotEmpty
            && prnNoAdj.count > 0)
        {
          tempBuf = "";
          if (prnNoAdj.count < PRINT_MAX_LEN)
          {
            tempBuf = "".padLeft(PRINT_MAX_LEN - prnNoAdj.count, " ");	// レシートNoやジャーナルNoは右寄せ
          }
          sLine[num] = sprintf("%s%s", [tempBuf, prnNoBuf]);
          num ++;
        }
      }
    }
    else
    {

      // RRRR  or  JJJJ  or  RRRR + JJJJ
      if (prnNoBuf.isNotEmpty
          && prnNoAdj.count > 0)
      {
        tempBuf = "";
        if (prnNoAdj.count < PRINT_MAX_LEN)
        {
          tempBuf = "".padLeft(PRINT_MAX_LEN - prnNoAdj.count, " ");	// レシートNoやジャーナルNoは右寄せ
        }
        sLine[num] = sprintf("%s%s", [tempBuf, prnNoBuf]);
        num ++;
      }
    }


    ejFp = null;
    if ( headParam.ptIfThHead.EjDataTxt.isNotEmpty )
    {
      ejFp = TprxPlatform.getFile(headParam.ptIfThHead.EjDataTxt);
    }

    //
    // 印字文字列の書き込み
    //
    for (num = 0; num < SLINE_MAX; num++)
    {
      if (sLine[num].isEmpty)
      {
        continue;
      }
      ret = await IfThAlloc.ifThAllocArea(tid, IfThLib.IF_TH_Y_12);
      if (ret != 0)
      {
        TprLog().logAdd(tid, LogLevelDefine.warning,
            "ifThHeaderCommonPrint : if_th_AllocArea [$num] [$ret]",
            errId: -1);
        return InterfaceDefine.IF_TH_PERALLOC;
      }
      ret = await IfThGridStr.ifThGridString(tid, InterfaceDefine.IF_TH_FW12, 1, 1, 0, 0, 0, headParam.iAFontId, headParam.iKFontId, sLine[num]);
      if (ret != 0)
      {
        TprLog().logAdd(tid, LogLevelDefine.warning,
            "ifThHeaderCommonPrint : if_th_GridString [$num] [$ret]",
            errId: -1);
        return InterfaceDefine.IF_TH_PERWRITE;
      }

      if (ejFp != null)
      {

        // 先頭に空白行を
        if ( num == 0 )
        {
          ejData = "".padLeft(CmStrMolding.JNALWIDTH, " ");

          ejFp.writeAsStringSync("$ejData\n", mode: FileMode.append);
        }

        // 中央寄せ
        ejData = "";
        ejData = "".padLeft(
          (CmStrMolding.JNALWIDTH - CmStrMolding.RCPTWIDTH) ~/ 2
          , " ");
        ejData += sLine[num];

        ejFp.writeAsStringSync("$ejData\n", mode: FileMode.append);
      }

    }

    return InterfaceDefine.IF_TH_POK;
  }

}