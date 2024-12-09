/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_type.dart';
import '../../regs/checker/rcsyschk.dart';
import '../../tprlib/tprlib_generic.dart';
import '../apllib/apllib_other.dart';

/// 関連tprxソース: usbcam.c
class IfUsbCam {
  static String USBCAM_START = 'A'; // 0x41
  static String USBCAM_STOP = 'Z'; // 0x5a
  static int USBCAM_NORMAL = 0;
  static int USBCAM_SENDERR = -1;

  /// 指定データをtprdrv_usbcam ドライバへ送信する
  /// 関連tprxソース: usbcam.c - if_usbcam_Send
  /// 引数:TPRTID src
  ///     int    InOut
  ///     uchar  *SendData  送信データ
  ///     size_t len        送信データ長
  /// 戻値:USBCAM_NORMAL   正常
  ///     USBCAM_SENDERR  異常
  static Future<int> ifUsbcamSend(
      TprTID src, int InOut, String SendData, int len) async {
    TprMsgDevReq2 msgbuff = TprMsgDevReq2();
    String hMyPipe;
    int w_length;
    int ret;

    /* Drvice No. Get */
    hMyPipe = TprLibGeneric.tprLibFindFds(TprDidDef.TPRDIDUSBCAM1);
    if (int.parse(hMyPipe) == -1) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "usbcam lib TprLibFindFds() error");

      return USBCAM_SENDERR;
    }

    /*----------------------------------*/
    /* A requirement message is edited. */
    /*----------------------------------*/
    msgbuff.mid = TprMidDef.TPRMID_DEVREQ;
    msgbuff.tid = TprDidDef.TPRDIDUSBCAM1; /* device ID */
    msgbuff.src = src; /* Spec-N001 */
    msgbuff.io = TprDidDef.TPRDEVOUT;
    msgbuff.result = 0;
    msgbuff.datalen = 0;
    msgbuff.data[0] = '0';
    msgbuff.data[1] = len.toString();
    msgbuff.data[2] = SendData;

    // TODO: 中間 ドライバへの送信処理が不明のため確認後に実装
    /* Send the request */
    //w_length = msgbuff.length + sizeof( tprcommon_t );
    //ret = write(hMyPipe, &msgbuff, w_length);
    //if(ret != w_length) {
    //return USBCAM_SENDERR;
    //}

    return USBCAM_NORMAL;
  }

  /// 録画停止コマンド送信
  /// 関連tprxソース: usbcam.c - if_usbcam_RecStop
  /// 引数:TprTID src
  ///     int rct
  ///     int jnl
  ///     int stopAdd
  /// 戻値:USBCAM_NORMAL   正常
  ///     USBCAM_SENDERR  異常
  static Future<int> ifUsbcamRecStop(
      TprTID src, int rct, int jnl, int stopAdd) async {
    int errCode = 0;
    String SendBuf = '';

    if (AplLibOther.dirChk("/ext/usbcam/") == 0) {
      return USBCAM_NORMAL;
    }

    SendBuf = USBCAM_STOP;
    SendBuf += rct.toString().padLeft(4, '0');
    SendBuf += jnl.toString().padLeft(4, '0');
    SendBuf += stopAdd.toString().padLeft(1);

    errCode =
        await ifUsbcamSend(src, TprDidDef.TPRDEVOUT, SendBuf, SendBuf.length);

    return errCode;
  }
}
