/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rcfncchk.dart';
import 'rcky_rfdopr.dart';
import 'rcmbrbuyadd.dart';
import 'rcmbrkytcktmain.dart';

class RcSuicaCom {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rcsuica_com.c - rcSuica_Read_MainProc()
  static int rcSuicaReadMainProc () {
    return 0;
  }

  /// 関連tprxソース: rcsuica_com.c - rcNimoca_RdVoidData()
  static Future<bool> rcNimocaRdVoidData() async {
    RegsMem mem = SystemFunc.readRegsMem();
    if ((await CmCksys.cmNimocaPointSystem() == 1)
        && (!((await RcMbrBuyAdd.rcmbrChkBuyAddMode() > 0) /* 買上追加? */
            || (await RcFncChk.rcCheckStlMode() && !RckyRfdopr.rcRfdOprCheckRcptVoidMode())
            || (await RcFncChk.rcCheckItmMode() && !RckyRfdopr.rcRfdOprCheckRcptVoidMode())
            || (RcFncChk.rcSGCheckMbrScnMode())
            || (RcFncChk.rcSGCheckPreMode())
            || (RcFncChk.rcSGCheckMntMode())
            || (RcFncChk.rcCheckQCMbrNReadDspMode())
            || (RcMbrKyTcktMain.rcmbrChkTcktIssuMode() == 1)))
        && (mem.tTtllog.t100700.mbrInput == MbrInputType.nimocaInput.index)) {
      return true;
    }
    return false;
  }

  // TODO:中身未実装
  /// 関連tprxソース: rcsuica_com.c - rcSuica_IcChk()
  static int rcSuicaIcChk() {
    return 0;
  }

  /// 関連tprxソース: rcsuica_com.c - rcNimoca_point_data
  static Future<bool> rcNimocaPointData() async {
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    if ((await CmCksys.cmNimocaPointSystem() != 0) &&
        (cMem.stat.fncCode != FuncKey.KY_EVOID.keyId) &&
        (cMem.stat.fncCode != FuncKey.KY_ESVOID.keyId) &&
        (cMem.stat.fncCode != FuncKey.KY_CRDTVOID.keyId) &&
        (cMem.stat.fncCode != FuncKey.KY_PRECAVOID.keyId) &&
        ((mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput.index) ||
            (mem.tTtllog.t100700Sts.nimocaFlg == 2))) {
      return true;
    }
    return false;
  }
}