/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
///
/// サウンド用ヘッダファイル関連
///  関連tprxソース:cm_sound.h
enum CmSound {
    SOUND_STEREO,
    SOUND_DESKTOP,
    SOUND_TOWER;
}

///  関連tprxソース:cm_sound.h - SOUND_VOL_KIND
enum SoundVolKind {
    SOUND_VOL_G1,
    SOUND_VOL_DESIGNATED,
    SOUND_VOL_GUIDANCE,
    SOUND_VOL_STEREO,
    SOUND_VOL_ERROR,		// レジエラー音
    SOUND_VOL_WARNING,		// レジ警告音
    SOUND_VOL_FANFARE,		// ﾌｧﾝﾌｧｰﾚ音
    SOUND_VOL_POPUP,		// ポップアップ音
    SOUND_VOL_VERIFONE;		// VERIFONE音
}