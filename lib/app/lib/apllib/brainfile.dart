/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/environment.dart';
import 'recog.dart';

/// ブレインファイル定義
///  関連tprxソース:\lib\apllib\brainfile.c
class BrainFile {
  static const BRAINTXTFILEDIR = "/tmp/digi";
  static const BRAIN_START = 0;
  static const BRAIN_MENTE = 1;
  static const BRAIN_CANCEL = 2;
  static const BRAIN_EXIT = 3;

  /// ブレインファイルを生成する
  ///  関連tprxソース:brainfile.c - BrainFileMake()
  /// 引数:[sysIni] 設定ファイルから取得したデータ
  ///     [tid] メッセージID
  ///     [flg] 生成するファイルの種類
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  static Future<int> brainFileMake(
      SysJsonFile sysIni, TprTID tid, int flg) async {
    String fname = "";

    RecogRetData resultData = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_BRAIN_SYSTEM, RecogTypes.RECOG_GETSYS);

    if ((resultData.result == RecogValue.RECOG_OK0893) ||
        (resultData.result == RecogValue.RECOG_YES)) {
      switch (flg) {
        case BRAIN_START:
          fname = "${EnvironmentData().sysHomeDir}$BRAINTXTFILEDIR/start.txt";
          break;
        case BRAIN_MENTE:
          fname = "${EnvironmentData().sysHomeDir}$BRAINTXTFILEDIR/maintenance.txt";
          break;
        case BRAIN_CANCEL:
          fname = "${EnvironmentData().sysHomeDir}$BRAINTXTFILEDIR/cancel.txt";
          break;
        case BRAIN_EXIT:
          fname = "${EnvironmentData().sysHomeDir}$BRAINTXTFILEDIR/exit.txt";
          break;
        default:
          return (-1);
      }
      if (!TprxPlatform.getFile(fname).existsSync()) {
        TprLog().logAdd(tid, LogLevelDefine.error,
            "brainFileMake() file open error: $fname");
      }
    }
    return (0);
  }
  /// 関連tprxソース:brainfile.c - brainfile()
  static bool brainFileDel(TprTID tid) {
    // TODO:10091 ブレインファイル/システム
    return true;
  }

  /// 関連tprxソース:brainfile.c - BrainWakeup()
  static bool brainWakeup(TprTID tid) {
    // TODO:10091 ブレインファイル/システム
    return true;
  }
}
