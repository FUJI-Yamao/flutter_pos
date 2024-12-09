/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/sys/syst/sys_data.dart';
import 'package:flutter_pos/app/sys/syst/sys_ups.dart';
import 'package:flutter_pos/app/sys/syst/sysidol.dart';

import '../../common/environment.dart';
import '../../inc/sys/tpr_def.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_stat.dart';
import '../../lib/apllib/upderr_chk.dart';
import '../../tprlib/tprlib_data.dart';

/// 関連tprxソース: callbacks.c
class CallBacks {
  /// SYSNOTIFY message send
  /// 関連tprxソース: callbacks.c - SysNotifySend()
  static void sysNotifySend(int sts) {
    // TODO:10087 SYSNOTIFY
    int i = 0; /* loop counter */
    TprtStat sysNotify = TprtStat(); /* message buffer */
    String log = '';
    List<int> list = List.filled(16, 0); //tprsysnotify_tのサイズ16バイト
    String strMid = '';
    File file;

    SysData().sysMenuStatus = sts;
    UpdErrChk.updErrSaveReset(0);

    /* SYSNOTIFY->POWEROFF message buffer initialize */

    log = "SYST:SysNotifySend(0x&sts) call\n";
    TprLog().logAdd(0, LogLevelDefine.error, log);

    file = TprxPlatform.getFile(SysUps.sysUpsDrvTib.fds);

    /* TPRTST_POWEROFF send to tprdrv_ups */
    if (file.existsSync()) {
      if (sts == TprStatDef.TPRTST_POWEROFF) {
        sysNotify.mid = TprMidDef.TPRMID_SYSNOTIFY;
        sysNotify.length = 16 - 8; //tprsysnotify_tのサイズ16バイト tprcommon_tのサイズ8バイト
        sysNotify.mode = sts;
        strMid = sysNotify.mid.toString();
        for (i = 0; i < strMid.length; i++) {
          list.add(int.tryParse(strMid.substring(i, i + 1)) ?? 0);
        }
        file.writeAsBytesSync(list);
      }
    }

    /* management all drivers notify */
    for (i = 0; i < TprDef.TPRMAXTCT; i++) {
      file = TprxPlatform.getFile(TprLibData().sysTib.tct[i].fds);

      if (!file.existsSync()) {
        continue;
      }

      sysNotify.mid = TprMidDef.TPRMID_SYSNOTIFY;
      sysNotify.length = 16 - 8; //tprsysnotify_tのサイズ16バイト tprcommon_tのサイズ8バイト
      sysNotify.mode = sts;
      strMid = sysNotify.mid.toString();
      for (int i = 0; i < strMid.length; i++) {
        list.add(int.tryParse(strMid.substring(i, i + 1)) ?? 0);
      }
      file.writeAsBytesSync(list);

      // #ifdef	DEBUG_UPS
      // if(sts == TPRTST_POWEROFF)
      // {
      // memset(log, 0, sizeof(log));
      // sprintf(log,"SysNofiySend...[fds=%d].....\n", SysTib.tct[i].fds );
      // TprLibLogWrite(0,TPRLOG_ERROR,0, log );
      // }
      // #endif

      // #ifdef	DEBUG_UT
      // g_print("SysNofiySend...[fds=%d].....\n", SysTib.tct[i].fds );
      // #endif

      // TODO:10152 履歴ログ 上で同じことをしている 必要？
      // TprLibData().sysTib.tct[i].fds.writeAsBytesSync(list);

      // #ifdef	DEBUG_UPS
      // if(sts == TPRTST_POWEROFF)
      // {
      // memset(log, 0, sizeof(log));
      // sprintf(log,"SysNofiySend:write error[fds=%d][errno=%d]\n", SysTib.tct[i].fds, errno );
      // TprLibLogWrite(0,TPRLOG_ERROR,0, log );
      // }
      // #endif
      // #ifdef	DEBUG_UT
      // g_print("SYSNOTIFY:write err\n");
      // #endif

      /* wait 60ms for processing SIGCHLD */
      if (sts == TprStatDef.TPRTST_POWEROFF) {
        Future.delayed(const Duration(microseconds: 60000));
      }
    }

    SysIdol.sysIdolBufInit();
  }

  // TODO:10152 履歴ログ 突貫対応
  /// sendSysNotifyを取得する関数
  static TprtStat sysNotifySendIsolate(int sts){
    TprtStat sysNotify = TprtStat(); /* message buffer */

    sysNotify.mid = TprMidDef.TPRMID_SYSNOTIFY;
    sysNotify.length = 16 - 8; //tprsysnotify_tのサイズ16バイト tprcommon_tのサイズ8バイト
    sysNotify.mode = sts;

    return sysNotify;
  }
}
