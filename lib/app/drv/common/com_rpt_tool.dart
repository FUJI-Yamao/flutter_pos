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

import '../../common/environment.dart';
import '../../if/if_sound.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/cm_sound/sound_def.dart';

/// Repeat Tool
///  関連tprxソース:\drv\common\com_rpt_tool.c
class ComRptTool {
  /// Repeat Toolファイルの有無を判定する（ない場合、ログを出力する）
  ///  関連tprxソース:com_rpt_tool.c - com_rpt_ope_rec()
  /// 引数:[did] デバイスID
  ///     [data] ブザー音の種類
  ///     [data2] ブザー音の種類
  ///     [data3] ブザー音の種類
  /// 戻り値: なし
  static void comRptOpeRec(
      TprDID did, int data, int data2, String data3) {
    double msTime = _comGetMsTime();
    String buf = msTime.toStringAsFixed(3);
    String tmp = "";
    String fileName = "";

    switch (did) {
      case TprDidDef.TPRDIDMECKEY1:
        tmp = "KEY_D.${data.toString().padLeft(3, '0')}";
        break;
      case TprDidDef.TPRDIDMECKEY2:
        tmp = "KEY_T.${data.toString().padLeft(3, '0')}";
        break;
      case TprDidDef.TPRDIDPMOUSE1:
        tmp =
            "TCH_D.${data.toString().padLeft(4, '0')}.${data2.toString().padLeft(4, '0')}";
        break;
      case TprDidDef.TPRDIDPMOUSE2:
        tmp =
            "TCH_T.${data.toString().padLeft(4, '0')}.${data2.toString().padLeft(4, '0')}";
        break;
      case TprDidDef.TPRDIDSCANNER1:
        tmp = "SCN_D." + data3;
        break;
      case TprDidDef.TPRDIDSCANNER2:
        tmp = "SCN_T." + data3;
        break;
    }
    fileName = "/pj/tprx/tmp/rpttool_rec_file/$buf$tmp";
    if (!TprxPlatform.getFile(fileName).existsSync()) {
      TprLog().logAdd(0, LogLevelDefine.error,
          "com_rpt_tool File($fileName).existsSync() error");
    }
  }

  /// ブザー音を設定する
  ///  関連tprxソース:com_rpt_tool.c - rptTool_bz()
  /// 引数:[sysIni] 設定ファイルから取得したデータ
  ///     [flg] ブザー音の種類
  /// 戻り値: なし
  static void rptToolBz(int flg) {
    switch (flg) {
      case -1:
        IfSound.ifSound(SoundKind.error);
        break;
      case 0:
        IfSound.ifBzInit();
        break;
      default:
        IfSound.ifSound(SoundKind.birth);
        break;
    }
    return;
  }

  /// 音の再生を開始する
  ///  関連tprxソース:com_rpt_tool.c - rptTool_play_start()
  /// 引数: なし
  /// 戻り値: なし
  static void rptToolPlayStart() {
    /// TODO:コマンド実行と同様の処理がFlutterにあるか不明のため、暫定で処理を無効にする
    /*
		system("/pj/tprx/tool/operepeat &");
		 */
    return;
  }

  /// 音の録音を開始する
  ///  関連tprxソース:com_rpt_tool.c - rptTool_rec_start()
  /// 引数: なし
  /// 戻り値: なし
  static void rptToolRecStart() {
    /// TODO:コマンド実行と同様の処理がFlutterにあるか不明のため、暫定で処理を無効にする
    //system("rm /pj/tprx/tmp/rpttool_rec_file/*");
  }

  /// 音の録音を停止する
  ///  関連tprxソース:com_rpt_tool.c - rptTool_rec_stop()
  /// 引数: なし
  /// 戻り値: なし
  static void rptToolRecStop() {
    double msTime = _comGetMsTime();
    String cmd1 =
        "touch /pj/tprx/tmp/rpttool_rec_file/${msTime.toStringAsFixed(3)}.REC_END";
    String cmd2 =
        "ls -1 /pj/tprx/tmp/rpttool_rec_file | grep [1234567890] > /pj/tprx/tmp/rpt_ope_record.txt";

    /// TODO:コマンド実行と同様の処理がFlutterにあるか不明のため、暫定で処理を無効にする
    /*
		system(cmd1);
		system(cmd2);
		 */
    return;
  }

  /// POSIX時間を取得する
  ///  関連tprxソース:com_rpt_tool.c - com_get_mstime()
  /// 引数: なし
  /// 戻り値：POSIX時間
  static double _comGetMsTime() {
    DateTime now = DateTime.now();
    DateTime bgn = DateTime(1970, 1, 1);
    double ret = now.difference(bgn).inMicroseconds * 0.001 * 0.001;

    return ret;
  }
}
