/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../../../inc/sys/tpr_log.dart';
import '../../../../regs/checker/rc_ext.dart';
import '../../../../regs/checker/rcky_rfm.dart';
import '../../../../regs/checker/rcky_rpr.dart';
import '../model/m_full_self_maintenance_button_info.dart';

/// フルセルフのメンテナンス画面のコントローラー
class FullSelfMaintenanceController extends GetxController {

  /// 元の画面に戻る
  void toBack() {
    Get.back();
  }

  /// ボタン情報のリストにボタン情報を追加する
  List<MaintenanceButtonInfo> getMaintenanceButtonInfo() {
    List<MaintenanceButtonInfo> maintenanceButtonInfoList = <MaintenanceButtonInfo>[
      MaintenanceButtonInfo(
        buttonName: '再発行',
        onTapCallback: () async {
          TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal, "Tap button");
          RckyRpr.rprBtnFlg = 1;
          // TODO:10138 再発行、領収書対応 暫定処理
          await RckyRpr.rcKyRpr();
          RckyRpr.rprBtnFlg = 0;
        },
      ),
      MaintenanceButtonInfo(
        buttonName: '領収書',
        onTapCallback: () async {
          TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal, "Tap button");
          RckyRfm.rfmBtnFlg = 1;
          // TODO:10138 再発行、領収書対応 暫定処理
          await RcExt.rcKyRfm();
          RckyRfm.rfmBtnFlg = 0;
        },
      ),
    ];
    return maintenanceButtonInfoList;
  }

  // TODO:10138 再発行、領収書対応 の為小計画面破棄時にデータリセット
  ///　クローズ処理
  @override
  Future<void> onClose() async {
    // TODO: implement onClose
    super.onClose();
    await RcExt.rxChkModeReset("");
  }
}

