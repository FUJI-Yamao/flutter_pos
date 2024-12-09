/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import '../../../common/cmn_sysfunc.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/sys/tpr_def.dart';
import '../../../inc/sys/tpr_log.dart';
import '../model/customer_socket_model.dart';
import '../server/customer_socket_server.dart';

/// 客側通信クライアント（シングルトン）
class CustomerSocketClient {
  /// メインメニュー表示のメッセージ
  static const String msgMainMenu = 'msg_main_menu';
  /// 客側のシャットダウンOKのメッセージ
  static const String msgShutdownOk = 'msg_shutdown_ok';

  static final CustomerSocketClient _instance = CustomerSocketClient._internal();

  factory CustomerSocketClient() {
    // 初期化されていないと例外をスローする
    return _instance;
  }

  CustomerSocketClient._internal();

  /// WebSocketのインスタンス
  GetSocket? _socket;

  /// 終了確認
  final Completer<void> _shutdownOk = Completer.sync();

  /// 接続
  void connect(String address, int port) {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "CustomerSocketClient connect rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;

    // 客表接続しないの場合は、接続しないようにする
    if (pCom.iniMacInfo.internal_flg.colordsp_cnct == 0) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustomerSocketClient not connect");
      return;
    }

    String url = 'http://$address:$port${CustomerSocketServer.uri}/';
    _socket = GetSocket(url);
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "CustomerSocketClient connect url=$url");

    // ソケットが開かれたときの処理
    _socket?.onOpen(() {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustomerSocketClient onOpen");
    });

    // メッセージ受信時の処理
    _socket?.onMessage((data) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustomerSocketClient onMessage data=$data");

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
        case CustomerSocketClient.msgMainMenu:    // メインメニュー表示のメッセージ
          _procMainMenu();
        case CustomerSocketClient.msgShutdownOk:  // 客側のシャットダウンOKのメッセージ
          _procShutdownOk();
        default:
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
              "CustomerSocketServer onMessage invalid type=$type");
      }
    });

    //　ソケット閉じられた時の処理
    _socket?.onClose((close) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustomerSocketClient onClose");
    });

    //　エラー発生時の処理
    _socket?.onError((e) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "CustomerSocketClient onError $e");
    });

    //　イベント受信時の処理
    _socket?.on('event', (val) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustomerSocketClient onEvent val=$val");
    });

    // 接続
    _socket?.connect();
  }

  /// 切断
  void _disconnect() {
    if (_socket != null) {
      _socket?.close();
      _socket = null;
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustomerSocketClient disconnect");
    }
  }

  /// 客側に商品登録メッセージを送る
  void sendItemRegister(String json) {
    if (_socket != null) {
      _socket?.emit(CustomerSocketServer.msgItemRegister, json);
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustomerSocketClient sendItemRegister");
    }
  }

  /// 客側に商品クリアメッセージを送る
  void sendItemClear() {
    if (_socket != null) {
      _socket?.emit(CustomerSocketServer.msgItemClear, '');
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustomerSocketClient sendItemClear");
    }
  }

  /// 客側にロゴ表示メッセージを送る
  void sendLogoDisplay() {
    if (_socket != null) {
      _socket?.emit(CustomerSocketServer.msgLogoDisplay, '');
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustomerSocketClient sendLogoDisplay");
    }
  }

  /// フルセルフスタートのメッセージを送る
  void sendFullSelfStart(AutoStaffInfo autoStaffInfo) {
    if (_socket != null) {
      Map<String, dynamic> map = autoStaffInfo.toJson();
      String json = jsonEncode(map);

      _socket?.emit(CustomerSocketServer.msgFullSelfStart, json);
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustomerSocketClient sendFullSelfStart");
    }
  }

  /// 客側にシャットダウンのメッセージを送る
  Future<void> sendShutdown() async {
    if (_socket != null) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustomerSocketClient sendShutdown start");

      _socket?.emit(CustomerSocketServer.msgShutdown, '');

      Future.delayed(const Duration(seconds: TprDef.timeoutIsolateAbort), () {
        // _shutdownOk を完了状態にする
        if (!_shutdownOk.isCompleted) {
          _shutdownOk.complete();

          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
              "CustomerSocketClient sendShutdown timeout");
        }
      });


      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustomerSocketClient sendShutdown end");

      return _shutdownOk.future;
    } else {
      _shutdownOk.complete();
      return _shutdownOk.future;
    }
  }

  /// メインメニュー表示のメッセージ
  void _procMainMenu() {
    // レジ側画面でメインメニュー画面を表示する
    Get.back();

    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "CustomerSocketClient _procMainMenu end");
  }

  // 客側のシャットダウンOKのメッセージ
  void _procShutdownOk() {
    // 切断する
    _disconnect();

    // _shutdownOk を完了状態にする
    if (!_shutdownOk.isCompleted) {
      _shutdownOk.complete();
    }

    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "CustomerSocketClient _procShutdownOk end");
  }
}
