/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/lib/ean.dart';
import '../../../../inc/lib/jan_inf.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../../../lib/apllib/apllib_staffpw.dart';
import '../../../../lib/cm_jan/set_jinf.dart';
import '../../../../lib/cm_sys/cm_stf.dart';
import '../../../../regs/checker/rc_key.dart';
import '../../../../regs/checker/rcsyschk.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../component/w_trainingModeText.dart';
import '../../../controller/c_drv_controller.dart';
import '../../../language/l_languagedbcall.dart';
import '../../common/component/w_msgdialog.dart';
import '../controller/c_full_self_register_controller.dart';

/// フルセルフの店員を呼ぶ画面
/// todo:デザインは暫定
class FullSelfCallStaffPage extends StatelessWidget with RegisterDeviceEvent {
  FullSelfCallStaffPage({super.key, this.msgDialog}) {
    registrationEvent();
  }

  //訓練モード判定
  final bool isTrainingMode = RcSysChk.rcTROpeModeChk();

  /// この画面を閉じたときに表示するメッセージダイアログ
  final MsgDialog? msgDialog;

  /// コントローラー
  final FullSelfRegisterController controller = Get.find();

  /// スキャンしたバーコードをチェック中かどうか
  bool isCheckingData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Center(
        child: Stack(
          children: [
            Center(
              child: Obx(
                () => Text(
                  'l_full_self_call_attendant_guidance'.trns,
                  style: const TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: BaseFont.font30px,
                    fontFamily: BaseFont.familyDefault,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            kDebugMode
                ? SoundElevatedButton(
                    onPressed: () {
                      Get.back();
                      if (msgDialog != null) {
                        MsgDialog.show(msgDialog!);
                      }
                    },
                    callFunc: runtimeType.toString(),
                    child: const Text('バーコードスキャン'),
                  )
                : Container(),
            //訓練モードの時表示する半透明テキスト
            if (isTrainingMode) TrainingModeText(),
          ],
        ),
      ),
    );
  }

  /// キーコントローラ取得
  @override
  KeyDispatch? getKeyCtrl() {
    KeyDispatch keyCon = KeyDispatch(Tpraid.TPRAID_CHK);
    // 何の入力もなし.
    return keyCon;
  }

  ///スキャンコントローラ取得
  @override
  Function(RxInputBuf)? getScanCtrl() {
    return (data) async {
      AplLibStaffPw.staffPw.scanBuf = data.devInf.barData;
      scanStaff();
    };
  }

  /// 従業員コードを読み込み、問題があればエラーダイアログを表示
  /// 問題なければ店員呼び出し画面を閉じてメッセージダイアログを表示する
  Future<void> scanStaff() async {
    if (isCheckingData) {
      // 既に読みこんだものを処理中なら何もしない.
      return;
    }

    isCheckingData = true;
    await AplLibStaffPw.inputBufGet(1, 0);
    JANInf ji = JANInf();
    ji.code = AplLibStaffPw.staffPw.scanBuf;
    AplLibStaffPw.staffPw.scanBuf = "";
    await SetJinf.cmSetJanInf(ji, 0, 1);
    if (ji.type != JANInfConsts.JANtypeClerk &&
        ji.type != JANInfConsts.JANtypeClerk2 &&
        ji.type != JANInfConsts.JANtypeClerk3) {
      _showErrorMessageId(
          DlgConfirmMsgKind.MSG_BARFMTERR.dlgId); //バーコードフォーマットエラー
      isCheckingData = false;
      return;
    }
    if (ji.type == JANInfConsts.JANtypeClerk3) {
      int stfLen = await CmStf.apllibStaffCDInputLimit(2);
      int indataBuf =
          int.parse(ji.code.substring(Ean.ASC_EAN_13 - stfLen - 1, stfLen));
      if (indataBuf == 0) {
        TprLog().logAdd(AplLibStaffPw.staffPw.tid, LogLevelDefine.normal,
            "CallStaff Ji.Type=JANtype_CLERK_3 zero error code:${ji.code}");
        _showErrorMessageId(DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
        isCheckingData = false;
        return;
      }
    }
    int scanTyp = 1;
    int errNo = await AplLibStaffPw.readCheckStaff(scanTyp);
    if (errNo != 0) {
      TprLog().logAdd(AplLibStaffPw.staffPw.tid, LogLevelDefine.normal,
          "CallStaff scanStaff() barcode scan error error:$errNo  code:${ji.code}");
      MsgDialog.show(MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: errNo,
      ));
      isCheckingData = false;
      return;
    }
    // 正常な従業員コードが読み込まれた.
    TprLog().logAdd(AplLibStaffPw.staffPw.tid, LogLevelDefine.normal,
        "CallStaff scanStaff() barcode scan success ${ji.code}");
    Get.back();
    if (msgDialog != null) {
      MsgDialog.show(msgDialog!);
    }
  }

  /// エラーダイアログ表示処理（引数：エラーNo）
  void _showErrorMessageId(int errCode) {
    //すでにエラーダイアログが表示されたら、新しいerrダイアログを出せない
    if (MsgDialog.isDialogShowing) {
      return;
    }
    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: errCode,
      ),
    );
  }

  @override
  IfDrvPage getTag() {
    return IfDrvPage.callStaff;
  }
}
