/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_ignore_scrollbar.dart';
import '../../component/w_scroll_button.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/component/w_dicisionbutton.dart';
import 'controller/c_batch_report_controller.dart';
import 'model/m_batch_report_info.dart';

/// 予約レポートの出力ページ
class BatchReportOutputPage extends StatelessWidget {
  /// 項目名一覧
  static const List<String> columnTitleList = ["選択", "番号", "予約名称", "出力レポート"];
  /// 項目ごとの割合
  static const List<int> flexList = [2, 2, 5, 8];
  /// 選択項目のフォントサイズ
  static const double itemFontSize = BaseFont.font22px;
  /// 出力レポートのフォントサイズ
  static const double outputReportFontSize = BaseFont.font16px;

  const BatchReportOutputPage({super.key});

  @override
  Widget build(BuildContext context) {
    BatchReportOutputController batchReportOutputController = Get.put(BatchReportOutputController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '予約レポートの出力',
          style: TextStyle(
            color: BaseColor.someTextPopupArea,
            fontSize: BaseFont.font28px,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: BaseColor.baseColor.withOpacity(0.7),
        actions: buildActions(context),
      ),
      body: Container(
        color: BaseColor.batchReportOutputPageBackgroundColor,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              height: 88.0,
              color: BaseColor.batchReportOutputPageCommentBackgroundColor,  // 説明文の背景色
              child: const Center(
                child: Text(
                  '設定されたレポート群を印字します。\nレポートを選択して印字ボタンを押してください。',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: BaseFont.font22px,
                    fontFamily: BaseFont.familyDefault,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  children: [
                    // 16.0 + ボタン72.0
                    const SizedBox(width: 88.0,),
                    Expanded(
                      child: Column(
                        children: [
                          // 表のタイトル
                          createRowTitles(),
                          // 表の中身
                          createRow(batchReportOutputController),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0,),
                    // スクロールボタンの表示
                    Obx(() => (batchReportOutputController.isScrollable.value)
                        ? ScrollButton(
                          pageHeight: constraints.maxHeight,
                          scrollButtonAndBarController: batchReportOutputController.batchReportScrollController,
                        )
                        : const SizedBox(width: 72.0,),
                    ),
                  ],
                );
              },),
            ),
            // ボタンとリストの余白
            const SizedBox(height: 20.0,),
            // その他レポート、印字ボタン
            Row(
              children: [
                // 16.0 + スクロールボタン72.0
                const SizedBox(width: 88.0,),
                // リストの端からボタンまでの余白
                const SizedBox(width: 60.0,),
                // その他レポートボタン
                Visibility(
                  visible: false,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: DecisionButton(// TODO: 必要なタイミングで中身を実装
                    oncallback: () {
                    },
                    text: 'その他レポート',
                  ),
                ),
                // ボタンの間の余白
                Expanded(child: Container(),),
                // 印字ボタン
                DecisionButton(
                  oncallback: () => batchReportOutputController.onReport(),
                  text: '印字',
                ),
                // リストの端からボタンまでの余白
                const SizedBox(width: 60.0,),
                // 16.0 + スクロールボタン72.0
                const SizedBox(width: 88.0,),
              ],
            ),
            // ボタンと画面下端の余白
            const SizedBox(height: 20.0,),
          ],
        ),
      ),
    );
  }

  /// 予約レポートのタイトルを表示
  Widget createRowTitles() {
    const double rowTitleHeight = 50;
    return Container(
      color: BaseColor.maintainBaseColor,
      child: Row(
          children: [
            for (int i = 0; i < columnTitleList.length; i++)
              Expanded(
                flex: flexList[i],
                child: Container(
                  height: rowTitleHeight,
                  alignment: i != 0 ? Alignment.centerLeft : Alignment.center,
                  padding: i != 0
                            ? const EdgeInsets.only(left: 20.0)
                            : EdgeInsets.zero,
                  child: Text(
                    columnTitleList[i],
                    style: const TextStyle(
                      fontFamily: BaseFont.familyDefault,
                      color: BaseColor.storeOpenCloseWhiteColor,
                      fontSize: BaseFont.font22px,
                    ),
                  ),
                ),
              ),
          ]
      ),
    );
  }

  /// 予約レポートの一覧を表示
  Widget createRow(BatchReportOutputController batchReportOutputController) {
    return Expanded(
      child: IgnoreScrollbar(
        scrollController: batchReportOutputController.batchReportScrollController,
        child: Obx(() {
          return ListView.builder(
            controller: batchReportOutputController.batchReportScrollController,
            itemCount: batchReportOutputController.batchReportDetailList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  createRowDetail(index, batchReportOutputController),
                  const Divider(
                    height: 1.0,
                    color: Colors.black,
                    indent: 20.0,
                    endIndent: 20.0,
                    // endIndent: 16.0,
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }

  /// 項目行のListを返す.
  Stack createRowDetail(int index, BatchReportOutputController batchReportOutputController) {
    List<Widget> outputReportWidget = [];   // 出力レポートリスト
    // 出力レポートのフォントサイズ４行分+各行の上下に余白8px5行分
    const double rowHeight = (outputReportFontSize * 4) + (8.0 * 5);
    // 出力レポートの内容
    outputReportWidget = getOutputReport(
        outputReportWidget,
        batchReportOutputController.batchReportDetailList[index].batchReportOrderDetailList
    );
    String callFunc = 'createRowDetail';
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              flex: flexList[0],
              child: Center(
                child: SizedBox(
                  height: rowHeight,
                  child: FractionallySizedBox(
                    widthFactor: 0.6,
                    heightFactor: 0.6,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Obx(() {
                        if (batchReportOutputController.batchReportDetailList[index].isChecked.value) {
                          return const Icon(
                            Icons.check,
                            size: 32.0, // デフォルトは14.0
                          );
                        } else {
                          return Container();
                        }
                      },),
                    ),
                  ),
                ),
              ),
            ),
            // 番号
            Expanded(
              flex: flexList[1],
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  batchReportOutputController.batchReportDetailList[index].batchNo.toString().padLeft(4, '0'),
                  maxLines: 1,
                  style: const TextStyle(
                    fontFamily: BaseFont.familyNumber,
                    color: BaseColor.storeCloseBlack54Color,
                    fontSize: itemFontSize,
                  ),
                ),
              ),
            ),
            // 予約名称
            Expanded(
              flex: flexList[2],
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  batchReportOutputController.batchReportDetailList[index].batchName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: BaseFont.familyDefault,
                    color: BaseColor.storeCloseBlack54Color,
                    fontSize: itemFontSize,
                  ),
                ),
              ),
            ),
            // 出力レポート
            Expanded(
              flex: flexList[3],
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: outputReportWidget,
                ),
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: SoundInkWell(
              onTap: () {
                batchReportOutputController.updateCheckState(index);
              },
              callFunc: callFunc,
            ),
          ),
        ),
      ],
    );
  }

  /// キャンセルボタン
  List<Widget> buildActions(BuildContext context,) {
    String callFunc = 'buildActions';
    return <Widget>[
      SoundTextButton(
        onPressed: () {
          // 一つ前の画面に戻る
          Get.back();
        },
        callFunc: '$callFunc ${'l_cmn_cancel'.trns}',
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

  /// 出力レポートの内容を追加する
  List<Widget> getOutputReport (List<Widget> outputReportWidget, List<BatchReportOrderDetail> batchReportOrderDetailList) {
    // 出力レポートを取得
    int reportAmount = batchReportOrderDetailList.length;
    for (int i = 0; i <= reportAmount - 1; i++) {
      if (reportAmount < 5) {
        outputReportWidget.add(
          outputReportDetail(batchReportOrderDetailList[i].batchReportNoName,),
        );
      } else {
        if (i < 3) {
          outputReportWidget.add(
            outputReportDetail(batchReportOrderDetailList[i].batchReportNoName,),
          );
        } else {
          outputReportWidget.add(
            outputReportDetail('…'),
          );
          break;
        }
      }
    }
    // 余白用
    outputReportWidget.add(const SizedBox(height: 8.0,),);
    return outputReportWidget;
  }

  /// 出力レポートの詳細
  Widget outputReportDetail(String reportText,) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 8.0,),
      child: Text(
        reportText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontFamily: BaseFont.familyDefault,
          color: BaseColor.storeCloseBlack54Color,
          fontSize: outputReportFontSize,
        ),
      ),
    );
  }

}