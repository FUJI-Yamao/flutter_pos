/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import '../../../../regs/checker/rcsyschk.dart';
import '../../../component/w_sound_buttons.dart';
import 'package:get/get.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_trainingModeText.dart';
import '../controller/c_full_self_maintenance_controller.dart';
import '../model/m_full_self_maintenance_button_info.dart';

/// フルセルフのメンテナンス画面
class FullSelfMaintenancePage extends StatelessWidget {
   FullSelfMaintenancePage({super.key}) : isTrainingMode = RcSysChk.rcTROpeModeChk();

  //訓練モード判定
  final bool isTrainingMode;

  @override
  Widget build(BuildContext context) {
    FullSelfMaintenanceController controller = Get.put(FullSelfMaintenanceController());
    List<MaintenanceButtonInfo> maintenanceButtonInfoList = controller.getMaintenanceButtonInfo();
    return Scaffold(
      body: Container(
        color: BaseColor.modeChangePageBackgroundColor,
        child: Stack(
          children: [
           Column(
             children: [
               // タイトルバー
               titleBar(),
               // メンテナンス画面で使用するボタン
               Expanded(
                 child: Container(
                   color: BaseColor.loginBackColor,
                   child: Container(
                     margin: const EdgeInsets.only(
                         top: 72.0, left: 96.0, right: 96.0, bottom: 112.0),
                     color: BaseColor.loginBackColor,
                     child: GridView.builder(
                       physics: const NeverScrollableScrollPhysics(),
                       padding: const EdgeInsets.all(0),
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 4,
                         crossAxisSpacing: 0,
                         mainAxisSpacing: 0,
                         childAspectRatio: 2 / 1,
                       ),
                       itemCount: maintenanceButtonInfoList.length,
                       itemBuilder: (context, keyIdx) {
                         return Padding(
                           padding:
                           const EdgeInsets.only(left: 16.0, right: 16.0, top: 15.0, bottom: 16.0),
                           child: Stack(
                             children: [
                               SizedBox(
                                   width: 184.0,
                                   height: 80.0,
                                   child: SoundElevatedButton(
                                       style: ElevatedButton.styleFrom(
                                           backgroundColor: BaseColor.someTextPopupArea,
                                           side: const BorderSide(
                                             color: BaseColor.loginTabTextColor, //色
                                             width: 1, //太さ
                                           )),
                                       onPressed: () {
                                         // 上位のSoundInkWellにタップ処理が吸われるため、ここには処理を書かない
                                       },
                                       callFunc: runtimeType.toString(),
                                       child: Text(
                                         maintenanceButtonInfoList[keyIdx].buttonName,
                                         style: const TextStyle(
                                           color: BaseColor.baseColor,
                                           fontSize: BaseFont.font18px,
                                           fontFamily: BaseFont.familySub,
                                         ),
                                       ))),
                               Positioned.fill(
                                   child: Material(
                                     color: BaseColor.transparent,
                                     child: SoundInkWell(
                                       onTap: () {
                                         maintenanceButtonInfoList[keyIdx].onTapCallback.call();
                                       },
                                       callFunc: runtimeType.toString(),
                                     ),
                                   )),
                             ],
                           ),
                         );
                       },
                     ),
                   ),
                 ),
               ),
               // タイトルバーの高さ(56.0)
               const SizedBox(height: 56.0,),
             ],
           ),
            //訓練モードの時表示する半透明テキスト
            if (isTrainingMode) TrainingModeText(),
          ],
        ),
      ),
    );
  }

  /// タイトルバー
  Widget titleBar(){
    String callFunc = 'titleBar';
    return
      Container(
        height: 56.0,
        width: double.infinity,
        color: BaseColor.baseColor.withOpacity(0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              child: const Text(
                'メンテナンス画面',
                style: TextStyle(
                  color: BaseColor.someTextPopupArea,
                  fontSize: BaseFont.font24px,
                ),
              ),
            ),
            SoundTextButton(
              onPressed: () {
                Get.back();
              },
              callFunc: callFunc,
              child: const Row(
                children: <Widget>[
                  Icon(
                    Icons.close,
                    color: BaseColor.someTextPopupArea,
                    size: 45,
                  ),
                  SizedBox(
                    width: 19,
                  ),
                  Text(
                    '戻る',
                    style: TextStyle(
                      color: BaseColor.someTextPopupArea,
                      fontSize: BaseFont.font18px,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }

}