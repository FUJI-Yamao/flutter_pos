/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../page/p_full_self_card.dart';
import '../page/p_full_self_barcode_page.dart';
import '/app/ui/component/w_sound_buttons.dart';
import '../../../../colorfont/c_basecolor.dart';

///会員情報読み込みページ右側ウイジェット
class ArcusApp extends StatelessWidget {
  const ArcusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                imagePath: 'assets/images/icon_membars_app.svg',
                text: 'アークスアプリ',
                onPressed: () {
                  Get.to(() => const BarcodePage());
                },
                callFunc: 'アークスアプリ',
              ),
              SizedBox(width: 15.w),
              _buildButton(
                imagePath: 'assets/images/icon_membars_card.svg',
                text: '磁気カード',
                onPressed: () {
                  Get.to(() => const FullSelfMagneticCardPage());
                },
                callFunc: '磁気カード',
              ),
              SizedBox(width: 15.w),
              _buildButton(
                imagePath: 'assets/images/icon_membars_card.svg',
                text: '持っていない',
                onPressed: () {},
                callFunc: '持っていない',
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w, bottom: 6.h, top: 300.h),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SoundElevatedButton(
              onPressed: () {
                Get.back();
              },
              callFunc: '前の画面に戻る',
              style: ElevatedButton.styleFrom(
                backgroundColor: BaseColor.batchReportOutputPageScrollButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Container(
                width: 190.w,
                height: 64.h,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/icon_back_fullself.svg',
                      width: 32.w,
                      height: 28.h,
                    ),
                    SizedBox(width: 15.w),
                    const Text(
                      '前の画面に戻る',
                      style: TextStyle(
                          fontSize: BaseFont.font18px,
                          color: BaseColor.someTextPopupArea,
                          fontFamily: BaseFont.familySub),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///会員カード読み込みアイテム構築
  Widget _buildButton(
      {required String imagePath,
      required String text,
      required onPressed,
      required callFunc}) {
    return SizedBox(
      width: 268.w,
      height: 200.h,
      child: SoundElevatedButton(
        onPressed: onPressed,
        callFunc: callFunc,
        style: ElevatedButton.styleFrom(
          backgroundColor: BaseColor.soundUnSelectInColor,
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: BaseColor.ticketPayFixedForegroundColor,
              width: 1,
            ),
          ),
          shadowColor: BaseColor.dropShadowColor,
          elevation: 5,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 16.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagePath,
                width: 152.w,
                height: 112.h,
              ),
              SizedBox(height: 8.h),
              Text(
                text,
                style: const TextStyle(
                  fontFamily: BaseFont.familySub,
                  fontSize: BaseFont.font22px,
                  color: BaseColor.storeOpenFontColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
