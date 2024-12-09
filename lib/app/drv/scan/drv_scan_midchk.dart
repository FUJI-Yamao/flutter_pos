/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';
import './drv_scan_aplreq.dart';
import './drv_scan_com.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_stat.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_log.dart';

/// 関連tprxソース:drv_scan_midchk_plus.c
///
class ScanMidChk {
  /// 変数
  static TprLog myLog = TprLog();

  /// アプリからの送信データを選別する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 引数:[ptTprMsg] アプリからの送信データ
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - drv_scan_MidCheck()
  static Future<int> drvScanMidCheck(SendPort _parentSendPort, TprTID tid, TprMsg_t ptTprMsg) async {
    switch (ptTprMsg.common.mid) {
      case TprMidDef.TPRMID_DEVREQ:
        if (ScanCom.scan_info.sysFailFlg == 0) {
           await ScanAplReq().drvScanAplReq(_parentSendPort, tid, ptTprMsg.data);
        }
        break;
      case TprMidDef.TPRMID_TIM:
        if (ScanCom.scan_info.sysFailFlg == 0) {
          //drvScanTimer(tid, ptTprMsg);
        }
        break;
      case TprMidDef.TPRMID_SYSNOTIFY:
        if (ptTprMsg.sysnotify.mode == TprStatDef.TPRTST_POWEROFF) {
          /* Start: Dart変換の際、コメント化：TprLibGeneric.c TprSysNotifyAck() */
					//TprSysNotifyAck(ScanCommon.scan_info.sysPipe, ScanCommon.scan_info.myDid, tid);
					  /* End: Dart変換の際、コメント化：TprLibGeneric.c TprSysNotifyAck() */
          myLog.logAdd(tid, LogLevelDefine.normal, " POWER OFF");
          /* Start: Dart変換の際、コメント化：fb_mem.c FBMemDel(), rxmem.c rxMemFree() */ /*
					FBMemDel(0);
					rxMemFree(RXMEM_STAT);
					rxMemFree(RXMEM_COMMON);
					exit( 0 );
					 */ /* End: Dart変換の際、コメント化：fb_mem.c FBMemDel(), rxmem.c rxMemFree() */
        }
        break;
      case TprMidDef.TPRMID_SYSFAIL:
        ScanCom.scan_info.sysFailFlg = 1;
        /* Start: Dart変換の際、コメント化：TprLibSysFail.c TprSysFailAck() */ /*
				TprSysFailAck(ScanCommon.scan_info.sysPipe);
				*/ /* End: Dart変換の際、コメント化：TprLibSysFail.c TprSysFailAck() */
        myLog.logAdd(tid, LogLevelDefine.error, " TPRTST_SYSFAIL");
        break;
      default:
        break;
    }

    return (0);
  }
}
