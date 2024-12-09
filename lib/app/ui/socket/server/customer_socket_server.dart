/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';

import 'package:get/get.dart' as getx;
import 'package:get_server/get_server.dart';

import '../../../../clxos/calc_api_result_data.dart';
import '../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../lib/cm_sound/sound.dart';
import '../../../regs/checker/rxregstr.dart';
import '../../menu/customer/e_customer_page.dart';
import '../../page/customer/controller/c_customer_register_controller.dart';
import '../../page/full_self/page/p_full_self_start_page.dart';
import '../client/customer_socket_client.dart';
import '../model/customer_socket_model.dart';

/// 客側通信サーバー
class CustomerSocketServer extends GetView {

  /// URI
  static const String uri = '/customer_socket';

  /// 商品登録メッセージ
  static const String msgItemRegister = 'msg_item_register';
  /// 商品登録完了メッセージ
  static const String msgItemComplete = 'msg_item_complete';
  /// 商品クリアメッセージ
  static const String msgItemClear = 'msg_item_clear';
  /// 小計操作メッセージ
  static const String msgPaymentOperation = 'msg_payment_operation';
  /// 小計クリアメッセージ
  static const String msgPaymentClear = 'msg_payment_clear';
  /// ロゴ表示メッセージ
  static const String msgLogoDisplay = 'msg_logo_display';
  /// フルセルフスタートのメッセージ
  static const String msgFullSelfStart = 'msg_full_self_start';
  /// フシャットダウンのメッセージ
  static const String msgShutdown = 'msg_shutdown';

  /// 接続相手（レジ側と通信する際に利用する）
  static GetSocket? _clientSocket;

  /// メインメニュー表示のメッセージを送る
  static void sendMainMenu() {
    _clientSocket?.emit(CustomerSocketClient.msgMainMenu, '');
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "CustomerSocketServer sendMainMenu");
  }

  /// 客側通信サーバー起動
  static void getServerStart(String address, int port) {
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "CustomerSocketServer getServerStart address=$address port=$port");
    GetServer(
      getPages: [
        GetPage(
          name: uri,
          page: () => CustomerSocketServer(),
          method: Method.ws,
        ),
      ],
      host: address,
      port: port,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Socket(builder: (socket) {
      socket.onOpen((ws) {
        _clientSocket = ws;
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
            "CustomerSocketServer onOpen");
      });

      socket.on('join', (val) {
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
            "CustomerSocketServer join");
      });

      socket.onMessage((data) {
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
            "CustomerSocketServer onMessage data=$data");

        // メッセージの種別を取得
        late Map<String, dynamic> mapData;
        try {
          mapData = jsonDecode(data);
        } catch (e) {
          TprLog().logAdd(
            Tpraid.TPRAID_NONE,
            LogLevelDefine.error,
            'SocketPage socket.onMessage JsonDecode(data) Error $e',
          );
          return;
        }
        final String type = mapData['type'];

        // メッセージ毎の処理
        switch (type) {
          case CustomerSocketServer.msgItemRegister:  // 商品登録メッセージ
            _procItemRegister(mapData['data']);
          case CustomerSocketServer.msgItemComplete:  // 商品登録完了メッセージ
            _procItemComplete();
          case CustomerSocketServer.msgItemClear:     // 商品クリアメッセージ
            _procItemClear();
          case CustomerSocketServer.msgLogoDisplay:   // ロゴ表示メッセージ
            _procLogoDisplay();
          case CustomerSocketServer.msgFullSelfStart: // フルセルフスタートのメッセージ
            _procFullSelfStart(mapData['data']);
          case CustomerSocketServer.msgShutdown:      // シャットダウンのメッセージ
            _procShutdown();
          default:
            TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
                "CustomerSocketServer onMessage invalid type=$type");
        }
      });

      socket.onClose((close) {
        _clientSocket = null;
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
            "CustomerSocketServer onClose");
      });
    });
  }

  /// 商品登録メッセージの処理
  void _procItemRegister(String json) {
    // 客表（登録）の画面を表示
    _toPage(CustomerPage.register);

    // 商品登録メッセージの処理
    late CalcResultItem calcResultItem;
    try {
      Map<String, dynamic> mapInnerData = jsonDecode(json);
      calcResultItem = CalcResultItem.fromJson(mapInnerData);
    } catch (e) {
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.error,
        "CustomerSocketServer _procItemRegister error $e",
      );
      return;
    }
    if (calcResultItem.retSts == 0) {
      getx.Get.put(CustomerRegisterController()).setData(calcResultItem);
    }
  }

  /// 商品登録完了メッセージ
  void _procItemComplete() {
    getx.Get.back();
  }

  /// 商品クリアメッセージの処理
  void _procItemClear() {
    // 客表（登録）の画面を表示
    _toPage(CustomerPage.register);
    // 商品クリアメッセージの処理
    getx.Get.put(CustomerRegisterController()).clearData();
  }

  /// ロゴ表示メッセージの処理
  void _procLogoDisplay() {
    // ロゴの画面を表示
    _toPage(CustomerPage.logo);
  }

  /// フルセルフスタートのメッセージの処理
  Future<void> _procFullSelfStart(String json) async {
    late AutoStaffInfo autoStaffInfo;
    try {
      Map<String, dynamic> map = jsonDecode(json);
      autoStaffInfo = AutoStaffInfo.fromJson(map);
    } catch (e) {
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.error,
        "CustomerSocketServer _procFullSelfStart error $e",
      );
      return;
    }

    // 再初期化する
    await _reinitialize();
    // 設定ファイルから、登録モードか訓練モードかを取得し共有メモリにセットする.
    Mac_infoJsonFile macInfo = Mac_infoJsonFile();
    await macInfo.load();
    await Rxregstr.rxRegsStart(macInfo.internal_flg.mode);
    // フルセルフのスタート画面
    getx.Get.off(() => FullSelfStartPage(autoStaffInfo));

    TprLog().logAdd(
      Tpraid.TPRAID_NONE, LogLevelDefine.error,
      "CustomerSocketServer _procFullSelfStart end",
    );
  }

  /// シャットダウンのメッセージの処理
  Future<void> _procShutdown() async {
    // TODO:客側のisolateを終了する
    //await Future.delayed(const Duration(seconds: 10));

    // レジ側にシャットダウンOKのメッセージを送信する
    _clientSocket?.emit(CustomerSocketClient.msgShutdownOk, '');
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "CustomerSocketServer _procShutdown end");
  }

  /// 画面遷移（同じ画面の時には遷移しない）
  void _toPage(CustomerPage page) {
    // 以下の理由で、Get.offNamed で画面遷移させる
    // Get.offNamed は、同じ画面に遷移すると、表示のアニメーションがない。Get.backで戻る画面はない。
    // Get.offAllNamed は、同じ画面に遷移すると、表示のアニメーションがある。Get.backで戻る画面はない。
    // Get.toNamed は、同じ画面に遷移すると、表示のアニメーションがない。Get.backで戻る画面はある。
    getx.Get.offNamed(page.routeName);
  }

  /// 再初期化する
  Future<void> _reinitialize() async {
    // Soundクラス（シングルトン）を初期化する
    await Sound().reinitialize();
  }
}