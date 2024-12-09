/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../cm_sys/cm_cksys.dart';
import '../if_smscl/if_smscl.dart';
import '../if_smscl/sc_detect.dart';
import 'if_detect_i.dart';

/// 関連tprxソース: if_detect.c
class IfDetect {
  /// 関連tprxソース: if_detect.c - if_detect_disable
  /// @return 0:正常終了
  /// @return -1:異常終了
  static Future<int> ifDetectDisable() async {
    int res = 0;

    if (await CmCksys.cmCheckAfterWeb2300() == 1) {
      if (await ScDetect.ifScDetect(0, IfSmScl.SC_CMD_DETECT_DISABLE) !=
          SmScl.SMSCL_NORMAL.value) {
        res = -1;
      }
    } else {
      res = IfDetectI.ifDetectIntr(DetectCommand.CMD_DISABLE.value, "\x00");
    }
    return res;
  }
}
