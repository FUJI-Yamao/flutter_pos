/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'data_restor2JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Data_restor2JsonFile extends ConfigJsonFile {
  static final Data_restor2JsonFile _instance = Data_restor2JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "data_restor2.json";

  Data_restor2JsonFile(){
    setPath(_confPath, _fileName);
  }
  Data_restor2JsonFile._internal();

  factory Data_restor2JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Data_restor2JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Data_restor2JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Data_restor2JsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        file01 = _$File01FromJson(jsonD['file01']);
      } catch(e) {
        file01 = _$File01FromJson({});
        ret = false;
      }
      try {
        file02 = _$File02FromJson(jsonD['file02']);
      } catch(e) {
        file02 = _$File02FromJson({});
        ret = false;
      }
      try {
        file03 = _$File03FromJson(jsonD['file03']);
      } catch(e) {
        file03 = _$File03FromJson({});
        ret = false;
      }
      try {
        file04 = _$File04FromJson(jsonD['file04']);
      } catch(e) {
        file04 = _$File04FromJson({});
        ret = false;
      }
      try {
        file05 = _$File05FromJson(jsonD['file05']);
      } catch(e) {
        file05 = _$File05FromJson({});
        ret = false;
      }
      try {
        file06 = _$File06FromJson(jsonD['file06']);
      } catch(e) {
        file06 = _$File06FromJson({});
        ret = false;
      }
      try {
        file07 = _$File07FromJson(jsonD['file07']);
      } catch(e) {
        file07 = _$File07FromJson({});
        ret = false;
      }
      try {
        file08 = _$File08FromJson(jsonD['file08']);
      } catch(e) {
        file08 = _$File08FromJson({});
        ret = false;
      }
      try {
        file09 = _$File09FromJson(jsonD['file09']);
      } catch(e) {
        file09 = _$File09FromJson({});
        ret = false;
      }
      try {
        file10 = _$File10FromJson(jsonD['file10']);
      } catch(e) {
        file10 = _$File10FromJson({});
        ret = false;
      }
      try {
        file11 = _$File11FromJson(jsonD['file11']);
      } catch(e) {
        file11 = _$File11FromJson({});
        ret = false;
      }
      try {
        file12 = _$File12FromJson(jsonD['file12']);
      } catch(e) {
        file12 = _$File12FromJson({});
        ret = false;
      }
      try {
        file13 = _$File13FromJson(jsonD['file13']);
      } catch(e) {
        file13 = _$File13FromJson({});
        ret = false;
      }
      try {
        file14 = _$File14FromJson(jsonD['file14']);
      } catch(e) {
        file14 = _$File14FromJson({});
        ret = false;
      }
      try {
        file15 = _$File15FromJson(jsonD['file15']);
      } catch(e) {
        file15 = _$File15FromJson({});
        ret = false;
      }
      try {
        file16 = _$File16FromJson(jsonD['file16']);
      } catch(e) {
        file16 = _$File16FromJson({});
        ret = false;
      }
      try {
        file17 = _$File17FromJson(jsonD['file17']);
      } catch(e) {
        file17 = _$File17FromJson({});
        ret = false;
      }
      try {
        file18 = _$File18FromJson(jsonD['file18']);
      } catch(e) {
        file18 = _$File18FromJson({});
        ret = false;
      }
      try {
        file19 = _$File19FromJson(jsonD['file19']);
      } catch(e) {
        file19 = _$File19FromJson({});
        ret = false;
      }
      try {
        file20 = _$File20FromJson(jsonD['file20']);
      } catch(e) {
        file20 = _$File20FromJson({});
        ret = false;
      }
      try {
        file21 = _$File21FromJson(jsonD['file21']);
      } catch(e) {
        file21 = _$File21FromJson({});
        ret = false;
      }
      try {
        file22 = _$File22FromJson(jsonD['file22']);
      } catch(e) {
        file22 = _$File22FromJson({});
        ret = false;
      }
      try {
        file23 = _$File23FromJson(jsonD['file23']);
      } catch(e) {
        file23 = _$File23FromJson({});
        ret = false;
      }
      try {
        file24 = _$File24FromJson(jsonD['file24']);
      } catch(e) {
        file24 = _$File24FromJson({});
        ret = false;
      }
      try {
        file25 = _$File25FromJson(jsonD['file25']);
      } catch(e) {
        file25 = _$File25FromJson({});
        ret = false;
      }
      try {
        file26 = _$File26FromJson(jsonD['file26']);
      } catch(e) {
        file26 = _$File26FromJson({});
        ret = false;
      }
      try {
        file27 = _$File27FromJson(jsonD['file27']);
      } catch(e) {
        file27 = _$File27FromJson({});
        ret = false;
      }
      try {
        file28 = _$File28FromJson(jsonD['file28']);
      } catch(e) {
        file28 = _$File28FromJson({});
        ret = false;
      }
      try {
        file29 = _$File29FromJson(jsonD['file29']);
      } catch(e) {
        file29 = _$File29FromJson({});
        ret = false;
      }
      try {
        file30 = _$File30FromJson(jsonD['file30']);
      } catch(e) {
        file30 = _$File30FromJson({});
        ret = false;
      }
      try {
        file31 = _$File31FromJson(jsonD['file31']);
      } catch(e) {
        file31 = _$File31FromJson({});
        ret = false;
      }
      try {
        file32 = _$File32FromJson(jsonD['file32']);
      } catch(e) {
        file32 = _$File32FromJson({});
        ret = false;
      }
      try {
        file33 = _$File33FromJson(jsonD['file33']);
      } catch(e) {
        file33 = _$File33FromJson({});
        ret = false;
      }
      try {
        file34 = _$File34FromJson(jsonD['file34']);
      } catch(e) {
        file34 = _$File34FromJson({});
        ret = false;
      }
      try {
        file35 = _$File35FromJson(jsonD['file35']);
      } catch(e) {
        file35 = _$File35FromJson({});
        ret = false;
      }
      try {
        file36 = _$File36FromJson(jsonD['file36']);
      } catch(e) {
        file36 = _$File36FromJson({});
        ret = false;
      }
      try {
        file37 = _$File37FromJson(jsonD['file37']);
      } catch(e) {
        file37 = _$File37FromJson({});
        ret = false;
      }
      try {
        file38 = _$File38FromJson(jsonD['file38']);
      } catch(e) {
        file38 = _$File38FromJson({});
        ret = false;
      }
      try {
        file39 = _$File39FromJson(jsonD['file39']);
      } catch(e) {
        file39 = _$File39FromJson({});
        ret = false;
      }
      try {
        file40 = _$File40FromJson(jsonD['file40']);
      } catch(e) {
        file40 = _$File40FromJson({});
        ret = false;
      }
      try {
        file41 = _$File41FromJson(jsonD['file41']);
      } catch(e) {
        file41 = _$File41FromJson({});
        ret = false;
      }
      try {
        file42 = _$File42FromJson(jsonD['file42']);
      } catch(e) {
        file42 = _$File42FromJson({});
        ret = false;
      }
      try {
        file43 = _$File43FromJson(jsonD['file43']);
      } catch(e) {
        file43 = _$File43FromJson({});
        ret = false;
      }
      try {
        file44 = _$File44FromJson(jsonD['file44']);
      } catch(e) {
        file44 = _$File44FromJson({});
        ret = false;
      }
      try {
        file45 = _$File45FromJson(jsonD['file45']);
      } catch(e) {
        file45 = _$File45FromJson({});
        ret = false;
      }
      try {
        file46 = _$File46FromJson(jsonD['file46']);
      } catch(e) {
        file46 = _$File46FromJson({});
        ret = false;
      }
      try {
        file47 = _$File47FromJson(jsonD['file47']);
      } catch(e) {
        file47 = _$File47FromJson({});
        ret = false;
      }
      try {
        file48 = _$File48FromJson(jsonD['file48']);
      } catch(e) {
        file48 = _$File48FromJson({});
        ret = false;
      }
      try {
        file49 = _$File49FromJson(jsonD['file49']);
      } catch(e) {
        file49 = _$File49FromJson({});
        ret = false;
      }
      try {
        file50 = _$File50FromJson(jsonD['file50']);
      } catch(e) {
        file50 = _$File50FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _File01 file01 = _File01(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File02 file02 = _File02(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File03 file03 = _File03(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File04 file04 = _File04(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File05 file05 = _File05(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File06 file06 = _File06(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File07 file07 = _File07(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File08 file08 = _File08(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File09 file09 = _File09(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File10 file10 = _File10(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File11 file11 = _File11(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File12 file12 = _File12(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File13 file13 = _File13(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File14 file14 = _File14(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File15 file15 = _File15(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File16 file16 = _File16(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File17 file17 = _File17(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File18 file18 = _File18(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File19 file19 = _File19(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File20 file20 = _File20(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File21 file21 = _File21(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File22 file22 = _File22(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File23 file23 = _File23(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File24 file24 = _File24(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File25 file25 = _File25(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File26 file26 = _File26(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File27 file27 = _File27(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File28 file28 = _File28(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File29 file29 = _File29(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File30 file30 = _File30(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File31 file31 = _File31(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File32 file32 = _File32(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File33 file33 = _File33(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File34 file34 = _File34(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File35 file35 = _File35(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File36 file36 = _File36(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File37 file37 = _File37(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File38 file38 = _File38(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File39 file39 = _File39(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File40 file40 = _File40(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File41 file41 = _File41(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File42 file42 = _File42(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File43 file43 = _File43(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File44 file44 = _File44(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File45 file45 = _File45(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File46 file46 = _File46(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File47 file47 = _File47(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File48 file48 = _File48(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File49 file49 = _File49(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );

  _File50 file50 = _File50(
    typ                                : 0,
    name                               : "",
    src                                : "",
  );
}

@JsonSerializable()
class _File01 {
  factory _File01.fromJson(Map<String, dynamic> json) => _$File01FromJson(json);
  Map<String, dynamic> toJson() => _$File01ToJson(this);

  _File01({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "absv31.json")
  String name;
  @JsonKey(defaultValue: "conf/absv31.json")
  String src;
}

@JsonSerializable()
class _File02 {
  factory _File02.fromJson(Map<String, dynamic> json) => _$File02FromJson(json);
  Map<String, dynamic> toJson() => _$File02ToJson(this);

  _File02({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "acb.json")
  String name;
  @JsonKey(defaultValue: "conf/acb.json")
  String src;
}

@JsonSerializable()
class _File03 {
  factory _File03.fromJson(Map<String, dynamic> json) => _$File03FromJson(json);
  Map<String, dynamic> toJson() => _$File03ToJson(this);

  _File03({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "acb20.json")
  String name;
  @JsonKey(defaultValue: "conf/acb20.json")
  String src;
}

@JsonSerializable()
class _File04 {
  factory _File04.fromJson(Map<String, dynamic> json) => _$File04FromJson(json);
  Map<String, dynamic> toJson() => _$File04ToJson(this);

  _File04({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "acb50.json")
  String name;
  @JsonKey(defaultValue: "conf/acb50.json")
  String src;
}

@JsonSerializable()
class _File05 {
  factory _File05.fromJson(Map<String, dynamic> json) => _$File05FromJson(json);
  Map<String, dynamic> toJson() => _$File05ToJson(this);

  _File05({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "acr.json")
  String name;
  @JsonKey(defaultValue: "conf/acr.json")
  String src;
}

@JsonSerializable()
class _File06 {
  factory _File06.fromJson(Map<String, dynamic> json) => _$File06FromJson(json);
  Map<String, dynamic> toJson() => _$File06ToJson(this);

  _File06({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "aiv.json")
  String name;
  @JsonKey(defaultValue: "conf/aiv.json")
  String src;
}

@JsonSerializable()
class _File07 {
  factory _File07.fromJson(Map<String, dynamic> json) => _$File07FromJson(json);
  Map<String, dynamic> toJson() => _$File07ToJson(this);

  _File07({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "ar_stts_01.json")
  String name;
  @JsonKey(defaultValue: "conf/ar_stts_01.json")
  String src;
}

@JsonSerializable()
class _File08 {
  factory _File08.fromJson(Map<String, dynamic> json) => _$File08FromJson(json);
  Map<String, dynamic> toJson() => _$File08ToJson(this);

  _File08({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "ccr.json")
  String name;
  @JsonKey(defaultValue: "conf/ccr.json")
  String src;
}

@JsonSerializable()
class _File09 {
  factory _File09.fromJson(Map<String, dynamic> json) => _$File09FromJson(json);
  Map<String, dynamic> toJson() => _$File09ToJson(this);

  _File09({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "cct.json")
  String name;
  @JsonKey(defaultValue: "conf/cct.json")
  String src;
}

@JsonSerializable()
class _File10 {
  factory _File10.fromJson(Map<String, dynamic> json) => _$File10FromJson(json);
  Map<String, dynamic> toJson() => _$File10ToJson(this);

  _File10({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "dish.json")
  String name;
  @JsonKey(defaultValue: "conf/dish.json")
  String src;
}

@JsonSerializable()
class _File11 {
  factory _File11.fromJson(Map<String, dynamic> json) => _$File11FromJson(json);
  Map<String, dynamic> toJson() => _$File11ToJson(this);

  _File11({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "disht.json")
  String name;
  @JsonKey(defaultValue: "conf/disht.json")
  String src;
}

@JsonSerializable()
class _File12 {
  factory _File12.fromJson(Map<String, dynamic> json) => _$File12FromJson(json);
  Map<String, dynamic> toJson() => _$File12ToJson(this);

  _File12({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "fal2.json")
  String name;
  @JsonKey(defaultValue: "conf/fal2.json")
  String src;
}

@JsonSerializable()
class _File13 {
  factory _File13.fromJson(Map<String, dynamic> json) => _$File13FromJson(json);
  Map<String, dynamic> toJson() => _$File13ToJson(this);

  _File13({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "fcl.json")
  String name;
  @JsonKey(defaultValue: "conf/fcl.json")
  String src;
}

@JsonSerializable()
class _File14 {
  factory _File14.fromJson(Map<String, dynamic> json) => _$File14FromJson(json);
  Map<String, dynamic> toJson() => _$File14ToJson(this);

  _File14({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "gcat_cnct.json")
  String name;
  @JsonKey(defaultValue: "conf/gcat_cnct.json")
  String src;
}

@JsonSerializable()
class _File15 {
  factory _File15.fromJson(Map<String, dynamic> json) => _$File15FromJson(json);
  Map<String, dynamic> toJson() => _$File15ToJson(this);

  _File15({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "gp.json")
  String name;
  @JsonKey(defaultValue: "conf/gp.json")
  String src;
}

@JsonSerializable()
class _File16 {
  factory _File16.fromJson(Map<String, dynamic> json) => _$File16FromJson(json);
  Map<String, dynamic> toJson() => _$File16ToJson(this);

  _File16({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "ht2980.json")
  String name;
  @JsonKey(defaultValue: "conf/ht2980.json")
  String src;
}

@JsonSerializable()
class _File17 {
  factory _File17.fromJson(Map<String, dynamic> json) => _$File17FromJson(json);
  Map<String, dynamic> toJson() => _$File17ToJson(this);

  _File17({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "iccard.json")
  String name;
  @JsonKey(defaultValue: "conf/iccard.json")
  String src;
}

@JsonSerializable()
class _File18 {
  factory _File18.fromJson(Map<String, dynamic> json) => _$File18FromJson(json);
  Map<String, dynamic> toJson() => _$File18ToJson(this);

  _File18({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "j_debit.json")
  String name;
  @JsonKey(defaultValue: "conf/j_debit.json")
  String src;
}

@JsonSerializable()
class _File19 {
  factory _File19.fromJson(Map<String, dynamic> json) => _$File19FromJson(json);
  Map<String, dynamic> toJson() => _$File19ToJson(this);

  _File19({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "jmups.json")
  String name;
  @JsonKey(defaultValue: "conf/jmups.json")
  String src;
}

@JsonSerializable()
class _File20 {
  factory _File20.fromJson(Map<String, dynamic> json) => _$File20FromJson(json);
  Map<String, dynamic> toJson() => _$File20ToJson(this);

  _File20({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "jrw_multi.json")
  String name;
  @JsonKey(defaultValue: "conf/jrw_multi.json")
  String src;
}

@JsonSerializable()
class _File21 {
  factory _File21.fromJson(Map<String, dynamic> json) => _$File21FromJson(json);
  Map<String, dynamic> toJson() => _$File21ToJson(this);

  _File21({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "masr.json")
  String name;
  @JsonKey(defaultValue: "conf/masr.json")
  String src;
}

@JsonSerializable()
class _File22 {
  factory _File22.fromJson(Map<String, dynamic> json) => _$File22FromJson(json);
  Map<String, dynamic> toJson() => _$File22ToJson(this);

  _File22({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "mcp200.json")
  String name;
  @JsonKey(defaultValue: "conf/mcp200.json")
  String src;
}

@JsonSerializable()
class _File23 {
  factory _File23.fromJson(Map<String, dynamic> json) => _$File23FromJson(json);
  Map<String, dynamic> toJson() => _$File23ToJson(this);

  _File23({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "orc.json")
  String name;
  @JsonKey(defaultValue: "conf/orc.json")
  String src;
}

@JsonSerializable()
class _File24 {
  factory _File24.fromJson(Map<String, dynamic> json) => _$File24FromJson(json);
  Map<String, dynamic> toJson() => _$File24ToJson(this);

  _File24({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "pana.json")
  String name;
  @JsonKey(defaultValue: "conf/pana.json")
  String src;
}

@JsonSerializable()
class _File25 {
  factory _File25.fromJson(Map<String, dynamic> json) => _$File25FromJson(json);
  Map<String, dynamic> toJson() => _$File25ToJson(this);

  _File25({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "pana_gcat.json")
  String name;
  @JsonKey(defaultValue: "conf/pana_gcat.json")
  String src;
}

@JsonSerializable()
class _File26 {
  factory _File26.fromJson(Map<String, dynamic> json) => _$File26FromJson(json);
  Map<String, dynamic> toJson() => _$File26ToJson(this);

  _File26({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "psp60.json")
  String name;
  @JsonKey(defaultValue: "conf/psp60.json")
  String src;
}

@JsonSerializable()
class _File27 {
  factory _File27.fromJson(Map<String, dynamic> json) => _$File27FromJson(json);
  Map<String, dynamic> toJson() => _$File27ToJson(this);

  _File27({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "psp70.json")
  String name;
  @JsonKey(defaultValue: "conf/psp70.json")
  String src;
}

@JsonSerializable()
class _File28 {
  factory _File28.fromJson(Map<String, dynamic> json) => _$File28FromJson(json);
  Map<String, dynamic> toJson() => _$File28ToJson(this);

  _File28({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "pw410.json")
  String name;
  @JsonKey(defaultValue: "conf/pw410.json")
  String src;
}

@JsonSerializable()
class _File29 {
  factory _File29.fromJson(Map<String, dynamic> json) => _$File29FromJson(json);
  Map<String, dynamic> toJson() => _$File29ToJson(this);

  _File29({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "pwrctrl.json")
  String name;
  @JsonKey(defaultValue: "conf/pwrctrl.json")
  String src;
}

@JsonSerializable()
class _File30 {
  factory _File30.fromJson(Map<String, dynamic> json) => _$File30FromJson(json);
  Map<String, dynamic> toJson() => _$File30ToJson(this);

  _File30({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "rewrite_card.json")
  String name;
  @JsonKey(defaultValue: "conf/rewrite_card.json")
  String src;
}

@JsonSerializable()
class _File31 {
  factory _File31.fromJson(Map<String, dynamic> json) => _$File31FromJson(json);
  Map<String, dynamic> toJson() => _$File31ToJson(this);

  _File31({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "rfid.json")
  String name;
  @JsonKey(defaultValue: "conf/rfid.json")
  String src;
}

@JsonSerializable()
class _File32 {
  factory _File32.fromJson(Map<String, dynamic> json) => _$File32FromJson(json);
  Map<String, dynamic> toJson() => _$File32ToJson(this);

  _File32({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "s2pr.json")
  String name;
  @JsonKey(defaultValue: "conf/s2pr.json")
  String src;
}

@JsonSerializable()
class _File33 {
  factory _File33.fromJson(Map<String, dynamic> json) => _$File33FromJson(json);
  Map<String, dynamic> toJson() => _$File33ToJson(this);

  _File33({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "scale.json")
  String name;
  @JsonKey(defaultValue: "conf/scale.json")
  String src;
}

@JsonSerializable()
class _File34 {
  factory _File34.fromJson(Map<String, dynamic> json) => _$File34FromJson(json);
  Map<String, dynamic> toJson() => _$File34ToJson(this);

  _File34({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "sg_scale1.json")
  String name;
  @JsonKey(defaultValue: "conf/sg_scale1.json")
  String src;
}

@JsonSerializable()
class _File35 {
  factory _File35.fromJson(Map<String, dynamic> json) => _$File35FromJson(json);
  Map<String, dynamic> toJson() => _$File35ToJson(this);

  _File35({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "sg_scale2.json")
  String name;
  @JsonKey(defaultValue: "conf/sg_scale2.json")
  String src;
}

@JsonSerializable()
class _File36 {
  factory _File36.fromJson(Map<String, dynamic> json) => _$File36FromJson(json);
  Map<String, dynamic> toJson() => _$File36ToJson(this);

  _File36({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "sip60.json")
  String name;
  @JsonKey(defaultValue: "conf/sip60.json")
  String src;
}

@JsonSerializable()
class _File37 {
  factory _File37.fromJson(Map<String, dynamic> json) => _$File37FromJson(json);
  Map<String, dynamic> toJson() => _$File37ToJson(this);

  _File37({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "sm_scale1.json")
  String name;
  @JsonKey(defaultValue: "conf/sm_scale1.json")
  String src;
}

@JsonSerializable()
class _File38 {
  factory _File38.fromJson(Map<String, dynamic> json) => _$File38FromJson(json);
  Map<String, dynamic> toJson() => _$File38ToJson(this);

  _File38({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "sm_scale2.json")
  String name;
  @JsonKey(defaultValue: "conf/sm_scale2.json")
  String src;
}

@JsonSerializable()
class _File39 {
  factory _File39.fromJson(Map<String, dynamic> json) => _$File39FromJson(json);
  Map<String, dynamic> toJson() => _$File39ToJson(this);

  _File39({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "sm_scalesc.json")
  String name;
  @JsonKey(defaultValue: "conf/sm_scalesc.json")
  String src;
}

@JsonSerializable()
class _File40 {
  factory _File40.fromJson(Map<String, dynamic> json) => _$File40FromJson(json);
  Map<String, dynamic> toJson() => _$File40ToJson(this);

  _File40({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "sm_scalesc_scl.json")
  String name;
  @JsonKey(defaultValue: "conf/sm_scalesc_scl.json")
  String src;
}

@JsonSerializable()
class _File41 {
  factory _File41.fromJson(Map<String, dynamic> json) => _$File41FromJson(json);
  Map<String, dynamic> toJson() => _$File41ToJson(this);

  _File41({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "sm_scalesc_signp.json")
  String name;
  @JsonKey(defaultValue: "conf/sm_scalesc_signp.json")
  String src;
}

@JsonSerializable()
class _File42 {
  factory _File42.fromJson(Map<String, dynamic> json) => _$File42FromJson(json);
  Map<String, dynamic> toJson() => _$File42ToJson(this);

  _File42({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "smtplus.json")
  String name;
  @JsonKey(defaultValue: "conf/smtplus.json")
  String src;
}

@JsonSerializable()
class _File43 {
  factory _File43.fromJson(Map<String, dynamic> json) => _$File43FromJson(json);
  Map<String, dynamic> toJson() => _$File43ToJson(this);

  _File43({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "sprocket_prn.json")
  String name;
  @JsonKey(defaultValue: "conf/sprocket_prn.json")
  String src;
}

@JsonSerializable()
class _File44 {
  factory _File44.fromJson(Map<String, dynamic> json) => _$File44FromJson(json);
  Map<String, dynamic> toJson() => _$File44ToJson(this);

  _File44({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "sqrc_spec.json")
  String name;
  @JsonKey(defaultValue: "conf/sqrc_spec.json")
  String src;
}

@JsonSerializable()
class _File45 {
  factory _File45.fromJson(Map<String, dynamic> json) => _$File45FromJson(json);
  Map<String, dynamic> toJson() => _$File45ToJson(this);

  _File45({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "stpr.json")
  String name;
  @JsonKey(defaultValue: "conf/stpr.json")
  String src;
}

@JsonSerializable()
class _File46 {
  factory _File46.fromJson(Map<String, dynamic> json) => _$File46FromJson(json);
  Map<String, dynamic> toJson() => _$File46ToJson(this);

  _File46({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "suica_cnct.json")
  String name;
  @JsonKey(defaultValue: "conf/suica_cnct.json")
  String src;
}

@JsonSerializable()
class _File47 {
  factory _File47.fromJson(Map<String, dynamic> json) => _$File47FromJson(json);
  Map<String, dynamic> toJson() => _$File47ToJson(this);

  _File47({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "vismac.json")
  String name;
  @JsonKey(defaultValue: "conf/vismac.json")
  String src;
}

@JsonSerializable()
class _File48 {
  factory _File48.fromJson(Map<String, dynamic> json) => _$File48FromJson(json);
  Map<String, dynamic> toJson() => _$File48ToJson(this);

  _File48({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "yamato.json")
  String name;
  @JsonKey(defaultValue: "conf/yamato.json")
  String src;
}

@JsonSerializable()
class _File49 {
  factory _File49.fromJson(Map<String, dynamic> json) => _$File49FromJson(json);
  Map<String, dynamic> toJson() => _$File49ToJson(this);

  _File49({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "yomoca.json")
  String name;
  @JsonKey(defaultValue: "conf/yomoca.json")
  String src;
}

@JsonSerializable()
class _File50 {
  factory _File50.fromJson(Map<String, dynamic> json) => _$File50FromJson(json);
  Map<String, dynamic> toJson() => _$File50ToJson(this);

  _File50({
    required this.typ,
    required this.name,
    required this.src,
  });

  @JsonKey(defaultValue: 40)
  int    typ;
  @JsonKey(defaultValue: "rfid_utr.json")
  String name;
  @JsonKey(defaultValue: "conf/rfid_utr.json")
  String src;
}

