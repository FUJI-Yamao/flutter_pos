import 'dart:io';
import 'package:path/path.dart';

import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/environment.dart';
import '../../inc/sys/tpr_log.dart';

///  関連tprxソース:mobile_lib.c
class MobileLib {
  static String sysHomeDirp = EnvironmentData().sysHomeDir;

  static String RXRCT_DIRECTORY = "/tmp/regs/";
  static String RXMBLTMP_DIR = "/tmp/mobile/";

  ///**********************************************************************
  ///  仮締ファイルをクリアする
  ///**********************************************************************
  ///  関連tprxソース:mobile_lib.c - rcMblSus_Delete
  static Future<int> rcMblSusDelete(String? xsDate) async {
    if (xsDate != null && xsDate.isNotEmpty) {
      // Convert x_sDate to YYYYMMDD format and store it in w_sDate
      var wsDate = xsDate.substring(0, 4) +
          xsDate.substring(5, 7) +
          xsDate.substring(8, 10);

      /* 当日のファイルを残す場合は一旦移動する */
      // copy sysHomeDirp/tmp/regs/MOBILEYYYYMMDD* to sysHomeDirp/tmp/
      // delete sysHomeDirp/tmp/regs/MOBILEYYYYMMDD*
      var from = TprxPlatform.getDirectory('$sysHomeDirp$RXRCT_DIRECTORY');
      var to = TprxPlatform.getDirectory('$sysHomeDirp/tmp/');
      if (from.existsSync() && to.existsSync()) {
        List<FileSystemEntity> entities = from.listSync();
        for (FileSystemEntity entity in entities) {
          if (basename(entity.path).startsWith('MOBILE$wsDate')) {
            if (entity is File) {
              entity.copySync(to.path);
              entity.deleteSync();
            }
          }
        }
        // ファイル削除
        entities = from.listSync();
        for (FileSystemEntity entity in entities) {
          if (basename(entity.path).startsWith('MOBILE')) {
            if (entity is File) {
              entity.deleteSync();
            }
          }
        }
      }

      if (from.existsSync() && to.existsSync()) {
        from = TprxPlatform.getDirectory('$sysHomeDirp/tmp/');
        to = TprxPlatform.getDirectory('$sysHomeDirp$RXRCT_DIRECTORY');
        List<FileSystemEntity> entities = from.listSync();
        for (FileSystemEntity entity in entities) {
          if (basename(entity.path).startsWith('MOBILE$wsDate')) {
            if (entity is File) {
              entity.copySync(to.path);
              entity.deleteSync();
            }
          }
        }
      }
    }

    SysJsonFile sysIni = SysJsonFile();
    var wsRemotePath = await sysIni.getValueWithName('mobile', 'remotepath');

    // Get the remote path from the ini file
    if (!wsRemotePath.result) {
      TprLog().logAdd(Tpraid.TPRAID_MOBILE, LogLevelDefine.error,
          'Mobile Pos:Getini Error!!');
      return -1;
    }

    if (xsDate != null && xsDate.isNotEmpty) {
      // Convert x_sDate to YYYYMMDD format and store it in w_sDate
      var wsDate = xsDate.substring(0, 4) +
          xsDate.substring(5, 7) +
          xsDate.substring(8, 10);

      var from = TprxPlatform.getDirectory(wsRemotePath.value.toString());
      var to = TprxPlatform.getDirectory('$sysHomeDirp/tmp/');
      if (from.existsSync() && to.existsSync()) {
        var entities = from.listSync();
        for (FileSystemEntity entity in entities) {
          if (basename(entity.path).startsWith('MOBILE$wsDate')) {
            if (entity is File) {
              entity.copySync(to.path);
              entity.deleteSync();
            }
          }
        }

        entities = from.listSync();
        for (FileSystemEntity entity in entities) {
          if (basename(entity.path).startsWith('MOBILE')) {
            if (entity is File) {
              entity.deleteSync();
            }
          }
        }
      }

      from = TprxPlatform.getDirectory('$sysHomeDirp/tmp/');
      to = TprxPlatform.getDirectory(wsRemotePath.value.toString());
      if (from.existsSync() && to.existsSync()) {
        var entities = from.listSync();
        for (FileSystemEntity entity in entities) {
          if (basename(entity.path).startsWith('MOBILE$wsDate')) {
            if (entity is File) {
              entity.copySync(to.path);
              entity.deleteSync();
            }
          }
        }
      }
    }

    return 0;
  }
}
