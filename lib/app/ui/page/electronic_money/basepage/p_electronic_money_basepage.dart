/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import '../../../../regs/checker/regs.dart';
import 'package:flutter_pos/app/ui/page/subtotal/component/w_payment_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../inc/sys/tpr_aid.dart';
import '../../../../regs/checker/rc_key.dart';
import '../../../../regs/checker/rc_touch_key.dart';
import '../../../../regs/checker/rcky_cha.dart';
import '../../../../regs/checker/rcstllcd.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../controller/c_drv_controller.dart';
import '../../../enum/e_presetcd.dart';
import '../../common/basepage/common_base.dart';

///電子マネー選択ページ
class ElectronicMoneyScreen extends CommonBasePage with RegisterDeviceEvent {
  ElectronicMoneyScreen({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) {
    registrationEvent();
  }

  @override
  Widget buildBody(BuildContext context) {
    return ElectronicMoneyWidget(
      backgroundColor: backgroundColor,
    );
  }

  @override
  IfDrvPage getTag() {
    return IfDrvPage.subtotalElectronicMoney;
  }

  @override
  KeyDispatch? getKeyCtrl() {
    KeyDispatch keyCon = KeyDispatch(Tpraid.TPRAID_CHK);
    return keyCon;
  }
}

class ElectronicMoneyWidget extends StatefulWidget {
  /// 背景色
  final Color backgroundColor;

  ///コンストラクタ
  const ElectronicMoneyWidget({super.key, required this.backgroundColor});

  @override
  ElectronicMoneyState createState() => ElectronicMoneyState();
}

class ElectronicMoneyState extends State<ElectronicMoneyWidget> {
  /// 電子マネーリスト
  final eMoneyList = <PresetInfo>[].obs;

  /// 初期化処理
  @override
  void initState() {
    super.initState();
    loadElectronicMoneyData();
  }

  ///電子マネーの支払方法リストデータ取得
  void loadElectronicMoneyData() async {
    var allPresets = await RegistInitData.getPresetData();
    var filteredPresets = allPresets
        .where((item) =>
            item.presetCd == PresetCd.electronicMoney.value && item.kyCd != 0)
        .toList();
    eMoneyList.assignAll(filteredPresets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: const Center(
            child: Text(
              'お支払い方法を選択してください',
              style: TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => GridView.builder(
          padding: const EdgeInsets.only(
            left: 88,
            right: 88,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: eMoneyList.length,
          itemBuilder: (context, index) {
            var eMoney = eMoneyList[index];
            return PaymentBox(
              iconPath: 'assets/images/${eMoney.imgName}',
              title: eMoney.kyName,
              onTap: () {
                TchKeyDispatch.rcDTchByKeyId(eMoney.kyCd, eMoney);
              },
              presetColor: eMoney.presetColor,
            );
          },
        ),
      ),
    );
  }
}
