/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_gtkutil.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_mem.dart';

/// 関連tprxソース: rcmg_dsp.c
class RcmgDsp {
  static	DspInfo	inpDsp = DspInfo();
  static	DspInfo	inpDsp2 = DspInfo();

  /// 商品リアル問合せの結果を返すチェック関数
  /// 戻り値　　：1:売価のみを入力する
  ///           2:分類コード 及び 売価を入力する
  ///           3:売価のみを入力する0=PLU  1=会員
  /// 関連tprxソース: rcmg_dsp.c - rc_NonPluDsp_Chk
  static int rcNonPluDspChk() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.stat.pluFlrdFlg);
  }

  /// 関連tprxソース: rcmg_dsp.c - rcChk_MgNonPlu_Dsp
  static Future<int> rcChkMgNonPluDsp(int noLogFlg) async {
    if ((inpDsp.Window != null) || (inpDsp2.Window != null)) {
      if (noLogFlg == 0) {  //roopしている箇所ではログ出力させない
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcmg_dsp.dart : Mg NonPlu Dsp Show");
      }
      return (1);
    }
    return (0);
  }
}
