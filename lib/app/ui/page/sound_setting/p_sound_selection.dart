/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_ignore_scrollbar.dart';
import '../../language/l_languagedbcall.dart';
import 'component/w_dicision_button.dart';
import 'component/w_safe_ink_well.dart';
import 'component/w_scroll_button.dart';
import 'controller/c_sound_selection_controller.dart';
import 'controller/c_sound_setting_controller.dart';

/// 音の選択画面
class SoundSelectionPage extends StatelessWidget {

  /// コンストラクタ
  SoundSelectionPage({
    super.key,
    required SoundSettingTarget soundSettingTarget,
    required SoundSettingInfo soundSettingInfo,
  }) {
    soundSelectionController = Get.put(SoundSelectionController(
      soundSettingTarget: soundSettingTarget,
      soundSettingInfo: soundSettingInfo,
    ));
  }

  /// 音の選択画面のコントローラー
  late final SoundSelectionController soundSelectionController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '音の選択',
          style: TextStyle(
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
                '一覧から鳴らしたい音を選択し、決定ボタンを押下することで、変更できます。\n'
                    'キャンセルを押下した場合は、変更されません。',
                maxLines: 2,
                style: TextStyle(
                  fontSize: BaseFont.font22px,
                  fontFamily: BaseFont.familyDefault,
                  height: 1.2,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: BaseColor.soundSettingPageBackgroundColor,
              border: Border(
                bottom: BorderSide(
                  width: 2.0,
                  style: BorderStyle.none,
                ),
              ),
            ),
            child: Center(
              child: Text(
                soundSelectionController.soundSettingTarget.name,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: BaseFont.font22px,
                  fontFamily: BaseFont.familyDefault,
                  color: BaseColor.soundSettingTabSelectedForegroundColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: BaseColor.soundSettingPageBackgroundColor,
              child: _valueListWithScrollButton(),
            ),
          ),
          Container(
            color: BaseColor.soundSettingPageBackgroundColor,
            padding: const EdgeInsets.only(top: 20.0, bottom: 40.0, right: 116.0),
            // 決定ボタン
            child: decideButton(),
          ),
        ],
      ),
    );
  }

  /// リスト表示とスクロールボタン表示
  Widget _valueListWithScrollButton() {
    return LayoutBuilder(builder: (buildContext, boxConstraints) {
      debugPrint('$boxConstraints');
      return Stack(
        children: [
          // リスト表示
          _valueList(),
          // スクロールボタンの表示
          Obx(() => (soundSelectionController.isScrollable.value)
              ? Positioned(
                  left: 0,
                  bottom: 0,
                  child: SoundSettingScrollButton(
                    pageHeight: boxConstraints.maxHeight,
                    soundScrollController: soundSelectionController.soundScrollController,
                  ),
                )
              : Container(),
          ),
        ],
      );
    });
  }

  /// リスト表示
  Widget _valueList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: IgnoreScrollbar(
        scrollController: soundSelectionController.soundScrollController,
        child: _createListView(),
      ),
    );
  }

  /// ListView作成
  Widget _createListView() {
    return ListView.builder(
      controller: soundSelectionController.soundScrollController,
      itemCount: soundSelectionController.soundSettingInfo.numList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 100.0),
          child: Stack(
            children: [
              Obx(() => DecoratedBox(
                decoration: BoxDecoration(
                  color: soundSelectionController.isSelected(index)
                      ? BaseColor.soundSelectInColor
                      : BaseColor.soundUnSelectInColor,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: soundSelectionController.isSelected(index)
                        ? BaseColor.soundSelectLineColor
                        : BaseColor.soundUnSelectLineColor,
                    width: soundSelectionController.isSelected(index) ? 4.0 : 1.0,
                  ),
                ),
                child: Container(
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '${soundSelectionController.soundSettingInfo.soundSettingKind.name}'
                        '${soundSelectionController.soundSettingInfo.numList[index]}',
                    maxLines: 1,
                    style: const TextStyle(
                      color: BaseColor.baseColor,
                      fontSize: BaseFont.font28px,
                    ),
                  ),
                ),
              )),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: SafeInkWell(
                    borderRadius: BorderRadius.circular(4.0),
                    onTap: () {
                      // 現在選択されている音の選択番号を、選択番号の一覧を持つnumListの内、
                      // 選択されたindex番目に入っている値に書き換える
                      soundSelectionController.setSelectedSoundNum(index);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 決定ボタンの配置
  Widget decideButton() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SoundSelectionDecisionButton(
            onTap: () {
              // 変更した音の選択番号を確定させる
              soundSelectionController.decideSoundNum();
            },
          ),
        ]
    );
  }

  /// 画面右上のキャンセルボタン
  List<Widget> buildActions(BuildContext context,) {
    return <Widget>[
      TextButton(
        onPressed: () {
          // 選択画面から一つ前の画面に戻る
          soundSelectionController.backToPreviousPage();
        },
        child: Row(
          children: <Widget>[
            const Icon(Icons.close, color: BaseColor.someTextPopupArea, size: 45,),
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