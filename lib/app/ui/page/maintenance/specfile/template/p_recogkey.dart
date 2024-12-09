/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../inc/sys/tpr_dlg.dart';
import '../../../../../sys/recogkey/recogkey.dart';
import '../../../../colorfont/c_basecolor.dart';
import '../../../../component/w_btn.dart';
import '../../../../component/w_divider.dart';
import '../../../../component/w_list_item.dart';
import '../model/e_speckind.dart';
import '../component/w_savechangealertmsgdialog.dart';
import '../../../common/component/w_msgdialog.dart';
import '../controller/c_recogkey_controller.dart';
import 'basepage/p_settingbase.dart';

/// 承認キーページ
class RecogekeyPageWidget extends SettingBasePage {
  ///コンストラクタ
  RecogekeyPageWidget({
    Key? key,
    required String title,
    required super.currentBreadcrumb,
  }) : super(SpecKind.recogkey, key: key, title: title) {
    controller = Get.put(RecogkeyController(title: title, breadcrumb: breadcrumb));
  }

  /// コントローラー
  late final RecogkeyController controller;

  /// 「メンテナンスを終了」ボタン、もしくは、戻るボタンを押したときの処理
  @override
  Future<bool> onEndMaintenancePage() async {
    return controller.onEndMaintenancePage();
  }
///「保存」ボタン処理
  @override
  void onSave() {
    controller.saveChange();
  }

  /// ページのボディを構築
  @override
  Widget body(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: BaseColor.maintainBaseColor,
      child: Container(
        width: 860.w,
        height: 570.h,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             Padding(
              padding: EdgeInsets.only(
                top: 10.h,
              ),
              child: const Text(
                '承認キーと承認機能を入力してください',
                style: TextStyle(
                    fontSize: BaseFont.font28px,
                    color: BaseColor.someTextPopupArea,
                    fontFamily: BaseFont.familyDefault),
                textAlign: TextAlign.center,
              ),
            ),
            Obx(
              () => Center(
                child: Column(
                  children: [
                    for (var index = 0;
                        index < controller.lstLblTxtsettings.length;
                        index++)
                      SizedBox(
                          width: controller.lstLblTxtsettings[index].width,
                          child: Flex(
                              mainAxisAlignment: MainAxisAlignment.start,
                              direction: Axis.vertical,
                              children: [
                                ListItem(
                                  lblsetting: controller
                                      .lstLblTxtsettings[index].lblsetting,
                                  txtsetting: controller
                                      .lstLblTxtsettings[index].txtsetting,
                                  btnsetting: controller
                                      .lstLblTxtsettings[index].btnsetting,
                                  axis:
                                      controller.lstLblTxtsettings[index].axis,
                                  flex:
                                      controller.lstLblTxtsettings[index].flex,
                                  containsSwitch: controller
                                      .lstLblTxtsettings[index].containsSwitch,
                                ),
                                const ListDivider()
                              ]))
                  ],
                ),
              ),
            ),
            GradientBorderButton(
              width: 220.w,
              height: 60.h,
              text: 'l_recog_data_clr'.trns,
              fontSize: BaseFont.font22px,
              fontFamily: BaseFont.familyDefault,
              onTap: () async {
                bool? result =
                    await Get.dialog<bool>(const SaveChangeAlertMsgDialog(
                  title: '確認',
                  msgList: ['承認データをクリアします。', 'よろしいですか？'],
                  buttonText1: 'いいえ',
                  buttonText2: 'はい',
                ));
                if (result == true) {
                  Recogkey recogkey = Recogkey();
                  DlgConfirmMsgKind err = await recogkey.recogkeyClrFuncMain();
                  if (err == DlgConfirmMsgKind.MSG_RECOG_OK) {
                    MsgDialog.show(
                      MsgDialog.singleButtonDlgId(
                        type: MsgDialogType.info,
                        dialogId: DlgConfirmMsgKind.MSG_RECOG_OK.dlgId,
                      ),
                    );

                  } else {
                    MsgDialog.show(
                      MsgDialog.singleButtonDlgId(
                        type: MsgDialogType.error,
                        dialogId: DlgConfirmMsgKind.MSG_RECOGERR2.dlgId,
                      ),
                    );

                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
