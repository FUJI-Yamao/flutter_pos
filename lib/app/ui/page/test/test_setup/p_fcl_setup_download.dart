/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/ui/page/test/test_setup/template/basepage/fcl_setup_base.dart';
import 'package:get/get.dart';

import '../../../../lib/apllib/TmnDaily_Trn.dart';
import '../../../../sys/usetup/fcl_setup/fcl_setup.dart';
import '../../../../sys/usetup/fcl_setup/fcl_setup_frs_comm.dart';
import '../../../../sys/usetup/fcl_setup/ut1_setup_sub.dart';
import '../../../colorfont/c_basefont.dart';
import '../controller/c_fcl_setup_download_controller.dart';


/// 端末設定情報ダウンロード画面
class FclSetupDownloadPage extends FclSetupBasePage {
  static const String utSTitleCommCom2 = '共通センタ通信-端末設定情報ダウンロード';
  static const String utDrCommMsg = '端末設定情報ダウンロードでは以下の処理を行います。\n・端末設定情報をセンタに保存します  \n・端末設定情報をセンタから取得します';
  static const String utDrCommMsg1 = '  ※更新項目は直近の伝票番号 ';

  /// コンストラクタ
  const FclSetupDownloadPage({
    super.key,
  }) : super(performed: performedFunc,title: utSTitleCommCom2, message: utDrCommMsg, attentionMessage: utDrCommMsg1);


  /// 「はい」ボタン押下時の処理
  static void performedFunc() {
    final FclSetupDownloadController ctrl = Get.find();

    // TODO:10150 端末セットアップ、ダウンロード 突貫対応
    // 既存はボタンの種類によってfclsInfo.stateに値をいれている
    TmnDailyTrn.fclsInfo.state = FclsSts.FCLS_STS_1_1_2;

    FclSetupFrsComm.utSetBtn();

    return;
  }

  @override
  Widget buildContent(BuildContext context) {
    FclSetupDownloadController con = Get.put(FclSetupDownloadController());
    return Obx(() => Text(
      con.execStatus.value,
      style: const TextStyle(
        fontFamily: BaseFont.familyDefault,
        fontSize: BaseFont.font24px,
      ),
    ));
  }
}
