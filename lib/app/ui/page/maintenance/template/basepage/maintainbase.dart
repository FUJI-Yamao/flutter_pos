/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../colorfont/c_basecolor.dart';
import '../../../../colorfont/c_basefont.dart';
import '../../../../component/w_btn.dart';
import '../../../../component/w_sound_buttons.dart';
import '../../../../language/l_languagedbcall.dart';
import '../../../../menu/register/enum/e_register_page.dart';

/// メンテンナスページ共通UI
abstract class MaintainBasePage extends StatelessWidget {
  /// コンストラクタ
  MaintainBasePage({
    super.key,
    required this.title,
    required String currentBreadcrumb,
    this.isVisibleMaintenanceFinishButton = false,
  }) {
    /// パンくずリストの設定
    _setBreadcrumb(currentBreadcrumb);
  }

  /// パンくずリストのセパレーター
  static const breadcrumbSeparator = '/';

  /// 画面タイトル
  final String title;

  /// パンくずリストの文字列
  late final String breadcrumb;

  /// 「メンテナンスを終了」ボタンの表示フラグ
  final bool isVisibleMaintenanceFinishButton;

  /// 「メンテナンスを終了」ボタン、もしくは、戻るボタンを押したときの処理
  Future<bool> onEndMaintenancePage() async {
    return true;
  }

  /// 「メンテナンスを終了」ボタン
  List<Widget> maintenanceFinishButton() {
    String callFunc = 'maintenanceFinishButton';
    return [
      Container(
        margin: EdgeInsets.only(top: 5.h, right: 15.w, bottom: 5.h),
        child: SoundOutlinedButton(
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(245, 50),
            side: const BorderSide(
              color: BaseColor.someTextPopupArea,
              ///枠線の色
            ),
          ),
          callFunc: callFunc,
          onPressed: () async {
            // 「メンテナンスを終了」ボタン、もしくは、戻るボタンを押したときの処理
            if (await onEndMaintenancePage()) {
              // メインメニュー画面まで戻る
              Get.until(ModalRoute.withName(RegisterPage.mainMenu.routeName));
            }
          },
          child: Padding(
            padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
            child: Text(
              'l_cmn_mente_end'.trns,
              style: const TextStyle(
                  fontSize: BaseFont.font18px,
                  letterSpacing: 1,
                  color: BaseColor.someTextPopupArea,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    ];
  }

  /// AppBar下のヘッダーUI.
  /// ツリーを表示しない場合はオーバーライドしてnullを返す.
  Widget? header(BuildContext context) {
    // パンくずリストも文字列を'/'で分割して、リストにする
    List<String> breadcrumbList = breadcrumb.split(breadcrumbSeparator);
    // パンくずリストは2階層目から表示する
    if (breadcrumbList.length > 1) {
      /// パンくずリスト
      return _createBreadcrumbList(breadcrumbList);
    } else {
      return null;
    }
  }

  /// パンくずリストの表示
  Widget _createBreadcrumbList(List<String> breadcrumbList) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 80.0, right: 80.0),
      color: BaseColor.maintainButtonAreaBG.withOpacity(0.5),   // 背景色
      child: Row(
        children: [
          Text.rich(
            TextSpan(   // RichTextを使用するとフォントが引き継がれないので、Text.richを使用する
              style: const TextStyle(fontSize: BaseFont.font18px, color: BaseColor.someTextPopupArea),
              children: [
                for (int index = 0; index < breadcrumbList.length; index++) ...{
                  if (index != 0) ...{
                    const WidgetSpan(
                      child: Icon(
                        Icons.navigate_next,
                        size: BaseFont.font18px,
                        color: BaseColor.someTextPopupArea,
                      ),
                    ),
                    TextSpan(text: breadcrumbList[index]),
                  } else ...{
                    TextSpan(text: breadcrumbList[index]),
                  }
                }
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// body
  /// 表示したい内容をオーバーライドして定義する.
  Widget body(BuildContext context);

  /// body.expandedで画面に合わせて最大幅まで拡張する.
  Widget _bodyExpanded(BuildContext context) {
    return Expanded(child: body(context));
  }

  /// body下のフッターUI.
  /// フッターを定義するときはオーバーライド
  Widget? footer(BuildContext context) {
    return null;
  }

  /// ページに表示する内容.
  /// header+body+footerのWidgetListを返す.
  List<Widget> _pageContents(BuildContext context) {
    List<Widget> bodyList = [];
    Widget? headerWidget = header(context);
    if (headerWidget != null) {
      bodyList.add(headerWidget);
    }
    bodyList.add(_bodyExpanded(context));
    Widget? footerWidget = footer(context);
    if (footerWidget != null) {
      bodyList.add(footerWidget);
    }
    return bodyList;
  }

  /// backボタンを押したときの処理.
  Future<void> onBack() async {
    // 「メンテナンスを終了」ボタン、もしくは、戻るボタンを押したときの処理
    if (await onEndMaintenancePage()) {
      // 前画面に戻る
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          // 左側のアイコン
          leadingWidth: 80.w,
          leading: SoundElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: BaseColor.someTextPopupArea,
                  backgroundColor: BaseColor.maintainButtonAreaBG,
                  padding: EdgeInsets.zero,
                  minimumSize: Size(80.w, 50.h),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)))),
              onPressed: onBack,
              callFunc: '${runtimeType.toString()} title $title',
              child: const Icon(
                Icons.arrow_back,
                size: 50,
              )),
          backgroundColor: BaseColor.maintainTitleBG,
          // タイトルテキスト
          title:
              Text(title, style: const TextStyle(fontSize: BaseFont.font24px)),

          actions: isVisibleMaintenanceFinishButton ? maintenanceFinishButton() : null,
        ),
        body: Container(
          color: BaseColor.maintainBaseColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _pageContents(context),
          ),
        ));
  }

  /// キャンセルボタン、決定ボタンの配置
  Widget cancelDecideButton(
      {required Function onCancel,
      required Function onDecide,
      String cancelStr = "",
      String decideStr = ""}) {
    return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BorderButton(
              width: 209.w,
              height: 80.h,
              text: cancelStr.isEmpty ? 'l_cmn_cancel'.trns : cancelStr,
              backgroundColor: BaseColor.maintainBaseColor,
              onTap: onCancel),
          SizedBox(
            width: 20.w,
          ),
          GradientBorderButton(
            width: 209.w,
            height: 80.h,
            text: decideStr.isEmpty ? '決定' : decideStr,
            onTap: onDecide,
          )
        ]);
  }

  /// パンくずリストの設定
  void _setBreadcrumb(String currentBreadcrumb) {
    // パンくずリストに文字列が設定されているか確認
    if (currentBreadcrumb.isNotEmpty) {
      // パンくずリストも文字列を'/'で分割して、リストにする
      List<String> breadcrumbList = currentBreadcrumb.split(breadcrumbSeparator);

      // パンくずリストの最後の画面が、titleと異なる時にパンくずリストに追加する。
      // 例：ネットワーク画面を開いたときには、パンくずリストにネットワークを追加するが、
      // ネットワーク画面からIPアドレス入力画面を開いたときには、titleはネットワークのままなので、
      // パンくずリストには追加しないようにする
      if (breadcrumbList[breadcrumbList.length - 1] != title) {
        breadcrumb = '$currentBreadcrumb/$title';
      } else {
        breadcrumb = currentBreadcrumb;
      }
    } else {
      // パンくずリストが空文字の場合は、titleの文字列を追加する
      breadcrumb = title;
    }
  }
}
