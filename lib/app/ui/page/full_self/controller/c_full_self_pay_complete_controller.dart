/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'package:get/get.dart';

import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../lib/cm_sound/sound_def.dart';
import '../../../../regs/checker/rc_sound.dart';
import '../../../socket/server/semiself_socket_server.dart';

/// フルセルフ取引完了画面のコントローラー
class FullSelfPayCompleteController extends GetxController {

  /// 自動で画面遷移する秒数を管理するタイマー
  late Timer timer;
  var complete = false.obs;
  static const int waitTime = 7;


  /// フルセルフのスタート画面
  void toFullSelfStartPage() {
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRetC.object;
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    int selfMode = pCom.iniMacInfo.select_self.kpi_hs_mode;
    // ガイダンス音声の停止
    RcSound.stop();

    timer.cancel();
    if (selfMode == 2) {
      // セミセルフのスタートページ
      tsBuf.qcConnect.MyStatus.qcStatus = SemiSelfSocketServer.msgStatusStandby;
      RegsMem().tTtllog.t100001.stlTaxInAmt = 0;
      complete.value = false;

      Get.until((route) => route.settings.name == '/FullSelfSelectPayPage');
    } else {
      // フルセルフのスタートページ
      Get.until((route) => route.settings.name == '/FullSelfStartPage');
    }
  }

  /// フルセルフのスタート画面
  Future<void> setPaymentSuccess() async {
    // ガイダンス音声の停止
    complete.value = true;
    await autoToFullSelfStartPage();

    // ガイダンス音声番号から音声を出力
    RcSound.playFromSoundNum(
      soundNum: SoundDef.guidanceFullSelfPayCompleteNumber,
    );
  }

  /// 特定秒後に自動で画面遷移
  Future<void> autoToFullSelfStartPage() async {
    timer = Timer(const Duration(seconds: waitTime), () {
      toFullSelfStartPage();
    });
  }
}
