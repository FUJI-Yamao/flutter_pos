/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../regs/checker/rcsyschk.dart';
import '../../regs/inc/rc_regs.dart';
import '../../common/cmn_sysfunc.dart';
import '../../regs/inc/rc_mem.dart';

class RcChgAssortPlu{
  /* rcfncchk.c */
  ///  関連tprxソース: rc_chgassortplu.c - rcCheck_ChgAsoortPluMode
  static Future<bool> rcCheckChgAsoortPluMode() async
  {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf())
    {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER  :
      case RcRegs.KY_DUALCSHR :
        return((cMem.stat.scrMode == RcRegs.RG_CHG_ASSORT_PLU_DSP) ||
        (cMem.stat.scrMode == RcRegs.VD_CHG_ASSORT_PLU_DSP) ||
        (cMem.stat.scrMode == RcRegs.TR_CHG_ASSORT_PLU_DSP) ||
        (cMem.stat.scrMode == RcRegs.SR_CHG_ASSORT_PLU_DSP) );
      case RcRegs.KY_SINGLE  :
        if(cMem.stat.scrType == RcRegs.LCD_104Inch){
          return((cMem.stat.scrMode == RcRegs.RG_CHG_ASSORT_PLU_DSP) ||
          (cMem.stat.scrMode == RcRegs.VD_CHG_ASSORT_PLU_DSP) ||
          (cMem.stat.scrMode == RcRegs.TR_CHG_ASSORT_PLU_DSP) ||
          (cMem.stat.scrMode == RcRegs.SR_CHG_ASSORT_PLU_DSP) );
        }
        else if(cMem.stat.scrType == RcRegs.LCD_57Inch){
          return((cMem.stat.subScrMode == RcRegs.RG_CHG_ASSORT_PLU_DSP) ||
          (cMem.stat.subScrMode == RcRegs.VD_CHG_ASSORT_PLU_DSP) ||
          (cMem.stat.subScrMode == RcRegs.TR_CHG_ASSORT_PLU_DSP) ||
          (cMem.stat.subScrMode == RcRegs.SR_CHG_ASSORT_PLU_DSP) );
        }
      }
    return false;
  }
}