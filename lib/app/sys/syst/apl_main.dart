/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:io';


import '../../inc/lib/spqc.dart';
import '../../inc/sys/tpr_debug_mode.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/apllib_speedself.dart';
import '../../lib/apllib/cmd_func.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../inc/lib/cm_sys.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_getpath.dart';

///  関連tprxソース: aplmain.c
class AplMain {
  /// Counter Reset of Auto Reboot program in case of debug mode boot
  ///  関連tprxソース: aplmain.c - aplAP_DirInit
  static void aplAPDirInit() {
    List<String> checkDirList = [
      "/web21ftp/file_data/",
      "/web21ftp/file_data/ampm/",
      "/web21ftp/file_data/ampm/mst_read",
      "${EnvironmentData().sysHomeDir}/tmp/csv_tran_backup/",
      "/home/web2100/histcpy/", // 履歴ログ取得先変更時の、親レジの履歴ログ保存ディレクトリ
    ];
    try {
      for (var dir in checkDirList) {
        if (TprxPlatform.getDirectory(dir).existsSync()) {
          continue;
        }
        // ディレクトリがなかったら作る.
        TprxPlatform.getDirectory(dir).createSync(recursive: true);
        CmdFunc.chmod(dir, "777");
        TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal,
            "aplAP_DirInit: mkdir($dir)  & chmod");
      }

      if (CompileFlag.DRUG_REVISION) {
        // spec_bkup用のディレクトリ作成---------------------
        bool s_onoff = CmCksys.cmMmSystem() > 0 ? true: false;
        int s_type = CmCksys.cmMmType();
        if (!s_onoff ||
            (s_onoff && CmSys.MacS <= s_type && s_type <= CmSys.MacM1)) {
          String dir = "${EnvironmentData().sysHomeDir}/tmp/spec_bkup";
          String path = "$dir/work";
          if (!TprxPlatform.getDirectory(path).existsSync()) {
            // 無いディレクトリ以下を全て作成.
            TprxPlatform.getDirectory(path).createSync(recursive: true);
            CmdFunc.chmod(path, "777");
            TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal,
                "aplAP_DirInit: mkdir($dir/work)  & chmod");
          }
        }
      }
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "aplAP_DirInit: mkdir error $e,$s");
    }
  }

  ///  関連tprxソース: aplmain.c - apl_DirInit
  static Future<void> aplDirInit() async {
    String buf = "";

    List<List<String>> checkDirList = [
      // path                mkdir        chmod         chown
      ["/web21ftp/vup/",     "",           "/bin/chmod", "/bin/chown"], // バージョンアップファイル各のディレクトリの属性変更
      ["/home/web2100/cpy/", "/bin/mkdir", "/bin/chmod", ""          ], // センターサーバー接続時のcopyファイル格納先
      ["/web21ftp/Wiz/",     "/bin/mkdir", "/bin/chmod", ""          ], // Ｗｉｚマスタ管理のファイル格納先
      ["${EnvironmentData().sysHomeDir}/tran_backup/bkcomp_file/",
                             "/bin/mkdir", "/bin/chmod", ""          ], // 過去実績圧縮ファイル保持ディレクトリを作成
    ];

    try {
      for (var list in checkDirList) {
        String path = list[0];
        String com1 = list[1];
        String com2 = list[2];
        String com3 = list[3];
        String err  = "";
        Directory dir = Directory(TprxPlatform.getPlatformPath(path));
        if (!dir.existsSync()) {
          if (com1 != "") {
            try {
              dir.createSync(recursive: true);
            } catch (e) {
              err = e.toString();
            } finally {
              TprLog().logAdd(0, LogLevelDefine.error,
                  "apl_DirInit: ${com1}(${path}) ret[${err}]");
            }
          }
          if (dir.existsSync() && (Platform.isLinux)) {
            if (com2 != "") {
              try {
                err = "";
                await Process.run(com2, ['777', path]);
              } catch (e) {
                err = e.toString();
              } finally {
                TprLog().logAdd(0, LogLevelDefine.error,
                    "apl_DirInit: ${com2} (${path}) ret[${err}]");
              }
            }
            if (com3 != "") {
              try {
                err = "";
                await Process.run(com3, ['-R', "web2100", "${path}*"]);
              } catch (e) {
                err = e.toString();
              } finally {
                TprLog().logAdd(0, LogLevelDefine.error,
                    "apl_DirInit: ${com3} (${path}) ret[${err}]");
              }
            }
          }
        }
      }
    } catch (e, s) {
      TprLog().logAdd(0, LogLevelDefine.error,
          "aplDirInit: mkdir error $e,$s");
    }

    // SpeedSelfディレクトリ作成
    SpSelfDirProcParam dirParam = SpSelfDirProcParam();
    dirParam.Type = SPSELF_DIR_PROC_TYPE.SPSELF_PROC_MAKEDIR;
    await AplLibSpeedSelf.aplLibSpeedSelfDirProc(0, dirParam);

    // 特注用ディレクトリ作成
    if(await CmCksys.cmSanrikuSystem() == 1) {
      buf = CmGetpath.cmGetdirCustomMade();
      await aplMakeDir(0, buf);
    }
    if(await CmCksys.cmSanrikuSystem() == 1) {
      buf = CmGetpath.cmGetdirSanrikuSend();
      await aplMakeDir(0, buf);
    }

    // 15VerMS仕様の当日実績圧縮ファイル保存ディレクトリを作成
    buf = "/web21ftp/backup/";
    Directory dir2 = Directory(buf);
    if (!dir2.existsSync()) {
      if (CmCksys.cmMmType() != CmSys.MacERR) {
        int ret = await aplMakeDir(0, buf);
        if (ret == 0) {
          TprLog().logAdd(0, LogLevelDefine.error, "aplAP_DirInit: mkdir (${buf}) ret[${ret}]");
          TprLog().logAdd(0, LogLevelDefine.error, "aplAP_DirInit: chmod (${buf}) ret[${ret}]");
        }
      }
    }

    if (CompileFlag.DEBUG_MODE) {
      aplMakeDir(0, TprDebugModeDefine.DEBUG_SYSTEM_DIR);
    }
  }

  /// 実行権限付ディレクトリ作成
  ///  関連tprxソース: aplmain.c - aplMakeDir
  static Future<int> aplMakeDir(TprTID tid, String path) async {
    String cmd = "";
    String err = "";
    Directory dir = Directory(path);

    if (dir.existsSync()) {
      return 0;
    }
    try {
      if (path != "") {
        dir.createSync(recursive: true);
      }
    } catch (e) {
      err = e.toString();
      TprLog().logAdd(0, LogLevelDefine.error, "aplMakeDir: Error[createSync][${err}]\n");
      return -1;
    }
    if (Platform.isLinux) {
      try {
        cmd = "/bin/chmod";
        await Process.run(cmd, ['777', path]);
      } catch (e) {
        err = e.toString();
        TprLog().logAdd(0, LogLevelDefine.error, "aplMakeDir: Error[${cmd}][${err}]\n");
        return -1;
      }
    }
    return 0;
  }
}
