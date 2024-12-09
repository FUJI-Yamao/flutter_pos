/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/drv/ffi/library.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:get/get.dart';

import '../../../../clxos/calc_api_data.dart';
import '../../../../clxos/calc_api_result_data.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../inc/apl/fnc_code.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/apl/rxmemqcConnect.dart';
import '../../../inc/apl/rxregmem_define.dart';
import '../../../inc/lib/qcConnect.dart';
import '../../../inc/lib/typ.dart';
import '../../../inc/sys/tpr_def.dart';
import '../../../inc/sys/tpr_dlg.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../lib/apllib/db_comlib.dart';
import '../../../regs/checker/rcky_qcnotpay_list.dart';
import '../../../regs/checker/rcky_qcselect.dart';
import '../../../sys/sale_com_mm/rept_ejconf.dart';
import '../../page/register/controller/c_registerbody_controller.dart';
import '../../page/register/model/m_registermodels.dart';
import '../../page/semi_self/controller/c_unpaid_controller.dart';
import '../../page/subtotal/controller/c_payment_controller.dart';
import '../model/semiself_request_socket_model.dart';
import '../model/semiself_response_socket_model.dart';
import '../server/semiself_socket_server.dart';

/// 客側通信クライアント（シングルトン）
class SemiSelfSocketClient {

  static const String uri = '/semiself_socket';

  static final SemiSelfSocketClient _instance = SemiSelfSocketClient._internal();

  factory SemiSelfSocketClient() {
    // 初期化されていないと例外をスローする
    return _instance;
  }

  SemiSelfSocketClient._internal();

  /// WebSocketのインスタンス
  GetSocket? socket1;
  GetSocket? socket2;
  GetSocket? socket3;
  GetSocket? socket4;

  // TODO:
  List<int> macNo = [3, 4, 5, 6, 7];

  int totalAmount = 0;

  /// 接続
  Future<void> connectSocket(int connectNum) async {
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    String ipAddr = tsBuf.qcConnect.ConStatus[connectNum].ipAddr;

    if (ipAddr != "") {
      switch(connectNum + 1) {
        case 1:   await connect1(ipAddr, QCSELECT_PORT_DEFAULT);  break;
        case 2:   await connect2(ipAddr, QCSELECT_PORT_DEFAULT);  break;
        case 3:   await connect3(ipAddr, QCSELECT_PORT_DEFAULT);  break;
        case 4:   await connect4(ipAddr, QCSELECT_PORT_DEFAULT);  break;
        default:                                                  break;
      }
    } else {
      tsBuf.qcConnect.ConStatus[connectNum].qcIdx = PayStatusInfo.pause.idx;
      tsBuf.qcConnect.ConStatus[connectNum].qcStatus = PayStatusInfo.pause.status;
    }
  }

  Future<void> connect1(String address, int port) async {

    String url = 'http://$address:$port${SemiSelfSocketServer.uri}/';
    socket1 = GetSocket(url);
    if (socket1 == null) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient1 not connect");
      return;
    }
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "SemiSelfSocketClient1 connect");

    // ソケットが開かれたときの処理
    socket1?.onOpen(() {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient1 onOpen");
    });

    // メッセージ受信時の処理
    socket1?.onMessage((data) async {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient1 onMessage data=$data");
      await prcMessage(1, data);
    });

    //　ソケット閉じられた時の処理
    socket1?.onClose((close) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient1 onClose");
    });

    //　エラー発生時の処理
    socket1?.onError((e) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "SemiSelfSocketClient1 onError $e");
      RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRetS.isInvalid()) {
        return;
      }
      RxTaskStatBuf tsBuf = xRetS.object;
      if (!isForceValidQc()) {
        tsBuf.qcConnect.ConStatus[0].qcIdx = PayStatusInfo.pause.idx;
        tsBuf.qcConnect.ConStatus[0].qcStatus = PayStatusInfo.pause.status;
      } else {
        tsBuf.qcConnect.ConStatus[0].qcIdx = PayStatusInfo.standby.idx;
        tsBuf.qcConnect.ConStatus[0].qcStatus = PayStatusInfo.standby.status;
      }
    });

    //　イベント受信時の処理
    socket1?.on('event', (val) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient1 onEvent val=$val");
    });

    // 接続
    try {
      var ret = socket1?.connect();
    }catch(e) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "socket1?.connect()　${e}");
    }
  }

  Future<void> connect2(String address, int port) async {

    String url = 'http://$address:$port${SemiSelfSocketServer.uri}/';
    socket2 = GetSocket(url);
    if (socket2 == null) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient2 not connect");
      return;
    }
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "SemiSelfSocketClient2 connect");

    // ソケットが開かれたときの処理
    socket2?.onOpen(() {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient2 onOpen");
    });

    // メッセージ受信時の処理
    socket2?.onMessage((data) async {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient2 onMessage data=$data");
      await prcMessage(2, data);
    });

    //　ソケット閉じられた時の処理
    socket2?.onClose((close) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient2 onClose");
    });

    //　エラー発生時の処理
    socket2?.onError((e) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "SemiSelfSocketClient2 onError $e");
      RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRetS.isInvalid()) {
        return;
      }
      RxTaskStatBuf tsBuf = xRetS.object;
      if (!isForceValidQc()) {
        tsBuf.qcConnect.ConStatus[1].qcIdx = PayStatusInfo.pause.idx;
        tsBuf.qcConnect.ConStatus[1].qcStatus = PayStatusInfo.pause.status;
      } else {
        tsBuf.qcConnect.ConStatus[1].qcIdx = PayStatusInfo.standby.idx;
        tsBuf.qcConnect.ConStatus[1].qcStatus = PayStatusInfo.standby.status;
      }
    });

    //　イベント受信時の処理
    socket2?.on('event', (val) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient2 onEvent val=$val");
    });

    // 接続
    try {
      var ret = socket2?.connect();
    }catch(e) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "socket2?.connect()　${e}");
    }
  }

  Future<void> connect3(String address, int port) async {

    String url = 'http://$address:$port${SemiSelfSocketServer.uri}/';
    socket3 = GetSocket(url);
    if (socket3 == null) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient3 not connect");
      return;
    }
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "SemiSelfSocketClient3 connect");

    // ソケットが開かれたときの処理
    socket3?.onOpen(() {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient3 onOpen");
    });

    // メッセージ受信時の処理
    socket3?.onMessage((data) async {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient3 onMessage data=$data");
      await prcMessage(3, data);
    });

    //　ソケット閉じられた時の処理
    socket3?.onClose((close) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient3 onClose");
    });

    //　エラー発生時の処理
    socket3?.onError((e) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "SemiSelfSocketClient3 onError $e");
      RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRetS.isInvalid()) {
        return;
      }
      RxTaskStatBuf tsBuf = xRetS.object;
      if (!isForceValidQc()) {
        tsBuf.qcConnect.ConStatus[2].qcIdx = PayStatusInfo.pause.idx;
        tsBuf.qcConnect.ConStatus[2].qcStatus = PayStatusInfo.pause.status;
      } else {
        tsBuf.qcConnect.ConStatus[2].qcIdx = PayStatusInfo.standby.idx;
        tsBuf.qcConnect.ConStatus[2].qcStatus = PayStatusInfo.standby.status;
      }
    });

    //　イベント受信時の処理
    socket3?.on('event', (val) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient3 onEvent val=$val");
    });

    // 接続
    try {
      var ret = socket3?.connect();
    }catch(e) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "socket3?.connect()　${e}");
    }
  }

  Future<void> connect4(String address, int port) async {

    String url = 'http://$address:$port${SemiSelfSocketServer.uri}/';
    socket4 = GetSocket(url);
    if (socket4 == null) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient4 not connect");
      return;
    }
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "SemiSelfSocketClient4 connect");

    // ソケットが開かれたときの処理
    socket4?.onOpen(() {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient4 onOpen");
    });

    // メッセージ受信時の処理
    socket4?.onMessage((data) async {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient4 onMessage data=$data");
      await prcMessage(4, data);
    });

    //　ソケット閉じられた時の処理
    socket4?.onClose((close) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient4 onClose");
    });

    //　エラー発生時の処理
    socket4?.onError((e) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "SemiSelfSocketClient4 onError $e");
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        return;
      }
      RxTaskStatBuf tsBuf = xRet.object;
      if (!isForceValidQc()) {
        tsBuf.qcConnect.ConStatus[3].qcIdx = PayStatusInfo.pause.idx;
        tsBuf.qcConnect.ConStatus[3].qcStatus = PayStatusInfo.pause.status;
      } else {
        tsBuf.qcConnect.ConStatus[3].qcIdx = PayStatusInfo.standby.idx;
        tsBuf.qcConnect.ConStatus[3].qcStatus = PayStatusInfo.standby.status;
      }
    });

    //　イベント受信時の処理
    socket4?.on('event', (val) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "SemiSelfSocketClient4 onEvent val=$val");
    });

    // 接続
    try {
      var ret = socket4?.connect();
    }catch(e) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "socket4?.connect()　${e}");
    }
  }

  Future<void> prcMessage(int index, String data) async {
    // メッセージの種別を取得
    late Map<String, dynamic> mapData;
    late Map<String, dynamic> mapData2;
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
    mapData2 = jsonDecode(mapData['data']);
    SemiSelfResponseInfo resInfo = SemiSelfResponseInfo.fromJson(mapData2);
    final bool result = resInfo.result;
    final String status = resInfo.status;
    final String cautionStatus = resInfo.cautionStatus;
    final String uuid = resInfo.uuid;
    final bool cancel = resInfo.cancel;
    final int errNo   = resInfo.errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    // メッセージ毎の処理
    switch (type) {
      case SemiSelfSocketServer.msgGetStatus:    // 待機中
        debugPrint("受信：msgGetStatus  receive:${type} status:${status} cautionStatus:${cautionStatus} result:${result} uuid:${uuid} cancel:${cancel} errNo:${errNo}");
        if (!result) {
          // ステータス取得で失敗している場合は休止中とする。
          tsBuf.qcConnect.ConStatus[index - 1].qcIdx = PayStatusInfo.pause.idx;
          tsBuf.qcConnect.ConStatus[index - 1].qcStatus = PayStatusInfo.pause.status;
          return;
        }
        switch (status) {
          case SemiSelfSocketServer.msgStatusStandby:
            tsBuf.qcConnect.ConStatus[index - 1].qcIdx = PayStatusInfo.standby.idx;
            tsBuf.qcConnect.ConStatus[index - 1].qcStatus = PayStatusInfo.standby.status;
            break;
          case SemiSelfSocketServer.msgStatusPaying:
            tsBuf.qcConnect.ConStatus[index - 1].qcIdx = PayStatusInfo.use.idx;
            tsBuf.qcConnect.ConStatus[index - 1].qcStatus = PayStatusInfo.use.status;
            break;
          case SemiSelfSocketServer.msgStatusPrePay:
            tsBuf.qcConnect.ConStatus[index - 1].qcIdx = PayStatusInfo.use.idx;
            tsBuf.qcConnect.ConStatus[index - 1].qcStatus = PayStatusInfo.use.status;
            break;
          case SemiSelfSocketServer.msgStatusPause:
            tsBuf.qcConnect.ConStatus[index - 1].qcIdx = PayStatusInfo.pause.idx;
            tsBuf.qcConnect.ConStatus[index - 1].qcStatus = PayStatusInfo.pause.status;
            break;
          case SemiSelfSocketServer.msgStatusPayEnd:
            // 支払い終了直後はまだ使用中のままとする。
            tsBuf.qcConnect.ConStatus[index - 1].qcIdx = PayStatusInfo.use.idx;
            tsBuf.qcConnect.ConStatus[index - 1].qcStatus = PayStatusInfo.use.status;
            RckyQcSelect.rcRemoveBkupFile(index, RckyQcSelect.getMacNoByIndex(index), uuid);
            break;
        }
        break;
      case SemiSelfSocketServer.msgPayment:  // 支払い指示
        debugPrint("受信：msgPayment  receive:${type} status:${status} cautionStatus:${cautionStatus} result:${result} uuid:${uuid} cancel:${cancel} errNo:${errNo}");
        if (!result) {
          // 支払い指示が失敗した（受け付けられなかった）場合はエラーダイアログを表示して画面遷移しない。
          await ReptEjConf.rcErr("prcMessage msgPayment", errNo);
          return;
        }
        if (!isForceValidQc()) {
          RckyQcSelect.rcCreateMakeBkupFile(index, uuid, resInfo.calcResultPay, resInfo.calcRequestParaPay);  // 未清算ファイルを作成する。
          final RegisterBodyController regBodyCtrl = Get.find();
          regBodyCtrl.delTabList();             // 登録した商品一覧をクリア
          regBodyCtrl.dispMachineSuccess(index);   // 「送信しました」画面を表示する。
          tsBuf.qcConnect.ConStatus[index - 1].qcIdx = PayStatusInfo.use.idx; // QC指定ボタンを「使用中」にする。
          tsBuf.qcConnect.ConStatus[index - 1].qcStatus = PayStatusInfo.use.status;
        }
        break;
      case SemiSelfSocketServer.msgCallBack:
        debugPrint("受信：msgCallBack  receive:${type} status:${status} result:${result} errNo:${errNo}");
        if (!result) {
          // 呼び戻しが失敗した（受け付けられなかった）場合はエラーダイアログを表示して画面遷移しない。
          await ReptEjConf.rcErr("prcMessage msgCallBack", errNo);
          return;
        }
        UnPaidListController listCtrl = Get.find();
        tsBuf.qcConnect.ConStatus[index - 1].qcIdx = PayStatusInfo.standby.idx;
        tsBuf.qcConnect.ConStatus[index - 1].qcStatus = PayStatusInfo.standby.status;
        if (await listCtrl.setUnpaidPluData(listCtrl.selectedIndex.value)
            != DlgConfirmMsgKind.MSG_NONE.dlgId) {
          await ReptEjConf.rcErr("setUnpaidPluData", errNo);
          return;
        }
        Get.back();
        break;
      default:
        // 不明メッセージの受信は休止中とする。
        tsBuf.qcConnect.ConStatus[index - 1].qcIdx = PayStatusInfo.pause.idx;
        tsBuf.qcConnect.ConStatus[index - 1].qcStatus = PayStatusInfo.pause.status;
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
            "SemiSelfSocketServer onMessage invalid type=$type");
    }
  }

  /// 精算機のステータスを取得
  void getQcStatus() {
    String log = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    for (int index = 1; index <= ConstQxConnect.QCCONNECT_MAX; index++) {
      switch (index) {
        case 1:
          if (socket1 != null) {
            socket1!.emit(SemiSelfSocketServer.msgGetStatus, '');
          }
          break;
        case 2:
          if (socket2 != null) {
            socket2!.emit(SemiSelfSocketServer.msgGetStatus, '');
          }
          break;
        case 3:
          if (socket3 != null) {
            socket3!.emit(SemiSelfSocketServer.msgGetStatus, '');
          }
          break;
        case 4:
          if (socket4 != null) {
            socket4!.emit(SemiSelfSocketServer.msgGetStatus, '');
          }
          break;
        default:
          break;
      }
      if (((socket1 == null) && (index == 1)) || ((socket2 == null) && (index == 2))
       || ((socket3 == null) && (index == 3)) || ((socket4 == null) && (index == 4))) {
        tsBuf.qcConnect.ConStatus[index - 1].qcIdx = PayStatusInfo.pause.idx;
        tsBuf.qcConnect.ConStatus[index - 1].qcStatus = PayStatusInfo.pause.status;
        tsBuf.qcConnect.ConStatus[index - 1].cautionStatus = "";
      }
      if (log != "") {
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, log);
      }
    }
  }

  void updateQcStatus(List<PaymachineState> payMachineStatus) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    for (int i = 0; i < ConstQxConnect.QCCONNECT_MAX; i++) {
      payMachineStatus[i].title.value = RckyQcSelect.getMacNameByIndex(i + 1);
      payMachineStatus[i].idx.value = tsBuf.qcConnect.ConStatus[i].qcIdx;
      payMachineStatus[i].state.value = tsBuf.qcConnect.ConStatus[i].qcStatus;
      payMachineStatus[i].nearstate.value = tsBuf.qcConnect.ConStatus[i].cautionStatus;
    }
  }

  /// 精算機へ支払い情報（レジ番号、UUID）を送信
  /// indexは精算機番号 1～4
  void sendPaymentInfo(
    int index, 
    String uuid,
    {
      List<String>? cartLogQuery,
      CalcResultPay? calcResultPay,
      CalcRequestParaPay? requestParaPay,
    }
  ) {
    String log = "";
    int macNo = RckyQcSelect.getMacNoByIndex(index);
    SemiSelfRequestInfo info = SemiSelfRequestInfo(
      macNo: macNo,
      uuid: uuid,
      cartLogQuery: cartLogQuery,
      calcResultPay: calcResultPay,
      requestParaPay: requestParaPay,
      cancel: false
    );
    Map<String, dynamic> map = info.toJson();
    String json = jsonEncode(map);
    switch(index) {
      case 1:
        if (socket1 != null) {
          socket1!.emit(SemiSelfSocketServer.msgPayment, json);
          log = "SemiSelfSocketClient sendPaymentInfo index:${index} macNo:${macNo} uuid:${uuid} json:${json}";
        }
        break;
      case 2:
        if (socket2 != null) {
          socket2!.emit(SemiSelfSocketServer.msgPayment, json);
          log = "SemiSelfSocketClient sendPaymentInfo index:${index} macNo:${macNo} uuid:${uuid} json:${json}";
        }
        break;
      case 3:
        if (socket3 != null) {
          socket3!.emit(SemiSelfSocketServer.msgPayment, json);
          log = "SemiSelfSocketClient sendPaymentInfo index:${index} macNo:${macNo} uuid:${uuid} json:${json}";
        }
        break;
      case 4:
        if (socket4 != null) {
          socket4!.emit(SemiSelfSocketServer.msgPayment, json);
          log = "SemiSelfSocketClient sendPaymentInfo index:${index} macNo:${macNo} uuid:${uuid} json:${json}";
        }
        break;
      default:
        break;
    }
    if (log != "") {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, log);
      if (isForceValidQc()) {
        RckyQcSelect.rcCreateMakeBkupFile(index, uuid, calcResultPay, requestParaPay); // 未清算ファイルを作成する。
        final RegisterBodyController regBodyCtrl = Get.find();
        regBodyCtrl.delTabList(); // 登録した商品一覧をクリア
        regBodyCtrl.dispMachineSuccess(index); // 「送信しました」画面を表示する。
      }
    }
  }

  /// 精算機へ呼び戻し情報（レジ番号、UUID）を送信
  /// indexは精算機番号 1～4
  /// 戻り値:0呼び戻せた,1呼び戻せなかった
  int sendCallBackInfo(int index, String uuid) {
    String log = "";
    int macNo = RckyQcSelect.getMacNoByIndex(index);
    SemiSelfRequestInfo info = SemiSelfRequestInfo(macNo: macNo, uuid: uuid, cancel: true);
    Map<String, dynamic> map = info.toJson();
    String json = jsonEncode(map);
    switch(index) {
      case 1:
        if (socket1 != null) {
          socket1!.emit(SemiSelfSocketServer.msgCallBack, json);
          log = "SemiSelfSocketClient sendCallBackInfo index:${index}} macNo:${macNo} uuid:${uuid} cancel=true";
        }
        break;
      case 2:
        if (socket2 != null) {
          socket2!.emit(SemiSelfSocketServer.msgCallBack, json);
          log = "SemiSelfSocketClient sendCallBackInfo index:${index}} macNo:${macNo} uuid:${uuid} cancel=true";
        }
        break;
      case 3:
        if (socket3 != null) {
          socket3!.emit(SemiSelfSocketServer.msgCallBack, json);
          log = "SemiSelfSocketClient sendCallBackInfo index:${index}} macNo:${macNo} uuid:${uuid} cancel=true";
        }
        break;
      case 4:
        if (socket4 != null) {
          socket4!.emit(SemiSelfSocketServer.msgCallBack, json);
          log = "SemiSelfSocketClient sendCallBackInfo index:${index}} macNo:${macNo} uuid:${uuid} cancel=true";
        }
        break;
      default:
        break;
    }
    if (log != "") {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, log);
    }
    return 0;
  }

  /// 切断
  /// indexは精算機番号 1～4
  void disconnect(int index) {
    String log = "";
    switch (index) {
      case 1:
        if (socket1 != null) {
          socket1!.close();
          socket1 = null;
          log = "SemiSelfSocketClient disconnect index=${index}";
        }
        break;
      case 2:
        if (socket2 != null) {
          socket2!.close();
          socket2 = null;
          log = "SemiSelfSocketClient disconnect index=${index}";
        }
        break;
      case 3:
        if (socket3 != null) {
          socket3!.close();
          socket3 = null;
          log = "SemiSelfSocketClient disconnect index=${index}";
        }
        break;
      case 4:
        if (socket4 != null) {
          socket4!.close();
          socket4 = null;
          log = "SemiSelfSocketClient disconnect index=${index}";
        }
        break;
      default:
        break;
    }
    if (log == "") {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, log);
    }
  }
}
