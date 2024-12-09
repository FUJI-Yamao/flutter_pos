/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../ui/page/change_coin/p_changecoinout_page.dart';
import '../../ui/page/common/component/w_msgdialog.dart';

///  関連tprxソース: rcky_out.c
///    // TODO:00001 日向  競合を防ぐために一時的にdummyで作成
class RckyOutDummy {
 
  /// 釣機払出画面を開く
  /// 関連tprxソース: rcky_out.c
  static void openCoutPage(String title, FuncKey key) {
    if (RegsMem().tTtllog.getItemLogCount() > 0) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          dialogId: DlgConfirmMsgKind.MSG_REGSTART_ERROR.dlgId,
          type: MsgDialogType.error,
        ),
      );
    } else {
      Get.to(() => ChangeCoinOutScreen(title: title, funcKey: key));
    }
  }

}
