/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../common/cls_conf/counterJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../menu/register/enum/e_register_page.dart';
import '../page/common/component/w_msgdialog.dart';
import '../page/store_open/p_store_open.dart';
import '../socket/client/customer_socket_client.dart';

/// キャッシャー側起動画面のコントローラー
class RegisterStartController extends GetxController {
  RegisterStartController(this.isBoot);

  /// 起動時フラグ
  final bool isBoot;

  // 初期処理
  @override
  void onInit() {
    super.onInit();

    if (isBoot) {
      // 3秒後に、次の画面に遷移
      Future.delayed(const Duration(seconds: 3), () async {
        // TODO:開設ステータスの確認
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
        late CounterJsonFile counterJson;
        if (xRet.isInvalid()) {
          counterJson = CounterJsonFile();
          await counterJson.load();
        } else {
          RxCommonBuf pCom = xRet.object;
          counterJson = pCom.iniCounter;
        }

        if (counterJson.tran.sale_date == '0000-00-00' || counterJson.tran.sale_date.isEmpty ) {
          // 開設画面へ
          Get.offNamed(RegisterPage.storeOpen.routeName);
        } else {
          // メニュー画面へ
          Get.offNamed(RegisterPage.mainMenu.routeName);
        }
      });
    }
  }

  /// メインメニュー画面に遷移する
  void toMainManu() {

    // TODO:客側画面をロゴ表示にする。ただし客側画面が取引中でないことを確認する


    MsgDialog.show(
      MsgDialog.twoButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_BACK_MAINMENU.dlgId,
        rightBtnFnc: () {
          // ダイアログを閉じる
          Get.back();
          // 客側画面をロゴ表示にする
          CustomerSocketClient().sendLogoDisplay();
          // レジ側画面でメインメニュー画面を表示する
          Get.back();
        },
        leftBtnTxt: 'いいえ',    // 「はい」と「いいえ」を表示する
      ),
    );
  }
}
