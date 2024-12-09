/* 
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../page/register/controller/c_registerbody_controller.dart';
import '../../../page/subtotal/component/w_machine_item.dart';

///お釣り払い出し精算機選択画面
class QcSelectChoicePage extends StatelessWidget {

  QcSelectChoicePage({super.key});
  @override
  Widget build(BuildContext context) {
    final RegisterBodyController bodyctrl = Get.find();
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            alignment: Alignment.center,
            color: BaseColor.presetColorCd205,
            child: const Text('お釣り払い出し精算機選択',
                style: TextStyle(
                  fontSize: BaseFont.font28px,
                  color: BaseColor.maintainTenkeyBG,
                )),
          ),
          Container(
            height: 200,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text('送信する精算機を選択してください。',
              style: TextStyle(
                fontSize: BaseFont.font24px,
                color: BaseColor.baseColor,
              )),
          ),
          Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            direction: Axis.horizontal,
            children: [
              for (int i = 0; i <= 2; i++)
                Padding(
                  padding: EdgeInsets.only(right: i == 0 ? 0 : 8.w),
                  child: Obx(
                    () => MachineItem(
                      no: i,
                      title: bodyctrl.payMachineStatus[i].title,
                      idx: bodyctrl.payMachineStatus[i].idx,
                      nearstate: bodyctrl.payMachineStatus[i].nearstate,
                      state: bodyctrl.payMachineStatus[i].state,
                      uuid: 1111,
                      function: bodyctrl.payMachineStatus[i].function,
                    ),
                  ),
                ),
            ],
          ),
          Container(
            height: 100.h,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            child:const Text(
              '※注意※\n'
              '送信後、すぐに精算機からお金が出る場合があります。\n'
              'お客様が精算機前へ移動したことを確認して押してください。',
              style: TextStyle(
                color: BaseColor.accentsColor,
                fontSize: BaseFont.font20px,
              ),
            ),
          ),
          Container(
            height: 60.h,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50.w,
              width: 180.h,
              child: SoundElevatedButton(
                callFunc: runtimeType.toString(),
                onPressed: () {
                  //todo:ともに一つ前のスプリットを取り消す。品券など

                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: BaseColor.attentionColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('中止',
                    style: TextStyle(
                      fontSize: BaseFont.font26px,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
