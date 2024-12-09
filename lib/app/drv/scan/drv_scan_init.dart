/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ffi';
import 'dart:io';

import 'package:flutter_pos/app/if/if_drv_control.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/lib/drv_com.dart';

import './drv_scan_com.dart';
import '../ffi/ubuntu/ffi_scanner.dart';
import '../../fb/fb_lib.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/lib/rs232c.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/apllib/cmd_func.dart';
import '../../lib/apllib/recog.dart';

import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cls_conf/recogkey_dataJsonFile.dart';
import '../../common/cls_conf/scan_2800_1JsonFile.dart';
import '../../common/cls_conf/scan_2800_2JsonFile.dart';
import '../../common/cls_conf/scan_2800_3JsonFile.dart';
import '../../common/cls_conf/scan_2800_4JsonFile.dart';
import '../../common/cls_conf/scan_2800ip_1JsonFile.dart';
import '../../common/cls_conf/scan_2800ip_2JsonFile.dart';
import '../../common/cls_conf/scan_2800im_1JsonFile.dart';
import '../../common/cls_conf/scan_2800im_2JsonFile.dart';
import '../../common/cls_conf/scan_2800a3_1JsonFile.dart';
import '../../common/cls_conf/scan_2800i3_1JsonFile.dart';
import '../../common/cls_conf/scan_2800g3_1JsonFile.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';


/// 関連tprxソース:drv_scan_init_plus.c
///
class ScanInit {
  /// 定数
  static const WAITTIME = 300000;
  static const SCAN_28_1 = "scan_2800_1";
  static const SCAN_28_2 = "scan_2800_2";
  static const SCAN_28_3 = "scan_2800_3";
  static const SCAN_28_4 = "scan_2800_4";
  static const SCAN_28IP_1 = "scan_2800ip_1";
  static const SCAN_28IP_2 = "scan_2800ip_2";
  static const SCAN_28IM_1 = "scan_2800im_1";
  static const SCAN_28IM_2 = "scan_2800im_2";
  static const SCAN_28A3_1 = "scan_2800a3_1";
  static const SCAN_28I3_1 = "scan_2800i3_1";
  static const SCAN_28G3_1 = "scan_2800g3_1";
  static const SYS_INI = "conf/sys.ini";
  static const MACINFO_INI = "conf/mac_info.ini";
  static const keyFilePath = "/dev/ttyS9";

  /// 戻り値
  static const SCAN_OK_I = 0;
  static const SCAN_NG_I = -1;
  static const SCAN_OK_B = true;
  static const SCAN_NG_B = false;

  /// 変数
  TprDID myDid = 0;
  TprTID myTid = 0;
  int iDrvno = 0;
  int fds = 0;
  static String log = "";
  static int savePortNm = 0;
  static int usbPort = 0;
  static ScanCom scanCom = ScanCom();
  static TprLog myLog = TprLog();
  CmdFunc cmdFunc = CmdFunc();
  Recogkey_dataJsonFile recogkey_data = Recogkey_dataJsonFile();
  FFIScanner scanner = FFIScanner();

  FbMem fbMem = FbMem();
  JsonRet jret = JsonRet();
  late RxCommonBuf pCom;
  late Mac_infoJsonFile mac_info;
  late SysJsonFile sysIni;
  TprTimReq timeout = TprTimReq();


  /// 初期化
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - drv_scan_Init()
  Future <int> drvScanInit(TprTID tid) async {

    myTid = tid;
    iDrvno = (myTid >> bitShift_Tid) & 0x000000FF;

    savePortNm = SCAN_NG_I;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (SCAN_NG_I);
    }
    pCom = xRet.object;
    mac_info = pCom.iniMacInfo;
    sysIni   = pCom.iniSys;
    await recogkey_data.load();

    ScanCom.scan_info.myIni = "";
    if (await drvScanInifileGet(tid, ScanCom.scan_info, iDrvno) != SCAN_OK_I) {
      return (SCAN_NG_I);
    }
    if (await _portInit(tid) != SCAN_OK_I) {
      return (SCAN_NG_I);
    }
    if (await drvScanDidGet(tid) != SCAN_OK_I) {
      return (SCAN_NG_I);
    }
    if (await drvScanRescharGet(tid) != SCAN_OK_I) {
      return (SCAN_NG_I);
    }

    /* 新型スキャナ判別 */
    ScanCom.scan_info.scanner_type = await drvScanGetType(tid);
    ScanCom.scan_info.sysFailFlg = 0;
    ScanCom.scan_info.act = SCAN_ACT.SCAN_ENABLE;

    scanCom.drvScanInitVariable(tid);

    ScanCom.object_in = 0;
    ScanCom.object_out = 0;
    ScanCom.object_data_flg = 0;
    ScanCom.scan_exe = 0;

    switch (ScanCom.scan_info.myDid) {
      case TprDidDef.TPRDIDSCANNER1:
        ScanCom.scan_info.device = Rs232cDev.RS232C_SCAND;
        break;
      case TprDidDef.TPRDIDSCANNER2:
        ScanCom.scan_info.device = Rs232cDev.RS232C_SCANT;
        break;
      case TprDidDef.TPRDIDSCANNER3:
        ScanCom.scan_info.device = Rs232cDev.RS232C_SCANA;
        break;
      case TprDidDef.TPRDIDSCANNER4:
        ScanCom.scan_info.device = Rs232cDev.RS232C_SCANP;
        break;
      default:
        ScanCom.scan_info.device = Rs232cDev.RS232C_SCAND;
        break;
    }

    if (usbPort == 1) {
      fbMem.drv_stat[0] = PlusDrvStat.PLUS_STS_MNG_SET_OK;
    }

    return (savePortNm);
  }

  /// drv_scan_init_plis.c   static int port_init(TPRMID tid)
  ///
  /// ポート初期化
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - port_init()
  Future<int> _portInit(TprMID tid) async {
    int i = 0;

    // getPidを使ったブロックは必要なのか？
		for ( i = 0; i < 100; i++ ) {
			if ( fbMem.ftdi_sio_mediation == 0 ) {
        fbMem.ftdi_sio_mediation = cmdFunc.getPid();
        sleep(Duration(microseconds: 10000));   // usleep(10000);
        if ( fbMem.ftdi_sio_mediation != cmdFunc.getPid() ) {
					log = "ftdi_sio_mediation check error continue[${fbMem
            .ftdi_sio_mediation}]!=[${cmdFunc.getPid()}]\n";
					myLog.logAdd(tid, LogLevelDefine.error, log);
					continue;
				}
				break;
			}
      sleep(Duration(microseconds: 100000));  // usleep(100000);
		}
    if ( fbMem.ftdi_sio_mediation != cmdFunc.getPid() ) {
			log = "ftdi_sio_mediation check error!![${fbMem
        .ftdi_sio_mediation}]!=[${cmdFunc.getPid()}]\n";
			myLog.logAdd(tid, LogLevelDefine.error, log);
      return SCAN_NG_I;
		}
		myLog.logAdd(tid, LogLevelDefine.normal, "ftdi_sio_mediation check ok!!\n");

    if(await getScannerParameter(tid, ScanCom.scan_info.myIni) != SCAN_OK_I){
      return (SCAN_NG_I);
    }

    ScanCom.scan_info.serialRW = SCAN_NG_I;
    for (i = 0; i < 3; i++) {
      if (drvScanPortOpen(tid) == SCAN_OK_I) {
        break;
      }
      sleep(Duration(microseconds: WAITTIME));  // usleep( WAITTIME );
    }
    if (ScanCom.scan_info.serialRW < 0) {
      fbMem.ftdi_sio_mediation = 0;
      return (SCAN_NG_I);
    }

    if (drvScanPortInit()  != SCAN_OK_I) {
      fbMem.ftdi_sio_mediation = 0;
      return (SCAN_NG_I);
    }
    fbMem.ftdi_sio_mediation = 0;
    return (SCAN_OK_I);
  }

  /// スキャナーのパラメータ取得
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 引数:[iniFile] iniファイル名
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - なし
  ///
  /// 　⇒　既存コードの流れではJSONから値を取得することが難しいため整理した。
  Future<int> getScannerParameter(int tid, String iniFile) async{
    String sTmpBuf = "";
    String port_type = "";
    int port = -1;
    int baudRate = 0;
    int dataBit = 0;
    int startBit = 0;
    int stopBit = 0;
    String parity = "";
    int id = 0;

    switch(ScanCom.scan_info.myIni){
      case "conf/scan_2800_1.json":
        Scan_2800_1JsonFile scan_2800_1 = Scan_2800_1JsonFile();
        await scan_2800_1.load();
        sTmpBuf = scan_2800_1.settings.port;
        port_type = scan_2800_1.settings.port_type;
        baudRate = scan_2800_1.settings.baudrate;
        dataBit = scan_2800_1.settings.databit;
        startBit = scan_2800_1.settings.startbit;
        stopBit = scan_2800_1.settings.stopbit;
        parity = scan_2800_1.settings.parity;
        id = scan_2800_1.settings.id;
        break;
      case "conf/scan_2800_2.json":
        Scan_2800_2JsonFile scan_2800_2 = Scan_2800_2JsonFile();
        await scan_2800_2.load();
        sTmpBuf = scan_2800_2.settings.port;
        port_type = scan_2800_2.settings.port_type;
        baudRate = scan_2800_2.settings.baudrate;
        dataBit = scan_2800_2.settings.databit;
        startBit = scan_2800_2.settings.startbit;
        stopBit = scan_2800_2.settings.stopbit;
        parity = scan_2800_2.settings.parity;
        id = scan_2800_2.settings.id;
        break;
      case "conf/scan_2800_3.json":
        Scan_2800_3JsonFile scan_2800_3 = Scan_2800_3JsonFile();
        await scan_2800_3.load();
        sTmpBuf = scan_2800_3.settings.port;
        port_type = scan_2800_3.settings.port_type;
        baudRate = scan_2800_3.settings.baudrate;
        dataBit = scan_2800_3.settings.databit;
        startBit = scan_2800_3.settings.startbit;
        stopBit = scan_2800_3.settings.stopbit;
        parity = scan_2800_3.settings.parity;
        id = scan_2800_3.settings.id;
        break;
      case "conf/scan_2800_4.json":
        Scan_2800_4JsonFile scan_2800_4 = Scan_2800_4JsonFile();
        await scan_2800_4.load();
        sTmpBuf = scan_2800_4.settings.port;
        port_type = scan_2800_4.settings.port_type;
        baudRate = scan_2800_4.settings.baudrate;
        dataBit = scan_2800_4.settings.databit;
        startBit = scan_2800_4.settings.startbit;
        stopBit = scan_2800_4.settings.stopbit;
        parity = scan_2800_4.settings.parity;
        id = scan_2800_4.settings.id;
        break;
      case "conf/scan_2800ip_1.json":
        Scan_2800ip_1JsonFile scan_2800ip_1 = Scan_2800ip_1JsonFile();
        await scan_2800ip_1.load();
        sTmpBuf = scan_2800ip_1.settings.port;
        port_type = scan_2800ip_1.settings.port_type;
        baudRate = scan_2800ip_1.settings.baudrate;
        dataBit = scan_2800ip_1.settings.databit;
        startBit = scan_2800ip_1.settings.startbit;
        stopBit = scan_2800ip_1.settings.stopbit;
        parity = scan_2800ip_1.settings.parity;
        id = scan_2800ip_1.settings.id;
        break;
      case "conf/scan_2800ip_2.json":
        Scan_2800ip_2JsonFile scan_2800ip_2 = Scan_2800ip_2JsonFile();
        await scan_2800ip_2.load();
        sTmpBuf = scan_2800ip_2.settings.port;
        port_type = scan_2800ip_2.settings.port_type;
        baudRate = scan_2800ip_2.settings.baudrate;
        dataBit = scan_2800ip_2.settings.databit;
        startBit = scan_2800ip_2.settings.startbit;
        stopBit = scan_2800ip_2.settings.stopbit;
        parity = scan_2800ip_2.settings.parity;
        id = scan_2800ip_2.settings.id;
        break;
      case "conf/scan_2800im_1.json":
        Scan_2800im_1JsonFile scan_2800im_1 = Scan_2800im_1JsonFile();
        await scan_2800im_1.load();
        sTmpBuf = scan_2800im_1.settings.port;
        port_type = scan_2800im_1.settings.port_type;
        baudRate = scan_2800im_1.settings.baudrate;
        dataBit = scan_2800im_1.settings.databit;
        startBit = scan_2800im_1.settings.startbit;
        stopBit = scan_2800im_1.settings.stopbit;
        parity = scan_2800im_1.settings.parity;
        id = scan_2800im_1.settings.id;
        break;
      case "conf/scan_2800im_2.json":
        Scan_2800im_2JsonFile scan_2800im_2 = Scan_2800im_2JsonFile();
        await scan_2800im_2.load();
        sTmpBuf = scan_2800im_2.settings.port;
        port_type = scan_2800im_2.settings.port_type;
        baudRate = scan_2800im_2.settings.baudrate;
        dataBit = scan_2800im_2.settings.databit;
        startBit = scan_2800im_2.settings.startbit;
        stopBit = scan_2800im_2.settings.stopbit;
        parity = scan_2800im_2.settings.parity;
        id = scan_2800im_2.settings.id;
        break;
      case "conf/scan_2800a3_1.json":
        Scan_2800a3_1JsonFile scan_2800a3_1 = Scan_2800a3_1JsonFile();
        await scan_2800a3_1.load();
        sTmpBuf = scan_2800a3_1.settings.port;
        port_type = scan_2800a3_1.settings.port_type;
        baudRate = scan_2800a3_1.settings.baudrate;
        dataBit = scan_2800a3_1.settings.databit;
        startBit = scan_2800a3_1.settings.startbit;
        stopBit = scan_2800a3_1.settings.stopbit;
        parity = scan_2800a3_1.settings.parity;
        id = scan_2800a3_1.settings.id;
        break;
      case "conf/scan_2800i3_1.json":
        Scan_2800i3_1JsonFile scan_2800i3_1 = Scan_2800i3_1JsonFile();
        await scan_2800i3_1.load();
        sTmpBuf = scan_2800i3_1.settings.port;
        port_type = scan_2800i3_1.settings.port_type;
        baudRate = scan_2800i3_1.settings.baudrate;
        dataBit = scan_2800i3_1.settings.databit;
        startBit = scan_2800i3_1.settings.startbit;
        stopBit = scan_2800i3_1.settings.stopbit;
        parity = scan_2800i3_1.settings.parity;
        id = scan_2800i3_1.settings.id;
        break;
      case "conf/scan_2800g3_1.json":
        Scan_2800g3_1JsonFile scan_2800g3_1 = Scan_2800g3_1JsonFile();
        await scan_2800g3_1.load();
        if ((CmCksys.cmTRK05System() != 0) && (savePortNm == PlusDrvChk.PLUS_SCAN_D)) {
          sTmpBuf = scan_2800g3_1.settings.port2;
        } else {
          sTmpBuf = scan_2800g3_1.settings.port;
        }
        port_type = scan_2800g3_1.settings.port_type;
        baudRate = scan_2800g3_1.settings.baudrate;
        dataBit = scan_2800g3_1.settings.databit;
        startBit = scan_2800g3_1.settings.startbit;
        stopBit = scan_2800g3_1.settings.stopbit;
        parity = scan_2800g3_1.settings.parity;
        id = scan_2800g3_1.settings.id;
        break;
      default:
        myLog.logAdd(tid, LogLevelDefine.error, "unknown json file");
        return (SCAN_NG_I);
    }

    try {
      if (sTmpBuf.substring(0, 3) == "com") {
        port = int.parse(sTmpBuf.substring(3));
      }
    } catch(e) {
      myLog.logAdd(tid, LogLevelDefine.error, " port error");
      return (-1);
    }

    if (port_type == "usb") {
      usbPort = 1;
      sTmpBuf = DrvCom.TTYUSB + (port - 2).toString();
    } else if (port_type == "scan") {
      usbPort = 1;
      sTmpBuf = DrvCom.TTYSCAN + (port - 1).toString();
    } else if (port_type == "pass") {
      usbPort = 1;
      sTmpBuf = DrvCom.TTYPASS + (port - 1).toString();
    } else {
      usbPort = 1;
      sTmpBuf = DrvCom.TTYS + (port - 1).toString();
    }
    ScanCom.keyFilePath = sTmpBuf;

    if (baudRate == 0) {
    	myLog.logAdd(tid, LogLevelDefine.error, "[settings] baudrate get error");
  	  return (SCAN_NG_I);
    } else {
      ScanCom.baudRate = baudRate;
		}

    if (dataBit == 0) {
    	myLog.logAdd(tid, LogLevelDefine.error, "[settings] databit get error");
    	return (SCAN_NG_I);
    } else {
      ScanCom.dataBit = dataBit;
    }

    if (startBit == 0 ) {
    	myLog.logAdd(tid, LogLevelDefine.error, "[settings] startbit get error");
    	return (SCAN_NG_I);
    } else {
      ScanCom.startBit = startBit;
    }

    if (stopBit == 0 ) {
    	myLog.logAdd(tid, LogLevelDefine.error, "[settings] stopbit get error");
    	return (SCAN_NG_I);
    } else {
      ScanCom.stopBit = stopBit;
    }

    if ( parity == "") {
    	myLog.logAdd(tid, LogLevelDefine.error, "[settings] parity get error");
    	return (SCAN_NG_I);
    } else {
      switch (parity) {
				case "even":
          ScanCom.parity = 'E';     /* EVEN */
					break;
				case "odd":
          ScanCom.parity = 'O';     /* ODD */
					break;
				case "none":
          ScanCom.parity = '0';     /* NONE */
					break;
				default:
          myLog.logAdd(tid, LogLevelDefine.error, " unknown parity");
          return (SCAN_NG_I);
			}
		}
    if (id == 0 ) {
      myLog.logAdd(tid, LogLevelDefine.error, "[settings] id get error");
      return (SCAN_NG_I);
    } else {
      ScanCom.id = id;
    }

    return (SCAN_OK_I);
  }

  /// iniファイルを取得する
  ///
  /// drv_scan_init_plus.c　drv_scan_inifile_get()
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 引数:[info] スキャナ情報（myini（iniファイル名）にアクセス）
  ///
  /// 引数:[iDrvno] ドライブNo
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - drv_scan_reschar_get()
  Future<int> drvScanInifileGet(TprTID tid, ScanInfo info, int iDrvno) async{
    String sTmpBuf = "";
    String bootp = "";
    String sDevName = "drivers" + iDrvno.toString().padLeft(2, '0');
    int web_type = 0;
    int tower_type = 0;
    JsonRet ret = JsonRet();

		bootp = CmCksys.cmWebTypeGet(sysIni);

    ret = await sysIni.getValueWithName(bootp, sDevName);
    if (ret.result != true) {
			myLog.logAdd(tid, LogLevelDefine.error, " SYS.INI drivers get error");
      return (SCAN_NG_I);
		}
    sTmpBuf = ret.value;

		web_type = await CmCksys.cmWebType();
		ScanCom.scan_info.web28type_scan = CmCksys.cmWeb2800Type(sysIni);
		if ( web_type == CmSys.WEBTYPE_WEB2800 ) {
			if ( sTmpBuf == SCAN_28_1 ) {
				switch ( ScanCom.scan_info.web28type_scan ) {
					case CmSys.WEB28TYPE_IP:
						sTmpBuf = SCAN_28IP_1;
						break;
					case CmSys.WEB28TYPE_IM:
					case CmSys.WEB28TYPE_SPP:
						sTmpBuf = SCAN_28IM_1;
						break;
					case CmSys.WEB28TYPE_A3:
					case CmSys.WEB28TYPE_SP3:
						sTmpBuf = SCAN_28A3_1;
						break;
					case CmSys.WEB28TYPE_I3:
						int devcon = mac_info.system.device_connect;
						if (devcon == 0) {
							sTmpBuf = SCAN_28I3_1;
						} else {
							sTmpBuf = SCAN_28A3_1;
						}
						break;
					case CmSys.WEB28TYPE_G3:
						sTmpBuf = SCAN_28G3_1;
						break;
					case CmSys.WEB28TYPE_PR3:
						myLog.logAdd(tid, LogLevelDefine.error, "Prime3 Not use scan_2800_1");
						return (SCAN_NG_I);
					default:
						break;
				}
			}
			if ( sTmpBuf == SCAN_28_2 ) {
				switch ( ScanCom.scan_info.web28type_scan ) {
					case CmSys.WEB28TYPE_IP:
					case CmSys.WEB28TYPE_I3:
						sTmpBuf = SCAN_28IP_2;
						break;
					case CmSys.WEB28TYPE_IM:
					case CmSys.WEB28TYPE_SPP:
					case CmSys.WEB28TYPE_A3:
					case CmSys.WEB28TYPE_SP3:
						sTmpBuf = SCAN_28IM_2;
						break;
					default:
						break;
				}
			}
		}

    ret = await sysIni.getValueWithName(sTmpBuf, "inifile");
    if (ret.result != true) {
			myLog.logAdd(tid, LogLevelDefine.error, " SYS.INI inifile get error");
      return (SCAN_NG_I);
		}
    info.myIni = ret.value;

    ret = await sysIni.getValueWithName(sTmpBuf, "tower");
    if (ret.result != true) {
			myLog.logAdd(tid, LogLevelDefine.error, "SYS.INI tower get error");
			savePortNm = PlusDrvChk.PLUS_SCAN_D;
    } else {
      tower_type = ret.value;
      if (tower_type == 3) {
				savePortNm = PlusDrvChk.PLUS_SCAN_P;
      } else if (tower_type == 2) {
				savePortNm = PlusDrvChk.PLUS_SCAN_T;
      } else {
        if (info.myIni.contains("scan_plus_2")) {
					savePortNm = PlusDrvChk.PLUS_SCAN_T;
        } else {
					savePortNm = tower_type + PlusDrvChk.PLUS_SCAN_D;
				}
			}
		}
    return (SCAN_OK_I);
  }

  /// スキャナと再度接続する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - drv_scan_reopen()
  int drvScanReopen(TprTID tid) {
    String erlog = "";
    int flg = 0;

    if ((savePortNm != PlusDrvChk.PLUS_SCAN_D) &&
        (savePortNm != PlusDrvChk.PLUS_SCAN_T) &&
        (savePortNm != PlusDrvChk.PLUS_SCAN_P)) {
      erlog = "drvScanReopen SavePortNm Illegal[$savePortNm]\n";
      myLog.logAdd(tid, LogLevelDefine.error, erlog);
      return -1;
    }
    myLog.logAdd(tid, LogLevelDefine.normal, "drvScanReopen skip\n");

		if ( (fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_REOPEN) ||
				(fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_REOPEN2) ||
				(fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_CLOSE) ) {
			erlog = "drvScanReopen[$savePortNm][${fbMem.drv_stat[savePortNm]}]\n";
			myLog.logAdd(tid, LogLevelDefine.error, erlog);
			flg = 0;

				if ( ScanCom.scan_info.serialRW >= 0 ) {
        scanner.scannerPortClose(fds);
					ScanCom.scan_info.serialRW = -1;
				}
				if ( fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_CLOSE ) {
        fbMem.drv_stat[savePortNm] = PlusDrvStat.PLUS_STS_MSG_SET_CLOSE;
					return 0;
				}
      if (drvScanPortInit() == -1) {
					if ( fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_REOPEN2 ) {
          fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_MNG_REOPEN2_NG;
        } else {
          fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_MNG_REOPEN2_NG;;
					}
					myLog.logAdd(tid, LogLevelDefine.error, "drvScanReopen reopen error\n");
					return -1;
				}
				if ( (fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_REOPEN2) && (flg == 0) ) {
        sleep(const Duration(microseconds: WAITTIME));
					flg = 1;
				}

			myLog.logAdd(tid, LogLevelDefine.normal, "drvScanReopen ok\n");
			fbMem.drv_stat[savePortNm] = PlusDrvStat.PLUS_STS_MNG_SET_OK;
		}

    return 0;
  }

  /// スキャナとポート接続する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - drv_scan_port_open()
  int drvScanPortOpen(TprTID tid) {
    // MEMO:プロトタイプはport openのみ.
    myLog.logAdd(tid, LogLevelDefine.normal, "scanner init start");
    ScanRet ret = scanner.scannerPortOpen(ScanCom.keyFilePath);
    if (ret.result != SCAN_OK_I) {
      myLog.logAdd(tid, LogLevelDefine.error, " TTY open error");
      return (SCAN_NG_I);
    }
    fds = ret.fds;
    ScanCom.scan_info.serialRW = fds;
    myLog.logAdd(tid, LogLevelDefine.normal, "init end");

    return (SCAN_OK_I);
  }

  int drvScanPortInit() {
    if (scanner.scannerPortInit(fds,
        ScanCom.baudRate, ScanCom.dataBit, ScanCom.stopBit) != SCAN_OK_I) {
      return (SCAN_NG_I);
    }
    return (SCAN_OK_I);
  }

  /// スキャナーのレスポンスの種別を取得
  ///
  /// 引数:[tid] タスクID
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - drv_scan_reschar_get()
  Future<int> drvScanRescharGet(TprTID tid) async{
    int iTmpBuf = 0;

    switch (ScanCom.scan_info.myDid) {
      case TprDidDef.TPRDIDSCANNER1:
        iTmpBuf = sysIni.scanner.reschar;
        break;
      case TprDidDef.TPRDIDSCANNER2:
        iTmpBuf = sysIni.scanner.reschar_tower;
        break;
      case TprDidDef.TPRDIDSCANNER3:
        iTmpBuf = sysIni.scanner.reschar_add;
        break;
      default:
        iTmpBuf = sysIni.scanner.reschar;
        break;
    }

    ScanCom.scan_info.cr_send = 0;
    switch (iTmpBuf) {
      case 1:
        ScanCom.scan_info.res_char = SCAN_RESCHAR.SCAN_ACK_NAK;
        myLog.logAdd(tid, LogLevelDefine.normal, " res_char [ACK/NAK]");
        break;
      case 2:
        ScanCom.scan_info.res_char = SCAN_RESCHAR.SCAN_ACK_NAK_CR;
        ScanCom.scan_info.cr_send = 1;
        myLog.logAdd(tid, LogLevelDefine.normal, " res_char [ACK/NAK] send 'CR'");
        break;
      case 3:
        ScanCom.scan_info.res_char = SCAN_RESCHAR.SCAN_BEL;
        ScanCom.scan_info.cr_send = 2;
        myLog.logAdd(tid, LogLevelDefine.normal, " res_char [ACK/NAK] send 'BEL'");
        break;
      default:
        ScanCom.scan_info.res_char = SCAN_RESCHAR.SCAN_O_N;
        myLog.logAdd(tid, LogLevelDefine.normal, " res_char [O/N]");
        break;
    }

    return (SCAN_OK_I);
  }

  /// デバイスIDを取得する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - drv_scan_did_get()
  Future<int> drvScanDidGet(TprTID tid) async {
    int iTmpBuf = 0;

    switch (ScanCom.id) {
      case 1:
      case 3:
        ScanCom.scan_info.myDid = TprDidDef.TPRDIDSCANNER1;
        break;
      case 2:
        ScanCom.scan_info.myDid = TprDidDef.TPRDIDSCANNER2;
        break;
      case 33:
        ScanCom.scan_info.myDid = TprDidDef.TPRDIDSCANNER3;
        break;
      case 4:
        ScanCom.scan_info.myDid = TprDidDef.TPRDIDSCANNER4;
        break;
      default:
        myLog.logAdd(tid, LogLevelDefine.error, " [settings] id error");
        return (SCAN_NG_I);
    }

    /*** scan command ***/
    switch (ScanCom.scan_info.myDid) {
      case TprDidDef.TPRDIDSCANNER1:
        ScanCom.scn_cmd = mac_info.scanner.scn_cmd_desktop;
        break;
      case TprDidDef.TPRDIDSCANNER2:
        ScanCom.scn_cmd = mac_info.scanner.scn_cmd_tower;
        break;
      case TprDidDef.TPRDIDSCANNER3:
        ScanCom.scn_cmd = mac_info.scanner.scn_cmd_add;
        break;
      default:
        ScanCom.scn_cmd = mac_info.scanner.scn_cmd_desktop;
        break;
    }

    /*** scan display mode ***/
    ScanCom.scn_disp = mac_info.scanner.scan_display_mode;

    /*** swing flg ***/
    iTmpBuf = mac_info.select_self.psensor_scan_swing;
		if (iTmpBuf == 0) {
			myLog.logAdd(tid, LogLevelDefine.error, "psensor_scan_swing get error");
			ScanCom.swing_flg = 0;
		} else {
			ScanCom.swing_flg = iTmpBuf;
			log = "drvScanDidGet() swing_flg:${ScanCom.swing_flg}";
			myLog.logAdd(tid, LogLevelDefine.normal, log);
		}

    return (SCAN_OK_I);
  }

  /// デバイスタイプを取得する
  ///
  /// 引数:[tid] デバイスメッセージID
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - drv_scan_get_type()
  Future<int> drvScanGetType(TprMID tid) async {

    int  	  iTmpBuf = 0;
    String 	sTmpBuf = "";
    int			flag_1 = 0;
    int			flag_2 = 0;
    int			flag_3 = 0;
    int			flag_4 = 0;

    DbManipulationPs db = DbManipulationPs();
    await db.openDB();

    Result result;

    /* 値下バーコード１段目の設定確認 */
    String sql1 = "select instre_flg from c_instre_mst where format_typ=9;";
    try {
      result = await db.dbCon.execute(sql1);
      if (result.isNotEmpty) {
        final data = result.first.toColumnMap();
        flag_1 = int.tryParse(data["instre_flg"]) ?? 0;
      } else {
        flag_1 = 0;
      }
    } catch(e) {
      return (SCAN_NG_I);
    }

    /* 値下バーコード２段目の設定確認 */
    String sql2 = "select instre_flg from c_instre_mst where format_typ=10;";
    try {
      result = await db.dbCon.execute(sql2);
      if (result.isNotEmpty) {
        final data = result.first.toColumnMap();
        flag_2 = int.tryParse(data["instre_flg"]) ?? 0;
      } else {
        flag_2 = 0;
      }
    } catch(e) {
      return (SCAN_NG_I);
    }

    /* 値引バーコード仕様の設定確認 */
    RecogRetData rret = await Recog().recogGet(
        tid, RecogLists.RECOG_DISC_BARCODE,  RecogTypes.RECOG_GETMEM);
    if(rret.result == RecogValue.RECOG_YES){
      flag_3 = 1;
    }

    ScanCom.scan_info.beep_times = mac_info.scanner.beep_times;
    if (ScanCom.scan_info.beep_times == 0) {
      myLog.logAdd(tid, LogLevelDefine.error, " MAC_INFO.INI [scanner] scn_cmd get error");
      return (SCAN_NG_I);
    }

    ScanCom.scan_info.beep_interval = mac_info.scanner.beep_interval;
    if (ScanCom.scan_info.beep_interval == 0) {
      myLog.logAdd(tid, LogLevelDefine.error, " MAC_INFO.INI [scanner] scn_cmd get error");
      return (SCAN_NG_I);
    }

    /* サウンド変更の設定確認 */
    switch ( ScanCom.scan_info.myDid ) {
      case TprDidDef.TPRDIDSCANNER1:
        iTmpBuf = mac_info.scanner.scan_dp_snd_desktop;
        break;
      case TprDidDef.TPRDIDSCANNER2:
        iTmpBuf = mac_info.scanner.scan_dp_snd_tower;
        break;
      case TprDidDef.TPRDIDSCANNER3:
        iTmpBuf = mac_info.scanner.scan_dp_snd_add;
        break;
      default:
        iTmpBuf = mac_info.scanner.scan_dp_snd_desktop;
        break;
    }
    flag_4 = iTmpBuf;

    if ((flag_1 > 0) && (flag_2 > 0) && (flag_3 > 0) && (flag_4 > 0)) {
      // TODO:以下の処理はライブラリ層に追加必要
      // sTmpBuf = ScanCom.SCAN_GET_TYPE;
      // write(ScanCom.scan_info.serialRW, sTmpBuf, sTmpBuf.length);
      //   // usleep(100000);
      //
      // FD_ZERO(&readfds);
      // timeout.sec = 1;  // .tv_sec = 1;
      // timeout.msec = 0; // .tv_usec = 0;
      // n = ScanCom.scan_info.serialRW + 1;
      // FD_SET(ScanCom.scan_info.serialRW, &readfds);
      //
      // select(n, &readfds, (fd_set *)0, (fd_set *)0, &timeout);
      // if ( FD_ISSET(scan_info.SerialRW, &readfds) ) {
      // 	i = read(ScanCom.scan_info.serialRW, sTmpBuf, sTmpBuf.length);
      // 	if ( i == 3 ) {
      // 		if ( (sTmpBuf[0] == 0x30) && (sTmpBuf[1] == 0x31) ) {
      // 			myLog.logAdd(tid, LogLevelDefine.normal, " Detect New Type Scanner.   DiscountPair Enable.");
      // 			return ScanCom.SCAN_NEW_DP_TYPE;
      // 		}
      // 		else if( (sTmpBuf[0] == 0x30) && (sTmpBuf[1] == 0x30) ) {
      // 			myLog.logAdd(tid, LogLevelDefine.normal, " Detect New Type Scanner.   DiscountPair Disable.");
      // 			return ScanCom.SCAN_NEW_TYPE;
      // 		}
      // 	}
      // }
    }
    sTmpBuf = " Not carried out the discrimination of scanner type. [marking :$flag_1 $flag_2] [key:$flag_3] [sound:$flag_4]";
    myLog.logAdd(tid, LogLevelDefine.normal, sTmpBuf);
    return ScanCom.SCAN_OLD_TYPE;
  }
}
