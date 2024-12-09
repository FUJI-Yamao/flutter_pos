/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../../inc/sys/tpr_dlg.dart';
import '../../../../../sys/recogkey/recogkey.dart';
import '../../../common/component/w_msgdialog.dart';

import '../model/m_specfile.dart';
import 'package:get/get.dart';

import '../template/p_recogkey_confirm.dart';
import 'c_specfile_controller.dart';

/// 承認キーコントローラー
class RecogkeyController extends SpecfileControllerBase {
  RecogkeyController({
    required super.title,
    required super.breadcrumb,
  });

  /// 項目一覧データを作成する.
  @override
  Future<void> createRow() async {
    int i = 0;
    await createDisplayableData();
    for (var element in dispRowData) {
      await createLabelSettingData(element, i);
      i++;
    }
  }

  @override
  dynamic getNowSettingValue(SpecFileDispRow element) {
    // 初期値なし.
    return "";
  }

  /// JSON → スペックファイル変数作成
  Future<void> createDisplayableData() async {
    dispRowData.add(const SpecFileDispRow(
      title: "承認キー",
      description: "承認キー設定　　　　\n　123467890AB",
      editKind: SpecFileEditKind.hexInput,
      setting: StringInputSetting(12, 12),
    ));

    dispRowData.add(const SpecFileDispRow(
      title: "承認機能",
      description: "承認機能　　\n 12345678",
      editKind: SpecFileEditKind.hexInput,
      setting: StringInputSetting(8, 8),
    ));
  }

  //変更チェック関数
  @override
  void afterChange(SpecFileDispRow row, String value) {
    isChangedFlg = false;
  }

  /// 保存ボタンの処理.
  @override
  Future<void> saveChange({bool dspConfirmDlg = true}) async {
    //入力値を取得
    String inputKey = lstLblTxtsettings[0].txtsetting.value.text;
    String inputMakeData = lstLblTxtsettings[1].txtsetting.value.text;

    Recogkey recogKeyInstance = Recogkey();
    var result =
        await recogKeyInstance.recogkeyConfirmButton(inputKey, inputMakeData);
    var error = result.$1;
    var recogkeySaveDes = result.$2;

    if (error == RecogkeyError.INPUT_ERROR) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          //	"承認キーが不正です。\n再度入力して下さい。"
          dialogId: DlgConfirmMsgKind.MSG_APPROVE_ERR.dlgId,
        ),
      );

    } else if (error == RecogkeyError.ENTRY_DATA_NO_MUCH) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          //	"承認キーが不正です。\n再度入力して下さい。"
          dialogId: DlgConfirmMsgKind.MSG_SCALE_UPRC_OUT_RANGE.dlgId,
        ),
      );

    } else if (error == RecogkeyError.NONE) {
      ///すべてのチェック通った場合、機能リストと実行ボタンを表示
      int intputBiValue = int.parse(inputMakeData, radix: 16);

      ///承認キー設定画面で[保存]ボタン、承認キー設定_機能一覧画面を表示する
      Get.to(() => RecogekeyConfirmPageWidget(
        title: '承認機能確認',
        currentBreadcrumb: breadcrumb,
        bi: intputBiValue,
        recogkeySaveDes: recogkeySaveDes,
      ));
      isChangedFlg = false;
    }
  }
}
