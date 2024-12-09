/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:sprintf/sprintf.dart';

import '../../../dummy.dart';
import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_macro.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/cm_mbr/cmmbrsys.dart';
import '../inc/rc_custreal_nec.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_acracb.dart';
import 'rc_flrda.dart';
import 'rc_ifevent.dart';
import 'rcfncchk.dart';
import 'rcqr_com.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';

class RcNecRealSvr {
  static const int RCV_WAIT = 300;
  static const int MAX_RETRY_CNT = 999;
  static const int CUSTREALSVR_RD = 1;
  static const int CUSTREALSVR_WT = 2;
  static const int CUST_RETRY_OVER = -1;
  static const int CUST_READ = 1;
  static const int CUSTREAL_USE_TIME = 9998;
  static const int ALL_CHARGE = 1;
  static const int CHANGE_CHARGE = 2;

  static int custreal_retry_cnt = 0;
  static String custreal_mbrcd = '';
  static int custreal_member = 0;
  static int custreal_step = 0;
  static int custreal_rwflg = 0;
  static int rd_retry_cnt = 0;
  static int WT_RETRY_CNT = 1;
  static int RD_RETRY_CNT = 1;
  static int WT_RETRY_WAIT = 1000;
  static int RD_RETRY_WAIT = 1000;
  static int cust_timeremove_flg = 0;
  // static int cust_use_time_chk = CUSTREAL_USE_TIME;

  /// 関連tprxソース: rc_necrealsvr.c - nec_CustReal_OffLineClr()
  static Future<void> necCustRealOffLineClr() async {
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;

    if (necCustRealSvrOffLineChk() != 0) {
      cBuf.custOffline = 0;
      if (!RcFncChk.rcCheckScanCheck()) {
        switch (await RcSysChk.rcKySelf()) {
          case RcRegs.KY_CHECKER:
          case RcRegs.DESKTOPTYPE:
          case RcRegs.KY_SINGLE:
          case RcRegs.KY_DUALCSHR:
            if (await RcFncChk.rcCheckStlMode()) {
              RcIfEvent.stlDisplayTimeOffline(RegsDef.subttl);
              if (FbInit.subinitMainSingleSpecialChk()) {
                if (!await RcSysChk.rcSGChkSelfGateSystem()) {
                  RcIfEvent.stlDisplayTimeOffline(RegsDef.dualSubttl);
                }
              }
            }
            else if ((await RcSysChk.rcSGChkSelfGateSystem())
                && (await RcStlLcd.rcSGDualSubttlDspChk())) {
              RcIfEvent.stlDisplayTimeOffline(RegsDef.subttl);
            } else {
              RcIfEvent.chkDisplayTimeOffline();
            }
            break;
        }
      }
    }
    cBuf.custOffline = 0;
    custreal_rwflg = 0;
  }

  /// 関連tprxソース: rc_necrealsvr.c - nec_CustRealSvr_OffLineChk()
  static int necCustRealSvrOffLineChk() {
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRetC.isInvalid()){
      return 0;
    }
    RxCommonBuf cBuf = xRetC.object;
    return(cBuf.custOffline == 2) ? 1 : 0;
  }

  /// 関連tprxソース: rc_necrealsvr.c - nec_CustReal_RetryCountSet()
  static Future<void> necCustRealRetryCountSet() async {
    String iniFile;
    JsonRet work;

    iniFile = "${EnvironmentData.TPRX_HOME}/conf/custreal_nec.json";
    work = await getJsonValue(iniFile, "custrealsvr", "retrywaittime");
    if (!work.result) {
      WT_RETRY_WAIT = RD_RETRY_WAIT = 1000;
    } else {
      WT_RETRY_WAIT = RD_RETRY_WAIT = work.value * 1000;
    }
    work = await getJsonValue(iniFile, "custrealsvr", "retrycnt");
    if (!work.result) {
      WT_RETRY_CNT = RD_RETRY_CNT = 1;
    } else {
      WT_RETRY_CNT = RD_RETRY_CNT = work.value;
    }
  }

  /// 関連tprxソース: rc_necrealsvr.c - CustRealSvr_UseSleep()
  static Future<void> custRealSvrUseSleep() async {
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    int i;

//   if( rcKy_Self() == KY_CHECKER ) {
    if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER)
        && (!await RcSysChk.rcCheckQCJCSystem())) {
      for(i = 0;i < 40 && ((cBuf.custOffline == 1)
          || ((tsBuf.custrealNec.order != -2) && (tsBuf.custrealNec.order != 0)))
          && (custreal_rwflg == 0); i++) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "CustRealSvr UseSleep");
        TprMacro.usleep(300000);
      }
    } else {
      for(i = 0;i < 40 && ((cBuf.custOffline == 1)
          || ((tsBuf.custrealNec.order != -1) && (tsBuf.custrealNec.order != 0)))
          && (custreal_rwflg == 0); i++) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "CustRealSvr UseSleep");
        TprMacro.usleep(300000);
      }
    }
  }

  /// 関連tprxソース: rc_necrealsvr.c - nec_CustReal_Write()
  static Future<int> necCustRealWrite(TTtlLog ttllog, RxMemPrn prnbuf) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_SOCKET);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxSocket readBuf = xRet.object;
    int ret;
    int retryFlg = 0;
    AcMem cMem = SystemFunc.readAcMem();

    cust_timeremove_flg = 0;
    if (cMem.stat.dspEventMode != 100) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "CustRealSrv Write Start TimerRemove");
      RcIfEvent.rxChkTimerRemove();
      await RcIfEvent.rcWaitSave();
      cust_timeremove_flg = 1;
    }
    do {
      await RcIfEvent.rcWaitSave();
      TprMacro.usleep((RCV_WAIT * 100));
      if ((ret = necCustRealSvrInquData(readBuf)) != RcMbr.RCMBR_NON_READ) {
        if (await necCustRealWriteAnsChk(ret, readBuf) != 0) {
          ttllog.t100700.realCustsrvFlg = 1;
          if (readBuf.order == RcCustrealNec.ORDER_NEC_ERRRT) {
            retryFlg = 1;
          }
        }
        else {
          ttllog.t100700.tpntTtlsrv = await necCustRealGetAnsttlsrv(readBuf, prnbuf);
          if (RcSysChk.rcVDOpeModeChk()) {
            ttllog.t100700.lpntTtlsrv =
                ttllog.t100700.tpntTtlsrv + ttllog.t100700.dpntTtlsrv;
          } else {
            ttllog.t100700.lpntTtlsrv =
                ttllog.t100700.tpntTtlsrv - ttllog.t100700.dpntTtlsrv;
          }
        }
      }
    } while (ret == RcMbr.RCMBR_NON_READ);
    if (cust_timeremove_flg != 0) {
      cust_timeremove_flg = 0;
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "CustRealSrv Write End TimerAdd");
      await RcIfEvent.rxChkTimerAdd();
    }
    return (retryFlg);
  }

  /// 関連tprxソース: rc_necrealsvr.c - nec_CustRealSvr_InquData()
  static int necCustRealSvrInquData(RxSocket readBuf) {
    int ret = RcMbr.RCMBR_NON_READ;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_SOCKET);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxSocket rdBuf = xRet.object;

    if (custreal_retry_cnt < MAX_RETRY_CNT) {
      // if (rxQueueRead(RXQUEUE_CUSTREALNEC_RSOCKET, RXQUEUE_NOWAIT) == RXQUEUE_OK) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_CUSTREAL_NECSOCKET);
      if (xRet.isValid()) {
        rdBuf = readBuf;
        // UrlDecorde( read_buf->data, rd_buf.data );
        rdBuf.data = Uri.decodeFull(readBuf.data);
        readBuf.data = rdBuf.data;
        ret = CUST_READ;
      } else {
        custreal_retry_cnt++;
      }
      // } else {
      //   custreal_retry_cnt++;
      // }
    }
    if ((ret == RcMbr.RCMBR_NON_READ) &&
        (custreal_retry_cnt >= MAX_RETRY_CNT)) {
      ret = CUST_RETRY_OVER;
    }
    return (ret);
  }

  /// 関連tprxソース: rc_necrealsvr.c - nec_CustReal_WriteAnsChk()
  static Future<int> necCustRealWriteAnsChk(int rcvret, RxSocket read_buf) async {
    String errLog;
    int ret = 0;

    if ((rcvret == CUST_READ) &&
        (read_buf.order == RcCustrealNec.ORDER_NEC_RECEIVE)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "custreal server write Ans");
      errLog = "[$custreal_retry_cnt][${read_buf.data[0]}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, errLog);

      errLog = "[100][${read_buf.data[100]}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, errLog);

      errLog = "[200][${read_buf.data[200]}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, errLog);

      errLog = "[300][${read_buf.data[300]}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, errLog);

      errLog = "[400][${read_buf.data[400]}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, errLog);

      errLog = "[500][${read_buf.data[500]}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, errLog);

      if ((ret = await necCustRealSvrChkRecvData(CUSTREALSVR_WT, read_buf.data[0])) != Typ.NORMAL) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "custreal server write error");
        await necCustRealOffLineSet();
      }
      else {
        await necCustRealOffLineClr();
      }
    }
    else {
      if (read_buf.order != RcCustrealNec.ORDER_NEC_RECEIVE) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "Send to Cust Receive Error");
      } else {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "Send to Cust COMPC NG!");
      }
      await necCustRealOffLineSet();
      ret = DlgConfirmMsgKind.MSG_REQ_PLU_ERR.dlgId;
      // rxMemClr(RXMEM_SOCKET); 共有メモリRxSocketの初期化処理
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_SOCKET);
      if (xRet.isValid()) {
        xRet.object = RxSocket();
      }
    }
    return ret;
  }

  /// 関連tprxソース: rc_necrealsvr.c - nec_CustRealSvrChkRecvData()
  static Future<int> necCustRealSvrChkRecvData(int kind, String buf) async {
    int p;
    int skip;
    String buf2;

    if (kind == CUSTREALSVR_WT) {
      if (!buf.contains("FCSP0004") && !buf.contains("FCSP0006")) {
        return (DlgConfirmMsgKind.MSG_WRITEERR.dlgId);
      } else {
        p = buf.indexOf("FCSP0004");
        if (p == -1) {
          p = buf.indexOf("FCSP0006");
        }
        if (p != -1) {
          buf2 = buf.substring(p);
          for (skip = 0; skip < 16; skip++) {
            p = buf2.indexOf(',');
            if (p != -1) {
              p++;
              buf2 = buf2.substring(p);
            } else {
              break;
            }
          }
          if (p != -1) {
            buf2 = buf2.substring(p);
            if (buf2[0] != 'N') {
              return (DlgConfirmMsgKind.MSG_WRITEERR.dlgId);
            }
          } else {
            return (DlgConfirmMsgKind.MSG_WRITEERR.dlgId);
          }
        } else {
          return (DlgConfirmMsgKind.MSG_WRITEERR.dlgId);
        }
      }
    } else {
      if (!buf.contains("FCSP0002")) {
        await necCustRealOffLineSet();
        return (DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId);
      } else {
        if (buf.contains("N000000000") || buf.contains("N058000000")) {
          return (Typ.NORMAL);
        }
        else if (buf.contains("E021000000")) {
          return (DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId);
        } else {
          return (Typ.NORMAL);
        }
      }
    }
    return (Typ.NORMAL);
  }

  /// 関連tprxソース: rc_necrealsvr.c - nec_CustReal_OffLineSet()
  static Future<void> necCustRealOffLineSet() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    cBuf.custOffline = 2;
    if (!RcFncChk.rcCheckScanCheck()) {
      switch (await RcSysChk.rcKySelf()) {
        case RcRegs.KY_CHECKER:
        case RcRegs.DESKTOPTYPE:
        case RcRegs.KY_SINGLE:
        case RcRegs.KY_DUALCSHR:
          if (await RcFncChk.rcCheckStlMode()) {
            RcIfEvent.stlDisplayTimeOffline(RegsDef.subttl);
            if (FbInit.subinitMainSingleSpecialChk() == true) {
              if (!await RcSysChk.rcSGChkSelfGateSystem()) {
                RcIfEvent.stlDisplayTimeOffline(RegsDef.dualSubttl);
              }
            }
          }
          else if ((await RcSysChk.rcSGChkSelfGateSystem())
              && (await RcStlLcd.rcSGDualSubttlDspChk())) {
            RcIfEvent.stlDisplayTimeOffline(RegsDef.subttl);
          } else {
            Dummy.chkDisplayTimeOffline();
          }
          break;
      }
    }
    custreal_rwflg = 0;
  }

  /// 関連tprxソース: rc_necrealsvr.c - nec_CustReal_GetAnsttlsrv()
  static Future<int> necCustRealGetAnsttlsrv(RxSocket read_buf, RxMemPrn? prn) async {
    int ttlsrv = 0;
    int skip, i;
    int m_flg = 0;
    int p = 0;
    String date_mm = "";
    int mm = 0;
    String data2 = "";
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    m_flg = 0;
    ttlsrv = 0;
    if (prn != null) {
      mem.tTtllog.t100700Sts.webrealsrvExpPointPrn = 0;
      mem.tTtllog.t100700Sts.webrealsrvExpDate = "";
      mem.tTtllog.t100700Sts.webrealsrvExpPoint = 0;
      mem.tTtllog.t100700Sts.achievedFlg = 0;
      mem.tTtllog.t100700Sts.achievedAmt = 0;
    }

    p = read_buf.data.indexOf("FCSP0004");
    if (p == -1) {
      p = read_buf.data.indexOf("FCSP0006");
    }
    if (p != -1) {
      for (skip = 0; skip < 23; skip++) {
        data2 = read_buf.data.substring(p);
        p = data2.indexOf(',');
        if (p != -1) {
          p++;
          data2 = data2.substring(p);
        } else {
          break;
        }
      }
      if (p != -1) {
        /* total point */
        m_flg = int.parse(data2.substring(0, 1));
        p = data2.indexOf(',');
        data2 = data2.substring(p+1);
        p = data2.indexOf(',');
        ttlsrv = int.parse(data2.substring(0, p));
        data2 = data2.substring(p+1);
        if (m_flg == 1) {
          ttlsrv = ttlsrv * -1;
        }
        if (prn == null) {
          return (ttlsrv);
        }
        /* revocation */
        p = data2.indexOf(',');
        if (p == -1) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "Revocation Data Not");
          return (ttlsrv);
        }
        data2 = data2.substring(p+1);
        p = data2.indexOf(',');
        if (p == -1) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "Revocation Data Not");
          return (ttlsrv);
        }
        data2 = data2.substring(p+1);
        m_flg = int.parse(data2.substring(0, 1));
        p = data2.indexOf(',');
        data2 = data2.substring(p+1);
        /* point */
        p = data2.indexOf(',');
        for (i = 0; i < p; i++) {
          mem.tTtllog.t100700Sts.webrealsrvExpPoint =
              mem.tTtllog.t100700Sts.webrealsrvExpPoint * 10;
        }
        mem.tTtllog.t100700Sts.webrealsrvExpPoint += int.parse(data2.substring(0, p));
        data2 = data2.substring(p+1);
        p = data2.indexOf(',');
        if (p != -1) {
          /* yyyymmdd */
          data2 = data2.substring(p+1);
          p = data2.indexOf(',');
          mem.tTtllog.t100700Sts.webrealsrvExpDate += data2.substring(0, p);
          data2 = data2.substring(p);
        }
        else {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "Revocation Day Not Data");
        }
        if (mem.tTtllog.t100700Sts.webrealsrvExpDate.isNotEmpty) {
          /* preint check */
          mm = 0;
          date_mm = cBuf.dbOpenClose.sale_date!.substring(5,7);
          mm = int.parse(date_mm);
          if (mem.tTtllog.t100700Sts.webrealsrvExpPoint != 0) {
            if (((cBuf.dbTrm.outpntPrnStart != 0) &&
                (cBuf.dbTrm.outpntPrnEnd != 0) &&
                ((mm >= 1) && (mm <= 12)))) {
              if (cBuf.dbTrm.outpntPrnStart <= cBuf.dbTrm.outpntPrnEnd) {
                if ((cBuf.dbTrm.outpntPrnStart <= mm) &&
                    (cBuf.dbTrm.outpntPrnEnd >= mm)) {
                  mem.tTtllog.t100700Sts.webrealsrvExpPointPrn = 1;
                }
              }
              else {
                if ((cBuf.dbTrm.outpntPrnStart <= mm) ||
                    (cBuf.dbTrm.outpntPrnEnd >= mm)) {
                  mem.tTtllog.t100700Sts.webrealsrvExpPointPrn = 1;
                }
              }
            }
          }
        }
      }
    }
    return (ttlsrv);
  }

  /// 関連tprxソース: rc_necrealsvr.c - nec_CustRealSvrFlWt()
  static Future<int> necCustRealSvrFlWt(TTtlLog ttllog, RxMemPrn prnbuf) async {
    int ret = Typ.NORMAL;
    int wtRetryCnt;
    String log;
    int retryFlg;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_SOCKET);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxSocket buf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    // cm_clr(log, sizeof(log));
    log = "CustRealSvr NEC Write Read offline flg = ${ttllog.t100700.realCustsrvFlg} \n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    if (ttllog.t100700.realCustsrvFlg != 2) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "CustRealSvr NEC Write NonRead Skip\n");
      ttllog.t100700.realCustsrvFlg = 1;
      return (Typ.NORMAL);
    }
    if (necCustRealSvrOffLineChk() != 0 && (ttllog.t100700.realCustsrvFlg != 2)) {
      ttllog.t100700.realCustsrvFlg = 1;
      return (Typ.NORMAL);
    }
    // if (!strncmp(mem.tHeader.cust_no[2], CUSTREAL_NEC_NORDCD, CmMbrSys.cmMbrcdLen() - 2 - 1)) {
    String custNo = "";
    if (mem.tHeader.cust_no != null) {
      custNo = mem.tHeader.cust_no!.substring(2);
    }
    if (custNo != RcCustrealNec.CUSTREAL_NEC_NORDCD) {
      ttllog.t100700.realCustsrvFlg = 0;
      return (Typ.NORMAL);
    }

    await necCustRealRetryCountSet();

    if (tsBuf.custrealNec.order == 0) {
      if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
          (!await RcSysChk.rcCheckQCJCSystem())) {
        tsBuf.custrealNec.order = -2;
      } else {
        tsBuf.custrealNec.order = -1;
      }
    }
    await custRealSvrUseSleep();
    if (necCustRealSvrOffLineChk() != 0 && (ttllog.t100700.realCustsrvFlg != 2)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "write Wait Offline");
      await necCustRealOffLineSet();
      ttllog.t100700.realCustsrvFlg = 1;
      return (ret);
    }
    ttllog.t100700.realCustsrvFlg = 0;
    cBuf.custOffline = 1;
    custreal_rwflg = 2;

    if (ttllog.t100700Sts.magMbrSys == 1) {
      /* 買上追加 */
      if (((mem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_VOID) &&
          (ttllog.t101100.dsptAddpnt < 0)) ||
          ((mem.tHeader.ope_mode_flg != OpeModeFlagList.OPE_MODE_VOID) &&
              (ttllog.t101100.dsptAddpnt >= 0))) {
        buf.data = await necCustRealSvrSetFCSP03Data(buf.data, ttllog);
      } else {
        buf.data = await necCustRealSvrSetFCSP05Data(buf.data, ttllog);
      }
    }
    else {
      if ((ttllog.t100001Sts.voidMacNo == 0) &&
          (ttllog.t100003.refundQty == 0) &&
          (mem.tHeader.ope_mode_flg != OpeModeFlagList.OPE_MODE_VOID)) {
        buf.data = await necCustRealSvrSetFCSP03Data(buf.data, ttllog);
      }
      else {
        buf.data = await necCustRealSvrSetFCSP05Data(buf.data, ttllog);
      }
    }
    buf.order = RcCustrealNec.ORDER_NEC_REQUEST;

    custreal_retry_cnt = 0;
    custreal_mbrcd = mem.tHeader.cust_no!.substring(0, CmMbrSys.cmMbrcdLen());
    wtRetryCnt = 0;
    do {
      // if (rxMemWrite(RXMEM_CUSTREAL_NECSOCKET, &buf) == RXMEM_OK) {
      //   rxQueueWrite(RXQUEUE_CUSTREALNEC_TSOCKET);
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_CUSTREAL_NECSOCKET);
      if (xRet.isValid()) {
        retryFlg = await necCustRealWrite(ttllog, prnbuf);
        if (retryFlg != 0 && ((wtRetryCnt + 1) <= WT_RETRY_CNT)) {
          await necCustRealOffLineClr();
          ttllog.t100700.realCustsrvFlg = 0;
          cBuf.custOffline = 1;
          custreal_rwflg = 2;
          custreal_retry_cnt = 0;
          wtRetryCnt ++;
          log = "CustRealSvr Write: Retry[$wtRetryCnt]";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          TprMacro.usleep(WT_RETRY_WAIT * 1000);
        }
        else {
          wtRetryCnt = WT_RETRY_CNT + 1;
        }
      }
      else {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "custreal server Write SOCKET Write Error");
        await necCustRealOffLineSet();
        ttllog.t100700.realCustsrvFlg = 1;
        wtRetryCnt = WT_RETRY_CNT + 1;
      }
    } while (wtRetryCnt <= WT_RETRY_CNT);
    tsBuf.custrealNec.order = 0;

    return ret;
  }

  /// 関連tprxソース: rc_necrealsvr.c - nec_CustRealSvrSetFCSP03Data()
  static Future<String> necCustRealSvrSetFCSP03Data(String senddata, TTtlLog ttllog) async {
    String stre_cd = "";
    String mac_no = "";
    String work = "";
    String buf = "";
    String nowdate = "";
    String nowtime = "";
    String saledate = "";
    int compcd = 0;
    String comp_cd = "";
    int tenantcd = 0;
    String tenant_cd = "";
    String receipt_no = "";
    String log = "";

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return "";
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if (cBuf.dbOpenClose.sale_date != null) {
      saledate = cBuf.dbOpenClose.sale_date![0];
      saledate += cBuf.dbOpenClose.sale_date![1];
      saledate += cBuf.dbOpenClose.sale_date![2];
      saledate += cBuf.dbOpenClose.sale_date![3];
      saledate += cBuf.dbOpenClose.sale_date![5];
      saledate += cBuf.dbOpenClose.sale_date![6];
      saledate += cBuf.dbOpenClose.sale_date![8];
      saledate += "${cBuf.dbOpenClose.sale_date![9]},";
    } else {
      saledate = "00000000,";
    }

    if (mem.tHeader.endtime != null) {
      nowdate = mem.tHeader.endtime![0];
      nowdate += mem.tHeader.endtime![1];
      nowdate += mem.tHeader.endtime![2];
      nowdate += mem.tHeader.endtime![3];
      nowdate += mem.tHeader.endtime![5];
      nowdate += mem.tHeader.endtime![6];
      nowdate += mem.tHeader.endtime![8];
      nowdate += "${mem.tHeader.endtime![9]},";

      nowtime += mem.tHeader.endtime![11];
      nowtime += mem.tHeader.endtime![12];
      nowtime += mem.tHeader.endtime![14];
      nowtime += mem.tHeader.endtime![15];
      nowtime += mem.tHeader.endtime![17];
      nowtime += "${mem.tHeader.endtime![18]},";
    } else {
      nowdate = "00000000,";
      nowtime = "000000,";
    }

    stre_cd = sprintf("%012d,", [cBuf.iniMacInfo.system.shpno]);
    mac_no = sprintf("%013d,", [
      (await CompetitionIni.competitionIniGetRcptNo(await RcSysChk.getTid()))
          .value
    ]);

    tenantcd = await getTenantCd();
    tenant_cd = sprintf("%08d,", [tenantcd]);
    compcd = getCompCd();
    comp_cd = sprintf("%06d,", [compcd]);
    receipt_no = sprintf("%08d,", [mem.tHeader.receipt_no]);

    // #if ARCS_MBR
    if (CompileFlag.ARCS_MBR) {
      if ((RcqrCom.qrReadMacNo != 0) &&
          (RcqrCom.qrReadSptendCnt > 0) &&
          (RcqrCom.qrReadSptendCnt == mem.tTtllog.t100001Sts.sptendCnt) &&
          (mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt < 0) &&
          ((await CompetitionIni.competitionIniGetRcptNo(
              await RcSysChk.getTid())).value) != RcqrCom.qrReadMacNo) {
        mac_no = sprintf("%013d,", [RcqrCom.qrReadMacNo]);
        receipt_no = sprintf("%08d,", [RcqrCom.qrReadReptNo]);

        log = sprintf(
            "NEC Cust real Server Change Speezer mac_no[%013d]->[%013d], receipt_no[%08d]->[%08d] sptend_cnt[%d]",
            [
              (await CompetitionIni.competitionIniGetRcptNo(
                  await RcSysChk.getTid())).value,
              RcqrCom.qrReadMacNo,
              mem.tHeader.receipt_no,
              RcqrCom.qrReadReptNo,
              RcqrCom.qrReadSptendCnt
            ]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      }
      // #endif
    }

    buf += "FCSP0003,001,0,0310,";
    buf += saledate; /* 営業日付 YYYYMMDD */
    buf += nowdate; /* データ作成日付(システム日付) YYYYMMDD */
    buf += nowtime; /* データ作成時刻(システム時刻) HH24MISS*/
    buf += "01,"; /* 発生元区分 */
    buf += tenant_cd; /* テナントコード */
    buf += comp_cd; /* 企業コード */
    buf += "000000,"; /* 企業支部コード */
    buf += "000000,"; /* 企業支部コード2 */
    buf += stre_cd; /* 企業店舗コード(店舗コード) */
    buf += mac_no; /* 企業端末コード(マシン番号) */
    buf += receipt_no; /* 取引番号(レシート番号) */
    /* 会員ID */

    buf += "0000";
    if (mem.tHeader.cust_no != null) {
      work = mem.tHeader.cust_no!.substring(3);
    } else {
      work = "0";
    }
    buf += work;
    buf += ",";
    buf += "1,"; /* ポイント大分類1 */
    /* ポイント中分類1 */

    if (prepaidChargeChk(ttllog) == ALL_CHARGE) {
      buf += "51,";
      if (mem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_VOID) {
        if (ttllog.t100900.totalChgamt >= 0) {
          buf += "1,";
        } else {
          buf += "0,";
        }
      }
      else {
        if (ttllog.t100900.totalChgamt >= 0) {
          buf += "0,";
        } else {
          buf += "1,";
        }
      }
      /* ポイント数1 */
      work = "${ttllog.t100900.totalChgamt.abs()},";
      buf += work;
    }
    else {
      buf += "01,";
      /* ポイント符号1  */
      if (ttllog.t100700Sts.magMbrSys == 1) {
        /* 買上追加 */
        if (mem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_VOID) {
          if (ttllog.t101100.dsptAddpnt >= 0) {
            buf += "1,";
          } else {
            buf += "0,";
          }
        }
        else {
          if (ttllog.t101100.dsptAddpnt >= 0) {
            buf += "0,";
          } else {
            buf += "1,";
          }
        }
        /* ポイント数1 */
        work = "${ttllog.t101100.dsptAddpnt.abs()},";
        buf += work;
      }
      else {
        /* 登録 */
        if (mem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_VOID) {
          if (ttllog.t100700.dpntTtlsrv >= 0) {
            buf += "1,";
          } else {
            buf += "0,";
          }
        }
        else {
          if (ttllog.t100700.dpntTtlsrv >= 0) {
            buf += "0,";
          } else {
            buf += "1,";
          }
        }
        /* ポイント数1 */
        int n = ttllog.t100700.dpntTtlsrv.abs() -
            ttllog.t100900.totalChgamt.abs();
        work = "$n,";
        buf += work;
      }
    }
    /* ポイント大分類2 ～ ポイント数2 */
    if (prepaidChargeChk(ttllog) == CHANGE_CHARGE) {
      buf += "1,51,";
      buf += "0,";
      work = "${ttllog.t100900.totalChgamt.abs()},";
      buf += work;
    }
    else {
      buf += "0,00,0,0,";
    }
    buf += "0,00,0,0,"; /* ポイント大分類3 ～ ポイント数3 */
    buf += "0,00,0,0,"; /* 未使用 */

    if (ttllog.t100700Sts.magMbrSys == 1) {
      /* 買上追加 */
      buf += "0,"; /* ポイント対象売上金額符号 */
      buf += "0,"; /* ポイント対象売上金額 */
      buf += "0,"; /* 売上金額符号 */
      buf += "0,"; /* 売上額       */
      buf += "0,"; /* 売上対象外金額符号 */
      buf += "0,"; /* 売上対象外金額     */
    }
    else {
      if (prepaidChargeChk(ttllog) == ALL_CHARGE) {
        buf += "0,"; /* ポイント対象売上金額符号 */
        buf += "0,"; /* ポイント対象売上金額 */
        buf += "0,"; /* 売上金額符号 */
        buf += "0,"; /* 売上額       */
      }
      else {
        /* ポイント対象売上金額符号 */
        if (mem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_VOID) {
          if (mem.tTtllog.calcData.stlIntaxInAmt >= 0) {
            buf += "1,";
          } else {
            buf += "0,";
          }
        }
        else {
          if (mem.tTtllog.calcData.stlIntaxInAmt >= 0) {
            buf += "0,";
          } else {
            buf += "1,";
          }
        }
        /* ポイント対象売上金額 */
        work = "${mem.tTtllog.calcData.stlIntaxInAmt.abs()},";
        buf += work;
        /* 売上金額符号 */
        if (mem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_VOID) {
          if (mem.tTtllog.calcData.stlIntaxInAmt >= 0) {
            buf += "1,";
          } else {
            buf += "0,";
          }
        }
        else {
          if (mem.tTtllog.calcData.stlIntaxInAmt >= 0) {
            buf += "0,";
          } else {
            buf += "1,";
          }
        }
        /* 売上額       */
        work = "${mem.tTtllog.calcData.stlIntaxInAmt.abs()},";
        buf += work;
        /* 売上対象外金額符号 */
      }
      if (mem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_VOID) {
        if (ttllog.t100900.todayChgamt >= 0) {
          buf += "1,";
        } else {
          buf += "0,";
        }
      }
      else {
        if (ttllog.t100900.todayChgamt >= 0) {
          buf += "0,";
        } else {
          buf += "1,";
        }
      }
      /* 売上対象外金額     */
      work = "${ttllog.t100900.todayChgamt.abs()},";
      buf += work;
    }
    buf += "0,0,,,,,,,"; /* ポイント利用符号 -  企画コード4 */
    /* レシート企画コード1 */
    if (ttllog.t101000[0].promTicketNo == 0) {
      buf += ",";
    } else {
      work = sprintf("%015d,", [ttllog.t101000[0].promTicketNo]);
      buf += work;
    }
    /* レシート企画コード2 */
    if (ttllog.t101000[1].promTicketNo == 0) {
      buf += ",";
    } else {
      work = sprintf("%015d,", [ttllog.t101000[1].promTicketNo]);
      buf += work;
    }
    /* レシート企画コード3 */
    if (ttllog.t101000[2].promTicketNo == 0) {
      buf += ",";
    } else {
      work = sprintf("%015d,", [ttllog.t101000[2].promTicketNo]);
      buf += work;
    }
    /* レシート企画コード4 */
    if (ttllog.t101000[3].promTicketNo == 0) {
      buf += ",";
    } else {
      work = sprintf("%015d,", [ttllog.t101000[3].promTicketNo]);
      buf += work;
    }
    buf += ",,,,"; /* 未使用 - ポイント修正承認者ID */
    if (prepaidChargeChk(ttllog) != ALL_CHARGE) {
      buf += "1,,,,"; /* 拡張領域使用有無 - 予備項目A3*/
      if (await rcNewARCSChkRARACrdtReceipt(ttllog)) {
        buf += "01,";
      } else if (await rcNewARCSChkQUICPayReceipt(ttllog)) {
        buf += "01,";
      } else if (await rcNewARCSChkiDReceipt(ttllog)) {
        buf += "01,";
      } else if (await rcNewARCSChkHouseCrdtReceipt(ttllog)) {
        buf += "02,";
      } else if (await rcNewARCSChkPrepaidReceipt(ttllog)) {
        buf += "03,";
      } else if (rcChkOffLineCrdtReceipt(ttllog) != -1) {
        buf += "01,";
      } else {
        buf += "04,"; /* 予備項目B1 */
      }
      buf += ",,"; /* 予備項目B2 - B3 */
    }
    else {
      buf += "0,,,,,,,"; /* 拡張領域使用有無 */
    }
    buf += "END";
    senddata = buf;
    return senddata;
  }

  /// 関連tprxソース: rc_necrealsvr.c - rcChk_Receipt()
  static Future<int> rcChkReceipt(int crdt_typ, TTtlLog ttl) async {
    int i;
    List<int> tendcd = []; //[SPTEND_MAX];
    KopttranBuff KOPTTRAN = KopttranBuff();

    for (i = 0; i < RcAcracb.SPTEND_MAX; i++) {
      tendcd.add(ttl.t100100[i].sptendCd);
      if (RcSysChk.rcChkKYCHA(tendcd[i])) {
        await RcFlrda.rcReadKopttran(tendcd[i], KOPTTRAN);
        if ((KOPTTRAN.crdtTyp == crdt_typ) && (KOPTTRAN.crdtEnbleFlg == 1)) {
          return (tendcd[i]);
        }
      }
    }
    return (-1);
  }

  /// 関連tprxソース: rc_necrealsvr.c - rcNewARCS_ChkRARACrdtReceipt()
  static Future<bool> rcNewARCSChkRARACrdtReceipt(TTtlLog ttllog) async {
    return ((await rcChkReceipt(0, ttllog) != -1) &&
        ((ttllog.t100700Sts.mbrTyp == Mcd.MCD_RLSCRDT) ||
            (ttllog.t100700Sts.mbrTyp == Mcd.MCD_RLSVISA)));
  }

  /// 関連tprxソース: rc_necrealsvr.c - rcNewARCS_ChkQUICPayReceipt()
  static Future<bool> rcNewARCSChkQUICPayReceipt(TTtlLog ttllog) async {
    return ((await rcChkReceipt(19, ttllog) != -1) &&
        ((ttllog.t100700Sts.mbrTyp == Mcd.MCD_RLSCRDT) ||
            (ttllog.t100700Sts.mbrTyp == Mcd.MCD_RLSVISA)));
  }

  /// 関連tprxソース: rc_necrealsvr.c - rcNewARCS_ChkiDReceipt()
  static Future<bool> rcNewARCSChkiDReceipt(TTtlLog ttllog) async {
    return ((await rcChkReceipt(20, ttllog) != -1) &&
        ((ttllog.t100700Sts.mbrTyp == Mcd.MCD_RLSCRDT) ||
            (ttllog.t100700Sts.mbrTyp == Mcd.MCD_RLSVISA)));
  }

  /// 関連tprxソース: rc_necrealsvr.c - rcNewARCS_ChkHouseCrdtReceipt()
  static Future<bool> rcNewARCSChkHouseCrdtReceipt(TTtlLog ttllog) async {
    return ((await rcChkReceipt(0, ttllog) != -1) &&
        ((ttllog.t100700Sts.mbrTyp == Mcd.MCD_RLSHOUSE) ||
            (ttllog.t100700Sts.mbrTyp == Mcd.MCD_RLSCARD)));
  }

  /// 関連tprxソース: rc_necrealsvr.c - rcNewARCS_ChkPrepaidReceipt()
  static Future<bool> rcNewARCSChkPrepaidReceipt(TTtlLog ttllog) async {
    return (await rcChkReceipt(6, ttllog) != -1);
  }

  /// 関連tprxソース: rc_necrealsvr.c - rcChk_OffLineCrdtReceipt()
  static int rcChkOffLineCrdtReceipt(TTtlLog ttl) {
    int i;
    List<int> tendcd = []; //[SPTEND_MAX];

    for (i = 0; i < RcAcracb.SPTEND_MAX; i++) {
      tendcd.add(ttl.t100100[i].sptendCd);
      if (tendcd[i] == FuncKey.KY_CHA9.keyId) {
        return (tendcd[i]);
      }
    }
    return (-1);
  }

  /// 関連tprxソース: rc_necrealsvr.c - prepaid_charge_chk()
  static int prepaidChargeChk(TTtlLog ttllog) {
    if (ttllog.t100900.todayChgamt != 0) {
      if (ttllog.t100001Sts.chrgFlg == 0) {
        return (ALL_CHARGE);
      } else if (ttllog.t100001Sts.chrgFlg == 1) {
        return (CHANGE_CHARGE);
      }
    }
    return 0;
  }

  /// 関連tprxソース: rc_necrealsvr.c - getCompCd()
  static int getCompCd() {
    int compCd = 0;
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRetC.object;

    compCd = (cBuf.dbTrm.ralseRealCompCd % 100);
    return compCd;
  }

  /// 関連tprxソース: rc_necrealsvr.c - getTenantCd()
  static Future<int> getTenantCd() async {
    int tenant_cd = 0;
    String filePath = "";
    JsonRet jsonRet;

    filePath = sprintf("%s/conf/custreal_nec.json", [EnvironmentData().env['TPRX_HOME']]);
    jsonRet = await getJsonValue(filePath, 'nec', 'tenantcd');
    if (!jsonRet.result) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "TprLibGetIni error(tenantcd)");
      tenant_cd = 1001006;
    } else {
      tenant_cd = jsonRet.value;
    }
    return tenant_cd;
  }

  /// 関連tprxソース: rc_necrealsvr.c - nec_CustRealSvrSetFCSP05Data()
  static Future<String> necCustRealSvrSetFCSP05Data(String senddata, TTtlLog ttllog) async {
    String stre_cd = "";
    String mac_no = "";
    String work = "";
    String buf = "";
    String nowdate = "";
    String nowtime = "";
    String saledate = "";
    int compcd = 0;
    String comp_cd = "";
    int tenantcd = 0;
    String tenant_cd = "";
    String receipt_no = "";
    String mbrcd = "";
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return "";
    }
    RxCommonBuf cBuf = xRetC.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if (cBuf.dbOpenClose.sale_date != null) {
      saledate = cBuf.dbOpenClose.sale_date![0];
      saledate += cBuf.dbOpenClose.sale_date![1];
      saledate += cBuf.dbOpenClose.sale_date![2];
      saledate += cBuf.dbOpenClose.sale_date![3];
      saledate += cBuf.dbOpenClose.sale_date![5];
      saledate += cBuf.dbOpenClose.sale_date![6];
      saledate += cBuf.dbOpenClose.sale_date![8];
      saledate += "${cBuf.dbOpenClose.sale_date![9]},";
    } else {
      saledate = "00000000,";
    }

    if (mem.tHeader.endtime != null) {
      nowdate = mem.tHeader.endtime![0];
      nowdate += mem.tHeader.endtime![1];
      nowdate += mem.tHeader.endtime![2];
      nowdate += mem.tHeader.endtime![3];
      nowdate += mem.tHeader.endtime![5];
      nowdate += mem.tHeader.endtime![6];
      nowdate += mem.tHeader.endtime![8];
      nowdate += "${mem.tHeader.endtime![9]},";

      nowtime += mem.tHeader.endtime![11];
      nowtime += mem.tHeader.endtime![12];
      nowtime += mem.tHeader.endtime![14];
      nowtime += mem.tHeader.endtime![15];
      nowtime += mem.tHeader.endtime![17];
      nowtime += "${mem.tHeader.endtime![18]},";
    } else {
      nowdate = "00000000,";
      nowtime = "000000,";
    }

    stre_cd = sprintf("%012d,", [cBuf.iniMacInfo.system.shpno]);
    mac_no = sprintf("%013d,", [
      (await CompetitionIni.competitionIniGetRcptNo(await RcSysChk.getTid()))
          .value
    ]);

    tenantcd = await getTenantCd();
    tenant_cd = sprintf("%08d,", [tenantcd]);

    compcd = getCompCd();
    comp_cd = sprintf("%06d,", [compcd]);

    receipt_no = sprintf("%08d,", [mem.tHeader.receipt_no]);

    mbrcd += "0000";
    if (mem.tHeader.cust_no != null) {
      work = mem.tHeader.cust_no!.substring(3);
    } else {
      work = "0";
    }
    mbrcd += work;
    mbrcd += ",";

    buf += "FCSP0005,001,0,0410,";
    buf += saledate; /* 営業日付 YYYYMMDD */
    buf += nowdate; /* データ作成日付(システム日付) YYYYMMDD */
    buf += nowtime; /* データ作成時刻(システム時刻) HH24MISS*/
    buf += "01,"; /* 発生元区分 */
    buf += tenant_cd; /* テナントコード */
    buf += comp_cd; /* 企業コード */
    buf += "000000,"; /* 企業支部コード */
    buf += "000000,"; /* 企業支部コード2 */
    buf += stre_cd; /* 企業店舗コード(店舗コード) */
    buf += mac_no; /* 企業端末コード(マシン番号) */
    buf += receipt_no; /* 取引番号(レシート番号) */
    buf += mbrcd; /* 会員ID */
    buf += "1,"; /* ポイント大分類1 */
    if (prepaidChargeChk(ttllog) == ALL_CHARGE) {
      buf += "51,";
      buf += "0,";
      work = "${ttllog.t100900.totalChgamt.abs()},";
    }
    else {
      buf += "01,"; /* ポイント中分類1 */
      buf += "0,"; /* ポイント符号1  */
      /* ポイント数1 */
      if (ttllog.t100700Sts.magMbrSys == 1) {
        /* 買上追加 */
        work = "${ttllog.t101100.dsptAddpnt.abs()},";
      } else {
        work = "${(ttllog.t100700.dpntTtlsrv - ttllog.t100900.totalChgamt).abs()},";
      }
    }
    buf += work;
    if (prepaidChargeChk(ttllog) == CHANGE_CHARGE) {
      buf += "1,51,";
      buf += "0,";
      work = "${ttllog.t100900.totalChgamt.abs()},";
      buf += work;
    }
    else {
      buf += "0,00,0,0,";
    }
    /* ポイント大分類2 ～ ポイント数2 */
    buf += "0,00,0,0,"; /* ポイント大分類3 ～ ポイント数3 */
    buf += "0,00,0,0,"; /* 未使用 */
    if (prepaidChargeChk(ttllog) == ALL_CHARGE) {
      buf += "0,0,"; /* ポイント対象売上金額符号 - ポイント対象売上金額 */
      buf += "0,0,"; /* 売上金額符号 - 売上額       */
      buf += "0,"; /* 売上対象外金額符号 */
      work = "${ttllog.t100900.todayChgamt.abs()},";
      buf += work; /* 売上対象外金額     */
    }
    else {
      buf += "0,"; /* ポイント対象売上金額符号 */
      /* ポイント対象売上金額 */
      if (ttllog.t100700Sts.magMbrSys == 1) {
        /* 買上追加 */
        work = "0,";
      } else {
        work = "${mem.tTtllog.calcData.stlIntaxInAmt.abs()},";
      }
      buf += work;
      buf += "0,"; /* 売上金額符号 */
      /* 売上額       */
      if (ttllog.t100700Sts.magMbrSys == 1) {
        /* 買上追加 */
        work = "0,";
      } else {
        work = "${mem.tTtllog.calcData.stlIntaxInAmt.abs()},";
      }
      buf += work;
      buf += "0,"; /* 売上対象外金額符号 */
      /* 売上対象外金額     */
      // memset(work, 0x00, sizeof(work));
      if (ttllog.t100700Sts.magMbrSys == 1) {
        /* 買上追加 */
        work = "0,";
      } else {
        work = "${ttllog.t100900.todayChgamt.abs()},";
      }
      buf += work;
    }
    buf += "0,"; /* 未使用 */
    buf += "0,"; /* 未使用 */
    buf += ","; /* 利用判定日 */
    buf += ","; /* 前ポイントデータ処理区分 */
    buf += ","; /* 前営業日 */
    buf += ","; /* 前データ発生年月日 */
    buf += ","; /* 前データ発生時刻 */
    buf += ","; /* 前発生元区分 */
    buf += ","; /* 前企業コード */
    buf += ","; /* 前企業支部コード */
    buf += ","; /* 前企業支部コード2 */
    buf += ","; /* 前企業店舗コード */
    buf += ","; /* 前企業端末コード */
    buf += ","; /* 前取引番号       */
    buf += ","; /* 未使用 */
    buf += ","; /* ポイント変動コメント */
    buf += ","; /* ポイント修正担当者ID */
    buf += ","; /* ポイント修正承認者ID */
    /* 拡張領域使用有無 */
    if (prepaidChargeChk(ttllog) != ALL_CHARGE) {
      buf += "1,";
    } else {
      buf += "0,";
    }
    buf += ","; /* 予備項目A1 */
    buf += ","; /* 予備項目A2 */
    buf += ","; /* 予備項目A3 */
    /* 予備項目B1 */
    if (prepaidChargeChk(ttllog) != ALL_CHARGE) {
      if (await rcNewARCSChkRARACrdtReceipt(ttllog)) {
        buf += "01,";
      } else if (await rcNewARCSChkQUICPayReceipt(ttllog)) {
        buf += "01,";
      } else if (await rcNewARCSChkiDReceipt(ttllog)) {
        buf += "01,";
      } else if (await rcNewARCSChkHouseCrdtReceipt(ttllog)) {
        buf += "02,";
      } else if (await rcNewARCSChkPrepaidReceipt(ttllog)) {
        buf += "03,";
      } else if (rcChkOffLineCrdtReceipt(ttllog) != -1) {
        buf += "01,";
      } else {
        buf += "04,";
      }
    } else {
      buf += ",";
    }
    buf += ","; /* 予備項目B2 */
    buf += ","; /* 予備項目B3 */
    buf += "END";

    senddata = buf;
    return senddata;
  }
}