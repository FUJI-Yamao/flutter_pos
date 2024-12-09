/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:get/get.dart';

import '../../../../common/cmn_sysfunc.dart';
import '../../../../common/environment.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../lib/apllib/apllib_auto_staffpw.dart';
import '../../../../lib/cm_sound/sound_def.dart';
import '../../../../regs/checker/rc_sound.dart';
import '../../../../regs/checker/regs.dart';
import '../../../enum/e_screen_kind.dart';
import '../../../menu/customer/e_customer_page.dart';
import '../../../menu/register/enum/e_register_page.dart';
import '../../../socket/model/customer_socket_model.dart';
import '../../../socket/server/customer_socket_server.dart';
import '../../common/component/w_msgdialog.dart';
import '../../staff_open/enum/e_openclose_enum.dart';
import '../../staff_open/w_open_close_page.dart';
import '../page/p_full_self_maintenance_page.dart';
import '../page/p_full_self_register_page.dart';

/// フルセルフのスタート画面のコントローラー
class FullSelfStartController extends GetxController {
  /// コンストラクタ
  FullSelfStartController(this.autoStaffInfo);

  /// 自動従業員情報
  final AutoStaffInfo autoStaffInfo;

  @override
  Future<void> onInit() async {
    super.onInit();
    await RegistInitData.main();
  }

  @override
  void onReady() {
    super.onReady();

    // ガイダンス音声番号から音声を出力
    RcSound.playFromSoundNum(
      soundNum: SoundDef.guidanceFullSelfStartNumber
    );
  }

  @override
  void onClose() {
    super.onClose();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    
    /// 従業員クローズ
    if (pCom.iniMacInfo.select_self.kpi_hs_mode != 2) {
      AplLibAutoStaffPw.closeStaff(autoStaffInfo);
    }
  }

  /// 商品登録画面に遷移する
  Future<void> toRegister() async {
    // ガイダンス音声の停止
    RcSound.stop();

    // 商品登録画面に遷移する
    await Get.to(() => FullSelfRegisterPage());

    // ガイダンス音声番号から音声を出力
    RcSound.playFromSoundNum(
      soundNum: SoundDef.guidanceFullSelfStartNumber,
    );
  }

  /// フルセルフのメンテナンス画面に遷移
  void toMaintenance() {
    // ガイダンス音声の停止
    RcSound.stop();

    MsgDialog.show(
      MsgDialog.twoButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_SG_MENTENANSE.dlgId,
        rightBtnFnc: () {
          Get.back();
          Get.to(() => FullSelfMaintenancePage());
        },
        leftBtnTxt: 'いいえ', // 「はい」と「いいえ」を表示する
      ),
    );
  }

  /// メインメニュー画面に戻る
  void toMainManu() {
    // ガイダンス音声の停止
    RcSound.stop();

    MsgDialog.show(
      MsgDialog.twoButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_BACK_MAINMENU.dlgId,
        rightBtnFnc: () {
          Get.back();
          if (EnvironmentData().screenKind == ScreenKind.register) {
            // レジ側の場合は、offNamed で、メニュー画面へ
            Get.offNamed(RegisterPage.mainMenu.routeName);
          } else {
            // 客側画面をロゴ表示にする
            Get.offNamed(CustomerPage.logo.routeName);

            // レジ側画面でメインメニュー画面を表示する
            CustomerSocketServer.sendMainMenu();
          }
        },
        leftBtnTxt: 'いいえ', // 「はい」と「いいえ」を表示する
      ),
    );
  }

  /// セミセルフの場合のメインメニュー画面に戻るメソッド
  void semiSelftoMainManu() {
    // ガイダンス音声の停止
    RcSound.stop();

    MsgDialog.show(
      MsgDialog.threeButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_BACK_MAINMENU.dlgId,
        //はいボタン
        leftBtnFnc: () {
          Get.back();
          if (EnvironmentData().screenKind == ScreenKind.register) {
            // レジ側の場合は、offNamed で、メニュー画面へ
            Get.offNamed(RegisterPage.mainMenu.routeName);
          } else {
            // 客側画面をロゴ表示にする
            Get.offNamed(CustomerPage.logo.routeName);

            // レジ側画面でメインメニュー画面を表示する
            CustomerSocketServer.sendMainMenu();
          }
        },
        //いいえボタン
        middleBtnFnc: () {
          Get.back();
        },
        rightBtnFnc: () {
          //TODO: 休止ボタン現状非動作
        },
      ),
    );
  }

  /// セミセルフのメンテナンス操作画面に遷移
  void semiSelftoMaintenance() {
    // ガイダンス音声の停止
    RcSound.stop();

    MsgDialog.show(
      MsgDialog.twoButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_BACK_MAINMENU.dlgId,
        leftBtnFnc: () {
          Future.delayed(Duration.zero, () {
            Get.dialog(
              StaffOpenClosePage(labels: const [
                OpenCloseInputFieldLabel.codeNum,
                OpenCloseInputFieldLabel.password
              ]),
              //　ダイアログ外タップで閉じない
              barrierDismissible: false,
            ).then((success) {
              if (success) {
                Get.to(() => FullSelfMaintenancePage());
              } else {
                Get.back();
              }
            });
          });
        },
        leftBtnTxt: 'はい',
        rightBtnTxt: 'いいえ',
        rightBtnFnc: () {
          Get.back();
        },
      ),
    );
  }
}
