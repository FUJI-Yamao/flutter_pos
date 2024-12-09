/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'csvbkupJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class CsvbkupJsonFile extends ConfigJsonFile {
  static final CsvbkupJsonFile _instance = CsvbkupJsonFile._internal();

  final String _confPath = "conf/";
  final JsonLanguage _confLang = JsonLanguage.aa;
  final String _fileName = "csvbkup.json";

  CsvbkupJsonFile(){
    setPath(_confPath, _fileName, _confLang);
  }
  CsvbkupJsonFile._internal();

  factory CsvbkupJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$CsvbkupJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$CsvbkupJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$CsvbkupJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        max_item = _$Max_itemFromJson(jsonD['max_item']);
      } catch(e) {
        max_item = _$Max_itemFromJson({});
        ret = false;
      }
      try {
        page = _$PageFromJson(jsonD['page']);
      } catch(e) {
        page = _$PageFromJson({});
        ret = false;
      }
      try {
        item0 = _$Item0FromJson(jsonD['item0']);
      } catch(e) {
        item0 = _$Item0FromJson({});
        ret = false;
      }
      try {
        item1 = _$Item1FromJson(jsonD['item1']);
      } catch(e) {
        item1 = _$Item1FromJson({});
        ret = false;
      }
      try {
        item2 = _$Item2FromJson(jsonD['item2']);
      } catch(e) {
        item2 = _$Item2FromJson({});
        ret = false;
      }
      try {
        item3 = _$Item3FromJson(jsonD['item3']);
      } catch(e) {
        item3 = _$Item3FromJson({});
        ret = false;
      }
      try {
        item4 = _$Item4FromJson(jsonD['item4']);
      } catch(e) {
        item4 = _$Item4FromJson({});
        ret = false;
      }
      try {
        item5 = _$Item5FromJson(jsonD['item5']);
      } catch(e) {
        item5 = _$Item5FromJson({});
        ret = false;
      }
      try {
        item6 = _$Item6FromJson(jsonD['item6']);
      } catch(e) {
        item6 = _$Item6FromJson({});
        ret = false;
      }
      try {
        item7 = _$Item7FromJson(jsonD['item7']);
      } catch(e) {
        item7 = _$Item7FromJson({});
        ret = false;
      }
      try {
        item8 = _$Item8FromJson(jsonD['item8']);
      } catch(e) {
        item8 = _$Item8FromJson({});
        ret = false;
      }
      try {
        item9 = _$Item9FromJson(jsonD['item9']);
      } catch(e) {
        item9 = _$Item9FromJson({});
        ret = false;
      }
      try {
        item10 = _$Item10FromJson(jsonD['item10']);
      } catch(e) {
        item10 = _$Item10FromJson({});
        ret = false;
      }
      try {
        item11 = _$Item11FromJson(jsonD['item11']);
      } catch(e) {
        item11 = _$Item11FromJson({});
        ret = false;
      }
      try {
        item12 = _$Item12FromJson(jsonD['item12']);
      } catch(e) {
        item12 = _$Item12FromJson({});
        ret = false;
      }
      try {
        item13 = _$Item13FromJson(jsonD['item13']);
      } catch(e) {
        item13 = _$Item13FromJson({});
        ret = false;
      }
      try {
        item14 = _$Item14FromJson(jsonD['item14']);
      } catch(e) {
        item14 = _$Item14FromJson({});
        ret = false;
      }
      try {
        item15 = _$Item15FromJson(jsonD['item15']);
      } catch(e) {
        item15 = _$Item15FromJson({});
        ret = false;
      }
      try {
        item16 = _$Item16FromJson(jsonD['item16']);
      } catch(e) {
        item16 = _$Item16FromJson({});
        ret = false;
      }
      try {
        item17 = _$Item17FromJson(jsonD['item17']);
      } catch(e) {
        item17 = _$Item17FromJson({});
        ret = false;
      }
      try {
        item18 = _$Item18FromJson(jsonD['item18']);
      } catch(e) {
        item18 = _$Item18FromJson({});
        ret = false;
      }
      try {
        item19 = _$Item19FromJson(jsonD['item19']);
      } catch(e) {
        item19 = _$Item19FromJson({});
        ret = false;
      }
      try {
        item20 = _$Item20FromJson(jsonD['item20']);
      } catch(e) {
        item20 = _$Item20FromJson({});
        ret = false;
      }
      try {
        item21 = _$Item21FromJson(jsonD['item21']);
      } catch(e) {
        item21 = _$Item21FromJson({});
        ret = false;
      }
      try {
        item22 = _$Item22FromJson(jsonD['item22']);
      } catch(e) {
        item22 = _$Item22FromJson({});
        ret = false;
      }
      try {
        item23 = _$Item23FromJson(jsonD['item23']);
      } catch(e) {
        item23 = _$Item23FromJson({});
        ret = false;
      }
      try {
        item24 = _$Item24FromJson(jsonD['item24']);
      } catch(e) {
        item24 = _$Item24FromJson({});
        ret = false;
      }
      try {
        item25 = _$Item25FromJson(jsonD['item25']);
      } catch(e) {
        item25 = _$Item25FromJson({});
        ret = false;
      }
      try {
        item26 = _$Item26FromJson(jsonD['item26']);
      } catch(e) {
        item26 = _$Item26FromJson({});
        ret = false;
      }
      try {
        item27 = _$Item27FromJson(jsonD['item27']);
      } catch(e) {
        item27 = _$Item27FromJson({});
        ret = false;
      }
      try {
        item28 = _$Item28FromJson(jsonD['item28']);
      } catch(e) {
        item28 = _$Item28FromJson({});
        ret = false;
      }
      try {
        item29 = _$Item29FromJson(jsonD['item29']);
      } catch(e) {
        item29 = _$Item29FromJson({});
        ret = false;
      }
      try {
        item30 = _$Item30FromJson(jsonD['item30']);
      } catch(e) {
        item30 = _$Item30FromJson({});
        ret = false;
      }
      try {
        item31 = _$Item31FromJson(jsonD['item31']);
      } catch(e) {
        item31 = _$Item31FromJson({});
        ret = false;
      }
      try {
        item32 = _$Item32FromJson(jsonD['item32']);
      } catch(e) {
        item32 = _$Item32FromJson({});
        ret = false;
      }
      try {
        item33 = _$Item33FromJson(jsonD['item33']);
      } catch(e) {
        item33 = _$Item33FromJson({});
        ret = false;
      }
      try {
        item34 = _$Item34FromJson(jsonD['item34']);
      } catch(e) {
        item34 = _$Item34FromJson({});
        ret = false;
      }
      try {
        item35 = _$Item35FromJson(jsonD['item35']);
      } catch(e) {
        item35 = _$Item35FromJson({});
        ret = false;
      }
      try {
        item36 = _$Item36FromJson(jsonD['item36']);
      } catch(e) {
        item36 = _$Item36FromJson({});
        ret = false;
      }
      try {
        item37 = _$Item37FromJson(jsonD['item37']);
      } catch(e) {
        item37 = _$Item37FromJson({});
        ret = false;
      }
      try {
        item38 = _$Item38FromJson(jsonD['item38']);
      } catch(e) {
        item38 = _$Item38FromJson({});
        ret = false;
      }
      try {
        item39 = _$Item39FromJson(jsonD['item39']);
      } catch(e) {
        item39 = _$Item39FromJson({});
        ret = false;
      }
      try {
        item40 = _$Item40FromJson(jsonD['item40']);
      } catch(e) {
        item40 = _$Item40FromJson({});
        ret = false;
      }
      try {
        item41 = _$Item41FromJson(jsonD['item41']);
      } catch(e) {
        item41 = _$Item41FromJson({});
        ret = false;
      }
      try {
        item42 = _$Item42FromJson(jsonD['item42']);
      } catch(e) {
        item42 = _$Item42FromJson({});
        ret = false;
      }
      try {
        item43 = _$Item43FromJson(jsonD['item43']);
      } catch(e) {
        item43 = _$Item43FromJson({});
        ret = false;
      }
      try {
        item44 = _$Item44FromJson(jsonD['item44']);
      } catch(e) {
        item44 = _$Item44FromJson({});
        ret = false;
      }
      try {
        item45 = _$Item45FromJson(jsonD['item45']);
      } catch(e) {
        item45 = _$Item45FromJson({});
        ret = false;
      }
      try {
        item46 = _$Item46FromJson(jsonD['item46']);
      } catch(e) {
        item46 = _$Item46FromJson({});
        ret = false;
      }
      try {
        item47 = _$Item47FromJson(jsonD['item47']);
      } catch(e) {
        item47 = _$Item47FromJson({});
        ret = false;
      }
      try {
        item48 = _$Item48FromJson(jsonD['item48']);
      } catch(e) {
        item48 = _$Item48FromJson({});
        ret = false;
      }
      try {
        item49 = _$Item49FromJson(jsonD['item49']);
      } catch(e) {
        item49 = _$Item49FromJson({});
        ret = false;
      }
      try {
        item50 = _$Item50FromJson(jsonD['item50']);
      } catch(e) {
        item50 = _$Item50FromJson({});
        ret = false;
      }
      try {
        item51 = _$Item51FromJson(jsonD['item51']);
      } catch(e) {
        item51 = _$Item51FromJson({});
        ret = false;
      }
      try {
        item52 = _$Item52FromJson(jsonD['item52']);
      } catch(e) {
        item52 = _$Item52FromJson({});
        ret = false;
      }
      try {
        item53 = _$Item53FromJson(jsonD['item53']);
      } catch(e) {
        item53 = _$Item53FromJson({});
        ret = false;
      }
      try {
        item54 = _$Item54FromJson(jsonD['item54']);
      } catch(e) {
        item54 = _$Item54FromJson({});
        ret = false;
      }
      try {
        item55 = _$Item55FromJson(jsonD['item55']);
      } catch(e) {
        item55 = _$Item55FromJson({});
        ret = false;
      }
      try {
        item56 = _$Item56FromJson(jsonD['item56']);
      } catch(e) {
        item56 = _$Item56FromJson({});
        ret = false;
      }
      try {
        item57 = _$Item57FromJson(jsonD['item57']);
      } catch(e) {
        item57 = _$Item57FromJson({});
        ret = false;
      }
      try {
        item58 = _$Item58FromJson(jsonD['item58']);
      } catch(e) {
        item58 = _$Item58FromJson({});
        ret = false;
      }
      try {
        item59 = _$Item59FromJson(jsonD['item59']);
      } catch(e) {
        item59 = _$Item59FromJson({});
        ret = false;
      }
      try {
        item60 = _$Item60FromJson(jsonD['item60']);
      } catch(e) {
        item60 = _$Item60FromJson({});
        ret = false;
      }
      try {
        item61 = _$Item61FromJson(jsonD['item61']);
      } catch(e) {
        item61 = _$Item61FromJson({});
        ret = false;
      }
      try {
        item62 = _$Item62FromJson(jsonD['item62']);
      } catch(e) {
        item62 = _$Item62FromJson({});
        ret = false;
      }
      try {
        item63 = _$Item63FromJson(jsonD['item63']);
      } catch(e) {
        item63 = _$Item63FromJson({});
        ret = false;
      }
      try {
        item64 = _$Item64FromJson(jsonD['item64']);
      } catch(e) {
        item64 = _$Item64FromJson({});
        ret = false;
      }
      try {
        item65 = _$Item65FromJson(jsonD['item65']);
      } catch(e) {
        item65 = _$Item65FromJson({});
        ret = false;
      }
      try {
        item66 = _$Item66FromJson(jsonD['item66']);
      } catch(e) {
        item66 = _$Item66FromJson({});
        ret = false;
      }
      try {
        item67 = _$Item67FromJson(jsonD['item67']);
      } catch(e) {
        item67 = _$Item67FromJson({});
        ret = false;
      }
      try {
        item68 = _$Item68FromJson(jsonD['item68']);
      } catch(e) {
        item68 = _$Item68FromJson({});
        ret = false;
      }
      try {
        item69 = _$Item69FromJson(jsonD['item69']);
      } catch(e) {
        item69 = _$Item69FromJson({});
        ret = false;
      }
      try {
        item70 = _$Item70FromJson(jsonD['item70']);
      } catch(e) {
        item70 = _$Item70FromJson({});
        ret = false;
      }
      try {
        item71 = _$Item71FromJson(jsonD['item71']);
      } catch(e) {
        item71 = _$Item71FromJson({});
        ret = false;
      }
      try {
        item72 = _$Item72FromJson(jsonD['item72']);
      } catch(e) {
        item72 = _$Item72FromJson({});
        ret = false;
      }
      try {
        item73 = _$Item73FromJson(jsonD['item73']);
      } catch(e) {
        item73 = _$Item73FromJson({});
        ret = false;
      }
      try {
        item74 = _$Item74FromJson(jsonD['item74']);
      } catch(e) {
        item74 = _$Item74FromJson({});
        ret = false;
      }
      try {
        item75 = _$Item75FromJson(jsonD['item75']);
      } catch(e) {
        item75 = _$Item75FromJson({});
        ret = false;
      }
      try {
        item76 = _$Item76FromJson(jsonD['item76']);
      } catch(e) {
        item76 = _$Item76FromJson({});
        ret = false;
      }
      try {
        item77 = _$Item77FromJson(jsonD['item77']);
      } catch(e) {
        item77 = _$Item77FromJson({});
        ret = false;
      }
      try {
        item78 = _$Item78FromJson(jsonD['item78']);
      } catch(e) {
        item78 = _$Item78FromJson({});
        ret = false;
      }
      try {
        item79 = _$Item79FromJson(jsonD['item79']);
      } catch(e) {
        item79 = _$Item79FromJson({});
        ret = false;
      }
      try {
        item80 = _$Item80FromJson(jsonD['item80']);
      } catch(e) {
        item80 = _$Item80FromJson({});
        ret = false;
      }
      try {
        item81 = _$Item81FromJson(jsonD['item81']);
      } catch(e) {
        item81 = _$Item81FromJson({});
        ret = false;
      }
      try {
        item82 = _$Item82FromJson(jsonD['item82']);
      } catch(e) {
        item82 = _$Item82FromJson({});
        ret = false;
      }
      try {
        item83 = _$Item83FromJson(jsonD['item83']);
      } catch(e) {
        item83 = _$Item83FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Max_item max_item = _Max_item(
    total_item                         : 0,
  );

  _Page page = _Page(
    total_page                         : 0,
    onoff0                             : 0,
    onoff1                             : 0,
    onoff2                             : 0,
    onoff3                             : 0,
    onoff4                             : 0,
    onoff5                             : 0,
    onoff6                             : 0,
  );

  _Item0 item0 = _Item0(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    t_exe3                             : "",
    t_exe4                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item1 item1 = _Item1(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item2 item2 = _Item2(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item3 item3 = _Item3(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item4 item4 = _Item4(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item5 item5 = _Item5(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item6 item6 = _Item6(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item7 item7 = _Item7(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item8 item8 = _Item8(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item9 item9 = _Item9(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item10 item10 = _Item10(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item11 item11 = _Item11(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item12 item12 = _Item12(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item13 item13 = _Item13(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item14 item14 = _Item14(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item15 item15 = _Item15(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    t_exe3                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item16 item16 = _Item16(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item17 item17 = _Item17(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item18 item18 = _Item18(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item19 item19 = _Item19(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item20 item20 = _Item20(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item21 item21 = _Item21(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item22 item22 = _Item22(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item23 item23 = _Item23(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item24 item24 = _Item24(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item25 item25 = _Item25(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item26 item26 = _Item26(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item27 item27 = _Item27(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item28 item28 = _Item28(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    t_exe3                             : "",
    t_exe4                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item29 item29 = _Item29(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item30 item30 = _Item30(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item31 item31 = _Item31(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item32 item32 = _Item32(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item33 item33 = _Item33(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item34 item34 = _Item34(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item35 item35 = _Item35(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item36 item36 = _Item36(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item37 item37 = _Item37(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item38 item38 = _Item38(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item39 item39 = _Item39(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item40 item40 = _Item40(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item41 item41 = _Item41(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item42 item42 = _Item42(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item43 item43 = _Item43(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item44 item44 = _Item44(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item45 item45 = _Item45(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item46 item46 = _Item46(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item47 item47 = _Item47(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item48 item48 = _Item48(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item49 item49 = _Item49(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item50 item50 = _Item50(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item51 item51 = _Item51(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item52 item52 = _Item52(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item53 item53 = _Item53(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item54 item54 = _Item54(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    t_exe3                             : "",
    t_exe4                             : "",
    t_exe5                             : "",
    t_exe6                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item55 item55 = _Item55(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item56 item56 = _Item56(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item57 item57 = _Item57(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item58 item58 = _Item58(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item59 item59 = _Item59(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item60 item60 = _Item60(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item61 item61 = _Item61(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item62 item62 = _Item62(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item63 item63 = _Item63(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item64 item64 = _Item64(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item65 item65 = _Item65(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item66 item66 = _Item66(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item67 item67 = _Item67(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item68 item68 = _Item68(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item69 item69 = _Item69(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item70 item70 = _Item70(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item71 item71 = _Item71(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item72 item72 = _Item72(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item73 item73 = _Item73(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item74 item74 = _Item74(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item75 item75 = _Item75(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    t_exe3                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item76 item76 = _Item76(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item77 item77 = _Item77(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item78 item78 = _Item78(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    t_exe2                             : "",
    t_exe3                             : "",
    t_exe4                             : "",
    t_exe5                             : "",
    t_exe6                             : "",
    t_exe7                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
  );

  _Item79 item79 = _Item79(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item80 item80 = _Item80(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item81 item81 = _Item81(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item82 item82 = _Item82(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item83 item83 = _Item83(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    keyword3                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );
}

@JsonSerializable()
class _Max_item {
  factory _Max_item.fromJson(Map<String, dynamic> json) => _$Max_itemFromJson(json);
  Map<String, dynamic> toJson() => _$Max_itemToJson(this);

  _Max_item({
    required this.total_item,
  });

  @JsonKey(defaultValue: 84)
  int    total_item;
}

@JsonSerializable()
class _Page {
  factory _Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);
  Map<String, dynamic> toJson() => _$PageToJson(this);

  _Page({
    required this.total_page,
    required this.onoff0,
    required this.onoff1,
    required this.onoff2,
    required this.onoff3,
    required this.onoff4,
    required this.onoff5,
    required this.onoff6,
  });

  @JsonKey(defaultValue: 7)
  int    total_page;
  @JsonKey(defaultValue: 0)
  int    onoff0;
  @JsonKey(defaultValue: 0)
  int    onoff1;
  @JsonKey(defaultValue: 0)
  int    onoff2;
  @JsonKey(defaultValue: 1)
  int    onoff3;
  @JsonKey(defaultValue: 1)
  int    onoff4;
  @JsonKey(defaultValue: 0)
  int    onoff5;
  @JsonKey(defaultValue: 0)
  int    onoff6;
}

@JsonSerializable()
class _Item0 {
  factory _Item0.fromJson(Map<String, dynamic> json) => _$Item0FromJson(json);
  Map<String, dynamic> toJson() => _$Item0ToJson(this);

  _Item0({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.t_exe3,
    required this.t_exe4,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 8)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 1)
  int    position;
  @JsonKey(defaultValue: "ﾚｼﾞ日別取引")
  String table1;
  @JsonKey(defaultValue: 4)
  int    total;
  @JsonKey(defaultValue: "reg_dly_deal")
  String t_exe1;
  @JsonKey(defaultValue: "reg_dly_flow")
  String t_exe2;
  @JsonKey(defaultValue: "reg_dly_inout")
  String t_exe3;
  @JsonKey(defaultValue: "reg_dly_acr")
  String t_exe4;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_deal")
  String keyword;
  @JsonKey(defaultValue: "dlydeal_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item1 {
  factory _Item1.fromJson(Map<String, dynamic> json) => _$Item1FromJson(json);
  Map<String, dynamic> toJson() => _$Item1ToJson(this);

  _Item1({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 16)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 2)
  int    position;
  @JsonKey(defaultValue: "中分類日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_mdl")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_mdl")
  String keyword;
  @JsonKey(defaultValue: "dlymdl_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item2 {
  factory _Item2.fromJson(Map<String, dynamic> json) => _$Item2FromJson(json);
  Map<String, dynamic> toJson() => _$Item2ToJson(this);

  _Item2({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 32)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 3)
  int    position;
  @JsonKey(defaultValue: "小分類日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_sml")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_sml")
  String keyword;
  @JsonKey(defaultValue: "dlysml_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item3 {
  factory _Item3.fromJson(Map<String, dynamic> json) => _$Item3FromJson(json);
  Map<String, dynamic> toJson() => _$Item3ToJson(this);

  _Item3({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 64)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 4)
  int    position;
  @JsonKey(defaultValue: "単品日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_plu")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_plu")
  String keyword;
  @JsonKey(defaultValue: "dlyplu_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item4 {
  factory _Item4.fromJson(Map<String, dynamic> json) => _$Item4FromJson(json);
  Map<String, dynamic> toJson() => _$Item4ToJson(this);

  _Item4({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 1024)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 5)
  int    position;
  @JsonKey(defaultValue: "ｶﾃｺﾞﾘ値引日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_cat")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_cat")
  String keyword;
  @JsonKey(defaultValue: "dlycat_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item5 {
  factory _Item5.fromJson(Map<String, dynamic> json) => _$Item5FromJson(json);
  Map<String, dynamic> toJson() => _$Item5ToJson(this);

  _Item5({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 128)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 7)
  int    position;
  @JsonKey(defaultValue: "特売日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_brgn")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_brgn")
  String keyword;
  @JsonKey(defaultValue: "dlybrgn_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item6 {
  factory _Item6.fromJson(Map<String, dynamic> json) => _$Item6FromJson(json);
  Map<String, dynamic> toJson() => _$Item6ToJson(this);

  _Item6({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 768)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 8)
  int    position;
  @JsonKey(defaultValue: "企画日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_mach")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_mach")
  String keyword;
  @JsonKey(defaultValue: "dlymach_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item7 {
  factory _Item7.fromJson(Map<String, dynamic> json) => _$Item7FromJson(json);
  Map<String, dynamic> toJson() => _$Item7ToJson(this);

  _Item7({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 9)
  int    position;
  @JsonKey(defaultValue: "仮登録ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_tmp_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_tmp")
  String keyword;
  @JsonKey(defaultValue: "dlytmp_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item8 {
  factory _Item8.fromJson(Map<String, dynamic> json) => _$Item8FromJson(json);
  Map<String, dynamic> toJson() => _$Item8ToJson(this);

  _Item8({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 10)
  int    position;
  @JsonKey(defaultValue: "売価変更ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_prcchg_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_prcchg")
  String keyword;
  @JsonKey(defaultValue: "dlyprcchgl_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item9 {
  factory _Item9.fromJson(Map<String, dynamic> json) => _$Item9FromJson(json);
  Map<String, dynamic> toJson() => _$Item9ToJson(this);

  _Item9({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 11)
  int    position;
  @JsonKey(defaultValue: "ｸﾚｼﾞｯﾄ")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_crdt_demand_tbl")
  String t_exe1;
  @JsonKey(defaultValue: "c_crdt_actual_log")
  String t_exe2;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_crdt")
  String keyword;
  @JsonKey(defaultValue: "dlycrdt_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item10 {
  factory _Item10.fromJson(Map<String, dynamic> json) => _$Item10FromJson(json);
  Map<String, dynamic> toJson() => _$Item10ToJson(this);

  _Item10({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 13)
  int    position;
  @JsonKey(defaultValue: "ｱｲﾃﾑﾛｸﾞ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_itemlog")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_itemlog")
  String keyword;
  @JsonKey(defaultValue: "dlyitemlog_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item11 {
  factory _Item11.fromJson(Map<String, dynamic> json) => _$Item11FromJson(json);
  Map<String, dynamic> toJson() => _$Item11ToJson(this);

  _Item11({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 256)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 14)
  int    position;
  @JsonKey(defaultValue: "ﾐｯｸｽﾏｯﾁﾛｸﾞ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_bdllog")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_bdllog")
  String keyword;
  @JsonKey(defaultValue: "dlybdllog_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item12 {
  factory _Item12.fromJson(Map<String, dynamic> json) => _$Item12FromJson(json);
  Map<String, dynamic> toJson() => _$Item12ToJson(this);

  _Item12({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 512)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 15)
  int    position;
  @JsonKey(defaultValue: "ｾｯﾄﾏｯﾁﾛｸﾞ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_stmlog")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_stmlog")
  String keyword;
  @JsonKey(defaultValue: "dlystmlog_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item13 {
  factory _Item13.fromJson(Map<String, dynamic> json) => _$Item13FromJson(json);
  Map<String, dynamic> toJson() => _$Item13ToJson(this);

  _Item13({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 16)
  int    position;
  @JsonKey(defaultValue: "ﾄｰﾀﾙﾛｸﾞ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_ttllog")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_ttllog")
  String keyword;
  @JsonKey(defaultValue: "dlyttllog_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item14 {
  factory _Item14.fromJson(Map<String, dynamic> json) => _$Item14FromJson(json);
  Map<String, dynamic> toJson() => _$Item14ToJson(this);

  _Item14({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 2)
  int    page;
  @JsonKey(defaultValue: 13)
  int    position;
  @JsonKey(defaultValue: "電子ｼﾞｬｰﾅﾙ累計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_ejlog")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_ejlog_manual")
  String keyword;
  @JsonKey(defaultValue: "dlyejlog_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item15 {
  factory _Item15.fromJson(Map<String, dynamic> json) => _$Item15FromJson(json);
  Map<String, dynamic> toJson() => _$Item15ToJson(this);

  _Item15({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.t_exe3,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 8)
  int    onoff;
  @JsonKey(defaultValue: 2)
  int    page;
  @JsonKey(defaultValue: 1)
  int    position;
  @JsonKey(defaultValue: "ﾚｼﾞ累計取引実績")
  String table1;
  @JsonKey(defaultValue: 3)
  int    total;
  @JsonKey(defaultValue: "reg_mly_deal")
  String t_exe1;
  @JsonKey(defaultValue: "reg_mly_flow")
  String t_exe2;
  @JsonKey(defaultValue: "reg_mly_inout")
  String t_exe3;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_deal")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item16 {
  factory _Item16.fromJson(Map<String, dynamic> json) => _$Item16FromJson(json);
  Map<String, dynamic> toJson() => _$Item16ToJson(this);

  _Item16({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 16)
  int    onoff;
  @JsonKey(defaultValue: 2)
  int    page;
  @JsonKey(defaultValue: 2)
  int    position;
  @JsonKey(defaultValue: "中分類累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_mly_mdl")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_mdl")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item17 {
  factory _Item17.fromJson(Map<String, dynamic> json) => _$Item17FromJson(json);
  Map<String, dynamic> toJson() => _$Item17ToJson(this);

  _Item17({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 32)
  int    onoff;
  @JsonKey(defaultValue: 2)
  int    page;
  @JsonKey(defaultValue: 3)
  int    position;
  @JsonKey(defaultValue: "小分類累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_mly_sml")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_sml")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item18 {
  factory _Item18.fromJson(Map<String, dynamic> json) => _$Item18FromJson(json);
  Map<String, dynamic> toJson() => _$Item18ToJson(this);

  _Item18({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 64)
  int    onoff;
  @JsonKey(defaultValue: 2)
  int    page;
  @JsonKey(defaultValue: 4)
  int    position;
  @JsonKey(defaultValue: "単品累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_mly_plu")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_plu")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item19 {
  factory _Item19.fromJson(Map<String, dynamic> json) => _$Item19FromJson(json);
  Map<String, dynamic> toJson() => _$Item19ToJson(this);

  _Item19({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 1024)
  int    onoff;
  @JsonKey(defaultValue: 2)
  int    page;
  @JsonKey(defaultValue: 5)
  int    position;
  @JsonKey(defaultValue: "ｶﾃｺﾞﾘ値引累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_mly_cat")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_cat")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item20 {
  factory _Item20.fromJson(Map<String, dynamic> json) => _$Item20FromJson(json);
  Map<String, dynamic> toJson() => _$Item20ToJson(this);

  _Item20({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 128)
  int    onoff;
  @JsonKey(defaultValue: 2)
  int    page;
  @JsonKey(defaultValue: 7)
  int    position;
  @JsonKey(defaultValue: "特売累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_sch_brgn")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_sch_brgn")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item21 {
  factory _Item21.fromJson(Map<String, dynamic> json) => _$Item21FromJson(json);
  Map<String, dynamic> toJson() => _$Item21ToJson(this);

  _Item21({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 768)
  int    onoff;
  @JsonKey(defaultValue: 2)
  int    page;
  @JsonKey(defaultValue: 8)
  int    position;
  @JsonKey(defaultValue: "企画累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_sch_mach")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_sch_mach")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item22 {
  factory _Item22.fromJson(Map<String, dynamic> json) => _$Item22FromJson(json);
  Map<String, dynamic> toJson() => _$Item22ToJson(this);

  _Item22({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 1)
  int    position;
  @JsonKey(defaultValue: "中分類ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_mdlcls_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_stremdl_mst")
  String t_exe2;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "mdl_cls_mst")
  String keyword;
  @JsonKey(defaultValue: "mdlcls_week")
  String keyword2;
  @JsonKey(defaultValue: "mdlcls_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item23 {
  factory _Item23.fromJson(Map<String, dynamic> json) => _$Item23FromJson(json);
  Map<String, dynamic> toJson() => _$Item23ToJson(this);

  _Item23({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 2)
  int    position;
  @JsonKey(defaultValue: "小分類ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_smlcls_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_stresml_mst")
  String t_exe2;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "sml_cls_mst")
  String keyword;
  @JsonKey(defaultValue: "smlcls_week")
  String keyword2;
  @JsonKey(defaultValue: "smlcls_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item24 {
  factory _Item24.fromJson(Map<String, dynamic> json) => _$Item24FromJson(json);
  Map<String, dynamic> toJson() => _$Item24ToJson(this);

  _Item24({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 3)
  int    position;
  @JsonKey(defaultValue: "商品ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_plu_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_scanplu_mst")
  String t_exe2;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "plu_mst")
  String keyword;
  @JsonKey(defaultValue: "plumst_week")
  String keyword2;
  @JsonKey(defaultValue: "plumst_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item25 {
  factory _Item25.fromJson(Map<String, dynamic> json) => _$Item25FromJson(json);
  Map<String, dynamic> toJson() => _$Item25ToJson(this);

  _Item25({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 4)
  int    position;
  @JsonKey(defaultValue: "ｶﾃｺﾞﾘ値引ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_cat_dsc_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "cat_dsc_mst")
  String keyword;
  @JsonKey(defaultValue: "catdsc_week")
  String keyword2;
  @JsonKey(defaultValue: "catdsc_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item26 {
  factory _Item26.fromJson(Map<String, dynamic> json) => _$Item26FromJson(json);
  Map<String, dynamic> toJson() => _$Item26ToJson(this);

  _Item26({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 7)
  int    position;
  @JsonKey(defaultValue: "特売ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_brgnsch_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_brgnitem_mst")
  String t_exe2;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "brgn_mst")
  String keyword;
  @JsonKey(defaultValue: "brgnmst_week")
  String keyword2;
  @JsonKey(defaultValue: "brgnmst_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item27 {
  factory _Item27.fromJson(Map<String, dynamic> json) => _$Item27FromJson(json);
  Map<String, dynamic> toJson() => _$Item27ToJson(this);

  _Item27({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 8)
  int    position;
  @JsonKey(defaultValue: "ﾐｯｸｽﾏｯﾁﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_bdlsch_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_bdlitem_mst")
  String t_exe2;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "bdl_mst")
  String keyword;
  @JsonKey(defaultValue: "bdlmst_week")
  String keyword2;
  @JsonKey(defaultValue: "bdlmst_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item28 {
  factory _Item28.fromJson(Map<String, dynamic> json) => _$Item28FromJson(json);
  Map<String, dynamic> toJson() => _$Item28ToJson(this);

  _Item28({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.t_exe3,
    required this.t_exe4,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 9)
  int    position;
  @JsonKey(defaultValue: "ｾｯﾄﾏｯﾁﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 4)
  int    total;
  @JsonKey(defaultValue: "c_stmsch_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_stmitem_mst")
  String t_exe2;
  @JsonKey(defaultValue: "c_stmsch2_mst")
  String t_exe3;
  @JsonKey(defaultValue: "c_stmitem2_mst")
  String t_exe4;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "stm_mst")
  String keyword;
  @JsonKey(defaultValue: "stmmst_week")
  String keyword2;
  @JsonKey(defaultValue: "stmmst_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item29 {
  factory _Item29.fromJson(Map<String, dynamic> json) => _$Item29FromJson(json);
  Map<String, dynamic> toJson() => _$Item29ToJson(this);

  _Item29({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 13)
  int    position;
  @JsonKey(defaultValue: "従業員ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_staff_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "staff_mst")
  String keyword;
  @JsonKey(defaultValue: "staffmst_week")
  String keyword2;
  @JsonKey(defaultValue: "staffmst_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item30 {
  factory _Item30.fromJson(Map<String, dynamic> json) => _$Item30FromJson(json);
  Map<String, dynamic> toJson() => _$Item30ToJson(this);

  _Item30({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: -1)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 1)
  int    position;
  @JsonKey(defaultValue: "会員日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dmly_cust")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_cust")
  String keyword;
  @JsonKey(defaultValue: "dlycust_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item31 {
  factory _Item31.fromJson(Map<String, dynamic> json) => _$Item31FromJson(json);
  Map<String, dynamic> toJson() => _$Item31ToJson(this);

  _Item31({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 2049)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 2)
  int    position;
  @JsonKey(defaultValue: "地区日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_zone")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_zone")
  String keyword;
  @JsonKey(defaultValue: "dlyzone_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item32 {
  factory _Item32.fromJson(Map<String, dynamic> json) => _$Item32FromJson(json);
  Map<String, dynamic> toJson() => _$Item32ToJson(this);

  _Item32({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 2049)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 3)
  int    position;
  @JsonKey(defaultValue: "ｻｰﾋﾞｽ分類日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_svs")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_svs")
  String keyword;
  @JsonKey(defaultValue: "dlysvs_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item33 {
  factory _Item33.fromJson(Map<String, dynamic> json) => _$Item33FromJson(json);
  Map<String, dynamic> toJson() => _$Item33ToJson(this);

  _Item33({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 8194)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 6)
  int    position;
  @JsonKey(defaultValue: "FSP単品日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_fspplu")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_fspplu")
  String keyword;
  @JsonKey(defaultValue: "dlyfspplu_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item34 {
  factory _Item34.fromJson(Map<String, dynamic> json) => _$Item34FromJson(json);
  Map<String, dynamic> toJson() => _$Item34ToJson(this);

  _Item34({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 8194)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 4)
  int    position;
  @JsonKey(defaultValue: "FSP中分類日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_fspmdl")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_fspmdl")
  String keyword;
  @JsonKey(defaultValue: "dlyfspmdl_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item35 {
  factory _Item35.fromJson(Map<String, dynamic> json) => _$Item35FromJson(json);
  Map<String, dynamic> toJson() => _$Item35ToJson(this);

  _Item35({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 8194)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 5)
  int    position;
  @JsonKey(defaultValue: "FSP小分類日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_fspsml")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_fspsml")
  String keyword;
  @JsonKey(defaultValue: "dlyfspsml_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item36 {
  factory _Item36.fromJson(Map<String, dynamic> json) => _$Item36FromJson(json);
  Map<String, dynamic> toJson() => _$Item36ToJson(this);

  _Item36({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 8194)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 13)
  int    position;
  @JsonKey(defaultValue: "FSP合計日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_fspttl")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_fspttl")
  String keyword;
  @JsonKey(defaultValue: "dlyfspttl_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item37 {
  factory _Item37.fromJson(Map<String, dynamic> json) => _$Item37FromJson(json);
  Map<String, dynamic> toJson() => _$Item37ToJson(this);

  _Item37({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 4097)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 7)
  int    position;
  @JsonKey(defaultValue: "会員日計+累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dmly_cust")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_cust")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item38 {
  factory _Item38.fromJson(Map<String, dynamic> json) => _$Item38FromJson(json);
  Map<String, dynamic> toJson() => _$Item38ToJson(this);

  _Item38({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 2049)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 8)
  int    position;
  @JsonKey(defaultValue: "地区累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_mly_zone")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_zone")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item39 {
  factory _Item39.fromJson(Map<String, dynamic> json) => _$Item39FromJson(json);
  Map<String, dynamic> toJson() => _$Item39ToJson(this);

  _Item39({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 2049)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 9)
  int    position;
  @JsonKey(defaultValue: "ｻｰﾋﾞｽ分類累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_mly_svs")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_svs")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item40 {
  factory _Item40.fromJson(Map<String, dynamic> json) => _$Item40FromJson(json);
  Map<String, dynamic> toJson() => _$Item40ToJson(this);

  _Item40({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 8194)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 12)
  int    position;
  @JsonKey(defaultValue: "FSP単品累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_mly_fspplu")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_fspplu")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item41 {
  factory _Item41.fromJson(Map<String, dynamic> json) => _$Item41FromJson(json);
  Map<String, dynamic> toJson() => _$Item41ToJson(this);

  _Item41({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 8194)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 10)
  int    position;
  @JsonKey(defaultValue: "FSP中分類累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_mly_fspmdl")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_fspmdl")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item42 {
  factory _Item42.fromJson(Map<String, dynamic> json) => _$Item42FromJson(json);
  Map<String, dynamic> toJson() => _$Item42ToJson(this);

  _Item42({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 8194)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 11)
  int    position;
  @JsonKey(defaultValue: "FSP小分類累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_mly_fspsml")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_fspsml")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item43 {
  factory _Item43.fromJson(Map<String, dynamic> json) => _$Item43FromJson(json);
  Map<String, dynamic> toJson() => _$Item43ToJson(this);

  _Item43({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 8194)
  int    onoff;
  @JsonKey(defaultValue: 4)
  int    page;
  @JsonKey(defaultValue: 14)
  int    position;
  @JsonKey(defaultValue: "FSP合計累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_mly_fspttl")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_fspttl")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item44 {
  factory _Item44.fromJson(Map<String, dynamic> json) => _$Item44FromJson(json);
  Map<String, dynamic> toJson() => _$Item44ToJson(this);

  _Item44({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 5)
  int    page;
  @JsonKey(defaultValue: 1)
  int    position;
  @JsonKey(defaultValue: "会員ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_cust_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_cust_enq_tbl")
  String t_exe2;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "cust_mst")
  String keyword;
  @JsonKey(defaultValue: "custmst_week")
  String keyword2;
  @JsonKey(defaultValue: "custmst_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item45 {
  factory _Item45.fromJson(Map<String, dynamic> json) => _$Item45FromJson(json);
  Map<String, dynamic> toJson() => _$Item45ToJson(this);

  _Item45({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 5)
  int    page;
  @JsonKey(defaultValue: 2)
  int    position;
  @JsonKey(defaultValue: "地区ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "zone_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "zone_mst")
  String keyword;
  @JsonKey(defaultValue: "zonemst_week")
  String keyword2;
  @JsonKey(defaultValue: "zonemst_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item46 {
  factory _Item46.fromJson(Map<String, dynamic> json) => _$Item46FromJson(json);
  Map<String, dynamic> toJson() => _$Item46ToJson(this);

  _Item46({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 5)
  int    page;
  @JsonKey(defaultValue: 3)
  int    position;
  @JsonKey(defaultValue: "ｻｰﾋﾞｽ分類ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_svs_cls_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "svs_mst")
  String keyword;
  @JsonKey(defaultValue: "svsmst_week")
  String keyword2;
  @JsonKey(defaultValue: "svsmst_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item47 {
  factory _Item47.fromJson(Map<String, dynamic> json) => _$Item47FromJson(json);
  Map<String, dynamic> toJson() => _$Item47ToJson(this);

  _Item47({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 5)
  int    page;
  @JsonKey(defaultValue: 13)
  int    position;
  @JsonKey(defaultValue: "FSPｽｹｼﾞｭｰﾙ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_fspsch_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "fspsch_mst")
  String keyword;
  @JsonKey(defaultValue: "fspschmst_week")
  String keyword2;
  @JsonKey(defaultValue: "fspschmst_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item48 {
  factory _Item48.fromJson(Map<String, dynamic> json) => _$Item48FromJson(json);
  Map<String, dynamic> toJson() => _$Item48ToJson(this);

  _Item48({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 5)
  int    page;
  @JsonKey(defaultValue: 8)
  int    position;
  @JsonKey(defaultValue: "FSP商品ﾃｰﾌﾞﾙ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_fspplan_plu_tbl")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "fspplan_plu")
  String keyword;
  @JsonKey(defaultValue: "fspplanplu_week")
  String keyword2;
  @JsonKey(defaultValue: "fspplanplu_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item49 {
  factory _Item49.fromJson(Map<String, dynamic> json) => _$Item49FromJson(json);
  Map<String, dynamic> toJson() => _$Item49ToJson(this);

  _Item49({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 5)
  int    page;
  @JsonKey(defaultValue: 9)
  int    position;
  @JsonKey(defaultValue: "FSP中分類ﾃｰﾌﾞﾙ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_fspplan_mdlcls_tbl")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "fspplan_mdl")
  String keyword;
  @JsonKey(defaultValue: "fspplanmdl_week")
  String keyword2;
  @JsonKey(defaultValue: "fspplanmdl_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item50 {
  factory _Item50.fromJson(Map<String, dynamic> json) => _$Item50FromJson(json);
  Map<String, dynamic> toJson() => _$Item50ToJson(this);

  _Item50({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 5)
  int    page;
  @JsonKey(defaultValue: 7)
  int    position;
  @JsonKey(defaultValue: "FSP小分類ﾃｰﾌﾞﾙ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_fspplan_smlcls_tbl")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "fspplan_sml")
  String keyword;
  @JsonKey(defaultValue: "fspplansml_week")
  String keyword2;
  @JsonKey(defaultValue: "fspplansml_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item51 {
  factory _Item51.fromJson(Map<String, dynamic> json) => _$Item51FromJson(json);
  Map<String, dynamic> toJson() => _$Item51ToJson(this);

  _Item51({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 17)
  int    position;
  @JsonKey(defaultValue: "履歴ﾛｸﾞ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "histlog_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "histlog")
  String keyword;
  @JsonKey(defaultValue: "histlog_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item52 {
  factory _Item52.fromJson(Map<String, dynamic> json) => _$Item52FromJson(json);
  Map<String, dynamic> toJson() => _$Item52ToJson(this);

  _Item52({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 18)
  int    position;
  @JsonKey(defaultValue: "電子ｼﾞｬｰﾅﾙ日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_ejlog")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_ejlog")
  String keyword;
  @JsonKey(defaultValue: "dlyejlog_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item53 {
  factory _Item53.fromJson(Map<String, dynamic> json) => _$Item53FromJson(json);
  Map<String, dynamic> toJson() => _$Item53ToJson(this);

  _Item53({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 1)
  int    position;
  @JsonKey(defaultValue: "ﾀｰﾐﾅﾙ")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_trm_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_cust_trm_mst")
  String t_exe2;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "dly_trm")
  String keyword;
  @JsonKey(defaultValue: "dlytrm_week")
  String keyword2;
  @JsonKey(defaultValue: "dlytrm_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item54 {
  factory _Item54.fromJson(Map<String, dynamic> json) => _$Item54FromJson(json);
  Map<String, dynamic> toJson() => _$Item54ToJson(this);

  _Item54({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.t_exe3,
    required this.t_exe4,
    required this.t_exe5,
    required this.t_exe6,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 7)
  int    position;
  @JsonKey(defaultValue: "ｷｰｵﾌﾟｼｮﾝ")
  String table1;
  @JsonKey(defaultValue: 6)
  int    total;
  @JsonKey(defaultValue: "c_kopttran_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_koptinout_mst")
  String t_exe2;
  @JsonKey(defaultValue: "c_koptdisc_mst")
  String t_exe3;
  @JsonKey(defaultValue: "c_koptref_mst")
  String t_exe4;
  @JsonKey(defaultValue: "c_koptoth_mst")
  String t_exe5;
  @JsonKey(defaultValue: "c_koptcmn_mst")
  String t_exe6;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "dly_kopt")
  String keyword;
  @JsonKey(defaultValue: "dlykopt_week")
  String keyword2;
  @JsonKey(defaultValue: "dlykopt_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item55 {
  factory _Item55.fromJson(Map<String, dynamic> json) => _$Item55FromJson(json);
  Map<String, dynamic> toJson() => _$Item55ToJson(this);

  _Item55({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 2)
  int    position;
  @JsonKey(defaultValue: "ﾚｼｰﾄﾒｯｾｰｼﾞ")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_recmsg_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_schmsg_mst")
  String t_exe2;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "dly_recmsg")
  String keyword;
  @JsonKey(defaultValue: "dlyrecmsg_week")
  String keyword2;
  @JsonKey(defaultValue: "dlyrecmsg_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item56 {
  factory _Item56.fromJson(Map<String, dynamic> json) => _$Item56FromJson(json);
  Map<String, dynamic> toJson() => _$Item56ToJson(this);

  _Item56({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 8)
  int    position;
  @JsonKey(defaultValue: "ﾌﾟﾘｾｯﾄ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_preset_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "dly_preset")
  String keyword;
  @JsonKey(defaultValue: "dlypreset_week")
  String keyword2;
  @JsonKey(defaultValue: "dlypreset_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item57 {
  factory _Item57.fromJson(Map<String, dynamic> json) => _$Item57FromJson(json);
  Map<String, dynamic> toJson() => _$Item57ToJson(this);

  _Item57({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 3)
  int    position;
  @JsonKey(defaultValue: "予約ﾚﾎﾟｰﾄ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_batrepo_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "dly_batrepo")
  String keyword;
  @JsonKey(defaultValue: "dlybatrepo_week")
  String keyword2;
  @JsonKey(defaultValue: "dlybatrepo_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item58 {
  factory _Item58.fromJson(Map<String, dynamic> json) => _$Item58FromJson(json);
  Map<String, dynamic> toJson() => _$Item58ToJson(this);

  _Item58({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 9)
  int    position;
  @JsonKey(defaultValue: "ｲﾒｰｼﾞ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_img_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "dly_img")
  String keyword;
  @JsonKey(defaultValue: "dlyimg_week")
  String keyword2;
  @JsonKey(defaultValue: "dlyimg_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item59 {
  factory _Item59.fromJson(Map<String, dynamic> json) => _$Item59FromJson(json);
  Map<String, dynamic> toJson() => _$Item59ToJson(this);

  _Item59({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 6)
  int    position;
  @JsonKey(defaultValue: "単品日計TPR8100")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "PLUD8")
  String t_exe1;
  @JsonKey(defaultValue: "csv_tpr8100")
  String section;
  @JsonKey(defaultValue: "dly_plu_tpr8100")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item60 {
  factory _Item60.fromJson(Map<String, dynamic> json) => _$Item60FromJson(json);
  Map<String, dynamic> toJson() => _$Item60ToJson(this);

  _Item60({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 12)
  int    position;
  @JsonKey(defaultValue: "店舗実績TPR8100")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "STRF8")
  String t_exe1;
  @JsonKey(defaultValue: "STR28")
  String t_exe2;
  @JsonKey(defaultValue: "csv_tpr8100")
  String section;
  @JsonKey(defaultValue: "dly_deal_tpr8100")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item61 {
  factory _Item61.fromJson(Map<String, dynamic> json) => _$Item61FromJson(json);
  Map<String, dynamic> toJson() => _$Item61ToJson(this);

  _Item61({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 18)
  int    position;
  @JsonKey(defaultValue: "部門時間帯TPR8100")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "TIMF8")
  String t_exe1;
  @JsonKey(defaultValue: "csv_tpr8100")
  String section;
  @JsonKey(defaultValue: "reg_dly_mly_mdl_tpr8100")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item62 {
  factory _Item62.fromJson(Map<String, dynamic> json) => _$Item62FromJson(json);
  Map<String, dynamic> toJson() => _$Item62ToJson(this);

  _Item62({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 13)
  int    position;
  @JsonKey(defaultValue: "JA仕様日計ﾌｧｲﾙ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "FTKBSNIK")
  String t_exe1;
  @JsonKey(defaultValue: "csv_tpr8100")
  String section;
  @JsonKey(defaultValue: "ibaraki_tpr8100")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item63 {
  factory _Item63.fromJson(Map<String, dynamic> json) => _$Item63FromJson(json);
  Map<String, dynamic> toJson() => _$Item63ToJson(this);

  _Item63({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 14)
  int    position;
  @JsonKey(defaultValue: "税金")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_tax_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "tax_mst")
  String keyword;
  @JsonKey(defaultValue: "tax_week")
  String keyword2;
  @JsonKey(defaultValue: "tax_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item64 {
  factory _Item64.fromJson(Map<String, dynamic> json) => _$Item64FromJson(json);
  Map<String, dynamic> toJson() => _$Item64ToJson(this);

  _Item64({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 15)
  int    position;
  @JsonKey(defaultValue: "共通ｺﾝﾄﾛｰﾙ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_ctrl_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "ctrl_mst")
  String keyword;
  @JsonKey(defaultValue: "ctrl_week")
  String keyword2;
  @JsonKey(defaultValue: "ctrl_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item65 {
  factory _Item65.fromJson(Map<String, dynamic> json) => _$Item65FromJson(json);
  Map<String, dynamic> toJson() => _$Item65ToJson(this);

  _Item65({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 16)
  int    position;
  @JsonKey(defaultValue: "ｲﾝｽﾄｱﾏｰｷﾝｸﾞ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_instre_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "instre_mst")
  String keyword;
  @JsonKey(defaultValue: "instre_week")
  String keyword2;
  @JsonKey(defaultValue: "instre_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item66 {
  factory _Item66.fromJson(Map<String, dynamic> json) => _$Item66FromJson(json);
  Map<String, dynamic> toJson() => _$Item66ToJson(this);

  _Item66({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 10)
  int    position;
  @JsonKey(defaultValue: "中分類値下")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_mdlsch_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_mdlitem_mst")
  String t_exe2;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "mdlsch_mst")
  String keyword;
  @JsonKey(defaultValue: "mdlsch_week")
  String keyword2;
  @JsonKey(defaultValue: "mdlsch_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item67 {
  factory _Item67.fromJson(Map<String, dynamic> json) => _$Item67FromJson(json);
  Map<String, dynamic> toJson() => _$Item67ToJson(this);

  _Item67({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 11)
  int    position;
  @JsonKey(defaultValue: "小分類値下")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_smlsch_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_smlitem_mst")
  String t_exe2;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "smlsch_mst")
  String keyword;
  @JsonKey(defaultValue: "smlsch_week")
  String keyword2;
  @JsonKey(defaultValue: "smlsch_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item68 {
  factory _Item68.fromJson(Map<String, dynamic> json) => _$Item68FromJson(json);
  Map<String, dynamic> toJson() => _$Item68ToJson(this);

  _Item68({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 5)
  int    page;
  @JsonKey(defaultValue: 10)
  int    position;
  @JsonKey(defaultValue: "商品ﾎﾟｲﾝﾄ加算")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_plusch_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_pluitem_mst")
  String t_exe2;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "plusch_mst")
  String keyword;
  @JsonKey(defaultValue: "plusch_week")
  String keyword2;
  @JsonKey(defaultValue: "plusch_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item69 {
  factory _Item69.fromJson(Map<String, dynamic> json) => _$Item69FromJson(json);
  Map<String, dynamic> toJson() => _$Item69ToJson(this);

  _Item69({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 5)
  int    position;
  @JsonKey(defaultValue: "予約売価変更")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_batprcchg_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "batprcchg_mst")
  String keyword;
  @JsonKey(defaultValue: "batprcchg_week")
  String keyword2;
  @JsonKey(defaultValue: "batprcchg_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item70 {
  factory _Item70.fromJson(Map<String, dynamic> json) => _$Item70FromJson(json);
  Map<String, dynamic> toJson() => _$Item70ToJson(this);

  _Item70({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 6)
  int    position;
  @JsonKey(defaultValue: "FIPｽｸﾛｰﾙﾒｯｾｰｼﾞ")
  String table1;
  @JsonKey(defaultValue: 2)
  int    total;
  @JsonKey(defaultValue: "c_fipsch_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_fipmsg_mst")
  String t_exe2;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "fipsch_mst")
  String keyword;
  @JsonKey(defaultValue: "fipsch_week")
  String keyword2;
  @JsonKey(defaultValue: "fipsch_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item71 {
  factory _Item71.fromJson(Map<String, dynamic> json) => _$Item71FromJson(json);
  Map<String, dynamic> toJson() => _$Item71ToJson(this);

  _Item71({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 5)
  int    page;
  @JsonKey(defaultValue: 4)
  int    position;
  @JsonKey(defaultValue: "記念日種別ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_anvkind_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "anvkind_mst")
  String keyword;
  @JsonKey(defaultValue: "anvkind_week")
  String keyword2;
  @JsonKey(defaultValue: "anvkind_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item72 {
  factory _Item72.fromJson(Map<String, dynamic> json) => _$Item72FromJson(json);
  Map<String, dynamic> toJson() => _$Item72ToJson(this);

  _Item72({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 5)
  int    page;
  @JsonKey(defaultValue: 5)
  int    position;
  @JsonKey(defaultValue: "確定割戻率ﾃｰﾌﾞﾙ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "dec_rbt_tbl")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "decrbt_mst")
  String keyword;
  @JsonKey(defaultValue: "decrbt_week")
  String keyword2;
  @JsonKey(defaultValue: "decrbt_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item73 {
  factory _Item73.fromJson(Map<String, dynamic> json) => _$Item73FromJson(json);
  Map<String, dynamic> toJson() => _$Item73ToJson(this);

  _Item73({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 5)
  int    page;
  @JsonKey(defaultValue: 6)
  int    position;
  @JsonKey(defaultValue: "郵便番号ﾏｽﾀ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "zipcode_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "zipcode_mst")
  String keyword;
  @JsonKey(defaultValue: "zipcode_week")
  String keyword2;
  @JsonKey(defaultValue: "zipcode_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item74 {
  factory _Item74.fromJson(Map<String, dynamic> json) => _$Item74FromJson(json);
  Map<String, dynamic> toJson() => _$Item74ToJson(this);

  _Item74({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 3)
  int    page;
  @JsonKey(defaultValue: 17)
  int    position;
  @JsonKey(defaultValue: "産地･ﾒｰｶｰ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "maker_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "maker_mst")
  String keyword;
  @JsonKey(defaultValue: "maker_week")
  String keyword2;
  @JsonKey(defaultValue: "maker_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item75 {
  factory _Item75.fromJson(Map<String, dynamic> json) => _$Item75FromJson(json);
  Map<String, dynamic> toJson() => _$Item75ToJson(this);

  _Item75({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.t_exe3,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 5)
  int    page;
  @JsonKey(defaultValue: 11)
  int    position;
  @JsonKey(defaultValue: "Mｶｰﾄﾞ")
  String table1;
  @JsonKey(defaultValue: 3)
  int    total;
  @JsonKey(defaultValue: "c_mcspec_mst")
  String t_exe1;
  @JsonKey(defaultValue: "c_mckind_tbl")
  String t_exe2;
  @JsonKey(defaultValue: "c_mcnega_tbl")
  String t_exe3;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "mcard_mst")
  String keyword;
  @JsonKey(defaultValue: "mcard_week")
  String keyword2;
  @JsonKey(defaultValue: "mcard_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item76 {
  factory _Item76.fromJson(Map<String, dynamic> json) => _$Item76FromJson(json);
  Map<String, dynamic> toJson() => _$Item76ToJson(this);

  _Item76({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 6)
  int    position;
  @JsonKey(defaultValue: "出退勤ログ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_duty_log")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "duty_log")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item77 {
  factory _Item77.fromJson(Map<String, dynamic> json) => _$Item77FromJson(json);
  Map<String, dynamic> toJson() => _$Item77ToJson(this);

  _Item77({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 12)
  int    position;
  @JsonKey(defaultValue: "SIMS用CSVﾛｸﾞ")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "sims_log")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "sims_log")
  String keyword;
  @JsonKey(defaultValue: "simslog_week")
  String keyword2;
  @JsonKey(defaultValue: "simslog_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item78 {
  factory _Item78.fromJson(Map<String, dynamic> json) => _$Item78FromJson(json);
  Map<String, dynamic> toJson() => _$Item78ToJson(this);

  _Item78({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.t_exe2,
    required this.t_exe3,
    required this.t_exe4,
    required this.t_exe5,
    required this.t_exe6,
    required this.t_exe7,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 7)
  int    page;
  @JsonKey(defaultValue: 1)
  int    position;
  @JsonKey(defaultValue: "予約ログ")
  String table1;
  @JsonKey(defaultValue: 7)
  int    total;
  @JsonKey(defaultValue: "m_reserv_log")
  String t_exe1;
  @JsonKey(defaultValue: "reserv_tbl")
  String t_exe2;
  @JsonKey(defaultValue: "c_itemlog_reserv")
  String t_exe3;
  @JsonKey(defaultValue: "c_ttllog_reserv")
  String t_exe4;
  @JsonKey(defaultValue: "c_bdllog_reserv")
  String t_exe5;
  @JsonKey(defaultValue: "c_stmlog_reserv")
  String t_exe6;
  @JsonKey(defaultValue: "c_crdt_actual_log_reserv")
  String t_exe7;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "reserv_log")
  String keyword;
  @JsonKey(defaultValue: "reservlog_week")
  String keyword2;
  @JsonKey(defaultValue: "reservlog_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
}

@JsonSerializable()
class _Item79 {
  factory _Item79.fromJson(Map<String, dynamic> json) => _$Item79FromJson(json);
  Map<String, dynamic> toJson() => _$Item79ToJson(this);

  _Item79({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 16)
  int    position;
  @JsonKey(defaultValue: "Zレシート")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "z_receipt")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "z_receipt")
  String keyword;
  @JsonKey(defaultValue: "zreceipt_week")
  String keyword2;
  @JsonKey(defaultValue: "zreceipt_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item80 {
  factory _Item80.fromJson(Map<String, dynamic> json) => _$Item80FromJson(json);
  Map<String, dynamic> toJson() => _$Item80ToJson(this);

  _Item80({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 6)
  int    position;
  @JsonKey(defaultValue: "大分類日計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_dly_lrg")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_lrg")
  String keyword;
  @JsonKey(defaultValue: "dlylrg_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item81 {
  factory _Item81.fromJson(Map<String, dynamic> json) => _$Item81FromJson(json);
  Map<String, dynamic> toJson() => _$Item81ToJson(this);

  _Item81({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 2)
  int    page;
  @JsonKey(defaultValue: 9)
  int    position;
  @JsonKey(defaultValue: "大分類累計実績")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "reg_mly_lrg")
  String t_exe1;
  @JsonKey(defaultValue: "csv_term")
  String section;
  @JsonKey(defaultValue: "reg_mly_lrg")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item82 {
  factory _Item82.fromJson(Map<String, dynamic> json) => _$Item82FromJson(json);
  Map<String, dynamic> toJson() => _$Item82ToJson(this);

  _Item82({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 10)
  int    position;
  @JsonKey(defaultValue: "理由区分")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_reason_mst")
  String t_exe1;
  @JsonKey(defaultValue: "csv_prg")
  String section;
  @JsonKey(defaultValue: "reason_mst")
  String keyword;
  @JsonKey(defaultValue: "reason_week")
  String keyword2;
  @JsonKey(defaultValue: "reason_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item83 {
  factory _Item83.fromJson(Map<String, dynamic> json) => _$Item83FromJson(json);
  Map<String, dynamic> toJson() => _$Item83ToJson(this);

  _Item83({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.keyword3,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 6)
  int    page;
  @JsonKey(defaultValue: 11)
  int    position;
  @JsonKey(defaultValue: "現金過不足")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "drawchk_cash_log")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "drawchk_cash_log")
  String keyword;
  @JsonKey(defaultValue: "drawchk_cash_log_week")
  String keyword2;
  @JsonKey(defaultValue: "drawchk_cash_log_day")
  String keyword3;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

