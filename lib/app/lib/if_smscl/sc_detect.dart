/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/apl/compflag.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_type.dart';
import 'if_smscl.dart';
import 'smscl_com.dart';

/// 関連tprxソース: if_detect.c
class ScDetect {
  /// 関連tprxソース: if_detect.c - if_sc_Detect
  static Future<int> ifScDetect(TprTID src, String cmd) async {
    if (CompileFlag.PPSDVS) {
      int errCode;
      String sendBuf = '';
      int len = 0;

      sendBuf = IfSmScl.SMSCL_CMD_READ;
      sendBuf = cmd;

      errCode = await SmsclCom.ifScTransmit(
          src, TprDidDef.TPRDEVOUT, len, sendBuf, 1);

      return errCode;
    } else {
      return SmScl.SMSCL_NORMAL.value;
    }
  }
}
