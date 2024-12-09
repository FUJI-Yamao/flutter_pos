/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import '/app/ui/page/full_self/controller/c_full_self_footer_lower_buttons_controller.dart';
import '../../../../colorfont/c_basefont.dart';
import '../controller/c_full_self_timecontroller.dart';
import '/app/ui/component/w_sound_buttons.dart';

///会員情報読み込みページ左側の共通ウイジェット
class FullSelfSideBarWidget extends StatelessWidget {
  ///シナリオに応じて表示するボタンを決定
  final String scenario;

  ///会員情報読み込みページ
  static const String selectPage = 'SelectPage';

  ///バーコード読み込みページと磁気カードを読み込みページ
  static const String cardPage = 'CardPage';
  FullSelfSideBarWidget({super.key, required this.scenario});
  final TimeController timeController = Get.put(TimeController());
  // フルセルフ画面のフッターの下部にあるボタンのコントローラー
  final FullSelfFooterLowerButtonsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    ///ボタンの設定リスト
    final List<Map<String, dynamic>> buttons = [
      {
        'icon': 'assets/images/icon_sidebar_language.svg',
        'text': 'Language',
        'color': BaseColor.languageButtonColor,
        'action': () => controller.language(),
        'enabled': true,
      },
      {
        'icon': 'assets/images/icon_sidebar_delete.svg',
        'text': '買い物をやめる',
        'color': BaseColor.baseColor,
        'action': () => () {},
        'enabled': true,
      },
      {
        'icon': 'assets/images/icon_sidebar_call.svg',
        'text': '店員を呼ぶ',
        'color': BaseColor.baseColor,
        'action': () => () {},
        'enabled': true,
      },
      {
        'icon': 'assets/images/icon_sidebar_non_barcode.svg',
        'text': 'レジ袋を購入',
        'color': BaseColor.baseColor,
        'action': () => () {},
        'enabled': true,
      },
      {
        'icon': 'assets/images/icon_sidebar_non_barcode.svg',
        'text': 'バーコードがない商品',
        'color': BaseColor.baseColor,
        'action': () => () {},
        'enabled': true,
      },
    ];

    ///シナリオに応じて表示するボタンのインデックスを選択
    List<int> buttonIndices;
    switch (scenario) {
      ///会員情報読み込みページ
      ///会員情報読み込みページ
      case selectPage:
        buttonIndices = [0];
        break;

      ///バーコード読み込みページと磁気カードを読み込みページ
      case cardPage:
        buttonIndices = [0, 1, 2];
        break;
      case '':
        buttonIndices = [3, 4];
        break;
      default:
        buttonIndices = [0];
    }
    return Container(
      width: 152.w,
      height: 768.h,
      color: BaseColor.baseColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
            width: 120.w,
            height: 160.h,
            color: BaseColor.mainColor,
          ),
          SizedBox(height: 16.h),

          ///ボタンを生成
          ...buttonIndices.asMap().entries.map(
            (entry) {
              ///現在のボタンのインデックス
              final index = entry.key;

              ///現在のボタンの設定
              final button = buttons[entry.value];

              ///ボタンがクリック可能かどうか
              final bool isEnabled = button['enabled'] as bool;

              ///背景色の設定
              final backgroundColor =
                  index == 0 ? button['color'] : BaseColor.baseColor;

              ///文字色の設定
              final textColor = isEnabled
                  ? (index == 0 ? Colors.black : BaseColor.someTextPopupArea)
                  : (index == 0
                      ? Colors.black.withOpacity(0.3)
                      : BaseColor.someTextPopupArea.withOpacity(0.3));

              ///枠線の色設定
              final borderColor = isEnabled
                  ? (index == 0
                      ? BaseColor.transparent
                      : BaseColor.someTextPopupArea)
                  : (index == 0
                      ? BaseColor.transparent
                      : BaseColor.someTextPopupArea.withOpacity(0.3));

              ///枠線の表示
              final borderWidth = index == 0 ? 0.0 : 1.0;

              ///ボタン間の距離
              final double topPadding = index == 0 ? 16.h : 8.h;
              final double bottomPadding = index == 0 ? 16.h : 8.h;

              return Padding(
                padding:
                    EdgeInsets.only(top: topPadding, bottom: bottomPadding),
                child: SizedBox(
                  width: 128.w,
                  height: 64.h,
                  child: SoundElevatedButton(
                    callFunc: runtimeType.toString(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side:
                            BorderSide(color: borderColor, width: borderWidth),
                      ),
                      foregroundColor: textColor,
                    ),
                    onPressed: isEnabled ? button['action'] : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          button['icon'],
                          width: 32.w,
                          height: 32.h,
                          colorFilter: isEnabled
                              ? null
                              : ColorFilter.mode(
                                  BaseColor.someTextPopupArea.withOpacity(0.3),
                                  BlendMode.srcIn),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            button['text'],
                            style: TextStyle(
                                color: textColor,
                                fontSize: BaseFont.font18px,
                                fontFamily: BaseFont.familyDefault),
                            textAlign: TextAlign.center,
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          Positioned(
            bottom: 0.h,
            left: 0.w,
            child: Container(
              width: 152.w,
              height: 56.h,
              color: BaseColor.changeCoinReferTitleColor,
              alignment: Alignment.center,
              child: Obx(
                () => Text(
                  textAlign: TextAlign.center,
                  timeController.currentTime.value,
                  style: const TextStyle(
                      fontFamily: BaseFont.familyDefault,
                      fontSize: BaseFont.font18px,
                      color: BaseColor.someTextPopupArea),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
