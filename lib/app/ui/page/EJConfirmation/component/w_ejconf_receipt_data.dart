/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/w_sound_buttons.dart';

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

///仮のデータがある時の表示画面のスクロールバー
class DataView extends StatefulWidget {
  final ScrollController _datascrollerController;
  final List<String> receiptData;

  const DataView({super.key, required ScrollController scrollController, required this.receiptData})
      : _datascrollerController = scrollController;

  @override
  DataViewState createState() => DataViewState();
}

class DataViewState extends State<DataView> {

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(right: 8.0.w),
        child: ScrollbarTheme(
          data: const ScrollbarThemeData(
            thumbColor: MaterialStatePropertyAll(BaseColor.transparent),
            trackColor: MaterialStatePropertyAll(BaseColor.transparent),
          ),
          child: Scrollbar(
            controller: widget._datascrollerController,
            thumbVisibility: true,
            child: SizedBox(
              width: 632.w,
              child: ListView.builder(
                controller: widget._datascrollerController,
                itemCount:widget.receiptData.length,
                itemBuilder: (context, index) =>
                  Container(
                    color: BaseColor.someTextPopupArea,
                    child:
                      Text(widget.receiptData[index],
                    style: const TextStyle(
                      fontSize: BaseFont.font22px,
                      fontFamily: BaseFont.familyDefault,
                      color: BaseColor.baseColor,
                    ),
                      ),
                  ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        right: 0,
        top: 8,
        bottom: 8,

        ///この処理はスライダーをドラッグしてスクロールするため
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            int sensitivity = 1;
            if (details.delta.dy > sensitivity) {
              _scrollDown();
            } else if (details.delta.dy < -sensitivity) {
              _scrollUp();
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///上スクロールボタン
              Container(
                width: 40.w,
                height: 64.h,
                decoration: const BoxDecoration(
                  color: BaseColor.scrollerColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: SoundIconButton(
                  onPressed: () {
                    _scrollUp();
                  },
                  callFunc: runtimeType.toString(),
                  icon: const Icon(
                    Icons.arrow_drop_up,
                    color: BaseColor.someTextPopupArea,
                  ),
                ),
              ),

              Expanded(
                child: Stack(children: [
                  Container(
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: BaseColor.scrollerColor.withOpacity(0.2),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: CustomScrollBar(widget._datascrollerController),
                  ),
                ]),
              ),
              Container(
                width: 40.w,
                height: 64.w,
                decoration: const BoxDecoration(
                  color: BaseColor.scrollerColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: SoundIconButton(
                  onPressed: () {
                    _scrollDown();
                  },
                  callFunc: runtimeType.toString(),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: BaseColor.someTextPopupArea,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  ///上スクロールボタン押したときのメソッド　距離調整可能
  void _scrollUp() {
    widget._datascrollerController.animateTo(
      widget._datascrollerController.offset - 250,
      duration: const Duration(microseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  ///下スクロールボタン押したときのメソッド
  void _scrollDown() {
    widget._datascrollerController.animateTo(
      widget._datascrollerController.offset + 250,
      duration: const Duration(microseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}

///カスタマイズスクロールバーの構築
class CustomScrollBar extends StatefulWidget {
  const CustomScrollBar(
    this.scrollController, {super.key}
  );

  final ScrollController scrollController;

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
