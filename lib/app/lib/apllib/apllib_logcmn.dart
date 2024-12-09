/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxregmem_define.dart';
import 'competition_ini.dart';

/// 実績に関するライブラリ関数
/// 関連tprxソース: AplLib_LogCmn.c
class AplLibLogCmn {

  /// ヘッダーログにデータをセットする
  /// 引数:[tid] タスクID
  /// 引数:[receiptNo] レシート
  /// 関連tprxソース: AplLib_LogCmn.c - AplLib_LogCmn_HeaderSet()
  static Future<void> aplLibLogCmnHeaderSet(int tid, int receiptNo) async {
    RegsMem mem = SystemFunc.readRegsMem();

    mem.tHeader.print_no =
        (await CompetitionIni.competitionIniGetPrintNo(tid)).value;
    if (receiptNo > 0) {
      mem.tHeader.receipt_no = receiptNo;
    } else {
      mem.tHeader.receipt_no =
          (await CompetitionIni.competitionIniGetRcptNo(tid)).value;
    }
  }
}
