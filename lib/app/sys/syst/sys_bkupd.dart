/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../../common/cls_conf/configJsonFile.dart';
import '../../common/environment.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/sys/tpr.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/rm_common.dart';
import 'sys_stdn.dart';
// 関連tprxソース:sysbkupd.c バックアップ関連処理.


/// 何をバックアップするかのモード.
enum SysBkupMode {
  none,
  cdVersionUp,
  backupData,
  hdVersionUp,
  versionUpEnd,
  ;

  static SysBkupMode getMode(int index) {
    if (index < 0 || versionUpEnd.index <= index) {
      return SysBkupMode.versionUpEnd;
    }
    return values[index];
  }
}

/// ファイルのバックアップモード.
enum FileBkupMode { backup, recovery, backupDelete }

/// 関連tprxソース:sysbkupd.c
class SysBkupd {
  /// バックアップするmodeが記載されている設定ファイル.
  /// sysdef.h
  static const SYS_BKUPD_INI = "conf/backupdata.ini";
  static const SYSBKUPD_BACKUP_PATH = "/tmp";

  /// バックアップデータをチェックする.
  /// backupdataの設定ファイルをチェックして、
  /// セットされているstartmodeに沿ってバックアップやっバージョンアップを行う.
  /// バージョンアップを行う場合はtrueを返す.
  ///  関連tprxソース:sysbkupd.c - sysBackupd_Play_Check()
  static Future<bool> sysBackupdPlayCheck() async {
    String path = "${EnvironmentData().sysHomeDir}/$SYS_BKUPD_INI";

    int startModeIndex = 0;
    JsonRet ret = await getJsonValue(path, "backupd", "start");
    if (!ret.result) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.warning,
          "sysBackupd_Play_Check: get start mode NG. ${ret.cause.name}");
      return false;
    }
    startModeIndex = ret.value as int;
    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.warning,
        "sysBackupd_Play_Check: get start mode OK");
    SysBkupMode startMode = SysBkupMode.getMode(startModeIndex);
    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.warning,
        "sysBackupd_Play_Check: start mode ${SysBkupMode.cdVersionUp.name}");
    bool lastRet = false; // 最後のバックアップ処理.
    // バックアップモードに対応するバックアップを実行.
    switch (startMode) {
      case SysBkupMode.none:
        return false;
      case SysBkupMode.cdVersionUp:
        sysBkupdBackup(FileBkupMode.backup);
        bool isSuccess = sysVupMain(path, 0);
        if (!isSuccess) {
          TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
              "sysBackupd_Play_Check: CD version up error");
          sysBkupdBackup(FileBkupMode.recovery);
          lastRet = true;
        }
        break;
      case SysBkupMode.backupData:
        bool isSuccess = sysBackupdPlay(path);
        if (!isSuccess) {
          TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
              "sysBackupd_Play_Check: backup data error");
          sysBkupdBackup(FileBkupMode.recovery);
          lastRet = true;
        }
        break;
      case SysBkupMode.hdVersionUp:
        //  HD version start
        bool isSuccess = sysVupMain(path, 1);
        if (!isSuccess) {
          TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
              "sysBackupd_Play_Check: HD version error");
          sysBkupdBackup(FileBkupMode.recovery);
        }
        lastRet = true;
        break;
      default:
        //error do nothing.
        // Set start mode
        lastRet = true;
        break;
    }
    int nextMode = SysBkupMode.none.index;
    if (lastRet) {
      //delete backup file
      sysBkupdBackup(FileBkupMode.backupDelete);
    } else {
      nextMode = nextMode++;
    }
    // set start mode.
    JsonRet setRet =
        await setJsonValue(path, "backupd", "start", nextMode.toString());
    if (setRet.result) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal,
          "sysBackupd_Play_Check: set next start mode OK");
    } else {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.warning,
          "sysBackupd_Play_Check: set start mode NG");
    }
    if (Tpr.APPEND_REGS) {
      RmCommon.rmMainExit();
    }
    if (CompileFlag.FB2GTK) {
      FbInit.fbDirectShutdown();
    }

    // バックアップやバージョンアップを行ったら再起動.
    // システム再起動.
    // シャットダウンをする一連の処理
    await SysStdn.finishAppAndShutdown(mode: ShutDownMode.reboot);
    // アプリ終了
    exit(1);
    return true;
  }

  /// apl and DB version up used rpm file
  /// 関連tprxソース:sysbkupd.c - sysVup_main()
  // TODO:10013 バージョンアップ 実装.要不要判断.
  static bool sysVupMain(String path, int flag) {
    return true;
  }

  /// backupdata execute
  /// 関連tprxソース:sysbkupd.c - sysBackupd_Play()
  // TODO:10013 バージョンアップ 実装.要不要判断.
  static bool sysBackupdPlay(String path) {
    return true;
  }

  /// file back up
  ///  関連tprxソース:sysbkupd.c - sysbkupd_backup()
  static bool sysBkupdBackup(FileBkupMode mode) {
    if (mode != FileBkupMode.recovery) {
      // バックアップファイルを削除.
      String filePath = sprintf("%s%s/apl_bak.tar.gz",
          [EnvironmentData().sysHomeDir, SYSBKUPD_BACKUP_PATH]);
      TprxPlatform.getFile(filePath).deleteSync();
      filePath = sprintf("%s%s/conf_bak.tar.gz",
          [EnvironmentData().sysHomeDir, SYSBKUPD_BACKUP_PATH]);
      TprxPlatform.getFile(filePath).deleteSync();
      filePath = sprintf("%s%s/data_bak.tar.gz",
          [EnvironmentData().sysHomeDir, SYSBKUPD_BACKUP_PATH]);
      TprxPlatform.getFile(filePath).deleteSync();
    }

    switch (mode) {
      case FileBkupMode.backup:
        return _sysBkupdBackup_backup();
      case FileBkupMode.recovery:
        return _sysBkupdBackup_recovery();
      case FileBkupMode.backupDelete:
        return _sysBkupdBackup_backupDelete();
    }
  }

  static bool _sysBkupdBackup_backup() {
    // TODO:10014 バックアップ sysbkupd_backup()の p_flg == 0
    return true;
  }

  static bool _sysBkupdBackup_recovery() {
    // TODO:10014 バックアップ :sysbkupd_backup()の p_flg == 1
    return true;
  }

  static bool _sysBkupdBackup_backupDelete() {
    // TODO:10014 バックアップ sysbkupd_backup()の p_flg == 2
    return true;
  }
}
