/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sprintf/sprintf.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../backend/mente/condition_monitoring.dart';
import '../../backend/update/actual_results.dart';
import '../../backend/history/hist_main.dart';
import '../../backend/history/hist_proc.dart';
import '../../backend/update/mupd_c.dart';
import '../../drv/printer/drv_print_isolate.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../lib/cm_sound/sound.dart';
import '../../lib/fl_rsh/crt_rsh.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/apllib_other.dart';
import '../../lib/apllib/apllib_std_add.dart';
import '../../lib/apllib/apllib_vup.dart';
import '../../lib/apllib/auto_update.dart';
import '../../lib/apllib/brainfile.dart';
import '../../lib/apllib/cmd_func.dart';
import '../../lib/apllib/qcjc_lib.dart';
import '../../lib/apllib/rm_db_read.dart';
import '../../lib/apllib/rm_ini_read.dart';
import '../../lib/apllib/rx_mkey_get.dart';
import '../../lib/apllib/rx_prt_flag_set.dart';
import '../../lib/apllib/upd_util.dart';
import '../../common/cls_conf/boot_testJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cls_conf/soundJsonFile.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../inc/lib/cm_sys.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/dual_cashier_util.dart';
import '../../common/environment.dart';
import '../../lib/apllib/rm_common.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../fb/fb_init.dart';
import '../../if/if_drv_control.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/sys/tpr.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_stat.dart';
import '../../lib/cm_sys/cm_getdfree.dart';
import '../../lib/fl_ftp/wftpLib.dart';
import '../../lib/if_vega3000/vega3000_com.dart';
import '../../regs/checker/rcky_qcselect.dart';
import '../../regs/checker/rcspeeza_com.dart';
import '../../regs/update/rul_main.dart';
import '../../regs/spool/rsmain.dart';
import '../../tprlib/tprlib_color.dart';
import '../../ui/enum/e_screen_kind.dart';
import '../../ui/socket/client/customer_socket_client.dart';
import '../../ui/socket/client/semiself_socket_client.dart';
import '../usetup/mst_read/spec_chg.dart';
import 'apl_main.dart';
import 'callbacks.dart';
import 'scpu_main.dart';
import 'sys_auto_update.dart';
import 'sys_ups.dart';
import 'sys_bkupd.dart';
import 'sys_data.dart';
import 'sys_init.dart';

/// 関連tprxソース:sysmain.c
class SysMain {
  static const POSTMASTER_FILE =
      "/usr/local/pgsql/data/postmaster.opts.default";
  static const _VUPDIR = "/pj/tprx/vup";
  static const ZINIT_FNAME_KOPTNUM = "/tmp/vup_z_koptnum.csv";
  static const ZINIT_FNAME_KOPTREC = "/tmp/vup_z_koptrec.csv";
  static const ZINIT_KOPTREC_ITEMMAX = 4; // アイテム数は4
  /// 関連tprxソース:sysext.h
  static const SYSCHK_GO = "/var/tmp/systemcheck.go";


  /// アプリ起動時のデータセットアップ　共通処理
  static Future<bool> startAppIniCommon() async {
    await EnvironmentData().tprLibGetEnv();
    if (EnvironmentData().sysHomeDir.isEmpty) {
      // homeディレクトリへのパス定義がない場合はアプリの強制終了.
      exit(0);
    }
    // アプリケーションフォルダの設定
    await setApplicationFolderPath();
    // ログIsolateの作成.
    await _startLogIsolate();

    return true;
  }

  /// アプリ起動時のデータセットアップ　客表
  static Future<bool> startAppIniCustomer() async {
    startAppIniCommon();
    // DBオープン
    var dbAccess = DbManipulationPs();
    await dbAccess.openDB();
    // Soundクラス（シングルトン）を初期化する
    await Sound().initialize();

    return true;
  }

  /// アプリ起動時のデータセットアップ　7inch客表
  static Future<bool> startAppIniCustomer_7() async {
    startAppIniCommon();
    // DBオープン
    var dbAccess = DbManipulationPs();
    await dbAccess.openDB();

    return true;
  }

  /// アプリ起動時のデータセットアップ　店員側画面
  /// 関連tprxソース:sysmain.c main()
  static Future<bool> startAppIniRegister() async {
    startAppIniCommon();

    if (Tpr.APPEND_REGS) {
      await RmCommon.rmMainInit();
    }

    // Power ON log 010524.
    TprLog().logAdd(0, LogLevelDefine.other1, "PowerON!!");
    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.other1, "PowerON!!");

    // 起動試験設定情報取得.
    Boot_testJsonFile bootJson = Boot_testJsonFile();
    await bootJson.load();
    int bootTest = bootJson.boot_test.boot_test;
    TprLog().logAdd(
        Tpraid.TPRAID_SYSINI, LogLevelDefine.normal, "boot_test : $bootTest");

    // 環境変数の状態をログ出力.
    await logWriteEnvironment();
    await UpdUtil.updDirCreate(TprMidDef.TPRMID_NOP);

    if (CompileFlag.FTP_CHANGE) {
      // netを削除する.
      WFtpLib.wftpNetrcFileDel(Tpraid.TPRAID_FTP, EnvironmentData().sysHomeDir);
    }
    // postmaster.opt.default check.
    await postmasterCheck(EnvironmentData().sysHomeDir, true);

    // Check netdoachgxxxxxx.cmd for IP changes.
    await SysInit.sysHQIPchgCheck(EnvironmentData().sysHomeDir);

    // Check backup data play
    await SysBkupd.sysBackupdPlayCheck();

    // キータイプ取得
    await _setKeyType();

    // DBオープン
    var dbAccess = DbManipulationPs();
    await dbAccess.openDB();
    // Soundクラス（シングルトン）を初期化する
    await Sound().initialize();

    if (Tpr.APPEND_REGS) {
      await RmCommon.rmMainInit_DB();
    }


    // 共有メモリの読み込み
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    AutoUpdate.auIniSystemCheck(Tpraid.TPRAID_SYSINI);
    if (CmCksys.cmAutoUpdateSystem() != 0) {
      //  module version up check
      SysInit.sysVupCheck(EnvironmentData().sysHomeDir, pCom.dbTrm.strclsVup);
    } else {
      if (pCom.dbTrm.vupfileGetFlg == 1 || pCom.dbTrm.vupfileGetFlg == 2) {
        AplLibVup.regVupFileGet(Tpraid.TPRAID_SYSINI, 0);
      }

      // module version up check
      SysInit.sysVupCheck(EnvironmentData().sysHomeDir, pCom.dbTrm.strclsVup);
    }
    SysInit.sysSelfVupCheck();
    SysInit.sysTPR1VupCheck();
    SysInit.sysTPR2VupCheck();
    SysInit.sysCHGVupCheck(0);
    SysInit.sysCHGVupCheck(1);
    SysAutoUpdate.sysAutoUpdate();

    //copy verup_hist.txt /tmp to /log
    if (TprxPlatform.getFile(
        EnvironmentData().sysHomeDir + AplLib.VERUP_HIST_FILE).existsSync()) {
      TprxPlatform.getFile(
          EnvironmentData().sysHomeDir + AplLib.VERUP_HIST_FILE)
          .copy(EnvironmentData().sysHomeDir + AplLib.VERUP_HIST_FILE_CP);
    }

    // ntp daemon startup
    sysNtpDaemonStart(EnvironmentData().sysHomeDir);

    // <OSK> icc api install
    sysIccVupCheck();

    sysVacuumCheck();

    // Check /pj/trpx/vup
    checkVupDir();
    // Table内容をファイル化する
    await createTempTableLists(0);

    CmCksys.cmChkVerticalFHDSystemMain(true); /* 縦型21.5インチ識別 兼 共有メモリへの書込み */

    CmCksys.cmChkVtclFHDFselfSystemMain(true); /* 縦型15.6インチ対面識別 兼 共有メモリへの書込み */

    // RM-5900の場合
    CmCksys.cmChkVerticalRm5900SystemMain(true);

    zDemoMode();

    // DiskOC for USB
    UpdUtil.updUSBDirCreate();

    QCJCLib.qcjcSystem(Tpraid.TPRAID_SYSINI);
    SpecChg.specChgMain(Tpraid.TPRAID_SYSINI);
    AplLibOther.aplLibPowerONMakeLog();

    // プロセス排他制御用のセマフォセット
    // TODO:10068 履歴ログセマフォ
    //pCom->renew_mem_semid = semget(IPC_PRIVATE, 1, (IPC_CREAT | 0666 | IPC_EXCL) );

    await _bootNow(false);
    //projects main initialize
    await SysInit().sysInitialize(EnvironmentData().sysHomeDir);
    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal,
        "sys:aplInitiallize ..... done");

    FbInit.optWindowTypeGet();
    if (Tpr.APPEND_REGS) {
      //await RmIniRead().rmIniReadMain();    // RmCommon.rmMainInit()で実行済み
      await RmDBRead().rmDbDialogRead();
    }
    // QCJC仕様の場合に、QCJC_Cのマシン番号をセットする
    if (CmCksys.cmQCashierJCSystem() != 0) {
      QCJCLib.qcjcCSetiniMacno(0);
    }
    await psensorIniRead();

    // TODO:10076 システムコマンドの実行

    // #if CENTOS_G3
    // system("/usr/bin/pulseaudio --daemonize=no  --realtime --log-target=journal &> /dev/null &");
    // sleep(1);
    // system("/usr/bin/amixer sset Master 100% &> /dev/null");
    // #endif
    //     L316/648line

    if (CompileFlag.FB2GTK) {
      // TODO:10077 コンパイルスイッチ(FB2GTKT)
      //dual設定など.
    }
    // acxreal タスク起動時に問い合わせを止める
    // TODO:10078 釣銭機のIsolateとの通信
    // if( (rxMem_ret = rxMemPtr(RXMEM_STAT, (void **)&pStat)) != RXMEM_OK)
    //   TprLibLogWrite(TPRAID_SYSINI, -1, -1, "TS_BUF get error\n");
    // else
    //   pStat->acx.acxreal_flg = 1;    /* acxreal 釣銭機への問合せ 0:続行 1:停止 */

    // TODO:10074 FlameBuffer 描画するかどうか?PrintScreenStart Flutterではいらないのでは.
    //   PrintScreenStart();

    await RxMkeyGet.sysDefKeyGet();
    _updateSSDStartDate();

    //  start apl module. aplExecMore()はFlutterではプロセスを分けていないのでなし.

    // Initialize UPS driver
    SysUps.sysUpsInit(EnvironmentData().sysHomeDir);
    //set initialize SCPU
    ScpuMain.scpuInitialize();
    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal,
        "sys:scpulInitiallize ..... done");

    //adjust priority はFlutterではプロセスを分けていないのでなし.

    //am/pm make dir
    AplMain.aplAPDirInit();
    //  etc directry
    await AplMain.aplDirInit();
    // Clear data
    _clearDataByReboot();
    int dfSize = CmGetDiskFree.cmGetDiskFree();
    int limitSize = CmGetDiskFree.cmGetDiskFreeLimit();
    if (limitSize <= dfSize) {
      // Set DiskFree Stat
      CmGetDiskFree.cmSetDiskFreeStat();
    }

    // ZHQ用初期化処理
    _zInitialize();

    // 後処理 (z_initializeの処理結果にかかわらず必ず実行)
    _zInitializeEnd();

    _sysWsInitialisation();
    //gtk main initialize
    // TODO:10074 FlameBuffer gtkはC言語のUI描画処理.Flutterでは不要or置き換え
    // gtk_set_locale ();
    // gtk_init (&argc, &argv);
    // gtk_rc_parse( tmp_buf );

    // add_pixmap_directory ( pixmap ); 画像フォルダの登録.Flutterではassetを使用しているので不要
    TprLibColor.tprLibColorInit();

    CreateRHost.createRhosts();

    await _bootNow(true);
    if (SysInit().needPwrOffOn) {
      // for Web2300/WebPrimePlus USB device NG
      // TODO:10073 web2300仕様
      // SysData().sysMenuStatus = TprStatDef.TPRTST_MENTE;
      // HistMain.tprtStat =
      //     CallBacks.sysNotifySendIsolate(TprStatDef.TPRTST_IDLE);
      // HistMain.tprtStat =
      //     CallBacks.sysNotifySendIsolate(TprStatDef.TPRTST_MENTE);
// //    sysPFMenuWait(2);    /* for slide switch */
//       sysPFMenuMain(3, 3);    /* for 10sec after shutdown */
//       input_tag = gdk_input_add( SysTib.sysPi, GDK_INPUT_READ,
//           (GdkInputFunction)sysMainGetEvent, "" );
    } else {
      if (CompileFlag.FB2GTK) {
        // TODO:10077 コンパイルスイッチ(FB2GTK)
      }
      //sysMainGetEventはIsolateの通信に置き換えらえる.
      // メインメニュースタート.
      SysData().sysMenuStatus = TprStatDef.TPRTST_START;
    }
    RxPrtFlagSet.recogReadFlagClear();
    await AplLibAuto.aplLibAutoSetAutoMode(0, 0);

    if (await CmCksys.cmCapsCafisSystem() != 0) {
      // TODO:10088 CAPS(CAFIS)接続仕様
    }
    if (await CmCksys.cmNttaspSystem() != 0) {
      // TODO:10089 NTTASP仕様
    }
    TprxPlatform.getFile(SYSCHK_GO).createSync(recursive: true);
    CmdFunc.df(
        outputPath: TprxPlatform.getPlatformPath(
            "${EnvironmentData().sysHomeDir}/log/df.txt"));

    BrainFile.brainFileDel(Tpraid.TPRAID_SYSINI);
    BrainFile.brainWakeup(Tpraid.TPRAID_SYSINI);

    // VEGA3000 初期化
    if (CompileFlag.CENTOS) {
      // TODO:10155 顧客呼出 - VEGA端末を有効にするため、固定値(gcat_cnct=19)をセット
      pCom.iniMacInfo.internal_flg.gcat_cnct = 19;
      if (CmCksys.cmCrdtVegaSystem() != 0) {
        TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal,
            "VEGA3000 Config Initialize");
        await IfVega3000Com().ifVega3000ConfigInitExec();
      }
    }

    // ドライバなどのIsolateの作成
    // 設定ファイルやDBなどの更新が一通り終わってから行う.
    await IfDrvControl().startSubIsolate();

    IfDrvControl drvCtl = IfDrvControl();
    String type = await drvCtl.getWebType();
    if( EnvironmentData().screenKind == ScreenKind.register ) {
      // 状態監視
      ConditionMonitoring().startIsolate();

      // ローカル実績上げIsolateの作成
      RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
      await _startRulMainIsolate(rootIsolateToken);
      final receivePortForRul = ReceivePort();
      RulMupdConsole().comPort!.send(receivePortForRul.sendPort);
      receivePortForRul.listen((notify) {
        RulMupdConsole().comPort = notify as SendPort;
        RulMupdConsole().sendNewestSaleDate();
      });

      // マスタ実績上げIsolateの作成
      await _startMupdCIsolate(rootIsolateToken);
      final receivePortForMupdC = ReceivePort();
      MupdCConsole().comPort!.send(receivePortForMupdC.sendPort);
      receivePortForMupdC.listen((notify) {
        if (notify is SendPort) {
          MupdCConsole().comPort = notify;
          MupdCConsole().sendNewestSaleDate();
        } else if (notify is bool) {
          MupdCConsole().onStatusCallback(notify);
        }
      });

      // 履歴ログIsolateの作成.
      /// MEMO:設定ファイル読み取り用
      String absolutePath = EnvironmentData.TPRX_HOME;
      await SysMain.startHistMainIsolate(
          rootIsolateToken, absolutePath, Tpraid.TPRAID_HIST);
      final receivePortForHist = ReceivePort();
      HistConsole().comPort!.send(receivePortForHist.sendPort);
      receivePortForHist.listen((notify) {
        HistConsole().comPort = notify as SendPort;
        HistConsole().sendSysNotify(TprStatDef.TPRTST_IDLE);
        HistConsole().sendSysNotify(TprStatDef.TPRTST_MENTE);
      });

      // 実績集計
      ActualResults().startIsolate();
    }

    // 二人制初期化
    RsMain.rsInit();

    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal,
        "startAppIniRegister(): End");

    return true;
  }

  /// 常駐isolateを停止する
  static void isolateStop() {
    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal, "isolateStop start");

    /// ドライバisolateを停止する。
    IfDrvControl().mkeyIsolateCtrl.sendStop();
    IfDrvControl().drwIsolateCtrl.sendStop();
    IfDrvControl().printIsolateCtrl.sendStop();
    IfDrvControl().sampleIsolateCtrl.sendStop();
    IfDrvControl().scanIsolateCtrl.sendStop();
    if (DualCashierUtil.isRegister2()) {
      IfDrvControl().scanIsolateCtrl2.sendStop();
    }
    IfDrvControl().multiTmnIsolateCtrl.sendStop();
    /// バックグラウンドの履歴ログ取得停止
    HistConsole().sendHistStop();
    // 実績集計
    ActualResults().sendStop();

    if (EnvironmentData().screenKind == ScreenKind.register2) {
      IfDrvControl().scanIsolateCtrl2.sendStop();
    }

    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal, "isolateStop end");
  }

  /// 常駐isolateを再開する
  static void isolateRestart() {
    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal, "isolateRestart start");

    /// ドライバisolateを再開する。
    IfDrvControl().mkeyIsolateCtrl.sendRestart();
    IfDrvControl().drwIsolateCtrl.sendRestart();
    IfDrvControl().printIsolateCtrl.sendRestart();
    IfDrvControl().sampleIsolateCtrl.sendRestart();
    IfDrvControl().scanIsolateCtrl.sendRestart();
    if (DualCashierUtil.isRegister2()) {
      IfDrvControl().scanIsolateCtrl2.sendRestart();
    }
    IfDrvControl().multiTmnIsolateCtrl.sendRestart();
    /// バックグラウンドの履歴ログ取得再開
    HistConsole().sendHistReStart();
    // 実績集計
    ActualResults().sendRestart();

    if (EnvironmentData().screenKind == ScreenKind.register2) {
      IfDrvControl().scanIsolateCtrl2.sendRestart();
    }

    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal, "isolateRestart end");
  }

  /// 常駐isolateを終了する
  static Future<void> isolateAbort() async {
    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal, "isolateAbort start");

    List<Future<void>> futureList = [];

    // 客側にシャットダウンのメッセージを送る
    futureList.add(CustomerSocketClient().sendShutdown());

    // 実績集計
    futureList.add(ActualResults().sendAbort());
    // 状態監視
    futureList.add(ConditionMonitoring().sendAbort());

    // 全てのisolateが終了するのを待つ
    await Future.wait(futureList);

    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal, "isolateAbort end");
  }

  /// 環境変数の設定状況をログに出力する.
  ///  関連tprxソース:sysmain.c - sysDebugEnv()
  static Future<void> logWriteEnvironment() async {
    List<String> checkParam = [
      "HOME",
      "PATH",
      "SHELL",
      "BASE_ENV",
      "LC_ALL",
      "LANG",
      "LINGUAS",
      "TPRX_HOME",
      "DISPLAY",
      "WINDOW"
    ];
    for (String param in checkParam) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal,
          "[$param=${EnvironmentData().env[param]}]");
    }
  }

  /// 関連tprxソース:sysmain.c - postmasterCheck()
  static Future<void> postmasterCheck(String dir, bool flag) async {
    if (CompileFlag.CENTOS) {
      return;
    }
    RandomAccessFile? rFile;
    String err = ""; // エラーがでた箇所のエラー文言.Exceptionが出たときに表示する.
    try {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error, "");
        return;
      }
      RxCommonBuf pCom = xRet.object;

      Mac_infoJsonFile macini = pCom.iniMacInfo;
      File postmaster = TprxPlatform.getFile(POSTMASTER_FILE);
      err =
      "postmasterCheck postmaster.opt.default open error"; // オープンできなかったときのエラー.
      rFile = postmaster.openSync(mode: FileMode.write); //ファイル新規作成.
      err =
      "postmasterCheck postmaster.opt.default write error"; // 書き込みできなかったときのエラー.
      // データを書き込み.
      if (macini.mm_system.mm_onoff == 0) {
        rFile.writeStringSync("-S -i -N 32 -B 64");
      } else {
        String context = "";
        int mmType = macini.mm_system.mm_type;
        // TODO:10017 マジックナンバー
        switch (mmType) {
          case 0:
          case 3:
            context = "-S -i -N 32 -B 64";
            break;
          case 1:
          case 2:
          default:
            context = flag ? "-S -i -N 64 -B 1024" : "-S -i -N 64 -B 256";
            break;
        }
        rFile.writeStringSync(context);
      }
    } catch (e, s) {
      TprLog()
          .logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error, "$err ,$e,$s");
      return;
    } finally {
      // 最後にファイルを閉じる.
      rFile?.close();
    }
  }

  /// ntpデーモンをスタートする.
  ///  関連tprxソース: sysmain.c - sysNtpDaemonStart()
  static void sysNtpDaemonStart(String path) {
    // TODO:10060 ntpデーモン
  }

  ///  関連tprxソース: sysmain.c - sysIccVupCheck()
  static void sysIccVupCheck() {
    // TODO:10061 iccバージョンアップ
  }

  ///  関連tprxソース: sysmain.c - sysVacuumCheck()
  static void sysVacuumCheck() {
    // TODO:10062 DBバキューム
  }

  ///  関連tprxソース: sysmain.c - CheckVupDir()
  static void checkVupDir() {
    try {
      Directory dir = TprxPlatform.getDirectory(_VUPDIR);
      if (!dir.existsSync()) {
        TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
            "Not found /pj/tprx/vup",
            errId: -1);
        // TODO:10008 ファイル/ディレクトリ権限操作
        // tprxソースでは0777で権限を付与している.
        dir.createSync(recursive: true);
      }
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "Can't mkdir /pj/tprx/vup $e $s",
          errId: -1);
    }
  }

  /// RAMディスクに各テーブルの構造を保存する
  /// この構造を元に履歴ログを取り込んだりする. この処理が失敗した場合, 履歴ログ処理は動作しない
  ///  関連tprxソース: sysmain.c - CreateTempTableLists()
  static Future<int> createTempTableLists(int tid) async {
    String erLog = '';
    String fName = '';
    String tmpBuf = '';
    String tmpBufSave = '';
    String sql = '';
    File? fp;
    int result = 0;
    int i = 0;
    int tuples = 0;
    String callFunc = 'createTempTableLists';
    Result res;
    int attNum = 0;
    String attName = '';
    String typName = '';
    int conType = 0;
    List<Future> futures = [];

    erLog = "$callFunc start\n";
    TprLog().logAdd(tid, LogLevelDefine.normal, erLog);

    DbManipulationPs db = DbManipulationPs();

    sql =
    "SELECT CLS.relname as relname, ATT.attnum as attnum, ATT.attname as attname, TYP.typname as typname, CASE CON.contype WHEN 'p' THEN 1 ELSE 0 END as contype "
        "FROM pg_class AS CLS "
        "INNER JOIN pg_namespace AS NSP "
        "ON CLS.relnamespace = NSP.oid "
        "AND CLS.relkind = 'r' "
        "AND NSP.nspname = 'public' "
        "INNER JOIN pg_attribute AS ATT "
        "ON CLS.oid = ATT.attrelid "
        "AND ATT.attnum > 0 "
        "INNER JOIN pg_type AS TYP "
        "ON ATT.atttypid = TYP.oid "
        "LEFT JOIN pg_constraint AS CON "
        "ON CLS.oid = CON.conrelid "
        "AND ATT.attnum = ANY(CON.conkey) "
        "AND CON.contype = 'p' "
        "ORDER BY CLS.relname, ATT.attnum;";

    try {
      res = await db.dbCon.execute(sql);

      if (res.isEmpty) {
        return -1;
      }

      tuples = res.length;

      erLog = "$callFunc table select tuple [$tuples]\n";
      TprLog().logAdd(tid, LogLevelDefine.normal, erLog);
    } catch (e) {
      // Cソース「db_PQexec() == NULL」時に相当
      erLog = "$callFunc table select error!!\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      return -1;
    }

    for (i = 0; i < tuples; i++) {
      Map<String, dynamic> data = res.elementAt(i).toColumnMap();
      tmpBuf = data["relname"] ?? "";
      attNum = data["attnum"] ?? 0;
      attName = data["attname"] ?? "";
      typName = data["typname"] ?? "";
      conType = data["contype"] ?? 0;

      if (tmpBufSave.isEmpty) {
        tmpBufSave = tmpBuf;
        fName = sprintf(HistMain.TEMP_TBL_FNAME, [tmpBufSave]);

        if (fp != null) {
          fp = null;
        }

        fp = TprxPlatform.getFile(fName);
        futures.add(fp.writeAsString(''));
        await Future.wait(futures);


      } else if (tmpBuf.compareTo(tmpBufSave) != 0) {
        tmpBufSave = tmpBuf;
        fName = sprintf(HistMain.TEMP_TBL_FNAME, [tmpBufSave]);

        if (fp != null) {
          fp = null;
        }

        fp = TprxPlatform.getFile(fName);
        futures.add(fp.writeAsString(''));
        await Future.wait(futures);

      }

      try {
        futures.add(fp!.writeAsString(
            "$attName,$typName,$conType,\n", mode: FileMode.append));
        await Future.wait(futures);
      } catch (e) {
        erLog = "$callFunc fopen($fName) error[$e]\n";
        result = -1;
        break;
      }
    }

    if (fp != null) {
      fp = null;
    }

    fp = TprxPlatform.getFile(HistMain.CREATE_CHK_FNAME);

    if (result == -1) {
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
    } else {
      try {
        RandomAccessFile raFile = fp.openSync(mode: FileMode.write);
        raFile.closeSync();
        fp = null;
      } catch (e) {
        erLog = "$callFunc : chk file create error \n";
        TprLog().logAdd(tid, LogLevelDefine.normal, erLog);
      }

      erLog = "$callFunc normal end\n";
      TprLog().logAdd(tid, LogLevelDefine.normal, erLog);
    }

    return result;
  }

  /// デモモード
  ///  関連tprxソース: sysmain.c - z_demo_mode()
  static bool zDemoMode() {
    // TODO:10064 デモモード

    return true;
  }

  /// [removeFlag]がfalseのとき、bootnowファイルを作成する
  ///  [removeFlag]がtrueのとき、bootnowファイルを削除する
  ///  関連tprxソース: sysmain.c - z_demo_mode()
  static Future<void> _bootNow(bool removeFlag) async {
    String filePath =
        "${EnvironmentData().sysHomeDir}/log/bootnow";
    File file = TprxPlatform.getFile(filePath);
    if (removeFlag) {
      if (file.existsSync()) {
        file.delete();
      }
    } else {
      if (!file.existsSync()) {
        file.create();
      }
    }
  }

  ///  関連tprxソース: sysmain.c - keytype_set()
  static Future<void> _setKeyType() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    SysJsonFile sysJson = pCom.iniSys;

    int webType = await CmCksys.cmWebType();
    int web28Type = CmCksys.cmWeb2800Type(sysJson);

    // Set MechaKeyType to COMMON
    switch (pCom.iniMacInfo.system.keytype_desk) {
    // Desktop
      case 0:
        pCom.mkeyD = _getKeyTypeMemDeyTypeDeskDefault(webType, web28Type);
        break;
      case 1:
        pCom.mkeyD = RxMemKey.KEYTYPE_84;
        break;
      case 2:
        pCom.mkeyD = RxMemKey.KEYTYPE_68;
        break;
      case 3:
        pCom.mkeyD = RxMemKey.KEYTYPE_56;
        break;
      case 4:
        pCom.mkeyD = RxMemKey.KEYTYPE_30;
        break;
      case 5:
        pCom.mkeyD = RxMemKey.KEYTYPE_52;
        break;
      case 6:
        pCom.mkeyD = RxMemKey.KEYTYPE_35;
        break;
      default:
        pCom.mkeyD = RxMemKey.KEYTYPE_84;
    }
    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.warning,
        "Desktop MechaKeyType:${pCom.mkeyD}");

    switch (pCom.iniMacInfo.system.keytype_tower) {
    //Tower
      case 0: // default
        pCom.mkeyT = _getKeyTypeMemDeyTypeTowerDefault(webType, web28Type);
        break;
      case 1:
        pCom.mkeyT = RxMemKey.KEYTYPE_84;
        break;
      case 2:
        pCom.mkeyT = RxMemKey.KEYTYPE_68;
        break;
      case 3:
        pCom.mkeyT = RxMemKey.KEYTYPE_56;
        break;
      case 4:
        pCom.mkeyT = RxMemKey.KEYTYPE_30;
        break;
      case 5:
        pCom.mkeyT = RxMemKey.KEYTYPE_52;
        break;

      default:
        pCom.mkeyT = RxMemKey.KEYTYPE_68;
    }
    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.warning,
        "Tower MechaKeyType:${pCom.mkeyT}");
  }

  /// pCom.iniMacInfo.system.keytype_deskが0だった時のキータイプを取得する.
  static int _getKeyTypeMemDeyTypeDeskDefault(int webType, int web28type) {
    switch (webType) {
      case CmSys.WEBTYPE_WEB2800:
        if (web28type == CmSys.WEB28TYPE_I ||
            web28type == CmSys.WEB28TYPE_IP ||
            web28type == CmSys.WEB28TYPE_I3) {
          return RxMemKey.KEYTYPE_68;
        }
        if (web28type == CmSys.WEB28TYPE_PR3) {
          return RxMemKey.KEYTYPE_30;
        }
        if (TprxPlatform.getFile(CmSys.TYPE52KEY_D).existsSync()) {
          return RxMemKey.KEYTYPE_52;
        }
        if (TprxPlatform.getFile(CmSys.TYPE35KEY_D).existsSync()) {
          return RxMemKey.KEYTYPE_35;
        }
        if (web28type == CmSys.WEB28TYPE_IM ||
            web28type == CmSys.WEB28TYPE_A3) {
          return RxMemKey.KEYTYPE_84;
        }
        return RxMemKey.KEYTYPE_84;
      case CmSys.WEBTYPE_WEB2200:
      case CmSys.WEBTYPE_WEB2300:
      case CmSys.WEBTYPE_WEB2350:
      case CmSys.WEBTYPE_WEB2500:
        return RxMemKey.KEYTYPE_56;
      case CmSys.WEBTYPE_WEBPRIME:
      case CmSys.WEBTYPE_WEBPLUS:
      case CmSys.WEBTYPE_WEBPLUS2:
        return RxMemKey.KEYTYPE_30;
      default:
        return RxMemKey.KEYTYPE_84;
    }
  }

  /// pCom.iniMacInfo.system.keytype_towerが0だった時のキータイプを取得する.
  static int _getKeyTypeMemDeyTypeTowerDefault(int webType, int web28type) {
    switch (webType) {
      case CmSys.WEBTYPE_WEB2800:
        if (TprxPlatform.getFile(CmSys.TYPE52KEY_T).existsSync()) {
          return RxMemKey.KEYTYPE_52;
        }
        return RxMemKey.KEYTYPE_68;
      case CmSys.WEBTYPE_WEB2200:
      case CmSys.WEBTYPE_WEB2300:
      case CmSys.WEBTYPE_WEB2350:
      case CmSys.WEBTYPE_WEB2500:
        return RxMemKey.KEYTYPE_30;
      case CmSys.WEBTYPE_WEBPRIME:
      case CmSys.WEBTYPE_WEBPLUS:
      case CmSys.WEBTYPE_WEBPLUS2:
        return RxMemKey.KEYTYPE_30;
      default:
        return RxMemKey.KEYTYPE_68;
    }
  }

  ///  関連tprxソース: sysmain.c - psensor_ini_read()
  static Future<void> psensorIniRead() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macJson = pCom.iniMacInfo;

    pCom.psensorNoticeFlg = macJson.select_self.psensor_notice;
    pCom.psensorSwingNoticeFlg = macJson.select_self.psensor_swing_notice;
    pCom.psensorSlowNoticeFlg = macJson.select_self.psensor_slow_notice;
    pCom.psensorAwayNoticeFlg = macJson.select_self.psensor_away_notice;
    pCom.psensorDisptime = macJson.select_self.psensor_disptime;

    pCom.psensorSwingCnt = macJson.select_self.psensor_swing_cnt;
    pCom.psensorScanSlowSound = macJson.select_self.psensor_scan_slow_sound;
    pCom.psensorAwaySound = macJson.select_self.psensor_away_sound;
  }

  ///  関連tprxソース: sysmain.c - Update_SSD_StartDate()
  static void _updateSSDStartDate() {
    // TODO:10079 SSD
  }

  /// 再起動によるデータの削除
  /// 関連tprxソース: sysmain.c - ClearDataByReboot()
  static void _clearDataByReboot() {
    // タブデータ, 管理ファイル, 仮締データを削除
    // TODO:10082 ディレクトリからファイル検索&操作
  }

// ZHQで動作する場合に必要な初期設定等を行う
  /// 関連tprxソース: sysmain.c - z_initialize()
  static Future<void> _zInitialize() async {
    if (await CmCksys.cmZHQSystem() == 0) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.warning,
          "syst z_initialize(). no ZHQ system.");
      return;
    }
    // TODO:10027 ZHQSystem
  }

  /// ZHQ用初期設定 後処理を行う
  /// 関連tprxソース: sysmain.c - z_initialize_end()
  static void _zInitializeEnd() {
    TprLog().logAdd(
        Tpraid.TPRAID_SYSINI, LogLevelDefine.warning, "ssyst zInitializeEnd()");
    // 一時ファイルの削除
    AplLibStdAdd.aplLibRemove(Tpraid.TPRAID_SYSINI,
        ZINIT_FNAME_KOPTNUM);
    AplLibStdAdd.aplLibRemove(Tpraid.TPRAID_SYSINI,
        ZINIT_FNAME_KOPTREC);
  }

  // 特定WS仕様初期設定 後処理を行う
  /// 関連tprxソース: sysmain.c - sys_ws_initialisation()
  static Future<void> _sysWsInitialisation() async {
    if (await CmCksys.cmWsSystem() == 0) {
      return;
    }
    // TODO:10084 特定WS仕様
  }

  /// ログのIsolateをスタートする.
  /// mainIsolateから呼び出す.
  static Future<void> _startLogIsolate() async {
    var receivePort = ReceivePort();
    String logDir = await TprLog().getOutputDirectory();
    await Isolate.spawn(
        TprLogIsolate().logOutputIsolate, [receivePort.sendPort, logDir]);
    TprLog().logPort = await receivePort.first as SendPort;
    TprLog().sendWaitListLog();
  }

  /// ローカル実績上げ処理のIsolateをスタートする.
  /// mainIsolateから呼び出す.
  static Future<void> _startRulMainIsolate(
      RootIsolateToken rootIsolateToken) async {
    var rcvPrt = ReceivePort();
    RulMupdConsole().stopRul();
    await Isolate.spawn(
        RulMainIsolate().rulMain, [rcvPrt.sendPort, rootIsolateToken, TprLog().logPort!, EnvironmentData().screenKind]);
    RulMupdConsole().comPort = await rcvPrt.first as SendPort;
  }

  /// マスタ実績上げ処理のIsolateをスタートする.
  /// mainIsolateから呼び出す.
  static Future<void> _startMupdCIsolate(
      RootIsolateToken rootIsolateToken) async {
    var rcvPrt = ReceivePort();
    await Isolate.spawn(
        MupdCIsolate().mupdCMain, [rcvPrt.sendPort, rootIsolateToken, TprLog().logPort!, EnvironmentData().screenKind]);
    MupdCConsole().comPort = await rcvPrt.first as SendPort;
  }

  static Future<void> setApplicationFolderPath() async {
    Directory dir = Directory(EnvironmentData.TPRX_HOME);
    AppPath().path = dir.path;
  }

  /// 履歴ログのIsolateをスタートする.
  static Future<void> startHistMainIsolate(
      RootIsolateToken rootIsolateToken, absolutePath, tid) async {
    var rcvPrt = ReceivePort();
    //DrvPrintIsolate.checkAndLoadReceiptLogo(absolutePath);
    await Isolate.spawn(HistMain.histMain, [
      DeviceIsolateInitData(
          rcvPrt.sendPort,
          TprLog().logPort!,
          tid,
          absolutePath,
          EnvironmentData(),
          SystemFunc.readRxCommonBuf(),
          SystemFunc.readRxTaskStat()),
      rcvPrt.sendPort,
      rootIsolateToken,
      tid
    ]);
    HistConsole().comPort = await rcvPrt.first as SendPort;
  }
}
