/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/foundation.dart';

import '../../inc/sys/tpr_type.dart';
import '../../../app/inc/apl/compflag.dart';
import '../../../app/fb/fb_lib.dart';
import '../../inc/sys/tpr_log.dart';
//import '../../../app/fb/fb_drvchk.dart';
import '../../common/cmn_sysfunc.dart';

class _DRVERR_CNT {
  int	cnt = 0;
}

class ComDrvErr {

  List<_DRVERR_CNT> drverr_count = new List.generate(
      PlusDrvChk.PLUS_DRV_CHK_MAX, (index) => _DRVERR_CNT.new());

  ComDrvErr() {
    drverr_count[PlusDrvChk.PLUS_SCAN_D].cnt   =  1000;   // PLUS_SCAN_D
    drverr_count[PlusDrvChk.PLUS_SCAN_T].cnt   =  1000;   // PLUS_SCAN_T
    drverr_count[PlusDrvChk.PLUS_FIP_D].cnt    =  40;     // PLUS_FIP_D
    drverr_count[PlusDrvChk.PLUS_FIP_T].cnt    =  40;     // PLUS_FIP_T
    drverr_count[PlusDrvChk.PLUS_TPANEL_D].cnt =  -1;     // PLUS_TPANEL_D
    drverr_count[PlusDrvChk.PLUS_TPANEL_T].cnt =  -1;     // PLUS_TPANEL_T	5
    drverr_count[PlusDrvChk.PLUS_MKEY_D].cnt   =  -1;     // PLUS_MKEY_D
    drverr_count[PlusDrvChk.PLUS_MKEY_T].cnt   =  -1;     // PLUS_MKEY_T
    drverr_count[PlusDrvChk.PLUS_MSR_D].cnt    =  1000;   // PLUS_MSR_D	TBD
    drverr_count[PlusDrvChk.PLUS_MSR_T].cnt    =  1000;   // PLUS_MSR_T	TBD
    drverr_count[PlusDrvChk.PLUS_TPRTF].cnt    =  -1;     // PLUS_TPRTF		10
    drverr_count[PlusDrvChk.PLUS_SMSCLSC].cnt  =  1000;   // PLUS_SMSCLSC
    drverr_count[PlusDrvChk.PLUS_SIGNP].cnt    =  1000;   // PLUS_SIGNP
    drverr_count[PlusDrvChk.PLUS_FIP_3].cnt    =  40;     // PLUS_FIP_3
    drverr_count[PlusDrvChk.PLUS_TPRTF2].cnt   =  -1;     // PLUS_TPRTF2
    drverr_count[PlusDrvChk.PLUS_TPANEL_A].cnt =  -1;     // PLUS_TPANEL_A	15
    drverr_count[PlusDrvChk.PLUS_ICCARD].cnt   =  -1;     // PLUS_ICCARD
    drverr_count[PlusDrvChk.PLUS_MST].cnt      =  -1;     // PLUS_MST
    drverr_count[PlusDrvChk.PLUS_CPNPRN].cnt   =  -1;     // PLUS_CPNPRN
    drverr_count[PlusDrvChk.PLUS_POWLI].cnt    =  1000;   // PLUS_POWLI
    drverr_count[PlusDrvChk.PLUS_SCAN_P].cnt   =  1000;   // PLUS_SCAN_P		20
    drverr_count[PlusDrvChk.PLUS_APBF].cnt     =  1000;   // PLUS_APBF
    drverr_count[PlusDrvChk.PLUS_EXC].cnt      =  5;      // PLUS_EXC
    drverr_count[PlusDrvChk.PLUS_HITOUCH].cnt  =  5;      // PLUS_HITOUCH
    drverr_count[PlusDrvChk.PLUS_AMI].cnt      =  5;      // PLUS_AMI
  }

  /// COMドライバエラーログ出力
  /// COMドライバについてエラー要因が無いかチェックし、エラー要因があった場合にその要因をログ出力する。
  /// 引数:[tid]
  ///     [SavePortNm]
  /// 戻り値：0　エラー無し
  ///       -1　エラー有り
  /// 関連tprxソース:com_drverr.c - com_drverr()
  int com_drverr(TprTID tid, int SavePortNm) {
    TprLog myLog = TprLog();
    FbMem fbMem = SystemFunc.readFbMem(null);

    if (CompileFlag.CENTOS == true) {

      if ((SavePortNm < 0) || (SavePortNm >= PlusDrvChk.PLUS_DRV_CHK_MAX)) {
        String erlog = Object().runtimeType.toString() +
            " SavePortNm Illegal[" + SavePortNm.toString() + "]\n";
        myLog.logAdd(tid, LogLevelDefine.error, erlog);
        return -1;
      }

      if (drverr_count[SavePortNm].cnt == -1) {
        String erlog = Object().runtimeType.toString() +
            " SavePortNm [" + SavePortNm.toString() + "] unsupport\n";
        myLog.logAdd(tid, LogLevelDefine.error, erlog);
        return -1;
      }

      fbMem.drv_err[SavePortNm]++;
      if(fbMem.drv_err[SavePortNm] > drverr_count[SavePortNm].cnt) {
        String erlog = Object().runtimeType.toString() +
          " SavePortNm [" + SavePortNm.toString() + "]" +
          " drv_err[" + drverr_count[SavePortNm].cnt.toString() + "] \n";
        myLog.logAdd(tid, LogLevelDefine.error, erlog);
        fbMem.drv_err[SavePortNm] = drverr_count[SavePortNm].cnt;
        SystemFunc.writeFbMem(null, fbMem);
      }
    }
    return 0;
  }
}