/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'sioJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class SioJsonFile extends ConfigJsonFile {
  static final SioJsonFile _instance = SioJsonFile._internal();

  final String _confPath = "conf/";
  final JsonLanguage _confLang = JsonLanguage.aa;
  final String _fileName = "sio.json";

  SioJsonFile(){
    setPath(_confPath, _fileName, _confLang);
  }
  SioJsonFile._internal();

  factory SioJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$SioJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$SioJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$SioJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        global = _$GlobalFromJson(jsonD['global']);
      } catch(e) {
        global = _$GlobalFromJson({});
        ret = false;
      }
      try {
        button01 = _$Button01FromJson(jsonD['button01']);
      } catch(e) {
        button01 = _$Button01FromJson({});
        ret = false;
      }
      try {
        button02 = _$Button02FromJson(jsonD['button02']);
      } catch(e) {
        button02 = _$Button02FromJson({});
        ret = false;
      }
      try {
        button03 = _$Button03FromJson(jsonD['button03']);
      } catch(e) {
        button03 = _$Button03FromJson({});
        ret = false;
      }
      try {
        button04 = _$Button04FromJson(jsonD['button04']);
      } catch(e) {
        button04 = _$Button04FromJson({});
        ret = false;
      }
      try {
        button05 = _$Button05FromJson(jsonD['button05']);
      } catch(e) {
        button05 = _$Button05FromJson({});
        ret = false;
      }
      try {
        button06 = _$Button06FromJson(jsonD['button06']);
      } catch(e) {
        button06 = _$Button06FromJson({});
        ret = false;
      }
      try {
        button07 = _$Button07FromJson(jsonD['button07']);
      } catch(e) {
        button07 = _$Button07FromJson({});
        ret = false;
      }
      try {
        button08 = _$Button08FromJson(jsonD['button08']);
      } catch(e) {
        button08 = _$Button08FromJson({});
        ret = false;
      }
      try {
        button09 = _$Button09FromJson(jsonD['button09']);
      } catch(e) {
        button09 = _$Button09FromJson({});
        ret = false;
      }
      try {
        button10 = _$Button10FromJson(jsonD['button10']);
      } catch(e) {
        button10 = _$Button10FromJson({});
        ret = false;
      }
      try {
        button11 = _$Button11FromJson(jsonD['button11']);
      } catch(e) {
        button11 = _$Button11FromJson({});
        ret = false;
      }
      try {
        button12 = _$Button12FromJson(jsonD['button12']);
      } catch(e) {
        button12 = _$Button12FromJson({});
        ret = false;
      }
      try {
        button13 = _$Button13FromJson(jsonD['button13']);
      } catch(e) {
        button13 = _$Button13FromJson({});
        ret = false;
      }
      try {
        button14 = _$Button14FromJson(jsonD['button14']);
      } catch(e) {
        button14 = _$Button14FromJson({});
        ret = false;
      }
      try {
        button15 = _$Button15FromJson(jsonD['button15']);
      } catch(e) {
        button15 = _$Button15FromJson({});
        ret = false;
      }
      try {
        button16 = _$Button16FromJson(jsonD['button16']);
      } catch(e) {
        button16 = _$Button16FromJson({});
        ret = false;
      }
      try {
        button17 = _$Button17FromJson(jsonD['button17']);
      } catch(e) {
        button17 = _$Button17FromJson({});
        ret = false;
      }
      try {
        button18 = _$Button18FromJson(jsonD['button18']);
      } catch(e) {
        button18 = _$Button18FromJson({});
        ret = false;
      }
      try {
        button19 = _$Button19FromJson(jsonD['button19']);
      } catch(e) {
        button19 = _$Button19FromJson({});
        ret = false;
      }
      try {
        button20 = _$Button20FromJson(jsonD['button20']);
      } catch(e) {
        button20 = _$Button20FromJson({});
        ret = false;
      }
      try {
        button21 = _$Button21FromJson(jsonD['button21']);
      } catch(e) {
        button21 = _$Button21FromJson({});
        ret = false;
      }
      try {
        button22 = _$Button22FromJson(jsonD['button22']);
      } catch(e) {
        button22 = _$Button22FromJson({});
        ret = false;
      }
      try {
        button23 = _$Button23FromJson(jsonD['button23']);
      } catch(e) {
        button23 = _$Button23FromJson({});
        ret = false;
      }
      try {
        button24 = _$Button24FromJson(jsonD['button24']);
      } catch(e) {
        button24 = _$Button24FromJson({});
        ret = false;
      }
      try {
        button25 = _$Button25FromJson(jsonD['button25']);
      } catch(e) {
        button25 = _$Button25FromJson({});
        ret = false;
      }
      try {
        button26 = _$Button26FromJson(jsonD['button26']);
      } catch(e) {
        button26 = _$Button26FromJson({});
        ret = false;
      }
      try {
        button27 = _$Button27FromJson(jsonD['button27']);
      } catch(e) {
        button27 = _$Button27FromJson({});
        ret = false;
      }
      try {
        button28 = _$Button28FromJson(jsonD['button28']);
      } catch(e) {
        button28 = _$Button28FromJson({});
        ret = false;
      }
      try {
        button29 = _$Button29FromJson(jsonD['button29']);
      } catch(e) {
        button29 = _$Button29FromJson({});
        ret = false;
      }
      try {
        button30 = _$Button30FromJson(jsonD['button30']);
      } catch(e) {
        button30 = _$Button30FromJson({});
        ret = false;
      }
      try {
        button31 = _$Button31FromJson(jsonD['button31']);
      } catch(e) {
        button31 = _$Button31FromJson({});
        ret = false;
      }
      try {
        button32 = _$Button32FromJson(jsonD['button32']);
      } catch(e) {
        button32 = _$Button32FromJson({});
        ret = false;
      }
      try {
        button33 = _$Button33FromJson(jsonD['button33']);
      } catch(e) {
        button33 = _$Button33FromJson({});
        ret = false;
      }
      try {
        button34 = _$Button34FromJson(jsonD['button34']);
      } catch(e) {
        button34 = _$Button34FromJson({});
        ret = false;
      }
      try {
        button35 = _$Button35FromJson(jsonD['button35']);
      } catch(e) {
        button35 = _$Button35FromJson({});
        ret = false;
      }
      try {
        button36 = _$Button36FromJson(jsonD['button36']);
      } catch(e) {
        button36 = _$Button36FromJson({});
        ret = false;
      }
      try {
        button37 = _$Button37FromJson(jsonD['button37']);
      } catch(e) {
        button37 = _$Button37FromJson({});
        ret = false;
      }
      try {
        button38 = _$Button38FromJson(jsonD['button38']);
      } catch(e) {
        button38 = _$Button38FromJson({});
        ret = false;
      }
      try {
        button39 = _$Button39FromJson(jsonD['button39']);
      } catch(e) {
        button39 = _$Button39FromJson({});
        ret = false;
      }
      try {
        button40 = _$Button40FromJson(jsonD['button40']);
      } catch(e) {
        button40 = _$Button40FromJson({});
        ret = false;
      }
      try {
        button41 = _$Button41FromJson(jsonD['button41']);
      } catch(e) {
        button41 = _$Button41FromJson({});
        ret = false;
      }
      try {
        button42 = _$Button42FromJson(jsonD['button42']);
      } catch(e) {
        button42 = _$Button42FromJson({});
        ret = false;
      }
      try {
        button43 = _$Button43FromJson(jsonD['button43']);
      } catch(e) {
        button43 = _$Button43FromJson({});
        ret = false;
      }
      try {
        button44 = _$Button44FromJson(jsonD['button44']);
      } catch(e) {
        button44 = _$Button44FromJson({});
        ret = false;
      }
      try {
        button45 = _$Button45FromJson(jsonD['button45']);
      } catch(e) {
        button45 = _$Button45FromJson({});
        ret = false;
      }
      try {
        button46 = _$Button46FromJson(jsonD['button46']);
      } catch(e) {
        button46 = _$Button46FromJson({});
        ret = false;
      }
      try {
        button47 = _$Button47FromJson(jsonD['button47']);
      } catch(e) {
        button47 = _$Button47FromJson({});
        ret = false;
      }
      try {
        button48 = _$Button48FromJson(jsonD['button48']);
      } catch(e) {
        button48 = _$Button48FromJson({});
        ret = false;
      }
      try {
        button49 = _$Button49FromJson(jsonD['button49']);
      } catch(e) {
        button49 = _$Button49FromJson({});
        ret = false;
      }
      try {
        button50 = _$Button50FromJson(jsonD['button50']);
      } catch(e) {
        button50 = _$Button50FromJson({});
        ret = false;
      }
      try {
        button51 = _$Button51FromJson(jsonD['button51']);
      } catch(e) {
        button51 = _$Button51FromJson({});
        ret = false;
      }
      try {
        button52 = _$Button52FromJson(jsonD['button52']);
      } catch(e) {
        button52 = _$Button52FromJson({});
        ret = false;
      }
      try {
        button53 = _$Button53FromJson(jsonD['button53']);
      } catch(e) {
        button53 = _$Button53FromJson({});
        ret = false;
      }
      try {
        button54 = _$Button54FromJson(jsonD['button54']);
      } catch(e) {
        button54 = _$Button54FromJson({});
        ret = false;
      }
      try {
        button_END = _$Button_ENDFromJson(jsonD['button_END']);
      } catch(e) {
        button_END = _$Button_ENDFromJson({});
        ret = false;
      }
      try {
        button_NEXT = _$Button_NEXTFromJson(jsonD['button_NEXT']);
      } catch(e) {
        button_NEXT = _$Button_NEXTFromJson({});
        ret = false;
      }
      try {
        button_PREV = _$Button_PREVFromJson(jsonD['button_PREV']);
      } catch(e) {
        button_PREV = _$Button_PREVFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Global global = _Global(
    title                              : "",
  );

  _Button01 button01 = _Button01(
    title                              : "",
    kind                               : "",
    section                            : "",
    type                               : "",
  );

  _Button02 button02 = _Button02(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button03 button03 = _Button03(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button04 button04 = _Button04(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button05 button05 = _Button05(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button06 button06 = _Button06(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button07 button07 = _Button07(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button08 button08 = _Button08(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button09 button09 = _Button09(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button10 button10 = _Button10(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button11 button11 = _Button11(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button12 button12 = _Button12(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button13 button13 = _Button13(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button14 button14 = _Button14(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button15 button15 = _Button15(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button16 button16 = _Button16(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button17 button17 = _Button17(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button18 button18 = _Button18(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button19 button19 = _Button19(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button20 button20 = _Button20(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button21 button21 = _Button21(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button22 button22 = _Button22(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button23 button23 = _Button23(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button24 button24 = _Button24(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button25 button25 = _Button25(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button26 button26 = _Button26(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button27 button27 = _Button27(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button28 button28 = _Button28(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button29 button29 = _Button29(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button30 button30 = _Button30(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button31 button31 = _Button31(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button32 button32 = _Button32(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button33 button33 = _Button33(
    title                              : "",
    kind                               : "",
    section                            : "",
    type                               : "",
  );

  _Button34 button34 = _Button34(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button35 button35 = _Button35(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button36 button36 = _Button36(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button37 button37 = _Button37(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button38 button38 = _Button38(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button39 button39 = _Button39(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button40 button40 = _Button40(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button41 button41 = _Button41(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button42 button42 = _Button42(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button43 button43 = _Button43(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button44 button44 = _Button44(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button45 button45 = _Button45(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button46 button46 = _Button46(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button47 button47 = _Button47(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button48 button48 = _Button48(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button49 button49 = _Button49(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button50 button50 = _Button50(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button51 button51 = _Button51(
    title                              : "",
    kind                               : 0,
    section                            : "",
    type                               : "",
  );

  _Button52 button52 = _Button52(
    title                              : "",
    kind                               : "",
    section                            : "",
    type                               : "",
  );

  _Button53 button53 = _Button53(
    title                              : "",
    kind                               : "",
    section                            : "",
    type                               : "",
  );

  _Button54 button54 = _Button54(
    title                              : "",
    kind                               : "",
    section                            : "",
    type                               : "",
  );

  _Button_END button_END = _Button_END(
    title                              : "",
    kind                               : "",
    section                            : "",
    type                               : "",
  );

  _Button_NEXT button_NEXT = _Button_NEXT(
    title                              : "",
    kind                               : "",
    section                            : "",
    type                               : "",
  );

  _Button_PREV button_PREV = _Button_PREV(
    title                              : "",
    kind                               : "",
    section                            : "",
    type                               : "",
  );
}

@JsonSerializable()
class _Global {
  factory _Global.fromJson(Map<String, dynamic> json) => _$GlobalFromJson(json);
  Map<String, dynamic> toJson() => _$GlobalToJson(this);

  _Global({
    required this.title,
  });

  @JsonKey(defaultValue: "接続機器一覧")
  String title;
}

@JsonSerializable()
class _Button01 {
  factory _Button01.fromJson(Map<String, dynamic> json) => _$Button01FromJson(json);
  Map<String, dynamic> toJson() => _$Button01ToJson(this);

  _Button01({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "使用せず")
  String title;
  @JsonKey(defaultValue: "")
  String kind;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button02 {
  factory _Button02.fromJson(Map<String, dynamic> json) => _$Button02FromJson(json);
  Map<String, dynamic> toJson() => _$Button02ToJson(this);

  _Button02({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "音声合成装置(HD AIVoice)")
  String title;
  @JsonKey(defaultValue: 14)
  int    kind;
  @JsonKey(defaultValue: "aiv")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button03 {
  factory _Button03.fromJson(Map<String, dynamic> json) => _$Button03FromJson(json);
  Map<String, dynamic> toJson() => _$Button03ToJson(this);

  _Button03({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "皿勘定(DENSO)")
  String title;
  @JsonKey(defaultValue: 13)
  int    kind;
  @JsonKey(defaultValue: "dish")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button04 {
  factory _Button04.fromJson(Map<String, dynamic> json) => _$Button04FromJson(json);
  Map<String, dynamic> toJson() => _$Button04ToJson(this);

  _Button04({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "伝票プリンタ(TM-U210B)")
  String title;
  @JsonKey(defaultValue: 8)
  int    kind;
  @JsonKey(defaultValue: "stpr")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button05 {
  factory _Button05.fromJson(Map<String, dynamic> json) => _$Button05FromJson(json);
  Map<String, dynamic> toJson() => _$Button05ToJson(this);

  _Button05({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "秤")
  String title;
  @JsonKey(defaultValue: 5)
  int    kind;
  @JsonKey(defaultValue: "scale")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button06 {
  factory _Button06.fromJson(Map<String, dynamic> json) => _$Button06FromJson(json);
  Map<String, dynamic> toJson() => _$Button06ToJson(this);

  _Button06({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "2ｽﾃｰｼｮﾝﾌﾟﾘﾝﾀ")
  String title;
  @JsonKey(defaultValue: 11)
  int    kind;
  @JsonKey(defaultValue: "s2pr")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button07 {
  factory _Button07.fromJson(Map<String, dynamic> json) => _$Button07FromJson(json);
  Map<String, dynamic> toJson() => _$Button07ToJson(this);

  _Button07({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "GP-460RC")
  String title;
  @JsonKey(defaultValue: 9)
  int    kind;
  @JsonKey(defaultValue: "gp")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button08 {
  factory _Button08.fromJson(Map<String, dynamic> json) => _$Button08FromJson(json);
  Map<String, dynamic> toJson() => _$Button08ToJson(this);

  _Button08({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "無線LAN再起動")
  String title;
  @JsonKey(defaultValue: 12)
  int    kind;
  @JsonKey(defaultValue: "pwrctrl")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button09 {
  factory _Button09.fromJson(Map<String, dynamic> json) => _$Button09FromJson(json);
  Map<String, dynamic> toJson() => _$Button09ToJson(this);

  _Button09({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "Yomoca")
  String title;
  @JsonKey(defaultValue: 17)
  int    kind;
  @JsonKey(defaultValue: "yomoca")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button10 {
  factory _Button10.fromJson(Map<String, dynamic> json) => _$Button10FromJson(json);
  Map<String, dynamic> toJson() => _$Button10ToJson(this);

  _Button10({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "自動釣銭機")
  String title;
  @JsonKey(defaultValue: 2)
  int    kind;
  @JsonKey(defaultValue: "acr")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button11 {
  factory _Button11.fromJson(Map<String, dynamic> json) => _$Button11FromJson(json);
  Map<String, dynamic> toJson() => _$Button11ToJson(this);

  _Button11({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "釣銭釣札機")
  String title;
  @JsonKey(defaultValue: 2)
  int    kind;
  @JsonKey(defaultValue: "acb")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button12 {
  factory _Button12.fromJson(Map<String, dynamic> json) => _$Button12FromJson(json);
  Map<String, dynamic> toJson() => _$Button12ToJson(this);

  _Button12({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ACR-40+RAD-S1 or ACB-20")
  String title;
  @JsonKey(defaultValue: 2)
  int    kind;
  @JsonKey(defaultValue: "acb20")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button13 {
  factory _Button13.fromJson(Map<String, dynamic> json) => _$Button13FromJson(json);
  Map<String, dynamic> toJson() => _$Button13ToJson(this);

  _Button13({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "釣銭釣札機(ACB-50)")
  String title;
  @JsonKey(defaultValue: 2)
  int    kind;
  @JsonKey(defaultValue: "acb50")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button14 {
  factory _Button14.fromJson(Map<String, dynamic> json) => _$Button14FromJson(json);
  Map<String, dynamic> toJson() => _$Button14ToJson(this);

  _Button14({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "カード決済機")
  String title;
  @JsonKey(defaultValue: 15)
  int    kind;
  @JsonKey(defaultValue: "gcat_cnct")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button15 {
  factory _Button15.fromJson(Map<String, dynamic> json) => _$Button15FromJson(json);
  Map<String, dynamic> toJson() => _$Button15ToJson(this);

  _Button15({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ｸﾞﾛｰﾘｰPSP-70C")
  String title;
  @JsonKey(defaultValue: 3)
  int    kind;
  @JsonKey(defaultValue: "psp70")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button16 {
  factory _Button16.fromJson(Map<String, dynamic> json) => _$Button16FromJson(json);
  Map<String, dynamic> toJson() => _$Button16ToJson(this);

  _Button16({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ﾘﾗｲﾄｶｰﾄﾞ  R/W")
  String title;
  @JsonKey(defaultValue: 3)
  int    kind;
  @JsonKey(defaultValue: "rewrite")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button17 {
  factory _Button17.fromJson(Map<String, dynamic> json) => _$Button17FromJson(json);
  Map<String, dynamic> toJson() => _$Button17ToJson(this);

  _Button17({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ﾋﾞｽﾏｯｸ")
  String title;
  @JsonKey(defaultValue: 3)
  int    kind;
  @JsonKey(defaultValue: "vismac")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button18 {
  factory _Button18.fromJson(Map<String, dynamic> json) => _$Button18FromJson(json);
  Map<String, dynamic> toJson() => _$Button18ToJson(this);

  _Button18({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "沖製ﾘﾗｲﾄｶｰﾄﾞ")
  String title;
  @JsonKey(defaultValue: 3)
  int    kind;
  @JsonKey(defaultValue: "orc")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button19 {
  factory _Button19.fromJson(Map<String, dynamic> json) => _$Button19FromJson(json);
  Map<String, dynamic> toJson() => _$Button19ToJson(this);

  _Button19({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ｸﾞﾛｰﾘｰPSP-60P")
  String title;
  @JsonKey(defaultValue: 3)
  int    kind;
  @JsonKey(defaultValue: "psp60")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button20 {
  factory _Button20.fromJson(Map<String, dynamic> json) => _$Button20FromJson(json);
  Map<String, dynamic> toJson() => _$Button20ToJson(this);

  _Button20({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ﾊﾟﾅｺｰﾄﾞ R/W")
  String title;
  @JsonKey(defaultValue: 3)
  int    kind;
  @JsonKey(defaultValue: "pana")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button21 {
  factory _Button21.fromJson(Map<String, dynamic> json) => _$Button21FromJson(json);
  Map<String, dynamic> toJson() => _$Button21ToJson(this);

  _Button21({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ＰＷ４１０")
  String title;
  @JsonKey(defaultValue: 3)
  int    kind;
  @JsonKey(defaultValue: "pw410")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button22 {
  factory _Button22.fromJson(Map<String, dynamic> json) => _$Button22FromJson(json);
  Map<String, dynamic> toJson() => _$Button22ToJson(this);

  _Button22({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ﾊﾟﾅｿﾆｯｸG-CAT")
  String title;
  @JsonKey(defaultValue: 15)
  int    kind;
  @JsonKey(defaultValue: "gcat")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button23 {
  factory _Button23.fromJson(Map<String, dynamic> json) => _$Button23FromJson(json);
  Map<String, dynamic> toJson() => _$Button23ToJson(this);

  _Button23({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "Edy(SIPｼﾘｰｽﾞ)")
  String title;
  @JsonKey(defaultValue: 4)
  int    kind;
  @JsonKey(defaultValue: "sip60")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button24 {
  factory _Button24.fromJson(Map<String, dynamic> json) => _$Button24FromJson(json);
  Map<String, dynamic> toJson() => _$Button24ToJson(this);

  _Button24({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "CCR")
  String title;
  @JsonKey(defaultValue: 4)
  int    kind;
  @JsonKey(defaultValue: "ccr")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button25 {
  factory _Button25.fromJson(Map<String, dynamic> json) => _$Button25FromJson(json);
  Map<String, dynamic> toJson() => _$Button25ToJson(this);

  _Button25({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ｾﾙﾌｼｽﾃﾑ秤1")
  String title;
  @JsonKey(defaultValue: 6)
  int    kind;
  @JsonKey(defaultValue: "sm_scale1")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button26 {
  factory _Button26.fromJson(Map<String, dynamic> json) => _$Button26FromJson(json);
  Map<String, dynamic> toJson() => _$Button26ToJson(this);

  _Button26({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ｾﾙﾌｼｽﾃﾑ秤2")
  String title;
  @JsonKey(defaultValue: 7)
  int    kind;
  @JsonKey(defaultValue: "sm_scale2")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button27 {
  factory _Button27.fromJson(Map<String, dynamic> json) => _$Button27FromJson(json);
  Map<String, dynamic> toJson() => _$Button27ToJson(this);

  _Button27({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ｾﾙﾌｼｽﾃﾑ秤")
  String title;
  @JsonKey(defaultValue: 10)
  int    kind;
  @JsonKey(defaultValue: "sm_scalesc")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button28 {
  factory _Button28.fromJson(Map<String, dynamic> json) => _$Button28FromJson(json);
  Map<String, dynamic> toJson() => _$Button28ToJson(this);

  _Button28({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "スキャナ")
  String title;
  @JsonKey(defaultValue: 16)
  int    kind;
  @JsonKey(defaultValue: "scan_plus_1")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button29 {
  factory _Button29.fromJson(Map<String, dynamic> json) => _$Button29FromJson(json);
  Map<String, dynamic> toJson() => _$Button29ToJson(this);

  _Button29({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "RFIDﾀｸﾞﾘｰﾀﾞﾗｲﾀ")
  String title;
  @JsonKey(defaultValue: 19)
  int    kind;
  @JsonKey(defaultValue: "rfid")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button30 {
  factory _Button30.fromJson(Map<String, dynamic> json) => _$Button30FromJson(json);
  Map<String, dynamic> toJson() => _$Button30ToJson(this);

  _Button30({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "音声合成装置(AR-STTS-01)")
  String title;
  @JsonKey(defaultValue: 14)
  int    kind;
  @JsonKey(defaultValue: "ar_stts_01")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button31 {
  factory _Button31.fromJson(Map<String, dynamic> json) => _$Button31FromJson(json);
  Map<String, dynamic> toJson() => _$Button31ToJson(this);

  _Button31({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "MCP200")
  String title;
  @JsonKey(defaultValue: 3)
  int    kind;
  @JsonKey(defaultValue: "MCP200")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button32 {
  factory _Button32.fromJson(Map<String, dynamic> json) => _$Button32FromJson(json);
  Map<String, dynamic> toJson() => _$Button32ToJson(this);

  _Button32({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "スキャナ2")
  String title;
  @JsonKey(defaultValue: 21)
  int    kind;
  @JsonKey(defaultValue: "scan_plus_2")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button33 {
  factory _Button33.fromJson(Map<String, dynamic> json) => _$Button33FromJson(json);
  Map<String, dynamic> toJson() => _$Button33ToJson(this);

  _Button33({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "")
  String title;
  @JsonKey(defaultValue: "")
  String kind;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button34 {
  factory _Button34.fromJson(Map<String, dynamic> json) => _$Button34FromJson(json);
  Map<String, dynamic> toJson() => _$Button34ToJson(this);

  _Button34({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "Smartplus")
  String title;
  @JsonKey(defaultValue: 15)
  int    kind;
  @JsonKey(defaultValue: "smtplus")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button35 {
  factory _Button35.fromJson(Map<String, dynamic> json) => _$Button35FromJson(json);
  Map<String, dynamic> toJson() => _$Button35ToJson(this);

  _Button35({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "FCLｼﾘｰｽﾞ")
  String title;
  @JsonKey(defaultValue: 20)
  int    kind;
  @JsonKey(defaultValue: "fcl")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button36 {
  factory _Button36.fromJson(Map<String, dynamic> json) => _$Button36FromJson(json);
  Map<String, dynamic> toJson() => _$Button36ToJson(this);

  _Button36({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "JREM(NCRｼﾘｰｽﾞ)")
  String title;
  @JsonKey(defaultValue: 22)
  int    kind;
  @JsonKey(defaultValue: "jrw_multi")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button37 {
  factory _Button37.fromJson(Map<String, dynamic> json) => _$Button37FromJson(json);
  Map<String, dynamic> toJson() => _$Button37ToJson(this);

  _Button37({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "Suica")
  String title;
  @JsonKey(defaultValue: 18)
  int    kind;
  @JsonKey(defaultValue: "suica")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button38 {
  factory _Button38.fromJson(Map<String, dynamic> json) => _$Button38FromJson(json);
  Map<String, dynamic> toJson() => _$Button38ToJson(this);

  _Button38({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "皿勘定(ﾀｶﾔ)")
  String title;
  @JsonKey(defaultValue: 13)
  int    kind;
  @JsonKey(defaultValue: "disht")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button39 {
  factory _Button39.fromJson(Map<String, dynamic> json) => _$Button39FromJson(json);
  Map<String, dynamic> toJson() => _$Button39ToJson(this);

  _Button39({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "日立ブルーチップ")
  String title;
  @JsonKey(defaultValue: 3)
  int    kind;
  @JsonKey(defaultValue: "ht2980")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button40 {
  factory _Button40.fromJson(Map<String, dynamic> json) => _$Button40FromJson(json);
  Map<String, dynamic> toJson() => _$Button40ToJson(this);

  _Button40({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ABS-V31")
  String title;
  @JsonKey(defaultValue: 3)
  int    kind;
  @JsonKey(defaultValue: "absv31")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button41 {
  factory _Button41.fromJson(Map<String, dynamic> json) => _$Button41FromJson(json);
  Map<String, dynamic> toJson() => _$Button41ToJson(this);

  _Button41({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "スキャナ2")
  String title;
  @JsonKey(defaultValue: 21)
  int    kind;
  @JsonKey(defaultValue: "scan_2800ip_2")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button42 {
  factory _Button42.fromJson(Map<String, dynamic> json) => _$Button42FromJson(json);
  Map<String, dynamic> toJson() => _$Button42ToJson(this);

  _Button42({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "ﾔﾏﾄ電子ﾏﾈｰ端末")
  String title;
  @JsonKey(defaultValue: 4)
  int    kind;
  @JsonKey(defaultValue: "yamato")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button43 {
  factory _Button43.fromJson(Map<String, dynamic> json) => _$Button43FromJson(json);
  Map<String, dynamic> toJson() => _$Button43ToJson(this);

  _Button43({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "CCT決済端末")
  String title;
  @JsonKey(defaultValue: 15)
  int    kind;
  @JsonKey(defaultValue: "cct")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button44 {
  factory _Button44.fromJson(Map<String, dynamic> json) => _$Button44FromJson(json);
  Map<String, dynamic> toJson() => _$Button44ToJson(this);

  _Button44({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "自走式磁気カードリーダー")
  String title;
  @JsonKey(defaultValue: 23)
  int    kind;
  @JsonKey(defaultValue: "masr")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button45 {
  factory _Button45.fromJson(Map<String, dynamic> json) => _$Button45FromJson(json);
  Map<String, dynamic> toJson() => _$Button45ToJson(this);

  _Button45({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "J-Mups決済端末")
  String title;
  @JsonKey(defaultValue: 15)
  int    kind;
  @JsonKey(defaultValue: "jmups")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button46 {
  factory _Button46.fromJson(Map<String, dynamic> json) => _$Button46FromJson(json);
  Map<String, dynamic> toJson() => _$Button46ToJson(this);

  _Button46({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "釣銭釣札機(FAL2)")
  String title;
  @JsonKey(defaultValue: 2)
  int    kind;
  @JsonKey(defaultValue: "fal2")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button47 {
  factory _Button47.fromJson(Map<String, dynamic> json) => _$Button47FromJson(json);
  Map<String, dynamic> toJson() => _$Button47ToJson(this);

  _Button47({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "MST決済端末")
  String title;
  @JsonKey(defaultValue: 4)
  int    kind;
  @JsonKey(defaultValue: "mst")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button48 {
  factory _Button48.fromJson(Map<String, dynamic> json) => _$Button48FromJson(json);
  Map<String, dynamic> toJson() => _$Button48ToJson(this);

  _Button48({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "VEGA")
  String title;
  @JsonKey(defaultValue: 24)
  int    kind;
  @JsonKey(defaultValue: "vega3000")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button49 {
  factory _Button49.fromJson(Map<String, dynamic> json) => _$Button49FromJson(json);
  Map<String, dynamic> toJson() => _$Button49ToJson(this);

  _Button49({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "CASTLES")
  String title;
  @JsonKey(defaultValue: 15)
  int    kind;
  @JsonKey(defaultValue: "castles")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button50 {
  factory _Button50.fromJson(Map<String, dynamic> json) => _$Button50FromJson(json);
  Map<String, dynamic> toJson() => _$Button50ToJson(this);

  _Button50({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "PCT決済端末")
  String title;
  @JsonKey(defaultValue: 25)
  int    kind;
  @JsonKey(defaultValue: "pct")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button51 {
  factory _Button51.fromJson(Map<String, dynamic> json) => _$Button51FromJson(json);
  Map<String, dynamic> toJson() => _$Button51ToJson(this);

  _Button51({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "重量センサー")
  String title;
  @JsonKey(defaultValue: 26)
  int    kind;
  @JsonKey(defaultValue: "scale_sks")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button52 {
  factory _Button52.fromJson(Map<String, dynamic> json) => _$Button52FromJson(json);
  Map<String, dynamic> toJson() => _$Button52ToJson(this);

  _Button52({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "")
  String title;
  @JsonKey(defaultValue: "")
  String kind;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button53 {
  factory _Button53.fromJson(Map<String, dynamic> json) => _$Button53FromJson(json);
  Map<String, dynamic> toJson() => _$Button53ToJson(this);

  _Button53({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "")
  String title;
  @JsonKey(defaultValue: "")
  String kind;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button54 {
  factory _Button54.fromJson(Map<String, dynamic> json) => _$Button54FromJson(json);
  Map<String, dynamic> toJson() => _$Button54ToJson(this);

  _Button54({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "")
  String title;
  @JsonKey(defaultValue: "")
  String kind;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "NORMAL")
  String type;
}

@JsonSerializable()
class _Button_END {
  factory _Button_END.fromJson(Map<String, dynamic> json) => _$Button_ENDFromJson(json);
  Map<String, dynamic> toJson() => _$Button_ENDToJson(this);

  _Button_END({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "終了")
  String title;
  @JsonKey(defaultValue: "")
  String kind;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "END")
  String type;
}

@JsonSerializable()
class _Button_NEXT {
  factory _Button_NEXT.fromJson(Map<String, dynamic> json) => _$Button_NEXTFromJson(json);
  Map<String, dynamic> toJson() => _$Button_NEXTToJson(this);

  _Button_NEXT({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "次頁")
  String title;
  @JsonKey(defaultValue: "")
  String kind;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "NEXTP")
  String type;
}

@JsonSerializable()
class _Button_PREV {
  factory _Button_PREV.fromJson(Map<String, dynamic> json) => _$Button_PREVFromJson(json);
  Map<String, dynamic> toJson() => _$Button_PREVToJson(this);

  _Button_PREV({
    required this.title,
    required this.kind,
    required this.section,
    required this.type,
  });

  @JsonKey(defaultValue: "前頁")
  String title;
  @JsonKey(defaultValue: "")
  String kind;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "PREVP")
  String type;
}

