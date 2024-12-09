/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'searchlogJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class SearchlogJsonFile extends ConfigJsonFile {
  static final SearchlogJsonFile _instance = SearchlogJsonFile._internal();

  final String _confPath = "conf/";
  final JsonLanguage _confLang = JsonLanguage.aa;
  final String _fileName = "searchlog.json";

  SearchlogJsonFile(){
    setPath(_confPath, _fileName, _confLang);
  }
  SearchlogJsonFile._internal();

  factory SearchlogJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$SearchlogJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$SearchlogJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$SearchlogJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        display = _$DisplayFromJson(jsonD['display']);
      } catch(e) {
        display = _$DisplayFromJson({});
        ret = false;
      }
      try {
        config = _$ConfigFromJson(jsonD['config']);
      } catch(e) {
        config = _$ConfigFromJson({});
        ret = false;
      }
      try {
        command1 = _$Command1FromJson(jsonD['command1']);
      } catch(e) {
        command1 = _$Command1FromJson({});
        ret = false;
      }
      try {
        search1 = _$Search1FromJson(jsonD['search1']);
      } catch(e) {
        search1 = _$Search1FromJson({});
        ret = false;
      }
      try {
        search2 = _$Search2FromJson(jsonD['search2']);
      } catch(e) {
        search2 = _$Search2FromJson({});
        ret = false;
      }
      try {
        search3 = _$Search3FromJson(jsonD['search3']);
      } catch(e) {
        search3 = _$Search3FromJson({});
        ret = false;
      }
      try {
        search4 = _$Search4FromJson(jsonD['search4']);
      } catch(e) {
        search4 = _$Search4FromJson({});
        ret = false;
      }
      try {
        search5 = _$Search5FromJson(jsonD['search5']);
      } catch(e) {
        search5 = _$Search5FromJson({});
        ret = false;
      }
      try {
        search6 = _$Search6FromJson(jsonD['search6']);
      } catch(e) {
        search6 = _$Search6FromJson({});
        ret = false;
      }
      try {
        search7 = _$Search7FromJson(jsonD['search7']);
      } catch(e) {
        search7 = _$Search7FromJson({});
        ret = false;
      }
      try {
        search8 = _$Search8FromJson(jsonD['search8']);
      } catch(e) {
        search8 = _$Search8FromJson({});
        ret = false;
      }
      try {
        search9 = _$Search9FromJson(jsonD['search9']);
      } catch(e) {
        search9 = _$Search9FromJson({});
        ret = false;
      }
      try {
        search10 = _$Search10FromJson(jsonD['search10']);
      } catch(e) {
        search10 = _$Search10FromJson({});
        ret = false;
      }
      try {
        search11 = _$Search11FromJson(jsonD['search11']);
      } catch(e) {
        search11 = _$Search11FromJson({});
        ret = false;
      }
      try {
        search12 = _$Search12FromJson(jsonD['search12']);
      } catch(e) {
        search12 = _$Search12FromJson({});
        ret = false;
      }
      try {
        search13 = _$Search13FromJson(jsonD['search13']);
      } catch(e) {
        search13 = _$Search13FromJson({});
        ret = false;
      }
      try {
        search15 = _$Search15FromJson(jsonD['search15']);
      } catch(e) {
        search15 = _$Search15FromJson({});
        ret = false;
      }
      try {
        search16 = _$Search16FromJson(jsonD['search16']);
      } catch(e) {
        search16 = _$Search16FromJson({});
        ret = false;
      }
      try {
        search21 = _$Search21FromJson(jsonD['search21']);
      } catch(e) {
        search21 = _$Search21FromJson({});
        ret = false;
      }
      try {
        search22 = _$Search22FromJson(jsonD['search22']);
      } catch(e) {
        search22 = _$Search22FromJson({});
        ret = false;
      }
      try {
        search23 = _$Search23FromJson(jsonD['search23']);
      } catch(e) {
        search23 = _$Search23FromJson({});
        ret = false;
      }
      try {
        search24 = _$Search24FromJson(jsonD['search24']);
      } catch(e) {
        search24 = _$Search24FromJson({});
        ret = false;
      }
      try {
        search25 = _$Search25FromJson(jsonD['search25']);
      } catch(e) {
        search25 = _$Search25FromJson({});
        ret = false;
      }
      try {
        search26 = _$Search26FromJson(jsonD['search26']);
      } catch(e) {
        search26 = _$Search26FromJson({});
        ret = false;
      }
      try {
        search27 = _$Search27FromJson(jsonD['search27']);
      } catch(e) {
        search27 = _$Search27FromJson({});
        ret = false;
      }
      try {
        search28 = _$Search28FromJson(jsonD['search28']);
      } catch(e) {
        search28 = _$Search28FromJson({});
        ret = false;
      }
      try {
        search31 = _$Search31FromJson(jsonD['search31']);
      } catch(e) {
        search31 = _$Search31FromJson({});
        ret = false;
      }
      try {
        search32 = _$Search32FromJson(jsonD['search32']);
      } catch(e) {
        search32 = _$Search32FromJson({});
        ret = false;
      }
      try {
        search33 = _$Search33FromJson(jsonD['search33']);
      } catch(e) {
        search33 = _$Search33FromJson({});
        ret = false;
      }
      try {
        search34 = _$Search34FromJson(jsonD['search34']);
      } catch(e) {
        search34 = _$Search34FromJson({});
        ret = false;
      }
      try {
        search35 = _$Search35FromJson(jsonD['search35']);
      } catch(e) {
        search35 = _$Search35FromJson({});
        ret = false;
      }
      try {
        search36 = _$Search36FromJson(jsonD['search36']);
      } catch(e) {
        search36 = _$Search36FromJson({});
        ret = false;
      }
      try {
        search37 = _$Search37FromJson(jsonD['search37']);
      } catch(e) {
        search37 = _$Search37FromJson({});
        ret = false;
      }
      try {
        search38 = _$Search38FromJson(jsonD['search38']);
      } catch(e) {
        search38 = _$Search38FromJson({});
        ret = false;
      }
      try {
        search39 = _$Search39FromJson(jsonD['search39']);
      } catch(e) {
        search39 = _$Search39FromJson({});
        ret = false;
      }
      try {
        search40 = _$Search40FromJson(jsonD['search40']);
      } catch(e) {
        search40 = _$Search40FromJson({});
        ret = false;
      }
      try {
        search41 = _$Search41FromJson(jsonD['search41']);
      } catch(e) {
        search41 = _$Search41FromJson({});
        ret = false;
      }
      try {
        search42 = _$Search42FromJson(jsonD['search42']);
      } catch(e) {
        search42 = _$Search42FromJson({});
        ret = false;
      }
      try {
        search51 = _$Search51FromJson(jsonD['search51']);
      } catch(e) {
        search51 = _$Search51FromJson({});
        ret = false;
      }
      try {
        search52 = _$Search52FromJson(jsonD['search52']);
      } catch(e) {
        search52 = _$Search52FromJson({});
        ret = false;
      }
      try {
        search53 = _$Search53FromJson(jsonD['search53']);
      } catch(e) {
        search53 = _$Search53FromJson({});
        ret = false;
      }
      try {
        search54 = _$Search54FromJson(jsonD['search54']);
      } catch(e) {
        search54 = _$Search54FromJson({});
        ret = false;
      }
      try {
        search56 = _$Search56FromJson(jsonD['search56']);
      } catch(e) {
        search56 = _$Search56FromJson({});
        ret = false;
      }
      try {
        search61 = _$Search61FromJson(jsonD['search61']);
      } catch(e) {
        search61 = _$Search61FromJson({});
        ret = false;
      }
      try {
        search62 = _$Search62FromJson(jsonD['search62']);
      } catch(e) {
        search62 = _$Search62FromJson({});
        ret = false;
      }
      try {
        search63 = _$Search63FromJson(jsonD['search63']);
      } catch(e) {
        search63 = _$Search63FromJson({});
        ret = false;
      }
      try {
        search64 = _$Search64FromJson(jsonD['search64']);
      } catch(e) {
        search64 = _$Search64FromJson({});
        ret = false;
      }
      try {
        search65 = _$Search65FromJson(jsonD['search65']);
      } catch(e) {
        search65 = _$Search65FromJson({});
        ret = false;
      }
      try {
        search66 = _$Search66FromJson(jsonD['search66']);
      } catch(e) {
        search66 = _$Search66FromJson({});
        ret = false;
      }
      try {
        search67 = _$Search67FromJson(jsonD['search67']);
      } catch(e) {
        search67 = _$Search67FromJson({});
        ret = false;
      }
      try {
        search68 = _$Search68FromJson(jsonD['search68']);
      } catch(e) {
        search68 = _$Search68FromJson({});
        ret = false;
      }
      try {
        search69 = _$Search69FromJson(jsonD['search69']);
      } catch(e) {
        search69 = _$Search69FromJson({});
        ret = false;
      }
      try {
        search70 = _$Search70FromJson(jsonD['search70']);
      } catch(e) {
        search70 = _$Search70FromJson({});
        ret = false;
      }
      try {
        search71 = _$Search71FromJson(jsonD['search71']);
      } catch(e) {
        search71 = _$Search71FromJson({});
        ret = false;
      }
      try {
        search72 = _$Search72FromJson(jsonD['search72']);
      } catch(e) {
        search72 = _$Search72FromJson({});
        ret = false;
      }
      try {
        search73 = _$Search73FromJson(jsonD['search73']);
      } catch(e) {
        search73 = _$Search73FromJson({});
        ret = false;
      }
      try {
        search74 = _$Search74FromJson(jsonD['search74']);
      } catch(e) {
        search74 = _$Search74FromJson({});
        ret = false;
      }
      try {
        search75 = _$Search75FromJson(jsonD['search75']);
      } catch(e) {
        search75 = _$Search75FromJson({});
        ret = false;
      }
      try {
        search76 = _$Search76FromJson(jsonD['search76']);
      } catch(e) {
        search76 = _$Search76FromJson({});
        ret = false;
      }
      try {
        search77 = _$Search77FromJson(jsonD['search77']);
      } catch(e) {
        search77 = _$Search77FromJson({});
        ret = false;
      }
      try {
        search78 = _$Search78FromJson(jsonD['search78']);
      } catch(e) {
        search78 = _$Search78FromJson({});
        ret = false;
      }
      try {
        search79 = _$Search79FromJson(jsonD['search79']);
      } catch(e) {
        search79 = _$Search79FromJson({});
        ret = false;
      }
      try {
        search80 = _$Search80FromJson(jsonD['search80']);
      } catch(e) {
        search80 = _$Search80FromJson({});
        ret = false;
      }
      try {
        search91 = _$Search91FromJson(jsonD['search91']);
      } catch(e) {
        search91 = _$Search91FromJson({});
        ret = false;
      }
      try {
        search92 = _$Search92FromJson(jsonD['search92']);
      } catch(e) {
        search92 = _$Search92FromJson({});
        ret = false;
      }
      try {
        search93 = _$Search93FromJson(jsonD['search93']);
      } catch(e) {
        search93 = _$Search93FromJson({});
        ret = false;
      }
      try {
        search94 = _$Search94FromJson(jsonD['search94']);
      } catch(e) {
        search94 = _$Search94FromJson({});
        ret = false;
      }
      try {
        search95 = _$Search95FromJson(jsonD['search95']);
      } catch(e) {
        search95 = _$Search95FromJson({});
        ret = false;
      }
      try {
        search96 = _$Search96FromJson(jsonD['search96']);
      } catch(e) {
        search96 = _$Search96FromJson({});
        ret = false;
      }
      try {
        search97 = _$Search97FromJson(jsonD['search97']);
      } catch(e) {
        search97 = _$Search97FromJson({});
        ret = false;
      }
      try {
        search98 = _$Search98FromJson(jsonD['search98']);
      } catch(e) {
        search98 = _$Search98FromJson({});
        ret = false;
      }
      try {
        search99 = _$Search99FromJson(jsonD['search99']);
      } catch(e) {
        search99 = _$Search99FromJson({});
        ret = false;
      }
      try {
        search100 = _$Search100FromJson(jsonD['search100']);
      } catch(e) {
        search100 = _$Search100FromJson({});
        ret = false;
      }
      try {
        search101 = _$Search101FromJson(jsonD['search101']);
      } catch(e) {
        search101 = _$Search101FromJson({});
        ret = false;
      }
      try {
        search102 = _$Search102FromJson(jsonD['search102']);
      } catch(e) {
        search102 = _$Search102FromJson({});
        ret = false;
      }
      try {
        search103 = _$Search103FromJson(jsonD['search103']);
      } catch(e) {
        search103 = _$Search103FromJson({});
        ret = false;
      }
      try {
        search104 = _$Search104FromJson(jsonD['search104']);
      } catch(e) {
        search104 = _$Search104FromJson({});
        ret = false;
      }
      try {
        search105 = _$Search105FromJson(jsonD['search105']);
      } catch(e) {
        search105 = _$Search105FromJson({});
        ret = false;
      }
      try {
        search106 = _$Search106FromJson(jsonD['search106']);
      } catch(e) {
        search106 = _$Search106FromJson({});
        ret = false;
      }
      try {
        search107 = _$Search107FromJson(jsonD['search107']);
      } catch(e) {
        search107 = _$Search107FromJson({});
        ret = false;
      }
      try {
        search108 = _$Search108FromJson(jsonD['search108']);
      } catch(e) {
        search108 = _$Search108FromJson({});
        ret = false;
      }
      try {
        search109 = _$Search109FromJson(jsonD['search109']);
      } catch(e) {
        search109 = _$Search109FromJson({});
        ret = false;
      }
      try {
        search110 = _$Search110FromJson(jsonD['search110']);
      } catch(e) {
        search110 = _$Search110FromJson({});
        ret = false;
      }
      try {
        search111 = _$Search111FromJson(jsonD['search111']);
      } catch(e) {
        search111 = _$Search111FromJson({});
        ret = false;
      }
      try {
        search112 = _$Search112FromJson(jsonD['search112']);
      } catch(e) {
        search112 = _$Search112FromJson({});
        ret = false;
      }
      try {
        search113 = _$Search113FromJson(jsonD['search113']);
      } catch(e) {
        search113 = _$Search113FromJson({});
        ret = false;
      }
      try {
        search114 = _$Search114FromJson(jsonD['search114']);
      } catch(e) {
        search114 = _$Search114FromJson({});
        ret = false;
      }
      try {
        search115 = _$Search115FromJson(jsonD['search115']);
      } catch(e) {
        search115 = _$Search115FromJson({});
        ret = false;
      }
      try {
        search116 = _$Search116FromJson(jsonD['search116']);
      } catch(e) {
        search116 = _$Search116FromJson({});
        ret = false;
      }
      try {
        search117 = _$Search117FromJson(jsonD['search117']);
      } catch(e) {
        search117 = _$Search117FromJson({});
        ret = false;
      }
      try {
        search118 = _$Search118FromJson(jsonD['search118']);
      } catch(e) {
        search118 = _$Search118FromJson({});
        ret = false;
      }
      try {
        search119 = _$Search119FromJson(jsonD['search119']);
      } catch(e) {
        search119 = _$Search119FromJson({});
        ret = false;
      }
      try {
        search120 = _$Search120FromJson(jsonD['search120']);
      } catch(e) {
        search120 = _$Search120FromJson({});
        ret = false;
      }
      try {
        search121 = _$Search121FromJson(jsonD['search121']);
      } catch(e) {
        search121 = _$Search121FromJson({});
        ret = false;
      }
      try {
        search122 = _$Search122FromJson(jsonD['search122']);
      } catch(e) {
        search122 = _$Search122FromJson({});
        ret = false;
      }
      try {
        search123 = _$Search123FromJson(jsonD['search123']);
      } catch(e) {
        search123 = _$Search123FromJson({});
        ret = false;
      }
      try {
        search124 = _$Search124FromJson(jsonD['search124']);
      } catch(e) {
        search124 = _$Search124FromJson({});
        ret = false;
      }
      try {
        search125 = _$Search125FromJson(jsonD['search125']);
      } catch(e) {
        search125 = _$Search125FromJson({});
        ret = false;
      }
      try {
        search126 = _$Search126FromJson(jsonD['search126']);
      } catch(e) {
        search126 = _$Search126FromJson({});
        ret = false;
      }
      try {
        search127 = _$Search127FromJson(jsonD['search127']);
      } catch(e) {
        search127 = _$Search127FromJson({});
        ret = false;
      }
      try {
        search128 = _$Search128FromJson(jsonD['search128']);
      } catch(e) {
        search128 = _$Search128FromJson({});
        ret = false;
      }
      try {
        search129 = _$Search129FromJson(jsonD['search129']);
      } catch(e) {
        search129 = _$Search129FromJson({});
        ret = false;
      }
      try {
        search130 = _$Search130FromJson(jsonD['search130']);
      } catch(e) {
        search130 = _$Search130FromJson({});
        ret = false;
      }
      try {
        search131 = _$Search131FromJson(jsonD['search131']);
      } catch(e) {
        search131 = _$Search131FromJson({});
        ret = false;
      }
      try {
        search132 = _$Search132FromJson(jsonD['search132']);
      } catch(e) {
        search132 = _$Search132FromJson({});
        ret = false;
      }
      try {
        search133 = _$Search133FromJson(jsonD['search133']);
      } catch(e) {
        search133 = _$Search133FromJson({});
        ret = false;
      }
      try {
        search134 = _$Search134FromJson(jsonD['search134']);
      } catch(e) {
        search134 = _$Search134FromJson({});
        ret = false;
      }
      try {
        search135 = _$Search135FromJson(jsonD['search135']);
      } catch(e) {
        search135 = _$Search135FromJson({});
        ret = false;
      }
      try {
        search136 = _$Search136FromJson(jsonD['search136']);
      } catch(e) {
        search136 = _$Search136FromJson({});
        ret = false;
      }
      try {
        search137 = _$Search137FromJson(jsonD['search137']);
      } catch(e) {
        search137 = _$Search137FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Display display = _Display(
    display                            : "",
  );

  _Config config = _Config(
    title                              : "",
    command_number                     : 0,
    search_number                      : 0,
  );

  _Command1 command1 = _Command1(
    command                            : "",
    command_sata                       : "",
    command_ssd                        : "",
    command_sata2                      : "",
    command_ssd2                       : "",
    file_name                          : "",
  );

  _Search1 search1 = _Search1(
    typ                                : 0,
    title                              : "",
    description_cd                     : 0,
  );

  _Search2 search2 = _Search2(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word2                       : "",
    search_word1_sata                  : "",
    search_word2_sata                  : "",
    description                        : "",
  );

  _Search3 search3 = _Search3(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search4 search4 = _Search4(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search5 search5 = _Search5(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    sensor_word                        : "",
    description                        : "",
  );

  _Search6 search6 = _Search6(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    sensor_word                        : "",
    description                        : "",
  );

  _Search7 search7 = _Search7(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    partition                          : "",
    description                        : "",
  );

  _Search8 search8 = _Search8(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word2                       : "",
    search_word1_sata                  : "",
    search_word2_sata                  : "",
    description                        : "",
  );

  _Search9 search9 = _Search9(
    file_name                          : "",
    file_name2                         : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    sensor_word                        : "",
    description                        : "",
  );

  _Search10 search10 = _Search10(
    file_name                          : "",
    file_name2                         : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    sensor_word                        : "",
    description                        : "",
  );

  _Search11 search11 = _Search11(
    file_name                          : "",
    file_name2                         : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    sensor_word                        : "",
    description                        : "",
  );

  _Search12 search12 = _Search12(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search13 search13 = _Search13(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    print_word                         : "",
    description                        : "",
  );

  _Search15 search15 = _Search15(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search16 search16 = _Search16(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search21 search21 = _Search21(
    typ                                : 0,
    ssd                                : 0,
    title                              : "",
    description_cd                     : 0,
  );

  _Search22 search22 = _Search22(
    file_name                          : "",
    file_name2                         : "",
    typ                                : 0,
    ssd                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    ssd_word                           : "",
    description                        : "",
  );

  _Search23 search23 = _Search23(
    file_name                          : "",
    file_name2                         : "",
    typ                                : 0,
    ssd                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    ssd_word                           : "",
    description                        : "",
  );

  _Search24 search24 = _Search24(
    file_name                          : "",
    file_name2                         : "",
    typ                                : 0,
    ssd                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    ssd_word                           : "",
    description                        : "",
  );

  _Search25 search25 = _Search25(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    description                        : "",
  );

  _Search26 search26 = _Search26(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    description                        : "",
  );

  _Search27 search27 = _Search27(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    description                        : "",
  );

  _Search28 search28 = _Search28(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    description                        : "",
  );

  _Search31 search31 = _Search31(
    typ                                : 0,
    ssd                                : 0,
    title                              : "",
    description_cd                     : 0,
  );

  _Search32 search32 = _Search32(
    typ                                : 0,
    ssd                                : 0,
    title                              : "",
    description_cd                     : 0,
  );

  _Search33 search33 = _Search33(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    print_value_ok                     : "",
    print_value_ng                     : "",
    smart_word                         : "",
    smart_word_sata                    : "",
    description                        : "",
  );

  _Search34 search34 = _Search34(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    print_value_ok                     : "",
    print_value_ng                     : "",
    smart_word                         : "",
    smart_word_sata                    : "",
    description                        : "",
  );

  _Search35 search35 = _Search35(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    print_value_ok                     : "",
    print_value_ng                     : "",
    smart_word                         : "",
    smart_word_sata                    : "",
    description                        : "",
  );

  _Search36 search36 = _Search36(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    smart_word                         : "",
    smart_word_sata                    : "",
    description                        : "",
  );

  _Search37 search37 = _Search37(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    print_value_ok                     : "",
    print_value_ng                     : "",
    smart_word                         : "",
    smart_word_sata                    : "",
    description                        : "",
  );

  _Search38 search38 = _Search38(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    smart_word                         : "",
    smart_word_sata                    : "",
    description                        : "",
  );

  _Search39 search39 = _Search39(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    print_value_ok                     : "",
    print_value_ng                     : "",
    smart_word                         : "",
    smart_word_sata                    : "",
    description                        : "",
  );

  _Search40 search40 = _Search40(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    print_value_ok                     : "",
    print_value_ng                     : "",
    smart_word                         : "",
    smart_word_sata                    : "",
    description                        : "",
  );

  _Search41 search41 = _Search41(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    print_value_ok                     : "",
    print_value_ng                     : "",
    smart_word                         : "",
    smart_word_sata                    : "",
    description                        : "",
  );

  _Search42 search42 = _Search42(
    file_name                          : "",
    file_name2                         : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    print_word2                        : "",
    sensor_word                        : "",
    description                        : "",
    description_cd                     : 0,
  );

  _Search51 search51 = _Search51(
    typ                                : 0,
    ssd                                : 0,
    title                              : "",
    description_cd                     : 0,
  );

  _Search52 search52 = _Search52(
    file_name                          : "",
    file_name2                         : "",
    typ                                : 0,
    ssd                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    ssd_word                           : "",
    description                        : "",
  );

  _Search53 search53 = _Search53(
    file_name                          : "",
    file_name2                         : "",
    typ                                : 0,
    ssd                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    ssd_word                           : "",
    description                        : "",
  );

  _Search54 search54 = _Search54(
    file_name                          : "",
    file_name2                         : "",
    typ                                : 0,
    ssd                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    ssd_word                           : "",
    description                        : "",
  );

  _Search56 search56 = _Search56(
    file_name                          : "",
    typ                                : 0,
    ssd                                : 0,
    out_count                          : 0,
    print_word                         : "",
    description                        : "",
  );

  _Search61 search61 = _Search61(
    typ                                : 0,
    title                              : "",
    description_cd                     : 0,
  );

  _Search62 search62 = _Search62(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search63 search63 = _Search63(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search64 search64 = _Search64(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search65 search65 = _Search65(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search66 search66 = _Search66(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search67 search67 = _Search67(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search68 search68 = _Search68(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search69 search69 = _Search69(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search70 search70 = _Search70(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search71 search71 = _Search71(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search72 search72 = _Search72(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search73 search73 = _Search73(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search74 search74 = _Search74(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search75 search75 = _Search75(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search76 search76 = _Search76(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search77 search77 = _Search77(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search78 search78 = _Search78(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search79 search79 = _Search79(
    file_name                          : "",
    typ                                : 0,
    date                               : "",
    term_date                          : 0,
    out_count                          : 0,
    print_word                         : "",
    words                              : 0,
    search_word1                       : "",
    search_word1_sata                  : "",
    description                        : "",
  );

  _Search80 search80 = _Search80(
    typ                                : 0,
    file_name                          : "",
    out_count                          : 0,
    print_word                         : "",
    print_value_ok                     : "",
    print_value_ng                     : "",
    description                        : "",
  );

  _Search91 search91 = _Search91(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search92 search92 = _Search92(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search93 search93 = _Search93(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search94 search94 = _Search94(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search95 search95 = _Search95(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search96 search96 = _Search96(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search97 search97 = _Search97(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search98 search98 = _Search98(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    print_word                         : "",
    description                        : "",
  );

  _Search99 search99 = _Search99(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search100 search100 = _Search100(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search101 search101 = _Search101(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search102 search102 = _Search102(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search103 search103 = _Search103(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search104 search104 = _Search104(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search105 search105 = _Search105(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search106 search106 = _Search106(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search107 search107 = _Search107(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search108 search108 = _Search108(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search109 search109 = _Search109(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search110 search110 = _Search110(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search111 search111 = _Search111(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search112 search112 = _Search112(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search113 search113 = _Search113(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search114 search114 = _Search114(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : 0,
    print_word                         : "",
    description                        : "",
  );

  _Search115 search115 = _Search115(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : 0,
    print_word                         : "",
    description                        : "",
  );

  _Search116 search116 = _Search116(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search117 search117 = _Search117(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search118 search118 = _Search118(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search119 search119 = _Search119(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search120 search120 = _Search120(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search121 search121 = _Search121(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search122 search122 = _Search122(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search123 search123 = _Search123(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search124 search124 = _Search124(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search125 search125 = _Search125(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search126 search126 = _Search126(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search127 search127 = _Search127(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search128 search128 = _Search128(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search129 search129 = _Search129(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search130 search130 = _Search130(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search131 search131 = _Search131(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search132 search132 = _Search132(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search133 search133 = _Search133(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search134 search134 = _Search134(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search135 search135 = _Search135(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search136 search136 = _Search136(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );

  _Search137 search137 = _Search137(
    file_name                          : "",
    typ                                : 0,
    out_count                          : 0,
    section                            : "",
    keyword                            : "",
    print_word                         : "",
    description                        : "",
  );
}

@JsonSerializable()
class _Display {
  factory _Display.fromJson(Map<String, dynamic> json) => _$DisplayFromJson(json);
  Map<String, dynamic> toJson() => _$DisplayToJson(this);

  _Display({
    required this.display,
  });

  @JsonKey(defaultValue: "yes")
  String display;
}

@JsonSerializable()
class _Config {
  factory _Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);

  _Config({
    required this.title,
    required this.command_number,
    required this.search_number,
  });

  @JsonKey(defaultValue: "<H/W情報>")
  String title;
  @JsonKey(defaultValue: 1)
  int    command_number;
  @JsonKey(defaultValue: 137)
  int    search_number;
}

@JsonSerializable()
class _Command1 {
  factory _Command1.fromJson(Map<String, dynamic> json) => _$Command1FromJson(json);
  Map<String, dynamic> toJson() => _$Command1ToJson(this);

  _Command1({
    required this.command,
    required this.command_sata,
    required this.command_ssd,
    required this.command_sata2,
    required this.command_ssd2,
    required this.file_name,
  });

  @JsonKey(defaultValue: "\"/usr/sbin/smartctl /dev/hda -a\"")
  String command;
  @JsonKey(defaultValue: "\"/usr/sbin/smartctl /dev/sda -a -d ata\"")
  String command_sata;
  @JsonKey(defaultValue: "\"/usr/sbin/smartctl /dev/sda -i -d ata\"")
  String command_ssd;
  @JsonKey(defaultValue: "\"/usr/sbin/smartctl /dev/sdb -a -d ata\"")
  String command_sata2;
  @JsonKey(defaultValue: "\"/usr/sbin/smartctl /dev/sdb -i -d ata\"")
  String command_ssd2;
  @JsonKey(defaultValue: "smart.log")
  String file_name;
}

@JsonSerializable()
class _Search1 {
  factory _Search1.fromJson(Map<String, dynamic> json) => _$Search1FromJson(json);
  Map<String, dynamic> toJson() => _$Search1ToJson(this);

  _Search1({
    required this.typ,
    required this.title,
    required this.description_cd,
  });

  @JsonKey(defaultValue: 0)
  int    typ;
  @JsonKey(defaultValue: "\"HDD/Memory/CPU\"")
  String title;
  @JsonKey(defaultValue: 0)
  int    description_cd;
}

@JsonSerializable()
class _Search2 {
  factory _Search2.fromJson(Map<String, dynamic> json) => _$Search2FromJson(json);
  Map<String, dynamic> toJson() => _$Search2ToJson(this);

  _Search2({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word2,
    required this.search_word1_sata,
    required this.search_word2_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/messages*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 100)
  int    out_count;
  @JsonKey(defaultValue: "\"SeekComplete\"")
  String print_word;
  @JsonKey(defaultValue: 2)
  int    words;
  @JsonKey(defaultValue: "SeekComplete")
  String search_word1;
  @JsonKey(defaultValue: "hda")
  String search_word2;
  @JsonKey(defaultValue: "SeekComplete")
  String search_word1_sata;
  @JsonKey(defaultValue: "sda")
  String search_word2_sata;
  @JsonKey(defaultValue: "001-010")
  String description;
}

@JsonSerializable()
class _Search3 {
  factory _Search3.fromJson(Map<String, dynamic> json) => _$Search3FromJson(json);
  Map<String, dynamic> toJson() => _$Search3ToJson(this);

  _Search3({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/messages*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"cut here\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"cut here\"")
  String search_word1;
  @JsonKey(defaultValue: "\"cut here\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "001-020")
  String description;
}

@JsonSerializable()
class _Search4 {
  factory _Search4.fromJson(Map<String, dynamic> json) => _$Search4FromJson(json);
  Map<String, dynamic> toJson() => _$Search4ToJson(this);

  _Search4({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/messages*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"Oops\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "Oops")
  String search_word1;
  @JsonKey(defaultValue: "Oops")
  String search_word1_sata;
  @JsonKey(defaultValue: "001-030")
  String description;
}

@JsonSerializable()
class _Search5 {
  factory _Search5.fromJson(Map<String, dynamic> json) => _$Search5FromJson(json);
  Map<String, dynamic> toJson() => _$Search5ToJson(this);

  _Search5({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.sensor_word,
    required this.description,
  });

  @JsonKey(defaultValue: "sensor.log")
  String file_name;
  @JsonKey(defaultValue: 5)
  int    typ;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"CPU温度(℃)\"")
  String print_word;
  @JsonKey(defaultValue: "\"CPU Temp\"")
  String sensor_word;
  @JsonKey(defaultValue: "005-010")
  String description;
}

@JsonSerializable()
class _Search6 {
  factory _Search6.fromJson(Map<String, dynamic> json) => _$Search6FromJson(json);
  Map<String, dynamic> toJson() => _$Search6ToJson(this);

  _Search6({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.sensor_word,
    required this.description,
  });

  @JsonKey(defaultValue: "sensor.log")
  String file_name;
  @JsonKey(defaultValue: 5)
  int    typ;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"CPUファン回転数(rpm)\"")
  String print_word;
  @JsonKey(defaultValue: "\"CPU Fan\"")
  String sensor_word;
  @JsonKey(defaultValue: "005-020")
  String description;
}

@JsonSerializable()
class _Search7 {
  factory _Search7.fromJson(Map<String, dynamic> json) => _$Search7FromJson(json);
  Map<String, dynamic> toJson() => _$Search7ToJson(this);

  _Search7({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.partition,
    required this.description,
  });

  @JsonKey(defaultValue: "dsk_used.log")
  String file_name;
  @JsonKey(defaultValue: 6)
  int    typ;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"システム領域使用率(%/GB)\"")
  String print_word;
  @JsonKey(defaultValue: "\"/\"")
  String partition;
  @JsonKey(defaultValue: "005-030")
  String description;
}

@JsonSerializable()
class _Search8 {
  factory _Search8.fromJson(Map<String, dynamic> json) => _$Search8FromJson(json);
  Map<String, dynamic> toJson() => _$Search8ToJson(this);

  _Search8({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word2,
    required this.search_word1_sata,
    required this.search_word2_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/messages*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"HDD接続不良\"")
  String print_word;
  @JsonKey(defaultValue: 2)
  int    words;
  @JsonKey(defaultValue: "\"resetting link\"")
  String search_word1;
  @JsonKey(defaultValue: "hda")
  String search_word2;
  @JsonKey(defaultValue: "\"resetting link\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "ata1")
  String search_word2_sata;
  @JsonKey(defaultValue: "015-010")
  String description;
}

@JsonSerializable()
class _Search9 {
  factory _Search9.fromJson(Map<String, dynamic> json) => _$Search9FromJson(json);
  Map<String, dynamic> toJson() => _$Search9ToJson(this);

  _Search9({
    required this.file_name,
    required this.file_name2,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.sensor_word,
    required this.description,
  });

  @JsonKey(defaultValue: "segf_cnt")
  String file_name;
  @JsonKey(defaultValue: "segf_down")
  String file_name2;
  @JsonKey(defaultValue: 7)
  int    typ;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "segfault")
  String print_word;
  @JsonKey(defaultValue: "segfault")
  String sensor_word;
  @JsonKey(defaultValue: "010-010")
  String description;
}

@JsonSerializable()
class _Search10 {
  factory _Search10.fromJson(Map<String, dynamic> json) => _$Search10FromJson(json);
  Map<String, dynamic> toJson() => _$Search10ToJson(this);

  _Search10({
    required this.file_name,
    required this.file_name2,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.sensor_word,
    required this.description,
  });

  @JsonKey(defaultValue: "ill_cnt")
  String file_name;
  @JsonKey(defaultValue: "ill_down")
  String file_name2;
  @JsonKey(defaultValue: 7)
  int    typ;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"不正な電源OFF\"")
  String print_word;
  @JsonKey(defaultValue: "shutdown")
  String sensor_word;
  @JsonKey(defaultValue: "010-020")
  String description;
}

@JsonSerializable()
class _Search11 {
  factory _Search11.fromJson(Map<String, dynamic> json) => _$Search11FromJson(json);
  Map<String, dynamic> toJson() => _$Search11ToJson(this);

  _Search11({
    required this.file_name,
    required this.file_name2,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.sensor_word,
    required this.description,
  });

  @JsonKey(defaultValue: "nodb_cnt")
  String file_name;
  @JsonKey(defaultValue: "nodb_down")
  String file_name2;
  @JsonKey(defaultValue: 7)
  int    typ;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"DB起動復旧\"")
  String print_word;
  @JsonKey(defaultValue: "database")
  String sensor_word;
  @JsonKey(defaultValue: "010-030")
  String description;
}

@JsonSerializable()
class _Search12 {
  factory _Search12.fromJson(Map<String, dynamic> json) => _$Search12FromJson(json);
  Map<String, dynamic> toJson() => _$Search12ToJson(this);

  _Search12({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/messages*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"転送エラー回数\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"ata1.00: failed command\"")
  String search_word1;
  @JsonKey(defaultValue: "\"ata1.00: failed command\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "015-020")
  String description;
}

@JsonSerializable()
class _Search13 {
  factory _Search13.fromJson(Map<String, dynamic> json) => _$Search13FromJson(json);
  Map<String, dynamic> toJson() => _$Search13ToJson(this);

  _Search13({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/fsckdate.log")
  String file_name;
  @JsonKey(defaultValue: 11)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"ファイルシステム修復\"")
  String print_word;
  @JsonKey(defaultValue: "015-030")
  String description;
}

@JsonSerializable()
class _Search15 {
  factory _Search15.fromJson(Map<String, dynamic> json) => _$Search15FromJson(json);
  Map<String, dynamic> toJson() => _$Search15ToJson(this);

  _Search15({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/tmp/rmstcls_stat.json")
  String file_name;
  @JsonKey(defaultValue: 16)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "store_close")
  String section;
  @JsonKey(defaultValue: "file_sort")
  String keyword;
  @JsonKey(defaultValue: "\"ファイル整理処理\"")
  String print_word;
  @JsonKey(defaultValue: "700-010")
  String description;
}

@JsonSerializable()
class _Search16 {
  factory _Search16.fromJson(Map<String, dynamic> json) => _$Search16FromJson(json);
  Map<String, dynamic> toJson() => _$Search16ToJson(this);

  _Search16({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/tmp/rmstcls_stat.json")
  String file_name;
  @JsonKey(defaultValue: 16)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "store_close")
  String section;
  @JsonKey(defaultValue: "usb_ng_cnt")
  String keyword;
  @JsonKey(defaultValue: "\"USBバックアップエラー回数\"")
  String print_word;
  @JsonKey(defaultValue: "015-050")
  String description;
}

@JsonSerializable()
class _Search21 {
  factory _Search21.fromJson(Map<String, dynamic> json) => _$Search21FromJson(json);
  Map<String, dynamic> toJson() => _$Search21ToJson(this);

  _Search21({
    required this.typ,
    required this.ssd,
    required this.title,
    required this.description_cd,
  });

  @JsonKey(defaultValue: 0)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    ssd;
  @JsonKey(defaultValue: "\"SSD (Lifetime)\"")
  String title;
  @JsonKey(defaultValue: 0)
  int    description_cd;
}

@JsonSerializable()
class _Search22 {
  factory _Search22.fromJson(Map<String, dynamic> json) => _$Search22FromJson(json);
  Map<String, dynamic> toJson() => _$Search22ToJson(this);

  _Search22({
    required this.file_name,
    required this.file_name2,
    required this.typ,
    required this.ssd,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.ssd_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/ssd_smhd.json")
  String file_name;
  @JsonKey(defaultValue: "/pj/tprx/log/smartinfo.txt")
  String file_name2;
  @JsonKey(defaultValue: 8)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    ssd;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"稼働開始\"")
  String print_word;
  @JsonKey(defaultValue: "SetDateTime")
  String ssd_word;
  @JsonKey(defaultValue: "025-010")
  String description;
}

@JsonSerializable()
class _Search23 {
  factory _Search23.fromJson(Map<String, dynamic> json) => _$Search23FromJson(json);
  Map<String, dynamic> toJson() => _$Search23ToJson(this);

  _Search23({
    required this.file_name,
    required this.file_name2,
    required this.typ,
    required this.ssd,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.ssd_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/ssd_smhd.json")
  String file_name;
  @JsonKey(defaultValue: "/pj/tprx/log/smartinfo.txt")
  String file_name2;
  @JsonKey(defaultValue: 8)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    ssd;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"書換回数\"")
  String print_word;
  @JsonKey(defaultValue: "RewriteCount")
  String ssd_word;
  @JsonKey(defaultValue: "025-020")
  String description;
}

@JsonSerializable()
class _Search24 {
  factory _Search24.fromJson(Map<String, dynamic> json) => _$Search24FromJson(json);
  Map<String, dynamic> toJson() => _$Search24ToJson(this);

  _Search24({
    required this.file_name,
    required this.file_name2,
    required this.typ,
    required this.ssd,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.ssd_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/ssd_smhd.json")
  String file_name;
  @JsonKey(defaultValue: "/pj/tprx/log/smartinfo.txt")
  String file_name2;
  @JsonKey(defaultValue: 8)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    ssd;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"寿命予測\"")
  String print_word;
  @JsonKey(defaultValue: "LifetimeForecast")
  String ssd_word;
  @JsonKey(defaultValue: "025-030")
  String description;
}

@JsonSerializable()
class _Search25 {
  factory _Search25.fromJson(Map<String, dynamic> json) => _$Search25FromJson(json);
  Map<String, dynamic> toJson() => _$Search25ToJson(this);

  _Search25({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/log/smartinfo.txt")
  String file_name;
  @JsonKey(defaultValue: 13)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"ファームウェア Ver.\"")
  String print_word;
  @JsonKey(defaultValue: "025-040")
  String description;
}

@JsonSerializable()
class _Search26 {
  factory _Search26.fromJson(Map<String, dynamic> json) => _$Search26FromJson(json);
  Map<String, dynamic> toJson() => _$Search26ToJson(this);

  _Search26({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/log/smartinfo.txt")
  String file_name;
  @JsonKey(defaultValue: 12)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"バッドブロック\"")
  String print_word;
  @JsonKey(defaultValue: "025-050")
  String description;
}

@JsonSerializable()
class _Search27 {
  factory _Search27.fromJson(Map<String, dynamic> json) => _$Search27FromJson(json);
  Map<String, dynamic> toJson() => _$Search27ToJson(this);

  _Search27({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/log/smartinfo.txt")
  String file_name;
  @JsonKey(defaultValue: 14)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"スペアブロック\"")
  String print_word;
  @JsonKey(defaultValue: "025-060")
  String description;
}

@JsonSerializable()
class _Search28 {
  factory _Search28.fromJson(Map<String, dynamic> json) => _$Search28FromJson(json);
  Map<String, dynamic> toJson() => _$Search28ToJson(this);

  _Search28({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/log/smartinfo.txt")
  String file_name;
  @JsonKey(defaultValue: 15)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"SSDID\"")
  String print_word;
  @JsonKey(defaultValue: "400-010")
  String description;
}

@JsonSerializable()
class _Search31 {
  factory _Search31.fromJson(Map<String, dynamic> json) => _$Search31FromJson(json);
  Map<String, dynamic> toJson() => _$Search31ToJson(this);

  _Search31({
    required this.typ,
    required this.ssd,
    required this.title,
    required this.description_cd,
  });

  @JsonKey(defaultValue: 0)
  int    typ;
  @JsonKey(defaultValue: 10)
  int    ssd;
  @JsonKey(defaultValue: "\"HDD (S.M.A.R.T.)\"")
  String title;
  @JsonKey(defaultValue: 0)
  int    description_cd;
}

@JsonSerializable()
class _Search32 {
  factory _Search32.fromJson(Map<String, dynamic> json) => _$Search32FromJson(json);
  Map<String, dynamic> toJson() => _$Search32ToJson(this);

  _Search32({
    required this.typ,
    required this.ssd,
    required this.title,
    required this.description_cd,
  });

  @JsonKey(defaultValue: 0)
  int    typ;
  @JsonKey(defaultValue: 11)
  int    ssd;
  @JsonKey(defaultValue: "\"2nd HDD (S.M.A.R.T.)\"")
  String title;
  @JsonKey(defaultValue: 1)
  int    description_cd;
}

@JsonSerializable()
class _Search33 {
  factory _Search33.fromJson(Map<String, dynamic> json) => _$Search33FromJson(json);
  Map<String, dynamic> toJson() => _$Search33ToJson(this);

  _Search33({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.print_value_ok,
    required this.print_value_ng,
    required this.smart_word,
    required this.smart_word_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "smart.log")
  String file_name;
  @JsonKey(defaultValue: 4)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"読み込みエラー率\"")
  String print_word;
  @JsonKey(defaultValue: "\"正常\"")
  String print_value_ok;
  @JsonKey(defaultValue: "\"異常\"")
  String print_value_ng;
  @JsonKey(defaultValue: "Raw_Read_Error_Rate")
  String smart_word;
  @JsonKey(defaultValue: "Raw_Read_Error_Rate")
  String smart_word_sata;
  @JsonKey(defaultValue: "02?-010")
  String description;
}

@JsonSerializable()
class _Search34 {
  factory _Search34.fromJson(Map<String, dynamic> json) => _$Search34FromJson(json);
  Map<String, dynamic> toJson() => _$Search34ToJson(this);

  _Search34({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.print_value_ok,
    required this.print_value_ng,
    required this.smart_word,
    required this.smart_word_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "smart.log")
  String file_name;
  @JsonKey(defaultValue: 4)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"代替処理済の不良セクタ数\"")
  String print_word;
  @JsonKey(defaultValue: "\"正常\"")
  String print_value_ok;
  @JsonKey(defaultValue: "\"異常\"")
  String print_value_ng;
  @JsonKey(defaultValue: "Reallocated_Sector_Ct")
  String smart_word;
  @JsonKey(defaultValue: "Reallocated_Sector_Ct")
  String smart_word_sata;
  @JsonKey(defaultValue: "02?-020")
  String description;
}

@JsonSerializable()
class _Search35 {
  factory _Search35.fromJson(Map<String, dynamic> json) => _$Search35FromJson(json);
  Map<String, dynamic> toJson() => _$Search35ToJson(this);

  _Search35({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.print_value_ok,
    required this.print_value_ng,
    required this.smart_word,
    required this.smart_word_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "smart.log")
  String file_name;
  @JsonKey(defaultValue: 4)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"磁気ヘッドシークエラー率\"")
  String print_word;
  @JsonKey(defaultValue: "\"正常\"")
  String print_value_ok;
  @JsonKey(defaultValue: "\"異常\"")
  String print_value_ng;
  @JsonKey(defaultValue: "Seek_Error_Rate")
  String smart_word;
  @JsonKey(defaultValue: "Seek_Error_Rate")
  String smart_word_sata;
  @JsonKey(defaultValue: "02?-030")
  String description;
}

@JsonSerializable()
class _Search36 {
  factory _Search36.fromJson(Map<String, dynamic> json) => _$Search36FromJson(json);
  Map<String, dynamic> toJson() => _$Search36ToJson(this);

  _Search36({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.smart_word,
    required this.smart_word_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "smart.log")
  String file_name;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"使用時間\"")
  String print_word;
  @JsonKey(defaultValue: "Power_On_Hours")
  String smart_word;
  @JsonKey(defaultValue: "Power_On_Hours")
  String smart_word_sata;
  @JsonKey(defaultValue: "02?-040")
  String description;
}

@JsonSerializable()
class _Search37 {
  factory _Search37.fromJson(Map<String, dynamic> json) => _$Search37FromJson(json);
  Map<String, dynamic> toJson() => _$Search37ToJson(this);

  _Search37({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.print_value_ok,
    required this.print_value_ng,
    required this.smart_word,
    required this.smart_word_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "smart.log")
  String file_name;
  @JsonKey(defaultValue: 4)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"スピンアップ再試行回数\"")
  String print_word;
  @JsonKey(defaultValue: "\"正常\"")
  String print_value_ok;
  @JsonKey(defaultValue: "\"異常\"")
  String print_value_ng;
  @JsonKey(defaultValue: "Spin_Retry_Count")
  String smart_word;
  @JsonKey(defaultValue: "Spin_Retry_Count")
  String smart_word_sata;
  @JsonKey(defaultValue: "02?-050")
  String description;
}

@JsonSerializable()
class _Search38 {
  factory _Search38.fromJson(Map<String, dynamic> json) => _$Search38FromJson(json);
  Map<String, dynamic> toJson() => _$Search38ToJson(this);

  _Search38({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.smart_word,
    required this.smart_word_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "smart.log")
  String file_name;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"温度\"")
  String print_word;
  @JsonKey(defaultValue: "Temperature_Celsius")
  String smart_word;
  @JsonKey(defaultValue: "Temperature_Celsius")
  String smart_word_sata;
  @JsonKey(defaultValue: "02?-060")
  String description;
}

@JsonSerializable()
class _Search39 {
  factory _Search39.fromJson(Map<String, dynamic> json) => _$Search39FromJson(json);
  Map<String, dynamic> toJson() => _$Search39ToJson(this);

  _Search39({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.print_value_ok,
    required this.print_value_ng,
    required this.smart_word,
    required this.smart_word_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "smart.log")
  String file_name;
  @JsonKey(defaultValue: 4)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"セクタ代替処理発生回数\"")
  String print_word;
  @JsonKey(defaultValue: "\"正常\"")
  String print_value_ok;
  @JsonKey(defaultValue: "\"異常\"")
  String print_value_ng;
  @JsonKey(defaultValue: "Reallocated_Event_Count")
  String smart_word;
  @JsonKey(defaultValue: "Reallocated_Event_Count")
  String smart_word_sata;
  @JsonKey(defaultValue: "02?-070")
  String description;
}

@JsonSerializable()
class _Search40 {
  factory _Search40.fromJson(Map<String, dynamic> json) => _$Search40FromJson(json);
  Map<String, dynamic> toJson() => _$Search40ToJson(this);

  _Search40({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.print_value_ok,
    required this.print_value_ng,
    required this.smart_word,
    required this.smart_word_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "smart.log")
  String file_name;
  @JsonKey(defaultValue: 4)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"代替処理待ちセクタ数\"")
  String print_word;
  @JsonKey(defaultValue: "\"正常\"")
  String print_value_ok;
  @JsonKey(defaultValue: "\"異常\"")
  String print_value_ng;
  @JsonKey(defaultValue: "Current_Pending_Sector")
  String smart_word;
  @JsonKey(defaultValue: "Current_Pending_Sector")
  String smart_word_sata;
  @JsonKey(defaultValue: "02?-080")
  String description;
}

@JsonSerializable()
class _Search41 {
  factory _Search41.fromJson(Map<String, dynamic> json) => _$Search41FromJson(json);
  Map<String, dynamic> toJson() => _$Search41ToJson(this);

  _Search41({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.print_value_ok,
    required this.print_value_ng,
    required this.smart_word,
    required this.smart_word_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "smart.log")
  String file_name;
  @JsonKey(defaultValue: 4)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"回復不可能なセクタ数\"")
  String print_word;
  @JsonKey(defaultValue: "\"正常\"")
  String print_value_ok;
  @JsonKey(defaultValue: "\"異常\"")
  String print_value_ng;
  @JsonKey(defaultValue: "Offline_Uncorrectable")
  String smart_word;
  @JsonKey(defaultValue: "Offline_Uncorrectable")
  String smart_word_sata;
  @JsonKey(defaultValue: "02?-090")
  String description;
}

@JsonSerializable()
class _Search42 {
  factory _Search42.fromJson(Map<String, dynamic> json) => _$Search42FromJson(json);
  Map<String, dynamic> toJson() => _$Search42ToJson(this);

  _Search42({
    required this.file_name,
    required this.file_name2,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.print_word2,
    required this.sensor_word,
    required this.description,
    required this.description_cd,
  });

  @JsonKey(defaultValue: "ATA_cnt")
  String file_name;
  @JsonKey(defaultValue: "ATA_down")
  String file_name2;
  @JsonKey(defaultValue: 9)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"HDDエラーログ数\"")
  String print_word;
  @JsonKey(defaultValue: "\" 最終発生時間:\"")
  String print_word2;
  @JsonKey(defaultValue: "errcount")
  String sensor_word;
  @JsonKey(defaultValue: "02?-100")
  String description;
  @JsonKey(defaultValue: 5)
  int    description_cd;
}

@JsonSerializable()
class _Search51 {
  factory _Search51.fromJson(Map<String, dynamic> json) => _$Search51FromJson(json);
  Map<String, dynamic> toJson() => _$Search51ToJson(this);

  _Search51({
    required this.typ,
    required this.ssd,
    required this.title,
    required this.description_cd,
  });

  @JsonKey(defaultValue: 0)
  int    typ;
  @JsonKey(defaultValue: 2)
  int    ssd;
  @JsonKey(defaultValue: "\"2nd SSD (Lifetime)\"")
  String title;
  @JsonKey(defaultValue: 0)
  int    description_cd;
}

@JsonSerializable()
class _Search52 {
  factory _Search52.fromJson(Map<String, dynamic> json) => _$Search52FromJson(json);
  Map<String, dynamic> toJson() => _$Search52ToJson(this);

  _Search52({
    required this.file_name,
    required this.file_name2,
    required this.typ,
    required this.ssd,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.ssd_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/ssd2_smhd.json")
  String file_name;
  @JsonKey(defaultValue: "/pj/tprx/log/smartinfo2.txt")
  String file_name2;
  @JsonKey(defaultValue: 8)
  int    typ;
  @JsonKey(defaultValue: 2)
  int    ssd;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"稼働開始\"")
  String print_word;
  @JsonKey(defaultValue: "SetDateTime")
  String ssd_word;
  @JsonKey(defaultValue: "026-010")
  String description;
}

@JsonSerializable()
class _Search53 {
  factory _Search53.fromJson(Map<String, dynamic> json) => _$Search53FromJson(json);
  Map<String, dynamic> toJson() => _$Search53ToJson(this);

  _Search53({
    required this.file_name,
    required this.file_name2,
    required this.typ,
    required this.ssd,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.ssd_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/ssd2_smhd.json")
  String file_name;
  @JsonKey(defaultValue: "/pj/tprx/log/smartinfo2.txt")
  String file_name2;
  @JsonKey(defaultValue: 8)
  int    typ;
  @JsonKey(defaultValue: 2)
  int    ssd;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"書換回数\"")
  String print_word;
  @JsonKey(defaultValue: "RewriteCount")
  String ssd_word;
  @JsonKey(defaultValue: "026-020")
  String description;
}

@JsonSerializable()
class _Search54 {
  factory _Search54.fromJson(Map<String, dynamic> json) => _$Search54FromJson(json);
  Map<String, dynamic> toJson() => _$Search54ToJson(this);

  _Search54({
    required this.file_name,
    required this.file_name2,
    required this.typ,
    required this.ssd,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.ssd_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/ssd2_smhd.json")
  String file_name;
  @JsonKey(defaultValue: "/pj/tprx/log/smartinfo2.txt")
  String file_name2;
  @JsonKey(defaultValue: 8)
  int    typ;
  @JsonKey(defaultValue: 2)
  int    ssd;
  @JsonKey(defaultValue: "no")
  String date;
  @JsonKey(defaultValue: 0)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"寿命予測\"")
  String print_word;
  @JsonKey(defaultValue: "LifetimeForecast")
  String ssd_word;
  @JsonKey(defaultValue: "026-030")
  String description;
}

@JsonSerializable()
class _Search56 {
  factory _Search56.fromJson(Map<String, dynamic> json) => _$Search56FromJson(json);
  Map<String, dynamic> toJson() => _$Search56ToJson(this);

  _Search56({
    required this.file_name,
    required this.typ,
    required this.ssd,
    required this.out_count,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/log/smartinfo2.txt")
  String file_name;
  @JsonKey(defaultValue: 12)
  int    typ;
  @JsonKey(defaultValue: 2)
  int    ssd;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"バッドブロック\"")
  String print_word;
  @JsonKey(defaultValue: "026-050")
  String description;
}

@JsonSerializable()
class _Search61 {
  factory _Search61.fromJson(Map<String, dynamic> json) => _$Search61FromJson(json);
  Map<String, dynamic> toJson() => _$Search61ToJson(this);

  _Search61({
    required this.typ,
    required this.title,
    required this.description_cd,
  });

  @JsonKey(defaultValue: 0)
  int    typ;
  @JsonKey(defaultValue: "\"USBデバイス活線挿抜\"")
  String title;
  @JsonKey(defaultValue: 0)
  int    description_cd;
}

@JsonSerializable()
class _Search62 {
  factory _Search62.fromJson(Map<String, dynamic> json) => _$Search62FromJson(json);
  Map<String, dynamic> toJson() => _$Search62ToJson(this);

  _Search62({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"スキャナ(卓上)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[0\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[0\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-010")
  String description;
}

@JsonSerializable()
class _Search63 {
  factory _Search63.fromJson(Map<String, dynamic> json) => _$Search63FromJson(json);
  Map<String, dynamic> toJson() => _$Search63ToJson(this);

  _Search63({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"スキャナ(タワー)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[1\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[1\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-020")
  String description;
}

@JsonSerializable()
class _Search64 {
  factory _Search64.fromJson(Map<String, dynamic> json) => _$Search64FromJson(json);
  Map<String, dynamic> toJson() => _$Search64ToJson(this);

  _Search64({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"客側表示器(A)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[2\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[2\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-030")
  String description;
}

@JsonSerializable()
class _Search65 {
  factory _Search65.fromJson(Map<String, dynamic> json) => _$Search65FromJson(json);
  Map<String, dynamic> toJson() => _$Search65ToJson(this);

  _Search65({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"客側表示器(B)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[3\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[3\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-040")
  String description;
}

@JsonSerializable()
class _Search66 {
  factory _Search66.fromJson(Map<String, dynamic> json) => _$Search66FromJson(json);
  Map<String, dynamic> toJson() => _$Search66ToJson(this);

  _Search66({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"客側表示器(C)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[13\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[13\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-050")
  String description;
}

@JsonSerializable()
class _Search67 {
  factory _Search67.fromJson(Map<String, dynamic> json) => _$Search67FromJson(json);
  Map<String, dynamic> toJson() => _$Search67ToJson(this);

  _Search67({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"タッチパネル(卓上)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[4\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[4\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-060")
  String description;
}

@JsonSerializable()
class _Search68 {
  factory _Search68.fromJson(Map<String, dynamic> json) => _$Search68FromJson(json);
  Map<String, dynamic> toJson() => _$Search68ToJson(this);

  _Search68({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"タッチパネル(タワー)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[5\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[5\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-070")
  String description;
}

@JsonSerializable()
class _Search69 {
  factory _Search69.fromJson(Map<String, dynamic> json) => _$Search69FromJson(json);
  Map<String, dynamic> toJson() => _$Search69ToJson(this);

  _Search69({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"メカキー(卓上)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[6\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[6\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-080")
  String description;
}

@JsonSerializable()
class _Search70 {
  factory _Search70.fromJson(Map<String, dynamic> json) => _$Search70FromJson(json);
  Map<String, dynamic> toJson() => _$Search70ToJson(this);

  _Search70({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"メカキー(タワー)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[7\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[7\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-090")
  String description;
}

@JsonSerializable()
class _Search71 {
  factory _Search71.fromJson(Map<String, dynamic> json) => _$Search71FromJson(json);
  Map<String, dynamic> toJson() => _$Search71ToJson(this);

  _Search71({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"磁気リーダー(卓上)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[8\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[8\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-100")
  String description;
}

@JsonSerializable()
class _Search72 {
  factory _Search72.fromJson(Map<String, dynamic> json) => _$Search72FromJson(json);
  Map<String, dynamic> toJson() => _$Search72ToJson(this);

  _Search72({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"磁気リーダー(タワー)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[9\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[9\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-110")
  String description;
}

@JsonSerializable()
class _Search73 {
  factory _Search73.fromJson(Map<String, dynamic> json) => _$Search73FromJson(json);
  Map<String, dynamic> toJson() => _$Search73ToJson(this);

  _Search73({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"プリンター(卓上)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[10\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[10\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-120")
  String description;
}

@JsonSerializable()
class _Search74 {
  factory _Search74.fromJson(Map<String, dynamic> json) => _$Search74FromJson(json);
  Map<String, dynamic> toJson() => _$Search74ToJson(this);

  _Search74({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"プリンター(タワー)\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[14\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[14\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-130")
  String description;
}

@JsonSerializable()
class _Search75 {
  factory _Search75.fromJson(Map<String, dynamic> json) => _$Search75FromJson(json);
  Map<String, dynamic> toJson() => _$Search75ToJson(this);

  _Search75({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"秤\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[11\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[11\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-140")
  String description;
}

@JsonSerializable()
class _Search76 {
  factory _Search76.fromJson(Map<String, dynamic> json) => _$Search76FromJson(json);
  Map<String, dynamic> toJson() => _$Search76ToJson(this);

  _Search76({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"サインポール\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[12\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[12\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-150")
  String description;
}

@JsonSerializable()
class _Search77 {
  factory _Search77.fromJson(Map<String, dynamic> json) => _$Search77FromJson(json);
  Map<String, dynamic> toJson() => _$Search77ToJson(this);

  _Search77({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"追加タッチパネル\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[15\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[15\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-160")
  String description;
}

@JsonSerializable()
class _Search78 {
  factory _Search78.fromJson(Map<String, dynamic> json) => _$Search78FromJson(json);
  Map<String, dynamic> toJson() => _$Search78ToJson(this);

  _Search78({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"ＩＣリーダー\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[16\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[16\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-170")
  String description;
}

@JsonSerializable()
class _Search79 {
  factory _Search79.fromJson(Map<String, dynamic> json) => _$Search79FromJson(json);
  Map<String, dynamic> toJson() => _$Search79ToJson(this);

  _Search79({
    required this.file_name,
    required this.typ,
    required this.date,
    required this.term_date,
    required this.out_count,
    required this.print_word,
    required this.words,
    required this.search_word1,
    required this.search_word1_sata,
    required this.description,
  });

  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: "yes")
  String date;
  @JsonKey(defaultValue: 7)
  int    term_date;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"外付けＵＰＳ\"")
  String print_word;
  @JsonKey(defaultValue: 1)
  int    words;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[17\\]\"")
  String search_word1;
  @JsonKey(defaultValue: "\"USB_CLOSE_INFORMATION\\[17\\]\"")
  String search_word1_sata;
  @JsonKey(defaultValue: "030-180")
  String description;
}

@JsonSerializable()
class _Search80 {
  factory _Search80.fromJson(Map<String, dynamic> json) => _$Search80FromJson(json);
  Map<String, dynamic> toJson() => _$Search80ToJson(this);

  _Search80({
    required this.typ,
    required this.file_name,
    required this.out_count,
    required this.print_word,
    required this.print_value_ok,
    required this.print_value_ng,
    required this.description,
  });

  @JsonKey(defaultValue: 10)
  int    typ;
  @JsonKey(defaultValue: "/var/log/web21_boot.log*")
  String file_name;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"USBカメラ\"")
  String print_word;
  @JsonKey(defaultValue: "\"正常\"")
  String print_value_ok;
  @JsonKey(defaultValue: "\"異常\"")
  String print_value_ng;
  @JsonKey(defaultValue: "030-190")
  String description;
}

@JsonSerializable()
class _Search91 {
  factory _Search91.fromJson(Map<String, dynamic> json) => _$Search91FromJson(json);
  Map<String, dynamic> toJson() => _$Search91ToJson(this);

  _Search91({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/version.json")
  String file_name;
  @JsonKey(defaultValue: 53)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "apl")
  String section;
  @JsonKey(defaultValue: "ver")
  String keyword;
  @JsonKey(defaultValue: "\"APL Ver\"")
  String print_word;
  @JsonKey(defaultValue: "100-001")
  String description;
}

@JsonSerializable()
class _Search92 {
  factory _Search92.fromJson(Map<String, dynamic> json) => _$Search92FromJson(json);
  Map<String, dynamic> toJson() => _$Search92ToJson(this);

  _Search92({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/version.json")
  String file_name;
  @JsonKey(defaultValue: 50)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "base_db")
  String section;
  @JsonKey(defaultValue: "ver")
  String keyword;
  @JsonKey(defaultValue: "\"DB Ver\"")
  String print_word;
  @JsonKey(defaultValue: "100-002")
  String description;
}

@JsonSerializable()
class _Search93 {
  factory _Search93.fromJson(Map<String, dynamic> json) => _$Search93FromJson(json);
  Map<String, dynamic> toJson() => _$Search93ToJson(this);

  _Search93({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/version_smhd.json")
  String file_name;
  @JsonKey(defaultValue: 53)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "submasterhd")
  String section;
  @JsonKey(defaultValue: "ver")
  String keyword;
  @JsonKey(defaultValue: "\"SMHD Ver\"")
  String print_word;
  @JsonKey(defaultValue: "100-003")
  String description;
}

@JsonSerializable()
class _Search94 {
  factory _Search94.fromJson(Map<String, dynamic> json) => _$Search94FromJson(json);
  Map<String, dynamic> toJson() => _$Search94ToJson(this);

  _Search94({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/mac_info.json")
  String file_name;
  @JsonKey(defaultValue: 50)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "fcon_version")
  String section;
  @JsonKey(defaultValue: "printer")
  String keyword;
  @JsonKey(defaultValue: "\"Printer Ver\"")
  String print_word;
  @JsonKey(defaultValue: "100-005")
  String description;
}

@JsonSerializable()
class _Search95 {
  factory _Search95.fromJson(Map<String, dynamic> json) => _$Search95FromJson(json);
  Map<String, dynamic> toJson() => _$Search95ToJson(this);

  _Search95({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/mac_info.json")
  String file_name;
  @JsonKey(defaultValue: 50)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "fcon_version")
  String section;
  @JsonKey(defaultValue: "printer2")
  String keyword;
  @JsonKey(defaultValue: "\"Printer(WebSpeezaC)\"")
  String print_word;
  @JsonKey(defaultValue: "100-006")
  String description;
}

@JsonSerializable()
class _Search96 {
  factory _Search96.fromJson(Map<String, dynamic> json) => _$Search96FromJson(json);
  Map<String, dynamic> toJson() => _$Search96ToJson(this);

  _Search96({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/version_ssps.json")
  String file_name;
  @JsonKey(defaultValue: 50)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "self_data")
  String section;
  @JsonKey(defaultValue: "ver")
  String keyword;
  @JsonKey(defaultValue: "\"SELF Ver\"")
  String print_word;
  @JsonKey(defaultValue: "100-010")
  String description;
}

@JsonSerializable()
class _Search97 {
  factory _Search97.fromJson(Map<String, dynamic> json) => _$Search97FromJson(json);
  Map<String, dynamic> toJson() => _$Search97ToJson(this);

  _Search97({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/counter.json")
  String file_name;
  @JsonKey(defaultValue: 51)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "tran")
  String section;
  @JsonKey(defaultValue: "sale_date")
  String keyword;
  @JsonKey(defaultValue: "\"本日営業日\"")
  String print_word;
  @JsonKey(defaultValue: "200-001")
  String description;
}

@JsonSerializable()
class _Search98 {
  factory _Search98.fromJson(Map<String, dynamic> json) => _$Search98FromJson(json);
  Map<String, dynamic> toJson() => _$Search98ToJson(this);

  _Search98({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "ifconfig")
  String file_name;
  @JsonKey(defaultValue: 52)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "\"MACアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "400-001")
  String description;
}

@JsonSerializable()
class _Search99 {
  factory _Search99.fromJson(Map<String, dynamic> json) => _$Search99FromJson(json);
  Map<String, dynamic> toJson() => _$Search99ToJson(this);

  _Search99({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/mac_info.json")
  String file_name;
  @JsonKey(defaultValue: 51)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "system")
  String section;
  @JsonKey(defaultValue: "shpno")
  String keyword;
  @JsonKey(defaultValue: "\"店舗番号\"")
  String print_word;
  @JsonKey(defaultValue: "210-001")
  String description;
}

@JsonSerializable()
class _Search100 {
  factory _Search100.fromJson(Map<String, dynamic> json) => _$Search100FromJson(json);
  Map<String, dynamic> toJson() => _$Search100ToJson(this);

  _Search100({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/mac_info.json")
  String file_name;
  @JsonKey(defaultValue: 51)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "system")
  String section;
  @JsonKey(defaultValue: "macno")
  String keyword;
  @JsonKey(defaultValue: "\"レジ番号\"")
  String print_word;
  @JsonKey(defaultValue: "210-002")
  String description;
}

@JsonSerializable()
class _Search101 {
  factory _Search101.fromJson(Map<String, dynamic> json) => _$Search101FromJson(json);
  Map<String, dynamic> toJson() => _$Search101ToJson(this);

  _Search101({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/mac_info.json")
  String file_name;
  @JsonKey(defaultValue: 51)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "mm_system")
  String section;
  @JsonKey(defaultValue: "mm_onoff")
  String keyword;
  @JsonKey(defaultValue: "\"M/S仕様\"")
  String print_word;
  @JsonKey(defaultValue: "210-003")
  String description;
}

@JsonSerializable()
class _Search102 {
  factory _Search102.fromJson(Map<String, dynamic> json) => _$Search102FromJson(json);
  Map<String, dynamic> toJson() => _$Search102ToJson(this);

  _Search102({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/mac_info.json")
  String file_name;
  @JsonKey(defaultValue: 51)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "mm_system")
  String section;
  @JsonKey(defaultValue: "mm_type")
  String keyword;
  @JsonKey(defaultValue: "\"マシンタイプ\"")
  String print_word;
  @JsonKey(defaultValue: "210-004")
  String description;
}

@JsonSerializable()
class _Search103 {
  factory _Search103.fromJson(Map<String, dynamic> json) => _$Search103FromJson(json);
  Map<String, dynamic> toJson() => _$Search103ToJson(this);

  _Search103({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/mac_info.json")
  String file_name;
  @JsonKey(defaultValue: 51)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "timeserver")
  String section;
  @JsonKey(defaultValue: "timeserver")
  String keyword;
  @JsonKey(defaultValue: "\"時刻問い合わせ先\"")
  String print_word;
  @JsonKey(defaultValue: "210-011")
  String description;
}

@JsonSerializable()
class _Search104 {
  factory _Search104.fromJson(Map<String, dynamic> json) => _$Search104FromJson(json);
  Map<String, dynamic> toJson() => _$Search104ToJson(this);

  _Search104({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/mac_info.json")
  String file_name;
  @JsonKey(defaultValue: 51)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "mm_system")
  String section;
  @JsonKey(defaultValue: "sgt_cf_wt")
  String keyword;
  @JsonKey(defaultValue: "\"バックアップメモリ\"")
  String print_word;
  @JsonKey(defaultValue: "210-012")
  String description;
}

@JsonSerializable()
class _Search105 {
  factory _Search105.fromJson(Map<String, dynamic> json) => _$Search105FromJson(json);
  Map<String, dynamic> toJson() => _$Search105ToJson(this);

  _Search105({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/mac_info_JC_C.json")
  String file_name;
  @JsonKey(defaultValue: 54)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "system")
  String section;
  @JsonKey(defaultValue: "macno")
  String keyword;
  @JsonKey(defaultValue: "\"レジ番号(JC)\"")
  String print_word;
  @JsonKey(defaultValue: "210-005")
  String description;
}

@JsonSerializable()
class _Search106 {
  factory _Search106.fromJson(Map<String, dynamic> json) => _$Search106FromJson(json);
  Map<String, dynamic> toJson() => _$Search106ToJson(this);

  _Search106({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "web000001")
  String keyword;
  @JsonKey(defaultValue: "\"IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-001")
  String description;
}

@JsonSerializable()
class _Search107 {
  factory _Search107.fromJson(Map<String, dynamic> json) => _$Search107FromJson(json);
  Map<String, dynamic> toJson() => _$Search107ToJson(this);

  _Search107({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/sysconfig/network-scripts/ifcfg-eth0")
  String file_name;
  @JsonKey(defaultValue: 56)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "NETMASK")
  String keyword;
  @JsonKey(defaultValue: "\"サブネットマスク\"")
  String print_word;
  @JsonKey(defaultValue: "500-002")
  String description;
}

@JsonSerializable()
class _Search108 {
  factory _Search108.fromJson(Map<String, dynamic> json) => _$Search108FromJson(json);
  Map<String, dynamic> toJson() => _$Search108ToJson(this);

  _Search108({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/sysconfig/network-scripts/ifcfg-eth0")
  String file_name;
  @JsonKey(defaultValue: 56)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "GATEWAY")
  String keyword;
  @JsonKey(defaultValue: "\"ゲートウェイアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-003")
  String description;
}

@JsonSerializable()
class _Search109 {
  factory _Search109.fromJson(Map<String, dynamic> json) => _$Search109FromJson(json);
  Map<String, dynamic> toJson() => _$Search109ToJson(this);

  _Search109({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "ts2100")
  String keyword;
  @JsonKey(defaultValue: "\"サーバー IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-004")
  String description;
}

@JsonSerializable()
class _Search110 {
  factory _Search110.fromJson(Map<String, dynamic> json) => _$Search110FromJson(json);
  Map<String, dynamic> toJson() => _$Search110ToJson(this);

  _Search110({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "subsrx")
  String keyword;
  @JsonKey(defaultValue: "\"サブサーバー IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-005")
  String description;
}

@JsonSerializable()
class _Search111 {
  factory _Search111.fromJson(Map<String, dynamic> json) => _$Search111FromJson(json);
  Map<String, dynamic> toJson() => _$Search111ToJson(this);

  _Search111({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "sims2100")
  String keyword;
  @JsonKey(defaultValue: "\"SIMS2100 IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-006")
  String description;
}

@JsonSerializable()
class _Search112 {
  factory _Search112.fromJson(Map<String, dynamic> json) => _$Search112FromJson(json);
  Map<String, dynamic> toJson() => _$Search112ToJson(this);

  _Search112({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "hqserver")
  String keyword;
  @JsonKey(defaultValue: "\"テキストデータ保存 IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-007")
  String description;
}

@JsonSerializable()
class _Search113 {
  factory _Search113.fromJson(Map<String, dynamic> json) => _$Search113FromJson(json);
  Map<String, dynamic> toJson() => _$Search113ToJson(this);

  _Search113({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "custserver")
  String keyword;
  @JsonKey(defaultValue: "\"顧客サーバー IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-009")
  String description;
}

@JsonSerializable()
class _Search114 {
  factory _Search114.fromJson(Map<String, dynamic> json) => _$Search114FromJson(json);
  Map<String, dynamic> toJson() => _$Search114ToJson(this);

  _Search114({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/resolv.conf")
  String file_name;
  @JsonKey(defaultValue: 57)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: 1)
  int    keyword;
  @JsonKey(defaultValue: "\"DNS(1)\"")
  String print_word;
  @JsonKey(defaultValue: "500-010")
  String description;
}

@JsonSerializable()
class _Search115 {
  factory _Search115.fromJson(Map<String, dynamic> json) => _$Search115FromJson(json);
  Map<String, dynamic> toJson() => _$Search115ToJson(this);

  _Search115({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/resolv.conf")
  String file_name;
  @JsonKey(defaultValue: 57)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: 2)
  int    keyword;
  @JsonKey(defaultValue: "\"DNS(2)\"")
  String print_word;
  @JsonKey(defaultValue: "500-011")
  String description;
}

@JsonSerializable()
class _Search116 {
  factory _Search116.fromJson(Map<String, dynamic> json) => _$Search116FromJson(json);
  Map<String, dynamic> toJson() => _$Search116ToJson(this);

  _Search116({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "timeserver")
  String keyword;
  @JsonKey(defaultValue: "\"タイムサーバー IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-012")
  String description;
}

@JsonSerializable()
class _Search117 {
  factory _Search117.fromJson(Map<String, dynamic> json) => _$Search117FromJson(json);
  Map<String, dynamic> toJson() => _$Search117ToJson(this);

  _Search117({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "centerserver_mst")
  String keyword;
  @JsonKey(defaultValue: "\"センターサーバー(マスタ) IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-013")
  String description;
}

@JsonSerializable()
class _Search118 {
  factory _Search118.fromJson(Map<String, dynamic> json) => _$Search118FromJson(json);
  Map<String, dynamic> toJson() => _$Search118ToJson(this);

  _Search118({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "centerserver_trn")
  String keyword;
  @JsonKey(defaultValue: "\"センターサーバー(実績) IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-014")
  String description;
}

@JsonSerializable()
class _Search119 {
  factory _Search119.fromJson(Map<String, dynamic> json) => _$Search119FromJson(json);
  Map<String, dynamic> toJson() => _$Search119ToJson(this);

  _Search119({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "pbchg1")
  String keyword;
  @JsonKey(defaultValue: "\"収納サーバー(Primary) IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-016")
  String description;
}

@JsonSerializable()
class _Search120 {
  factory _Search120.fromJson(Map<String, dynamic> json) => _$Search120FromJson(json);
  Map<String, dynamic> toJson() => _$Search120ToJson(this);

  _Search120({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "pbchg2")
  String keyword;
  @JsonKey(defaultValue: "\"収納サーバー(Secondary) IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-017")
  String description;
}

@JsonSerializable()
class _Search121 {
  factory _Search121.fromJson(Map<String, dynamic> json) => _$Search121FromJson(json);
  Map<String, dynamic> toJson() => _$Search121ToJson(this);

  _Search121({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "spqc")
  String keyword;
  @JsonKey(defaultValue: "\"お会計券管理 IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-018")
  String description;
}

@JsonSerializable()
class _Search122 {
  factory _Search122.fromJson(Map<String, dynamic> json) => _$Search122FromJson(json);
  Map<String, dynamic> toJson() => _$Search122ToJson(this);

  _Search122({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "spqc_subsvr")
  String keyword;
  @JsonKey(defaultValue: "\"お会計券管理サブサーバー IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-019")
  String description;
}

@JsonSerializable()
class _Search123 {
  factory _Search123.fromJson(Map<String, dynamic> json) => _$Search123FromJson(json);
  Map<String, dynamic> toJson() => _$Search123ToJson(this);

  _Search123({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "hq_2nd_server")
  String keyword;
  @JsonKey(defaultValue: "\"上位第2接続先 IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-022")
  String description;
}

@JsonSerializable()
class _Search124 {
  factory _Search124.fromJson(Map<String, dynamic> json) => _$Search124FromJson(json);
  Map<String, dynamic> toJson() => _$Search124ToJson(this);

  _Search124({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "verup_cnct")
  String keyword;
  @JsonKey(defaultValue: "\"バージョンアップファイル取得先 IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-023")
  String description;
}

@JsonSerializable()
class _Search125 {
  factory _Search125.fromJson(Map<String, dynamic> json) => _$Search125FromJson(json);
  Map<String, dynamic> toJson() => _$Search125ToJson(this);

  _Search125({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "kitchen_print1")
  String keyword;
  @JsonKey(defaultValue: "\"キッチンプリンタ1 IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-024")
  String description;
}

@JsonSerializable()
class _Search126 {
  factory _Search126.fromJson(Map<String, dynamic> json) => _$Search126FromJson(json);
  Map<String, dynamic> toJson() => _$Search126ToJson(this);

  _Search126({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "kitchen_print2")
  String keyword;
  @JsonKey(defaultValue: "\"キッチンプリンタ2 IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-025")
  String description;
}

@JsonSerializable()
class _Search127 {
  factory _Search127.fromJson(Map<String, dynamic> json) => _$Search127FromJson(json);
  Map<String, dynamic> toJson() => _$Search127ToJson(this);

  _Search127({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "bkup_save")
  String keyword;
  @JsonKey(defaultValue: "\"spec_bkup保存先 IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-026")
  String description;
}

@JsonSerializable()
class _Search128 {
  factory _Search128.fromJson(Map<String, dynamic> json) => _$Search128FromJson(json);
  Map<String, dynamic> toJson() => _$Search128ToJson(this);

  _Search128({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "histlog_server")
  String keyword;
  @JsonKey(defaultValue: "\"履歴(COPY文)マスター取込み先 IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-027")
  String description;
}

@JsonSerializable()
class _Search129 {
  factory _Search129.fromJson(Map<String, dynamic> json) => _$Search129FromJson(json);
  Map<String, dynamic> toJson() => _$Search129ToJson(this);

  _Search129({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "manage")
  String keyword;
  @JsonKey(defaultValue: "\"モニタPC IPアドレス\"")
  String print_word;
  @JsonKey(defaultValue: "500-029")
  String description;
}

@JsonSerializable()
class _Search130 {
  factory _Search130.fromJson(Map<String, dynamic> json) => _$Search130FromJson(json);
  Map<String, dynamic> toJson() => _$Search130ToJson(this);

  _Search130({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "histlog_sub_server")
  String keyword;
  @JsonKey(defaultValue: "\"履歴(COPY文)マスター取込み先 IPアドレス(サブ)\"")
  String print_word;
  @JsonKey(defaultValue: "500-028")
  String description;
}

@JsonSerializable()
class _Search131 {
  factory _Search131.fromJson(Map<String, dynamic> json) => _$Search131FromJson(json);
  Map<String, dynamic> toJson() => _$Search131ToJson(this);

  _Search131({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/mac_info.json")
  String file_name;
  @JsonKey(defaultValue: 51)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "system")
  String section;
  @JsonKey(defaultValue: "crpno")
  String keyword;
  @JsonKey(defaultValue: "\"企業番号\"")
  String print_word;
  @JsonKey(defaultValue: "210-100")
  String description;
}

@JsonSerializable()
class _Search132 {
  factory _Search132.fromJson(Map<String, dynamic> json) => _$Search132FromJson(json);
  Map<String, dynamic> toJson() => _$Search132ToJson(this);

  _Search132({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "ts21db")
  String keyword;
  @JsonKey(defaultValue: "\"DBサーバー\"")
  String print_word;
  @JsonKey(defaultValue: "500-100")
  String description;
}

@JsonSerializable()
class _Search133 {
  factory _Search133.fromJson(Map<String, dynamic> json) => _$Search133FromJson(json);
  Map<String, dynamic> toJson() => _$Search133ToJson(this);

  _Search133({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "tswebsvr")
  String keyword;
  @JsonKey(defaultValue: "\"TS仕様シェル実行\"")
  String print_word;
  @JsonKey(defaultValue: "500-101")
  String description;
}

@JsonSerializable()
class _Search134 {
  factory _Search134.fromJson(Map<String, dynamic> json) => _$Search134FromJson(json);
  Map<String, dynamic> toJson() => _$Search134ToJson(this);

  _Search134({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/etc/hosts")
  String file_name;
  @JsonKey(defaultValue: 55)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "")
  String section;
  @JsonKey(defaultValue: "cust_reserve_svr")
  String keyword;
  @JsonKey(defaultValue: "\"顧客(予約)DBサーバー\"")
  String print_word;
  @JsonKey(defaultValue: "500-102")
  String description;
}

@JsonSerializable()
class _Search135 {
  factory _Search135.fromJson(Map<String, dynamic> json) => _$Search135FromJson(json);
  Map<String, dynamic> toJson() => _$Search135ToJson(this);

  _Search135({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/barcode_pay.json")
  String file_name;
  @JsonKey(defaultValue: 51)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "barcodepay")
  String section;
  @JsonKey(defaultValue: "validFlg")
  String keyword;
  @JsonKey(defaultValue: "\"JPQR決済利用\"")
  String print_word;
  @JsonKey(defaultValue: "600-001")
  String description;
}

@JsonSerializable()
class _Search136 {
  factory _Search136.fromJson(Map<String, dynamic> json) => _$Search136FromJson(json);
  Map<String, dynamic> toJson() => _$Search136ToJson(this);

  _Search136({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/repica.json")
  String file_name;
  @JsonKey(defaultValue: 51)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "normal")
  String section;
  @JsonKey(defaultValue: "validFlg")
  String keyword;
  @JsonKey(defaultValue: "\"レピカ利用\"")
  String print_word;
  @JsonKey(defaultValue: "600-002")
  String description;
}

@JsonSerializable()
class _Search137 {
  factory _Search137.fromJson(Map<String, dynamic> json) => _$Search137FromJson(json);
  Map<String, dynamic> toJson() => _$Search137ToJson(this);

  _Search137({
    required this.file_name,
    required this.typ,
    required this.out_count,
    required this.section,
    required this.keyword,
    required this.print_word,
    required this.description,
  });

  @JsonKey(defaultValue: "/pj/tprx/conf/repica.json")
  String file_name;
  @JsonKey(defaultValue: 51)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    out_count;
  @JsonKey(defaultValue: "cocona")
  String section;
  @JsonKey(defaultValue: "validFlg_cocona")
  String keyword;
  @JsonKey(defaultValue: "\"cocona利用\"")
  String print_word;
  @JsonKey(defaultValue: "600-003")
  String description;
}

