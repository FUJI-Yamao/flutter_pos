/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/regs/checker/regs.dart';
import 'package:flutter_pos/app/ui/page/subtotal/component/w_payment_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../common/number_util.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/sys/tpr_aid.dart';
import '../../../../lib/cm_chg/ltobcd.dart';
import '../../../../regs/checker/rc_key.dart';
import '../../../../regs/checker/rc_touch_key.dart';
import '../../../../regs/checker/rcky_cha.dart';
import '../../../../regs/checker/rcstllcd.dart';
import '../../../../regs/inc/rc_mem.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../controller/c_drv_controller.dart';
import '../../../enum/e_presetcd.dart';
import '../../common/basepage/common_base.dart';
import '../../ticket_payment/p_ticketpayment_page.dart';
import '../controller/c_coupons_controller.dart';
import '../controller/c_subtotal_controller.dart';

///商品券選択ページ
class GiftCertificatePage extends CommonBasePage with RegisterDeviceEvent {
  ///コンストラクタ
  GiftCertificatePage({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) {
    registrationEvent();
  }

  @override
  Widget buildBody(BuildContext context) {
    return GiftCertificateWidget(
      backgroundColor: backgroundColor,
    );
  }

  @override
  IfDrvPage getTag() {
    return IfDrvPage.giftcertificate;
  }

  @override
  KeyDispatch? getKeyCtrl() {
    KeyDispatch keyCon = KeyDispatch(Tpraid.TPRAID_CHK);
    return keyCon;
  }
}
///商品券選択画面widget
class GiftCertificateWidget extends StatefulWidget {
  /// 背景色
  final Color backgroundColor;

  ///コンストラクタ
  const GiftCertificateWidget({super.key, required this.backgroundColor});

  @override
  GiftCertificateState createState() => GiftCertificateState();
}

class GiftCertificateState extends State<GiftCertificateWidget> {
  /// 商品券リスト
  final giftCertificateList = <PresetInfo>[].obs;

  SubtotalController subtotalCtrl = Get.find();

  /// 初期化処理
  @override
  void initState() {
    super.initState();
    loadGiftCertificateData();
  }

  ///商品券リストデータ取得
  void loadGiftCertificateData() async {
    var allPresets = await RegistInitData.getPresetData();
    var filteredPresets = allPresets
        .where((item) => item.presetCd == PresetCd.giftVoucher.value && item.kyCd != 0)
        .toList();
    giftCertificateList.assignAll(filteredPresets);
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
              'お預かりした商品券を選んでください',
              style: TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '残り',
                      style: TextStyle(
                        color: BaseColor.baseColor,
                        fontSize: BaseFont.font18px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                    SizedBox(
                      width: 66.w,
                    ),
                    Text(
                      NumberFormatUtil.formatAmount(
                            subtotalCtrl.notEnoughAmount.value),
                      style: const TextStyle(
                          color: BaseColor.baseColor,
                          fontSize: BaseFont.font28px,
                          fontFamily: BaseFont.familyNumber),
                    ),
                  ],
                )),
          ),
          Expanded(
            child: Obx(() => GridView.builder(
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
                  itemCount: giftCertificateList.length,
                  itemBuilder: (context, index) {
                    var giftCertificate = giftCertificateList[index];
                    return PaymentBox(
                      iconPath: 'assets/images/${giftCertificate.imgName}',
                      title: giftCertificate.kyName,
                      onTap: () {
                        TchKeyDispatch.rcDTchByKeyId(
                            giftCertificate.kyCd, giftCertificate);
                      },
                      presetColor: giftCertificate.presetColor,
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
