/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';

import 'package:flutter_pos/app/ui/socket/model/lock_request_socket_model.dart';
import 'package:get/get.dart';

import '../../../inc/sys/tpr_log.dart';
import '../model/customer_socket_model.dart';
import '../model/dual_response_socket_model.dart';
import '../model/end_request_socket_model.dart';
import '../model/unlock_possibility_socket_model.dart';
import '../server/register2_socket_server.dart';

/// 卓上/タワー側通信クライアント（シングルトン）
class Register2SocketClient {
  static final Register2SocketClient _instance = Register2SocketClient._internal();

  factory Register2SocketClient() {
    // 初期化されていないと例外をスローする
    return _instance;
  }

  Register2SocketClient._internal();

  /// WebSocketのインスタンス
  GetSocket? _socket;

  /// 接続
  void connect(String address, int port) {
    String url = 'http://$address:$port${Register2SocketServer.uri}/';
    _socket = GetSocket(url);
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketClient connect url=$url");

    // ソケットが開かれたときの処理
    _socket?.onOpen(() {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "Register2SocketClient onOpen");
    });

    // メッセージ受信時の処理
    _socket?.onMessage((data) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "Register2SocketClient onMessage data=$data");

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

      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "Register2SocketServer onMessage invalid type=$type");
    });

    // ソケット閉じられた時の処理
    _socket?.onClose((close) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "Register2SocketClient onClose");
    });

    // エラー発生時の処理
    _socket?.onError((e) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "Register2SocketClient onError $e");
    });

    // イベント受信時の処理
    _socket?.on('event', (val) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "Register2SocketClient onEvent val=$val");
    });

    // 接続
    _socket?.connect();
  }

  /// 切断
  void disconnect() {
    _socket?.close();
    _socket?.dispose();
    _socket = null;
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketClient disconnect");
  }

  /// 画面ロック要求を送信する
  /// registerプロセスとregister2プロセスの両方で使用される。処理に分岐はない
  void sendLockRequest(bool lockStatus) {
    Map<String, dynamic> map = LockRequestInfo(lockStatus: lockStatus).toJson();
    String json = jsonEncode(map);

    _socket?.emit(Register2SocketServer.msgLockRequest, json);
     TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
         "Register2SocketClient sendLockRequest");
  }
  /// 2人制モード開始要求を送信する
  /// registerプロセスとregister2プロセスの両方で使用される。処理に分岐はない
  void sendDualModeRequest(AutoStaffInfo autoStaffInfo) {
    Map<String, dynamic> map = autoStaffInfo.toJson();
    String json = jsonEncode(map);

    _socket?.emit(Register2SocketServer.msgDualModeRequest, json);
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketClient sendDualModeRequest");
  }

  /// 2人制モード開始応答を送信する
  /// sendLockRequestに対して応答する
  /// registerプロセスとregister2プロセスの両方で使用される。処理に分岐はない
  void sendDualModeResponse(DualResponseInfo dualReplyInfo) {
    Map<String, dynamic> map = dualReplyInfo.toJson();
    String json = jsonEncode(map);

    _socket?.emit(Register2SocketServer.msgDualModeResponse, json);
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketClient sendDualModeResponse");
  }

  /// 2人制モード終了要求を送信する
  /// registerプロセスとregister2プロセスの両方で使用される。処理に分岐はない
  void sendDualModeEndRequest({bool isAuto = false}) {
    Map<String, dynamic> map = EndRequestInfo(isAuto: isAuto).toJson();
    String json = jsonEncode(map);

    _socket?.emit(Register2SocketServer.msgDualModeEndRequest, json);
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketClient sendDualModeEndRequest isAuto=${isAuto.toString()}");
  }

  /// 2人制モード終了応答を送信する
  /// sendDualModeEndRequestに対して応答する
  /// registerプロセスとregister2プロセスの両方で使用される。処理に分岐はない
  void sendDualModeEndResponse(DualResponseInfo dualReplyInfo) {
    Map<String, dynamic> map = dualReplyInfo.toJson();
    String json = jsonEncode(map);

    _socket?.emit(Register2SocketServer.msgDualModeEndResponse, json);
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketClient sendDualModeEndResponse dualReplyInfo.result=${dualReplyInfo.result.toString()}");
  }

  /// 2人制モードデータ送信を送信する
  /// register2プロセスで使用され、registerでは使用されない
  void sendDualModeSendRegistData() {
    _socket?.emit(Register2SocketServer.msgDualModeSendRegistData, '');
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketClient sendDualModeSendRegistData");
  }

  /// 1人制モードロック解除可否を送信する
  /// registerプロセスとregister2プロセスの両方で使用される。処理に分岐はない
  void sendSingleModeUnlockPossibility(bool unlockPossibility) {
    Map<String, dynamic> map = UnlockPossibilityInfo(unlockPossibility: unlockPossibility).toJson();
    String json = jsonEncode(map);

    _socket?.emit(Register2SocketServer.msgSingleModeSendUnlockPossibility, json);
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketClient sendSingleModeUnlockPossibility unlockPossibility=${unlockPossibility.toString()}");
  }

  /// 2人制モード商品登録メッセージを送信する
  /// register2プロセスで使用され、registerでは使用されない
  void sendDualModeItemRegister(String json) {
    _socket?.emit(Register2SocketServer.msgDualModeItemRegister, json);
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketClient sendDualModeItemRegister");
  }
}
