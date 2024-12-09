/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'common/environment.dart';
import 'ui/colorfont/c_basefont.dart';
import 'ui/controller/c_common_controller.dart';
import 'ui/controller/c_my_custom_scroll_behavior.dart';
import 'ui/menu/customer/customer_page_manager.dart';
import 'ui/menu/customer/e_customer_page.dart';
import 'ui/model/m_screeen_info.dart';
import 'ui/socket/server/customer_socket_server.dart';

/// 暫定画面　お客様側画面
/// 多言語機能
/// 通信機能　等　予定

/// お客様側画面（サンプル）
class CustomerApp extends StatelessWidget {
  /// コンストラクタ
  const CustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenInfo screenInfo = EnvironmentData().getOwnScreenInfo();

    return ScreenUtilInit(
      designSize: Size(screenInfo.width, screenInfo.height), // 設計ドラフト内のデバイス画面のサイズ (dp 単位)
      minTextAdapt: true, // 幅と高さの最小値に従ってテキストを調整するかどうか
      splitScreenMode: true, // 分割画面のサポート
      builder: (context, child) {
        return GetMaterialApp(
          initialRoute: CustomerPage.logo.routeName,
          getPages: CustomerPageManager.pages(),
          // getPagesを変数でセット
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: BaseFont.familyDefault,
            useMaterial3: false,
          ),
          scrollBehavior: MyCustomScrollBehavior(), // スワイプスクロール設定

          // ソケット通信用
          onInit: () async {
            // 客側通信サーバー起動
            CustomerSocketServer.getServerStart(screenInfo.address, screenInfo.port);

            // 多言語取得
            Get.put(CommonController());
          },
        );
      },
    );
  }
}
