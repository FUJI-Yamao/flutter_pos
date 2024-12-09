/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../inc/sys/tpr_aid.dart';
import '../lib/cm_sound/sound.dart';
import '../lib/cm_sound/sound_def.dart';

/// サウンド関連の処理
///  関連tprxソース:\inc\lib\if_spk.h, \lib\if_spk\if_sound.c,
///  \lib\cm_sound\sound_start.c,sound_stop.c
class IfSound {

  /// タッチ音（本体側）
  /// 関連tprxソース:tprx\src\inc\lib\if_spk.h
  /// #define if_bz()             if_sound ( LSPEAKER1, BUZZER_PI )
  static void ifBz() {
    Sound().playTapSound(tid: Tpraid.TPRAID_SOUND);
  }

  /// タッチ音（タワー側or客側表示パネル）
  /// 関連tprxソース:tprx\src\inc\lib\if_spk.h
  /// #define if_bz_cshr()        if_sound ( LSPEAKER2, BUZZER_PI )
  static void ifBzCshr() {
    Sound().playTapSound(tid: Tpraid.TPRAID_SOUND2);
  }

  /// 音再生（本体側）
  /// 関連tprxソース:tprx\src\inc\lib\if_spk.h
  /// #define if_bzerr(mode)      if_sound ( LSPEAKER1, mode )
  /// #define if_bzerr_cshr(mode) if_sound ( LSPEAKER2, mode )
  /// #define if_music(kind)      if_music_com ( LSPEAKER1, kind )
  static void ifSound(SoundKind soundKind) {
    Sound().playSound(tid: Tpraid.TPRAID_SOUND, soundKind: soundKind);
  }

  /// 音再生（タワー側or客側表示パネル）
  /// 関連tprxソース:tprx\src\inc\lib\if_spk.h
  /// #define if_bzerr_cshr(mode) if_sound ( LSPEAKER2, mode )
  /// #define if_music_cshr(kind) if_music_com ( LSPEAKER2, kind )
  static void ifSoundCshr(SoundKind soundKind) {
    Sound().playSound(tid: Tpraid.TPRAID_SOUND2, soundKind: soundKind);
  }

  /// 音を停止する（本体側）
  /// 関連tprxソース:tprx\src\inc\lib\if_spk.h
  /// #define if_bzoff()          if_sound ( LSPEAKER1, BUZZER_OFF )
  static void ifBzOff() {
    Sound().playStop(tid: Tpraid.TPRAID_SOUND);
  }

  /// 音を停止する（タワー側or客側表示パネル）
  /// 関連tprxソース:tprx\src\inc\lib\if_spk.h
  /// #define if_bzoff_cshr()     if_sound ( LSPEAKER2, BUZZER_OFF )
  static void ifBzOffCshr() {
    Sound().playStop(tid: Tpraid.TPRAID_SOUND2);
  }

  /// if_bzon/if_bzon_cshrは、現POSでも実装はないので、移植しない
  /// 関連tprxソース:tprx\src\inc\lib\if_spk.h
  /// #define if_bzon()           if_sound ( LSPEAKER1, BUZZER_ON )
  /// #define if_bzon_cshr()      if_sound ( LSPEAKER2, BUZZER_ON )

  /// init.wavを鳴らす
  /// 関連tprxソース:tprx\src\inc\lib\if_spk.h
  /// #define if_bzinit()         if_sound ( LSPEAKER5, BUZZER_INIT )
  static void ifBzInit() {
    Sound().playSound(tid: Tpraid.TPRAID_SOUND, soundKind: SoundKind.init);
  }
}
