/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/cmn_sysfunc.dart';
import '../../../../regs/checker/rc_vega3000.dart';
import '../../../../regs/checker/rcky_cat_cardread.dart';
import '../../../../regs/checker/rcmbrflrd.dart';
import '../../../../regs/inc/rc_mem.dart';
import '../../../controller/c_common_controller.dart';
import '../../../menu/register/m_menu.dart';
import '../../member/controller/c_member_call_controller.dart';
import '../../register/controller/c_registerbody_controller.dart';
import '../../register/model/m_membermodels.dart';
import '../p_device_loading_by_type_page.dart';

/// 端末読込画面のコントローラ
class DeviceLoadingController extends MemberCallInputController {
  /// コンストラクタ
  DeviceLoadingController();

  @override
  void onInit() {
    super.onInit();
  }

  /// バックエンド処理「会員読取_可否チェック」を実装する
  Future<bool> executeCheckCardReadProcessing() async {
    debugPrint('********** RcKyCatCardRead.rcKyCatCardRead() start');
    await RcKyCatCardRead.rcKyCatCardRead();
    debugPrint('********** RcKyCatCardRead.rcKyCatCardRead() end');

    AcMem cMem = SystemFunc.readAcMem();
    debugPrint('********** errNo = ${cMem.ent.errNo}');
    if (cMem.ent.errNo != 0) {
      return false;
    }
    return true;
  }

  /// カード読取処理の呼出＆表示
  Future<void> outputMemberParam() async {
    await _executeCardReadProcessing().then((bool isSuccess) async {
      // TODO:10155 顧客呼出 正常動作確認用（フロント側へ渡すパラメタ）
      debugPrint('********** custNo = ${RcMbrFlrd.cust.cust_no}');
      debugPrint('********** status = ${RcMbrFlrd.rcdStatus}');
      debugPrint('********** ttlPoint = ${RcMbrFlrd.ttlPoint}');
      debugPrint('********** lapsePoint = ${RcMbrFlrd.lapsePoint}');
      debugPrint('********** lapseDay = ${RcMbrFlrd.lapseDay}');
      debugPrint('********** cardType = ${RcMbrFlrd.cardType}');
      debugPrint('********** seniorFlg = ${RcMbrFlrd.seniorFlg}');
      _setRegisterBodyInfo();
      CommonController commonCtrl = Get.find();
      if (commonCtrl.onSubtotalRoute.value) {  //小計画面から端末読込画面を起動
        SetMenu1.navigateToPaymentSelectPage();
      } else {  //登録画面から端末読込画面を起動
        SetMenu1.navigateToRegisterPage();
      }
    });
  }

  /// バックエンド処理「会員読取_カード番号チェック＆出力」を実装する
  Future<bool> _executeCardReadProcessing() async {
    debugPrint('********** RcVega3000.rcVegaWaitResponse() start');
    await RcVega3000.rcVegaWaitResponse();
    debugPrint('********** RcVega3000.rcVegaWaitResponse() end');

    AcMem cMem = SystemFunc.readAcMem();
    debugPrint('********** errNo = ${cMem.ent.errNo}');
    if (cMem.ent.errNo != 0) {
      return false;
    }
    return true;
  }

  /// 顧客情報を登録画面（RegisterBodyController）に設定する
  void _setRegisterBodyInfo() {
    MemberInfo memberInfo = getMemberInfo();
    RegisterBodyController registerBodyCtrl = Get.find();
    registerBodyCtrl.setMemberType(memberInfo);
  }

  /// 読取画面遷移
  void navigateByType(LoadingType type, String title) {
    Get.to(() => DeviceLoadingByTypeScreen(title: title, loadingType: type));
  }
}

/// 端末の読込種別
enum LoadingType {
  phone('スマホ', 'スマホのバーコードをスキャンしてください', 'assets/images/icon_smartphone.svg', 'assets/images/xga_handy_barcode_scanning_840x440.webp'),
  card('磁気カード', '端末に磁気カードを読み込ませてください', 'assets/images/icon_magneticcard.svg', 'assets/images/xga_vega_members_slit_840x440.webp');

  final String subject;
  final String subtitle;
  final String icon;
  final String loadImage;
  const LoadingType(this.subject, this.subtitle, this.icon, this.loadImage);
}
