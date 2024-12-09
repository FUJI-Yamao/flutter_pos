/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/drv/ffi/library.dart';
import 'package:flutter_pos/app/ui/page/semi_self/component/w_semiself_unpaidlist_receiptdata.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../regs/checker/rc_ext.dart';
import '../../../../regs/checker/rcky_qcnotpay_list.dart';
import '../../../../sys/sale_com_mm/rept_ejconf.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../socket/client/semiself_socket_client.dart';
import '../controller/c_unpaid_controller.dart';

///未精算一覧の底ボタンの部分
class UnpaidBottomButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UnPaidListController listCtrl = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Obx(() {
        ///前ボタンの表示状態
        bool isPrevEnable = listCtrl.prevBtnFlg.value;
        ///次ボタンの表示状態
        bool isNextEnable = listCtrl.nextBtnFlg.value;
        ///呼び戻すボタンの表示状態
        bool hasUnpaidData = listCtrl.unpaidList.isNotEmpty;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isPrevEnable) ...[
              _buildButton(
                  color: Colors.green[300]!,
                  textcolor: Colors.black,
                  width: 50,
                  hight: 50,
                  fontSize: BaseFont.font20px,
                  label: '前',
                  onPressed: () {
                    listCtrl.onPreviousBtn();
                    listCtrl.selectedItem(listCtrl.selectedIndex.value);
                  }),
              const SizedBox(
                width: 20,
              ),
            ] else ...[
              const SizedBox(
                width: 70,
              ),
            ],
            if (isNextEnable) ...[
              _buildButton(
                  color: Colors.green[300]!,
                  textcolor: Colors.black,
                  width: 50,
                  hight: 50,
                  fontSize: BaseFont.font20px,
                  label: '次',
                  onPressed: () {
                    listCtrl.onNextBtn();
                    listCtrl.selectedItem(listCtrl.selectedIndex.value);
                  }),
              const SizedBox(
                width: 250,
              ),
            ] else ...[
              const SizedBox(
                width: 300,
              ),
            ],
            if (hasUnpaidData) ...[
              _buildButton(
                  color: Colors.indigo[200]!,
                  textcolor: Colors.black,
                  width: 150,
                  hight: 50,
                  fontSize: BaseFont.font26px,
                  label: '呼び戻す',
                  onPressed: () async {
                    // TODO:仮実装（一括でキャンセルする）画面からどの未清算情報が押さたのか（どの精算機へ送った情報なのか）取得する必要がある。
                    int index = listCtrl.getSelectedItem();
                    if (index > 0) {
                      SemiSelfSocketClient().sendCallBackInfo(index,
                          listCtrl.outputList[listCtrl.selectedIndex.value]['uuid']);
                      if (isForceValidQc()) {
                        await listCtrl.setUnpaidPluData(listCtrl.selectedIndex.value);
                        Get.back();
                      }
                    }
                  }),
              const SizedBox(
                width: 330,
              ),
            ] else ...[
              const SizedBox(
                width: 480,
              ),
            ],
            _buildButton(
                color: Colors.redAccent,
                textcolor: BaseColor.someTextPopupArea,
                width: 100,
                hight: 50,
                fontSize: BaseFont.font20px,
                label: '中止',
                onPressed: () {
                  Get.back();
                }),
          ],
        );
      }),
    );
  }

  Widget _buildButton({
    required Color color,
    required Color textcolor,
    required double fontSize,
    required double width,
    required double hight,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: width,
      height: hight,
      child: SoundElevatedButton(
        onPressed: onPressed,
        callFunc: runtimeType.toString(),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textcolor,
            fontSize: fontSize,
            fontFamily: BaseFont.familyDefault,
          ),
        ),
      ),
    );
  }
}
