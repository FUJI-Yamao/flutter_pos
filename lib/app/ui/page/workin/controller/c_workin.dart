/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../regs/checker/rcky_brand.dart';
import '../../common/component/w_msgdialog.dart';
import '../../member/controller/c_member_call_controller.dart';
import '../../../enum/e_member_kind.dart';
import '../../register/controller/c_registerbody_controller.dart';
import '../../register/model/m_membermodels.dart';
import '../widget/w_dialog_content_preca_ref.dart';
import '../../../../inc/apl/image.dart';

/// 業務宣言画面用のコントローラ
class WorkinController extends MemberCallInputController {
  /// コンストラクタ
  WorkinController();

  /// 変更する会員種別
  MemberKind memberKind = MemberKind.rara;

  /// 顧客情報をRegisterBodyControllerに設定する。
  /// この時に会員種別を再設定する。
  @override
  void setMemberInfo() {
    debugPrint('WorkinController memberKind change to $memberKind');
    MemberInfo memberInfo = getMemberInfo();
    memberInfo.memberKind = memberKind;
    RegisterBodyController registerBodyCtrl = Get.find();
    registerBodyCtrl.setMemberType(memberInfo);
  }

  /// 業務宣言画面内のボタン押下時の処理
  Future<void> onWorkinButtonPressed(int titleId) async {
    debugPrint('_onWorkinButtonPressed $titleId click');
    if (titleId == ImageDefinitions.IMG_PRECA_IN) {
      // 会員情報をRARAプリカ会員に切り替え
      memberKind = MemberKind.raraPreca;
      setMemberInfo();
      // 1つ前の画面に戻る
      Get.back();

      // プリカ宣言押下時のバックエンドの処理の呼び出し
      await RcKyBrand.rcDetectPrecaIn();
    } else if (titleId == ImageDefinitions.IMG_HOUSE_IN) {
      // 会員情報をRARAハウス会員に切り替え
      memberKind = MemberKind.raraHouse;
      setMemberInfo();
      Get.back();

      // プリカ宣言押下時のバックエンドの処理の呼び出し
      await RcKyBrand.rcDetectHouseIn();
    } else if (titleId == ImageDefinitions.IMG_PRECA_REF) {
      // プリカ残高照会画面に遷移
      MsgDialog.show(MsgDialog.twoButtonDlgId(
        dialogId: DlgConfirmMsgKind.MSG_FREE_MESSAGE.dlgId,
        replacements: const ['お買い物を続けますか？'],
        type: MsgDialogType.info,
        leftBtnFnc: () {
          Get.back();
          Get.back();
        },
        leftBtnTxt: "はい",
        rightBtnFnc: () {
          Get.back();
        },
        rightBtnTxt: "いいえ",
        content: DialogContentPrecaRef(price: 10000),
      ));
    } else {
      debugPrint('unknown title click: $titleId');
    }
  }
}
