/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/fnc_code.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../regs/checker/rc_ewdsp.dart';
import '../../regs/inc/rc_mem.dart';
import '../../regs/inc/rc_regs.dart';
import '../../ui/page/common/component/w_msgdialog.dart';

/// Confirm Electric Journal Display & Printing
/// 関連tprxソース:rept_ejconf.c
class ReptEjConf {

  static Future<void> rcErr(String functionName, int errNo) async {
    await rcErr2(functionName, errNo);
  }

  /// 登録中かチェックする（VEGA機専用）
  /// 関連tprxソース: rept_ejconf.c - rcCheck_Registration
  /// 引数：なし
  /// 戻値：1:登録中  0:登録中でない（精算終了）
  static bool rcCheckRegistration() {
    AcMem cMem = SystemFunc.readAcMem();

    return (!((!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) &&
        (RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId]))));
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:rept_ejconf.c - rcmbrChkStat
  static int rcmbrChkStat() {
    return 0;
  }

  /// 関連tprxソース:rept_ejconf.c - rcErr2
  static Future<void> rcErr2(final String call_func, int err_no) async {
    DlgParam param = DlgParam();

    param.erCode    = err_no;
    param.dialogPtn = DlgPattern.TPRDLG_PT4.index;
    param.title      = "エラー"; // MSG_TTL_ERR;

    // TODO:仮実装　TprLibDlg() => TprLibDlg.c  TprLibDlg2(&param) が本来コールするもの
    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        dialogId: param.erCode, type: MsgDialogType.error,
          footerMessage: await RcEwdsp.rcMakeUt1Msg(param.erCode),
          btnFnc: () async {
            Get.back();
        }
      ),
    );
  }

  /// 関連tprxソース:rept_ejconf.c - rc_Assort_DataSet(int)
  //実装は必要だがARKS対応では除外
  static  void rcAssortDataSet(int){
    return;
  }

}
