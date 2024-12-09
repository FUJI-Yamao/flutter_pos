/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:get/get.dart' as getx;
import 'package:get_server/get_server.dart';

import '../../../../clxos/calc_api_data.dart';
import '../../../../clxos/calc_api_result_data.dart';
import '../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../inc/apl/rxregmem_define.dart';
import '../../../inc/sys/tpr_dlg.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../lib/cm_sound/sound.dart';
import '../../../regs/checker/rxregstr.dart';
import '../../../regs/qcConnect/qcConnect.dart';
import '../../menu/customer/e_customer_page.dart';
import '../../page/customer/controller/c_customer_register_controller.dart';
import '../../page/full_self/controller/c_full_self_register_controller.dart';
import '../../page/full_self/page/p_full_self_start_page.dart';
import '../client/customer_socket_client.dart';
import '../model/customer_socket_model.dart';
import '../model/semiself_response_socket_model.dart';

/// セミセルフ通信サーバー
class SemiSelfSocketServer extends GetView {

  /// URI
  static const String uri = '/semiself_socket_server';

  /// 状態取得メッセージ
  static const String msgGetStatus = 'msg_get_status';

  /// 支払いメッセージ
  static const String msgPayment = 'msg_payment';

  /// 呼び戻しメッセージ
  static const String msgCallBack = 'msg_call_back';

  /// 状態メッセージ
  static const String msgStatusStandby = 'msg_status_stanby'; // 待機中
  static const String msgStatusPrePay  = 'msg_status_prepay'; // 支払い前
  static const String msgStatusPaying  = 'msg_status_paying'; // 支払い中
  static const String msgStatusPayEnd  = 'msg_status_pay_end';// 支払い完了
  static const String msgStatusPause   = 'msg_status_pause';  // 休止中

  /// 状態メッセージ
  static const String msgCautionStatusNormal  = 'msg_caution_status_normal';   // 通常
  static const String msgCautionStatusPrnEnd  = 'msg_caution_status_prn_end';  // プリンタニアエンド
  static const String msgCautionStatusAcxEnd  = 'msg_caution_status_acx_end';  // 釣銭機ニアエンド
  static const String msgCautionStatusAcxFull = 'msg_caution_status_acx_full'; // 釣銭機ニアフル
  static const String msgCautionStatusAcxErr  = 'msg_caution_status_acx_err';  // 釣銭機エラー

  /// 処理中の登録機レジ番号
  static int regNoBeingProcessed = 0;

  /// 接続相手（レジ側と通信する際に利用する）
  static GetSocket? _clientSocket;

  /// メインメニュー表示のメッセージを送る
  static void sendMainMenu() {
    _clientSocket?.emit(CustomerSocketClient.msgMainMenu, '');
    TprLog().logAdd(Tpraid.TPRAID_QCCONNECT, LogLevelDefine.normal,
        "SemiSelfSocketServer sendMainMenu");
  }

  static int getTotalAmount() {
    return RegsMem().tTtllog.t100001.stlTaxInAmt;
  }

  /// 精算機通信サーバー起動
  static void getServerStart(String address, int port) {
    TprLog().logAdd(Tpraid.TPRAID_QCCONNECT, LogLevelDefine.normal,
        "SemiSelfSocketServer getServerStart address = $address  port = $port");
    GetServer(
      getPages: [
        GetPage(
          name: uri,
          page: () => SemiSelfSocketServer(),
          method: Method.ws,
        ),
      ],
      host: address,
      port: port,
    );
  }

  static Future localhostSetting() async {
    var localip;
    // インターフェス情報
    // Get Network Interface information
    Future<String> _getIPaddress(String nwinface, String protocol) async {
      for (var interface in await NetworkInterface.list()) {
        if ((interface.name == nwinface) || ((Platform.isLinux) && (interface.name != ""))) {
          for (var addr in interface.addresses) {
            if (addr.type.name == protocol) {
              return addr.address;
            }
          }
        }
      }
      return "";
    }
    // Getter
    if (Platform.isWindows) {
      localip = await _getIPaddress("イーサネット", "IPv4");
    } else if (Platform.isLinux) {
      localip = await _getIPaddress("enp0s3", "IPv4");
    }
    return localip;
  }

  @override
  Widget build(BuildContext context) {
    return Socket(builder: (socket) {
      socket.onOpen((ws) {
        _clientSocket = ws;
        TprLog().logAdd(Tpraid.TPRAID_QCCONNECT, LogLevelDefine.normal,
            "SemiSelfSocketServer onOpen");
      });

      socket.on('join', (val) {
        TprLog().logAdd(Tpraid.TPRAID_QCCONNECT, LogLevelDefine.normal,
            "SemiSelfSocketServer join");
      });

      socket.onMessage((data) async {
        TprLog().logAdd(Tpraid.TPRAID_QCCONNECT, LogLevelDefine.normal,
            "SemiSelfSocketServer onMessage data=$data");

        // メッセージの種別を取得
        late Map<String, dynamic> mapData;
        try {
          mapData = jsonDecode(data);
        } catch (e) {
          TprLog().logAdd(
            Tpraid.TPRAID_QCCONNECT,
            LogLevelDefine.error,
            'SocketPage socket.onMessage JsonDecode(data) Error $e',
          );
          return;
        }
        final String type = mapData['type'];
        final String requestInfo = mapData['data'];
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
        if (xRet.isInvalid()) {
          return;
        }
        RxTaskStatBuf tsBuf = xRet.object;

        // メッセージ毎の処理
        switch (type) {
          case SemiSelfSocketServer.msgGetStatus: // 状態取得
            if (_clientSocket != null) {
              SemiSelfResponseInfo res = SemiSelfResponseInfo(
                result: true,
                status: tsBuf.qcConnect.MyStatus.qcStatus,
                cautionStatus: tsBuf.qcConnect.MyStatus.cautionStatus,
                uuid: QcConnect.uuid,
                calcResultPay: null,
                calcRequestParaPay: null,
                cancel: false,
                errNo: DlgConfirmMsgKind.MSG_NONE.dlgId,
              );
              Map<String, dynamic> map = res.toJson();
              String json = jsonEncode(map);
              _clientSocket!.emit(SemiSelfSocketServer.msgGetStatus, json);
            }
            break;
          case SemiSelfSocketServer.msgPayment:   // 支払い
            if (_clientSocket != null) {
              SemiSelfResponseInfo res = await QcConnect.recvQcConnect(requestInfo);
              if (res.result) {
                tsBuf.qcConnect.MyStatus.qcStatus = msgStatusPrePay;
              } else {
                tsBuf.qcConnect.MyStatus.qcStatus = msgStatusStandby;
              }
              Map<String, dynamic> map = res.toJson();
              String json = jsonEncode(map);
              _clientSocket!.emit(SemiSelfSocketServer.msgPayment, json);
            }
            break;
          case SemiSelfSocketServer.msgCallBack:  // 呼び戻し
            // TODO:呼び戻し可否処理が必要（支払い中：payingの場合は呼び戻し不可とする）
            bool result = true;
            String uuid = QcConnect.uuid;
            int errNo = DlgConfirmMsgKind.MSG_NONE.dlgId;
            if (tsBuf.qcConnect.MyStatus.qcStatus == msgStatusPaying) {
              result = false;
              errNo = DlgConfirmMsgKind.MSG_QC_USE_NOW.dlgId;
            } else {
              tsBuf.qcConnect.MyStatus.qcStatus = msgStatusStandby;
              QcConnect.uuid = "";
              QcConnect.calcRequestParaPay = CalcRequestParaPay(compCd: 0, streCd: 0);
              RegsMem().tTtllog.t100001.stlTaxInAmt = 0;
            }
            if (_clientSocket != null) {
              SemiSelfResponseInfo res = SemiSelfResponseInfo(
                  result: result,   // trueで呼び戻し成功、falseで失敗（呼び戻せなかった）
                  status: tsBuf.qcConnect.MyStatus.qcStatus,
                  cautionStatus: tsBuf.qcConnect.MyStatus.cautionStatus,
                  uuid: uuid,
                  calcResultPay: null,
                  calcRequestParaPay: null,
                  cancel: false,
                  errNo: errNo,
              );
              Map<String, dynamic> map = res.toJson();
              String json = jsonEncode(map);
              _clientSocket!.emit(SemiSelfSocketServer.msgCallBack, json);
            }
            break;
          default:
            TprLog().logAdd(Tpraid.TPRAID_QCCONNECT, LogLevelDefine.error,
                "SemiSelfSocketServer onMessage invalid type=$type");
        }
      });

      socket.onClose((close) {
        _clientSocket = null;
        TprLog().logAdd(Tpraid.TPRAID_QCCONNECT, LogLevelDefine.normal,
            "SemiSelfSocketServer onClose");
      });
    });
  }
}