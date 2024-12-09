/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/environment.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_type.dart';
import 'package:flutter_pos/app/lib/cm_sound/sound.dart';
import 'package:flutter_pos/app/lib/cm_sound/sound_def.dart';
import 'package:flutter_pos/app/lib/cm_sound/sound_file_util.dart';
import '../../ui/enum/e_screen_kind.dart';
import '../inc/rc_regs.dart';
import 'rcsyschk.dart';

///
/// 関連tprxソース: tprx\src\regs\checker\rc_sound.c
///
class RcSound {
  /// ガイダンス音声の再生
  /// 関連tprxソース: extern void rcSound(char *sound_no)
  static Future<void> play({
    required String sndFile,
    bool isLoop = false,
  }) async {
    // ガイダンス音声の停止
    stop();

    // TIDを取得する
    TprMID tid = await _getTid();
    // ガイダンス音声の再生
    String filePath = SoundFileUtil.fixedFileName(
      fileName: sndFile,
    );
    Sound().playSoundForFile(
      tid: tid,
      fileName: filePath,
      soundVolumeKind: SoundVolumeKind.guidance,
      isLoop: isLoop,
    );
  }

  /// 音声番号からガイダンス音声の再生
  /// 関連tprxソース: extern void rcSound(char *sound_no)
  static Future<void> playFromSoundNum({
    required int soundNum,
    bool isLoop = false,
  }) async {
    // ガイダンス音声の停止
    await syncStop();

    // ガイダンス音声番号からファイル名を取得
    String sndFile = SoundFileUtil.getFileNameByNumber(
        soundNum: soundNum);
    // 初期表示に少し遅らせてからガイダンス音声が流れるようにする
    await Future.delayed(const Duration(milliseconds: SoundDef.guidanceWait));

    // TIDを取得する
    TprMID tid = await _getTid();

    // ガイダンス音声の再生
    String filePath = SoundFileUtil.fixedFileName(
      fileName: sndFile,
    );
    Sound().playSoundForFile(
      tid: tid,
      fileName: filePath,
      soundVolumeKind: SoundVolumeKind.guidance,
      isLoop: isLoop,
    );
  }

  /// ガイダンス音声の停止
  /// 関連tprxソース: extern void rcSound(char *sound_no)
  static Future<void> stop() async {
    // TIDを取得する
    TprMID tid = await _getTid();
    // 音を停止する
    Sound().playStop(tid: tid);
  }

  /// ガイダンス音声を同期的に停止
  /// 関連tprxソース: extern void rcSound(char *sound_no)
  static Future<void> syncStop() async {
    // TIDを取得する
    TprMID tid = await _getTid();
    // 音を停止する
    await Sound().syncPlayStop(tid: tid);
  }

  /// TIDを取得する
  static Future<TprMID> _getTid() async {
    late TprMID tid;

    // 現POSの仕組みでは、うまくいかないのでコメントアウト
    /*
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE || RcRegs.KY_DUALCSHR:
        tid = Tpraid.TPRAID_SOUND;
      case RcRegs.KY_CHECKER:
        tid = Tpraid.TPRAID_SOUND2;
      case RcRegs.KY_SINGLE:
        tid = Tpraid.TPRAID_SOUND;
      default:
        tid = Tpraid.TPRAID_SOUND;
    }

    if (await RcSysChk.rcChkSmartSelfSystem()
        && (await RcSysChk.rcNewSGChkNewSelfGateSystem() ||await  RcSysChk.rcQCChkQcashierSystem())) {
      tid = Tpraid.TPRAID_SOUND2;
    }
     */
    switch (EnvironmentData().screenKind) {
      case ScreenKind.register:
        tid = Tpraid.TPRAID_SOUND;
      case ScreenKind.register2 || ScreenKind.customer:
        tid = Tpraid.TPRAID_SOUND2;
      case ScreenKind.customer_7_1 || ScreenKind.customer_7_2:
      // このプロセスで音を鳴らすことはないが、TPRAID_SOUND2を設定しておく
        tid = Tpraid.TPRAID_SOUND2;
    }

    return tid;
  }

  /// 関連tprxソース: extern void rc_KeySound( char *filename )
  static Future<void> rcKeySound(String? filename) async {
    String filePath;
    Sound sound = Sound();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_DUALCSHR:
        sound.playStop(tid: Tpraid.TPRAID_SOUND);
        if (filename != null) {
          filePath = TprxPlatform.getPlatformPath(EnvironmentData.TPRX_HOME +
              SoundDef.assetsPath +
              SoundDef.soundPath +
              filename);
          sound.playSoundForFile(
              tid: Tpraid.TPRAID_SOUND,
              fileName: filePath,
              soundVolumeKind: SoundVolumeKind.tap);
        }
        break;
      case RcRegs.KY_CHECKER:
        sound.playStop(tid: Tpraid.TPRAID_SOUND2);
        if (filename != null) {
          filePath = TprxPlatform.getPlatformPath(EnvironmentData.TPRX_HOME +
              SoundDef.assetsPath +
              SoundDef.soundPath +
              filename);
          sound.playSoundForFile(
              tid: Tpraid.TPRAID_SOUND2,
              fileName: filePath,
              soundVolumeKind: SoundVolumeKind.tap);
        }
        break;
      case RcRegs.KY_SINGLE:
        sound.playStop(tid: Tpraid.TPRAID_SOUND);
        sound.playStop(tid: Tpraid.TPRAID_SOUND2);
        if (filename != null) {
          filePath = TprxPlatform.getPlatformPath(EnvironmentData.TPRX_HOME +
              SoundDef.assetsPath +
              SoundDef.soundPath +
              filename);
          sound.playSoundForFile(
              tid: Tpraid.TPRAID_SOUND,
              fileName: filePath,
              soundVolumeKind: SoundVolumeKind.tap); // 新POSではKY_SINGLEをなくす予定なので実装しない(stereo)
        }
        break;
      default:
        return;
    }
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（サウンド関連）
  /// Shop&Go精算機で会員読込をした時の音を再生する
  /// 引数:[type] 音のタイプ
  /// 引数:[sagIcReadMbrFlg] CoGCaIC読取操作で1度読み設定有効フラグ
  /// 関連tprxソース: rc_sound.c - rcSAG_MbrRead_Sound
  static void rcSAGMbrReadSound(int type, int sagIcReadMbrFlg) {}
}