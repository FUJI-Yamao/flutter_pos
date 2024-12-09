// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'soundJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SoundJsonFile _$SoundJsonFileFromJson(Map<String, dynamic> json) =>
    SoundJsonFile()
      ..sound = _Sound.fromJson(json['sound'] as Map<String, dynamic>)
      ..guidance = _Guidance.fromJson(json['guidance'] as Map<String, dynamic>)
      ..hdaivoice =
          _Hdaivoice.fromJson(json['hdaivoice'] as Map<String, dynamic>)
      ..arsttsvoice =
          _Arsttsvoice.fromJson(json['arsttsvoice'] as Map<String, dynamic>)
      ..volume = _Volume.fromJson(json['volume'] as Map<String, dynamic>)
      ..designated =
          _Designated.fromJson(json['designated'] as Map<String, dynamic>)
      ..pitch = _Pitch.fromJson(json['pitch'] as Map<String, dynamic>);

Map<String, dynamic> _$SoundJsonFileToJson(SoundJsonFile instance) =>
    <String, dynamic>{
      'sound': instance.sound.toJson(),
      'guidance': instance.guidance.toJson(),
      'hdaivoice': instance.hdaivoice.toJson(),
      'arsttsvoice': instance.arsttsvoice.toJson(),
      'volume': instance.volume.toJson(),
      'designated': instance.designated.toJson(),
      'pitch': instance.pitch.toJson(),
    };

_Sound _$SoundFromJson(Map<String, dynamic> json) => _Sound(
      wav_use: json['wav_use'] as int? ?? 1,
    );

Map<String, dynamic> _$SoundToJson(_Sound instance) => <String, dynamic>{
      'wav_use': instance.wav_use,
    };

_Guidance _$GuidanceFromJson(Map<String, dynamic> json) => _Guidance(
      left_volume: json['left_volume'] as int? ?? 100,
      right_volume: json['right_volume'] as int? ?? 100,
    );

Map<String, dynamic> _$GuidanceToJson(_Guidance instance) => <String, dynamic>{
      'left_volume': instance.left_volume,
      'right_volume': instance.right_volume,
    };

_Hdaivoice _$HdaivoiceFromJson(Map<String, dynamic> json) => _Hdaivoice(
      voice_volume: json['voice_volume'] as int? ?? 100,
      voice_speed: json['voice_speed'] as int? ?? 130,
      effect_volume0: json['effect_volume0'] as int? ?? 100,
      effect_volume1: json['effect_volume1'] as int? ?? 100,
      effect_volume2: json['effect_volume2'] as int? ?? 100,
      effect_volume3: json['effect_volume3'] as int? ?? 100,
      effect_volume4: json['effect_volume4'] as int? ?? 100,
      effect_volume5: json['effect_volume5'] as int? ?? 100,
      effect_volume6: json['effect_volume6'] as int? ?? 100,
      effect_volume7: json['effect_volume7'] as int? ?? 100,
      effect_volume8: json['effect_volume8'] as int? ?? 100,
      effect_volume9: json['effect_volume9'] as int? ?? 100,
    );

Map<String, dynamic> _$HdaivoiceToJson(_Hdaivoice instance) =>
    <String, dynamic>{
      'voice_volume': instance.voice_volume,
      'voice_speed': instance.voice_speed,
      'effect_volume0': instance.effect_volume0,
      'effect_volume1': instance.effect_volume1,
      'effect_volume2': instance.effect_volume2,
      'effect_volume3': instance.effect_volume3,
      'effect_volume4': instance.effect_volume4,
      'effect_volume5': instance.effect_volume5,
      'effect_volume6': instance.effect_volume6,
      'effect_volume7': instance.effect_volume7,
      'effect_volume8': instance.effect_volume8,
      'effect_volume9': instance.effect_volume9,
    };

_Arsttsvoice _$ArsttsvoiceFromJson(Map<String, dynamic> json) => _Arsttsvoice(
      voice_volume: json['voice_volume'] as int? ?? 119,
      voice_loudness: json['voice_loudness'] as int? ?? 1,
      voice_speed: json['voice_speed'] as int? ?? 1,
      voice_leave: json['voice_leave'] as int? ?? 500,
    );

Map<String, dynamic> _$ArsttsvoiceToJson(_Arsttsvoice instance) =>
    <String, dynamic>{
      'voice_volume': instance.voice_volume,
      'voice_loudness': instance.voice_loudness,
      'voice_speed': instance.voice_speed,
      'voice_leave': instance.voice_leave,
    };

_Volume _$VolumeFromJson(Map<String, dynamic> json) => _Volume(
      G1R: json['G1R'] as int? ?? 10,
      G1L: json['G1L'] as int? ?? 10,
      G2: json['G2'] as int? ?? 10,
      VIA_DXS1: json['VIA_DXS1'] as int? ?? 100,
      VIA_DXS2: json['VIA_DXS2'] as int? ?? 100,
      VIA_DXS3: json['VIA_DXS3'] as int? ?? 100,
      VIA_DXS4: json['VIA_DXS4'] as int? ?? 100,
      ERR_R: json['ERR_R'] as int? ?? 10,
      ERR_L: json['ERR_L'] as int? ?? 10,
      WARN_R: json['WARN_R'] as int? ?? 10,
      WARN_L: json['WARN_L'] as int? ?? 10,
      FANFARE1_R: json['FANFARE1_R'] as int? ?? 10,
      FANFARE1_L: json['FANFARE1_L'] as int? ?? 10,
      FANFARE2_R: json['FANFARE2_R'] as int? ?? 10,
      FANFARE2_L: json['FANFARE2_L'] as int? ?? 10,
      FANFARE3_R: json['FANFARE3_R'] as int? ?? 10,
      FANFARE3_L: json['FANFARE3_L'] as int? ?? 10,
      BIRTH_R: json['BIRTH_R'] as int? ?? 10,
      BIRTH_L: json['BIRTH_L'] as int? ?? 10,
      POPUP_R: json['POPUP_R'] as int? ?? 10,
      POPUP_L: json['POPUP_L'] as int? ?? 10,
      VERIFONE_R: json['VERIFONE_R'] as int? ?? 10,
      VERIFONE_L: json['VERIFONE_L'] as int? ?? 10,
    );

Map<String, dynamic> _$VolumeToJson(_Volume instance) => <String, dynamic>{
      'G1R': instance.G1R,
      'G1L': instance.G1L,
      'G2': instance.G2,
      'VIA_DXS1': instance.VIA_DXS1,
      'VIA_DXS2': instance.VIA_DXS2,
      'VIA_DXS3': instance.VIA_DXS3,
      'VIA_DXS4': instance.VIA_DXS4,
      'ERR_R': instance.ERR_R,
      'ERR_L': instance.ERR_L,
      'WARN_R': instance.WARN_R,
      'WARN_L': instance.WARN_L,
      'FANFARE1_R': instance.FANFARE1_R,
      'FANFARE1_L': instance.FANFARE1_L,
      'FANFARE2_R': instance.FANFARE2_R,
      'FANFARE2_L': instance.FANFARE2_L,
      'FANFARE3_R': instance.FANFARE3_R,
      'FANFARE3_L': instance.FANFARE3_L,
      'BIRTH_R': instance.BIRTH_R,
      'BIRTH_L': instance.BIRTH_L,
      'POPUP_R': instance.POPUP_R,
      'POPUP_L': instance.POPUP_L,
      'VERIFONE_R': instance.VERIFONE_R,
      'VERIFONE_L': instance.VERIFONE_L,
    };

_Designated _$DesignatedFromJson(Map<String, dynamic> json) => _Designated(
      D_Left: json['D_Left'] as int? ?? 10,
      D_Right: json['D_Right'] as int? ?? 10,
    );

Map<String, dynamic> _$DesignatedToJson(_Designated instance) =>
    <String, dynamic>{
      'D_Left': instance.D_Left,
      'D_Right': instance.D_Right,
    };

_Pitch _$PitchFromJson(Map<String, dynamic> json) => _Pitch(
      CLICK_NUM_R: json['CLICK_NUM_R'] as int? ?? 1,
      CLICK_NUM_L: json['CLICK_NUM_L'] as int? ?? 1,
      ERR_NUM_R: json['ERR_NUM_R'] as int? ?? 1,
      ERR_NUM_L: json['ERR_NUM_L'] as int? ?? 1,
      FANFARE1_NUM_R: json['FANFARE1_NUM_R'] as int? ?? 1,
      FANFARE1_NUM_L: json['FANFARE1_NUM_L'] as int? ?? 1,
      FANFARE2_NUM_R: json['FANFARE2_NUM_R'] as int? ?? 1,
      FANFARE2_NUM_L: json['FANFARE2_NUM_L'] as int? ?? 1,
      FANFARE3_NUM_R: json['FANFARE3_NUM_R'] as int? ?? 1,
      FANFARE3_NUM_L: json['FANFARE3_NUM_L'] as int? ?? 1,
      BIRTH_NUM_R: json['BIRTH_NUM_R'] as int? ?? 1,
      BIRTH_NUM_L: json['BIRTH_NUM_L'] as int? ?? 1,
      WARNING_NUM_R: json['WARNING_NUM_R'] as int? ?? 1,
      WARNING_NUM_L: json['WARNING_NUM_L'] as int? ?? 1,
      POPUP_NUM_R: json['POPUP_NUM_R'] as int? ?? 1,
      POPUP_NUM_L: json['POPUP_NUM_L'] as int? ?? 1,
      VERIFONE_NUM_R: json['VERIFONE_NUM_R'] as int? ?? 1,
      VERIFONE_NUM_L: json['VERIFONE_NUM_L'] as int? ?? 1,
    );

Map<String, dynamic> _$PitchToJson(_Pitch instance) => <String, dynamic>{
      'CLICK_NUM_R': instance.CLICK_NUM_R,
      'CLICK_NUM_L': instance.CLICK_NUM_L,
      'ERR_NUM_R': instance.ERR_NUM_R,
      'ERR_NUM_L': instance.ERR_NUM_L,
      'FANFARE1_NUM_R': instance.FANFARE1_NUM_R,
      'FANFARE1_NUM_L': instance.FANFARE1_NUM_L,
      'FANFARE2_NUM_R': instance.FANFARE2_NUM_R,
      'FANFARE2_NUM_L': instance.FANFARE2_NUM_L,
      'FANFARE3_NUM_R': instance.FANFARE3_NUM_R,
      'FANFARE3_NUM_L': instance.FANFARE3_NUM_L,
      'BIRTH_NUM_R': instance.BIRTH_NUM_R,
      'BIRTH_NUM_L': instance.BIRTH_NUM_L,
      'WARNING_NUM_R': instance.WARNING_NUM_R,
      'WARNING_NUM_L': instance.WARNING_NUM_L,
      'POPUP_NUM_R': instance.POPUP_NUM_R,
      'POPUP_NUM_L': instance.POPUP_NUM_L,
      'VERIFONE_NUM_R': instance.VERIFONE_NUM_R,
      'VERIFONE_NUM_L': instance.VERIFONE_NUM_L,
    };
