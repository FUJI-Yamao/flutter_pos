/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter_pos/app/ui/page/search_registration/p_registration_scan.dart';
import 'package:get/get.dart';

import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../ui/page/common/component/w_msgdialog.dart';


class RckySrchreg {

  /// 検索登録画面を開く
  static Future<void> openSearchRegistrationPage(String title,
      FuncKey funcKey) async {
    //商品が選択された状態か判定
    if (RegsMem().tTtllog.getItemLogCount() > 0) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          dialogId: DlgConfirmMsgKind.MSG_REGSTART_ERROR.dlgId,
          type: MsgDialogType.error,
        ),
      );
    } else {
      Get.to(() => RegistrationScanPageWidget(title: title, funcKey: funcKey));
    }
  }
}