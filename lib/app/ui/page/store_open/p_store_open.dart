/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../sys/stropncls/rmstopn.dart';
import '../../../sys/syst/sys_stdn.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import 'controller/c_store_open_page.dart';

/// 開設画面
class StoreOpenPage extends StatefulWidget {
  const StoreOpenPage({super.key});

  @override
  StoreOpenPageState createState() => StoreOpenPageState();
}

class StoreOpenPageState extends State<StoreOpenPage> {

  /// 開設中止ボタンの表示フラグ
  bool _show = false;
  /// 開設中止ボタンを表示するためのタップ回数
  int _clickCount = 0;

  @override
  Widget build(BuildContext context) {
    StoreOpenPageController ctrl = Get.put(StoreOpenPageController());

    return Scaffold(
      backgroundColor: BaseColor.storeOpenCloseBackColor,
      appBar: AppBar(
        title: Obx(() => Row(
          children: [
            const Text(
              '開設',
              style: TextStyle(color: BaseColor.storeOpenCloseWhiteColor, fontSize: 30),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  ctrl.nowTime.value,
                  style: const TextStyle(color: BaseColor.storeOpenCloseWhiteColor, fontSize: 20),
                ),
              ),
            ),
          ],
        )),
        backgroundColor: BaseColor.storeOpenBackColor,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body:
      GetBuilder(
        init: StoreOpenPageController(),
        builder: (controller) => Center(
          child: Column(
            children: [
              Container(
                color: BaseColor.storeOpenMessageColor,
                padding: const EdgeInsets.all(16.0),
                child: const Center(
                  child: Text(
                    '営業日を決定後、実行を押してください。',
                    style: TextStyle(
                      color: BaseColor.storeOpenFontColor,
                      fontSize: 30.0,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 60),
              // 画面メッセージ
              const SizedBox(
                  width: 400,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        Text('営業日', style: TextStyle(fontSize: 18,color: BaseColor.storeOpenFontColor)),
                      ]
                  )
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: 250,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          SoundUtil.playPushSoundLog(runtimeType.toString());
                        },
                        child: Obx(() => DropdownButtonFormField<String?>(
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: BaseColor.storeOpenDropDownColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: BaseColor.storeOpenDropDownColor),
                            ),
                            filled: true,
                            fillColor: BaseColor.storeOpenCloseWhiteColor,
                          ),
                          dropdownColor: BaseColor.storeOpenCloseWhiteColor,
                          value: ctrl.selectedValue.value,
                          onChanged: (value) {
                            setState(() {
                              controller.onPressedSelectDate(value!);
                              SoundUtil.playPushSoundLog(runtimeType.toString());
                            });
                          },
                          items: <String>[
                            ctrl.pastDate.value,
                            ctrl.nowDate.value,
                            ctrl.futureDate.value
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: BaseColor.storeOpenFontColor,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        )),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),
                  SoundElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BaseColor.storeOpenFontColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),),
                      minimumSize: const Size(50, 50),
                    ),
                    onPressed: () => ctrl.selectedValue.value = ctrl.nowDate.value,
                    callFunc: runtimeType.toString(),
                    child: const Icon(Icons.autorenew_rounded, color: BaseColor.storeOpenCloseWhiteColor, size: 25,), // Icon
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const SizedBox(
                  width: 400,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        Text('前回営業日', style: TextStyle(fontSize: 18,color: BaseColor.storeOpenFontColor)),
                      ]
                  )
              ),
              const SizedBox(height: 10),
              Container(
                height: 80,
                width: 800,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Obx(() => Text(controller.lastsaleDate, style: const TextStyle(fontSize: 25, color: BaseColor.storeOpenFontColor))),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              GestureDetector(
                onTap: () => _pressingJudgment(),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const Text('件数', style: TextStyle(fontSize: BaseFont.font18px, color: BaseColor.storeOpenFontColor)),
                      const SizedBox(height: 20),
                      Obx(() => Text('${Rmstopn.histLogCnt.value}', style: const TextStyle(fontSize: 25, color: BaseColor.storeOpenFontColor))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // 電源OFFボタン
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 180,
                    height: 80,
                    child: SoundElevatedButton(
                      callFunc: runtimeType.toString(),
                      onPressed: () {
                        // 同じログを複数箇所に出力する関数
                        SysStdn.outputLogs('pressed powerOFF button From ${runtimeType.toString()}');
                        SysStdn.showShutdownConfirmationDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: BaseColor.storeOpenPowerOffColor, width: 1.0),
                        backgroundColor: BaseColor.storeOpenPowerOffBackColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            color: BaseColor.storeOpenPowerOffColor,
                            size: 40,
                          ),
                          SizedBox(width: 10),
                          Text('電源OFF', style: TextStyle(fontSize: 22,  color: BaseColor.storeOpenPowerOffColor)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // 開設中止ボタン(5回押すと表示)
                  Column(
                    children: [

                      _show ? SizedBox(
                        width: 180,
                        height: 80,
                        child: SoundElevatedButton(
                          onPressed: controller.onPressedSkipStoreOpen,
                          callFunc: runtimeType.toString(),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: BaseColor.storeOpenPowerOffColor, width: 1.0),
                            backgroundColor: BaseColor.storeOpenPowerOffBackColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('開設中止', style: TextStyle(fontSize: 20,  color: BaseColor.storeOpenPowerOffColor)),
                            ],
                          ),
                        ),
                      ) : Container(),
                    ],
                  ),

                  GestureDetector(
                    onTap: () {controller.onPressedStoreOpen();
                      SoundUtil.playPushSoundLog(runtimeType.toString());},
                    child: Container(
                      width: 180,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            BaseColor.confirmBtnFrom,
                            BaseColor.confirmBtnTo,
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: BaseColor.dropShadowColor,
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(3, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          '実行',
                          style: TextStyle(fontSize: 22, color: BaseColor.storeOpenCloseWhiteColor,fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 隠しボタン押下の判定
  void _pressingJudgment() {
    // _show が true の場合は、この処理は実行しない
    if (_show) return;

    // 最初のタップから5秒経過すると、カウントをリセットする
    if (_clickCount == 0) {
      Future.delayed(const Duration(seconds: 5), () async {
        _clickCount = 0;
      });
    }

    // 押下回数のインクリメント
    _clickCount++;

    // 5回タップすると、開設中止ボタンを表示する
    if (_clickCount >= 5) {
      setState(() {
        _clickCount = 0;
        _show = true;
      });
    }
  }

}
