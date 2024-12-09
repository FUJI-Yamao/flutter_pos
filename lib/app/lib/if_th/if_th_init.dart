/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th_init.c
//  このファイルは上記ヘッダーファイルを元にdart化したものです。 

// ************************************************************************
// File:           if_th_init.c
// Contents:       if_th_Init();
// ************************************************************************

import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_pos/app/inc/lib/if_th.dart';
import 'package:flutter_pos/app/inc/lib/if_thlib.dart';
import 'package:flutter_pos/app/lib/apllib/competition_ini.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../../common/cmn_sysfunc.dart';
import '../../if/common/interface_define.dart';
import '../../inc/apl/rxmem.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'if_th_csndpara.dart';


class TPrnFontInf {
//pid_t	pid;
  int handle = 0;
  int num = 0;
}

class IfThInit {

  static const TRUE  = 1;
  static const FALSE = 0;
  static const TPARAM_MAX = 12;
  static const PRN_FONT_INF_MAX = 20;

/* Static datas */
  static ThPrnBuf tPrnBuf = ThPrnBuf(); /* Print buffer */

/* External variables */
  static int ifThJr = 0; /* Web2100 Jr TRUE/FALSE */

  static List<TPrnFontInf> prnInf = List<TPrnFontInf>
        .generate(PRN_FONT_INF_MAX, (index) => TPrnFontInf());

  /// サーマルプリンタ初期化
  ///
  /// 引数:[src] APL-ID
  ///
  /// 戻り値：IF_TH_POK	: Normal end
  ///
  ///       IF_TH_PERWRITE	: Write error
  ///
  ///  関連tprxソース:if_th_init.c - if_th_Init()
  static Future<int> ifThInit(int src) async {
    List<IfThParam> th_param = List<IfThParam>.filled(TPARAM_MAX, IfThParam());  /* Parameter table */
    int		 iDotWidth = 0;		/* Receipt width in dots */
    int		 ret = 0;			    /* Return value */
    int    prt_type = 0;
    int    DefRecWidth = 0;
    String sLogMsg = "";		/* Error message buffer */

    src = await CmCksys.cmQCJCCPrintAid(src);
    if ((await CmCksys.cmZHQSystem() != 0) && (src == Tpraid.TPRAID_KITCHEN1_PRN)) {
      DefRecWidth = IfThLib.IF_TH_DEFRECWID80;
    } else {
      DefRecWidth = IfThLib.IF_TH_DEFRECWID;
    }

    /* Get x_offset value from mac_info.ini */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      tPrnBuf.x_offset = 0;
      iDotWidth = DefRecWidth;	/* Set default value */

      /* Initialize print buffer */
      tPrnBuf.crast = ((iDotWidth + 7) / 8).toInt();
      tPrnBuf.ctopline = 0;
      tPrnBuf.cbtmline = 0;

      sLogMsg = "IfThInit : Error on rxMemPtr!";
      TprLog().logAdd(src, LogLevelDefine.error, sLogMsg);
      return (InterfaceDefine.IF_TH_PERREAD);
    }
    RxCommonBuf cmem = xRet.object;

    tPrnBuf.OutPutFilePointer = "";

    prt_type = await CmCksys.cmPrinterType();

    /* success */
    tPrnBuf.x_offset = cmem.iniMacInfo.printer_cntl.x_offset;

    /* Parameter initialize */
    th_param[0].paraNum = 1;
    if ((await CmCksys.cmZHQSystem() != 0) && (src == Tpraid.TPRAID_KITCHEN1_PRN) ) {
      th_param[0].wData = cmem.iniMacInfo.printer_cntl.recipt_wid80;
      iDotWidth = cmem.iniMacInfo.printer_cntl.recipt_wid80;
    } else {
      th_param[0].wData = cmem.iniMacInfo.printer_cntl.recipt_wid;
      iDotWidth = cmem.iniMacInfo.printer_cntl.recipt_wid;
    }
    if (0 == iDotWidth) {
      iDotWidth = DefRecWidth;	/* Set default value */
    }

    /* Initialize print buffer */
    tPrnBuf.crast = ((iDotWidth + 7) / 8).toInt();
    tPrnBuf.ctopline = 0;
    tPrnBuf.cbtmline = 0;
    if (prt_type != CmSys.SUBCPU_PRINTER) {
      tPrnBuf.rct_lf_plus =
          await CompetitionIni.competitionIniGetShort(src,
                  CompetitionIniLists.COMPETITION_INI_RCT_LF_PLUS,
                  CompetitionIniType.COMPETITION_INI_GETMEM);
    }

    th_param[1].paraNum = 2;
    th_param[1].wData = cmem.iniMacInfo.printer_cntl.prnt_length;

    th_param[2].paraNum = 3;
    th_param[2].wData = cmem.iniMacInfo.printer_cntl.start_speed;

    th_param[3].paraNum = 4;
    th_param[3].wData = cmem.iniMacInfo.printer_cntl.top_speed;

    th_param[4].paraNum = 5;
    th_param[4].wData = cmem.iniMacInfo.printer_cntl.top_sp_step;

    th_param[5].paraNum = 6;
    th_param[5].wData = cmem.iniMacInfo.printer_cntl.start_density;

    th_param[6].paraNum = 7;
    th_param[6].wData = cmem.iniMacInfo.printer_cntl.top_density;

    th_param[7].paraNum = 8;
    th_param[7].wData = cmem.iniMacInfo.printer_cntl.top_den_step;

    th_param[8].paraNum = 9;
    th_param[8].wData = cmem.iniMacInfo.printer_cntl.prt_position;

    th_param[9].paraNum = 10;
    th_param[9].wData = cmem.iniMacInfo.printer_cntl.head_wid;

    th_param[10].paraNum = 11;
    th_param[10].wData = cmem.iniMacInfo.printer_cntl.prt_start_size;

    th_param[11].paraNum = 12;
    th_param[11].wData = cmem.iniMacInfo.printer_cntl.err_mask;

    if ( prt_type == CmSys.TPRTS ) {
      th_param[0].paraNum = 1;
      th_param[0].wData = cmem.iniMacInfo.printer.rct_spd; /* speed */
    } else if ( prt_type == CmSys.TPRTF ) {
      th_param[0].wData = cmem.iniMacInfo.printer.rct_spd; /* spped */
      th_param[1].wData =
          await CompetitionIni.competitionIniGetShort(src,
                  CompetitionIniLists.COMPETITION_INI_RCT_DNS,
                  CompetitionIniType.COMPETITION_INI_GETMEM);	/* density */
    } else if ((prt_type == CmSys.TPRTSS)||(prt_type == CmSys.TPRTIM)||(prt_type == CmSys.TPRTHP)) {
      th_param[1].wData =
          await CompetitionIni.competitionIniGetShort(src,
                  CompetitionIniLists.COMPETITION_INI_RCT_DNS,
                  CompetitionIniType.COMPETITION_INI_GETMEM);	/* density */
    }
    if (await CmCksys.cmDummyPrintMyself() == TRUE) {
      return InterfaceDefine.IF_TH_POK;
    }

    /* Send the parameters to printer */
    if (0 != (ret = await IfThCSndPara.ifThCSendParam(src, TPARAM_MAX, th_param))) {
      sLogMsg = "IfThInit : Error on if_th_cSendParam. ret(${ret})";
      TprLog().logAdd(src, LogLevelDefine.error, sLogMsg);
      return ( ret );		/* Error happened */
    }

    /* get Web2100 Jr flag */
    int webJrSystem = await CmCksys.cmWebJrSystem();
    if (webJrSystem == 0) {	/* 戻値：0:WEB2100 Jr.タイプではない  1:WEB2100 Jr.タイプ */
      /* not Jr */
      ifThJr = FALSE;
    } else if (webJrSystem == 1) {
      int webJrDebugSystem = CmCksys.cmWebJrDebugSystem(cmem.iniSys);
      if (webJrDebugSystem == 0) { /* 戻値： 0: webjr=yes  1: webjr=ok0893 */
        /* Jr */
        ifThJr = TRUE;
      } else if (webJrDebugSystem == 1) {
        /* Jr debug mode */
        ifThJr = FALSE;
      }
      if (prt_type == CmSys.TPRTF) {
        ifThJr = FALSE;
      }
    } else {
      /* error */
      sLogMsg = "IfThInit : Error on cm_webjr_system : ret(${webJrSystem})";
      TprLog().logAdd(src, LogLevelDefine.error, sLogMsg);
      return (-1);
    }
    return (InterfaceDefine.IF_TH_POK);
  }

  /// checking printer handler
  ///
  /// 引数:[src] APL-ID
  ///
  ///     [handle]
  ///
  ///     [num]
  ///
  /// 戻り値：0	: Normal end
  ///
  ///       -1	: error
  ///
  ///  関連tprxソース:if_th_init.c - PrnInf_Set()
  static Future<int> prnInfSet(int tid, int handle, int num) async {
    int		 i = 0;
    int    flg = 0;
    String erlog = "";

    tid = await CmCksys.cmQCJCCPrintAid(tid);

    for (int i = 0; i < PRN_FONT_INF_MAX; i++) {
      if (prnInf[i].handle == -1) {
        prnInf[i].handle = handle;
        prnInf[i].num = num;
        erlog = "PrnInf_Set() OK [${i}] HDL[${prnInf[i].handle}] NUM[${prnInf[i].num}\n";
        TprLog().logAdd(tid, LogLevelDefine.normal, erlog);
        flg = 1;
        break;
      }
    }
    if (flg == 0) {
      erlog = "PrnInf_Set() Over Error handle[${handle}] num[${num}]\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erlog);
      for (i = 0; i < PRN_FONT_INF_MAX; i++) {
        erlog = "PrnInf_Set() [${i}] HDL[${prnInf[i].handle}] NUM[${prnInf[i].num}]\n";
        TprLog().logAdd(tid, LogLevelDefine.error, erlog);
      }
      return -1;
    }
    return 0;
  }

  ///  関連tprxソース:if_th_init.c - PrnInf_Reset()
  static Future<int> prnInfReset(int tid, int handle) async {
    int		i = 0, flg = 0;
    String erlog = "";

    tid = await CmCksys.cmQCJCCPrintAid(tid);

    for (i = (PRN_FONT_INF_MAX - 1); i >= 0; i--) {
      if (prnInf[i].handle == handle) {
        erlog = "PrnInf_Reset() OK [${i}] HDL[${prnInf[i].handle}] NUM[${prnInf[i].num}]\n";
        TprLog().logAdd(tid, LogLevelDefine.normal, erlog);
        prnInf[i].handle = -1;
        prnInf[i].num = -1;
        flg = 1;
        break;
      }
    }
    if (flg == 0) {
      erlog = "PrnInf_Reset() Not found handle[${handle}]\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erlog);
      for (i = 0; i < PRN_FONT_INF_MAX; i++) {
        erlog = "PrnInf_Reset() [${i}] HDL[${prnInf[i].handle}] NUM[${prnInf[i].num}]\n";
        TprLog().logAdd(tid, LogLevelDefine.error, erlog);
      }
      return -1;
    }
    return 0;
  }

  ///  関連tprxソース:if_th_init.c - PrnInf_Num()
  static PrnFontIdx prnInfNum(int tid, int handle) {
    switch (handle) {
      case 0:
        return PrnFontIdx.E24_16_1_1;
      case 1:
        return PrnFontIdx.E24_24_1_1;
      case 2:
        return PrnFontIdx.E24_24_1_2;
      case 3:
        return PrnFontIdx.E24_24_2_1;
      case 4:
        return PrnFontIdx.E24_24_2_2;
      case 5:
        return PrnFontIdx.E24_48_1_1;
      case 6:
        return PrnFontIdx.E16_16_1_1;
      case 7:
        return PrnFontIdx.E16_16_2_2;
      case 8:
        return PrnFontIdx.E16_24_1_1;
      default:
        return PrnFontIdx.E24_24_1_1;
    }
    // int i = 0;
    // String erlog = "";
    // tid = CmCksys.cmQCJCCPrintAid(tid);
    // for (int i = 0; i < PRN_FONT_INF_MAX; i++) {
    //   if (prnInf[i].handle == handle) {
    //     return (prnInf[i].num);
    //   }
    // }
    // erlog = "PrnInf_Num() Not found handle[${handle}]\n";
    // TprLog().logAdd(tid, LogLevelDefine.error, erlog);
    // for (i = 0; i < PRN_FONT_INF_MAX; i++) {
    //   erlog = "PrnInf_Num() [${i}] HDL[${prnInf[i].handle}] NUM[${prnInf[i].num}]\n";
    //   TprLog().logAdd(tid, LogLevelDefine.error, erlog);
    // }
    //return -1;
  }

  ///  関連tprxソース:if_th_init.c - PrnInf_Init()
  static Future<void> PrnInf_Init(int tid) async {
    tid = await CmCksys.cmQCJCCPrintAid(tid);
    TprLog().logAdd(tid, LogLevelDefine.normal, "PrnInf_Init()\n");
    for (int i = 0; i < PRN_FONT_INF_MAX; i++) {
      prnInf[i].handle = -1;
      prnInf[i].num = -1;
    }
  }

  ///  関連tprxソース:if_th_init.c - if_th_Set_lf_plus()
  static Future<void> ifThSetLfPlus(TprTID src, int typ) async {
    src = await CmCksys.cmQCJCCPrintAid(src);
    if (typ == 1) {
      tPrnBuf.rct_lf_plus = 6;
      return;
    }
    int prt_type = await CmCksys.cmPrinterType();
    if (prt_type != CmSys.SUBCPU_PRINTER) {
      tPrnBuf.rct_lf_plus =
          await CompetitionIni.competitionIniGetShort(src,
                  CompetitionIniLists.COMPETITION_INI_RCT_LF_PLUS,
                  CompetitionIniType.COMPETITION_INI_GETMEM);
    }
  }
}
