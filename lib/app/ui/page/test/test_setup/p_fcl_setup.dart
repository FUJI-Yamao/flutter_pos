/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/page/test/test_setup/template/basepage/fcl_setup_base.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../lib/apllib/TmnDaily_Trn.dart';
import '../../../../sys/usetup/fcl_setup/fcl_setup.dart';
import '../../../../sys/usetup/fcl_setup/fcl_setup_frs_comm.dart';
import '../../../../sys/usetup/fcl_setup/ut1_setup_sub.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_btn.dart';
import '../../../component/w_inputbox.dart';
import '../../../menu/register/enum/e_register_page.dart';
import '../../common/component/w_msgdialog.dart';
import '../../maintenance/specfile/model/m_specfile.dart';
import '../controller/c_fcl_setup_download_controller.dart';
import '../controller/c_fcl_setup_controller.dart';


/// 端末セットアップ通信画面
class FclSetupPage extends FclSetupBasePage {
  static const String utSTitleCommCom = '共通センタ通信-端末セットアップ通信';
  static const String utSetupCommMsg = 'セットアップ通信では以下の処理を行います。        \n・端末とPOSで利用可能なサービスのTIDをセンタから  \n  取得しPOSに格納後、サービスが可能になります';
  static const String utSetupCommMsg1 = '  ※端末を新たに接続する際は必ず実行して下さい \n  ※POS交換、店舗間移動の場合も必ず実行して下さい';

  /// コンストラクタ
  const FclSetupPage({
    super.key,
  }) : super(
      title: utSTitleCommCom,
      message: utSetupCommMsg,
      attentionMessage: utSetupCommMsg1,
      performed: performedFunc,
  );

  /// 「はい」ボタン押下時の処理
  static void performedFunc() {
    final FclSetupController ctrl = Get.find();

    // TODO:10150 端末セットアップ、ダウンロード 突貫対応
    // 既存はボタンの種類によってfclsInfo.stateに値をいれている
    TmnDailyTrn.fclsInfo.state = FclsSts.FCLS_STS_1_1_1;

    FclSetupFrsComm.utSetBtn();

  }

  @override
  Widget buildContent(BuildContext context) {
    FclSetupController con = Get.put(FclSetupController());
    return Obx(() => Text(
      con.execStatus.value,
      style: const TextStyle(
        fontFamily: BaseFont.familyDefault,
        fontSize: BaseFont.font24px,
      ),
    ));
  }
}
