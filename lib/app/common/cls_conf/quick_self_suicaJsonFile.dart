/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'quick_self_suicaJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Quick_self_suicaJsonFile extends ConfigJsonFile {
  static final Quick_self_suicaJsonFile _instance = Quick_self_suicaJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "quick_self_suica.json";

  Quick_self_suicaJsonFile(){
    setPath(_confPath, _fileName);
  }
  Quick_self_suicaJsonFile._internal();

  factory Quick_self_suicaJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Quick_self_suicaJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Quick_self_suicaJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Quick_self_suicaJsonFileToJson(this));
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
      try {
        screen10 = _$Screen10FromJson(jsonD['screen10']);
      } catch(e) {
        screen10 = _$Screen10FromJson({});
        ret = false;
      }
      try {
        screen11 = _$Screen11FromJson(jsonD['screen11']);
      } catch(e) {
        screen11 = _$Screen11FromJson({});
        ret = false;
      }
      try {
        screen12 = _$Screen12FromJson(jsonD['screen12']);
      } catch(e) {
        screen12 = _$Screen12FromJson({});
        ret = false;
      }
      try {
        screen13 = _$Screen13FromJson(jsonD['screen13']);
      } catch(e) {
        screen13 = _$Screen13FromJson({});
        ret = false;
      }
      try {
        screen14 = _$Screen14FromJson(jsonD['screen14']);
      } catch(e) {
        screen14 = _$Screen14FromJson({});
        ret = false;
      }
      try {
        screen15 = _$Screen15FromJson(jsonD['screen15']);
      } catch(e) {
        screen15 = _$Screen15FromJson({});
        ret = false;
      }
      try {
        screen16 = _$Screen16FromJson(jsonD['screen16']);
      } catch(e) {
        screen16 = _$Screen16FromJson({});
        ret = false;
      }
      try {
        screen17 = _$Screen17FromJson(jsonD['screen17']);
      } catch(e) {
        screen17 = _$Screen17FromJson({});
        ret = false;
      }
      try {
        screen18 = _$Screen18FromJson(jsonD['screen18']);
      } catch(e) {
        screen18 = _$Screen18FromJson({});
        ret = false;
      }
      try {
        screen19 = _$Screen19FromJson(jsonD['screen19']);
      } catch(e) {
        screen19 = _$Screen19FromJson({});
        ret = false;
      }
      try {
        screen20 = _$Screen20FromJson(jsonD['screen20']);
      } catch(e) {
        screen20 = _$Screen20FromJson({});
        ret = false;
      }
      try {
        screen21 = _$Screen21FromJson(jsonD['screen21']);
      } catch(e) {
        screen21 = _$Screen21FromJson({});
        ret = false;
      }
      try {
        screen22 = _$Screen22FromJson(jsonD['screen22']);
      } catch(e) {
        screen22 = _$Screen22FromJson({});
        ret = false;
      }
      try {
        screen23 = _$Screen23FromJson(jsonD['screen23']);
      } catch(e) {
        screen23 = _$Screen23FromJson({});
        ret = false;
      }
      try {
        screen24 = _$Screen24FromJson(jsonD['screen24']);
      } catch(e) {
        screen24 = _$Screen24FromJson({});
        ret = false;
      }
      try {
        screen25 = _$Screen25FromJson(jsonD['screen25']);
      } catch(e) {
        screen25 = _$Screen25FromJson({});
        ret = false;
      }
      try {
        screen26 = _$Screen26FromJson(jsonD['screen26']);
      } catch(e) {
        screen26 = _$Screen26FromJson({});
        ret = false;
      }
      try {
        screen27 = _$Screen27FromJson(jsonD['screen27']);
      } catch(e) {
        screen27 = _$Screen27FromJson({});
        ret = false;
      }
      try {
        screen28 = _$Screen28FromJson(jsonD['screen28']);
      } catch(e) {
        screen28 = _$Screen28FromJson({});
        ret = false;
      }
      try {
        screen29 = _$Screen29FromJson(jsonD['screen29']);
      } catch(e) {
        screen29 = _$Screen29FromJson({});
        ret = false;
      }
      try {
        screen30 = _$Screen30FromJson(jsonD['screen30']);
      } catch(e) {
        screen30 = _$Screen30FromJson({});
        ret = false;
      }
      try {
        screen31 = _$Screen31FromJson(jsonD['screen31']);
      } catch(e) {
        screen31 = _$Screen31FromJson({});
        ret = false;
      }
      try {
        screen32 = _$Screen32FromJson(jsonD['screen32']);
      } catch(e) {
        screen32 = _$Screen32FromJson({});
        ret = false;
      }
      try {
        screen33 = _$Screen33FromJson(jsonD['screen33']);
      } catch(e) {
        screen33 = _$Screen33FromJson({});
        ret = false;
      }
      try {
        screen34 = _$Screen34FromJson(jsonD['screen34']);
      } catch(e) {
        screen34 = _$Screen34FromJson({});
        ret = false;
      }
      try {
        screen35 = _$Screen35FromJson(jsonD['screen35']);
      } catch(e) {
        screen35 = _$Screen35FromJson({});
        ret = false;
      }
      try {
        screen36 = _$Screen36FromJson(jsonD['screen36']);
      } catch(e) {
        screen36 = _$Screen36FromJson({});
        ret = false;
      }
      try {
        screen37 = _$Screen37FromJson(jsonD['screen37']);
      } catch(e) {
        screen37 = _$Screen37FromJson({});
        ret = false;
      }
      try {
        screen38 = _$Screen38FromJson(jsonD['screen38']);
      } catch(e) {
        screen38 = _$Screen38FromJson({});
        ret = false;
      }
      try {
        screen39 = _$Screen39FromJson(jsonD['screen39']);
      } catch(e) {
        screen39 = _$Screen39FromJson({});
        ret = false;
      }
      try {
        screen40 = _$Screen40FromJson(jsonD['screen40']);
      } catch(e) {
        screen40 = _$Screen40FromJson({});
        ret = false;
      }
      try {
        screen41 = _$Screen41FromJson(jsonD['screen41']);
      } catch(e) {
        screen41 = _$Screen41FromJson({});
        ret = false;
      }
      try {
        screen42 = _$Screen42FromJson(jsonD['screen42']);
      } catch(e) {
        screen42 = _$Screen42FromJson({});
        ret = false;
      }
      try {
        screen43 = _$Screen43FromJson(jsonD['screen43']);
      } catch(e) {
        screen43 = _$Screen43FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Common common = _Common(
    item_line                          : 0,
    scan_skip                          : 0,
    page_max                           : 0,
    ini_typ                            : 0,
    preset_name                        : "",
    refbtn_name                        : "",
    update_chk_retry_cnt               : 0,
    update_chk_retry_time              : 0,
  );

  _Screen0 screen0 = _Screen0(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen1 screen1 = _Screen1(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen2 screen2 = _Screen2(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen3 screen3 = _Screen3(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen4 screen4 = _Screen4(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen5 screen5 = _Screen5(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen6 screen6 = _Screen6(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen7 screen7 = _Screen7(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen8 screen8 = _Screen8(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen9 screen9 = _Screen9(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen10 screen10 = _Screen10(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen11 screen11 = _Screen11(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen12 screen12 = _Screen12(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen13 screen13 = _Screen13(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen14 screen14 = _Screen14(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen15 screen15 = _Screen15(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen16 screen16 = _Screen16(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen17 screen17 = _Screen17(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen18 screen18 = _Screen18(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen19 screen19 = _Screen19(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen20 screen20 = _Screen20(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen21 screen21 = _Screen21(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen22 screen22 = _Screen22(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen23 screen23 = _Screen23(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen24 screen24 = _Screen24(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen25 screen25 = _Screen25(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen26 screen26 = _Screen26(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen27 screen27 = _Screen27(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen28 screen28 = _Screen28(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen29 screen29 = _Screen29(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen30 screen30 = _Screen30(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen31 screen31 = _Screen31(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen32 screen32 = _Screen32(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen33 screen33 = _Screen33(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen34 screen34 = _Screen34(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen35 screen35 = _Screen35(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen36 screen36 = _Screen36(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen37 screen37 = _Screen37(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen38 screen38 = _Screen38(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen39 screen39 = _Screen39(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen40 screen40 = _Screen40(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen41 screen41 = _Screen41(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen42 screen42 = _Screen42(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );

  _Screen43 screen43 = _Screen43(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound                              : 0,
    snd_timer                          : 0,
    edy_timer                          : 0,
    dsp_timer                          : 0,
    cncl_timer                         : 0,
    dsp_cnt_max                        : 0,
    cnt_timer                          : 0,
    sound2                             : 0,
    sound3                             : 0,
  );
}

@JsonSerializable()
class _Common {
  factory _Common.fromJson(Map<String, dynamic> json) => _$CommonFromJson(json);
  Map<String, dynamic> toJson() => _$CommonToJson(this);

  _Common({
    required this.item_line,
    required this.scan_skip,
    required this.page_max,
    required this.ini_typ,
    required this.preset_name,
    required this.refbtn_name,
    required this.update_chk_retry_cnt,
    required this.update_chk_retry_time,
  });

  @JsonKey(defaultValue: 5)
  int    item_line;
  @JsonKey(defaultValue: 0)
  int    scan_skip;
  @JsonKey(defaultValue: 44)
  int    page_max;
  @JsonKey(defaultValue: 1)
  int    ini_typ;
  @JsonKey(defaultValue: "新聞")
  String preset_name;
  @JsonKey(defaultValue: "残額  確認")
  String refbtn_name;
  @JsonKey(defaultValue: 6)
  int    update_chk_retry_cnt;
  @JsonKey(defaultValue: 10)
  int    update_chk_retry_time;
}

@JsonSerializable()
class _Screen0 {
  factory _Screen0.fromJson(Map<String, dynamic> json) => _$Screen0FromJson(json);
  Map<String, dynamic> toJson() => _$Screen0ToJson(this);

  _Screen0({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面")
  String title;
  @JsonKey(defaultValue: "「買い物スタート」ボタンを押してから　　　 Ｓｕｉｃａをタッチしてください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 1)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5033)
  int    sound;
  @JsonKey(defaultValue: 60)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 16)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 7)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen1 {
  factory _Screen1.fromJson(Map<String, dynamic> json) => _$Screen1FromJson(json);
  Map<String, dynamic> toJson() => _$Screen1ToJson(this);

  _Screen1({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面２（ボタンを押したが、Ｓｕｉｃａを検知できない）")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5035)
  int    sound;
  @JsonKey(defaultValue: 15)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen2 {
  factory _Screen2.fromJson(Map<String, dynamic> json) => _$Screen2FromJson(json);
  Map<String, dynamic> toJson() => _$Screen2ToJson(this);

  _Screen2({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スキャン画面")
  String title;
  @JsonKey(defaultValue: "＊残額以上のお買い物はできません。　＊複数枚でのご利用はできません")
  String msg1;
  @JsonKey(defaultValue: "Suica残額")
  String msg2;
  @JsonKey(defaultValue: 1)
  int    msg1_size;
  @JsonKey(defaultValue: 2)
  int    msg2_size;
  @JsonKey(defaultValue: 5002)
  int    sound;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 1)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen3 {
  factory _Screen3.fromJson(Map<String, dynamic> json) => _$Screen3FromJson(json);
  Map<String, dynamic> toJson() => _$Screen3ToJson(this);

  _Screen3({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "小計画面")
  String title;
  @JsonKey(defaultValue: "＊残額以上のお買い物はできません　　＊複数枚でのご利用はできません")
  String msg1;
  @JsonKey(defaultValue: "Suica残額")
  String msg2;
  @JsonKey(defaultValue: 1)
  int    msg1_size;
  @JsonKey(defaultValue: 2)
  int    msg2_size;
  @JsonKey(defaultValue: 5019)
  int    sound;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    edy_timer;
  @JsonKey(defaultValue: 1)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 3)
  int    cnt_timer;
  @JsonKey(defaultValue: 5096)
  int    sound2;
  @JsonKey(defaultValue: 5093)
  int    sound3;
}

@JsonSerializable()
class _Screen4 {
  factory _Screen4.fromJson(Map<String, dynamic> json) => _$Screen4FromJson(json);
  Map<String, dynamic> toJson() => _$Screen4ToJson(this);

  _Screen4({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "残額不足取消画面")
  String title;
  @JsonKey(defaultValue: "残額不足です")
  String msg1;
  @JsonKey(defaultValue: "最　初　へ　戻　る")
  String msg2;
  @JsonKey(defaultValue: 3)
  int    msg1_size;
  @JsonKey(defaultValue: 3)
  int    msg2_size;
  @JsonKey(defaultValue: 5129)
  int    sound;
  @JsonKey(defaultValue: 6)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 15)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen5 {
  factory _Screen5.fromJson(Map<String, dynamic> json) => _$Screen5FromJson(json);
  Map<String, dynamic> toJson() => _$Screen5ToJson(this);

  _Screen5({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "Suicaタッチ画面")
  String title;
  @JsonKey(defaultValue: "レシート有り")
  String msg1;
  @JsonKey(defaultValue: "レシート無し")
  String msg2;
  @JsonKey(defaultValue: 1)
  int    msg1_size;
  @JsonKey(defaultValue: 1)
  int    msg2_size;
  @JsonKey(defaultValue: 1039)
  int    sound;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 1028)
  int    sound2;
  @JsonKey(defaultValue: 1029)
  int    sound3;
}

@JsonSerializable()
class _Screen6 {
  factory _Screen6.fromJson(Map<String, dynamic> json) => _$Screen6FromJson(json);
  Map<String, dynamic> toJson() => _$Screen6ToJson(this);

  _Screen6({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "残額表示＆レシート発行画面")
  String title;
  @JsonKey(defaultValue: "ありがとうございます　　　　　　　　　　　　Ｓｕｉｃａのお取り忘れにご注意ください")
  String msg1;
  @JsonKey(defaultValue: "Ｓｕｉｃａのお取り忘れにご注意ください　　　レシートが必要な方は店員をお呼びください")
  String msg2;
  @JsonKey(defaultValue: 2)
  int    msg1_size;
  @JsonKey(defaultValue: 2)
  int    msg2_size;
  @JsonKey(defaultValue: 5127)
  int    sound;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 2)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen7 {
  factory _Screen7.fromJson(Map<String, dynamic> json) => _$Screen7FromJson(json);
  Map<String, dynamic> toJson() => _$Screen7ToJson(this);

  _Screen7({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "レシート発行後、カード取得")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5023)
  int    sound;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 1)
  int    edy_timer;
  @JsonKey(defaultValue: 1)
  int    dsp_timer;
  @JsonKey(defaultValue: 1)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen8 {
  factory _Screen8.fromJson(Map<String, dynamic> json) => _$Screen8FromJson(json);
  Map<String, dynamic> toJson() => _$Screen8ToJson(this);

  _Screen8({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スキャン画面２")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5003)
  int    sound;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 1)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen9 {
  factory _Screen9.fromJson(Map<String, dynamic> json) => _$Screen9FromJson(json);
  Map<String, dynamic> toJson() => _$Screen9ToJson(this);

  _Screen9({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スキャン画面３")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5003)
  int    sound;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 1)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen10 {
  factory _Screen10.fromJson(Map<String, dynamic> json) => _$Screen10FromJson(json);
  Map<String, dynamic> toJson() => _$Screen10ToJson(this);

  _Screen10({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "プリセットリスト画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5009)
  int    sound;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen11 {
  factory _Screen11.fromJson(Map<String, dynamic> json) => _$Screen11FromJson(json);
  Map<String, dynamic> toJson() => _$Screen11ToJson(this);

  _Screen11({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "プリセット商品画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5010)
  int    sound;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen12 {
  factory _Screen12.fromJson(Map<String, dynamic> json) => _$Screen12FromJson(json);
  Map<String, dynamic> toJson() => _$Screen12ToJson(this);

  _Screen12({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "取消ボタンを押したダイアログ画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5011)
  int    sound;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 15)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen13 {
  factory _Screen13.fromJson(Map<String, dynamic> json) => _$Screen13FromJson(json);
  Map<String, dynamic> toJson() => _$Screen13ToJson(this);

  _Screen13({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "年齢確認商品画面")
  String title;
  @JsonKey(defaultValue: "年齢確認が必要な商品のため　　　　　　　　　　このレジでのお取り扱いはできません　　　　　　店舗スタッフのいるレジでお買い上げください")
  String msg1;
  @JsonKey(defaultValue: "は　い")
  String msg2;
  @JsonKey(defaultValue: 2)
  int    msg1_size;
  @JsonKey(defaultValue: 1)
  int    msg2_size;
  @JsonKey(defaultValue: 5068)
  int    sound;
  @JsonKey(defaultValue: 7)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen14 {
  factory _Screen14.fromJson(Map<String, dynamic> json) => _$Screen14FromJson(json);
  Map<String, dynamic> toJson() => _$Screen14ToJson(this);

  _Screen14({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5014)
  int    sound;
  @JsonKey(defaultValue: 7)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 1)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen15 {
  factory _Screen15.fromJson(Map<String, dynamic> json) => _$Screen15FromJson(json);
  Map<String, dynamic> toJson() => _$Screen15ToJson(this);

  _Screen15({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "会員カード画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5054)
  int    sound;
  @JsonKey(defaultValue: 7)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 30)
  int    cncl_timer;
  @JsonKey(defaultValue: 4)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 7)
  int    cnt_timer;
  @JsonKey(defaultValue: 5056)
  int    sound2;
  @JsonKey(defaultValue: 5103)
  int    sound3;
}

@JsonSerializable()
class _Screen16 {
  factory _Screen16.fromJson(Map<String, dynamic> json) => _$Screen16FromJson(json);
  Map<String, dynamic> toJson() => _$Screen16ToJson(this);

  _Screen16({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スキャン画面(プリセットを表示しない設定の場合)")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5037)
  int    sound;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 1)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen17 {
  factory _Screen17.fromJson(Map<String, dynamic> json) => _$Screen17FromJson(json);
  Map<String, dynamic> toJson() => _$Screen17ToJson(this);

  _Screen17({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スキャン画面２(プリセットを表示しない設定の場合)")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5038)
  int    sound;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 1)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen18 {
  factory _Screen18.fromJson(Map<String, dynamic> json) => _$Screen18FromJson(json);
  Map<String, dynamic> toJson() => _$Screen18ToJson(this);

  _Screen18({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面 　　 　　 (user_cd29に128が有効)")
  String title;
  @JsonKey(defaultValue: "バーコードをスキャナーに近づけてください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 3)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5062)
  int    sound;
  @JsonKey(defaultValue: 60)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 16)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 4)
  int    cnt_timer;
  @JsonKey(defaultValue: 5112)
  int    sound2;
  @JsonKey(defaultValue: 5125)
  int    sound3;
}

@JsonSerializable()
class _Screen19 {
  factory _Screen19.fromJson(Map<String, dynamic> json) => _$Screen19FromJson(json);
  Map<String, dynamic> toJson() => _$Screen19ToJson(this);

  _Screen19({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面２ 　　　　 (user_cd29に128が有効)")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5038)
  int    sound;
  @JsonKey(defaultValue: 15)
  int    snd_timer;
  @JsonKey(defaultValue: 3)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen20 {
  factory _Screen20.fromJson(Map<String, dynamic> json) => _$Screen20FromJson(json);
  Map<String, dynamic> toJson() => _$Screen20ToJson(this);

  _Screen20({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面 　 　　　 (user_cd29に640が有効)")
  String title;
  @JsonKey(defaultValue: "バーコードをスキャナーに近づけてください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 3)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5044)
  int    sound;
  @JsonKey(defaultValue: 60)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 16)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 4)
  int    cnt_timer;
  @JsonKey(defaultValue: 5113)
  int    sound2;
  @JsonKey(defaultValue: 5126)
  int    sound3;
}

@JsonSerializable()
class _Screen21 {
  factory _Screen21.fromJson(Map<String, dynamic> json) => _$Screen21FromJson(json);
  Map<String, dynamic> toJson() => _$Screen21ToJson(this);

  _Screen21({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面２ 　　　　 (user_cd29に640が有効)")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5003)
  int    sound;
  @JsonKey(defaultValue: 15)
  int    snd_timer;
  @JsonKey(defaultValue: 3)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen22 {
  factory _Screen22.fromJson(Map<String, dynamic> json) => _$Screen22FromJson(json);
  Map<String, dynamic> toJson() => _$Screen22ToJson(this);

  _Screen22({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面 　 　　　 (user_cd29に1152が有効)")
  String title;
  @JsonKey(defaultValue: "バーコードをスキャナーに近づけてください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 3)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5062)
  int    sound;
  @JsonKey(defaultValue: 60)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 16)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 4)
  int    cnt_timer;
  @JsonKey(defaultValue: 5112)
  int    sound2;
  @JsonKey(defaultValue: 5125)
  int    sound3;
}

@JsonSerializable()
class _Screen23 {
  factory _Screen23.fromJson(Map<String, dynamic> json) => _$Screen23FromJson(json);
  Map<String, dynamic> toJson() => _$Screen23ToJson(this);

  _Screen23({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面２ 　　　　 (user_cd29に1152が有効)")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5038)
  int    sound;
  @JsonKey(defaultValue: 15)
  int    snd_timer;
  @JsonKey(defaultValue: 3)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen24 {
  factory _Screen24.fromJson(Map<String, dynamic> json) => _$Screen24FromJson(json);
  Map<String, dynamic> toJson() => _$Screen24ToJson(this);

  _Screen24({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面 　　 　　 (user_cd29に1664が有効)")
  String title;
  @JsonKey(defaultValue: "バーコードをスキャナーに近づけてください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 3)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5044)
  int    sound;
  @JsonKey(defaultValue: 60)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 16)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 4)
  int    cnt_timer;
  @JsonKey(defaultValue: 5113)
  int    sound2;
  @JsonKey(defaultValue: 5126)
  int    sound3;
}

@JsonSerializable()
class _Screen25 {
  factory _Screen25.fromJson(Map<String, dynamic> json) => _$Screen25FromJson(json);
  Map<String, dynamic> toJson() => _$Screen25ToJson(this);

  _Screen25({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面２ 　　　　 (user_cd29に1664が有効)")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5003)
  int    sound;
  @JsonKey(defaultValue: 15)
  int    snd_timer;
  @JsonKey(defaultValue: 3)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen26 {
  factory _Screen26.fromJson(Map<String, dynamic> json) => _$Screen26FromJson(json);
  Map<String, dynamic> toJson() => _$Screen26ToJson(this);

  _Screen26({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面  　　　　 (user_cd29に136が有効)")
  String title;
  @JsonKey(defaultValue: "ポイントカードをスキャナーに差し込むか、　　　　  商品のバーコードをスキャナーに近づけてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 3)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5104)
  int    sound;
  @JsonKey(defaultValue: 60)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 21)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 4)
  int    cnt_timer;
  @JsonKey(defaultValue: 5107)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen27 {
  factory _Screen27.fromJson(Map<String, dynamic> json) => _$Screen27FromJson(json);
  Map<String, dynamic> toJson() => _$Screen27ToJson(this);

  _Screen27({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面２ 　　　　 (user_cd29に136が有効)")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5097)
  int    sound;
  @JsonKey(defaultValue: 15)
  int    snd_timer;
  @JsonKey(defaultValue: 3)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen28 {
  factory _Screen28.fromJson(Map<String, dynamic> json) => _$Screen28FromJson(json);
  Map<String, dynamic> toJson() => _$Screen28ToJson(this);

  _Screen28({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面 　 　　　 (user_cd29に648が有効)")
  String title;
  @JsonKey(defaultValue: "ポイントカードをスキャナーに差し込むか、　　　　  商品のバーコードをスキャナーに近づけてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 3)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5105)
  int    sound;
  @JsonKey(defaultValue: 60)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 21)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 4)
  int    cnt_timer;
  @JsonKey(defaultValue: 5108)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen29 {
  factory _Screen29.fromJson(Map<String, dynamic> json) => _$Screen29FromJson(json);
  Map<String, dynamic> toJson() => _$Screen29ToJson(this);

  _Screen29({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面２ 　　　　 (user_cd29に648が有効)")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5065)
  int    sound;
  @JsonKey(defaultValue: 15)
  int    snd_timer;
  @JsonKey(defaultValue: 3)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen30 {
  factory _Screen30.fromJson(Map<String, dynamic> json) => _$Screen30FromJson(json);
  Map<String, dynamic> toJson() => _$Screen30ToJson(this);

  _Screen30({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面 　 　　　 (user_cd29に1160が有効)")
  String title;
  @JsonKey(defaultValue: "ポイントカードをスキャナーに差し込むか、　　　　  商品のバーコードをスキャナーに近づけてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 3)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5104)
  int    sound;
  @JsonKey(defaultValue: 60)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 21)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 4)
  int    cnt_timer;
  @JsonKey(defaultValue: 5107)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen31 {
  factory _Screen31.fromJson(Map<String, dynamic> json) => _$Screen31FromJson(json);
  Map<String, dynamic> toJson() => _$Screen31ToJson(this);

  _Screen31({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面２ 　　　　 (user_cd29に1160が有効)")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5097)
  int    sound;
  @JsonKey(defaultValue: 15)
  int    snd_timer;
  @JsonKey(defaultValue: 3)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen32 {
  factory _Screen32.fromJson(Map<String, dynamic> json) => _$Screen32FromJson(json);
  Map<String, dynamic> toJson() => _$Screen32ToJson(this);

  _Screen32({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面 　 　　　 (user_cd29に1672が有効)")
  String title;
  @JsonKey(defaultValue: "ポイントカードをスキャナーに差し込むか、　　　　  商品のバーコードをスキャナーに近づけてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 3)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5105)
  int    sound;
  @JsonKey(defaultValue: 60)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 21)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 4)
  int    cnt_timer;
  @JsonKey(defaultValue: 5108)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen33 {
  factory _Screen33.fromJson(Map<String, dynamic> json) => _$Screen33FromJson(json);
  Map<String, dynamic> toJson() => _$Screen33ToJson(this);

  _Screen33({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタート画面２ 　　　　 (user_cd29に1672が有効)")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5065)
  int    sound;
  @JsonKey(defaultValue: 15)
  int    snd_timer;
  @JsonKey(defaultValue: 3)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen34 {
  factory _Screen34.fromJson(Map<String, dynamic> json) => _$Screen34FromJson(json);
  Map<String, dynamic> toJson() => _$Screen34ToJson(this);

  _Screen34({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "エラーパスワード画面 　　 (user_cd29に8が有効)")
  String title;
  @JsonKey(defaultValue: "名札の氏名コードをスキャンして下さい")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 2)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen35 {
  factory _Screen35.fromJson(Map<String, dynamic> json) => _$Screen35FromJson(json);
  Map<String, dynamic> toJson() => _$Screen35ToJson(this);

  _Screen35({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "エラーパスワード画面")
  String title;
  @JsonKey(defaultValue: "従業員バーコードをスキャンして下さい")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 2)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen36 {
  factory _Screen36.fromJson(Map<String, dynamic> json) => _$Screen36FromJson(json);
  Map<String, dynamic> toJson() => _$Screen36ToJson(this);

  _Screen36({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "Suicaタッチ画面 　　　　　 (user_cd29に8が有効)")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5076)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 0)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen37 {
  factory _Screen37.fromJson(Map<String, dynamic> json) => _$Screen37FromJson(json);
  Map<String, dynamic> toJson() => _$Screen37ToJson(this);

  _Screen37({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "チャージ上限画面")
  String title;
  @JsonKey(defaultValue: "チャージ上限額を超えています　　　　　　　Ｓｕｉｃａでのお取り扱いはできません")
  String msg1;
  @JsonKey(defaultValue: "Suica上限額")
  String msg2;
  @JsonKey(defaultValue: 1)
  int    msg1_size;
  @JsonKey(defaultValue: 3)
  int    msg2_size;
  @JsonKey(defaultValue: 5015)
  int    sound;
  @JsonKey(defaultValue: 6)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 15)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen38 {
  factory _Screen38.fromJson(Map<String, dynamic> json) => _$Screen38FromJson(json);
  Map<String, dynamic> toJson() => _$Screen38ToJson(this);

  _Screen38({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "商品取消のダイアログ画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5089)
  int    sound;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen39 {
  factory _Screen39.fromJson(Map<String, dynamic> json) => _$Screen39FromJson(json);
  Map<String, dynamic> toJson() => _$Screen39ToJson(this);

  _Screen39({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "商品登録のダイアログ画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5090)
  int    sound;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen40 {
  factory _Screen40.fromJson(Map<String, dynamic> json) => _$Screen40FromJson(json);
  Map<String, dynamic> toJson() => _$Screen40ToJson(this);

  _Screen40({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スタートの支払選択画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5098)
  int    sound;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 15)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 5101)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
}

@JsonSerializable()
class _Screen41 {
  factory _Screen41.fromJson(Map<String, dynamic> json) => _$Screen41FromJson(json);
  Map<String, dynamic> toJson() => _$Screen41ToJson(this);

  _Screen41({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "支払選択画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5131)
  int    sound;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 5099)
  int    sound3;
}

@JsonSerializable()
class _Screen42 {
  factory _Screen42.fromJson(Map<String, dynamic> json) => _$Screen42FromJson(json);
  Map<String, dynamic> toJson() => _$Screen42ToJson(this);

  _Screen42({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "スキャンの選択画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5098)
  int    sound;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 5099)
  int    sound3;
}

@JsonSerializable()
class _Screen43 {
  factory _Screen43.fromJson(Map<String, dynamic> json) => _$Screen43FromJson(json);
  Map<String, dynamic> toJson() => _$Screen43ToJson(this);

  _Screen43({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound,
    required this.snd_timer,
    required this.edy_timer,
    required this.dsp_timer,
    required this.cncl_timer,
    required this.dsp_cnt_max,
    required this.cnt_timer,
    required this.sound2,
    required this.sound3,
  });

  @JsonKey(defaultValue: "小計の選択画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 5098)
  int    sound;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    edy_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_timer;
  @JsonKey(defaultValue: 60)
  int    cncl_timer;
  @JsonKey(defaultValue: 0)
  int    dsp_cnt_max;
  @JsonKey(defaultValue: 0)
  int    cnt_timer;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 5099)
  int    sound3;
}

