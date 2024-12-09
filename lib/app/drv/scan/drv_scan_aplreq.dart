/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/cls_conf/configJsonFile.dart';
import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';

import './drv_scan_com.dart';
import '../../inc/lib/drv_com.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../../app/common/cls_conf/sysJsonFile.dart';
import '../../../app/lib/apllib/recog.dart';


class SCAN_COMMAND {
  static const SCAN_CMD_CHARSET      = "\x02"; // 付随情報：ACK＋NAK、"M"、"H"
  static const SCAN_CMD_SOUND        = "\x03";
  static const SCAN_CMD_ENABLE       = "\x04";
  static const SCAN_CMD_DISABLE      = "\x05";
  static const SCAN_CMD_HW_ENABLE    = "\x06";
  static const SCAN_CMD_HW_DISABLE   = "\x07";
  static const SCAN_CMD_PASS_ENABLE  = "\x08";
  static const SCAN_CMD_PASS_DISABLE = "\x09";
  static const SCAN_CMD_SEND_DC2     = "\x12";
  static const SCAN_CMD_CHARREQ      = "\x46";
  static const SCAN_CMD_CHARGET      = "\x86";
  static const SCAN_CMD_PSC          = "\xff";
}

/// 関連tprxソース:drv_scan_aplreq_plus.c
///
class ScanAplReq {

  /// 変数
  static String log = "";
  static int qr_status = 0;
  static ScanCom scanCom = ScanCom();
  static TprLog myLog = TprLog();

  /// アプリからの送信データを設定する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 引数:[msg] アプリからの送信データ
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_aplreq_plus.c - drvScanAplReq()
  Future<int> drvScanAplReq(SendPort _parentSendPort, TprTID tid, String data) async {
    String sysSendData = "";
    String sendMsg = "";
    String log2 = "";
    String data1 = "";
    String data2 = "";
    if (data.length > 1) {
      data1 = data.substring(1, 2);
    }
    if (data.length > 2) {
      data2 = data.substring(2, 3);
    }

    /// SCPU Command
    switch (data.substring(0, 1)) {
      case  SCAN_COMMAND.SCAN_CMD_CHARSET:   // "\x02"
        if ((data1 == DrvCom.ACK) && (data2 == DrvCom.NAK)) {
          ScanCom.scan_info.res_char = SCAN_RESCHAR.SCAN_ACK_NAK;
          log2 = "res_char[ACK/NAK]";
        } else if (data1 == 'M') {
          ScanCom.scan_info.res_char = SCAN_RESCHAR.SCAN_ACK_NAK_CR;
          log2 = "res_char[ACK/NAK] send 'CR'";
        } else if (data1 == 'H') {
          ScanCom.scan_info.res_char = SCAN_RESCHAR.SCAN_BEL;
          log2 = "res_char[ACK/NAK] send 'BEL'";
        } else {
          ScanCom.scan_info.res_char = SCAN_RESCHAR.SCAN_O_N;
          log2 = "res_char[O/N]";
        }
        if (await drvScanRescharSet(_parentSendPort, tid, ScanCom.scan_info.res_char) == 0) {
          log = " Set $log2";
          myLog.logAdd(tid, LogLevelDefine.normal, log);
        } else {
          log = " Set Error $log2";
          myLog.logAdd(tid, LogLevelDefine.error, log);
        }
        break;
      case SCAN_COMMAND.SCAN_CMD_ENABLE:   // "\x04"
        ScanCom.scan_info.act = SCAN_ACT.SCAN_ENABLE;
        myLog.logAdd(tid, LogLevelDefine.normal, " Enable");
        await drvScanQCSend(_parentSendPort, tid, ScanCom.SCAN_QC_ENABLE);
        break;
      case SCAN_COMMAND.SCAN_CMD_DISABLE:   //"\x05"
        ScanCom.scan_info.act = SCAN_ACT.SCAN_DISABLE;
        myLog.logAdd(tid, LogLevelDefine.normal, " Disable");
        await drvScanQCSend(_parentSendPort, tid, ScanCom.SCAN_QC_DISABLE);
        break;
      case SCAN_COMMAND.SCAN_CMD_SEND_DC2:  // "\x12"
        sendMsg = "\x12"; /* DC2 */
        if (scanCom.drvScanSerialWrite(_parentSendPort, tid, sendMsg, sendMsg.length, 0) == 0) {
          myLog.logAdd(tid, LogLevelDefine.normal, " DC2 Write OK");
        } else {
          myLog.logAdd(tid, LogLevelDefine.normal, " DC2 Write NG");
        }
        break;
      case SCAN_COMMAND.SCAN_CMD_CHARREQ:   // "\x46"
        sysSendData = "\x86";
        if (ScanCom.scan_info.res_char == SCAN_RESCHAR.SCAN_ACK_NAK) {
          sysSendData += DrvCom.ACK;
          sysSendData += DrvCom.NAK;
          log = " Req res_char[ACK/NAK]";
        } else if (ScanCom.scan_info.res_char ==
            SCAN_RESCHAR.SCAN_ACK_NAK_CR) {
          sysSendData += 'M';
          log = " Req res_char[ACK/NAK] send 'CR'";
        } else if (ScanCom.scan_info.res_char == SCAN_RESCHAR.SCAN_BEL) {
          sysSendData += 'H';
          log = " Req res_char[ACK/NAK] send 'BEL'";
        } else {
          sysSendData += ScanCom.SCAN_OK_DAT;
          sysSendData += ScanCom.SCAN_NG_DAT;
          log = " Req res_char[O/N]";
        }
        myLog.logAdd(tid, LogLevelDefine.normal, log);
        scanCom.drvScanResNotify(_parentSendPort, tid,
            TprDidDef.TPRDEVRESULTOK, sysSendData, 3);
        break;
      case SCAN_COMMAND.SCAN_CMD_HW_ENABLE: //0x06=ACK
        myLog.logAdd(tid, LogLevelDefine.warning, "SCAN_CMD_HW_ENABLE");
        sendMsg = "\x16\x4D\x0D\x54\x52\x47\x4D\x4F\x44\x33\x21"; // "[SYN]M TRGMOD3!"
        if (scanCom.drvScanSerialWrite(_parentSendPort, tid, sendMsg, sendMsg.length, 0) != 0) {
          myLog.logAdd(tid, LogLevelDefine.error, "SCAN_CMD_HW_ENABLE NG");
        }
        break;
      case SCAN_COMMAND.SCAN_CMD_HW_DISABLE: //0x07=BEL
        myLog.logAdd(tid, LogLevelDefine.warning, "SCAN_CMD_HW_DISABLE");
        sendMsg = "\x16\x4D\x0D\x54\x52\x47\x4D\x4F\x44\x30\x21"; // "[SYN]M TRGMOD0!"
        if (scanCom.drvScanSerialWrite(_parentSendPort, tid, sendMsg, sendMsg.length, 0) != 0) {
          myLog.logAdd(tid, LogLevelDefine.error, "SCAN_CMD_HW_DISABLE NG");
        }
        break;
      case SCAN_COMMAND.SCAN_CMD_PASS_ENABLE: //0x08=BS
        myLog.logAdd(tid, LogLevelDefine.warning, "SCAN_CMD_PASS_ENABLE");
        sendMsg = "\x52\x0d";   // "R"
        if (scanCom.drvScanSerialWrite(_parentSendPort, tid, sendMsg, sendMsg.length, 0) != 0) {
          myLog.logAdd(tid, LogLevelDefine.error, "SCAN_CMD_PASS_ENABLE NG");
        }
        break;
      case SCAN_COMMAND.SCAN_CMD_PASS_DISABLE: //0x09=HT
        myLog.logAdd(tid, LogLevelDefine.warning, "SCAN_CMD_PASS_DISABLE");
        sendMsg = "\x5A\x0d";   // "Z"
        if (scanCom.drvScanSerialWrite(_parentSendPort, tid, sendMsg, sendMsg.length, 0) != 0) {
          myLog.logAdd(tid, LogLevelDefine.error, "SCAN_CMD_PASS_DISABLE NG");
        }
        break;
      case SCAN_COMMAND.SCAN_CMD_PSC:
        sendMsg = data.substring(1);
        if (scanCom.drvScanSerialWrite(_parentSendPort, tid, sendMsg, sendMsg.length, 0) == 0) {
          log = " PSC SendData = ${sendMsg[0]}";
          myLog.logAdd(tid, LogLevelDefine.normal, log);
        }
        break;
      default:
        break;
    }

    return (0);
  }

  /// アプリからの送信データを設定する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 引数:[res_char] レスポンス要求コマンド
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_aplreq_plus.c - drv_scan_reschar_set()
  static Future<int> drvScanRescharSet(SendPort _parentSendPort, TprTID tid, SCAN_RESCHAR res_char) async {
    int res_char_buf = 0;

    RxMemRet rret = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (rret.isInvalid()) {
      myLog.logAdd(tid, LogLevelDefine.error, " SystemFunc.rxMemRead error");
      return (-1);
    }
    RxCommonBuf pCom = rret.object;
    SysJsonFile sysIni = pCom.iniSys;

    switch (res_char) {
      case SCAN_RESCHAR.SCAN_O_N:
        res_char_buf = 0;
        break;
      case SCAN_RESCHAR.SCAN_ACK_NAK_CR:
        res_char_buf = 2;
        break;
      case SCAN_RESCHAR.SCAN_BEL:
        res_char_buf = 3;
        break;
      default:
        res_char_buf = 1;
        break;
    }

    switch (ScanCom.scan_info.myDid) {
      case TprDidDef.TPRDIDSCANNER1:
        sysIni.scanner.reschar = res_char_buf;
        break;
      case TprDidDef.TPRDIDSCANNER2:
        sysIni.scanner.reschar_tower = res_char_buf;
        break;
      case TprDidDef.TPRDIDSCANNER3:
        sysIni.scanner.reschar_add = res_char_buf;
        break;
      default:
        sysIni.scanner.reschar = res_char_buf;
        break;
    }
    await sysIni.save();
    SystemFunc.rxMemWrite(_parentSendPort, RxMemIndex.RXMEM_COMMON, pCom, RxMemAttn.MASTER);
    return (0);
  }

  /// アプリからの送信データ（QC）を設定する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 引数:[typ] レスポンス要求コマンド（QC）
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_aplreq_plus.c - drv_scan_QCSend()
  Future<int> drvScanQCSend(SendPort _parentSendPort, TprTID tid, int typ) async {
    TprMsg_t msg = TprMsg();

    if (((await Recog().recogGet(tid, RecogLists.RECOG_QCASHIER_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result == RecogValue.RECOG_NO) &&
        ((await Recog().recogGet(tid, RecogLists.RECOG_HAPPYSELF_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result == RecogValue.RECOG_NO)) {
      return (0);
    };

    if (typ == ScanCom.SCAN_QC_INFOCHK) {
      return (1);
    }

    if (qr_status == 1) {
      myLog.logAdd(
          tid, LogLevelDefine.warning, "drvScanQCSend Now QR Makeing");
      return (0);
    }

    switch (typ) {
      case ScanCom.SCAN_QC_NORMAL:
        if (ScanCom.scan_info.act != SCAN_ACT.SCAN_ENABLE) {
          return (0);
        }
        myLog.logAdd(
            tid, LogLevelDefine.warning, "drvScanQCSend SCAN_QC_NORMAL");
        msg.devreq.data[1] = 'D'; //0x44
        if (scanCom.drvScanSerialWrite(_parentSendPort, tid, msg.devreq.data[1], 1, 0) != 0) {
          myLog.logAdd(
              tid, LogLevelDefine.normal, "SCAN_QC_NORMAL Disable Write NG");
        }
        sleep(const Duration(microseconds: 50000));
        msg.devreq.data[1] = 'E'; //0x45
        if (scanCom.drvScanSerialWrite(_parentSendPort, tid, msg.devreq.data[1], 1, 0) != 0) {
          myLog.logAdd(
              tid, LogLevelDefine.normal, "SCAN_QC_NORMAL Enable Write NG");
        }
        sleep(const Duration(microseconds: 50000));
        msg.devreq.data[1] = String.fromCharCode(0x12); //DC2
        if (scanCom.drvScanSerialWrite(_parentSendPort, tid, msg.devreq.data[1], 1, 0) != 0) {
          myLog.logAdd(
              tid, LogLevelDefine.normal, "SCAN_QC_NORMAL DC2 Write NG");
        }
        break;
      case ScanCom.SCAN_QC_ENABLE:
        msg.devreq.data[1] = 'E'; //0x45
        myLog.logAdd(
            tid, LogLevelDefine.warning, "drvScanQCSend SCAN_QC_ENABLE");
        if (scanCom.drvScanSerialWrite(_parentSendPort, tid, msg.devreq.data[1], 1, 0) != 0) {
          myLog.logAdd(
              tid, LogLevelDefine.normal, "SCAN_QC_ENABLE Enable Write NG");
        }
        sleep(const Duration(microseconds: 50000));
        msg.devreq.data[1] = String.fromCharCode(0x12); //DC2
        if (scanCom.drvScanSerialWrite(_parentSendPort, tid, msg.devreq.data[1], 1, 0) != 0) {
          myLog.logAdd(
              tid, LogLevelDefine.normal, "SCAN_QC_ENABLE DC2 Write NG");
        }
        break;
      case ScanCom.SCAN_QC_DISABLE:
        msg.devreq.data[1] = 'D'; //0x44
        myLog.logAdd(
            tid, LogLevelDefine.warning, "drvScanQCSend SCAN_QC_DISABLE");
        if (scanCom.drvScanSerialWrite(_parentSendPort, tid, msg.devreq.data[1], 1, 0) != 0) {
          myLog.logAdd(
              tid, LogLevelDefine.normal, "SCAN_QC_DISABLE Disable Write NG");
        }
        break;
      default:
        break;
    }
    return (0);
  }
}
