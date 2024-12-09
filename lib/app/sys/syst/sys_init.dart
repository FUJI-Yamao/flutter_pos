/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/cls_conf/sys_paramJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../common/environment.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_tib.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/cmd_func.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import 'sys_data.dart';
import 'sys_stdn.dart';

/// sysHQIPchgCheck()で返す値の定義.
/// tprxソースと数値が一致するように作成しているので空き番がある.
enum SysHQIPchgCheckRet {
  none, //0
  jsonError, //1 設定ファイルのエラー.
  macInfoShpnoError, //2
  err, // 3.未使用.
  cmdFileError, // 4
  cmdFileOpenError, //5
  err2, // 6.未使用.
  cmdDateSectionError, // 7
}

/// シングルトンクラス.
/// 関連tprxソース:sysinit.c
class SysInit {
  static const TYPE_2500_TOWER = 1;
  static const TYPE_2500_DESKTOP = 0;
  static const IPCHG_DIR = "hqftp/ip_chg";
  static const SPEC_NETW_HOSTS = "/etc/hosts";
  static const SPEC_NETW_HOSTS_NEW = "/tmp/hosts.dst";
  static const SPEC_NETW_HOSTS_SAVE = "/tmp/hosts.save";

  // ---TprLibData.c- ------------------------
  /// 関連tprxソース:TprLibData.c
  late TprTib sysTib = TprTib();
  int tprxErrorNo = 0;
  //-----
  // ---sysinit.c- ------------------------
  /// 関連tprxソース:sysinit.c
  TprTID tidMkeyDesktop1 = 0;
  TprTID tidPmouseDesktop1 = 0;
  TprTID tidMkeyTower2 = 0;
  TprTID tidPmouseTower2 = 0;
  TprTID tidPmouseAdd3 = 0;
  int needReboot = 0;
  bool needPwrOffOn = false;
  //  // TODO:00001 日向 ここじゃないかも
  int errorNo = 0;

  // シングルトン.
  static final SysInit _instance = SysInit._internal();
  factory SysInit() {
    return _instance;
  }
  SysInit._internal();

  /// systask initialize
  ///               call  sysCreatePipe()
  ///                     pipe open
  ///                     create drivers task
  ///                     receive drivers task initialize end
  /// 関連tprxソース: sysinit.c - sysInitialize()
  Future<int> sysInitialize(String path) async {
    TprLog().logAdd(
        Tpraid.TPRAID_SYSINI, LogLevelDefine.fCall, "sys:sysInitiallize .....");
    int retValue = 0;

    String typeBuf = ''; /* type buffer */
    int sysEnv = 0; //  system type(bit)
    //   0 : debug mode
    //   1 : desktop
    //   2 : tower
    //   3 : jr
    //   4 : jr tower
    //   5 : dual desktop
    //   6 : dual tower
    //   7 : WebPrimePLUS desktop
    //   8 : WebPrimePLUS tower
    //   9 : Web2300 desktop
    //  10 : Web2300 tower
    //  11 : Web2800 desktop
    //  12 : Web2800 tower
    //  13 : Web2500 desktop
    //  14 : Web2500 tower
    //  15 : Web2350 desktop
    //  16 : Web2350 tower

    int startDrv = 0;
    bool jnpFlg = false;
    bool isTowerFlg = false;
    bool isWeb28Type = false;
    int happySelfCheck = 0;

    // ▼各変数の初期化-----------------------------------
    // TODO　シングルトン化も
    TprTib tib = TprTib();
    tidMkeyDesktop1 = 0;
    tidPmouseDesktop1 = 0;
    tidMkeyTower2 = 0;
    tidPmouseTower2 = 0;
    tidPmouseAdd3 = 0;
    needReboot = 0;
    for (var data in sysTib.tct) {
      data.fds = '';
      data.tid = -1;
    }
    errorNo = 0;
    tprxErrorNo = 0;

    //signal function regist
    CmdFunc.signal();
    // debug mode
    CmdFunc.signal();
    // debug information
    CmdFunc.signal();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return -1;
    }
    RxCommonBuf pCom = xRet.object;
    SysJsonFile sysJson = pCom.iniSys;

    SysData().sysExeCount = 0;
    //  create all FIFO pipe
    if (!sysCreatePipe()) {
      return -1;
    }
    // open systask receive pipe
    // TODO:10019 パイプ通信
    // open timertask send pipe
    // TODO:10019 パイプ通信
    // timer task executing....
    // module path & module name edit
    // TODO:10070 タイマータスク
    // sprintf( exe, "%s/%s/%s", path, SYSAPL_DIR, SYSTIME_NAME );
    // sprintf( tid, "%08x", TPRTID_TIMER );
    //
    // SysTib.tct[0].tid = TPRTID_TIMER;
    // SysTib.tct[1].tid = 1 << 12;
    // SysTib.tct[2].tid = 2 << 12;
    // SysTib.tct[3].tid = 3 << 12;
    //
    // /* executing timer-task */
    // TprLibLogWrite( TPRAID_SYSINI, TPRLOG_OTHER1, 0,
    //     "sysCreateDriverTasks call:timer-task\n" );
    // /* create child process */
    // if(( SysTib.tct[0].pid = fork()) == 0 ){
    //   /* executing..... */
    //   ret = execl( exe, exe, tid, path, SYSTIME_NAME, 0 );
    //   exit( 0 );
    // }
    // sleep(1);
    ++SysData().sysExeCount;
    // TPRREADY or TPRNOREADY receive from timer-task driver
    retValue = sysAllDrvReadyWait(1);

    //--------------
    //  H/W check start
    //--------------
// TODO:10160 デバイスチェックによるタワー/デスクトップ判定処理
    if (CmCksys.cmWeb2300System() != 0 || CmCksys.cmWebplusSystem() != 0) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "Last sys.json web2300=${sysJson.type.web2300}");
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "             webplus=${sysJson.type.webplus}");
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "             tower=%${sysJson.type.tower}");
    }
    const String noJson = "no";
    const String yesJson = "yes";

    //  Unset
    sysJson.type.webplus2 = noJson;
    sysJson.type.web2350 = noJson;
    sysJson.type.web2500 = noJson;
    sysJson.type.web2800 = noJson;
    sysJson.type.web2300 = noJson;
    sysJson.type.webplus = noJson;
    sysJson.type.dual = noJson;
    sysJson.type.webjr = noJson;
    if (CmCksys.cmWebplus2System() != 0) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "SYS:This SubMHDD is WebPrimePlus2 (/etc/plus2_smhd.json)");
      // set plus2
      sysJson.type.webplus2 = yesJson;

      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "Last sys.json tower=%${sysJson.type.tower}");
      isTowerFlg = true;
      //  I must develop the sysInit_plus2_check()
      startDrv = 0; // desktop
      if (startDrv > 0) {
        sysEnv = 18; // tower
//         sysJson.type.tower = yesJson;
      } else {
        sysEnv = 17; // desktop
//         sysJson.type.tower = noJson;
      }
    } else if (CmCksys.cmWeb2500System() != 0) {
      sysJson.type.web2500 = yesJson;
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "SYS:This SubMHDD is Web2500 (/etc/2500_smhd.json)");

      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "Last sys.json tower=%${sysJson.type.tower}");
      isTowerFlg = true;
      //  I must develop the sysInit_plus2_check()
      startDrv = 0; // desktop
      if (startDrv > 0) {
        sysEnv = 14; // tower
//         sysJson.type.tower = yesJson;
      } else {
        sysEnv = 13; // desktop
//         sysJson.type.tower = noJson;
      }
    } else if (CmCksys.cmWeb2350System() != 0) {
      sysJson.type.web2350 = yesJson;
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "SYS:This SubMHDD is Web2350 (/etc/2350_smhd.json)");

      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "Last sys.json tower=%${sysJson.type.tower}");
      isTowerFlg = true;
      //  I must develop the sysInit_plus2_check()
      startDrv = 0; // desktop
      if (startDrv > 0) {
        sysEnv = 16; // tower
//         sysJson.type.tower = yesJson;
      } else {
        sysEnv = 15; // desktop
//         sysJson.type.tower = noJson;
      }
    } else if (CmCksys.cmWeb2800System() != 0) {
      sysJson.type.web2800 = yesJson;
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "SYS:This SubMHDD is Web2800 (/etc/2800_smhd.json)");
      if (CmCksys.cmWeb3800System() != 0) {
        TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
            "SYS:This Machine is Web3800 ");
      }
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "Last sys.json tower=%${sysJson.type.tower}");
      isTowerFlg = true;

      //  I must develop the sysInit_plus2_check()
      startDrv = 0; // desktop
      if (sysInit2500Check(isTowerFlg) == TYPE_2500_TOWER) {
        sysEnv = 12; // tower
//         sysJson.type.tower = yesJson;
      } else {
        sysEnv = 11; // desktop
//         sysJson.type.tower = noJson;
      }
    } else if (CmCksys.cmWeb2300System() != 0) {
//       sysJson.type.tower = yesJson;

      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "SYS:This SubMHDD is Web2300 (/etc/2300_smhd.json)");

      sysJson.type.web2300 = yesJson;
      sysJson.type.webplus = noJson;

      if (sysInit2300Check("") > 0) {
        startDrv = 1; // tower
      } else {
        startDrv = 0; // desktop
      }
      if (startDrv > 0) {
        sysEnv = 10; // tower
//         sysJson.type.tower = yesJson;
      } else {
        sysEnv = 9; // desktop
//         sysJson.type.tower = noJson;
      }
    } else if (CmCksys.cmWebplusSystem() != 0) {
//       sysJson.type.tower = noJson;

      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "SYS:This SubMHDD is WebPlus (/etc/plus_smhd.json)");
      sysJson.type.webplus = yesJson;
      sysJson.type.web2300 = noJson;

      startDrv = 0; // desktop
      if (startDrv > 0) {
        sysEnv = 8; // tower
//         sysJson.type.tower = yesJson;
      } else {
        sysEnv = 7; // desktop
//         sysJson.type.tower = noJson;
      }
    } else {
//       sysJson.type.tower = yesJson;
      if (!RecogValue.RECOG_OK0893.isSameValue(sysJson.type.webjr)) {
        sysJson.type.webjr = yesJson;
      }
    }

    happySelfCheck = 0;
    if (sysEnv == 11) {
      // WEBTYPE_WEB2800_DESKTOP*
      // 承認キーチェック：HappySelf仕様
      if (sysJson.type.happyself_system.compareTo("ok0893") == 0 ||
          sysJson.type.happyself_system.compareTo("yes") == 0) {
        happySelfCheck++;
      }

      if (happySelfCheck == 0) {
        // 承認キーチェック：HappySelf仕様[Smile用]
        if (sysJson.type.happyself_smile_system.compareTo("ok0893") == 0 ||
            sysJson.type.happyself_smile_system.compareTo("yes") == 0) {
          happySelfCheck++;
        }
      }

      if (happySelfCheck == 1) {
        Mac_infoJsonFile macIni = pCom.iniMacInfo;
        await macIni.load();

        // TODO:10159 フルセルフ 検定向け対応の為 コメントアウト
        // if (macIni.select_self.self_mode != 0) {
        //   // 通常レジとして起動させたい
        //   await macIni.setValueWithName("select_self", "self_mode", "0");
        // }
        //
        if (macIni.select_self.self_mac_mode != 1) {
          // セルフ専用レジにしておく
          macIni.select_self.self_mac_mode = 1;
        }
        //
        // if (macIni.select_self.qc_mode != 0) {
        //   // 通常レジとして起動させたい
        //   await macIni.setValueWithName("select_self", "qc_mode", "0");
        // }

        // TODO:00005 田中:QP/ID検定の為、暫定的にqc_modeを1する
        macIni.select_self.qc_mode = 1;

        // TODO:10159 フルセルフ 検定向け対応の為 kpi_hs_modeにhs_start_modeをセット
        // KPI用HappySelfモードを起動時には初期モードにしておく
        // await macIni.setValueWithName("select_self", "kpi_hs_mode", typeBuf);
        macIni.select_self.kpi_hs_mode = macIni.select_self.hs_start_mode;
        await macIni.save();

        TprLog().logAdd(
            Tpraid.TPRAID_SYSINI, LogLevelDefine.other1, "Happy Self Start\n");
      } else {
        // TODO:00005 田中:QP/ID検定の為、暫定的にqc_modeを0する
        Mac_infoJsonFile macIni = pCom.iniMacInfo;
        await macIni.load();
        macIni.select_self.qc_mode = 0;
        await macIni.save();
      }
    }

    return 0;
  }

  /// wait for all execiting drivers ready message
  /// [execnt]executing drivers count
  /// 関連tprxソース: sysinit.c - sysAllDrvReadyWait()
  static int sysAllDrvReadyWait(int execCnt) {
    // TODO:10071 ドライバの準備待機

    return 0;
  }

  /// Create all tasks pipe
  ///  make mknod
  /// 関連tprxソース: sysinit.c - sysCreatePipe()
  static bool sysCreatePipe() {
    // TODO:10019 パイプ通信

    return true;
  }

  // TODO:10015 netDoAシステム いつまでに実装が必要か要確認.一旦実装保留
  ///  netDoAシステムののIPアドレスに変更があるかどうかをチェックし、
  ///  有ればホストファイルや設定ファイルの内容を書き換えて起動する.
  ///
  /// 関連tprxソース: sysinit.c - sysHQIPchgCheck()
  static Future<SysHQIPchgCheckRet> sysHQIPchgCheck(String path) async {
    // 効率的に動作するように非同期で読み込む.使うときにawaitする.
    Sys_paramJsonFile sys = Sys_paramJsonFile();
    Future<void> futureSysIniLoad = sys.load();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    late Mac_infoJsonFile macini;
    if (xRet.isInvalid()) {
      macini = Mac_infoJsonFile();
      await macini.load();
    } else {
      RxCommonBuf pCom = xRet.object;
      macini = pCom.iniMacInfo;
    }

    int streCode = macini.system.shpno;
    String netdoaPath = sprintf("%s/%s/netdoachg%06d.cmd",
        [EnvironmentData().sysHomeDir, IPCHG_DIR, streCode]);
    String okFileName = sprintf("%s/%s/netdoachg%06d.ok",
        [EnvironmentData().sysHomeDir, IPCHG_DIR, streCode]);
    File netdoaFile = TprxPlatform.getFile(netdoaPath);
    FileStat stat = netdoaFile.statSync();
    if (stat.type == FileSystemEntityType.notFound) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.warning,
          "SYS:$netdoaPath not exist");
      return SysHQIPchgCheckRet.none;
    }
    if (stat.type == FileSystemEntityType.directory) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "SYS:netdoachgxxxxxx.cmd is directory");
      return SysHQIPchgCheckRet.cmdFileError;
    }
    if (stat.size == 0) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "SYS:netdoachgxxxxxx.cmd is directory");
      return SysHQIPchgCheckRet.cmdFileError;
    }
    String cmdDt = "";
    try {
      List<String> lines = netdoaFile.readAsLinesSync(); // １行ずつ取得.
      for (String line in lines) {
        if (line.isEmpty) {
          continue;
        }
        if ((line[9] == "/" || line[9] == "/") &&
            (line[12] == "-" || line[12] == "/")) {
          cmdDt = line.substring(5, 5 + 10); // ５番目から10個を取得.yyyy-mm-dd
        }
      }
    } on FileSystemException catch (e, s) {
      // オープンエラー.
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "SYS:netdoachgxxxxxx.cmd open error,$e,$s");
      return SysHQIPchgCheckRet.cmdFileOpenError;
    }
    if (cmdDt.isEmpty) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "SYS:netdoachgxxxxxx.cmd date section error");
      return SysHQIPchgCheckRet.cmdDateSectionError;
    }
    DateTime iVupDate = DateTime(int.parse(cmdDt.substring(0, 4)),
        int.parse(cmdDt.substring(5, 2)), int.parse(cmdDt.substring(8, 2)));
    DateTime nowDate = DateTime.now();
    if (iVupDate.isAfter(nowDate)) {
      // IPアドレスの変更日時ではない.
      DateFormat outputFormat = DateFormat(DateUtil.formatDate);
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "SYS:IP change date doesn't come yet. sysdate(${outputFormat.format(nowDate)}) chgdate(${outputFormat.format(iVupDate)})");
      return SysHQIPchgCheckRet.none;
    }

    JsonRet ret = await getJsonValue(netdoaPath, "ip", "ipaddress");
    if (!ret.result) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "SYS:sysHQIPchgCheck():get new_ip from netdoachgxxxxxx.cmd error ${ret.cause.name}");
      return SysHQIPchgCheckRet.jsonError;
    }
    String newIp = ret.value;

    ret = await getJsonValue(netdoaPath, "hq", "loginname");
    if (!ret.result) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "SYS:sysHQIPchgCheck():get loginname from netdoachgxxxxxx.cmd error ${ret.cause.name}");
      return SysHQIPchgCheckRet.jsonError;
    }
    String ftpName = ret.value;

    ret = await getJsonValue(netdoaPath, "hq", "password");
    if (!ret.result) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "SYS:sysHQIPchgCheck():get password from netdoachgxxxxxx.cmd error ${ret.cause.name}");
      return SysHQIPchgCheckRet.jsonError;
    }
    String ftpPass = ret.value;

    ret = await getJsonValue(netdoaPath, "hq", "remotepath");
    if (!ret.result) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "SYS:sysHQIPchgCheck():get remotepath from netdoachgxxxxxx.cmd error ${ret.cause.name}");
      return SysHQIPchgCheckRet.jsonError;
    }
    String ftpRPath = ret.value;

    await futureSysIniLoad; // 使用するので読み込むまで待機.　読み込めたらoK.
    // TODO:10016 1VerDB未使用DB設定 要チェック.
    // sys.db.hqdbname = hqdbname; // netDoA仕様時ASPのDB名 ; 1ver未使用
    // sys.db.hqdbuser = hqdbuser; // netDoA仕様時ASPのDBログインユーザー名 ; 1ver未使用
    // sys.db.hqdbpass = hqdbpass; // netDoA仕様時ASPのDBパスワード ; 1ver未使用
    sys.hq.loginname = ftpName; // FTPログインユーザー名
    sys.hq.password = ftpPass; // パスワード.
    sys.hq.loginname = ftpRPath; // レジ->上位へ送信時、put先ディレクトリ.
    sys.save();

    // ホストファイルに新しいIPアドレスをセット.
    bool isSuccess = netdoaIpSet(newIp);
    if (!isSuccess) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "SYS:netdoa_ip_set(): error");
      return SysHQIPchgCheckRet.jsonError;
    }
    TprxPlatform.getFile(netdoaPath).renameSync(okFileName);
    TprLog().logAdd(
        Tpraid.TPRAID_SYSINI, LogLevelDefine.warning, "SYST:IP change OK");

    FbInit.fbDirectShutdown();

    // シャットダウンをする一連の処理
    await SysStdn.finishAppAndShutdown(mode: ShutDownMode.reboot);
    // アプリ終了
    exit(0);
  }

  /// hostsファイルにhqserverのIPアドレスとホスト名を書き込む.
  /// 関連tprxソース: sysinit.c - sysHostsCheck()
  static bool netdoaIpSet(String newIp) {
    late List<String> lines;
    try {
      lines = TprxPlatform.getFile(SPEC_NETW_HOSTS).readAsLinesSync();
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "netdoa_ip_set():file($SPEC_NETW_HOSTS) open error !!,$e,$s");
    }
    RandomAccessFile distFile =
    TprxPlatform.getFile(SPEC_NETW_HOSTS_NEW).openSync(mode: FileMode.write);
    for (String line in lines) {
      List<String> data =
          line.split(' '); // sscanf(src_buff, "%s %s %s", ipadr, name, name2);
      if (data.length < 2) {
        continue;
      }
      String ipadr = line[0];
      String name = line[1];

      String name2 = data.length < 3 ? "" : line[2];

      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          sprintf("netdoa_ip_set():ipadr=(%s) name=(%s) name2=(%s)", data));
      String dstBuff = "";
      if (name == "hqserver" && ipadr[0] != "#") {
        // TODO:00001 日向 改行コードがOSごとに違うかも.
        if (name2.isNotEmpty) {
          dstBuff = sprintf("%s	%s	%s\n", [newIp, "hqserver", name2]);
        } else {
          dstBuff = sprintf("%s	%s\n", [newIp, "hqserver"]);
        }
        try {
          distFile.writeStringSync(dstBuff);
        } catch (e, s) {
          distFile.closeSync();
          TprxPlatform.getFile(SPEC_NETW_HOSTS_NEW).delete();
          TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
              "netdoa_ip_set():file($SPEC_NETW_HOSTS_NEW) write error !!,$e,$s");
          return false;
        }
      }
    }
    distFile.closeSync();
    // TODO:10015 netDoAシステム パスがlinux用.
    TprxPlatform.getFile(SPEC_NETW_HOSTS).renameSync(SPEC_NETW_HOSTS_SAVE);
    TprxPlatform.getFile(SPEC_NETW_HOSTS_NEW).renameSync(SPEC_NETW_HOSTS);
    TprxPlatform.getFile(SPEC_NETW_HOSTS_SAVE).delete();

    return true;
  }

  ///  関連tprxソース:sysinit.c - sysVupCheck()
  // TODO:10013 バージョンアップ. 実装.
  static bool sysVupCheck(String path, int strclsVup) {
    return true;
  }

  /// self data verup check
  ///  関連tprxソース:sysinit.c - sysSelfVupCheck()
  // TODO:10013 バージョンアップ. 実装.
  static bool sysSelfVupCheck() {
    return true;
  }

  /// printer1 f/w verup check
  ///  関連tprxソース:sysinit.c - sysTPR1_VupCheck()
  // TODO:10013 バージョンアップ. 実装.
  static bool sysTPR1VupCheck() {
    return true;
  }

  /// printer2 f/w verup check
  ///  関連tprxソース:sysinit.c - sysTPR2_VupCheck()
  // TODO:10013 バージョンアップ. 実装.
  static bool sysTPR2VupCheck() {
    return true;
  }

  /// Chager Ctrl+Coin f/w verup check
  ///  関連tprxソース:sysinit.c - sysCHG_VupCheck()
  // TODO:10013 バージョンアップ. 実装.
  static bool sysCHGVupCheck(int devKind) {
    return true;
  }

  ///  Web2500 start process
  ///  0=Web2500 Desktop type,
  //         1=Web2500 Tower type,
  ///  関連tprxソース:sysinit.c - sysInit_2500_check()
  static int sysInit2500Check(bool towerFlg) {
    int ret = sysInit2500DeviceCheck();
    if (ret == TYPE_2500_DESKTOP && !towerFlg) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "Current DESKTOP : Last DESKTOP -> DESKTOP");
      return TYPE_2500_DESKTOP;
    }
    if (ret == TYPE_2500_TOWER && towerFlg) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "CCurrent TOWER : Last TOWER -> TOWER");
      return TYPE_2500_TOWER;
    }
    if (ret == TYPE_2500_TOWER && !towerFlg) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "Current TOWER : Last DESKTOP -> TOWER");
      return TYPE_2500_TOWER;
    }
    if (ret == TYPE_2500_DESKTOP && !towerFlg) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1,
          "Current DESKTOP : Last TOWER -> DESKTOP");
      return TYPE_2500_DESKTOP;
    }
    return TYPE_2500_DESKTOP;
  }

  ///   Web2500 start process
  ///   return  0: TYPE_2500_DESKTOP Not Exist Tower Device File
  //     1: TYPE_2500_TOWER Exist Tower Device File
  ///  関連tprxソース:sysinit.c - sysInit_2500_device_check()
  static int sysInit2500DeviceCheck() {
    List<String> checkFileNameList = [
      "/dev/web2800/tpanelusbdd1",
      "/dev/web2800/usbmkey1",
      "/dev/ttyFIP1",
      "/dev/ttySCAN1"
    ];
    bool isAllExist = true;
    for (var path in checkFileNameList) {
      bool isExist = TprxPlatform.getFile(path).existsSync();
      isAllExist &= isExist;
      String log = isExist ? "exist" : "not exist";
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal,
          "sysInit2500DeviceCheck() path $log");
    }
    if (isAllExist) {
      return TYPE_2500_TOWER;
    }
    return TYPE_2500_DESKTOP;
  }

  ///  Web2300 start process
  ///  関連tprxソース:sysinit.c - sysInit_2300_check()
  static int sysInit2300Check(String path) {
    // TODO:10073 web2300

    return 0;
  }
}
