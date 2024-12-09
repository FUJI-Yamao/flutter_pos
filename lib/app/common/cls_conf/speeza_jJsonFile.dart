/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'speeza_jJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Speeza_jJsonFile extends ConfigJsonFile {
  static final Speeza_jJsonFile _instance = Speeza_jJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "speeza_j.json";

  Speeza_jJsonFile(){
    setPath(_confPath, _fileName);
  }
  Speeza_jJsonFile._internal();

  factory Speeza_jJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Speeza_jJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Speeza_jJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Speeza_jJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        common = _$CommonFromJson(jsonD['common']);
      } catch(e) {
        common = _$CommonFromJson({});
        ret = false;
      }
      try {
        screen0 = _$Screen0FromJson(jsonD['screen0']);
      } catch(e) {
        screen0 = _$Screen0FromJson({});
        ret = false;
      }
      try {
        screen1 = _$Screen1FromJson(jsonD['screen1']);
      } catch(e) {
        screen1 = _$Screen1FromJson({});
        ret = false;
      }
      try {
        screen2 = _$Screen2FromJson(jsonD['screen2']);
      } catch(e) {
        screen2 = _$Screen2FromJson({});
        ret = false;
      }
      try {
        screen3 = _$Screen3FromJson(jsonD['screen3']);
      } catch(e) {
        screen3 = _$Screen3FromJson({});
        ret = false;
      }
      try {
        screen4 = _$Screen4FromJson(jsonD['screen4']);
      } catch(e) {
        screen4 = _$Screen4FromJson({});
        ret = false;
      }
      try {
        screen5 = _$Screen5FromJson(jsonD['screen5']);
      } catch(e) {
        screen5 = _$Screen5FromJson({});
        ret = false;
      }
      try {
        screen6 = _$Screen6FromJson(jsonD['screen6']);
      } catch(e) {
        screen6 = _$Screen6FromJson({});
        ret = false;
      }
      try {
        screen7 = _$Screen7FromJson(jsonD['screen7']);
      } catch(e) {
        screen7 = _$Screen7FromJson({});
        ret = false;
      }
      try {
        screen8 = _$Screen8FromJson(jsonD['screen8']);
      } catch(e) {
        screen8 = _$Screen8FromJson({});
        ret = false;
      }
      try {
        screen9 = _$Screen9FromJson(jsonD['screen9']);
      } catch(e) {
        screen9 = _$Screen9FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Common common = _Common(
    page_max                           : 0,
  );

  _Screen0 screen0 = _Screen0(
    title                              : "",
    line1                              : "",
    line2                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line1_cn                           : "",
    line2_cn                           : "",
    line1_kor                          : "",
    line2_kor                          : "",
    msg1                               : "",
    msg2                               : "",
    msg3                               : "",
    msg4                               : "",
    msg1_ex                            : "",
    msg2_ex                            : "",
    msg3_ex                            : "",
    msg4_ex                            : "",
    msg1_cn                            : "",
    msg2_cn                            : "",
    msg3_cn                            : "",
    msg4_cn                            : "",
    msg1_kor                           : "",
    msg2_kor                           : "",
    msg3_kor                           : "",
    msg4_kor                           : "",
    etc1                               : "",
    etc2                               : "",
    etc3                               : "",
    etc4                               : "",
    etc5                               : "",
    etc1_ex                            : "",
    etc2_ex                            : "",
    etc3_ex                            : "",
    etc4_ex                            : "",
    etc5_ex                            : "",
    etc1_cn                            : "",
    etc2_cn                            : "",
    etc3_cn                            : "",
    etc4_cn                            : "",
    etc5_cn                            : "",
    etc1_kor                           : "",
    etc2_kor                           : "",
    etc3_kor                           : "",
    etc4_kor                           : "",
    etc5_kor                           : "",
  );

  _Screen1 screen1 = _Screen1(
    title                              : "",
    line1                              : "",
    line2                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line1_cn                           : "",
    line2_cn                           : "",
    line1_kor                          : "",
    line2_kor                          : "",
    msg1                               : "",
    msg2                               : "",
    msg3                               : "",
    msg4                               : "",
    msg1_ex                            : "",
    msg2_ex                            : "",
    msg3_ex                            : "",
    msg4_ex                            : "",
    msg1_cn                            : "",
    msg2_cn                            : "",
    msg3_cn                            : "",
    msg4_cn                            : "",
    msg1_kor                           : "",
    msg2_kor                           : "",
    msg3_kor                           : "",
    msg4_kor                           : "",
    etc1                               : "",
    etc2                               : "",
    etc3                               : "",
    etc4                               : "",
    etc5                               : "",
    etc1_ex                            : "",
    etc2_ex                            : "",
    etc3_ex                            : "",
    etc4_ex                            : "",
    etc5_ex                            : "",
    etc1_cn                            : "",
    etc2_cn                            : "",
    etc3_cn                            : "",
    etc4_cn                            : "",
    etc5_cn                            : "",
    etc1_kor                           : "",
    etc2_kor                           : "",
    etc3_kor                           : "",
    etc4_kor                           : "",
    etc5_kor                           : "",
  );

  _Screen2 screen2 = _Screen2(
    title                              : "",
    line1                              : "",
    line2                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line1_cn                           : "",
    line2_cn                           : "",
    line1_kor                          : "",
    line2_kor                          : "",
    msg1                               : "",
    msg2                               : "",
    msg3                               : "",
    msg4                               : "",
    msg1_ex                            : "",
    msg2_ex                            : "",
    msg3_ex                            : "",
    msg4_ex                            : "",
    msg1_cn                            : "",
    msg2_cn                            : "",
    msg3_cn                            : "",
    msg4_cn                            : "",
    msg1_kor                           : "",
    msg2_kor                           : "",
    msg3_kor                           : "",
    msg4_kor                           : "",
    etc1                               : "",
    etc2                               : "",
    etc3                               : "",
    etc4                               : "",
    etc5                               : "",
    etc1_ex                            : "",
    etc2_ex                            : "",
    etc3_ex                            : "",
    etc4_ex                            : "",
    etc5_ex                            : "",
    etc1_cn                            : "",
    etc2_cn                            : "",
    etc3_cn                            : "",
    etc4_cn                            : "",
    etc5_cn                            : "",
    etc1_kor                           : "",
    etc2_kor                           : "",
    etc3_kor                           : "",
    etc4_kor                           : "",
    etc5_kor                           : "",
  );

  _Screen3 screen3 = _Screen3(
    title                              : "",
    line1                              : "",
    line2                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line1_cn                           : "",
    line2_cn                           : "",
    line1_kor                          : "",
    line2_kor                          : "",
    msg1                               : "",
    msg2                               : "",
    msg3                               : "",
    msg4                               : "",
    msg1_ex                            : "",
    msg2_ex                            : "",
    msg3_ex                            : "",
    msg4_ex                            : "",
    msg1_cn                            : "",
    msg2_cn                            : "",
    msg3_cn                            : "",
    msg4_cn                            : "",
    msg1_kor                           : "",
    msg2_kor                           : "",
    msg3_kor                           : "",
    msg4_kor                           : "",
    etc1                               : "",
    etc2                               : "",
    etc3                               : "",
    etc4                               : "",
    etc5                               : "",
    etc1_ex                            : "",
    etc2_ex                            : "",
    etc3_ex                            : "",
    etc4_ex                            : "",
    etc5_ex                            : "",
    etc1_cn                            : "",
    etc2_cn                            : "",
    etc3_cn                            : "",
    etc4_cn                            : "",
    etc5_cn                            : "",
    etc1_kor                           : "",
    etc2_kor                           : "",
    etc3_kor                           : "",
    etc4_kor                           : "",
    etc5_kor                           : "",
  );

  _Screen4 screen4 = _Screen4(
    title                              : "",
    line1                              : "",
    line2                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line1_cn                           : "",
    line2_cn                           : "",
    line1_kor                          : "",
    line2_kor                          : "",
    msg1                               : "",
    msg2                               : "",
    msg3                               : "",
    msg4                               : "",
    msg1_ex                            : "",
    msg2_ex                            : "",
    msg3_ex                            : "",
    msg4_ex                            : "",
    msg1_cn                            : "",
    msg2_cn                            : "",
    msg3_cn                            : "",
    msg4_cn                            : "",
    msg1_kor                           : "",
    msg2_kor                           : "",
    msg3_kor                           : "",
    msg4_kor                           : "",
    etc1                               : "",
    etc2                               : "",
    etc3                               : "",
    etc4                               : "",
    etc5                               : "",
    etc1_ex                            : "",
    etc2_ex                            : "",
    etc3_ex                            : "",
    etc4_ex                            : "",
    etc5_ex                            : "",
    etc1_cn                            : "",
    etc2_cn                            : "",
    etc3_cn                            : "",
    etc4_cn                            : "",
    etc5_cn                            : "",
    etc1_kor                           : "",
    etc2_kor                           : "",
    etc3_kor                           : "",
    etc4_kor                           : "",
    etc5_kor                           : "",
  );

  _Screen5 screen5 = _Screen5(
    title                              : "",
    line1                              : "",
    line2                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line1_cn                           : "",
    line2_cn                           : "",
    line1_kor                          : "",
    line2_kor                          : "",
    msg1                               : "",
    msg2                               : "",
    msg3                               : "",
    msg4                               : "",
    msg1_ex                            : "",
    msg2_ex                            : "",
    msg3_ex                            : "",
    msg4_ex                            : "",
    msg1_cn                            : "",
    msg2_cn                            : "",
    msg3_cn                            : "",
    msg4_cn                            : "",
    msg1_kor                           : "",
    msg2_kor                           : "",
    msg3_kor                           : "",
    msg4_kor                           : "",
    etc1                               : "",
    etc2                               : "",
    etc3                               : "",
    etc4                               : "",
    etc5                               : "",
    etc1_ex                            : "",
    etc2_ex                            : "",
    etc3_ex                            : "",
    etc4_ex                            : "",
    etc5_ex                            : "",
    etc1_cn                            : "",
    etc2_cn                            : "",
    etc3_cn                            : "",
    etc4_cn                            : "",
    etc5_cn                            : "",
    etc1_kor                           : "",
    etc2_kor                           : "",
    etc3_kor                           : "",
    etc4_kor                           : "",
    etc5_kor                           : "",
  );

  _Screen6 screen6 = _Screen6(
    title                              : "",
    line1                              : "",
    line2                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line1_cn                           : "",
    line2_cn                           : "",
    line1_kor                          : "",
    line2_kor                          : "",
    msg1                               : "",
    msg2                               : "",
    msg3                               : "",
    msg4                               : "",
    msg1_ex                            : "",
    msg2_ex                            : "",
    msg3_ex                            : "",
    msg4_ex                            : "",
    msg1_cn                            : "",
    msg2_cn                            : "",
    msg3_cn                            : "",
    msg4_cn                            : "",
    msg1_kor                           : "",
    msg2_kor                           : "",
    msg3_kor                           : "",
    msg4_kor                           : "",
    etc1                               : "",
    etc2                               : "",
    etc3                               : "",
    etc4                               : "",
    etc5                               : "",
    etc1_ex                            : "",
    etc2_ex                            : "",
    etc3_ex                            : "",
    etc4_ex                            : "",
    etc5_ex                            : "",
    etc1_cn                            : "",
    etc2_cn                            : "",
    etc3_cn                            : "",
    etc4_cn                            : "",
    etc5_cn                            : "",
    etc1_kor                           : "",
    etc2_kor                           : "",
    etc3_kor                           : "",
    etc4_kor                           : "",
    etc5_kor                           : "",
  );

  _Screen7 screen7 = _Screen7(
    title                              : "",
    line1                              : "",
    line2                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line1_cn                           : "",
    line2_cn                           : "",
    line1_kor                          : "",
    line2_kor                          : "",
    msg1                               : "",
    msg2                               : "",
    msg3                               : "",
    msg4                               : "",
    msg1_ex                            : "",
    msg2_ex                            : "",
    msg3_ex                            : "",
    msg4_ex                            : "",
    msg1_cn                            : "",
    msg2_cn                            : "",
    msg3_cn                            : "",
    msg4_cn                            : "",
    msg1_kor                           : "",
    msg2_kor                           : "",
    msg3_kor                           : "",
    msg4_kor                           : "",
    etc1                               : "",
    etc2                               : "",
    etc3                               : "",
    etc4                               : "",
    etc5                               : "",
    etc1_ex                            : "",
    etc2_ex                            : "",
    etc3_ex                            : "",
    etc4_ex                            : "",
    etc5_ex                            : "",
    etc1_cn                            : "",
    etc2_cn                            : "",
    etc3_cn                            : "",
    etc4_cn                            : "",
    etc5_cn                            : "",
    etc1_kor                           : "",
    etc2_kor                           : "",
    etc3_kor                           : "",
    etc4_kor                           : "",
    etc5_kor                           : "",
  );

  _Screen8 screen8 = _Screen8(
    title                              : "",
    line1                              : "",
    line2                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line1_cn                           : "",
    line2_cn                           : "",
    line1_kor                          : "",
    line2_kor                          : "",
    msg1                               : "",
    msg2                               : "",
    msg3                               : "",
    msg4                               : "",
    msg1_ex                            : "",
    msg2_ex                            : "",
    msg3_ex                            : "",
    msg4_ex                            : "",
    msg1_cn                            : "",
    msg2_cn                            : "",
    msg3_cn                            : "",
    msg4_cn                            : "",
    msg1_kor                           : "",
    msg2_kor                           : "",
    msg3_kor                           : "",
    msg4_kor                           : "",
    etc1                               : "",
    etc2                               : "",
    etc3                               : "",
    etc4                               : "",
    etc5                               : "",
    etc1_ex                            : "",
    etc2_ex                            : "",
    etc3_ex                            : "",
    etc4_ex                            : "",
    etc5_ex                            : "",
    etc1_cn                            : "",
    etc2_cn                            : "",
    etc3_cn                            : "",
    etc4_cn                            : "",
    etc5_cn                            : "",
    etc1_kor                           : "",
    etc2_kor                           : "",
    etc3_kor                           : "",
    etc4_kor                           : "",
    etc5_kor                           : "",
  );

  _Screen9 screen9 = _Screen9(
    title                              : "",
    line1                              : "",
    line2                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line1_cn                           : "",
    line2_cn                           : "",
    line1_kor                          : "",
    line2_kor                          : "",
    msg1                               : "",
    msg2                               : "",
    msg3                               : "",
    msg4                               : "",
    msg1_ex                            : "",
    msg2_ex                            : "",
    msg3_ex                            : "",
    msg4_ex                            : "",
    msg1_cn                            : "",
    msg2_cn                            : "",
    msg3_cn                            : "",
    msg4_cn                            : "",
    msg1_kor                           : "",
    msg2_kor                           : "",
    msg3_kor                           : "",
    msg4_kor                           : "",
    etc1                               : "",
    etc2                               : "",
    etc3                               : "",
    etc4                               : "",
    etc5                               : "",
    etc1_ex                            : "",
    etc2_ex                            : "",
    etc3_ex                            : "",
    etc4_ex                            : "",
    etc5_ex                            : "",
    etc1_cn                            : "",
    etc2_cn                            : "",
    etc3_cn                            : "",
    etc4_cn                            : "",
    etc5_cn                            : "",
    etc1_kor                           : "",
    etc2_kor                           : "",
    etc3_kor                           : "",
    etc4_kor                           : "",
    etc5_kor                           : "",
  );
}

@JsonSerializable()
class _Common {
  factory _Common.fromJson(Map<String, dynamic> json) => _$CommonFromJson(json);
  Map<String, dynamic> toJson() => _$CommonToJson(this);

  _Common({
    required this.page_max,
  });

  @JsonKey(defaultValue: 10)
  int    page_max;
}

@JsonSerializable()
class _Screen0 {
  factory _Screen0.fromJson(Map<String, dynamic> json) => _$Screen0FromJson(json);
  Map<String, dynamic> toJson() => _$Screen0ToJson(this);

  _Screen0({
    required this.title,
    required this.line1,
    required this.line2,
    required this.line1_ex,
    required this.line2_ex,
    required this.line1_cn,
    required this.line2_cn,
    required this.line1_kor,
    required this.line2_kor,
    required this.msg1,
    required this.msg2,
    required this.msg3,
    required this.msg4,
    required this.msg1_ex,
    required this.msg2_ex,
    required this.msg3_ex,
    required this.msg4_ex,
    required this.msg1_cn,
    required this.msg2_cn,
    required this.msg3_cn,
    required this.msg4_cn,
    required this.msg1_kor,
    required this.msg2_kor,
    required this.msg3_kor,
    required this.msg4_kor,
    required this.etc1,
    required this.etc2,
    required this.etc3,
    required this.etc4,
    required this.etc5,
    required this.etc1_ex,
    required this.etc2_ex,
    required this.etc3_ex,
    required this.etc4_ex,
    required this.etc5_ex,
    required this.etc1_cn,
    required this.etc2_cn,
    required this.etc3_cn,
    required this.etc4_cn,
    required this.etc5_cn,
    required this.etc1_kor,
    required this.etc2_kor,
    required this.etc3_kor,
    required this.etc4_kor,
    required this.etc5_kor,
  });

  @JsonKey(defaultValue: "スタート画面")
  String title;
  @JsonKey(defaultValue: "いらっしゃいませ")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line1_cn;
  @JsonKey(defaultValue: "")
  String line2_cn;
  @JsonKey(defaultValue: "")
  String line1_kor;
  @JsonKey(defaultValue: "")
  String line2_kor;
  @JsonKey(defaultValue: "ボタンを選択し")
  String msg1;
  @JsonKey(defaultValue: "登録をスタートしてください")
  String msg2;
  @JsonKey(defaultValue: "")
  String msg3;
  @JsonKey(defaultValue: "")
  String msg4;
  @JsonKey(defaultValue: "")
  String msg1_ex;
  @JsonKey(defaultValue: "")
  String msg2_ex;
  @JsonKey(defaultValue: "")
  String msg3_ex;
  @JsonKey(defaultValue: "")
  String msg4_ex;
  @JsonKey(defaultValue: "")
  String msg1_cn;
  @JsonKey(defaultValue: "")
  String msg2_cn;
  @JsonKey(defaultValue: "")
  String msg3_cn;
  @JsonKey(defaultValue: "")
  String msg4_cn;
  @JsonKey(defaultValue: "")
  String msg1_kor;
  @JsonKey(defaultValue: "")
  String msg2_kor;
  @JsonKey(defaultValue: "")
  String msg3_kor;
  @JsonKey(defaultValue: "")
  String msg4_kor;
  @JsonKey(defaultValue: "")
  String etc1;
  @JsonKey(defaultValue: "")
  String etc2;
  @JsonKey(defaultValue: "")
  String etc3;
  @JsonKey(defaultValue: "")
  String etc4;
  @JsonKey(defaultValue: "")
  String etc5;
  @JsonKey(defaultValue: "")
  String etc1_ex;
  @JsonKey(defaultValue: "")
  String etc2_ex;
  @JsonKey(defaultValue: "")
  String etc3_ex;
  @JsonKey(defaultValue: "")
  String etc4_ex;
  @JsonKey(defaultValue: "")
  String etc5_ex;
  @JsonKey(defaultValue: "")
  String etc1_cn;
  @JsonKey(defaultValue: "")
  String etc2_cn;
  @JsonKey(defaultValue: "")
  String etc3_cn;
  @JsonKey(defaultValue: "")
  String etc4_cn;
  @JsonKey(defaultValue: "")
  String etc5_cn;
  @JsonKey(defaultValue: "")
  String etc1_kor;
  @JsonKey(defaultValue: "")
  String etc2_kor;
  @JsonKey(defaultValue: "")
  String etc3_kor;
  @JsonKey(defaultValue: "")
  String etc4_kor;
  @JsonKey(defaultValue: "")
  String etc5_kor;
}

@JsonSerializable()
class _Screen1 {
  factory _Screen1.fromJson(Map<String, dynamic> json) => _$Screen1FromJson(json);
  Map<String, dynamic> toJson() => _$Screen1ToJson(this);

  _Screen1({
    required this.title,
    required this.line1,
    required this.line2,
    required this.line1_ex,
    required this.line2_ex,
    required this.line1_cn,
    required this.line2_cn,
    required this.line1_kor,
    required this.line2_kor,
    required this.msg1,
    required this.msg2,
    required this.msg3,
    required this.msg4,
    required this.msg1_ex,
    required this.msg2_ex,
    required this.msg3_ex,
    required this.msg4_ex,
    required this.msg1_cn,
    required this.msg2_cn,
    required this.msg3_cn,
    required this.msg4_cn,
    required this.msg1_kor,
    required this.msg2_kor,
    required this.msg3_kor,
    required this.msg4_kor,
    required this.etc1,
    required this.etc2,
    required this.etc3,
    required this.etc4,
    required this.etc5,
    required this.etc1_ex,
    required this.etc2_ex,
    required this.etc3_ex,
    required this.etc4_ex,
    required this.etc5_ex,
    required this.etc1_cn,
    required this.etc2_cn,
    required this.etc3_cn,
    required this.etc4_cn,
    required this.etc5_cn,
    required this.etc1_kor,
    required this.etc2_kor,
    required this.etc3_kor,
    required this.etc4_kor,
    required this.etc5_kor,
  });

  @JsonKey(defaultValue: "スタート画面")
  String title;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line1_cn;
  @JsonKey(defaultValue: "")
  String line2_cn;
  @JsonKey(defaultValue: "")
  String line1_kor;
  @JsonKey(defaultValue: "")
  String line2_kor;
  @JsonKey(defaultValue: "登録スタートボタンを押すか")
  String msg1;
  @JsonKey(defaultValue: "商品をスキャンしてください。")
  String msg2;
  @JsonKey(defaultValue: "")
  String msg3;
  @JsonKey(defaultValue: "")
  String msg4;
  @JsonKey(defaultValue: "")
  String msg1_ex;
  @JsonKey(defaultValue: "")
  String msg2_ex;
  @JsonKey(defaultValue: "")
  String msg3_ex;
  @JsonKey(defaultValue: "")
  String msg4_ex;
  @JsonKey(defaultValue: "")
  String msg1_cn;
  @JsonKey(defaultValue: "")
  String msg2_cn;
  @JsonKey(defaultValue: "")
  String msg3_cn;
  @JsonKey(defaultValue: "")
  String msg4_cn;
  @JsonKey(defaultValue: "")
  String msg1_kor;
  @JsonKey(defaultValue: "")
  String msg2_kor;
  @JsonKey(defaultValue: "")
  String msg3_kor;
  @JsonKey(defaultValue: "")
  String msg4_kor;
  @JsonKey(defaultValue: "")
  String etc1;
  @JsonKey(defaultValue: "")
  String etc2;
  @JsonKey(defaultValue: "")
  String etc3;
  @JsonKey(defaultValue: "")
  String etc4;
  @JsonKey(defaultValue: "")
  String etc5;
  @JsonKey(defaultValue: "")
  String etc1_ex;
  @JsonKey(defaultValue: "")
  String etc2_ex;
  @JsonKey(defaultValue: "")
  String etc3_ex;
  @JsonKey(defaultValue: "")
  String etc4_ex;
  @JsonKey(defaultValue: "")
  String etc5_ex;
  @JsonKey(defaultValue: "")
  String etc1_cn;
  @JsonKey(defaultValue: "")
  String etc2_cn;
  @JsonKey(defaultValue: "")
  String etc3_cn;
  @JsonKey(defaultValue: "")
  String etc4_cn;
  @JsonKey(defaultValue: "")
  String etc5_cn;
  @JsonKey(defaultValue: "")
  String etc1_kor;
  @JsonKey(defaultValue: "")
  String etc2_kor;
  @JsonKey(defaultValue: "")
  String etc3_kor;
  @JsonKey(defaultValue: "")
  String etc4_kor;
  @JsonKey(defaultValue: "")
  String etc5_kor;
}

@JsonSerializable()
class _Screen2 {
  factory _Screen2.fromJson(Map<String, dynamic> json) => _$Screen2FromJson(json);
  Map<String, dynamic> toJson() => _$Screen2ToJson(this);

  _Screen2({
    required this.title,
    required this.line1,
    required this.line2,
    required this.line1_ex,
    required this.line2_ex,
    required this.line1_cn,
    required this.line2_cn,
    required this.line1_kor,
    required this.line2_kor,
    required this.msg1,
    required this.msg2,
    required this.msg3,
    required this.msg4,
    required this.msg1_ex,
    required this.msg2_ex,
    required this.msg3_ex,
    required this.msg4_ex,
    required this.msg1_cn,
    required this.msg2_cn,
    required this.msg3_cn,
    required this.msg4_cn,
    required this.msg1_kor,
    required this.msg2_kor,
    required this.msg3_kor,
    required this.msg4_kor,
    required this.etc1,
    required this.etc2,
    required this.etc3,
    required this.etc4,
    required this.etc5,
    required this.etc1_ex,
    required this.etc2_ex,
    required this.etc3_ex,
    required this.etc4_ex,
    required this.etc5_ex,
    required this.etc1_cn,
    required this.etc2_cn,
    required this.etc3_cn,
    required this.etc4_cn,
    required this.etc5_cn,
    required this.etc1_kor,
    required this.etc2_kor,
    required this.etc3_kor,
    required this.etc4_kor,
    required this.etc5_kor,
  });

  @JsonKey(defaultValue: "商品登録画面")
  String title;
  @JsonKey(defaultValue: "商品を登録してください")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line1_cn;
  @JsonKey(defaultValue: "")
  String line2_cn;
  @JsonKey(defaultValue: "")
  String line1_kor;
  @JsonKey(defaultValue: "")
  String line2_kor;
  @JsonKey(defaultValue: "バーコードが無い商品は")
  String msg1;
  @JsonKey(defaultValue: "下から品目をお選びください")
  String msg2;
  @JsonKey(defaultValue: "")
  String msg3;
  @JsonKey(defaultValue: "")
  String msg4;
  @JsonKey(defaultValue: "")
  String msg1_ex;
  @JsonKey(defaultValue: "")
  String msg2_ex;
  @JsonKey(defaultValue: "")
  String msg3_ex;
  @JsonKey(defaultValue: "")
  String msg4_ex;
  @JsonKey(defaultValue: "")
  String msg1_cn;
  @JsonKey(defaultValue: "")
  String msg2_cn;
  @JsonKey(defaultValue: "")
  String msg3_cn;
  @JsonKey(defaultValue: "")
  String msg4_cn;
  @JsonKey(defaultValue: "")
  String msg1_kor;
  @JsonKey(defaultValue: "")
  String msg2_kor;
  @JsonKey(defaultValue: "")
  String msg3_kor;
  @JsonKey(defaultValue: "")
  String msg4_kor;
  @JsonKey(defaultValue: "買上点数")
  String etc1;
  @JsonKey(defaultValue: "点")
  String etc2;
  @JsonKey(defaultValue: "合計")
  String etc3;
  @JsonKey(defaultValue: "値下合計")
  String etc4;
  @JsonKey(defaultValue: "残額")
  String etc5;
  @JsonKey(defaultValue: "")
  String etc1_ex;
  @JsonKey(defaultValue: "")
  String etc2_ex;
  @JsonKey(defaultValue: "")
  String etc3_ex;
  @JsonKey(defaultValue: "")
  String etc4_ex;
  @JsonKey(defaultValue: "")
  String etc5_ex;
  @JsonKey(defaultValue: "")
  String etc1_cn;
  @JsonKey(defaultValue: "")
  String etc2_cn;
  @JsonKey(defaultValue: "")
  String etc3_cn;
  @JsonKey(defaultValue: "")
  String etc4_cn;
  @JsonKey(defaultValue: "")
  String etc5_cn;
  @JsonKey(defaultValue: "")
  String etc1_kor;
  @JsonKey(defaultValue: "")
  String etc2_kor;
  @JsonKey(defaultValue: "")
  String etc3_kor;
  @JsonKey(defaultValue: "")
  String etc4_kor;
  @JsonKey(defaultValue: "")
  String etc5_kor;
}

@JsonSerializable()
class _Screen3 {
  factory _Screen3.fromJson(Map<String, dynamic> json) => _$Screen3FromJson(json);
  Map<String, dynamic> toJson() => _$Screen3ToJson(this);

  _Screen3({
    required this.title,
    required this.line1,
    required this.line2,
    required this.line1_ex,
    required this.line2_ex,
    required this.line1_cn,
    required this.line2_cn,
    required this.line1_kor,
    required this.line2_kor,
    required this.msg1,
    required this.msg2,
    required this.msg3,
    required this.msg4,
    required this.msg1_ex,
    required this.msg2_ex,
    required this.msg3_ex,
    required this.msg4_ex,
    required this.msg1_cn,
    required this.msg2_cn,
    required this.msg3_cn,
    required this.msg4_cn,
    required this.msg1_kor,
    required this.msg2_kor,
    required this.msg3_kor,
    required this.msg4_kor,
    required this.etc1,
    required this.etc2,
    required this.etc3,
    required this.etc4,
    required this.etc5,
    required this.etc1_ex,
    required this.etc2_ex,
    required this.etc3_ex,
    required this.etc4_ex,
    required this.etc5_ex,
    required this.etc1_cn,
    required this.etc2_cn,
    required this.etc3_cn,
    required this.etc4_cn,
    required this.etc5_cn,
    required this.etc1_kor,
    required this.etc2_kor,
    required this.etc3_kor,
    required this.etc4_kor,
    required this.etc5_kor,
  });

  @JsonKey(defaultValue: "商品登録画面")
  String title;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line1_cn;
  @JsonKey(defaultValue: "")
  String line2_cn;
  @JsonKey(defaultValue: "")
  String line1_kor;
  @JsonKey(defaultValue: "")
  String line2_kor;
  @JsonKey(defaultValue: "商品のバーコードを")
  String msg1;
  @JsonKey(defaultValue: "スキャナーに近づけて")
  String msg2;
  @JsonKey(defaultValue: "登録を行ってください。")
  String msg3;
  @JsonKey(defaultValue: "")
  String msg4;
  @JsonKey(defaultValue: "")
  String msg1_ex;
  @JsonKey(defaultValue: "")
  String msg2_ex;
  @JsonKey(defaultValue: "")
  String msg3_ex;
  @JsonKey(defaultValue: "")
  String msg4_ex;
  @JsonKey(defaultValue: "")
  String msg1_cn;
  @JsonKey(defaultValue: "")
  String msg2_cn;
  @JsonKey(defaultValue: "")
  String msg3_cn;
  @JsonKey(defaultValue: "")
  String msg4_cn;
  @JsonKey(defaultValue: "")
  String msg1_kor;
  @JsonKey(defaultValue: "")
  String msg2_kor;
  @JsonKey(defaultValue: "")
  String msg3_kor;
  @JsonKey(defaultValue: "")
  String msg4_kor;
  @JsonKey(defaultValue: "価格")
  String etc1;
  @JsonKey(defaultValue: "個数")
  String etc2;
  @JsonKey(defaultValue: "値下")
  String etc3;
  @JsonKey(defaultValue: "")
  String etc4;
  @JsonKey(defaultValue: "")
  String etc5;
  @JsonKey(defaultValue: "")
  String etc1_ex;
  @JsonKey(defaultValue: "")
  String etc2_ex;
  @JsonKey(defaultValue: "")
  String etc3_ex;
  @JsonKey(defaultValue: "")
  String etc4_ex;
  @JsonKey(defaultValue: "")
  String etc5_ex;
  @JsonKey(defaultValue: "")
  String etc1_cn;
  @JsonKey(defaultValue: "")
  String etc2_cn;
  @JsonKey(defaultValue: "")
  String etc3_cn;
  @JsonKey(defaultValue: "")
  String etc4_cn;
  @JsonKey(defaultValue: "")
  String etc5_cn;
  @JsonKey(defaultValue: "")
  String etc1_kor;
  @JsonKey(defaultValue: "")
  String etc2_kor;
  @JsonKey(defaultValue: "")
  String etc3_kor;
  @JsonKey(defaultValue: "")
  String etc4_kor;
  @JsonKey(defaultValue: "")
  String etc5_kor;
}

@JsonSerializable()
class _Screen4 {
  factory _Screen4.fromJson(Map<String, dynamic> json) => _$Screen4FromJson(json);
  Map<String, dynamic> toJson() => _$Screen4ToJson(this);

  _Screen4({
    required this.title,
    required this.line1,
    required this.line2,
    required this.line1_ex,
    required this.line2_ex,
    required this.line1_cn,
    required this.line2_cn,
    required this.line1_kor,
    required this.line2_kor,
    required this.msg1,
    required this.msg2,
    required this.msg3,
    required this.msg4,
    required this.msg1_ex,
    required this.msg2_ex,
    required this.msg3_ex,
    required this.msg4_ex,
    required this.msg1_cn,
    required this.msg2_cn,
    required this.msg3_cn,
    required this.msg4_cn,
    required this.msg1_kor,
    required this.msg2_kor,
    required this.msg3_kor,
    required this.msg4_kor,
    required this.etc1,
    required this.etc2,
    required this.etc3,
    required this.etc4,
    required this.etc5,
    required this.etc1_ex,
    required this.etc2_ex,
    required this.etc3_ex,
    required this.etc4_ex,
    required this.etc5_ex,
    required this.etc1_cn,
    required this.etc2_cn,
    required this.etc3_cn,
    required this.etc4_cn,
    required this.etc5_cn,
    required this.etc1_kor,
    required this.etc2_kor,
    required this.etc3_kor,
    required this.etc4_kor,
    required this.etc5_kor,
  });

  @JsonKey(defaultValue: "商品登録画面")
  String title;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line1_cn;
  @JsonKey(defaultValue: "")
  String line2_cn;
  @JsonKey(defaultValue: "")
  String line1_kor;
  @JsonKey(defaultValue: "")
  String line2_kor;
  @JsonKey(defaultValue: "バーコードが無い商品は")
  String msg1;
  @JsonKey(defaultValue: "下のボタン↓を押してください")
  String msg2;
  @JsonKey(defaultValue: "")
  String msg3;
  @JsonKey(defaultValue: "")
  String msg4;
  @JsonKey(defaultValue: "")
  String msg1_ex;
  @JsonKey(defaultValue: "")
  String msg2_ex;
  @JsonKey(defaultValue: "")
  String msg3_ex;
  @JsonKey(defaultValue: "")
  String msg4_ex;
  @JsonKey(defaultValue: "")
  String msg1_cn;
  @JsonKey(defaultValue: "")
  String msg2_cn;
  @JsonKey(defaultValue: "")
  String msg3_cn;
  @JsonKey(defaultValue: "")
  String msg4_cn;
  @JsonKey(defaultValue: "")
  String msg1_kor;
  @JsonKey(defaultValue: "")
  String msg2_kor;
  @JsonKey(defaultValue: "")
  String msg3_kor;
  @JsonKey(defaultValue: "")
  String msg4_kor;
  @JsonKey(defaultValue: "価格")
  String etc1;
  @JsonKey(defaultValue: "個数")
  String etc2;
  @JsonKey(defaultValue: "値下")
  String etc3;
  @JsonKey(defaultValue: "")
  String etc4;
  @JsonKey(defaultValue: "")
  String etc5;
  @JsonKey(defaultValue: "")
  String etc1_ex;
  @JsonKey(defaultValue: "")
  String etc2_ex;
  @JsonKey(defaultValue: "")
  String etc3_ex;
  @JsonKey(defaultValue: "")
  String etc4_ex;
  @JsonKey(defaultValue: "")
  String etc5_ex;
  @JsonKey(defaultValue: "")
  String etc1_cn;
  @JsonKey(defaultValue: "")
  String etc2_cn;
  @JsonKey(defaultValue: "")
  String etc3_cn;
  @JsonKey(defaultValue: "")
  String etc4_cn;
  @JsonKey(defaultValue: "")
  String etc5_cn;
  @JsonKey(defaultValue: "")
  String etc1_kor;
  @JsonKey(defaultValue: "")
  String etc2_kor;
  @JsonKey(defaultValue: "")
  String etc3_kor;
  @JsonKey(defaultValue: "")
  String etc4_kor;
  @JsonKey(defaultValue: "")
  String etc5_kor;
}

@JsonSerializable()
class _Screen5 {
  factory _Screen5.fromJson(Map<String, dynamic> json) => _$Screen5FromJson(json);
  Map<String, dynamic> toJson() => _$Screen5ToJson(this);

  _Screen5({
    required this.title,
    required this.line1,
    required this.line2,
    required this.line1_ex,
    required this.line2_ex,
    required this.line1_cn,
    required this.line2_cn,
    required this.line1_kor,
    required this.line2_kor,
    required this.msg1,
    required this.msg2,
    required this.msg3,
    required this.msg4,
    required this.msg1_ex,
    required this.msg2_ex,
    required this.msg3_ex,
    required this.msg4_ex,
    required this.msg1_cn,
    required this.msg2_cn,
    required this.msg3_cn,
    required this.msg4_cn,
    required this.msg1_kor,
    required this.msg2_kor,
    required this.msg3_kor,
    required this.msg4_kor,
    required this.etc1,
    required this.etc2,
    required this.etc3,
    required this.etc4,
    required this.etc5,
    required this.etc1_ex,
    required this.etc2_ex,
    required this.etc3_ex,
    required this.etc4_ex,
    required this.etc5_ex,
    required this.etc1_cn,
    required this.etc2_cn,
    required this.etc3_cn,
    required this.etc4_cn,
    required this.etc5_cn,
    required this.etc1_kor,
    required this.etc2_kor,
    required this.etc3_kor,
    required this.etc4_kor,
    required this.etc5_kor,
  });

  @JsonKey(defaultValue: "プリセット画面")
  String title;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "商品を選択してください")
  String line2;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line1_cn;
  @JsonKey(defaultValue: "")
  String line2_cn;
  @JsonKey(defaultValue: "")
  String line1_kor;
  @JsonKey(defaultValue: "")
  String line2_kor;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: "")
  String msg3;
  @JsonKey(defaultValue: "")
  String msg4;
  @JsonKey(defaultValue: "")
  String msg1_ex;
  @JsonKey(defaultValue: "")
  String msg2_ex;
  @JsonKey(defaultValue: "")
  String msg3_ex;
  @JsonKey(defaultValue: "")
  String msg4_ex;
  @JsonKey(defaultValue: "")
  String msg1_cn;
  @JsonKey(defaultValue: "")
  String msg2_cn;
  @JsonKey(defaultValue: "")
  String msg3_cn;
  @JsonKey(defaultValue: "")
  String msg4_cn;
  @JsonKey(defaultValue: "")
  String msg1_kor;
  @JsonKey(defaultValue: "")
  String msg2_kor;
  @JsonKey(defaultValue: "")
  String msg3_kor;
  @JsonKey(defaultValue: "")
  String msg4_kor;
  @JsonKey(defaultValue: "価格")
  String etc1;
  @JsonKey(defaultValue: "個数")
  String etc2;
  @JsonKey(defaultValue: "値下")
  String etc3;
  @JsonKey(defaultValue: "")
  String etc4;
  @JsonKey(defaultValue: "")
  String etc5;
  @JsonKey(defaultValue: "")
  String etc1_ex;
  @JsonKey(defaultValue: "")
  String etc2_ex;
  @JsonKey(defaultValue: "")
  String etc3_ex;
  @JsonKey(defaultValue: "")
  String etc4_ex;
  @JsonKey(defaultValue: "")
  String etc5_ex;
  @JsonKey(defaultValue: "")
  String etc1_cn;
  @JsonKey(defaultValue: "")
  String etc2_cn;
  @JsonKey(defaultValue: "")
  String etc3_cn;
  @JsonKey(defaultValue: "")
  String etc4_cn;
  @JsonKey(defaultValue: "")
  String etc5_cn;
  @JsonKey(defaultValue: "")
  String etc1_kor;
  @JsonKey(defaultValue: "")
  String etc2_kor;
  @JsonKey(defaultValue: "")
  String etc3_kor;
  @JsonKey(defaultValue: "")
  String etc4_kor;
  @JsonKey(defaultValue: "")
  String etc5_kor;
}

@JsonSerializable()
class _Screen6 {
  factory _Screen6.fromJson(Map<String, dynamic> json) => _$Screen6FromJson(json);
  Map<String, dynamic> toJson() => _$Screen6ToJson(this);

  _Screen6({
    required this.title,
    required this.line1,
    required this.line2,
    required this.line1_ex,
    required this.line2_ex,
    required this.line1_cn,
    required this.line2_cn,
    required this.line1_kor,
    required this.line2_kor,
    required this.msg1,
    required this.msg2,
    required this.msg3,
    required this.msg4,
    required this.msg1_ex,
    required this.msg2_ex,
    required this.msg3_ex,
    required this.msg4_ex,
    required this.msg1_cn,
    required this.msg2_cn,
    required this.msg3_cn,
    required this.msg4_cn,
    required this.msg1_kor,
    required this.msg2_kor,
    required this.msg3_kor,
    required this.msg4_kor,
    required this.etc1,
    required this.etc2,
    required this.etc3,
    required this.etc4,
    required this.etc5,
    required this.etc1_ex,
    required this.etc2_ex,
    required this.etc3_ex,
    required this.etc4_ex,
    required this.etc5_ex,
    required this.etc1_cn,
    required this.etc2_cn,
    required this.etc3_cn,
    required this.etc4_cn,
    required this.etc5_cn,
    required this.etc1_kor,
    required this.etc2_kor,
    required this.etc3_kor,
    required this.etc4_kor,
    required this.etc5_kor,
  });

  @JsonKey(defaultValue: "プリセット個数入力画面")
  String title;
  @JsonKey(defaultValue: "個数を入力し")
  String line1;
  @JsonKey(defaultValue: "決定を押してください")
  String line2;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line1_cn;
  @JsonKey(defaultValue: "")
  String line2_cn;
  @JsonKey(defaultValue: "")
  String line1_kor;
  @JsonKey(defaultValue: "")
  String line2_kor;
  @JsonKey(defaultValue: "個数を訂正する場合はクリア")
  String msg1;
  @JsonKey(defaultValue: "ボタンを押してください")
  String msg2;
  @JsonKey(defaultValue: "")
  String msg3;
  @JsonKey(defaultValue: "")
  String msg4;
  @JsonKey(defaultValue: "")
  String msg1_ex;
  @JsonKey(defaultValue: "")
  String msg2_ex;
  @JsonKey(defaultValue: "")
  String msg3_ex;
  @JsonKey(defaultValue: "")
  String msg4_ex;
  @JsonKey(defaultValue: "")
  String msg1_cn;
  @JsonKey(defaultValue: "")
  String msg2_cn;
  @JsonKey(defaultValue: "")
  String msg3_cn;
  @JsonKey(defaultValue: "")
  String msg4_cn;
  @JsonKey(defaultValue: "")
  String msg1_kor;
  @JsonKey(defaultValue: "")
  String msg2_kor;
  @JsonKey(defaultValue: "")
  String msg3_kor;
  @JsonKey(defaultValue: "")
  String msg4_kor;
  @JsonKey(defaultValue: "価格")
  String etc1;
  @JsonKey(defaultValue: "個数")
  String etc2;
  @JsonKey(defaultValue: "値下")
  String etc3;
  @JsonKey(defaultValue: "")
  String etc4;
  @JsonKey(defaultValue: "")
  String etc5;
  @JsonKey(defaultValue: "")
  String etc1_ex;
  @JsonKey(defaultValue: "")
  String etc2_ex;
  @JsonKey(defaultValue: "")
  String etc3_ex;
  @JsonKey(defaultValue: "")
  String etc4_ex;
  @JsonKey(defaultValue: "")
  String etc5_ex;
  @JsonKey(defaultValue: "")
  String etc1_cn;
  @JsonKey(defaultValue: "")
  String etc2_cn;
  @JsonKey(defaultValue: "")
  String etc3_cn;
  @JsonKey(defaultValue: "")
  String etc4_cn;
  @JsonKey(defaultValue: "")
  String etc5_cn;
  @JsonKey(defaultValue: "")
  String etc1_kor;
  @JsonKey(defaultValue: "")
  String etc2_kor;
  @JsonKey(defaultValue: "")
  String etc3_kor;
  @JsonKey(defaultValue: "")
  String etc4_kor;
  @JsonKey(defaultValue: "")
  String etc5_kor;
}

@JsonSerializable()
class _Screen7 {
  factory _Screen7.fromJson(Map<String, dynamic> json) => _$Screen7FromJson(json);
  Map<String, dynamic> toJson() => _$Screen7ToJson(this);

  _Screen7({
    required this.title,
    required this.line1,
    required this.line2,
    required this.line1_ex,
    required this.line2_ex,
    required this.line1_cn,
    required this.line2_cn,
    required this.line1_kor,
    required this.line2_kor,
    required this.msg1,
    required this.msg2,
    required this.msg3,
    required this.msg4,
    required this.msg1_ex,
    required this.msg2_ex,
    required this.msg3_ex,
    required this.msg4_ex,
    required this.msg1_cn,
    required this.msg2_cn,
    required this.msg3_cn,
    required this.msg4_cn,
    required this.msg1_kor,
    required this.msg2_kor,
    required this.msg3_kor,
    required this.msg4_kor,
    required this.etc1,
    required this.etc2,
    required this.etc3,
    required this.etc4,
    required this.etc5,
    required this.etc1_ex,
    required this.etc2_ex,
    required this.etc3_ex,
    required this.etc4_ex,
    required this.etc5_ex,
    required this.etc1_cn,
    required this.etc2_cn,
    required this.etc3_cn,
    required this.etc4_cn,
    required this.etc5_cn,
    required this.etc1_kor,
    required this.etc2_kor,
    required this.etc3_kor,
    required this.etc4_kor,
    required this.etc5_kor,
  });

  @JsonKey(defaultValue: "商品登録中画面")
  String title;
  @JsonKey(defaultValue: "商品は")
  String line1;
  @JsonKey(defaultValue: "買い物袋に入れてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line1_cn;
  @JsonKey(defaultValue: "")
  String line2_cn;
  @JsonKey(defaultValue: "")
  String line1_kor;
  @JsonKey(defaultValue: "")
  String line2_kor;
  @JsonKey(defaultValue: "登録した商品は")
  String msg1;
  @JsonKey(defaultValue: "買い物袋に入れてください")
  String msg2;
  @JsonKey(defaultValue: "次の商品登録はこの画面が")
  String msg3;
  @JsonKey(defaultValue: "消えてから行ってください")
  String msg4;
  @JsonKey(defaultValue: "")
  String msg1_ex;
  @JsonKey(defaultValue: "")
  String msg2_ex;
  @JsonKey(defaultValue: "")
  String msg3_ex;
  @JsonKey(defaultValue: "")
  String msg4_ex;
  @JsonKey(defaultValue: "")
  String msg1_cn;
  @JsonKey(defaultValue: "")
  String msg2_cn;
  @JsonKey(defaultValue: "")
  String msg3_cn;
  @JsonKey(defaultValue: "")
  String msg4_cn;
  @JsonKey(defaultValue: "")
  String msg1_kor;
  @JsonKey(defaultValue: "")
  String msg2_kor;
  @JsonKey(defaultValue: "")
  String msg3_kor;
  @JsonKey(defaultValue: "")
  String msg4_kor;
  @JsonKey(defaultValue: "登録中")
  String etc1;
  @JsonKey(defaultValue: "価格")
  String etc2;
  @JsonKey(defaultValue: "")
  String etc3;
  @JsonKey(defaultValue: "")
  String etc4;
  @JsonKey(defaultValue: "")
  String etc5;
  @JsonKey(defaultValue: "")
  String etc1_ex;
  @JsonKey(defaultValue: "")
  String etc2_ex;
  @JsonKey(defaultValue: "")
  String etc3_ex;
  @JsonKey(defaultValue: "")
  String etc4_ex;
  @JsonKey(defaultValue: "")
  String etc5_ex;
  @JsonKey(defaultValue: "")
  String etc1_cn;
  @JsonKey(defaultValue: "")
  String etc2_cn;
  @JsonKey(defaultValue: "")
  String etc3_cn;
  @JsonKey(defaultValue: "")
  String etc4_cn;
  @JsonKey(defaultValue: "")
  String etc5_cn;
  @JsonKey(defaultValue: "")
  String etc1_kor;
  @JsonKey(defaultValue: "")
  String etc2_kor;
  @JsonKey(defaultValue: "")
  String etc3_kor;
  @JsonKey(defaultValue: "")
  String etc4_kor;
  @JsonKey(defaultValue: "")
  String etc5_kor;
}

@JsonSerializable()
class _Screen8 {
  factory _Screen8.fromJson(Map<String, dynamic> json) => _$Screen8FromJson(json);
  Map<String, dynamic> toJson() => _$Screen8ToJson(this);

  _Screen8({
    required this.title,
    required this.line1,
    required this.line2,
    required this.line1_ex,
    required this.line2_ex,
    required this.line1_cn,
    required this.line2_cn,
    required this.line1_kor,
    required this.line2_kor,
    required this.msg1,
    required this.msg2,
    required this.msg3,
    required this.msg4,
    required this.msg1_ex,
    required this.msg2_ex,
    required this.msg3_ex,
    required this.msg4_ex,
    required this.msg1_cn,
    required this.msg2_cn,
    required this.msg3_cn,
    required this.msg4_cn,
    required this.msg1_kor,
    required this.msg2_kor,
    required this.msg3_kor,
    required this.msg4_kor,
    required this.etc1,
    required this.etc2,
    required this.etc3,
    required this.etc4,
    required this.etc5,
    required this.etc1_ex,
    required this.etc2_ex,
    required this.etc3_ex,
    required this.etc4_ex,
    required this.etc5_ex,
    required this.etc1_cn,
    required this.etc2_cn,
    required this.etc3_cn,
    required this.etc4_cn,
    required this.etc5_cn,
    required this.etc1_kor,
    required this.etc2_kor,
    required this.etc3_kor,
    required this.etc4_kor,
    required this.etc5_kor,
  });

  @JsonKey(defaultValue: "クリニックモード読込画面")
  String title;
  @JsonKey(defaultValue: "バーコードをスキャンしてください")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line1_cn;
  @JsonKey(defaultValue: "")
  String line2_cn;
  @JsonKey(defaultValue: "")
  String line1_kor;
  @JsonKey(defaultValue: "")
  String line2_kor;
  @JsonKey(defaultValue: "バーコードを")
  String msg1;
  @JsonKey(defaultValue: "スキャナーに近づけて")
  String msg2;
  @JsonKey(defaultValue: "精算を行ってください。")
  String msg3;
  @JsonKey(defaultValue: "")
  String msg4;
  @JsonKey(defaultValue: "")
  String msg1_ex;
  @JsonKey(defaultValue: "")
  String msg2_ex;
  @JsonKey(defaultValue: "")
  String msg3_ex;
  @JsonKey(defaultValue: "")
  String msg4_ex;
  @JsonKey(defaultValue: "")
  String msg1_cn;
  @JsonKey(defaultValue: "")
  String msg2_cn;
  @JsonKey(defaultValue: "")
  String msg3_cn;
  @JsonKey(defaultValue: "")
  String msg4_cn;
  @JsonKey(defaultValue: "")
  String msg1_kor;
  @JsonKey(defaultValue: "")
  String msg2_kor;
  @JsonKey(defaultValue: "")
  String msg3_kor;
  @JsonKey(defaultValue: "")
  String msg4_kor;
  @JsonKey(defaultValue: "点数")
  String etc1;
  @JsonKey(defaultValue: "")
  String etc2;
  @JsonKey(defaultValue: "")
  String etc3;
  @JsonKey(defaultValue: "")
  String etc4;
  @JsonKey(defaultValue: "")
  String etc5;
  @JsonKey(defaultValue: "")
  String etc1_ex;
  @JsonKey(defaultValue: "")
  String etc2_ex;
  @JsonKey(defaultValue: "")
  String etc3_ex;
  @JsonKey(defaultValue: "")
  String etc4_ex;
  @JsonKey(defaultValue: "")
  String etc5_ex;
  @JsonKey(defaultValue: "")
  String etc1_cn;
  @JsonKey(defaultValue: "")
  String etc2_cn;
  @JsonKey(defaultValue: "")
  String etc3_cn;
  @JsonKey(defaultValue: "")
  String etc4_cn;
  @JsonKey(defaultValue: "")
  String etc5_cn;
  @JsonKey(defaultValue: "")
  String etc1_kor;
  @JsonKey(defaultValue: "")
  String etc2_kor;
  @JsonKey(defaultValue: "")
  String etc3_kor;
  @JsonKey(defaultValue: "")
  String etc4_kor;
  @JsonKey(defaultValue: "")
  String etc5_kor;
}

@JsonSerializable()
class _Screen9 {
  factory _Screen9.fromJson(Map<String, dynamic> json) => _$Screen9FromJson(json);
  Map<String, dynamic> toJson() => _$Screen9ToJson(this);

  _Screen9({
    required this.title,
    required this.line1,
    required this.line2,
    required this.line1_ex,
    required this.line2_ex,
    required this.line1_cn,
    required this.line2_cn,
    required this.line1_kor,
    required this.line2_kor,
    required this.msg1,
    required this.msg2,
    required this.msg3,
    required this.msg4,
    required this.msg1_ex,
    required this.msg2_ex,
    required this.msg3_ex,
    required this.msg4_ex,
    required this.msg1_cn,
    required this.msg2_cn,
    required this.msg3_cn,
    required this.msg4_cn,
    required this.msg1_kor,
    required this.msg2_kor,
    required this.msg3_kor,
    required this.msg4_kor,
    required this.etc1,
    required this.etc2,
    required this.etc3,
    required this.etc4,
    required this.etc5,
    required this.etc1_ex,
    required this.etc2_ex,
    required this.etc3_ex,
    required this.etc4_ex,
    required this.etc5_ex,
    required this.etc1_cn,
    required this.etc2_cn,
    required this.etc3_cn,
    required this.etc4_cn,
    required this.etc5_cn,
    required this.etc1_kor,
    required this.etc2_kor,
    required this.etc3_kor,
    required this.etc4_kor,
    required this.etc5_kor,
  });

  @JsonKey(defaultValue: "クリニックモード読込中画面")
  String title;
  @JsonKey(defaultValue: "読み込んでいます")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line1_cn;
  @JsonKey(defaultValue: "")
  String line2_cn;
  @JsonKey(defaultValue: "")
  String line1_kor;
  @JsonKey(defaultValue: "")
  String line2_kor;
  @JsonKey(defaultValue: "次のバーコードをスキャンする")
  String msg1;
  @JsonKey(defaultValue: "場合はこの画面が消えてから")
  String msg2;
  @JsonKey(defaultValue: "行ってください")
  String msg3;
  @JsonKey(defaultValue: "")
  String msg4;
  @JsonKey(defaultValue: "")
  String msg1_ex;
  @JsonKey(defaultValue: "")
  String msg2_ex;
  @JsonKey(defaultValue: "")
  String msg3_ex;
  @JsonKey(defaultValue: "")
  String msg4_ex;
  @JsonKey(defaultValue: "")
  String msg1_cn;
  @JsonKey(defaultValue: "")
  String msg2_cn;
  @JsonKey(defaultValue: "")
  String msg3_cn;
  @JsonKey(defaultValue: "")
  String msg4_cn;
  @JsonKey(defaultValue: "")
  String msg1_kor;
  @JsonKey(defaultValue: "")
  String msg2_kor;
  @JsonKey(defaultValue: "")
  String msg3_kor;
  @JsonKey(defaultValue: "")
  String msg4_kor;
  @JsonKey(defaultValue: "読込中")
  String etc1;
  @JsonKey(defaultValue: "価格")
  String etc2;
  @JsonKey(defaultValue: "")
  String etc3;
  @JsonKey(defaultValue: "")
  String etc4;
  @JsonKey(defaultValue: "")
  String etc5;
  @JsonKey(defaultValue: "")
  String etc1_ex;
  @JsonKey(defaultValue: "")
  String etc2_ex;
  @JsonKey(defaultValue: "")
  String etc3_ex;
  @JsonKey(defaultValue: "")
  String etc4_ex;
  @JsonKey(defaultValue: "")
  String etc5_ex;
  @JsonKey(defaultValue: "")
  String etc1_cn;
  @JsonKey(defaultValue: "")
  String etc2_cn;
  @JsonKey(defaultValue: "")
  String etc3_cn;
  @JsonKey(defaultValue: "")
  String etc4_cn;
  @JsonKey(defaultValue: "")
  String etc5_cn;
  @JsonKey(defaultValue: "")
  String etc1_kor;
  @JsonKey(defaultValue: "")
  String etc2_kor;
  @JsonKey(defaultValue: "")
  String etc3_kor;
  @JsonKey(defaultValue: "")
  String etc4_kor;
  @JsonKey(defaultValue: "")
  String etc5_kor;
}

