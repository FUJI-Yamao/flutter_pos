/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/mx_tab_control_grey_border.dart';
import '../../component/w_ignore_scrollbar.dart';
import '../../language/l_languagedbcall.dart';
import '../../menu/register/enum/e_register_page.dart';
import 'component/w_scroll_button.dart';
import 'component/w_volume_button.dart';
import 'controller/c_sound_setting_controller.dart';

/// 音の設定画面
class SoundSettingPage extends StatelessWidget with TabControlGreyBorder {
  /// コンストラクタ
  const SoundSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RegisterPage.soundSetting.pageTitleName,
          style: const TextStyle(
            color: BaseColor.someTextPopupArea,
            fontSize: BaseFont.font28px,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: BaseColor.baseColor.withOpacity(0.7),
        actions: buildActions(context),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            height: 88.0,
            color: BaseColor.soundSettingCommentBackgroundColor,  // 説明文の背景色
            child: const Center(
              child: Text(
                '音の種類毎に音量を設定できます。\nまた、選択ボタンを押下することで、鳴らす音を変更できます。',
                maxLines: 2,
                style: TextStyle(
                  fontSize: BaseFont.font22px,
                  fontFamily: BaseFont.familyDefault,
                  height: 1.2,
                ),
              ),
            ),
          ),
          // 本体側、客側をタブコントロールで切り替える
          _createTabControl(),
        ],
      ),
    );
  }

  /// 本体側、客側をタブコントロールで切り替える
  Widget _createTabControl() {
    final soundSettingController = Get.put(SoundSettingController());
    final RxList tabList = soundSettingController.tabList;
    final RxInt tabSelectedIndex = soundSettingController.tabSelectedIndex;
    final PageController pageController = soundSettingController.pageController;
    return Expanded(
      child: Obx(() {
        debugPrint("_createTabControl");
        return Column(
          children: [
            // タブの切替ボタン
            Row(
              children: [
                for (int idx = 0; idx < tabList.length; idx++)
                  _tabButton(
                    tabList: tabList,
                    pageController: pageController,
                    idx: idx,
                    tabSelectedIndex: tabSelectedIndex,
                  ),
              ],
            ),
            // タブ毎の画面
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (value) => tabSelectedIndex.value = value,
                children: [
                  for (int idx = 0; idx < tabList.length; idx++)
                    _tabView(soundSettingTargetInfo: tabList[idx]),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  /// タブの切替ボタン
  Widget _tabButton({
    required RxList tabList,
    required PageController pageController,
    required int idx,
    required RxInt tabSelectedIndex,
  }) {
    final soundSettingController = Get.put(SoundSettingController());
    return Expanded(
      flex: (tabSelectedIndex.value == idx) ? 2 : 1,
      child: Stack(
        children: [
          Obx(() => Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: (tabSelectedIndex.value == idx)
                  ? BaseColor.soundSettingPageBackgroundColor
                  : BaseColor.soundSettingTabUnselectedBackgroundColor,
              border: border(idx: idx, tabSelectedIndex: tabSelectedIndex.value),
            ),
            child: Center(
              child: Text(
                tabList[idx].soundSettingTarget.name,
                maxLines: 1,
                style: TextStyle(
                  fontSize: BaseFont.font22px,
                  fontFamily: BaseFont.familyDefault,
                  color: (tabSelectedIndex.value == idx)
                      ? BaseColor.soundSettingTabSelectedForegroundColor
                      : BaseColor.soundSettingTabUnselectedForegroundColor,
                ),
              ),
            ),
          ),),
          if (idx != soundSettingController.tabSelectedIndex.value) Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // 本体側と客側を切り替える
                  soundSettingController.changeTab(idx);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  /// タブ毎の画面
  Widget _tabView({
    required SoundSettingTargetInfo soundSettingTargetInfo,
  }) {
    return LayoutBuilder(builder: (buildContext, boxConstraints) {
      final soundSettingController = Get.put(SoundSettingController());
      return Stack(
        children: [
          // リスト表示
          _valueList(soundSettingTargetInfo: soundSettingTargetInfo),
          // スクロールボタンの表示
          Obx(() => (soundSettingController.isScrollable.value)
              ? Positioned(
                  left: 0,
                  bottom: 140.0,
                  child: SoundSettingScrollButton(
                    pageHeight: boxConstraints.maxHeight,
                    soundScrollController: soundSettingController.soundScrollController,
                  ),
                )
              : Container(),
          ),
        ],
      );
    });
  }

  /// リスト表示
  Widget _valueList({
    required SoundSettingTargetInfo soundSettingTargetInfo,
  }) {
    final soundSettingController = Get.put(SoundSettingController());
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: BaseColor.soundSettingPageBackgroundColor,
      child: IgnoreScrollbar(
        scrollController: soundSettingController.soundScrollController,
        child: Obx(() {
          debugPrint("Listview");
          return ListView.builder(
            controller: soundSettingController.soundScrollController,
            itemCount: soundSettingTargetInfo.soundSettingInfoList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  soundSettingRow(
                    soundSettingTargetInfo.soundSettingInfoList[index],
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }

  /// 音の種類と選択ボタンと音量とスライダーと+-ボタン
  Widget soundSettingRow(SoundSettingInfo soundSettingInfo) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 100.0),
      child: Row(
        children: [
          // タッチ音1 選択
          soundName(soundSettingInfo),
          // 音量： 0
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0,),
            child: Obx(() {
              debugPrint("dispVolume");
              return dispVolume(soundSettingInfo);
            }),
          ),
          // マイナスボタン
          VolumeButton(
            soundSettingInfo: soundSettingInfo,
            volumeButtonAction: VolumeButtonAction.down,
          ),
          // スライダー
          Obx(() {
            debugPrint("volumeSlider");
            return Expanded(
              child: volumeSlider(soundSettingInfo),
            );
          }),
          // プラスボタン
          VolumeButton(
            soundSettingInfo: soundSettingInfo,
            volumeButtonAction: VolumeButtonAction.up,
          ),
        ],
      ),
    );
  }

  /// 音の名称と"選択"ボタン
  Widget soundName(SoundSettingInfo soundSettingInfo) {
    final soundSettingController = Get.put(SoundSettingController());
    return Row(
      children: [
        SizedBox(
          width: 220.0,
          child: Obx(() =>
              Text( // タッチ音 + 選択番号
                soundSettingController.getSoundName(soundSettingInfo),
                style: const TextStyle(
                  fontSize: BaseFont.font22px,
                  fontFamily: BaseFont.familyDefault,
                ),
              )),
        ),
        Visibility(
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          visible: soundSettingInfo.numList.length > 1,
          child: ElevatedButton(
            onPressed: () async {
              // 選択画面へ遷移する
              soundSettingController.goToSelectionPage(soundSettingInfo);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: BaseColor.soundSettingButtonBackgroundColor,      // 選択ボタンの色
              foregroundColor: Colors.white,
              minimumSize: const Size(80.0, 40.0),
            ),
            child: const Text(
              '選択',
              style: TextStyle(
                fontSize: BaseFont.font18px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 現在の値を表示する（音量：１のように）
  Widget dispVolume(SoundSettingInfo soundSettingInfo) {
    return SizedBox(
      width: 96.0,
      child: Row(
        children: [
          const Text(
            '音量:',
            style: TextStyle(
              fontSize: BaseFont.font22px,
              fontFamily: BaseFont.familyDefault,
            ),
          ),
          const Spacer(),
          Text(
            '${soundSettingInfo.volume}',
            style: const TextStyle(
              fontSize: BaseFont.font22px,
              fontFamily: BaseFont.familyDefault,
            ),
          ),
        ],
      ),
    );
  }

  /// スライダー
  Widget volumeSlider(SoundSettingInfo soundSettingInfo) {
    final soundSettingController = Get.put(SoundSettingController());
    return SliderTheme(
      // Sliderの色設定
      // https://qiita.com/ikemura23/items/1fcb43bfa06a5ff064f1
      data: SliderTheme.of(Get.context!).copyWith(
        trackHeight: 4.0,                                                               // 線の太さ
        thumbColor: BaseColor.soundSettingSliderBackgroundColor,                        // つまみの色
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),              // つまみの大きさ
        overlayColor: BaseColor.soundSettingSliderBackgroundColor.withAlpha(0),         // つまみを掴んだ時のエフェクト
        activeTrackColor: BaseColor.soundSettingSliderBackgroundColor,                  // 線の色（アクティブ）
        inactiveTrackColor: BaseColor.soundSettingSliderBackgroundColor.withAlpha(60),  // 線の色（インアクティブ）
      ),
      child: Slider(
        value: soundSettingInfo.volume.value.toDouble(),
        min: SoundSettingController.volumeMin,
        max: SoundSettingController.volumeMax,
        onChanged: (value) {
          // スライダーで音量を調整する
          soundSettingController.volumeChange(soundSettingInfo, value.round());
        },
        onChangeEnd: (value) {
          // 変更した音量を確定させる
          soundSettingController.decideSoundVolume(soundSettingInfo);
        },
      ),
    );
  }

  /// キャンセルボタン
  List<Widget> buildActions(BuildContext context,) {
    final soundSettingController = Get.put(SoundSettingController());
    return <Widget>[
      TextButton(
        onPressed: () {
          // 一つ前の画面に戻る
          soundSettingController.backToPreviousPage();
        },
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.close,
              color: BaseColor.someTextPopupArea,
              size: 45,
            ),
            const SizedBox(
              width: 19,
            ),
            Text(
              'l_cmn_cancel'.trns,
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font18px,
              ),
            ),
          ],
        ),
      ),
    ];
  }

}