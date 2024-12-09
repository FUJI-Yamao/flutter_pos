/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';

import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../tprlib/tprlib_generic.dart';

class IfDetectI {
  /// 関連tprxソース: if_detect_i.c - if_detect_intr
  /// @return 0:正常終了, -1:異常終了
  static int ifDetectIntr(String cmd, String data) {
    TprMsgDevReq_t req = TprMsgDevReq_t();
    int txLeng = 0;
    String fds = ""; // もともとはファイルディスクリプタだが、ここではファイルパスを扱う
    int res = 0;

    req.mid = TprMidDef.TPRMID_DEVREQ;
    // tx_leng = sizeof(tprmsgdevreq_t) - sizeof(tprcommon_t) - sizeof(req.data) + 2;
    req.length = txLeng;

    req.tid = TprDidDef.TPRDIDDETECT2;
    /*** kari ***/

    req.io = TprDidDef.TPRDEVOUT;
    req.datalen = 0;
    req.data[0] = cmd;
    req.data[1] = data;
    fds = TprLibGeneric.tprLibFindFds(req.tid);
    if (fds.isEmpty) {
      res = -1;
    } else {
      // json形式でクラス内変数をファイルに保存
      File file = File(fds);
      file.writeAsStringSync(json.encode(req.toJson()));
    }
    return res;
  }
}
