/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../regs/checker/rc_vega3000.dart';
import '../../../regs/checker/rcky_cat_cardread.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import 'controller/c_device_loading_controller.dart';

/// 動作概要
/// 起動方法： Get.to(() => DeviceLoadingByTypeScreen(title: '磁気読込')); など
/// 端末読込のページ
class DeviceLoadingByTypeScreen extends CommonBasePage {
  final LoadingType loadingType;

  DeviceLoadingByTypeScreen({
    super.key,
    required super.title,
    required this.loadingType,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
    String className = 'DeviceLoadingByTypeScreen';
          return <Widget>[
            SoundTextButton(
              onPressed: () async {
                await RcVega3000.rcVegaMsReadStop(true);
                Get.back();
              },  //キャンセルボタン押下
              callFunc: className,
              child: Row(
                children: <Widget>[
                  const Icon(Icons.close,
                      color: BaseColor.someTextPopupArea, size: 45),
                  SizedBox(
                    width: 19.w,
                  ),
                  Text('l_cmn_cancel'.trns,
                      style: const TextStyle(
                          color: BaseColor.someTextPopupArea,
                          fontSize: BaseFont.font18px)),
                ],
              ),
            ),
          ];
        });

  @override
  Widget buildBody(BuildContext context) {
    return DeviceLoadingByTypeWidget(
      loadingType: loadingType,
      backgroundColor: backgroundColor,
    );
  }
}

/// 端末読込画面のウィジェット
class DeviceLoadingByTypeWidget extends StatefulWidget {
  final LoadingType loadingType;
  final Color backgroundColor;

  const DeviceLoadingByTypeWidget({super.key, required this.loadingType, required this.backgroundColor});

  @override
  DeviceLoadingState createState() => DeviceLoadingState();
}

/// 端末読込画面の状態管理
class DeviceLoadingState extends State<DeviceLoadingByTypeWidget> {
  DeviceLoadingController deviceLoadCtrl = Get.put(DeviceLoadingController());

  @override
  void initState() {
    super.initState();
    Future(() async {
      await deviceLoadCtrl.executeCheckCardReadProcessing();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              widget.loadingType.subtitle,
              style: const TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Image.asset(
            widget.loadingType.loadImage,
            width: 840.w,
            height: 440.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 80.h,
                    width: 200.w,
                    child: SoundElevatedButton(
                      onPressed: () async {
                        await RcVega3000.rcVegaMsReadStop(true);
                        Get.back();
                      },  //会員選択のやり直し押下
                      callFunc: '会員選択のやり直し',
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(),
                        foregroundColor: BaseColor.backColor,
                        backgroundColor: BaseColor.someTextPopupArea,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        elevation: 3,
                        padding: const EdgeInsets.all(24.0),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/images/icon_back_arrow.svg',
                              width: 32.w,
                              height: 32.h,
                            ),
                            const Text(
                              '会員選択の\nやり直し',
                              style: TextStyle(
                                fontSize: BaseFont.font18px,
                                color: BaseColor.baseColor,
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
          ],
        ),
      ),
    );
  }
}
