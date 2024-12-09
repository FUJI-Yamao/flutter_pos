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
import '../../inc/sys/tpr_type.dart';
import '../../tprlib/tprlib_generic.dart';
import '../cm_sys/cm_cksys.dart';
import 'if_smscl.dart';

/// 関連tprxソース: smscl_com.c
class SmsclCom {
  /// 関連tprxソース: smscl_com.c - w_flag
  static int wFlag = 0;

  /// SC基板制御コマンド送信関数
  /// 関連tprxソース: smscl_com.c - if_sc_Transmit
  static Future<int> ifScTransmit(
      TprTID src, int inOut, int len, String sendData, int dest) async {
    TprMsgDevReq2 sendBuf = TprMsgDevReq2();
    String hMyPipe = '';
    TprMID mid;
    TprDID tid;
    int lLimit;
    int boxType = CmCksys.cmCPUBoxChk();

    // CPUBoxのタイプが一体型の場合
    if (boxType != 0) {
      dest = 1;

      // LED6の制御を抑制
      if ((sendData[0] == '\x57') &&
          (sendData[1] == '\x69') &&
          (sendData[2] == '\x36')) {
        return SmScl.SMSCL_NORMAL.value;
      }

      lLimit = 0;
      while ((wFlag != 0) && (lLimit < 5)) {
        lLimit++;
        await Future.delayed(const Duration(microseconds: 10000));
      }
      wFlag = 1;
    }

    if (dest != 0) {
      mid = tid = TprDidDef.TPRDIDSGSCALE4;
    } else {
      mid = tid = TprDidDef.TPRDIDSGSCALE3;
    }

    // MIDからファイルパス取得
    /* Drvice No. Get */
    hMyPipe = TprLibGeneric.tprLibFindFds(mid);
    if (hMyPipe.isEmpty) {
      if (boxType != 0) {
        wFlag--;
      }
      return SmScl.SMSCL_SENDERR.value;
    } else {
      sendBuf.tid = tid; /* device ID */
    }

    sendBuf.mid =
        TprMidDef.TPRMID_DEVREQ; /* an area of the message receiving */
    // 未使用のためコメントアウト
    // sendBuf.length = sizeof(tprmsgdevreq2_t) -
    //     sizeof(tprcommon_t) -
    //     1024 +
    //     len; /* extention data length */

    sendBuf.src = src; /* Spec-N001 */
    sendBuf.io = inOut; /* input or output */
    sendBuf.result = 0; /* device I/O result */
    sendBuf.datalen = 0; /* datalen & sequence No. */

    sendBuf.dataStr = sendData;

    /* Send the request */
    File file = File(hMyPipe);
    try {
      file.writeAsStringSync(json.encode(sendBuf.toJson()));
      if (boxType != 0) {
        wFlag--;
        await Future.delayed(const Duration(microseconds: 30000));
      }
      return SmScl.SMSCL_NORMAL.value;
    } catch (e) {
      if (boxType != 0) {
        wFlag--;
      }
      return SmScl.SMSCL_SENDERR.value;
    }
  }
}
