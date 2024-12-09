/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../common/component/w_msgdialog.dart';

/// モードの種類
enum ModeKind {
  normal('通常／対面モード', 0),
  fulSelf('フルセルフモード', 1),
  adjustment('精算機モード', 2);

  /// 各モードの名前
  final String modeName;
  /// 各モードのID
  final int modeID;

  /// 選択されているモードのIDに応じてモードの名前を返す
  static String getModeName(int selectedModeID) {
    ModeKind? modeKind = values.firstWhereOrNull((e) => e.modeID == selectedModeID);
    return modeKind?.modeName ?? '';
  }

  const ModeKind(this.modeName, this.modeID);
}

/// モード切替画面のコントローラー
class ModeChangeController extends GetxController {

  /// ラジオボタンの現在選択されている値
  RxInt selectedModeID = (-1).obs;

  @override
  Future<void> onReady() async {
    await _readMacInfoJson();
  }

  /// 設定ファイルから設定値を取得する
  Future<void> _readMacInfoJson() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: DlgConfirmMsgKind.MSG_SYSERR.dlgId,
        ),
      );
      return;
    }
    RxCommonBuf pCom = xRet.object;

    // MacInfoJsonFileの読み込み
    Mac_infoJsonFile macInfoJsonFile = pCom.iniMacInfo;

    selectedModeID.value = macInfoJsonFile.select_self.kpi_hs_mode;
  }

  /// モードを変更する
  Future<void> changeMode(ModeKind modeKind) async {
    DlgConfirmMsgKind dlgConfirmMsgKind = DlgConfirmMsgKind.MSG_NONE;

    while (true) {
      // 共有メモリポインタの取得
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        dlgConfirmMsgKind = DlgConfirmMsgKind.MSG_SYSERR;
        break;
      }
      RxCommonBuf pCom = xRet.object;

      // MacInfoJsonFileの読み込み
      try {
        // ファイル更新用のインスタンス
        Mac_infoJsonFile macInfoJsonForFileUpdate = Mac_infoJsonFile();
        await macInfoJsonForFileUpdate.load();

        // 各モードのIDを代入、0なら対面、1ならフルセルフ、2なら精算機
        macInfoJsonForFileUpdate.select_self.kpi_hs_mode = modeKind.modeID;

        await macInfoJsonForFileUpdate.save();
      } catch (e, s) {
        // ログ出力
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "changeMode(), $e,$s");
        dlgConfirmMsgKind = DlgConfirmMsgKind.MSG_SYSERR;
        break;
      }

      // 現在選択されているIDを更新
      selectedModeID.value = modeKind.modeID;
      // メモリ更新用のインスタンス
      Mac_infoJsonFile macInfoJsonFile = pCom.iniMacInfo;
      macInfoJsonFile.select_self.kpi_hs_mode = modeKind.modeID;

      // 正常終了
      break;
    }

    // エラーがあれば、ダイアログ表示する
    if (dlgConfirmMsgKind != DlgConfirmMsgKind.MSG_NONE) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: dlgConfirmMsgKind.dlgId,
        ),
      );
    }

  }
}