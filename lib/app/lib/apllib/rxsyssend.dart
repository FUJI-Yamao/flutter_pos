/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import '../../common/environment.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_pipe.dart';
import '../../inc/sys/tpr_stat.dart';

/// 関連tprxソース: rxsyssend.c
class RxSysSend {
  /// 関連tprxソース: rxsyssend.c - rxUpsFailChk
  static void rxUpsFailChk(int mode) {
    TprMsgDevReq msg = TprMsgDevReq();
    int ret = 0;
    File fds;
    RandomAccessFile raFile;

    // open pipe
    try {
      fds = TprxPlatform.getFile(TprPipe.TPRPIPE_UPS);
      raFile = fds.openSync();
    } catch (e) {
      TprLog().logAdd(0, LogLevelDefine.error, "rxUpsFailChk open pipe fail");
      return;
    }

    msg.mid = TprMidDef.TPRMID_DEVACK;
    msg.result = TprStatDef.TPRTST_POWEROFF;
    msg.io = mode; // 1:shutdown 0:reboot
    msg.length = 1044 - 8; // sizeof(tprmsgdevnotify_t)-sizeof(tprcommon_t);

    try {
      String strMsg = msg.mid.toString() +
          msg.result.toString() +
          msg.io.toString() +
          msg.length.toString();
      List<int> list = strMsg.codeUnits;
      fds.writeAsBytesSync(list);
    } catch (e) {
      TprLog().logAdd(0, LogLevelDefine.error, "rxUpsFailChk write fail");
    }

    raFile.closeSync();
    return;
  }
}
