/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos.dart';
import 'package:flutter_pos/app/regs/checker/rcky_plu.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:get/get.dart';
import '../../if/if_drv_control.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/manual_input/component/w_mglogin_dialogpage.dart';
import '../../ui/page/manual_input/controller/c_keypresed_controller.dart';
import '../../ui/page/manual_input/controller/c_mglogininput_controller.dart';
import '../../ui/page/register/controller/c_registerbody_controller.dart';
import '../../ui/socket/client/customer_socket_client.dart';
import '../inc/rc_regs.dart';
import '../spool/rsmain.dart';

/// 分類登録情報
class ManualSmlCls {
  /// 分類コード
  String clsNo = "";

  /// 分類登録時の金額
  int clsVal = 0;

  /// 分類名称
  String itemName = "";

  ManualSmlCls({
    required this.clsNo,
    required this.clsVal,
    required this.itemName
  });
}

///　小分類処理.
/// 関連tprxソース:rcky_mg.c
class RcKyMg {

  /// 小分類手入力用データ
  static ManualSmlCls? manualSmlCls;

  /// 客表画面が開かれている場合はtrue
  static bool customerScreen = true;

  /// 分類コード
  static const int maxClassCodeLength = 6;

  /// 関連tprxソース:rcky_mg.c - rcKyMg
  static void rcKyMg() {
    debugPrint("call rcKyMg");
    debugPrint("分類登録ダイアログ called");

    debugPrint("******** MGLoginPageManager.isOpen: ${MGLoginPageManager.isOpen()}");
    if (MGLoginPageManager.isOpen()) {
      debugPrint("******** 分類登録ダイアログは既に開かれています");
      return;
    }

    final  keyPressCtrl = Get.find<KeyPressController>();
    String isClickedKeyValue = keyPressCtrl.funcKeyValue.value;

    String? mgName;
    if (int.tryParse(isClickedKeyValue) != null) {
      int index = int.parse(isClickedKeyValue);
    }
    /// 手入力エリアがオープンしている場合は小分類コードを設定して分類登録画面を開く
    if (keyPressCtrl.isMKInputMode.value) {
      String isClickedKeyValue = keyPressCtrl.funcKeyValue.value;

      /// 分類登録画面を開く際に手入力エリアをクリアする
      keyPressCtrl.resetKey();

      int digitChk = rcKyMgDigitChk(isClickedKeyValue);
      if (digitChk == 0) {
        Get.to(() => MGLoginPage(initialMGIndex: isClickedKeyValue, title: MGTitleConstants.mgTitle));
      } else {
        MsgDialog.show(MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: digitChk,
        ));
      }
    }
    Get.to(() => MGLoginPage(initialMGIndex:keyPressCtrl.funcKeyValue.value, title: MGTitleConstants.mgTitle));
  }

  /// 処理概要：小分類コード桁数チェック
  /// パラメータ：int String　入力された分類コード
  /// 戻り値：int エラーコード
  static int rcKyMgDigitChk(String inputClassCode) {
    int result = 0;

    /// 金額の桁数チェックは金額キーのキーオプションを参照する
    if (inputClassCode
        .toString()
        .length > maxClassCodeLength) {
      result = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
    }
    return result;
  }
}
