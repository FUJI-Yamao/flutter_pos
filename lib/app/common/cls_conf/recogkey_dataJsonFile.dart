/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'recogkey_dataJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Recogkey_dataJsonFile extends ConfigJsonFile {
  static final Recogkey_dataJsonFile _instance = Recogkey_dataJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "recogkey_data.json";

  Recogkey_dataJsonFile(){
    setPath(_confPath, _fileName);
  }
  Recogkey_dataJsonFile._internal();

  factory Recogkey_dataJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Recogkey_dataJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Recogkey_dataJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Recogkey_dataJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        page1 = _$Page1FromJson(jsonD['page1']);
      } catch(e) {
        page1 = _$Page1FromJson({});
        ret = false;
      }
      try {
        page2 = _$Page2FromJson(jsonD['page2']);
      } catch(e) {
        page2 = _$Page2FromJson({});
        ret = false;
      }
      try {
        page3 = _$Page3FromJson(jsonD['page3']);
      } catch(e) {
        page3 = _$Page3FromJson({});
        ret = false;
      }
      try {
        page4 = _$Page4FromJson(jsonD['page4']);
      } catch(e) {
        page4 = _$Page4FromJson({});
        ret = false;
      }
      try {
        page5 = _$Page5FromJson(jsonD['page5']);
      } catch(e) {
        page5 = _$Page5FromJson({});
        ret = false;
      }
      try {
        page6 = _$Page6FromJson(jsonD['page6']);
      } catch(e) {
        page6 = _$Page6FromJson({});
        ret = false;
      }
      try {
        page7 = _$Page7FromJson(jsonD['page7']);
      } catch(e) {
        page7 = _$Page7FromJson({});
        ret = false;
      }
      try {
        page8 = _$Page8FromJson(jsonD['page8']);
      } catch(e) {
        page8 = _$Page8FromJson({});
        ret = false;
      }
      try {
        page9 = _$Page9FromJson(jsonD['page9']);
      } catch(e) {
        page9 = _$Page9FromJson({});
        ret = false;
      }
      try {
        page10 = _$Page10FromJson(jsonD['page10']);
      } catch(e) {
        page10 = _$Page10FromJson({});
        ret = false;
      }
      try {
        page11 = _$Page11FromJson(jsonD['page11']);
      } catch(e) {
        page11 = _$Page11FromJson({});
        ret = false;
      }
      try {
        page12 = _$Page12FromJson(jsonD['page12']);
      } catch(e) {
        page12 = _$Page12FromJson({});
        ret = false;
      }
      try {
        page13 = _$Page13FromJson(jsonD['page13']);
      } catch(e) {
        page13 = _$Page13FromJson({});
        ret = false;
      }
      try {
        page14 = _$Page14FromJson(jsonD['page14']);
      } catch(e) {
        page14 = _$Page14FromJson({});
        ret = false;
      }
      try {
        page15 = _$Page15FromJson(jsonD['page15']);
      } catch(e) {
        page15 = _$Page15FromJson({});
        ret = false;
      }
      try {
        page16 = _$Page16FromJson(jsonD['page16']);
      } catch(e) {
        page16 = _$Page16FromJson({});
        ret = false;
      }
      try {
        page17 = _$Page17FromJson(jsonD['page17']);
      } catch(e) {
        page17 = _$Page17FromJson({});
        ret = false;
      }
      try {
        page18 = _$Page18FromJson(jsonD['page18']);
      } catch(e) {
        page18 = _$Page18FromJson({});
        ret = false;
      }
      try {
        page19 = _$Page19FromJson(jsonD['page19']);
      } catch(e) {
        page19 = _$Page19FromJson({});
        ret = false;
      }
      try {
        page20 = _$Page20FromJson(jsonD['page20']);
      } catch(e) {
        page20 = _$Page20FromJson({});
        ret = false;
      }
      try {
        page21 = _$Page21FromJson(jsonD['page21']);
      } catch(e) {
        page21 = _$Page21FromJson({});
        ret = false;
      }
      try {
        page22 = _$Page22FromJson(jsonD['page22']);
      } catch(e) {
        page22 = _$Page22FromJson({});
        ret = false;
      }
      try {
        page23 = _$Page23FromJson(jsonD['page23']);
      } catch(e) {
        page23 = _$Page23FromJson({});
        ret = false;
      }
      try {
        page24 = _$Page24FromJson(jsonD['page24']);
      } catch(e) {
        page24 = _$Page24FromJson({});
        ret = false;
      }
      try {
        page25 = _$Page25FromJson(jsonD['page25']);
      } catch(e) {
        page25 = _$Page25FromJson({});
        ret = false;
      }
      try {
        page26 = _$Page26FromJson(jsonD['page26']);
      } catch(e) {
        page26 = _$Page26FromJson({});
        ret = false;
      }
      try {
        page27 = _$Page27FromJson(jsonD['page27']);
      } catch(e) {
        page27 = _$Page27FromJson({});
        ret = false;
      }
      try {
        page28 = _$Page28FromJson(jsonD['page28']);
      } catch(e) {
        page28 = _$Page28FromJson({});
        ret = false;
      }
      try {
        page29 = _$Page29FromJson(jsonD['page29']);
      } catch(e) {
        page29 = _$Page29FromJson({});
        ret = false;
      }
      try {
        page30 = _$Page30FromJson(jsonD['page30']);
      } catch(e) {
        page30 = _$Page30FromJson({});
        ret = false;
      }
      try {
        page31 = _$Page31FromJson(jsonD['page31']);
      } catch(e) {
        page31 = _$Page31FromJson({});
        ret = false;
      }
      try {
        page32 = _$Page32FromJson(jsonD['page32']);
      } catch(e) {
        page32 = _$Page32FromJson({});
        ret = false;
      }
      try {
        page33 = _$Page33FromJson(jsonD['page33']);
      } catch(e) {
        page33 = _$Page33FromJson({});
        ret = false;
      }
      try {
        page34 = _$Page34FromJson(jsonD['page34']);
      } catch(e) {
        page34 = _$Page34FromJson({});
        ret = false;
      }
      try {
        page35 = _$Page35FromJson(jsonD['page35']);
      } catch(e) {
        page35 = _$Page35FromJson({});
        ret = false;
      }
      try {
        page36 = _$Page36FromJson(jsonD['page36']);
      } catch(e) {
        page36 = _$Page36FromJson({});
        ret = false;
      }
      try {
        page37 = _$Page37FromJson(jsonD['page37']);
      } catch(e) {
        page37 = _$Page37FromJson({});
        ret = false;
      }
      try {
        page38 = _$Page38FromJson(jsonD['page38']);
      } catch(e) {
        page38 = _$Page38FromJson({});
        ret = false;
      }
      try {
        page39 = _$Page39FromJson(jsonD['page39']);
      } catch(e) {
        page39 = _$Page39FromJson({});
        ret = false;
      }
      try {
        page40 = _$Page40FromJson(jsonD['page40']);
      } catch(e) {
        page40 = _$Page40FromJson({});
        ret = false;
      }
      try {
        page41 = _$Page41FromJson(jsonD['page41']);
      } catch(e) {
        page41 = _$Page41FromJson({});
        ret = false;
      }
      try {
        page42 = _$Page42FromJson(jsonD['page42']);
      } catch(e) {
        page42 = _$Page42FromJson({});
        ret = false;
      }
      try {
        page43 = _$Page43FromJson(jsonD['page43']);
      } catch(e) {
        page43 = _$Page43FromJson({});
        ret = false;
      }
      try {
        page44 = _$Page44FromJson(jsonD['page44']);
      } catch(e) {
        page44 = _$Page44FromJson({});
        ret = false;
      }
      try {
        page45 = _$Page45FromJson(jsonD['page45']);
      } catch(e) {
        page45 = _$Page45FromJson({});
        ret = false;
      }
      try {
        page46 = _$Page46FromJson(jsonD['page46']);
      } catch(e) {
        page46 = _$Page46FromJson({});
        ret = false;
      }
      try {
        page47 = _$Page47FromJson(jsonD['page47']);
      } catch(e) {
        page47 = _$Page47FromJson({});
        ret = false;
      }
      try {
        page48 = _$Page48FromJson(jsonD['page48']);
      } catch(e) {
        page48 = _$Page48FromJson({});
        ret = false;
      }
      try {
        page49 = _$Page49FromJson(jsonD['page49']);
      } catch(e) {
        page49 = _$Page49FromJson({});
        ret = false;
      }
      try {
        page50 = _$Page50FromJson(jsonD['page50']);
      } catch(e) {
        page50 = _$Page50FromJson({});
        ret = false;
      }
      try {
        page51 = _$Page51FromJson(jsonD['page51']);
      } catch(e) {
        page51 = _$Page51FromJson({});
        ret = false;
      }
      try {
        page52 = _$Page52FromJson(jsonD['page52']);
      } catch(e) {
        page52 = _$Page52FromJson({});
        ret = false;
      }
      try {
        page53 = _$Page53FromJson(jsonD['page53']);
      } catch(e) {
        page53 = _$Page53FromJson({});
        ret = false;
      }
      try {
        page54 = _$Page54FromJson(jsonD['page54']);
      } catch(e) {
        page54 = _$Page54FromJson({});
        ret = false;
      }
      try {
        page55 = _$Page55FromJson(jsonD['page55']);
      } catch(e) {
        page55 = _$Page55FromJson({});
        ret = false;
      }
      try {
        page56 = _$Page56FromJson(jsonD['page56']);
      } catch(e) {
        page56 = _$Page56FromJson({});
        ret = false;
      }
      try {
        page57 = _$Page57FromJson(jsonD['page57']);
      } catch(e) {
        page57 = _$Page57FromJson({});
        ret = false;
      }
      try {
        page58 = _$Page58FromJson(jsonD['page58']);
      } catch(e) {
        page58 = _$Page58FromJson({});
        ret = false;
      }
      try {
        page59 = _$Page59FromJson(jsonD['page59']);
      } catch(e) {
        page59 = _$Page59FromJson({});
        ret = false;
      }
      try {
        page60 = _$Page60FromJson(jsonD['page60']);
      } catch(e) {
        page60 = _$Page60FromJson({});
        ret = false;
      }
      try {
        page61 = _$Page61FromJson(jsonD['page61']);
      } catch(e) {
        page61 = _$Page61FromJson({});
        ret = false;
      }
      try {
        page62 = _$Page62FromJson(jsonD['page62']);
      } catch(e) {
        page62 = _$Page62FromJson({});
        ret = false;
      }
      try {
        page63 = _$Page63FromJson(jsonD['page63']);
      } catch(e) {
        page63 = _$Page63FromJson({});
        ret = false;
      }
      try {
        page64 = _$Page64FromJson(jsonD['page64']);
      } catch(e) {
        page64 = _$Page64FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Page1 page1 = _Page1(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page2 page2 = _Page2(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page3 page3 = _Page3(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page4 page4 = _Page4(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page5 page5 = _Page5(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page6 page6 = _Page6(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page7 page7 = _Page7(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page8 page8 = _Page8(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page9 page9 = _Page9(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page10 page10 = _Page10(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page11 page11 = _Page11(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page12 page12 = _Page12(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page13 page13 = _Page13(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page14 page14 = _Page14(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page15 page15 = _Page15(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page16 page16 = _Page16(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page17 page17 = _Page17(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page18 page18 = _Page18(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page19 page19 = _Page19(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page20 page20 = _Page20(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page21 page21 = _Page21(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page22 page22 = _Page22(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page23 page23 = _Page23(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page24 page24 = _Page24(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page25 page25 = _Page25(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page26 page26 = _Page26(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page27 page27 = _Page27(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page28 page28 = _Page28(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page29 page29 = _Page29(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page30 page30 = _Page30(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page31 page31 = _Page31(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page32 page32 = _Page32(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page33 page33 = _Page33(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page34 page34 = _Page34(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page35 page35 = _Page35(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page36 page36 = _Page36(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page37 page37 = _Page37(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page38 page38 = _Page38(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page39 page39 = _Page39(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page40 page40 = _Page40(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page41 page41 = _Page41(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page42 page42 = _Page42(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page43 page43 = _Page43(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page44 page44 = _Page44(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page45 page45 = _Page45(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page46 page46 = _Page46(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page47 page47 = _Page47(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page48 page48 = _Page48(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page49 page49 = _Page49(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page50 page50 = _Page50(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page51 page51 = _Page51(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page52 page52 = _Page52(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page53 page53 = _Page53(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page54 page54 = _Page54(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page55 page55 = _Page55(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page56 page56 = _Page56(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page57 page57 = _Page57(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page58 page58 = _Page58(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page59 page59 = _Page59(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page60 page60 = _Page60(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page61 page61 = _Page61(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page62 page62 = _Page62(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page63 page63 = _Page63(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );

  _Page64 page64 = _Page64(
    password                           : "",
    fcode                              : "",
    qcjc_type                          : "",
  );
}

@JsonSerializable()
class _Page1 {
  factory _Page1.fromJson(Map<String, dynamic> json) => _$Page1FromJson(json);
  Map<String, dynamic> toJson() => _$Page1ToJson(this);

  _Page1({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page2 {
  factory _Page2.fromJson(Map<String, dynamic> json) => _$Page2FromJson(json);
  Map<String, dynamic> toJson() => _$Page2ToJson(this);

  _Page2({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page3 {
  factory _Page3.fromJson(Map<String, dynamic> json) => _$Page3FromJson(json);
  Map<String, dynamic> toJson() => _$Page3ToJson(this);

  _Page3({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page4 {
  factory _Page4.fromJson(Map<String, dynamic> json) => _$Page4FromJson(json);
  Map<String, dynamic> toJson() => _$Page4ToJson(this);

  _Page4({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page5 {
  factory _Page5.fromJson(Map<String, dynamic> json) => _$Page5FromJson(json);
  Map<String, dynamic> toJson() => _$Page5ToJson(this);

  _Page5({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page6 {
  factory _Page6.fromJson(Map<String, dynamic> json) => _$Page6FromJson(json);
  Map<String, dynamic> toJson() => _$Page6ToJson(this);

  _Page6({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000012000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page7 {
  factory _Page7.fromJson(Map<String, dynamic> json) => _$Page7FromJson(json);
  Map<String, dynamic> toJson() => _$Page7ToJson(this);

  _Page7({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page8 {
  factory _Page8.fromJson(Map<String, dynamic> json) => _$Page8FromJson(json);
  Map<String, dynamic> toJson() => _$Page8ToJson(this);

  _Page8({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page9 {
  factory _Page9.fromJson(Map<String, dynamic> json) => _$Page9FromJson(json);
  Map<String, dynamic> toJson() => _$Page9ToJson(this);

  _Page9({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page10 {
  factory _Page10.fromJson(Map<String, dynamic> json) => _$Page10FromJson(json);
  Map<String, dynamic> toJson() => _$Page10ToJson(this);

  _Page10({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page11 {
  factory _Page11.fromJson(Map<String, dynamic> json) => _$Page11FromJson(json);
  Map<String, dynamic> toJson() => _$Page11ToJson(this);

  _Page11({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page12 {
  factory _Page12.fromJson(Map<String, dynamic> json) => _$Page12FromJson(json);
  Map<String, dynamic> toJson() => _$Page12ToJson(this);

  _Page12({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page13 {
  factory _Page13.fromJson(Map<String, dynamic> json) => _$Page13FromJson(json);
  Map<String, dynamic> toJson() => _$Page13ToJson(this);

  _Page13({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page14 {
  factory _Page14.fromJson(Map<String, dynamic> json) => _$Page14FromJson(json);
  Map<String, dynamic> toJson() => _$Page14ToJson(this);

  _Page14({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page15 {
  factory _Page15.fromJson(Map<String, dynamic> json) => _$Page15FromJson(json);
  Map<String, dynamic> toJson() => _$Page15ToJson(this);

  _Page15({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page16 {
  factory _Page16.fromJson(Map<String, dynamic> json) => _$Page16FromJson(json);
  Map<String, dynamic> toJson() => _$Page16ToJson(this);

  _Page16({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page17 {
  factory _Page17.fromJson(Map<String, dynamic> json) => _$Page17FromJson(json);
  Map<String, dynamic> toJson() => _$Page17ToJson(this);

  _Page17({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page18 {
  factory _Page18.fromJson(Map<String, dynamic> json) => _$Page18FromJson(json);
  Map<String, dynamic> toJson() => _$Page18ToJson(this);

  _Page18({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page19 {
  factory _Page19.fromJson(Map<String, dynamic> json) => _$Page19FromJson(json);
  Map<String, dynamic> toJson() => _$Page19ToJson(this);

  _Page19({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page20 {
  factory _Page20.fromJson(Map<String, dynamic> json) => _$Page20FromJson(json);
  Map<String, dynamic> toJson() => _$Page20ToJson(this);

  _Page20({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page21 {
  factory _Page21.fromJson(Map<String, dynamic> json) => _$Page21FromJson(json);
  Map<String, dynamic> toJson() => _$Page21ToJson(this);

  _Page21({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page22 {
  factory _Page22.fromJson(Map<String, dynamic> json) => _$Page22FromJson(json);
  Map<String, dynamic> toJson() => _$Page22ToJson(this);

  _Page22({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page23 {
  factory _Page23.fromJson(Map<String, dynamic> json) => _$Page23FromJson(json);
  Map<String, dynamic> toJson() => _$Page23ToJson(this);

  _Page23({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page24 {
  factory _Page24.fromJson(Map<String, dynamic> json) => _$Page24FromJson(json);
  Map<String, dynamic> toJson() => _$Page24ToJson(this);

  _Page24({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page25 {
  factory _Page25.fromJson(Map<String, dynamic> json) => _$Page25FromJson(json);
  Map<String, dynamic> toJson() => _$Page25ToJson(this);

  _Page25({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page26 {
  factory _Page26.fromJson(Map<String, dynamic> json) => _$Page26FromJson(json);
  Map<String, dynamic> toJson() => _$Page26ToJson(this);

  _Page26({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page27 {
  factory _Page27.fromJson(Map<String, dynamic> json) => _$Page27FromJson(json);
  Map<String, dynamic> toJson() => _$Page27ToJson(this);

  _Page27({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page28 {
  factory _Page28.fromJson(Map<String, dynamic> json) => _$Page28FromJson(json);
  Map<String, dynamic> toJson() => _$Page28ToJson(this);

  _Page28({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page29 {
  factory _Page29.fromJson(Map<String, dynamic> json) => _$Page29FromJson(json);
  Map<String, dynamic> toJson() => _$Page29ToJson(this);

  _Page29({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page30 {
  factory _Page30.fromJson(Map<String, dynamic> json) => _$Page30FromJson(json);
  Map<String, dynamic> toJson() => _$Page30ToJson(this);

  _Page30({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page31 {
  factory _Page31.fromJson(Map<String, dynamic> json) => _$Page31FromJson(json);
  Map<String, dynamic> toJson() => _$Page31ToJson(this);

  _Page31({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page32 {
  factory _Page32.fromJson(Map<String, dynamic> json) => _$Page32FromJson(json);
  Map<String, dynamic> toJson() => _$Page32ToJson(this);

  _Page32({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page33 {
  factory _Page33.fromJson(Map<String, dynamic> json) => _$Page33FromJson(json);
  Map<String, dynamic> toJson() => _$Page33ToJson(this);

  _Page33({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page34 {
  factory _Page34.fromJson(Map<String, dynamic> json) => _$Page34FromJson(json);
  Map<String, dynamic> toJson() => _$Page34ToJson(this);

  _Page34({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page35 {
  factory _Page35.fromJson(Map<String, dynamic> json) => _$Page35FromJson(json);
  Map<String, dynamic> toJson() => _$Page35ToJson(this);

  _Page35({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page36 {
  factory _Page36.fromJson(Map<String, dynamic> json) => _$Page36FromJson(json);
  Map<String, dynamic> toJson() => _$Page36ToJson(this);

  _Page36({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page37 {
  factory _Page37.fromJson(Map<String, dynamic> json) => _$Page37FromJson(json);
  Map<String, dynamic> toJson() => _$Page37ToJson(this);

  _Page37({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page38 {
  factory _Page38.fromJson(Map<String, dynamic> json) => _$Page38FromJson(json);
  Map<String, dynamic> toJson() => _$Page38ToJson(this);

  _Page38({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page39 {
  factory _Page39.fromJson(Map<String, dynamic> json) => _$Page39FromJson(json);
  Map<String, dynamic> toJson() => _$Page39ToJson(this);

  _Page39({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page40 {
  factory _Page40.fromJson(Map<String, dynamic> json) => _$Page40FromJson(json);
  Map<String, dynamic> toJson() => _$Page40ToJson(this);

  _Page40({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page41 {
  factory _Page41.fromJson(Map<String, dynamic> json) => _$Page41FromJson(json);
  Map<String, dynamic> toJson() => _$Page41ToJson(this);

  _Page41({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page42 {
  factory _Page42.fromJson(Map<String, dynamic> json) => _$Page42FromJson(json);
  Map<String, dynamic> toJson() => _$Page42ToJson(this);

  _Page42({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page43 {
  factory _Page43.fromJson(Map<String, dynamic> json) => _$Page43FromJson(json);
  Map<String, dynamic> toJson() => _$Page43ToJson(this);

  _Page43({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page44 {
  factory _Page44.fromJson(Map<String, dynamic> json) => _$Page44FromJson(json);
  Map<String, dynamic> toJson() => _$Page44ToJson(this);

  _Page44({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page45 {
  factory _Page45.fromJson(Map<String, dynamic> json) => _$Page45FromJson(json);
  Map<String, dynamic> toJson() => _$Page45ToJson(this);

  _Page45({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page46 {
  factory _Page46.fromJson(Map<String, dynamic> json) => _$Page46FromJson(json);
  Map<String, dynamic> toJson() => _$Page46ToJson(this);

  _Page46({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page47 {
  factory _Page47.fromJson(Map<String, dynamic> json) => _$Page47FromJson(json);
  Map<String, dynamic> toJson() => _$Page47ToJson(this);

  _Page47({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page48 {
  factory _Page48.fromJson(Map<String, dynamic> json) => _$Page48FromJson(json);
  Map<String, dynamic> toJson() => _$Page48ToJson(this);

  _Page48({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page49 {
  factory _Page49.fromJson(Map<String, dynamic> json) => _$Page49FromJson(json);
  Map<String, dynamic> toJson() => _$Page49ToJson(this);

  _Page49({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page50 {
  factory _Page50.fromJson(Map<String, dynamic> json) => _$Page50FromJson(json);
  Map<String, dynamic> toJson() => _$Page50ToJson(this);

  _Page50({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page51 {
  factory _Page51.fromJson(Map<String, dynamic> json) => _$Page51FromJson(json);
  Map<String, dynamic> toJson() => _$Page51ToJson(this);

  _Page51({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page52 {
  factory _Page52.fromJson(Map<String, dynamic> json) => _$Page52FromJson(json);
  Map<String, dynamic> toJson() => _$Page52ToJson(this);

  _Page52({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page53 {
  factory _Page53.fromJson(Map<String, dynamic> json) => _$Page53FromJson(json);
  Map<String, dynamic> toJson() => _$Page53ToJson(this);

  _Page53({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page54 {
  factory _Page54.fromJson(Map<String, dynamic> json) => _$Page54FromJson(json);
  Map<String, dynamic> toJson() => _$Page54ToJson(this);

  _Page54({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page55 {
  factory _Page55.fromJson(Map<String, dynamic> json) => _$Page55FromJson(json);
  Map<String, dynamic> toJson() => _$Page55ToJson(this);

  _Page55({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page56 {
  factory _Page56.fromJson(Map<String, dynamic> json) => _$Page56FromJson(json);
  Map<String, dynamic> toJson() => _$Page56ToJson(this);

  _Page56({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page57 {
  factory _Page57.fromJson(Map<String, dynamic> json) => _$Page57FromJson(json);
  Map<String, dynamic> toJson() => _$Page57ToJson(this);

  _Page57({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page58 {
  factory _Page58.fromJson(Map<String, dynamic> json) => _$Page58FromJson(json);
  Map<String, dynamic> toJson() => _$Page58ToJson(this);

  _Page58({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page59 {
  factory _Page59.fromJson(Map<String, dynamic> json) => _$Page59FromJson(json);
  Map<String, dynamic> toJson() => _$Page59ToJson(this);

  _Page59({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page60 {
  factory _Page60.fromJson(Map<String, dynamic> json) => _$Page60FromJson(json);
  Map<String, dynamic> toJson() => _$Page60ToJson(this);

  _Page60({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page61 {
  factory _Page61.fromJson(Map<String, dynamic> json) => _$Page61FromJson(json);
  Map<String, dynamic> toJson() => _$Page61ToJson(this);

  _Page61({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page62 {
  factory _Page62.fromJson(Map<String, dynamic> json) => _$Page62FromJson(json);
  Map<String, dynamic> toJson() => _$Page62ToJson(this);

  _Page62({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page63 {
  factory _Page63.fromJson(Map<String, dynamic> json) => _$Page63FromJson(json);
  Map<String, dynamic> toJson() => _$Page63ToJson(this);

  _Page63({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

@JsonSerializable()
class _Page64 {
  factory _Page64.fromJson(Map<String, dynamic> json) => _$Page64FromJson(json);
  Map<String, dynamic> toJson() => _$Page64ToJson(this);

  _Page64({
    required this.password,
    required this.fcode,
    required this.qcjc_type,
  });

  @JsonKey(defaultValue: "")
  String password;
  @JsonKey(defaultValue: "")
  String fcode;
  @JsonKey(defaultValue: "000000000000000000")
  String qcjc_type;
}

