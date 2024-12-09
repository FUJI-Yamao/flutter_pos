/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/page/full_self/member_info_loading/component/w_full_self_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../colorfont/c_basecolor.dart';
import '../../../../colorfont/c_basefont.dart';
import '../component/w_full_self_leftside.dart';
import '/app/ui/component/w_sound_buttons.dart';

///磁気カードを読み込みページ
class FullSelfMagneticCardPage extends StatelessWidget {
  const FullSelfMagneticCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          FullSelfSideBarWidget(scenario: FullSelfSideBarWidget.cardPage),
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    const FullSelfHeaderTextWidget(
                      text: '会員カードを端末に通してください',
                    ),
                    Image.asset(
                      'assets/images/xga_vega_members_slit_872x504.webp',
                      width: 872.w,
                      height: 504.h,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Positioned(
                  top: 692.h,
                  left: 16.w,
                  child: SizedBox(
                    width: 216.w,
                    height: 64.h,
                    child: SoundElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      callFunc: runtimeType.toString(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            BaseColor.batchReportOutputPageScrollButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 3,
                        shadowColor: BaseColor.scanBtnShadowColor,
                      ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
