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
import 'controller/c_charge_collect_controller.dart';
import 'controller/c_charge_collect_select_controller.dart';
import 'package:flutter_svg/svg.dart';

/// 動作概要
/// つり機回収方法選択のページ
class ChargeCollectSelectScreen extends CommonBasePage {
  ChargeCollectSelectScreen({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
    String className = 'ChargeCollectSelectScreen';
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
    return ChargeCollectSelectWidget(
      title: super.title,
      backgroundColor: backgroundColor,
    );
  }
}

/// つり機回収方法選択のウィジェット
class ChargeCollectSelectWidget extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  const ChargeCollectSelectWidget({super.key, required this.title, required this.backgroundColor});

  @override
  ChargeCollectSelectState createState() => ChargeCollectSelectState();
}

/// つり機回収方法選択の状態管理
class ChargeCollectSelectState extends State<ChargeCollectSelectWidget> {

  /// スペース
  double space = 8;
  double spaceDouble = 16;

  /// コントローラ
  ChargeCollectSelectController controller = Get.put(ChargeCollectSelectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(32.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          height: 32.h,
          child: const Center(
            child: Text(
              textAlign: TextAlign.center,
              '回収方法を選択してください',
              style: TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font18px,
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
            Container(),
            Center( // 回収方法の選択肢
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: spaceDouble,
                runSpacing: space,
                children: <Widget>[
                  for (var collectType in CollectType.valuesForOthers())... {
                    _selectButton(
                      collectType: collectType,
                    )
                  },
                ],
              ),
            ),
            Container(),
            Row( // 前の画面に戻る
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 56.h,
                  width: 216.w,
                  child: SoundElevatedButton(
                    onPressed: () => Get.back(),
                    callFunc: '前の画面に戻る',
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BaseColor.scanButtonColor,
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
                            'assets/images/icon_back_arrow_white.svg',
                            width: 32.w,
                            height: 32.h,
                          ),
                          const Text(
                            '前の画面に戻る',
                            style: TextStyle(
                              fontSize: BaseFont.font18px,
                              color: BaseColor.someTextPopupArea,
                              fontFamily: BaseFont.familyDefault,
                            ),
                          ),
                          Container(),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 回収方法選択ボタンのウィジェット
  Widget _selectButton({
    required CollectType collectType,
  }) {
    return SizedBox(
      width: 400.w,
      height: 56.h,
      child: SoundElevatedButton(
        onPressed: () => controller.onSelectCollectType(collectType),
        callFunc: collectType.value,
        style: ElevatedButton.styleFrom(
          side: const BorderSide(
            color: BaseColor.baseColor,
          ),
          foregroundColor: BaseColor.backColor,
          backgroundColor: BaseColor.someTextPopupArea,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 3,
          shadowColor: BaseColor.scanBtnShadowColor,
          padding: const EdgeInsets.all(24.0),
          alignment: Alignment.centerLeft,
        ),
        child: Text(
          collectType.value,
          style: const TextStyle(
            fontSize: BaseFont.font18px,
            color: BaseColor.baseColor,
            fontFamily: BaseFont.familyDefault,
          ),
        ),
      ),
    );
  }
}
