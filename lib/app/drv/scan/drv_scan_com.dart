/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';

import './drv_scan_init.dart';
import '../ffi/ubuntu/ffi_scanner.dart';
import '../../if/if_drv_control.dart';
import '../../fb/fb_lib.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';

/// 関連ソース: termios.h
class Termios {
  static const NCCS = 19;
  int c_iflag = 0; /* input mode flags */
  int c_oflag = 0; /* output mode flags */
  int c_cflag = 0; /* control mode flags */
  int c_lflag = 0; /* local mode flags */
  int c_ispeed = 0;
  int c_ospeed = 0;
  List<String> c_line = List.generate(1, (_) => ""); /* line discipline */
  List<String> c_cc = List.generate(NCCS, (_) => ""); /* control characters */
}

/// 関連tprxソース: drv_scan_plus.h
///  Enum
enum SCAN_ACT {
  SCAN_ENABLE(0),
  SCAN_DISABLE(1);

  final int id;
  const SCAN_ACT(this.id);
}

enum SCAN_RESCHAR {
  SCAN_O_N(0),
  SCAN_ACK_NAK(1),
  SCAN_ACK_NAK_CR(2),
  SCAN_BEL(3);

  final int id;
  const SCAN_RESCHAR(this.id);
}

enum SCAN_STATE {
  SCAN_STATE_IDLE(0),
  SCAN_STATE_RCV_CR(1),
  SCAN_STATE_RCV_EX(2);

  final int id;
  const SCAN_STATE(this.id);
}

/// 関連tprxソース: drv_scan_plus.h
///  struct SCAN_INFO
class ScanInfo {
  int sysPipe = 0; /* Sys task's pipe fds (write)	*/
  int myPipe = 0; /* My pipe fds	 (read )	*/
  TprDID myDid = 0; /* My device id			*/
  int serialRW = 0; /* serial Read Write		*/
  int sysFailFlg = 0; /* system fail filg 1:ON/0:OFF	*/
  String myIni = ""; //char[TPRMAXPATHLEN]
  SCAN_STATE state = SCAN_STATE.SCAN_STATE_IDLE; /* enum SCAN_STATE		*/
  int timer = 0; /* ON / OFF			*/
  SCAN_ACT act = SCAN_ACT.SCAN_ENABLE;
  SCAN_RESCHAR res_char = SCAN_RESCHAR.SCAN_O_N;
  String pHomePath = ""; //uchar		*
  int cr_send = 0;
  int device = 0; /* 通信ログ書き込み先ファイル指定 */
  int web28type_scan = 0;
  int scanner_type = 0; /* 0:old    1:new		*/
  double scantime = 0; /* スキャンデータ読み込み中に取得する時間 */
  double keep_scantime = 0; /* スキャンを開始した時間 */
  int scan_slowtime = 0;		/* スキャン困惑検知 通知秒数(<= psensor_scan_slowtime) */
  double object_in_stime = 0;	/* 物体を検知開始した時間(object_in) */
  int beep_times = 0;		/* 特定バーコード読取時ビープ回数　1～4回 */
  int beep_interval = 0;		/* 特定バーコード読取時ビープ間隔　1～3(100ミリ秒) */
  late SendPort parentSendPort;

  static final ScanInfo _cache = ScanInfo._internal();
  factory ScanInfo() {
    return _cache;
  }
  ScanInfo._internal();
}

/// 関連tprxソース: drv_scan_com_plus.c
///
class ScanCom {
  /// Port
  static const SCAN_PORT_IOCTL = false;  /* port init use ioctl()	*/
  static const SCAN_PORT_INIT_MAX = 10;  /* 最大リトライ回数		*/
  static const SCAN_PORT_INIT_WAIT = 200000;  /* リトライ時の待ち時間(msec)	*/

  /// Timer
  static const SCAN_TIMERID = 1;  /* TIMER ID */
  static const SCAN_RCVBUF_SIZE_MAX = 512;  /* 50 -> 512 */
  static const SCAN_TIMER = 2000;
  static const SCAN_HW_TIMER = 2000;

  /// Code
  static const SCAN_UPCA_CODE = 'A';
  static const SCAN_UPCE_CODE = 'E';
  static const SCAN_EAN13_CODE = 'F';
  static const SCAN_EAN8_CODE = 'F';
  static const SCAN_STF_CODE = 'H';
  static const SCAN_CODE128_CODE = 'K';
  static const SCAN_NW7_CODE = 'N';
  static const SCAN_ITF_CODE = 'I';
  static const SCAN_GS1_1_CODE = 'R';
  static const SCAN_GS1_2_CODE = 'X';
  static const SCAN_CODE39_CODE = 'M';
  static const SCAN_QR_CODE = 'Q';
  static const SCAN_CODE_MIO = 'T';
  static const SCAN_EAN128_CODE = 'W';
  static const SCAN_HW_SINGLE_RES = 'P';  /* DISPLAYMODEのレスポンスも'P' */
  static const SCAN_HW_PRESEN_RES = 'T';
  static const SCAN_PASSPORT_CODE = 'P';
  static const SCAN_HW_MODE_RES_END = '!';      /* 0x21 */
  static const SCAN_DISPLAYMODE_RES_END = '.';  /* 0x2e */
  static const SCAN_UPCA_SIZE = 14;          /*    1 +   12 +  1 */
  static const SCAN_UPCE_SIZE = 9;           /*    1 +    7 +  1 */
  static const SCAN_EAN8_SIZE = 11;          /*    2 +    8 +  1 */
  static const SCAN_EAN13_SIZE = 15;         /*    1 +   13 +  1 */
  static const SCAN_EAN_ADDON_SIZE = 20;     /*    1 +   18 +  1 */
  static const SCAN_CODE39_SIZE19  = 21;     /*    1 +   19 +  1 */
  static const SCAN_CODE128_SIZE8  = 10;     /*    1 +    8 +  1 */
  static const SCAN_CODE128_SIZE12 = 14;     /*    1 +   12 +  1 */
  static const SCAN_CODE128_SIZE16 = 18;     /*    1 +   16 +  1 */
  static const SCAN_CODE128_SIZE17 = 19;     /*    1 +   17 +  1 */
  static const SCAN_CODE128_SIZE18 = 20;     /*    1 +   18 +  1 */
  static const SCAN_CODE128_SIZE19 = 21;     /*    1 +   19 +  1 */
  static const SCAN_CODE128_SIZE20 = 22;     /*    1 +   20 +  1 */
  static const SCAN_CODE128_SIZE21 = 23;     /*    1 +   21 +  1 */
  static const SCAN_CODE128_SIZE22 = 24;     /*    1 +   22 +  1 */
  static const SCAN_CODE128_SIZE23 = 25;     /*    1 +   23 +  1 */
  static const SCAN_CODE128_SIZE24 = 26;     /*    1 +   24 +  1 */
  static const SCAN_CODE128_SIZE26 = 28;     /*    1 +   26 +  1 */
  static const SCAN_CODE128_SIZE28 = 30;     /*    1 +   28 +  1 */
  static const SCAN_CODE128_SIZE30 = 32;     /*    1 +   30 +  1 */
  static const SCAN_CODE128_SIZE32 = 34;     /*    1 +   32 +  1 */
  static const SCAN_CODE128_MAXLEN = SCAN_CODE128_SIZE30;
  static const SCAN_CODE128_RESERV = SCAN_CODE128_SIZE22;
  static const SCAN_ITF_SIZE14 = 16;         /*    1 +   14 +  1 */
  static const SCAN_ITF_SIZE16 = 18;         /*    1 +   16 +  1 */
  static const SCAN_ITF_SIZE18 = 20;         /*    1 +   18 +  1 */
  static const SCAN_GS1_SIZE28 = 31;         /*    2 +   28 +  1 */
  static const SCAN_NW7_SIZE18 = 20;         /*    2 +   18 +  1 */
  static const SCAN_NW7_SIZE19 = 21;         /*    2 +   19 +  1 */
  static const SCAN_QR_SIZE = 25;            /*    1 +   23 +  1 */
  static const SCAN_PBCHG_SIZE = 46;         /*    1 +   44 +  1 */
  static const SCAN_PASSPORT_OCRB_SIZE = 89; /*    1 +   87 +  1 */

  static const SCAN_OFFSET_LABEL_ID     = 1;
  static const SCAN_OFFSET_LABEL_ID2    = 2;
  static const SCAN_OFFSET_DATA0        = 0;
  static const SCAN_OFFSET_DATA         = 2;
  static const SCAN_OFFSET_DATA2        = 3;
  static const SCAN_OFFSET_START_CODE   = 1;
  static const SCAN_OFFSET_NW7_MCD      = 5;
  static const SCAN_HEADER              = 1;
  static const SCAN_HEADER_CR           = 2;
  static const SCAN_HEADER_LABEL        = 2;
  static const SCAN_LABEL_CR            = 2;
  static const SCAN_LABEL_START_STOP_CR = 4;
  static const SCAN_HEADER_LABEL_START_STOP_CR = 5;
  static const SCAN_HEADER_LABEL_CR     = 3;
  static const SCAN_HEADER_LABEL_CD_CR  = 4;
  static const SCAN_UPCA_DATA_SIZE      = 12;
  static const SCAN_UPCE_DATA_SIZE      = 7;
  static const SCAN_EAN8_DATA_SIZE      = 8;
  static const SCAN_EAN13_DATA_SIZE     = 13;
  static const SCAN_EAN13_NOCD_DATA_SIZE = 12;
  static const SCAN_EAN_ADDON_DATA_SIZE = 18;
  static const SCAN_CODE39_DATA_SIZE8   = 8;
  static const SCAN_CODE39_DATA_SIZE19  = 19;
  static const SCAN_CODE39_DATA_SIZE23  = 23;
  static const SCAN_CODE128_DATA_SIZE8  =  8;
  static const SCAN_CODE128_DATA_SIZE12 = 12;
  static const SCAN_CODE128_DATA_SIZE16 = 16;
  static const SCAN_CODE128_DATA_SIZE17 = 17;
  static const SCAN_CODE128_DATA_SIZE18 = 18;
  static const SCAN_CODE128_DATA_SIZE19 = 19;
  static const SCAN_CODE128_DATA_SIZE20 = 20;
  static const SCAN_CODE128_DATA_SIZE21 = 21;
  static const SCAN_CODE128_DATA_SIZE22 = 22;
  static const SCAN_CODE128_DATA_SIZE23 = 23;
  static const SCAN_CODE128_DATA_SIZE24 = 24;
  static const SCAN_CODE128_DATA_SIZE26 = 26;
  static const SCAN_CODE128_DATA_SIZE28 = 28;
  static const SCAN_CODE128_DATA_SIZE30 = 30;
  static const SCAN_CODE128_DATA_SIZE32 = 32;
  static const SCAN_CODE128_INSTR_SIZE13 = 13;
  static const SCAN_CODE128_INSTR_SIZE25 = 25;
  static const SCAN_CODE128_DATA_SIZE_PBCHG = 44;
  static const SCAN_CODE128_DATAM_MAXLEN = SCAN_CODE128_DATA_SIZE30;
  static const SCAN_CODE128_DATAM_RESERV = SCAN_CODE128_DATA_SIZE22;
  static const SCAN_ITF6_DATA_SIZE  =  6;
  static const SCAN_ITF14_DATA_SIZE = 14;
  static const SCAN_ITF16_DATA_SIZE = 16;
  static const SCAN_ITF18_DATA_SIZE = 18;
  static const SCAN_GS1_DATA_SIZE28 = 28;
  static const SCAN_NW7_DATA_SIZE7  =  7;
  static const SCAN_NW7_DATA_SIZE8  =  8;
  static const SCAN_NW7_DATA_SIZE13 = 13;
  static const SCAN_NW7_DATA_SIZE15 = 15;
  static const SCAN_NW7_DATA_SIZE18 = 18;
  static const SCAN_NW7_DATA_SIZE19 = 19;
  static const SCAN_NW7_DATA_SIZE20 = 20;
  static const SCAN_NW7_DATA_SIZE21 = 21;
  static const SCAN_NW7_MCD_SIZE    =  8;
  static const SCAN_QR_DATA_SIZE    = 23;
  static const SCAN_PBCHG_DATA_SIZE = 44;
  static const SCAN_PASSPORT_OCRB_DATA_SIZE = 87;

  /// Result
  static const SCAN_OK_DAT = 'O';
  static const SCAN_NG_DAT = 'N';
  static const SCAN_OK_DP_DAT = 'B';

  /// Array Num
  static const SCAN_RETRYMAX = 3;
  static const SCAN_LOGWRITE = 1;

  /// Type
  static const SCAN_GET_TYPE = "\$c0634\r";
  static const SCAN_OLD_TYPE = 0;
  static const SCAN_NEW_TYPE = 1;
  static const SCAN_NEW_DP_TYPE = 2;

  /// QC Send Type
  static const SCAN_QC_NORMAL = 0;
  static const SCAN_QC_ENABLE = 1;
  static const SCAN_QC_DISABLE = 2;
  static const SCAN_QC_INFOCHK = 3;

  /// Passport
  static const PASSPORT_SCAN_IDLE = 0;  /* アイドル状態 */
  static const PASSPORT_SCAN_PROCESSING = 1;  /* 処理中状態   */
  /// 変数
  static String keyFilePath = ""; /* deviceFilePath */
  static int baudRate = 0; /* COM baud rate	*/
  static int dataBit = 0; /* COM data bits	*/
  static int startBit = 0; /* COM start bit	*/
  static int stopBit = 0; /* COM stop bit		*/
  static String parity = ""; /* COM parity		*/
  static int id = 0;
  static int scn_cmd = 0; /* scan command		*/
  static int scn_disp = 0; /* scan display mode	*/
  static int object_in = 0;
  static int object_out = 0;
  static int scan_exe = 0;
  static int object_data_flg = 0;
  static int swing_flg = 0;
  static TprLog myLog = TprLog();
  static ScanInfo scan_info = ScanInfo();

  TprMsg_t tprMsg = TprMsg();


  ///  デバドラで作成済み：これは削除する。
  ///  FFIScanner().scannerPortInit
  int drvScanPortInit(TprTID tid) {
    return (0);
  }

  /// SYSタスクへレスポンスを送信する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 引数:[result] 通信結果
  ///
  /// 引数:[data] レスポンスデータ	//uchar *
  ///
  /// 引数:[datalen] データ長
  ///
  /// 引数:[flg] tid = PSENSOR1 固定フラグ
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_com_plus.c - drv_scan_ResNotify()
  int drvScanResNotify(SendPort _parentSendPort, TprTID tid, int result, String data, int datalen) {
    return drvScanResNotifyFlg(_parentSendPort ,tid, result, data, datalen, false);
  }

  /// SYSタスクへレスポンスを送信する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 引数:[result] 通信結果
  ///
  /// 引数:[data] レスポンスデータ	//uchar *
  ///
  /// 引数:[datalen] データ長
  ///
  /// 引数:[flg] tid = PSENSOR1 固定フラグ
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_com_plus.c - drv_scan_ResNotify_flg()
  int drvScanResNotifyFlg(SendPort _parentSendPort, TprTID tid,
      int result, String data, int datalen, bool flg) {
    TprMsg_t Msg = TprMsg();
    FbMem fbMem = FbMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      myLog.logAdd(tid, LogLevelDefine.error, " drvScanResNotify rxMemRead error");
      return (-1);
    }
    RxCommonBuf pCom = xRet.object;

    if (fbMem.FBvnc != 0) {
      myLog.logAdd(tid, LogLevelDefine.normal, "ignore Scan data on FBvnc != 0");
      return (0);
    }

    if (datalen > Msg.devnotify.data.length) {
      drvScanResNotify(_parentSendPort, tid, TprDidDef.TPRDEVRESULTRERR, "", 0);
      drvScanInitVariable(tid);
      myLog.logAdd(tid, LogLevelDefine.error, " read size over error");
      return (-1);
    }

    Msg.devnotify.mid = TprMidDef.TPRMID_DEVNOTIFY;
    Msg.devnotify.length = TprIpcSize.tprMsgDevReq - TprIpcSize.tprCmn -
                                Msg.devnotify.data.length + datalen;
    if (scan_info.myDid == TprDidDef.TPRDIDSCANNER3) {
      if (data.codeUnitAt(0) != "\x86") {
        if (pCom.addScanFlg == 0) {
          Msg.devnotify.tid	= TprDidDef.TPRDIDSCANNER1;
        } else {
          Msg.devnotify.tid	= TprDidDef.TPRDIDSCANNER2;
        }
      } else {
        Msg.devnotify.tid = scan_info.myDid; /* device ID */
      }
    } else if (scan_info.myDid == TprDidDef.TPRDIDSCANNER4) {
      Msg.devnotify.tid = TprDidDef.TPRDIDSCANNER1;
    } else {
      Msg.devnotify.tid = scan_info.myDid; /* device ID */
    }
    if (flg) {
      Msg.devnotify.tid = TprDidDef.TPRDIDPSENSOR1;
    }
    Msg.devnotify.io = TprDidDef.TPRDEVIN; /* input or output */
    Msg.devnotify.result = result;
    Msg.devnotify.datalen = datalen; /* datalen & sequence No. */

    if (Msg.devnotify.datalen > 0) {
      Msg.devnotify.data = data.split("");
    }
    tprMsg.devnotify = Msg.devnotify;
    _parentSendPort
        .send(NotifyFromSIsolate(NotifyTypeFromSIsolate.scanData, tprMsg));
    myLog.logAdd(tid, LogLevelDefine.normal, "Scan End : Response to BackEnd");
    return (0);
  }

  /// スキャナへデータを送信する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 引数:[SendData] 送信データ		//char *
  ///
  /// 引数:[SendDataSize] データ長
  ///
  /// 引数:[time] タイマー値
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_com_plus.c - drv_scan_SerialWriteLog()
  int drvScanSerialWrite(SendPort _parentSendPort, TprTID tid,
      String SendData, int SendDataSize, int time) {

    if (drvScanPortCheck(tid) != 0) {
      drvScanInitVariable(tid);
      myLog.logAdd(tid, LogLevelDefine.error, "SCAN DRV OFFLINE");
      return (-1);
    }

    if (drvScanPortInit(tid) != 0) {
      drvScanResNotify(_parentSendPort, tid, TprDidDef.TPRDEVRESULTWERR, "", 0);
      drvScanInitVariable(tid);
      myLog.logAdd(tid, LogLevelDefine.error, " serial prot init error");
      return (-1);
    }

    ScanRet sret = FFIScanner().scannerDataSnd(scan_info.serialRW, ScanInit.keyFilePath, SendData,SendDataSize);
    if ( sret.result != 0 ) {
      if ( ScanInit().drvScanReopen(tid) == -1 ) {
        myLog.logAdd( tid, LogLevelDefine.error, "drvScanSerialWrite() drvScanReopen error" );
      }
      drvScanResNotify(_parentSendPort, tid, TprDidDef.TPRDEVRESULTWERR, "", 0);
      drvScanInitVariable(tid);
      myLog.logAdd( tid, LogLevelDefine.error, " serial write error" );
      return( -1 );
    } else {
      //cmRs232cLogWrite(scan_info.device, RS232C_SEND, SendData, SendDataSize);
    }

    return (0);
  }

  /// ポート（接続）チェック
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 戻り値：0 = ON Line
  ///
  ///       -1 = OFF Line
  ///
  /// 関連tprxソース: drv_scan_com_plus.c - drv_scan_PortCheck()
  int drvScanPortCheck(TprTID tid) {

    if ((scan_info.web28type_scan == CmSys.WEB28TYPE_A3) ||
        (scan_info.web28type_scan == CmSys.WEB28TYPE_SP3) ||
        (scan_info.web28type_scan == CmSys.WEB28TYPE_PR3)) {
      return (0);
    }

    if (scn_cmd == 0) {
      /* コマンド制御を行なわない（送信しない）ので制御線をチェックしない。 */
      return (0);
    }

    /* Start: Dart変換の際、コメント化：<sys/ioctl.h> ioctl(), <unistd.h> usleep() */ /*
		for ( i = 0; i < 20; i++ ) {
			/* check online */
			if ( ioctl(scan_info.SerialRW, TIOCMGET, &mcs) != -1 ) {
				dsr =  (mcs & TIOCM_DSR) != 0 ? 1 : 0;
				if ( dsr != 0 ) {
					return( 0 );	/* OK */
				}
			}
			else {
				log = " ioctl error[$errno]";
				myLog.logAdd( tid, LogLevelDefine.error, log );
			}
			usleep( 10000 );
		}
		 */ /* End: Dart変換の際、コメント化：<sys/ioctl.h> ioctl(), <unistd.h> usleep() */
    return (-1); /* POWER OFF or NOT READY */
  }

  /// グローバル変数初期化
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 戻り値：なし
  ///
  /// 関連tprxソース: drv_scan_com_plus.c - drv_scan_InitVariable()
  void drvScanInitVariable(TprTID tid) {
    scan_info.scantime = 0;
    scan_info.keep_scantime = 0;
    drvScanResetTimer(tid);
    scan_info.state = SCAN_STATE.SCAN_STATE_IDLE;
  }

  /// タイマー値を設定する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 引数:[time] デバイスメッセージID
  ///
  /// 戻り値：0 = ON Line
  ///
  ///       -1 = OFF Line
  ///
  /// 関連tprxソース: drv_scan_com_plus.c - drv_scan_SetTimer()
  int drvScanSetTimer(TprTID tid, int time) {
    /* Start: Dart変換の際、コメント化：TprLibTimer.c  TprTimReq() */ /*
		if ( TprTimReq(tid, time/1000, time % 1000, SCAN_TIMERID) != 0 ) {
			drvScanResNotify(tid, TprDidDef.TPRDEVRESULTTIMNOTSRT, "", 0);
			drvScanInitVariable(tid);
			myLog.logAdd( tid, LogLevelDefine.error, " timer set error" );

			return( -1 );
		}
		scan_info.timer = 1;		//ON
		 */ /* End: Dart変換の際、コメント化：TprLibTimer.c  TprTimReq() */

    return (0);
  }

  /// タイマー値を初期化する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 戻り値：なし
  ///
  /// 関連tprxソース: drv_scan_com_plus.c - drv_scan_ResetTimer()
  void drvScanResetTimer(TprTID tid) {
		if ( scan_info.timer == 1 ) {
//	TprTimReq(tid, 0, 0, SCAN_TIMERID);   /* timer stop */
		}
		scan_info.timer = 0;		//OFF
  }

  /// スキャナへ応答キャラクタを送信する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 引数:[result] 送信データタイプ
  ///
  /// 引数:[len] データ長
  ///
  /// 戻り値：0 = ON Line
  ///
  ///       -1 = OFF Line
  ///
  /// 関連tprxソース: drv_scan_com_plus.c - drv_scan_ResCharSendLog()
  int drvScanResCharSend(SendPort _parentSendPort, TprTID tid, bool result, int len) {
    String SendData = "";

    if (scan_info.res_char == SCAN_RESCHAR.SCAN_ACK_NAK ||
        scan_info.res_char == SCAN_RESCHAR.SCAN_ACK_NAK_CR) {
      if (result) {
        SendData = "0x06"; //ASCII Code:ACK
      } else {
        SendData = "0x15"; //ASCII Code:NAK
      }
    } else if (scan_info.res_char == SCAN_RESCHAR.SCAN_BEL) {
      if (result) {
        SendData = "0x07"; //ASCII Code:BEL
      } else {
        SendData = "0x00"; //ASCII Code:NUL
      }
    } else {
      if (result) {
        SendData = SCAN_OK_DAT;
      } else {
        SendData = SCAN_NG_DAT;
      }
    }

    if ((scan_info.scanner_type == SCAN_NEW_DP_TYPE) && (22 <= len)) {
      SendData = SCAN_OK_DP_DAT;
      sleep(Duration(microseconds: 100000));    // usleep(100000);
      drvScanSerialWrite(_parentSendPort, tid, SendData, SendData.length, 0);
      print("]] beep!!\n");
    }

    return (0);
  }
}
