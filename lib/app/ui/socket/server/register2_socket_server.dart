/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';

import 'package:flutter/material.dart' as material;

import 'package:flutter_pos/app/common/dual_cashier_util.dart';
import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_pos/app/ui/controller/c_common_controller.dart';
import 'package:flutter_pos/app/ui/socket/model/dual_response_socket_model.dart';
import 'package:get/get.dart' as getx;
import 'package:get_server/get_server.dart';

import '../../../inc/sys/tpr_log.dart';
import '../../../lib/apllib/rm_db_read.dart';
import '../../../regs/checker/rc_arange.dart';
import '../../../regs/spool/rsmain.dart';
import '../../enum/e_dual_response.dart';
import '../../enum/e_dual_status.dart';
import '../../enum/e_screen_kind.dart';
import '../../menu/register/enum/e_register_page.dart';
import '../../page/common/component/w_lock_message_panel.dart';
import '../../page/common/component/w_msgdialog.dart';
import '../client/register2_socket_client.dart';
import '../model/customer_socket_model.dart';
import '../model/end_request_socket_model.dart';
import '../model/lock_request_socket_model.dart';
import '../model/unlock_possibility_socket_model.dart';

/// 卓上/タワー側通信サーバー
class Register2SocketServer extends GetView {

  /// URI
  static const String uri = '/register2_socket';

  /// 画面ロック要求メッセージ
  static const String msgLockRequest = 'msg_lock_request';

  /// 2人制モード開始要求メッセージ
  static const String msgDualModeRequest = 'msg_dual_mode_request';

  /// 2人制モード開始応答メッセージ
  static const String msgDualModeResponse = 'msg_dual_mode_response';

  /// 2人制モード終了要求メッセージ
  static const String msgDualModeEndRequest = 'msg_dual_mode_end_request';

  /// 2人制モード終了応答メッセージ
  static const String msgDualModeEndResponse = 'msg_dual_mode_end_response';

  /// 2人制モード登録データ送信メッセージ
  static const String msgDualModeSendRegistData= 'msg_dual_mode_send_regist_data';

  /// 1人制モードロック解除可否送信メッセージ
  static const String msgSingleModeSendUnlockPossibility= 'msg_single_mode_send_unlock_possibility';

  /// 2人制モードテストデータ１送信メッセージ
  static const String msgTwinModeSendTestData1= 'msg_twin_mode_send_test_data1';

  /// 2人制モードテストデータ２送信メッセージ
  static const String msgTwinModeSendTestData2= 'msg_twin_mode_send_test_data2';

  /// 2人制モード商品登録メッセージ
  static const String msgDualModeItemRegister = 'msg_dual_mode_item_register';

  /// 接続相手（卓上/タワー側と通信する際に利用する）
  static GetSocket? _clientSocket;

  static bool isLocked = false;

  /// 卓上/タワー側通信サーバー起動
  static void getServerStart(String address, int port) {
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketServer getServerStart address=$address port=$port");
    GetServer(
      getPages: [
        GetPage(
          name: uri,
          page: () => Register2SocketServer(),
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
        _clientSocket.printInfo();
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
            "Register2SocketServer onOpen[${_clientSocket..toString()}");
      });

      socket.on('join', (val) {
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
            "Register2SocketServer join");
      });

      socket.onMessage((data) {
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
            "Register2SocketServer onMessage data=$data");

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
          case Register2SocketServer.msgLockRequest:  // 画面ロック要求メッセージ
            _procLockRequest(mapData['data']);
          case Register2SocketServer.msgDualModeRequest:  // 2人制モード開始要求メッセージ
            _procDualModeRequest(mapData['data']);
          case Register2SocketServer.msgDualModeResponse:  // 2人制モード開始応答メッセージ
            _procDualModeResponse(mapData['data']);
          case Register2SocketServer.msgDualModeEndRequest:  // 2人制モード終了要求メッセージ
            _procDualModeEndRequest(mapData['data']);
          case Register2SocketServer.msgDualModeEndResponse:  // 2人制モード終了応答メッセージ
            _procDualModeEndResponse(mapData['data']);
          case Register2SocketServer.msgDualModeSendRegistData:  // 2人制モードデータ送信完了メッセージ
            _procDualModeSendRegistData();
          case Register2SocketServer.msgSingleModeSendUnlockPossibility:  // 1人制モードロック解除可否送信メッセージ
            _procSingleModeSendUnlockPossibility(mapData['data']);
          case Register2SocketServer.msgDualModeItemRegister:  // 2人制モード商品登録メッセージ
            _procDualModeItemRegister(mapData['data']);
          default:
            TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
                "Register2SocketServer onMessage invalid type=$type");
        }
      });

      socket.onClose((close) {
        _clientSocket = null;
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
            "Register2SocketServer onClose");
      });
    });
  }

  /// 画面ロック要求メッセージ処理
  /// registerプロセスとregister2プロセスの両方で使用される。処理に分岐があり、
  /// registerプロセスではcashier、register2プロセスはcheckerに対して従業員クローズ処理となる
  void _procLockRequest(String json) {
    TprLog().logAdd(
      Tpraid.TPRAID_NONE, LogLevelDefine.normal,
      "Register2SocketServer _procLockRequest call",
    );

    late LockRequestInfo lockRequestInfo;
    try {
      Map<String, dynamic> map = jsonDecode(json);
      lockRequestInfo = LockRequestInfo.fromJson(map);
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketServer _procLockRequest lockStatus=${lockRequestInfo.lockStatus.toString()}",
      );
    } catch (e) {
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.error,
        "Register2SocketServer _procLockRequest error $e",
      );
      return;
    }

    var commonCtrl = getx.Get.find<CommonController>();
    // ロックされていない かつ ロック状態指定がtrueの場合
    if (!LockMessagePanel.isShowing && lockRequestInfo.lockStatus) {
      String target = DualCashierUtil.getTargetName();
      int? checkerFlag;
      // 画面種別がregister2の場合
      if (DualCashierUtil.isRegister2()) {
        checkerFlag = 1;
      }

      DualCashierUtil.setLockStatus(true, '$target動作中');
      commonCtrl.isMainMachine.value = false;
      DualCashierUtil.autoCloseStaff(checkerFlag);
    }
    else if (LockMessagePanel.isShowing && !lockRequestInfo.lockStatus) {
      DualCashierUtil.setLockStatus(false, '');
      commonCtrl.isMainMachine.value = true;
    }
  }

  /// 2人制モード開始要求メッセージ処理
  /// registerプロセスとregister2プロセスの両方で使用される。処理に分岐があり、
  /// registerプロセスではcashierに対して従業員オープンし、小計画面に遷移する
  /// register2プロセスはcheckerに対して従業員オープンし、登録画面に遷移する
  void _procDualModeRequest(String json) async {
    TprLog().logAdd(
      Tpraid.TPRAID_NONE, LogLevelDefine.normal,
      "Register2SocketServer _procDualModeRequest call",
    );

    late AutoStaffInfo autoStaffInfo;
    try {
      Map<String, dynamic> map = jsonDecode(json);
      autoStaffInfo = AutoStaffInfo.fromJson(map);
    } catch (e) {
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.error,
        "Register2SocketServer AutoStaffInfo decode error $e",
      );
      Register2SocketClient().sendDualModeResponse(
          DualResponseInfo(result: false, isAuto: false, error: DualResponse.requestFailed.index));
      return;
    }

    var commonCtrl = getx.Get.find<CommonController>();
    commonCtrl.autoStaffInfo = autoStaffInfo;

    // 2人制に変更可能な場合
    bool isChangeOk = await DualCashierUtil.isDualModeSwitchEnable(await DualCashierUtil.rcKySelf(commonCtrl.isDualMode.value));
    TprLog().logAdd(
      Tpraid.TPRAID_NONE, LogLevelDefine.normal,
      "Register2SocketServer DualCashierUtil.isDualModeSwitchEnable=${isChangeOk.toString()} ",
    );

    if (isChangeOk) {
      await DualCashierUtil.startDualMode();
      DualCashierUtil.setLockStatus(false, '');
      commonCtrl.isDualMode.value = true;
      if (autoStaffInfo.staffCd.isNotEmpty) {
        if (DualCashierUtil.isRegister2()) {
          await DualCashierUtil.autoOpenStaff(1);
        } else {
          await DualCashierUtil.autoOpenStaff(0);
        }
      }

      await AcArange.rcCheckWhoKey();
      // 機種を取得
      commonCtrl.rcKySelf.value = await DualCashierUtil.rcKySelf(commonCtrl.isDualMode.value);
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketServer rcKySelf=${commonCtrl.rcKySelf.value.toString()} ",
      );
      if (DualCashierUtil.isRegister2()) {
        DualCashierUtil.transRegister();
      } else {
        await DualCashierUtil.transSubtotal();
      }

      Register2SocketClient().sendDualModeResponse(
          DualResponseInfo(result: true, isAuto: false, error: DualResponse.success.index));
      commonCtrl.dualStatus = DualStatus.dual;
    }
    else {
      Register2SocketClient().sendDualModeResponse(
          DualResponseInfo(result: false, isAuto: false, error: DualResponse.changeFailed.index));
    }
  }

  /// 2人制モード開始応答メッセージ処理
  /// registerプロセスとregister2プロセスの両方で使用される。処理に分岐があり、
  /// registerプロセスでは小計画面に遷移する
  /// register2プロセスは登録画面に遷移する
  void _procDualModeResponse(String json) async {
    TprLog().logAdd(
      Tpraid.TPRAID_NONE, LogLevelDefine.normal,
      "Register2SocketServer _procDualModeResponse call",
    );

    var commonCtrl = getx.Get.find<CommonController>();

    late DualResponseInfo dualResponseInfo;
    try {
      Map<String, dynamic> map = jsonDecode(json);
      dualResponseInfo = DualResponseInfo.fromJson(map);
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketServer _procDualModeResponse result=${dualResponseInfo.result.toString()}",
      );
    } catch (e) {
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.error,
        "Register2SocketServer DualResponseInfo decode error $e",
      );
      Register2SocketClient().sendDualModeResponse(
          DualResponseInfo(result: false, isAuto: false, error: DualResponse.requestFailed.index));

      String targetName = DualCashierUtil.getTargetName();
      String message = '$targetName側からの応答情報取得に失敗しました';
      MsgDialog.show(
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message: message,
        ),
      );
      commonCtrl.dualStatus = DualStatus.none;
      return;
    }

    if (dualResponseInfo.result) {
      commonCtrl.isDualMode.value = true;

      // タワー側のオープン情報を取得する
      await RmDBRead().rmDbStaffopenRead();

      // 機種を取得
      await AcArange.rcCheckWhoKey();
      commonCtrl.rcKySelf.value =
        await DualCashierUtil.rcKySelf(commonCtrl.isDualMode.value);

      if (DualCashierUtil.isRegister2()) {
        DualCashierUtil.transRegister();
      } else {
        await DualCashierUtil.transSubtotal();
      }
      commonCtrl.dualStatus = DualStatus.dual;
    }
    else {
      String targetName = DualCashierUtil.getTargetName();
      String message = DualCashierUtil.getErrorMessage(dualResponseInfo, targetName);

      MsgDialog.show(
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message: message,
        ),
      );
      commonCtrl.dualStatus = DualStatus.none;
    }
  }

  /// 2人制モード終了要求メッセージ処理
  /// registerプロセスとregister2プロセスの両方で使用される。処理に分岐があり、
  /// registerプロセスでは1人制として操作対象とする
  /// register2プロセスはロック状態にして捜査対象ではない状態とする
  void _procDualModeEndRequest(String json) async {
    TprLog().logAdd(
      Tpraid.TPRAID_NONE, LogLevelDefine.normal,
      "Register2SocketServer _procDualModeEndRequest call",
    );

    late EndRequestInfo endRequestInfo;
    try {
      Map<String, dynamic> map = jsonDecode(json);
      endRequestInfo = EndRequestInfo.fromJson(map);
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketServer _procDualModeEndRequest isAuto=${endRequestInfo.isAuto.toString()}",
      );
    } catch (e) {
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.error,
        "Register2SocketServer EndRequestInfo decode error $e",
      );
      Register2SocketClient().sendDualModeEndResponse(
          DualResponseInfo(result: false, isAuto: false, error: DualResponse.requestFailed.index));
      return;
    }

    var commonCtrl = getx.Get.find<CommonController>();

    int rcKySelf = await DualCashierUtil.rcKySelf(commonCtrl.isDualMode.value);
    // 1人制に変更可能な場合
    if (await DualCashierUtil.isDualModeSwitchEnable(rcKySelf, viewDialog: !endRequestInfo.isAuto)) {
      commonCtrl.isDualMode.value = false;
      await DualCashierUtil.endDualMode();
      await DualCashierUtil.autoCloseStaff(
          EnvironmentData().screenKind == ScreenKind.register2 ? 1 : 0);
      await RmDBRead().rmDbStaffopenRead();
      getx.Get.until(material.ModalRoute.withName(RegisterPage.mainMenu.routeName));
      if (DualCashierUtil.isRegister2()) {
        DualCashierUtil.setLockStatus(true, 'キャッシャー動作中');
        commonCtrl.isMainMachine.value = false;
      }

      // 機種を取得
      await AcArange.rcCheckWhoKey();
      commonCtrl.rcKySelf.value = await DualCashierUtil.rcKySelf(commonCtrl.isDualMode.value);

      Register2SocketClient().sendDualModeEndResponse(
          DualResponseInfo(result: true, isAuto: endRequestInfo.isAuto, error: DualResponse.success.index));
      commonCtrl.isDualMode.value = false;
      commonCtrl.dualStatus = DualStatus.none;
    }
    else {
      Register2SocketClient().sendDualModeEndResponse(
          DualResponseInfo(result: false, isAuto: false, error: DualResponse.changeFailed.index));
    }
  }

  /// 2人制モード終了応答メッセージ処理
  /// registerプロセスとregister2プロセスの両方で使用される。処理に分岐があり、
  /// registerプロセスでは1人制として操作対象とする
  /// register2プロセスはロック状態にして捜査対象ではない状態とする
  void _procDualModeEndResponse(String json) async {
    TprLog().logAdd(
      Tpraid.TPRAID_NONE, LogLevelDefine.normal,
      "Register2SocketServer _procDualModeEndResponse call",
    );

    var commonCtrl = getx.Get.find<CommonController>();

    late DualResponseInfo dualResponseInfo;
    try {
      Map<String, dynamic> map = jsonDecode(json);
      dualResponseInfo = DualResponseInfo.fromJson(map);
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketServer _procDualModeEndResponse result=${dualResponseInfo.result.toString()}",
      );
    } catch (e) {
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.error,
        "Register2SocketServer DualResponseInfo decode error $e",
      );
      Register2SocketClient().sendDualModeEndResponse(
          DualResponseInfo(result: false, isAuto: false, error: DualResponse.requestFailed.index));

      String targetName = DualCashierUtil.getTargetName();
      String message = '$targetName側からの応答情報取得に失敗しました';
      MsgDialog.show(
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message: message,
        ),
      );
      commonCtrl.dualStatus = DualStatus.none;
      return;
    }

    if (dualResponseInfo.result) {
      commonCtrl.isDualMode.value = false;
      await DualCashierUtil.autoCloseStaff(
          EnvironmentData().screenKind == ScreenKind.register2 ? 1 : 0);
      await RmDBRead().rmDbStaffopenRead();
      // 機種を取得
      await AcArange.rcCheckWhoKey();
      commonCtrl.rcKySelf.value =
      await DualCashierUtil.rcKySelf(commonCtrl.isDualMode.value);
      getx.Get.until(material.ModalRoute.withName(RegisterPage.mainMenu.routeName));
      if (DualCashierUtil.isRegister2()) {
        commonCtrl.isMainMachine.value = false;
        DualCashierUtil.setLockStatus(true, 'キャッシャー動作中');
      }
      commonCtrl.dualStatus = DualStatus.none;
    }
    else {
      String targetName = DualCashierUtil.getTargetName();
      String message = DualCashierUtil.getErrorMessage(dualResponseInfo, targetName);

      MsgDialog.show(
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message: message,
        ),
      );
      commonCtrl.dualStatus = DualStatus.dual;
    }
  }

  /// 2人制モードデータ送信メッセージ処理
  /// register2プロセスで使用され、registerでは使用されない
  void _procDualModeSendRegistData() {
    TprLog().logAdd(
      Tpraid.TPRAID_NONE, LogLevelDefine.normal,
      "Register2SocketServer _procDualModeSendRegistData call",
    );

    try {
      CommonController commonCtrl = getx.Get.find();
      commonCtrl.dualModeDataReceived.value = true;
    }
    catch(e) {
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.error,
        "Register2SocketServer SubtotalController find error",
      );
    }
  }

  /// 1人制モードロック解除可否送信メッセージ処理
  /// registerプロセスとregister2プロセスの両方で使用される。処理に分岐はない
  void _procSingleModeSendUnlockPossibility(String json) {
    TprLog().logAdd(
      Tpraid.TPRAID_NONE, LogLevelDefine.normal,
      "Register2SocketServer _procSingleModeSendUnlockPossibility call",
    );

    late UnlockPossibilityInfo unlockPossibilityInfo;
    try {
      Map<String, dynamic> map = jsonDecode(json);
      unlockPossibilityInfo = UnlockPossibilityInfo.fromJson(map);
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "Register2SocketServer _procSingleModeSendUnlockPossibility unlockPossibility=${unlockPossibilityInfo.unlockPossibility.toString()}",
      );
    } catch (e) {
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.error,
        "Register2SocketServer UnlockPossibilityInfo decode error $e",
      );
      return;
    }

    var commonCtrl = getx.Get.find<CommonController>();
    commonCtrl.isUnlockEnabled.value = unlockPossibilityInfo.unlockPossibility;
  }

  /// 2人制モード商品登録メッセージの処理
  /// register2プロセスで使用され、registerでは使用されない
  Future<void> _procDualModeItemRegister(String json) async {
    TprLog().logAdd(
      Tpraid.TPRAID_NONE, LogLevelDefine.normal,
      "Register2SocketServer _procDualModeItemRegister call",
    );
    try {
      int count = await RsMain.getSpoolCount();

      // スプールファイルに書き込む
      if (count < RsMain.spoolMax) {
        if (await RsMain.rsWriteSpoolFile(json, (count+1)) == RsMain.RS_OK) {
          RsMain.upSpoolCount();
        } else {
        }
      }
    } catch (e) {
      TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.error,
        "Register2SocketServer _procDualModeItemRegister JsonDecode(mapData['data']) Error $e",
      );
      return;
    }
  }
}
