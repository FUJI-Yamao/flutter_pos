/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'soundJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class SoundJsonFile extends ConfigJsonFile {
  static final SoundJsonFile _instance = SoundJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "sound.json";

  SoundJsonFile(){
    setPath(_confPath, _fileName);
  }
  SoundJsonFile._internal();

  factory SoundJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$SoundJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$SoundJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$SoundJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        sound = _$SoundFromJson(jsonD['sound']);
      } catch(e) {
        sound = _$SoundFromJson({});
        ret = false;
      }
      try {
        guidance = _$GuidanceFromJson(jsonD['guidance']);
      } catch(e) {
        guidance = _$GuidanceFromJson({});
        ret = false;
      }
      try {
        hdaivoice = _$HdaivoiceFromJson(jsonD['hdaivoice']);
      } catch(e) {
        hdaivoice = _$HdaivoiceFromJson({});
        ret = false;
      }
      try {
        arsttsvoice = _$ArsttsvoiceFromJson(jsonD['arsttsvoice']);
      } catch(e) {
        arsttsvoice = _$ArsttsvoiceFromJson({});
        ret = false;
      }
      try {
        volume = _$VolumeFromJson(jsonD['volume']);
      } catch(e) {
        volume = _$VolumeFromJson({});
        ret = false;
      }
      try {
        designated = _$DesignatedFromJson(jsonD['designated']);
      } catch(e) {
        designated = _$DesignatedFromJson({});
        ret = false;
      }
      try {
        pitch = _$PitchFromJson(jsonD['pitch']);
      } catch(e) {
        pitch = _$PitchFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Sound sound = _Sound(
    wav_use                            : 0,
  );

  _Guidance guidance = _Guidance(
    left_volume                        : 0,
    right_volume                       : 0,
  );

  _Hdaivoice hdaivoice = _Hdaivoice(
    voice_volume                       : 0,
    voice_speed                        : 0,
    effect_volume0                     : 0,
    effect_volume1                     : 0,
    effect_volume2                     : 0,
    effect_volume3                     : 0,
    effect_volume4                     : 0,
    effect_volume5                     : 0,
    effect_volume6                     : 0,
    effect_volume7                     : 0,
    effect_volume8                     : 0,
    effect_volume9                     : 0,
  );

  _Arsttsvoice arsttsvoice = _Arsttsvoice(
    voice_volume                       : 0,
    voice_loudness                     : 0,
    voice_speed                        : 0,
    voice_leave                        : 0,
  );

  _Volume volume = _Volume(
    G1R                                : 0,
    G1L                                : 0,
    G2                                 : 0,
    VIA_DXS1                           : 0,
    VIA_DXS2                           : 0,
    VIA_DXS3                           : 0,
    VIA_DXS4                           : 0,
    ERR_R                              : 0,
    ERR_L                              : 0,
    WARN_R                             : 0,
    WARN_L                             : 0,
    FANFARE1_R                         : 0,
    FANFARE1_L                         : 0,
    FANFARE2_R                         : 0,
    FANFARE2_L                         : 0,
    FANFARE3_R                         : 0,
    FANFARE3_L                         : 0,
    BIRTH_R                            : 0,
    BIRTH_L                            : 0,
    POPUP_R                            : 0,
    POPUP_L                            : 0,
    VERIFONE_R                         : 0,
    VERIFONE_L                         : 0,
  );

  _Designated designated = _Designated(
    D_Left                             : 0,
    D_Right                            : 0,
  );

  _Pitch pitch = _Pitch(
    CLICK_NUM_R                        : 0,
    CLICK_NUM_L                        : 0,
    ERR_NUM_R                          : 0,
    ERR_NUM_L                          : 0,
    FANFARE1_NUM_R                     : 0,
    FANFARE1_NUM_L                     : 0,
    FANFARE2_NUM_R                     : 0,
    FANFARE2_NUM_L                     : 0,
    FANFARE3_NUM_R                     : 0,
    FANFARE3_NUM_L                     : 0,
    BIRTH_NUM_R                        : 0,
    BIRTH_NUM_L                        : 0,
    WARNING_NUM_R                      : 0,
    WARNING_NUM_L                      : 0,
    POPUP_NUM_R                        : 0,
    POPUP_NUM_L                        : 0,
    VERIFONE_NUM_R                     : 0,
    VERIFONE_NUM_L                     : 0,
  );
}

@JsonSerializable()
class _Sound {
  factory _Sound.fromJson(Map<String, dynamic> json) => _$SoundFromJson(json);
  Map<String, dynamic> toJson() => _$SoundToJson(this);

  _Sound({
    required this.wav_use,
  });

  @JsonKey(defaultValue: 1)
  int    wav_use;
}

@JsonSerializable()
class _Guidance {
  factory _Guidance.fromJson(Map<String, dynamic> json) => _$GuidanceFromJson(json);
  Map<String, dynamic> toJson() => _$GuidanceToJson(this);

  _Guidance({
    required this.left_volume,
    required this.right_volume,
  });

  @JsonKey(defaultValue: 100)
  int    left_volume;
  @JsonKey(defaultValue: 100)
  int    right_volume;
}

@JsonSerializable()
class _Hdaivoice {
  factory _Hdaivoice.fromJson(Map<String, dynamic> json) => _$HdaivoiceFromJson(json);
  Map<String, dynamic> toJson() => _$HdaivoiceToJson(this);

  _Hdaivoice({
    required this.voice_volume,
    required this.voice_speed,
    required this.effect_volume0,
    required this.effect_volume1,
    required this.effect_volume2,
    required this.effect_volume3,
    required this.effect_volume4,
    required this.effect_volume5,
    required this.effect_volume6,
    required this.effect_volume7,
    required this.effect_volume8,
    required this.effect_volume9,
  });

  @JsonKey(defaultValue: 100)
  int    voice_volume;
  @JsonKey(defaultValue: 130)
  int    voice_speed;
  @JsonKey(defaultValue: 100)
  int    effect_volume0;
  @JsonKey(defaultValue: 100)
  int    effect_volume1;
  @JsonKey(defaultValue: 100)
  int    effect_volume2;
  @JsonKey(defaultValue: 100)
  int    effect_volume3;
  @JsonKey(defaultValue: 100)
  int    effect_volume4;
  @JsonKey(defaultValue: 100)
  int    effect_volume5;
  @JsonKey(defaultValue: 100)
  int    effect_volume6;
  @JsonKey(defaultValue: 100)
  int    effect_volume7;
  @JsonKey(defaultValue: 100)
  int    effect_volume8;
  @JsonKey(defaultValue: 100)
  int    effect_volume9;
}

@JsonSerializable()
class _Arsttsvoice {
  factory _Arsttsvoice.fromJson(Map<String, dynamic> json) => _$ArsttsvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$ArsttsvoiceToJson(this);

  _Arsttsvoice({
    required this.voice_volume,
    required this.voice_loudness,
    required this.voice_speed,
    required this.voice_leave,
  });

  @JsonKey(defaultValue: 119)
  int    voice_volume;
  @JsonKey(defaultValue: 1)
  int    voice_loudness;
  @JsonKey(defaultValue: 1)
  int    voice_speed;
  @JsonKey(defaultValue: 500)
  int    voice_leave;
}

@JsonSerializable()
class _Volume {
  factory _Volume.fromJson(Map<String, dynamic> json) => _$VolumeFromJson(json);
  Map<String, dynamic> toJson() => _$VolumeToJson(this);

  _Volume({
    required this.G1R,
    required this.G1L,
    required this.G2,
    required this.VIA_DXS1,
    required this.VIA_DXS2,
    required this.VIA_DXS3,
    required this.VIA_DXS4,
    required this.ERR_R,
    required this.ERR_L,
    required this.WARN_R,
    required this.WARN_L,
    required this.FANFARE1_R,
    required this.FANFARE1_L,
    required this.FANFARE2_R,
    required this.FANFARE2_L,
    required this.FANFARE3_R,
    required this.FANFARE3_L,
    required this.BIRTH_R,
    required this.BIRTH_L,
    required this.POPUP_R,
    required this.POPUP_L,
    required this.VERIFONE_R,
    required this.VERIFONE_L,
  });

  @JsonKey(defaultValue: 10)
  int    G1R;
  @JsonKey(defaultValue: 10)
  int    G1L;
  @JsonKey(defaultValue: 10)
  int    G2;
  @JsonKey(defaultValue: 100)
  int    VIA_DXS1;
  @JsonKey(defaultValue: 100)
  int    VIA_DXS2;
  @JsonKey(defaultValue: 100)
  int    VIA_DXS3;
  @JsonKey(defaultValue: 100)
  int    VIA_DXS4;
  @JsonKey(defaultValue: 10)
  int    ERR_R;
  @JsonKey(defaultValue: 10)
  int    ERR_L;
  @JsonKey(defaultValue: 10)
  int    WARN_R;
  @JsonKey(defaultValue: 10)
  int    WARN_L;
  @JsonKey(defaultValue: 10)
  int    FANFARE1_R;
  @JsonKey(defaultValue: 10)
  int    FANFARE1_L;
  @JsonKey(defaultValue: 10)
  int    FANFARE2_R;
  @JsonKey(defaultValue: 10)
  int    FANFARE2_L;
  @JsonKey(defaultValue: 10)
  int    FANFARE3_R;
  @JsonKey(defaultValue: 10)
  int    FANFARE3_L;
  @JsonKey(defaultValue: 10)
  int    BIRTH_R;
  @JsonKey(defaultValue: 10)
  int    BIRTH_L;
  @JsonKey(defaultValue: 10)
  int    POPUP_R;
  @JsonKey(defaultValue: 10)
  int    POPUP_L;
  @JsonKey(defaultValue: 10)
  int    VERIFONE_R;
  @JsonKey(defaultValue: 10)
  int    VERIFONE_L;
}

@JsonSerializable()
class _Designated {
  factory _Designated.fromJson(Map<String, dynamic> json) => _$DesignatedFromJson(json);
  Map<String, dynamic> toJson() => _$DesignatedToJson(this);

  _Designated({
    required this.D_Left,
    required this.D_Right,
  });

  @JsonKey(defaultValue: 10)
  int    D_Left;
  @JsonKey(defaultValue: 10)
  int    D_Right;
}

@JsonSerializable()
class _Pitch {
  factory _Pitch.fromJson(Map<String, dynamic> json) => _$PitchFromJson(json);
  Map<String, dynamic> toJson() => _$PitchToJson(this);

  _Pitch({
    required this.CLICK_NUM_R,
    required this.CLICK_NUM_L,
    required this.ERR_NUM_R,
    required this.ERR_NUM_L,
    required this.FANFARE1_NUM_R,
    required this.FANFARE1_NUM_L,
    required this.FANFARE2_NUM_R,
    required this.FANFARE2_NUM_L,
    required this.FANFARE3_NUM_R,
    required this.FANFARE3_NUM_L,
    required this.BIRTH_NUM_R,
    required this.BIRTH_NUM_L,
    required this.WARNING_NUM_R,
    required this.WARNING_NUM_L,
    required this.POPUP_NUM_R,
    required this.POPUP_NUM_L,
    required this.VERIFONE_NUM_R,
    required this.VERIFONE_NUM_L,
  });

  @JsonKey(defaultValue: 1)
  int    CLICK_NUM_R;
  @JsonKey(defaultValue: 1)
  int    CLICK_NUM_L;
  @JsonKey(defaultValue: 1)
  int    ERR_NUM_R;
  @JsonKey(defaultValue: 1)
  int    ERR_NUM_L;
  @JsonKey(defaultValue: 1)
  int    FANFARE1_NUM_R;
  @JsonKey(defaultValue: 1)
  int    FANFARE1_NUM_L;
  @JsonKey(defaultValue: 1)
  int    FANFARE2_NUM_R;
  @JsonKey(defaultValue: 1)
  int    FANFARE2_NUM_L;
  @JsonKey(defaultValue: 1)
  int    FANFARE3_NUM_R;
  @JsonKey(defaultValue: 1)
  int    FANFARE3_NUM_L;
  @JsonKey(defaultValue: 1)
  int    BIRTH_NUM_R;
  @JsonKey(defaultValue: 1)
  int    BIRTH_NUM_L;
  @JsonKey(defaultValue: 1)
  int    WARNING_NUM_R;
  @JsonKey(defaultValue: 1)
  int    WARNING_NUM_L;
  @JsonKey(defaultValue: 1)
  int    POPUP_NUM_R;
  @JsonKey(defaultValue: 1)
  int    POPUP_NUM_L;
  @JsonKey(defaultValue: 1)
  int    VERIFONE_NUM_R;
  @JsonKey(defaultValue: 1)
  int    VERIFONE_NUM_L;
}

