/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../ui/page/register/component/w_purchase_scroll_button.dart';
import '../../../../ui/page/register/component/w_purchasewidget_base.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_ignore_scrollbar.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../menu/register/enum/e_register_page.dart';
import '../controller/c_registerbody_controller.dart';
import 'w_purchasewidget.dart';

/// タブボタン
class TabButtonWidget extends StatelessWidget {
  /// コンストラクタ
  const TabButtonWidget(this.color, this.backColor, {super.key});

  final Color color;
  final Color backColor;

  @override
  Widget build(BuildContext context) {
    ///コントローラー
    RegisterBodyController bodyctrl = Get.find();
    String currentRoute = Get.currentRoute;
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.end,
          direction: Axis.horizontal,
          children: [
            Expanded(
                flex: bodyctrl.tabAdjustmentAreaFit.value, child: Container()),
            if (((currentRoute == RegisterPage.register.routeName
                || currentRoute == RegisterPage.tranining.routeName)
                && bodyctrl.addTabVisibleFlag.value)
              || (currentRoute == '/subtotal'
                && bodyctrl.refundFlag.value == false
                && bodyctrl.transactionManagement.count < RegisterBodyController.maxTabBtnCont))
              Material(
                color: BaseColor.backColor,
                child: SoundInkWell(
                    onTap: () => bodyctrl.addTabButton(currentRoute),
                    callFunc: runtimeType.toString(),
                    child: Container(
                      width: 62.w,
                      height: 36.h,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        size: BaseFont.font22px,
                        color: BaseColor.baseColor,
                      ),
                    )),
              ),
            for (int i = bodyctrl.transactionManagement.count - 1; i >= 0; i--)
              TabWidget(
                bodyctrl: bodyctrl,
                index: i,
                color: color,
                backColor: backColor,
              ),
          ],
        ),
      ),
    );
  }
}

/// タブボタン
class TabWidget extends StatelessWidget {
  /// コンストラクタ
  const TabWidget({
    super.key,
    required this.bodyctrl,
    required this.index,
    required this.color,
    required this.backColor,
  });

  /// コントローラー
  final RegisterBodyController bodyctrl;

  ///インデックス
  final int index;

  /// タブ文字色
  final Color color;

  /// タブ背景色
  final Color backColor;

  @override
  Widget build(BuildContext context) {
    ///コントローラー
    RegisterBodyController bodyCtrl = Get.find();

    return Obx(() => Stack(children: [
      Container(
        alignment: Alignment.center,
        height: 36.h,
        width: 144.w,
        decoration: BoxDecoration(
          color: index == bodyctrl.tabBtnIndex.value ? backColor : backColor.withOpacity(0.5),
          border: bodyCtrl.refundFlag.value
              ? const Border(
                top: BorderSide(color: BaseColor.attentionColor, width: 2),
                left: BorderSide(color: BaseColor.attentionColor, width: 2),
                right: BorderSide(color: BaseColor.attentionColor, width: 2),
                bottom: BorderSide.none,
              ) : null,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child:
        Obx(() => Container(
          alignment: Alignment.center,
          margin:
              EdgeInsets.only(top: 1.h, bottom: 1.h, left: 15.w, right: 15.w),
          decoration: const BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: BaseColor.someTextPopupArea)),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              '${index + 1}',   // インデックスは0スタートなので、+1して表示する
              style: TextStyle(
                fontSize: BaseFont.font18px,
                color: bodyCtrl.refundFlag.value ? BaseColor.baseColor : color,
              ),
            ),
          ),
          ),
        ),
      ),
      Positioned.fill(
        child: Material(
          color: BaseColor.transparent,
          child: SoundInkWell(
            // 現在表示しているタブはタップできない。また、返品時はタブ切替できない
            onTap: index == bodyctrl.tabBtnIndex.value || bodyCtrl.refundFlag.value
                ? null
                : () => bodyCtrl.changeTab(index),
            callFunc: runtimeType.toString(),
            child: null,
          ),
        ),
      )
    ]));
  }
}

/// リスト.アイテムを追加した時にアニメーションをする.
class ListPurchaseAnimatedWidget extends StatefulWidget {
  /// コンストラクタ
  const ListPurchaseAnimatedWidget({super.key});

  @override
  State<ListPurchaseAnimatedWidget> createState() =>
      ListPurchaseAnimatedWidgetState();
}

///　アイテムを追加した時のアニメーションステートクラス
class ListPurchaseAnimatedWidgetState
    extends State<ListPurchaseAnimatedWidget> {
  ///　リストの上部マージン
  static const topMargin = 7.0;

  ///　グローバルキー
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  ///　コントローラー
  RegisterBodyController bodyctrl = Get.find();

//初期化処理
  @override
  void initState() {
    super.initState();
    bodyctrl.setKey(_listKey);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(top: topMargin, bottom: 70.h),
        child: IgnoreScrollbar(
            scrollController: bodyctrl.purchaseScrollController,
            child: AnimatedList(
                controller: bodyctrl.purchaseScrollController,
                key: _listKey,
                initialItemCount: bodyctrl.purchaseData.length,
                itemBuilder: (context, index, animation) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Future.delayed(const Duration(milliseconds: 300), ()
                    {
                      var renderObj = _listKey.currentContext?.findRenderObject();
                      // RenderObjectを取得できない場合は処理終了
                      if (renderObj == null) {
                        return;
                      }

                      // スクロール一回分の高さを取得
                      final RenderBox renderBox = renderObj as RenderBox;
                      bodyctrl.scrollHeight.value = renderBox.size.height;

                  // リスト表示後のボタン状態を設定
                  bodyctrl.setButtonState();
                });
              });
              return _buildItem(index, animation, bodyctrl.purchaseData.length);
            },
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Stack(children: [
          SizedBox(
            height: 62.h,
            width: double.infinity,
            child: Obx(
              () => Visibility(
                visible: bodyctrl.purchaseScrollON.value,
                child: Align(
                  alignment: Alignment.center,
                  child: PurchaseScrollButton(
                    backgroundColor: BaseColor.topCloseButtonColor,
                    purchaseScrollController: bodyctrl.purchaseScrollController,
                    scrollHeight: bodyctrl.scrollHeight.value,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
        Obx(() {
          return Visibility(
            visible: bodyctrl.refundFlag.value && bodyctrl.purchaseData.isEmpty,
            child: const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  '返品したい商品をスキャン\nしてください',
                  style: TextStyle(
                    fontSize: BaseFont.font28px,
                    color: BaseColor.attentionColor,
                  ),
                ),
              ),
            ),
          );
        }),
    ]);
  }

  /// リストのアイテム
  Widget _buildItem(int index, Animation<double> animation, int len) {
    return SizeTransition(
        sizeFactor: animation,
        child: Container(
            padding:  EdgeInsets.only(right: 19.w),
            child: index == 0
                ? PurchaseWidget(
                    index: index, type: PurchaseType.top, length: len) // 大きい明細.
                : PurchaseWidget(
                    index: index,
                    type: PurchaseType.normal,
                    length: len) // 小さい明細.
            ));
  }
}
