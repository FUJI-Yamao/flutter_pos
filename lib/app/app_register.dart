/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// キャッシャー側runapp
/// 多言語機能
/// 通信機能　等追加予定

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/observer/c_register_observer.dart';
import 'package:flutter_pos/app/ui/observer/c_subtotal_observer.dart';
import 'package:flutter_pos/app/ui/socket/client/semiself_socket_client.dart';
import 'package:flutter_pos/app/ui/observer/c_main_menu_observer.dart';
import 'package:flutter_pos/app/ui/socket/client/register2_socket_client.dart';
import 'package:flutter_pos/app/ui/socket/server/register2_socket_server.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app/common/cmn_sysfunc.dart';
import '../app/inc/apl/rxmem_define.dart';
import 'common/cls_conf/mac_infoJsonFile.dart';
import 'common/environment.dart';
import 'inc/lib/typ.dart';
import 'inc/sys/tpr_aid.dart';
import 'lib/apllib/db_comlib.dart';
import 'ui/colorfont/c_basefont.dart';
import 'ui/controller/c_common_controller.dart';
import 'ui/controller/c_my_custom_scroll_behavior.dart';
import 'ui/enum/e_screen_kind.dart';
import 'ui/menu/register/m_menu.dart';
import 'ui/model/m_screeen_info.dart';
import 'ui/page/p_register_start_page.dart';
import 'ui/socket/client/customer_socket_client.dart';

/// キャッシャー側画面
class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenInfo screenInfo = EnvironmentData().getOwnScreenInfo();
    return ScreenUtilInit(
      // 設計ドラフト内のデバイス画面のサイズ (dp 単位)
      designSize: Size(screenInfo.width, screenInfo.height),
      // 幅と高さの最小値に従ってテキストを調整するかどうか
      minTextAdapt: true,
      // 分割画面のサポート
      splitScreenMode: true,

      builder: (context, child) {
        return GetMaterialApp(
          initialRoute: '/',
          getPages: SetMenu1().setScreen1Menu(), // getPagesを変数でセット
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: BaseFont.familyDefault,
            useMaterial3: false,
          ),
          scrollBehavior: MyCustomScrollBehavior(), // スワイプスクロール設定
          home: const RegisterStartPage(),
          navigatorObservers: [
            MainMenuObserver(),
            RegisterObserver(),
            SubtotalObserver(),
          ],

          // ソケット通信用サーバー機能
          onInit: () {
            // 共通コントローラー メモリから開放しない
            var commonCtrl = Get.put(CommonController(), permanent: true);
            commonCtrl.isMainMachine.value = EnvironmentData().screenKind == ScreenKind.register ? true : false;
            RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
            if (xRet.isInvalid()) {
              return;
            }
            RxCommonBuf pCom = xRet.object;

            // 客側通信サーバーへの接続設定（客表有効時のみ起動）
            if (pCom.iniMacInfo.internal_flg.colordsp_cnct == 1) {
              _initializeCustomerSocket();
            }
            // 精算機通信サーバーへの接続設定（精算機モード時のみ起動）
            if (pCom.iniMacInfo.select_self.kpi_hs_mode == 2) {
              _initializeSemiSelfSocket();
            }
            // 卓上/タワー側通信サーバーへの接続設定（タワー型設定時のみ起動）
            if (pCom.iniSys.type.tower == "yes") {
              _initializeRegister2Socket();
            }
          },


        );
      },
    );
  }

  /// 客側通信サーバーへの接続設定
  Future<void> _initializeCustomerSocket() async {
    // 通信先の判定
    ScreenKind dest;
    switch (EnvironmentData().screenKind) {
      case ScreenKind.register2:
      case ScreenKind.register:
      // MacInfoJsonFileの読み込み
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
        if(xRet.isInvalid()){
          return;
        }
        RxCommonBuf pCom = xRet.object;
        Mac_infoJsonFile macInfoJsonFile = pCom.iniMacInfo;

        if (macInfoJsonFile.internal_flg.colordsp_size == 0) {
          // 7インチ客表

          // todo register2未実装時に以下の設定だったため合わせた
          //dest = ScreenKind.customer_7_2;
          dest = EnvironmentData().screenKind == ScreenKind.register
              ? ScreenKind.customer_7_1 : ScreenKind.customer_7_2;
        } else {
          // 15インチ客表
          dest = ScreenKind.customer;
        }
      case ScreenKind.customer || ScreenKind.customer_7_1:
        dest = ScreenKind.register;
      case ScreenKind.customer_7_2:
        dest = ScreenKind.register2;
    }

    // 客側通信サーバーのIPアドレスとポート番号の取得
    ScreenInfo screenInfo = EnvironmentData().getScreenInfo(dest);
    // 客側通信サーバーに接続
    CustomerSocketClient().connect(screenInfo.address, screenInfo.port);
  }

  /// 精算機通信サーバーへの接続設定
  Future<void> _initializeSemiSelfSocket() async {
    // 通信先の判定
    ScreenKind dest;
    switch (EnvironmentData().screenKind) {
      case ScreenKind.register2:
      case ScreenKind.register:
      // MacInfoJsonFileの読み込み
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
        if (xRet.isInvalid()) {
          return;
        }
        RxCommonBuf pCom = xRet.object;
        Mac_infoJsonFile macInfoJsonFile = pCom.iniMacInfo;

        if (macInfoJsonFile.internal_flg.colordsp_size == 0) {
          // 7インチ客表

          // todo register2未実装時に以下の設定だったため合わせた
          //dest = ScreenKind.customer_7_2;
          dest = EnvironmentData().screenKind == ScreenKind.register
              ? ScreenKind.customer_7_1 : ScreenKind.customer_7_2;
        } else {
          // 15インチ客表
          dest = ScreenKind.customer;
        }
      case ScreenKind.customer || ScreenKind.customer_7_1:
        dest = ScreenKind.register;
      case ScreenKind.customer_7_2:
        dest = ScreenKind.register2;
    }

    // 客側通信サーバーのIPアドレスとポート番号の取得
    ScreenInfo screenInfo = EnvironmentData().getScreenInfo(dest);
    CustomerSocketClient().connect(screenInfo.address, screenInfo.port);
  }

  /// 卓上/タワー側通信サーバーへの接続設定
  Future<void> _initializeRegister2Socket() async {
    // 通信先の判定
    ScreenKind dest;
    switch (EnvironmentData().screenKind) {
      case ScreenKind.register:
        dest = ScreenKind.register2;
      case ScreenKind.register2:
        dest = ScreenKind.register;
      default:
        return;
    }

    // 卓上/タワー側通信サーバーのIPアドレスとポート番号の取得
    ScreenInfo targetScreenInfo = EnvironmentData().getScreenInfo(dest);
    ScreenInfo ownScreenInfo = EnvironmentData().getScreenInfo(EnvironmentData().screenKind);

    // 卓上/タワー側通信サーバーに接続
    Register2SocketClient().connect(targetScreenInfo.address, targetScreenInfo.port);
    // 相手側からの受信通信サーバーを起動
    Register2SocketServer.getServerStart(ownScreenInfo.address, ownScreenInfo.port);
  }
}
