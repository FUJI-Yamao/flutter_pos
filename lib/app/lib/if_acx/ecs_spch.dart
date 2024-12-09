/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../common/cls_conf/acbJsonFile.dart';
import '../../if/if_changer_isolate.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:ecs_spch.c
class EcsSpch {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsSpeedChange()
  /// * 機能概要      : ECS釣銭機速度変更コマンド送信
  /// * 引数          : TprTID src
  /// *                 int mode
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsSpeedChange(TprTID src, int mode) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(40, (_) => "\x00");
      int len = 0;
      String errLog = "";

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }
      sendBuf.fillRange(0, sendBuf.length, "\x00");
      sendBuf[len++] = TprDefAsc.DC1; // DC1 = 11H
      sendBuf[len++] = IfAcxDef.ECS_SPEEDCHG; // ECS_SPEEDCHG = 7DH
      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x31";

      switch (mode) {
        case 2400:
          sendBuf[len++] = "\x30"; // 2400bps
          errLog = "LOG SPDCHG 2400";
          break;
        case 4800:
          sendBuf[len++] = "\x31"; // 4800bps
          errLog = "LOG SPDCHG 4800";
          break;
        case 9600:
          sendBuf[len++] = "\x32"; // 9600bps
          errLog = "LOG SPDCHG 9600";
          break;
        case 19200:
          sendBuf[len++] = "\x33"; // 19200bps
          errLog = "LOG SPDCHG 19200";
          break;
        case 38400:
          sendBuf[len++] = "\x34"; // 38400bps
          errLog = "LOG SPDCHG 38400";
          break;
        case 57600:
          sendBuf[len++] = "\x35"; // 57600bps
          errLog = "LOG SPDCHG 57600";
          break;
        case 115200:
          sendBuf[len++] = "\x36"; // 115200bps
          errLog = "LOG SPDCHG 115200";
          break;
        default:
          AcbJsonFile acb = AcbJsonFile();
          await acb.load();

          switch (acb.settings.baudrate) {
            case 2400:
              sendBuf[len++] = "\x30";
              break;
            case 4800:
              sendBuf[len++] = "\x31";
              break;
            case 9600:
              sendBuf[len++] = "\x32";
              break;
            case 19200:
              sendBuf[len++] = "\x33";
              break;
            case 38400:
              sendBuf[len++] = "\x34";
              break;

            default:
              TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.error,
                  "if_ecs_SpeedChange Unknown baudRate");
              return (-1);
          }
          errLog = "LOG SPDCHG SYOSPD";
          break;
      }
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, errLog);

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsSpeedGet()
  /// * 機能概要      : ECS釣銭機速度変更コマンドレスポンス解析処理                                    */
  /// * 引数          : TprTID src
  /// *                 TprMsgDevReq2_t rcvBuf
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifEcsSpeedGet(TprTID src, TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode == IfAcxDef.MSG_ACROK) {
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
