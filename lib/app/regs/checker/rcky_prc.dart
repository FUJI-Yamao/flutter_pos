/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/regs/checker/rckyrmod.dart';
import 'package:flutter_pos/app/ui/controller/c_common_controller.dart';
import 'package:get/get.dart';

import '../../common/dual_cashier_util.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/manual_input/component/w_mglogin_dialogpage.dart';
import '../../ui/page/manual_input/controller/c_keypresed_controller.dart';
import '../../ui/page/manual_input/controller/c_mglogininput_controller.dart';
import '../../ui/page/price_check/controller/c_price_check_controller.dart';
import '../../ui/page/register/controller/c_registerbody_controller.dart';
import '../../ui/page/subtotal/controller/c_subtotal_controller.dart';

/// 金額キー
/// 関連tprxソース: rcky_prc.c
class RcKyPrc {
  /// 処理概要：金額キーが押された場合の処理
  ///  関連tprxソース: rcky_mul.c - rcKyPrc
  static void rcKyPrc() async {
    debugPrint("call rcKyPrc");
    debugPrint("KY_PRCMGLoginPage caled");

    debugPrint("******** MGLoginPageManager.isOpen: ${MGLoginPageManager.isOpen()}");
    if (MGLoginPageManager.isOpen()) {
      debugPrint("******** 分類登録ダイアログは既に開かれています");
      return;
    }

    final  keyPressCtrl = Get.find<KeyPressController>();
    String initalPrice = keyPressCtrl.funcKeyValue.value;

    Get.to(() => MGLoginPage(initialPrice: initalPrice, title: MGTitleConstants.mgTitle));

    /// 手入力エリアがオープンしている場合は金額を設定して分類登録画面を開く
    if (keyPressCtrl.isMKInputMode.value) {
      String initalPrice = keyPressCtrl.funcKeyValue.value;

      /// 分類登録画面を開く際に手入力エリアをクリアする
      keyPressCtrl.resetKey();

     int digitChk = rcKyPriceDigitChk(initalPrice);
     if (digitChk == 0) {
        Get.to(() => MGLoginPage(initialPrice: initalPrice, title: MGTitleConstants.mgTitle));
      } else {
        MsgDialog.show(MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: digitChk,
        ));
      }
    }
  }

  /// 処理概要：金額桁数チェック
  /// パラメータ：int String　入力された金額
  /// 戻り値：int エラーコード
  static int rcKyPriceDigitChk(String inputPrice) {
    int result = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      result = DlgConfirmMsgKind.MSG_MEMORYERR.dlgId;
    }
    return result;
  }

  /// 価格確認キー押下処理
  static void rcKyPrePrc() async {
    try {
      RegisterBodyController registerBodyCtrl = Get.find();
      CommonController commonCtrl = Get.find();
      KeyPressController keyPressCtrl = Get.find();

      PriceCheckController priceCheckCtrl = Get.find();
      // 価格確認画面非表示で価格確認モードの場合は価格確認モードを終了する
      if (!priceCheckCtrl.isPrcChkView.value && registerBodyCtrl.prcChkMode.value) {
        await priceCheckCtrl.endPrcChkStatus();
        return;
      }

      if (!registerBodyCtrl.prcChkMode.value) {
        if (keyPressCtrl.isMKInputMode.value) {
          // 置数中エラー
          MsgDialog.show(MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: DlgConfirmMsgKind.MSG_INPUTNUM.dlgId,
          ));
          return;
        }
        // 小計画面の場合
        if (commonCtrl.onSubtotalRoute.value) {
          SubtotalController subtotalCtrl = Get.find();
          if (await DualCashierUtil.is2Person() && await DualCashierUtil.isDualCashier(commonCtrl.isDualMode.value)) {
            if (subtotalCtrl.receivedAmount.value == 0) {
              await priceCheckCtrl.startPrcChkStatus();
              return;
            }
            else {
              MsgDialog.show(MsgDialog.singleButtonDlgId(
                type: MsgDialogType.error,
                dialogId: DlgConfirmMsgKind.MSG_NG_SPRIT_REGISTRATION_BACK.dlgId,
              ));
              return;
            }
          }
          int errNo = await RcKyRmod.rcKyRmod();
          if (errNo != 0) {
            // rcKyRmod()でrcErrをCALLしてるのでここでは何もしない
          } else {
            // 登録画面にuntil
            await priceCheckCtrl.startPrcChkStatus();
          }
          return;
        }
        else if (commonCtrl.onRegisterRoute.value) {
          await priceCheckCtrl.startPrcChkStatus();
          return;
        }
      }

      priceCheckCtrl.showOperationErrorDialog();
    } catch(_){
      MsgDialog.show(MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: DlgConfirmMsgKind.MSG_OPEBUSYERR_KEYSTATUS.dlgId,
        replacements: const ['価格確認'],
      ));
    }
  }

  /// 処理概要：金額制限チェック
  /// パラメータ：int inputPrice　入力された金額
  ///         　int priceLimit　金額制限値(キーオプションの値)
  /// 戻り値：int 0  制限内
  ///      　int 1   制限超過
  /// 関連tprxソース: rcky_prc.c - rcKy_PriceLimit_Chk
  static int rcKyPriceLimitChk(int inputPrice, int priceLimit) {
    if (priceLimit == 0) {
      /* 制限値が0の場合は制限しない */
      return 0;
    }
    if (inputPrice >= priceLimit * 1000) {
      /* 制限値以上の場合をチェック */
      return 1;
    }
    return 0;
  }
}