/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_assist_mnt.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_inifile.dart';
import '../../lib/apllib/apllib_other.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_usbcam/if_usbcam.dart';
import '../inc/rc_regs.dart';

class RcUsbCam1 {
  static String USBCAM_DIR = '/ext/usbcam/';
  static int qctkFlg = -1;
  static bool camstopFlg = false;
  static int usbcamTimer = -1;
  static int rcpNo = 0;
  static int prnNo = 0;

  ///  関連tprxソース: rc_usbcam1.c - qctk_flg
  static int INI_GET = 0;

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rc_usbcam1.c - rc_usbcam_stop_set
  static void rcUsbcamStopSet(int stopNow, int typ) {
    return;
  }

  ///  関連tprxソース: rc_usbcam1.c - rc_usbcam_start_stop
  static Future<void> rcUsbcamStartStop(int type, int force) async {
    int stopAdd = 0;
    int flg = 0;
    String __FUNCTION__ = 'rcUsbcamStartStop';
    int tId = await RcSysChk.getTid();

    if (await CmCksys.cmUsbcamCnct() == 0) {
      return;
    }

    if ((await rcUsbcamNgChk()) && (force == 0)) {
      return;
    }

    if (await rcQCTckTaking() != 0) {
      if ((type != UsbCamStat.SP_CAM_START.index) &&
          (type != UsbCamStat.CA_CAM_STOP.index)) return;
      stopAdd = 1;
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_CHECKER:
        break;

      default:
        if (await RcSysChk.rcQCChkQcashierSystem()) {
          if (type == UsbCamStat.QC_CAM_STOP.index) {
            flg = 2;
          } else if (type == UsbCamStat.QC_CAM_START.index) {
            flg = 1;
          }
          break;
        }

        if (type == UsbCamStat.CA_CAM_STOP.index) {
          flg = 2;
        } else if ((type == UsbCamStat.CA_CAM_START.index) ||
            (type == UsbCamStat.SP_CAM_START.index)) {
          flg = 1;
        }
        break;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tId, LogLevelDefine.error,
          "competitionIniGetRcptNo() rxMemRead error\n");
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if ((flg == 2) || ((flg == 1) && (rcUsbcamStopchk()))) {
      if (cBuf.usbcamStat == 1) {
        if (cBuf.usbcamDevStat < 0) {
          if (flg == 2) {
            RcAssistMnt.rcAssistSend(24047);
          }
          TprLog().logAdd(tId, LogLevelDefine.error,
              "rc_UsbCam_Set : STOP Cam not ready\n");
        }
        TprLog().logAdd(tId, LogLevelDefine.normal,
            '$__FUNCTION__ : Cam Stop R[$rcpNo] J[$prnNo]\n');

        rcUsbcamTimerRemove();
        if (rcpNo == 0) {
          rcpNo = await rcUsbcamSetRcpno();
        }
        if (prnNo == 0) {
          prnNo = await rcUsbcamSetJnlno();
        }

        await IfUsbCam.ifUsbcamRecStop(tId, rcpNo, prnNo, stopAdd);
        cBuf.usbcamStat = 0;
        camstopFlg = false;
        rcpNo = prnNo = 0;
      }
    }

    return;
  }

  ///  関連tprxソース: rc_usbcam1.c - rc_usbcam_stopchk
  static bool rcUsbcamStopchk() {
    return camstopFlg;
  }

  ///  関連tprxソース: rc_usbcam1.c - rc_usbcam_TimerRemove
  static Future<int> rcUsbcamTimerRemove() async {
    if (usbcamTimer != -1) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          'usbcam stop timer Remove[$usbcamTimer]');

      Fb2Gtk.gtkTimeoutRemove(usbcamTimer);
    }
    rcUsbcamTimerInit();
    return 0;
  }

  ///  関連tprxソース: rc_usbcam1.c - rc_usbcam_TimerInit
  static void rcUsbcamTimerInit() {
    usbcamTimer = -1;
    return;
  }

  ///  関連tprxソース: rc_usbcam1.c - rc_usbcam_set_rcpno
  static Future<int> rcUsbcamSetRcpno() async {
    int rcpNum = 0;

    rcpNum = RegsMem().tTtllog.t100904.useReceiptNo;

    if (rcpNum == 0) {
      rcpNum = await Counter.competitionGetRcptNo(await RcSysChk.getTid());
    }
    return rcpNum;
  }

  ///  関連tprxソース: rc_usbcam1.c - rc_usbcam_set_jnlno
  static Future<int> rcUsbcamSetJnlno() async {
    int prnNum = 0;

    prnNum = RegsMem().tTtllog.t100904.useJournalNo;

    if (prnNum == 0) {
      prnNum = await Counter.competitionGetPrintNo(await RcSysChk.getTid());
    }
    return prnNum;
  }

  ///  関連tprxソース: rc_usbcam1.c - rc_usbcam_ng_chk
  static Future<bool> rcUsbcamNgChk() async {
    return ((AplLibOther.dirChk(USBCAM_DIR) == 0) ||
        (RcFncChk.rcCheckAutoCheckerMode()) ||
        ((!RcSysChk.rcRGOpeModeChk()) &&
            (!RcSysChk.rcTROpeModeChk()) &&
            (!RcSysChk.rcVDOpeModeChk())) ||
        (await RcSysChk.rcCheckOutSider()));
  }

  ///  関連tprxソース: rc_usbcam1.c - rc_QCTck_Taking
  static Future<int> rcQCTckTaking() async {
    if ((await RcSysChk.rcQRChkPrintSystem()) &&
        (!await RcSysChk.rcChkTwoCnctSystem()) &&
        (!await RcSysChk.rcQCChkQcashierSystem()) &&
        (!await RcSysChk.rcSGChkSelfGateSystem())) {
      if (qctkFlg == -1) {
        String buf = '';
        AplLibIniFile.aplLibIniFile(await RcSysChk.getTid(), INI_GET, 0, "mac_info.ini",
            "movsend", "taking_start", buf);
        qctkFlg = int.parse(buf);
      }
      return qctkFlg;
    }
    return 0;
  }
}
