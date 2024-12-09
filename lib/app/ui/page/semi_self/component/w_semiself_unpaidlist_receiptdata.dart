/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../controller/c_unpaid_controller.dart';

///未精算一覧の右側のレシート情報
class UnpaidListRightSection extends StatefulWidget {
  @override
  _UnpaidListRightSectionState createState() => _UnpaidListRightSectionState();
}

class _UnpaidListRightSectionState extends State<UnpaidListRightSection> {
  final UnPaidListController unPaidCtrl = Get.find<UnPaidListController>();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool hasData;
    bool isFirstData;
    bool isLastestData;

    return Obx(() {
      if (unPaidCtrl.print_data.value.isNotEmpty) {
        hasData = unPaidCtrl.print_data.value != "";
      } else {
        hasData = false;
      }
      isFirstData = (currentIndex == 0) && (unPaidCtrl.viewPage.value == 0);
      isLastestData = (currentIndex + (unPaidCtrl.viewPage.value * unPaidCtrl.viewMax.value)) == (unPaidCtrl.unpaidList.length - 1);
      return Container(
        width: 480.w,
        height: 580.h,
        decoration: BoxDecoration(
          border: Border.all(color: BaseColor.baseColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: hasData
                  ? DataView(
                scrollController: unPaidCtrl.dataScrollerController,
                receiptData:
                unPaidCtrl.print_data.split('\\n'),
              )
                  : NoDataView(),
            ),
            //底のボタン部分
            _buildControlButtons(isFirstData, isLastestData, hasData),
          ],
        ),
      );
    });
  }

  Widget _buildControlButtons(
      bool isFirstData, bool isLastestData, bool hasData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //’前のページ’ボタン
        Expanded(
          child: _buildButton(
            label: '前ページ',
            onPressed: isFirstData || !hasData
                ? null
                : () {
                    setState(() {
                      currentIndex--;
                      if (currentIndex < 0) {
                        unPaidCtrl.onPreviousBtn();
                        currentIndex = (currentIndex % unPaidCtrl.viewMax.value);
                      }
                      unPaidCtrl.selectedItem(currentIndex);
                    });
                  },
            isEnable: !isFirstData && hasData,
          ),
        ),

        //’▲’スクロールバーのボタン
        Expanded(
          child: _buildIconButton(
            icon: Icons.arrow_drop_up,
            onPressed: unPaidCtrl.scrollUp,
          ),
        ),

        //’▼’スクロールバーのボタン
        Expanded(
          child: _buildIconButton(
            icon: Icons.arrow_drop_down,
            onPressed: unPaidCtrl.scrollDown,
          ),
        ),

        //’次のページ’ボタン
        Expanded(
          child: _buildButton(
            label: '次ページ',
            onPressed: isLastestData || !hasData
                ? null
                : () {
                    setState(() {
                      currentIndex++;
                      if (currentIndex >= unPaidCtrl.viewMax.value) {
                        unPaidCtrl.onNextBtn();
                        currentIndex = 0;
                      }
                      unPaidCtrl.selectedItem(currentIndex);
                    });
                  },
            isEnable: !isLastestData && hasData,
          ),
        )
      ],
    );
  }

  //’次、後　のページ’　ボタン構築
  Widget _buildButton({
    required String label,
    required VoidCallback? onPressed,
    required bool isEnable,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: BaseColor.baseColor),
        color: BaseColor.transparent,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
              color: isEnable
                  ? BaseColor.baseColor
                  : BaseColor.baseColor.withOpacity(0.3)),
        ),
      ),
    );
  }

  //’▲’’▼’スクロールバーのボタン構築
  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: BaseColor.baseColor),
        color: BaseColor.transparent,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: BaseColor.baseColor,
        ),
      ),
    );
  }
}

///仮のデータがある時の表示画面のスクロールバー
class DataView extends StatefulWidget {
  final ScrollController scrollController;
  final List<String> receiptData;

  const DataView(
      {Key? key, required this.scrollController, required this.receiptData})
      : super(key: key);

  @override
  DataViewState createState() => DataViewState();
}

class DataViewState extends State<DataView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scrollbar(
          controller: widget.scrollController,
          thumbVisibility: true,
          child: ListView.builder(
            controller: widget.scrollController,
            itemCount: widget.receiptData.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  widget.receiptData[index],
                  style: TextStyle(
                    fontSize: BaseFont.font24px,
                    color: BaseColor.baseColor,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

///データがない場合の表示画面
class NoDataView extends StatelessWidget {
  const NoDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '取引なし',
        style: TextStyle(
          fontSize: BaseFont.font24px,
          color: BaseColor.baseColor,
        ),
      ),
    );
  }
}

///カスタマイズスクロールバーの構築
class CustomScrollBar extends StatefulWidget {
  final ScrollController scrollController;

  const CustomScrollBar({required this.scrollController, Key? key})
      : super(key: key);

  @override
  CustomScrollBarState createState() => CustomScrollBarState();
}

class CustomScrollBarState extends State<CustomScrollBar> {
  /// CustomScrollBarの位置（Y軸）
  /// topが-1.0、bottomが1.0
  double _alignmentY = -1.0;

  @override
  void initState() {
    // スクロールの動きを検知するリスナーを設定
    widget.scrollController.addListener(_scrollingListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(1.0, _alignmentY),
      child: SizedBox(
        width: 16,
        height: 300,
        child: Container(
          decoration: BoxDecoration(
            color: BaseColor.scrollerColor.withOpacity(0.7),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  /// スクロールの動きを検知する
  void _scrollingListener() {
    setState(() {
      // スクロール位置
      final position = widget.scrollController.position;
      // スクロール領域に対する現在の位置の比率
      final ratio = position.pixels / position.maxScrollExtent;
      // スクロール位置に対するScrollBarのAlignmentを設定
      _alignmentY = ratio * 2 - 1;
    });
  }
}
