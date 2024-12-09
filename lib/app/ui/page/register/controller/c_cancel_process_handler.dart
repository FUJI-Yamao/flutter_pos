/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_pos/app/inc/lib/if_th.dart';

import '../../../../../clxos/calc_api.dart';
import '../../../../../clxos/calc_api_data.dart';
import '../../../../../clxos/calc_api_result_data.dart';
import '../../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../regs/checker/rcfncchk.dart';
import '../../../../regs/checker/rcsyschk.dart';
import '../../../../regs/inc/rc_regs.dart';
import '../../../menu/register/m_menu.dart';
import '../../common/component/w_msgdialog.dart';
import '../../subtotal/controller/c_payment_controller.dart';
import '../../subtotal/controller/c_subtotal_controller.dart';
import 'c_registerbody_controller.dart';

/// 取消処理の管理
class CancelProcessHandler {

  /// windowsの場合
  Future<CalcResultPay> cancelWindows(CalcRequestParaPay requestData) async {
    return CalcResultPay(
        retSts: 0, errMsg: null, posErrCd: null, totalData: null, digitalReceipt: null);
  }

  /// 取消ができるかチェック
  void cancelProcessDialog() {
    // 商品登録がある・会員登録がある・返品モード
    if (RegsMem().tTtllog.getItemLogCount() > 0 || RcFncChk.rcCheckMbrInput() || RegsMem().refundFlag) {
      _showConfirmationDialog();
    }
    // 商品登録も会員登録もしていない
    else if (RegsMem().tTtllog.getItemLogCount() <= 0 && !RcFncChk.rcCheckMbrInput()) {
      _showErrorMessage("登録データがありません");
      return;
    }
  }

  /// 取消確認ダイヤログ
  Future<void> _showConfirmationDialog() async {
    if(await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      // 背景を小計画面まで戻す
      Get.until((route) =>  route.settings.name == '/subtotal');
    } else {
      // 背景を登録画面まで戻す
      SetMenu1.navigateToRegisterPage();
    }
    MsgDialog.show(
      MsgDialog.twoButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_CANCEL_CONF.dlgId,
        rightBtnFnc: () async {
          if(await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
            PaymentController paymentCtrl = Get.find();
            paymentCtrl.isPaymentSuccess.value = true;
          }
          await _cancelProcess();
        },
      ),
    );
  }

  /// 取消処理
  Future<void> _cancelProcess() async {
    final RegisterBodyController regBodyCtrl = Get.find();
    final subtotalCtrl = Get.put(SubtotalController());
    String callFunc = '_cancelProcess';
    // 前のダイアログをクリア
    Get.back();
    // 商品登録がない・返品モード
    if (RegsMem().tTtllog.getItemLogCount() == 0 && RegsMem().refundFlag) {
      _showSuccessMessage("取消しました");
      regBodyCtrl.delTabList();
      return;
    }

    try {
      late Mac_infoJsonFile macinfoJson;
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        macinfoJson = Mac_infoJsonFile();
        await macinfoJson.load();
      } else {
        RxCommonBuf pCom = xRet.object;
        macinfoJson = pCom.iniMacInfo;
      }

      CalcRequestParaPay requestData = CalcRequestParaPay(
        compCd: macinfoJson.system.crpno,
        streCd: macinfoJson.system.shpno,
        custCode: "",
        macNo: macinfoJson.system.macno,
        uuid: RegsMem().lastRequestData!.uuid,
        opeMode: null,
        refundFlag: null,
        refundDate: "",
        priceMode: null,
        posSpec: null,
        arcsInfo: ArcsInfo(),
      );

      requestData.itemList = RegsMem().lastRequestData!.itemList;
      requestData.opeMode = RegsMem().tHeader.ope_mode_flg;
      requestData.posSpec = 0;

      CalcResultPay result;
      if (Platform.isWindows) {
        result = await cancelWindows(requestData);
      } else {
        final stopWatch = Stopwatch();
        stopWatch.start();
        result = await CalcApi.cancel(requestData);
        stopWatch.stop();
        debugPrint(
            'Clxos CalcApi.cancel()  ${stopWatch.elapsedMilliseconds}[ms]');
      }


        if (result.retSts != null && result.retSts == 0) {
          debugPrint("cancel API ok");
          _showSuccessMessage("取消しました");

          // 二人制タワー側では取消レシートを発行しない
          if(await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) {
            // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
            await IfTh.printReceipt(await RcSysChk.getTid(), result.digitalReceipt, callFunc);
          }

          // 購入商品の明細をクリアする
          if (regBodyCtrl.purchaseData.isNotEmpty) {
            if(await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
              subtotalCtrl.initializationSubttlInfo(); // 小計情報初期化
              subtotalCtrl.changeDiscountValue(); // 小計情報更新
            } else {
              // タブ位置のデータを削除する
              regBodyCtrl.delTabList();
            }
          }
        } else {
          debugPrint('cancel API fail: ${result.errMsg}');
          _showAPIErrorMessage("取消に失敗しました");
        }
    } catch (e) {
      debugPrint('cancel process error: $e');
      _showProcessErrorMessage("取消処理中にエラーが発生しました");
    }
  }

  /// 登録データ無しエラーダイヤログ
  Future<void> _showErrorMessage(String message) async {
    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        dialogId: DlgConfirmMsgKind.MSG_TWOCNCT_ERR_CALLRESULT.dlgId,
        type: MsgDialogType.error,
      ),
    );
  }

  /// API通信エラーダイヤログ
  Future<void> _showAPIErrorMessage(String message) async {
    MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          dialogId: DlgConfirmMsgKind.MSG_CANCEL_FAILED.dlgId,
          type: MsgDialogType.error,
      ),
    );
  }

  /// 取消処理中エラーダイヤログ
  Future<void> _showProcessErrorMessage(String message) async {
    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        dialogId: DlgConfirmMsgKind.MSG_CANCEL_ERROR.dlgId,
        type: MsgDialogType.error,
      ),
    );
  }

  /// 取消成功ダイヤログ
  Future<void> _showSuccessMessage(String message) async {
    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        dialogId: DlgConfirmMsgKind.MSG_CANCELED.dlgId,
        type: MsgDialogType.info,
      ),
    );
  }

}