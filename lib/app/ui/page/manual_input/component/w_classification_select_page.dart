/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/page/common/basepage/common_base.dart';
import 'package:flutter_pos/app/ui/page/manual_input/controller/c_mglogininput_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../regs/checker/rcky_mg.dart';
import '../../../component/w_sound_buttons.dart';

///分類登録選択ページの構築
class ClassificationSelectionPage extends CommonBasePage {
  ClassificationSelectionPage({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
          String className = '分類選択ページ';
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
                  const Text('キャンセル',
                      style: TextStyle(
                          color: BaseColor.someTextPopupArea,
                          fontSize: BaseFont.font18px)),
                ],
              ),
            ),
          ];
        });

  @override
  Widget buildBody(BuildContext context) {
    return const ClassificationSelectionBody();
  }
}

///分類登録構築ボディー
class ClassificationSelectionBody extends StatefulWidget {
  const ClassificationSelectionBody({super.key});

  @override
  State<StatefulWidget> createState() => _ClassificationSelectionBodyState();
}

///分類登録構築状態
class _ClassificationSelectionBodyState
    extends State<ClassificationSelectionBody> {
  final MGLoginInputController mgLogCtrl = Get.find<MGLoginInputController>();

  ///アイテムリスト
  List<ManualSmlCls> classificationList = [];

  ///最初のデータであるかどうか
  bool _canScrollUp = false;

  ///最新のデータであるかどうか
  bool _canScrollDown = true;

  /// ScrollControllerインスタンス作成
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    classificationList = mgLogCtrl.listClsCode ?? [];
    _scrollController.addListener(_scrollingListener);
    _checkShowScroller();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ///スクロール必要かどうかのチェック処理
  void _checkShowScroller() {
    int maxDisplayItems = 21;
    if (classificationList.length <= maxDisplayItems) {
      _canScrollUp = false;
      _canScrollDown = false;
    }
  }

  /// スクロールの動きを検知する
  void _scrollingListener() {
    if (!mounted) return;
    setState(() {
      _canScrollUp = _scrollController.offset > 0;
      _canScrollDown =
          _scrollController.offset < _scrollController.position.maxScrollExtent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.receiptBottomColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: const Center(
            child: Text(
              textAlign: TextAlign.center,
              '分類を選択してください',
              style: TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 40.h,
            left: 60.w,
            right: 84.w,
            child: SizedBox(
              height: 440.h,
              width: 880.w,
              child: _buildClassGrid(),
            ),
          ),
          if (_canScrollUp || _canScrollDown)
            Positioned(
              left: 0,
              right: 0,
              bottom: 40.h,
              child: Center(
                child: _buildScrollButtons(),
              ),
            ),
          if (_canScrollDown)
            Positioned(
              top: 40.h,
              right: 32.w,
              bottom: 40.h,
              child: _buildCustomScrollBar(),
            ),
          Positioned(
            left: 32.w,
            bottom: 32.h,
            child: _buildBackButton(),
          ),
        ],
      ),
    );
  }

  ///分類登録エリアの構築
  Widget _buildClassGrid() {
    const int itemsRow = 3;

    return GridView.builder(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemsRow,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          childAspectRatio: 288 / 56,
        ),
        itemCount: classificationList.length,
        itemBuilder: (context, index) {
          ManualSmlCls classification = classificationList[index];
          return _buildClassItem(classification);
        });
  }

  ///分類アイテムの構築
  Widget _buildClassItem(ManualSmlCls classification) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, classification);
      },
      child: Container(
        width: 288.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: BaseColor.someTextPopupArea,
          border: Border.all(
            color: BaseColor.baseColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Text(
          '[${classification.clsNo}] ${classification.itemName}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: BaseFont.font18px,
            color: BaseColor.baseColor,
            fontFamily: BaseFont.familyDefault,
          ),
        ),
      ),
    );
  }

  ///前の画面に戻るボタン
  Widget _buildBackButton() {
    return SizedBox(
      width: 200.w,
      height: 56.h,
      child: SoundElevatedButton(
        onPressed: () {
          Get.back();
        },
        callFunc: runtimeType.toString(),
        style: ElevatedButton.styleFrom(
          backgroundColor: BaseColor.otherButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 3,
          shadowColor: BaseColor.scanBtnShadowColor,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SvgPicture.asset(
            'assets/images/icon_back_fullself.svg',
            width: 23.w,
            height: 28.h,
          ),
          SizedBox(width: 8.w),
          const Text(
            '前の画面に戻る',
            style: TextStyle(
                fontSize: BaseFont.font18px,
                color: BaseColor.someTextPopupArea,
                fontFamily: BaseFont.familySub),
          ),
        ]),
      ),
    );
  }

  ///スクロールバー
  Widget _buildCustomScrollBar() {
    return SizedBox(
      width: 8.w,
      height: 424.h,
      child: CustomScrollBar(_scrollController),
    );
  }

  ///上下スクロールボタン
  Widget _buildScrollButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Opacity(
          opacity: _canScrollUp ? 1.0 : 0.3,
          child: Container(
            width: 64.w,
            height: 48.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: BaseColor.otherButtonColor,
            ),
            child: SoundInkWell(
              onTap: _canScrollUp ? _scrollUp : () {},
              callFunc: runtimeType.toString(),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/up.svg',
                  width: 30.w,
                  height: 18.h,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 24.w,
        ),
        Opacity(
          opacity: _canScrollDown ? 1.0 : 0.3,
          child: Container(
            width: 64.w,
            height: 48.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: BaseColor.otherButtonColor),
            child: SoundInkWell(
              onTap: _canScrollDown ? _scrollDown : () {},
              callFunc: runtimeType.toString(),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/down.svg',
                  width: 30.w,
                  height: 18.h,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///上スクロールボタン押したときのメソッド　距離調整可能
  void _scrollUp() {
    final double scrollAmount = 56.h * 2;
    final double newOffset = (_scrollController.offset - scrollAmount).clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.animateTo(newOffset,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  ///下スクロールボタン押したときのメソッド
  void _scrollDown() {
    final double scrollAmount = 56.h * 2;
    final double newOffset = (_scrollController.offset + scrollAmount).clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.animateTo(newOffset,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }
}

///カスタマイズスクロールバーの構築
class CustomScrollBar extends StatefulWidget {
  const CustomScrollBar(this.scrollController, {super.key});

  final ScrollController scrollController;

  @override
  CustomScrollBarState createState() => CustomScrollBarState();
}

///カスタマイズスクロールバーの状態
class CustomScrollBarState extends State<CustomScrollBar> {
  ///スクロールバー
  final double _thumbHeight = 212.h;
  double _thumbPosition = 0.0;

  @override
  void initState() {
    // スクロールの動きを検知するリスナーを設定
    widget.scrollController.addListener(_scrollingListener);

    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollingListener);
    super.dispose();
  }

  /// スクロールの動きを検知する
  void _scrollingListener() {
    if (!mounted) return;
    setState(() {
      double maxScrollExtent = widget.scrollController.position.maxScrollExtent;
      double pixels = widget.scrollController.position.pixels;

      double maxThumbScrollExtent = 424.h - _thumbPosition;

      if (maxScrollExtent > 0) {
        _thumbPosition = (pixels / maxScrollExtent) * maxThumbScrollExtent;
      } else {
        _thumbPosition = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 8.w,
          height: 424.h,
          color: BaseColor.baseColor.withOpacity(0.3),
        ),
        Positioned(
            top: _thumbPosition,
            child: Container(
              width: 8.w,
              height: _thumbHeight,
              color: BaseColor.baseColor,
            ))
      ],
    );
  }
}
