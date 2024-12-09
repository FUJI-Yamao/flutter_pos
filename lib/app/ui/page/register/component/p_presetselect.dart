/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import '../controller/c_presetscroll_controller.dart';
import 'w_plubuttonarea.dart';
import 'w_preset_scroll_button.dart';
import '../controller/c_registerpluare_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../common/basepage/common_base.dart';

///　プリセット選択画面
class PresetSelectPage extends CommonBasePage {
  PresetSelectPage({
    super.key,
    super.title = "プリセット選択",
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(cancelButtonText: 'l_cmn_close');

  @override
  Widget buildBody(BuildContext context) {
    return PresetSelectBody();
  }
}

///　プリセット選択ボディ
class PresetSelectBody extends StatefulWidget {
  @override
  _PresetSelectBodyState createState() => _PresetSelectBodyState();
}

///　プリセット選択ステート
class _PresetSelectBodyState extends State<PresetSelectBody> {
  /// 1行のボタン数
  static const int btnPerRow = 2;

  /// 行数
  static const int rowPerSection = 6;

  ///　１セクションあたりのボタン数
  static const int itemPerSection = rowPerSection * btnPerRow;

  ///　１ページあたりのセクション数
  static const int sectionPerPage = 2;

  ///　コントローラー
  final PluAreaController pluAreaCtrl = Get.find();

  /// スクロールボタンコントローラー
  final PresetScrollController presetScrollCtrl = PresetScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      ///PLUボタンプリセットデータのセクション数の計算
      ///１セクションは12個のプリセットデータが含まれる
      ///２列６行の12個
      int totalSections =
          (pluAreaCtrl.pluBtnData.length / itemPerSection).ceil();

      /// ページ数の計算　１ページには2セクションが含まれる
      int pageCount = (totalSections / sectionPerPage).ceil();
      return Padding(
        padding:
            EdgeInsets.only(top: 60.h, bottom: 24.h, left: 70.w, right: 70.w),
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: constraints.maxWidth,
                          height: 510.h,
                          child: ScrollbarTheme(
                            data: ScrollbarThemeData(
                              thickness: MaterialStateProperty.all(5.0),
                            ),
                            child: Scrollbar(
                              controller: presetScrollCtrl,
                              thumbVisibility: true,
                              child: PageView.builder(
                                controller: presetScrollCtrl,
                                scrollDirection: Axis.horizontal,
                                itemCount: pageCount,
                                itemBuilder: (context, index) {
                                  //　startIndexを計算　１ページには24個のボタンが含まれる
                                  int startIndex =
                                      index * itemPerSection * sectionPerPage;
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildPresetContainer(startIndex),
                                      buildDivider(),
                                      buildPresetContainer(
                                          startIndex + itemPerSection)
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 24.h,
                        ),
                        child: PresetScrollButton(
                            presetScrollCtrl: presetScrollCtrl,
                            scrollWidth: constraints.maxWidth),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  /// 分割線
  Widget buildDivider() {
    return Container(
      width: 1,
      height: 472.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      color: BaseColor.edgeBtnColor,
    );
  }

  ///指定されたstartIndexからプリセットボタンのコンテナを作成
  Widget buildPresetContainer(
    int startIndex,
  ) {
    return SizedBox(
      width: 425.w,
      child: PresetButtons(
        startIndex: startIndex,
        rowPerSection: rowPerSection,
        btnPerRow: btnPerRow,
      ),
    );
  }
}

///　Pluボタンを動的に2個作成して戻す
class PresetButtons extends StatelessWidget {
  ///　インデックス
  final int startIndex;

  /// 行数
  final int rowPerSection;

  /// 1行のボタン数
  final int btnPerRow;

  /// コンストラクタ
  const PresetButtons({
    super.key,
    required this.startIndex,
    required this.rowPerSection,
    required this.btnPerRow,
  });

  @override
  Widget build(BuildContext context) {
    ///　コントローラー
    PluAreaController pluAreaCtrl = Get.find();
    return SizedBox(
      width: 425.w,
      child: Column(
        children: List.generate(rowPerSection, (row) {
          return Column(
            children: [
              Row(
                children: List.generate(btnPerRow, (col) {
                  int currentIndex = startIndex + row * btnPerRow + col;
                  return currentIndex < pluAreaCtrl.pluBtnPresetData.length
                      ? Container(
                          padding: EdgeInsets.only(right: col == 0 ? 8.w : 0),
                          child: buildChild(currentIndex),
                        )
                      : const Spacer();
                }),
              ),
              //間隔の追加
              if (row < rowPerSection - 1) SizedBox(height: 8.h),
            ],
          );
        }),
      ),
    );
  }

  ///　指定されたインデックスに基づいて適切なWidgetを作成
  Widget buildChild(int index) {
    ///コントローラー
    PluAreaController pluAreaCtrl = Get.find();

    if (index < pluAreaCtrl.pluBtnData.length) {
      var item = pluAreaCtrl.pluBtnData[index];
      return PluWidget(
          dispData: item,
          visible: true,
          widgetMargin: EdgeInsets.zero,
          onTapCallback: () {
            Get.back();
          });
    } else {
      return const SizedBox.shrink();
    }
  }
}
