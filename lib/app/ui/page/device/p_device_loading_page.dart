/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import 'controller/c_device_loading_controller.dart';
import 'package:flutter_svg/svg.dart';

/// 動作概要
/// 起動方法： Get.to(() => DeviceLoadingScreen(title: '端末読込')); など
/// 端末読込（読み取り方法選択）のページ
class DeviceLoadingScreen extends CommonBasePage {
  DeviceLoadingScreen({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
    String className = 'DeviceLoadingScreen';
          return <Widget>[
            SoundTextButton(
              onPressed: () {
                Get.back();
              },
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
    return DeviceLoadingWidget(
      title: super.title,
      backgroundColor: backgroundColor,
    );
  }
}

/// 端末読込画面（読み取り方法選択）のウィジェット
class DeviceLoadingWidget extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  const DeviceLoadingWidget({super.key, required this.title, required this.backgroundColor});

  @override
  DeviceLoadingState createState() => DeviceLoadingState();
}

/// 端末読込画面（読み取り方法選択）の状態管理
class DeviceLoadingState extends State<DeviceLoadingWidget> {
  DeviceLoadingController controller = Get.put(DeviceLoadingController());

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
              textAlign: TextAlign.center,
              'スマホ または 磁気カードを選択してください',
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var loadingType in LoadingType.values)... {
                _loadButton(
                  text: loadingType.subject,
                  icon: loadingType.icon,
                  onPressed: () => controller.navigateByType(loadingType, widget.title),
                )
              },
            ],
          ),
        ],
      ),
    );
  }

  /// 読み取り選択ボタンのウィジェット
  Widget _loadButton({
    required String text,
    required String icon,
    required VoidCallback onPressed,
  }) {
    return Container(
        margin: const EdgeInsets.all(43),
        child: SizedBox(
          height: 200.h,
          width: 200.w,
          child: SoundElevatedButton(
            onPressed: onPressed,
            callFunc: text,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 112.w,
                  height: 112.h,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: BaseFont.font22px,
                    color: BaseColor.baseColor,
                  ),
                ),
              ]
            ),
          ),
        ),
    );
  }
}
