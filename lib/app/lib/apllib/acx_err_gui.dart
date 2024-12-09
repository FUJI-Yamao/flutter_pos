/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/L_AplLib.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../regs/checker/rcsyschk.dart';
import '../if_acx/acx_com.dart';

/// 関連tprxソース: acx_err_gui.c
class AcxErrGui {
  /// 処理概要：エラーコードより、該当ガイダンスデータを検索
  static TprMID tid = 0;

  /// 関連tprxソース: acx_err_gui.c - AcxErrGui_GuiDataChk
  static Future<int> acxErrGuiGuiDataChk(TprMID callTid) async {
    int acbSelect = AcxCom.ifAcbSelect();
    int ret = 0;
    tid = callTid;

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "acxErrGuiGuiDataChk()");
    acbSelect = AcxCom.ifAcbSelect();
    if ((acbSelect & CoinChanger.SST1) != 0) {
      ret = acxErrGuiGuiDataChkSst();
    } else if ((acbSelect & CoinChanger.ECS_X != 0)) {
      ret = acxErrGuiGuiDataChkSst();
    }
    //検索されたエラータイトルをログ出力
    if (ret == 1) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "     title [${AplLib.acxErrData.errTitle}]");
    }
    return ret;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: acx_err_gui.c - AcxErrGui_GuiDataChk_Sst
  static int acxErrGuiGuiDataChkSst() {
    return 0;
  }

  /// 関連tprxソース: acx_err_gui.c - AcxErrGui_StateEcsSet
  static void acxErrGuiStateEcsSet(TprMID callTid, StateEcs stateEcs) {
    String __FUNCTION__ = 'acxErrGuiStateEcsSet';
    int acbSelect;

    tid = callTid;

    acbSelect = AcxCom.ifAcbSelect();
    var select = acbSelect & CoinChanger.ECS_X;
    if (select == 0) {
      return;
    }

    AplLib.acxErrData.errCode = 0x0.toString();
    AplLib.acxErrData.unit = 0x0.toString();
    AplLib.acxErrData.unitLabel = 0x0.toString();
    AplLib.acxErrData.errCode = stateEcs.err.contentCode.toString();

    switch (stateEcs.err.unit) {
      case 1:
        AplLib.acxErrData.unit = 'ct';
        AplLib.acxErrData.unitLabel = LAplLib.APLLIB_ERRDSP_CTRL;
        break;
      case 2:
        AplLib.acxErrData.unit = 'b';
        AplLib.acxErrData.unitLabel = LAplLib.APLLIB_ERRDSP_BILL;

        break;
      case 3:
        AplLib.acxErrData.unit = 'c';
        AplLib.acxErrData.unitLabel = LAplLib.APLLIB_ERRDSP_COIN;

        break;
        AplLib.acxErrData.unit = '00';
        break;
    }

    TprLog().logAdd(tid, LogLevelDefine.normal,
        "$__FUNCTION__ : unit[$AplLib.acxErrData.unit] error_code[$AplLib.acxErrData.errCode]\n");

    return;
  }
}
