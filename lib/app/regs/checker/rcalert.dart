/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_sound.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../tprlib/TprLibDlg.dart';
import '../inc/rc_mem.dart';
import 'rcsyschk.dart';

/// 関連tprxソース: rcalert.c
class RcAlert {
  /// 関連tprxソース: rcalert.c - rcAlert_Mode_Chk
  static Future<int> rcAlertModeChk() async {
    String log = "";
    AcMem cMem = SystemFunc.readAcMem();

    switch (cMem.alertFlg) {
      case 1:
      case 3:
      case 4:
      case 5:
        if ((TprLibDlg.tprLibDlgNoCheck() != DlgConfirmMsgKind.MSG_AGE_CHECK.dlgId) &&
            (TprLibDlg.tprLibDlgNoCheck() != DlgConfirmMsgKind.MSG_NOTICE_REGISTRATION.dlgId) &&
            (TprLibDlg.tprLibDlgNoCheck() != DlgConfirmMsgKind.MSG_FORBIDDEN_REGISTRATION.dlgId)) {
          log = "rcAlertModeChk : Clear Force[${cMem.ent.errNo}]";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
          cMem.alertFlg = 0;
          return 0;
        }
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcAlert_Mode_Chk Now Alert");
        return 1;

      case 2:
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcAlert_Mode_Chk Now Sound Alert");
        RcSound.rcKeySound(null);
        cMem.alertFlg = 0;
        break;

      default:
        break;
    }
    return 0;
  }
}
