/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'qcashierJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class QcashierJsonFile extends ConfigJsonFile {
  static final QcashierJsonFile _instance = QcashierJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "qcashier.json";

  QcashierJsonFile(){
    setPath(_confPath, _fileName);
  }
  QcashierJsonFile._internal();

  factory QcashierJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$QcashierJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$QcashierJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$QcashierJsonFileToJson(this));
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
        chg_info = _$Chg_infoFromJson(jsonD['chg_info']);
      } catch(e) {
        chg_info = _$Chg_infoFromJson({});
        ret = false;
      }
      try {
        period = _$PeriodFromJson(jsonD['period']);
      } catch(e) {
        period = _$PeriodFromJson({});
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
      try {
        screen44 = _$Screen44FromJson(jsonD['screen44']);
      } catch(e) {
        screen44 = _$Screen44FromJson({});
        ret = false;
      }
      try {
        screen45 = _$Screen45FromJson(jsonD['screen45']);
      } catch(e) {
        screen45 = _$Screen45FromJson({});
        ret = false;
      }
      try {
        screen46 = _$Screen46FromJson(jsonD['screen46']);
      } catch(e) {
        screen46 = _$Screen46FromJson({});
        ret = false;
      }
      try {
        screen47 = _$Screen47FromJson(jsonD['screen47']);
      } catch(e) {
        screen47 = _$Screen47FromJson({});
        ret = false;
      }
      try {
        screen48 = _$Screen48FromJson(jsonD['screen48']);
      } catch(e) {
        screen48 = _$Screen48FromJson({});
        ret = false;
      }
      try {
        screen49 = _$Screen49FromJson(jsonD['screen49']);
      } catch(e) {
        screen49 = _$Screen49FromJson({});
        ret = false;
      }
      try {
        screen50 = _$Screen50FromJson(jsonD['screen50']);
      } catch(e) {
        screen50 = _$Screen50FromJson({});
        ret = false;
      }
      try {
        screen51 = _$Screen51FromJson(jsonD['screen51']);
      } catch(e) {
        screen51 = _$Screen51FromJson({});
        ret = false;
      }
      try {
        screen52 = _$Screen52FromJson(jsonD['screen52']);
      } catch(e) {
        screen52 = _$Screen52FromJson({});
        ret = false;
      }
      try {
        screen53 = _$Screen53FromJson(jsonD['screen53']);
      } catch(e) {
        screen53 = _$Screen53FromJson({});
        ret = false;
      }
      try {
        screen54 = _$Screen54FromJson(jsonD['screen54']);
      } catch(e) {
        screen54 = _$Screen54FromJson({});
        ret = false;
      }
      try {
        screen55 = _$Screen55FromJson(jsonD['screen55']);
      } catch(e) {
        screen55 = _$Screen55FromJson({});
        ret = false;
      }
      try {
        screen56 = _$Screen56FromJson(jsonD['screen56']);
      } catch(e) {
        screen56 = _$Screen56FromJson({});
        ret = false;
      }
      try {
        screen57 = _$Screen57FromJson(jsonD['screen57']);
      } catch(e) {
        screen57 = _$Screen57FromJson({});
        ret = false;
      }
      try {
        screen58 = _$Screen58FromJson(jsonD['screen58']);
      } catch(e) {
        screen58 = _$Screen58FromJson({});
        ret = false;
      }
      try {
        screen59 = _$Screen59FromJson(jsonD['screen59']);
      } catch(e) {
        screen59 = _$Screen59FromJson({});
        ret = false;
      }
      try {
        screen60 = _$Screen60FromJson(jsonD['screen60']);
      } catch(e) {
        screen60 = _$Screen60FromJson({});
        ret = false;
      }
      try {
        screen61 = _$Screen61FromJson(jsonD['screen61']);
      } catch(e) {
        screen61 = _$Screen61FromJson({});
        ret = false;
      }
      try {
        screen62 = _$Screen62FromJson(jsonD['screen62']);
      } catch(e) {
        screen62 = _$Screen62FromJson({});
        ret = false;
      }
      try {
        screen63 = _$Screen63FromJson(jsonD['screen63']);
      } catch(e) {
        screen63 = _$Screen63FromJson({});
        ret = false;
      }
      try {
        screen64 = _$Screen64FromJson(jsonD['screen64']);
      } catch(e) {
        screen64 = _$Screen64FromJson({});
        ret = false;
      }
      try {
        screen65 = _$Screen65FromJson(jsonD['screen65']);
      } catch(e) {
        screen65 = _$Screen65FromJson({});
        ret = false;
      }
      try {
        screen67 = _$Screen67FromJson(jsonD['screen67']);
      } catch(e) {
        screen67 = _$Screen67FromJson({});
        ret = false;
      }
      try {
        screen68 = _$Screen68FromJson(jsonD['screen68']);
      } catch(e) {
        screen68 = _$Screen68FromJson({});
        ret = false;
      }
      try {
        screen69 = _$Screen69FromJson(jsonD['screen69']);
      } catch(e) {
        screen69 = _$Screen69FromJson({});
        ret = false;
      }
      try {
        screen70 = _$Screen70FromJson(jsonD['screen70']);
      } catch(e) {
        screen70 = _$Screen70FromJson({});
        ret = false;
      }
      try {
        screen71 = _$Screen71FromJson(jsonD['screen71']);
      } catch(e) {
        screen71 = _$Screen71FromJson({});
        ret = false;
      }
      try {
        screen72 = _$Screen72FromJson(jsonD['screen72']);
      } catch(e) {
        screen72 = _$Screen72FromJson({});
        ret = false;
      }
      try {
        screen73 = _$Screen73FromJson(jsonD['screen73']);
      } catch(e) {
        screen73 = _$Screen73FromJson({});
        ret = false;
      }
      try {
        screen74 = _$Screen74FromJson(jsonD['screen74']);
      } catch(e) {
        screen74 = _$Screen74FromJson({});
        ret = false;
      }
      try {
        screen75 = _$Screen75FromJson(jsonD['screen75']);
      } catch(e) {
        screen75 = _$Screen75FromJson({});
        ret = false;
      }
      try {
        screen76 = _$Screen76FromJson(jsonD['screen76']);
      } catch(e) {
        screen76 = _$Screen76FromJson({});
        ret = false;
      }
      try {
        screen77 = _$Screen77FromJson(jsonD['screen77']);
      } catch(e) {
        screen77 = _$Screen77FromJson({});
        ret = false;
      }
      try {
        screen78 = _$Screen78FromJson(jsonD['screen78']);
      } catch(e) {
        screen78 = _$Screen78FromJson({});
        ret = false;
      }
      try {
        screen79 = _$Screen79FromJson(jsonD['screen79']);
      } catch(e) {
        screen79 = _$Screen79FromJson({});
        ret = false;
      }
      try {
        screen81 = _$Screen81FromJson(jsonD['screen81']);
      } catch(e) {
        screen81 = _$Screen81FromJson({});
        ret = false;
      }
      try {
        screen82 = _$Screen82FromJson(jsonD['screen82']);
      } catch(e) {
        screen82 = _$Screen82FromJson({});
        ret = false;
      }
      try {
        screen83 = _$Screen83FromJson(jsonD['screen83']);
      } catch(e) {
        screen83 = _$Screen83FromJson({});
        ret = false;
      }
      try {
        screen84 = _$Screen84FromJson(jsonD['screen84']);
      } catch(e) {
        screen84 = _$Screen84FromJson({});
        ret = false;
      }
      try {
        screen85 = _$Screen85FromJson(jsonD['screen85']);
      } catch(e) {
        screen85 = _$Screen85FromJson({});
        ret = false;
      }
      try {
        screen86 = _$Screen86FromJson(jsonD['screen86']);
      } catch(e) {
        screen86 = _$Screen86FromJson({});
        ret = false;
      }
      try {
        screen87 = _$Screen87FromJson(jsonD['screen87']);
      } catch(e) {
        screen87 = _$Screen87FromJson({});
        ret = false;
      }
      try {
        screen88 = _$Screen88FromJson(jsonD['screen88']);
      } catch(e) {
        screen88 = _$Screen88FromJson({});
        ret = false;
      }
      try {
        screen89 = _$Screen89FromJson(jsonD['screen89']);
      } catch(e) {
        screen89 = _$Screen89FromJson({});
        ret = false;
      }
      try {
        screen90 = _$Screen90FromJson(jsonD['screen90']);
      } catch(e) {
        screen90 = _$Screen90FromJson({});
        ret = false;
      }
      try {
        screen91 = _$Screen91FromJson(jsonD['screen91']);
      } catch(e) {
        screen91 = _$Screen91FromJson({});
        ret = false;
      }
      try {
        screen92 = _$Screen92FromJson(jsonD['screen92']);
      } catch(e) {
        screen92 = _$Screen92FromJson({});
        ret = false;
      }
      try {
        screen93 = _$Screen93FromJson(jsonD['screen93']);
      } catch(e) {
        screen93 = _$Screen93FromJson({});
        ret = false;
      }
      try {
        screen94 = _$Screen94FromJson(jsonD['screen94']);
      } catch(e) {
        screen94 = _$Screen94FromJson({});
        ret = false;
      }
      try {
        screen95 = _$Screen95FromJson(jsonD['screen95']);
      } catch(e) {
        screen95 = _$Screen95FromJson({});
        ret = false;
      }
      try {
        screen96 = _$Screen96FromJson(jsonD['screen96']);
      } catch(e) {
        screen96 = _$Screen96FromJson({});
        ret = false;
      }
      try {
        screen97 = _$Screen97FromJson(jsonD['screen97']);
      } catch(e) {
        screen97 = _$Screen97FromJson({});
        ret = false;
      }
      try {
        screen98 = _$Screen98FromJson(jsonD['screen98']);
      } catch(e) {
        screen98 = _$Screen98FromJson({});
        ret = false;
      }
      try {
        screen99 = _$Screen99FromJson(jsonD['screen99']);
      } catch(e) {
        screen99 = _$Screen99FromJson({});
        ret = false;
      }
      try {
        screen100 = _$Screen100FromJson(jsonD['screen100']);
      } catch(e) {
        screen100 = _$Screen100FromJson({});
        ret = false;
      }
      try {
        screen101 = _$Screen101FromJson(jsonD['screen101']);
      } catch(e) {
        screen101 = _$Screen101FromJson({});
        ret = false;
      }
      try {
        screen102 = _$Screen102FromJson(jsonD['screen102']);
      } catch(e) {
        screen102 = _$Screen102FromJson({});
        ret = false;
      }
      try {
        screen103 = _$Screen103FromJson(jsonD['screen103']);
      } catch(e) {
        screen103 = _$Screen103FromJson({});
        ret = false;
      }
      try {
        screen104 = _$Screen104FromJson(jsonD['screen104']);
      } catch(e) {
        screen104 = _$Screen104FromJson({});
        ret = false;
      }
      try {
        screen105 = _$Screen105FromJson(jsonD['screen105']);
      } catch(e) {
        screen105 = _$Screen105FromJson({});
        ret = false;
      }
      try {
        screen106 = _$Screen106FromJson(jsonD['screen106']);
      } catch(e) {
        screen106 = _$Screen106FromJson({});
        ret = false;
      }
      try {
        screen107 = _$Screen107FromJson(jsonD['screen107']);
      } catch(e) {
        screen107 = _$Screen107FromJson({});
        ret = false;
      }
      try {
        screen109 = _$Screen109FromJson(jsonD['screen109']);
      } catch(e) {
        screen109 = _$Screen109FromJson({});
        ret = false;
      }
      try {
        screen111 = _$Screen111FromJson(jsonD['screen111']);
      } catch(e) {
        screen111 = _$Screen111FromJson({});
        ret = false;
      }
      try {
        screen112 = _$Screen112FromJson(jsonD['screen112']);
      } catch(e) {
        screen112 = _$Screen112FromJson({});
        ret = false;
      }
      try {
        screen113 = _$Screen113FromJson(jsonD['screen113']);
      } catch(e) {
        screen113 = _$Screen113FromJson({});
        ret = false;
      }
      try {
        screen114 = _$Screen114FromJson(jsonD['screen114']);
      } catch(e) {
        screen114 = _$Screen114FromJson({});
        ret = false;
      }
      try {
        screen115 = _$Screen115FromJson(jsonD['screen115']);
      } catch(e) {
        screen115 = _$Screen115FromJson({});
        ret = false;
      }
      try {
        screen116 = _$Screen116FromJson(jsonD['screen116']);
      } catch(e) {
        screen116 = _$Screen116FromJson({});
        ret = false;
      }
      try {
        screen117 = _$Screen117FromJson(jsonD['screen117']);
      } catch(e) {
        screen117 = _$Screen117FromJson({});
        ret = false;
      }
      try {
        screen118 = _$Screen118FromJson(jsonD['screen118']);
      } catch(e) {
        screen118 = _$Screen118FromJson({});
        ret = false;
      }
      try {
        screen119 = _$Screen119FromJson(jsonD['screen119']);
      } catch(e) {
        screen119 = _$Screen119FromJson({});
        ret = false;
      }
      try {
        screen120 = _$Screen120FromJson(jsonD['screen120']);
      } catch(e) {
        screen120 = _$Screen120FromJson({});
        ret = false;
      }
      try {
        screen121 = _$Screen121FromJson(jsonD['screen121']);
      } catch(e) {
        screen121 = _$Screen121FromJson({});
        ret = false;
      }
      try {
        screen122 = _$Screen122FromJson(jsonD['screen122']);
      } catch(e) {
        screen122 = _$Screen122FromJson({});
        ret = false;
      }
      try {
        screen123 = _$Screen123FromJson(jsonD['screen123']);
      } catch(e) {
        screen123 = _$Screen123FromJson({});
        ret = false;
      }
      try {
        screen124 = _$Screen124FromJson(jsonD['screen124']);
      } catch(e) {
        screen124 = _$Screen124FromJson({});
        ret = false;
      }
      try {
        screen125 = _$Screen125FromJson(jsonD['screen125']);
      } catch(e) {
        screen125 = _$Screen125FromJson({});
        ret = false;
      }
      try {
        screen126 = _$Screen126FromJson(jsonD['screen126']);
      } catch(e) {
        screen126 = _$Screen126FromJson({});
        ret = false;
      }
      try {
        screen127 = _$Screen127FromJson(jsonD['screen127']);
      } catch(e) {
        screen127 = _$Screen127FromJson({});
        ret = false;
      }
      try {
        screen128 = _$Screen128FromJson(jsonD['screen128']);
      } catch(e) {
        screen128 = _$Screen128FromJson({});
        ret = false;
      }
      try {
        screen129 = _$Screen129FromJson(jsonD['screen129']);
      } catch(e) {
        screen129 = _$Screen129FromJson({});
        ret = false;
      }
      try {
        screen130 = _$Screen130FromJson(jsonD['screen130']);
      } catch(e) {
        screen130 = _$Screen130FromJson({});
        ret = false;
      }
      try {
        screen131 = _$Screen131FromJson(jsonD['screen131']);
      } catch(e) {
        screen131 = _$Screen131FromJson({});
        ret = false;
      }
      try {
        screen132 = _$Screen132FromJson(jsonD['screen132']);
      } catch(e) {
        screen132 = _$Screen132FromJson({});
        ret = false;
      }
      try {
        screen133 = _$Screen133FromJson(jsonD['screen133']);
      } catch(e) {
        screen133 = _$Screen133FromJson({});
        ret = false;
      }
      try {
        screen134 = _$Screen134FromJson(jsonD['screen134']);
      } catch(e) {
        screen134 = _$Screen134FromJson({});
        ret = false;
      }
      try {
        screen135 = _$Screen135FromJson(jsonD['screen135']);
      } catch(e) {
        screen135 = _$Screen135FromJson({});
        ret = false;
      }
      try {
        screen136 = _$Screen136FromJson(jsonD['screen136']);
      } catch(e) {
        screen136 = _$Screen136FromJson({});
        ret = false;
      }
      try {
        screen137 = _$Screen137FromJson(jsonD['screen137']);
      } catch(e) {
        screen137 = _$Screen137FromJson({});
        ret = false;
      }
      try {
        screen138 = _$Screen138FromJson(jsonD['screen138']);
      } catch(e) {
        screen138 = _$Screen138FromJson({});
        ret = false;
      }
      try {
        screen139 = _$Screen139FromJson(jsonD['screen139']);
      } catch(e) {
        screen139 = _$Screen139FromJson({});
        ret = false;
      }
      try {
        screen140 = _$Screen140FromJson(jsonD['screen140']);
      } catch(e) {
        screen140 = _$Screen140FromJson({});
        ret = false;
      }
      try {
        screen141 = _$Screen141FromJson(jsonD['screen141']);
      } catch(e) {
        screen141 = _$Screen141FromJson({});
        ret = false;
      }
      try {
        screen144 = _$Screen144FromJson(jsonD['screen144']);
      } catch(e) {
        screen144 = _$Screen144FromJson({});
        ret = false;
      }
      try {
        screen145 = _$Screen145FromJson(jsonD['screen145']);
      } catch(e) {
        screen145 = _$Screen145FromJson({});
        ret = false;
      }
      try {
        screen146 = _$Screen146FromJson(jsonD['screen146']);
      } catch(e) {
        screen146 = _$Screen146FromJson({});
        ret = false;
      }
      try {
        screen147 = _$Screen147FromJson(jsonD['screen147']);
      } catch(e) {
        screen147 = _$Screen147FromJson({});
        ret = false;
      }
      try {
        screen148 = _$Screen148FromJson(jsonD['screen148']);
      } catch(e) {
        screen148 = _$Screen148FromJson({});
        ret = false;
      }
      try {
        screen149 = _$Screen149FromJson(jsonD['screen149']);
      } catch(e) {
        screen149 = _$Screen149FromJson({});
        ret = false;
      }
      try {
        ActSetUp = _$AActSetUpFromJson(jsonD['ActSetUp']);
      } catch(e) {
        ActSetUp = _$AActSetUpFromJson({});
        ret = false;
      }
      try {
        HiddenSetUp = _$HHiddenSetUpFromJson(jsonD['HiddenSetUp']);
      } catch(e) {
        HiddenSetUp = _$HHiddenSetUpFromJson({});
        ret = false;
      }
      try {
        customer = _$CustomerFromJson(jsonD['customer']);
      } catch(e) {
        customer = _$CustomerFromJson({});
        ret = false;
      }
      try {
        ShopAndGo = _$SShopAndGoFromJson(jsonD['ShopAndGo']);
      } catch(e) {
        ShopAndGo = _$SShopAndGoFromJson({});
        ret = false;
      }
      try {
        PaymentGroup = _$PPaymentGroupFromJson(jsonD['PaymentGroup']);
      } catch(e) {
        PaymentGroup = _$PPaymentGroupFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Common common = _Common(
    item_disp                          : 0,
    logo_typ                           : 0,
    disp_typ                           : 0,
    spdsp_use                          : 0,
    fix_max                            : 0,
    fix_typ                            : 0,
    ptn_max                            : 0,
    ptn_typ                            : 0,
    spe_typ                            : 0,
    chara_typ                          : 0,
    language_typ                       : 0,
    page_max                           : 0,
    typ_max                            : 0,
    pay_typ1                           : 0,
    pay_typ2                           : 0,
    pay_typ3                           : 0,
    pay_typ4                           : 0,
    pay_typ5                           : 0,
    pay_typ6                           : 0,
    pay_typ7                           : 0,
    pay_typ8                           : 0,
    demo_disp_btn                      : 0,
    rcpt_limit_time                    : 0,
    next_rcpt_limit                    : 0,
    auto_susdsp                        : 0,
    susdsp_time                        : 0,
    rfm_receipt                        : 0,
    signp_typ                          : 0,
    select_typ                         : 0,
    select_str_msg                     : 0,
    regbag1_plucd                      : 0,
    regbag2_plucd                      : 0,
    regbag3_plucd                      : 0,
    autocash_operation                 : 0,
    autocash_equaltime                 : 0,
    autocash_overtime                  : 0,
    fip_disp                           : 0,
    crdtcard_gettimer                  : 0,
    charge_plucd1                      : 0,
    charge_plucd2                      : 0,
    charge_plucd3                      : 0,
    charge_plucd4                      : 0,
    charge_plucd5                      : 0,
    charge_plucd6                      : 0,
    crdtcard_warntime                  : 0,
    acx_recalc_btn                     : 0,
    lang_chg_max                       : 0,
    lang_select1                       : 0,
    lang_select2                       : 0,
    lang_select3                       : 0,
    lang_select4                       : 0,
    lang_select5                       : 0,
    lang_select6                       : 0,
    lang_select7                       : 0,
    lang_select8                       : 0,
    autocrdt_operation                 : 0,
    autocrdt_time                      : 0,
    preca_charge_only                  : 0,
    preca_charge_plucd1                : 0,
    preca_charge_plucd2                : 0,
    preca_charge_plucd3                : 0,
    preca_charge_plucd4                : 0,
    preca_charge_plucd5                : 0,
    preca_charge_plucd6                : 0,
    select_dsp_ccin                    : 0,
    cancel_btn_dsp                     : 0,
    clinic_mode                        : 0,
    clinic_receipt                     : 0,
    clinic_greeting                    : 0,
    clinic_greeting_sound              : 0,
    fin_btn_chg                        : 0,
    startdsp_btn_single                : 0,
    startdsp_scan_enable               : 0,
    pay_typ9                           : 0,
    pay_typ10                          : 0,
    pay_typ11                          : 0,
    pay_typ12                          : 0,
    pay_typ13                          : 0,
    pay_typ14                          : 0,
    pay_typ15                          : 0,
    pay_typ16                          : 0,
    verifone_nfc_crdt                  : 0,
    hs_dualdisp_chk                    : 0,
    back_btn_dsp                       : 0,
    NoOperationWarning                 : 0,
    NoOperationSignpaul_time           : 0,
    NoOperationVoicesound_time         : 0,
    NoOperationSound                   : 0,
    NoOperationPayWarning              : 0,
    cin_dsp_wait                       : 0,
    clinic_auto_stl                    : 0,
    acracb_stlmode                     : 0,
    apbf_regbag_plucd                  : 0,
    apbf_dlgdisp_time                  : 0,
    mybag_plu_point_add                : "",
    video_jpqr_scanner                 : 0,
    chg_warn_timer_use                 : 0,
    cin_cnl_btn_show                   : 0,
    regs_use_class                     : 0,
    sg_eatin_chk                       : 0,
    selfmode1_auto_cancel              : 0,
    point_use_unit                     : 0,
    selfmode1_wav_qty                  : 0,
    age_chk_notice                     : 0,
    verifone_nfc_repika_crdt           : 0,
    regbag1_default                    : 0,
    regbag2_default                    : 0,
    regbag3_default                    : 0,
    regbag_timing                      : 0,
    regbag_disp_back_btn               : 0,
    self_disp_preca_ref                : 0,
    fs_cashless_dsp_change             : 0,
    hs_fs_scanning_guide               : 0,
    hs_fs_twice_read_stop              : 0,
    cashin_sound                       : 0,
    sound_change_flg                   : 0,
    hs_fs_auto_preset_dsp              : 0,
    cashless_dsp_return                : 0,
    regbag_screen_scan_input           : 0,
    g3_pay_btn_blink                   : 0,
    g3_employee_call_btn               : 0,
    g3_pay_slct_btn_ptn                : 0,
    video_jpqr_sidescanner             : 0,
    mente_itemlist_type                : 0,
    rg_self_noteplu_perm               : 0,
    g3_self_itemlist_scrvoid           : 0,
    g3_fs_presetgroup_custom           : 0,
    g3_fs_presetgroup_btn1             : 0,
    g3_fs_presetgroup_btn2             : 0,
    g3_fs_presetgroup_btn3             : 0,
    g3_fs_presetgroup_btn4             : 0,
    g3_fs_presetgroup_btn5             : 0,
    g3_fs_presetgroup_btn6             : 0,
    g3_fs_presetgroup_btn7             : 0,
    g3_fs_presetgroup_btn8             : 0,
    callBuzzer_sound_change_flg        : 0,
    top_map_display                    : 0,
    start_payselect_display            : 0,
    idle_signp_state                   : 0,
    jpqr_paybtn_image                  : 0,
    vega_credit_forget_chk             : 0,
    cash_only_setting                  : 0,
    cash_only_border                   : 0,
    cashback_auto_cancel               : 0,
    force_agecheck                     : 0,
    lang_switch_display                : 0,
    self_edy_balance                   : 0,
    select_dsp_scan_ctrl               : 0,
    cashback_call_limit                : 0,
    regbag_clscd                       : 0,
    preca_image_btn                    : 0,
    change_after_receipt               : 0,
    total_amt_voice_ctrl               : 0,
    check_change_signp                 : 0,
    jpqr_paybtn_image2                 : 0,
    fs_bag_set_dsp                     : 0,
    cashless_dsp_show                  : 0,
    arcs_payment_mbr_read              : 0,
  );

  _Chg_info chg_info = _Chg_info(
    chg_info                           : 0,
    chg_5000                           : 0,
    chg_2000                           : 0,
    chg_1000                           : 0,
    chg_500                            : 0,
    chg_100                            : 0,
    chg_50                             : 0,
    chg_10                             : 0,
    chg_5                              : 0,
    chg_1                              : 0,
    chg_info_full_chk                  : 0,
    chg_signp_full_chk                 : 0,
  );

  _Period period = _Period(
    spr_str                            : 0,
    spr_end                            : 0,
    sum_str                            : 0,
    sum_end                            : 0,
    aut_str                            : 0,
    aut_end                            : 0,
    win1_str                           : 0,
    win1_end                           : 0,
    win2_str                           : 0,
    win2_end                           : 0,
    sp1_flg                            : 0,
    sp2_flg                            : 0,
    sp3_flg                            : 0,
    sp4_flg                            : 0,
    sp5_flg                            : 0,
    sp6_flg                            : 0,
    sp7_flg                            : 0,
    sp8_flg                            : 0,
    sp9_flg                            : 0,
    sp10_flg                           : 0,
    sp11_flg                           : 0,
    sp12_flg                           : 0,
    sp13_flg                           : 0,
    sp14_flg                           : 0,
    sp15_flg                           : 0,
    sp16_flg                           : 0,
    sp17_flg                           : 0,
    sp18_flg                           : 0,
    sp1_str                            : 0,
    sp1_end                            : 0,
    sp2_str                            : "",
    sp2_end                            : "",
    sp3_str                            : 0,
    sp3_end                            : 0,
    sp4_str                            : 0,
    sp4_end                            : 0,
    sp5_str                            : "",
    sp5_end                            : "",
    sp6_str                            : 0,
    sp6_end                            : 0,
    sp7_str                            : 0,
    sp7_end                            : 0,
    sp8_str                            : "",
    sp8_end                            : "",
    sp9_str                            : "",
    sp9_end                            : "",
    sp10_str                           : 0,
    sp10_end                           : 0,
    sp11_str                           : "",
    sp11_end                           : "",
    sp12_str                           : 0,
    sp12_end                           : 0,
    sp13_str                           : "",
    sp13_end                           : "",
    sp14_str                           : 0,
    sp14_end                           : 0,
    sp15_str                           : "",
    sp15_end                           : "",
    sp16_str                           : 0,
    sp16_end                           : 0,
    sp17_str                           : 0,
    sp17_end                           : 0,
    sp18_str                           : "",
    sp18_end                           : "",
    spr_time1                          : 0,
    spr_time2                          : 0,
    sum_time1                          : 0,
    sum_time2                          : 0,
    aut_time1                          : 0,
    aut_time2                          : 0,
    win_time1                          : 0,
    win_time2                          : 0,
  );

  _Screen0 screen0 = _Screen0(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen1 screen1 = _Screen1(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen2 screen2 = _Screen2(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen3 screen3 = _Screen3(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen4 screen4 = _Screen4(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen5 screen5 = _Screen5(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : "",
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen6 screen6 = _Screen6(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
    line2_1                            : "",
    line2_2                            : "",
    line2_3                            : "",
    line2_4                            : "",
  );

  _Screen7 screen7 = _Screen7(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen8 screen8 = _Screen8(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen9 screen9 = _Screen9(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen10 screen10 = _Screen10(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen11 screen11 = _Screen11(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen12 screen12 = _Screen12(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen13 screen13 = _Screen13(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen14 screen14 = _Screen14(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen15 screen15 = _Screen15(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen16 screen16 = _Screen16(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : "",
    sound3                             : "",
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : "",
    sound_led3                         : "",
    msg_max                            : 0,
    line2_1                            : "",
    line2_2                            : "",
    line2_3                            : "",
    line2_4                            : "",
    line2_1_ex                         : "",
    line2_2_ex                         : "",
    line2_3_ex                         : "",
    line2_4_ex                         : "",
  );

  _Screen17 screen17 = _Screen17(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen18 screen18 = _Screen18(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen19 screen19 = _Screen19(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : "",
    sound3                             : "",
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : "",
    sound_led3                         : "",
  );

  _Screen20 screen20 = _Screen20(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen21 screen21 = _Screen21(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen22 screen22 = _Screen22(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen23 screen23 = _Screen23(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen24 screen24 = _Screen24(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen25 screen25 = _Screen25(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen26 screen26 = _Screen26(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : "",
    sound3                             : "",
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : "",
    sound_led3                         : "",
  );

  _Screen27 screen27 = _Screen27(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen28 screen28 = _Screen28(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen29 screen29 = _Screen29(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen30 screen30 = _Screen30(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen31 screen31 = _Screen31(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen32 screen32 = _Screen32(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen33 screen33 = _Screen33(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen34 screen34 = _Screen34(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen35 screen35 = _Screen35(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen36 screen36 = _Screen36(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen37 screen37 = _Screen37(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen38 screen38 = _Screen38(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen39 screen39 = _Screen39(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen40 screen40 = _Screen40(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen41 screen41 = _Screen41(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen42 screen42 = _Screen42(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen43 screen43 = _Screen43(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen44 screen44 = _Screen44(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen45 screen45 = _Screen45(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen46 screen46 = _Screen46(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen47 screen47 = _Screen47(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen48 screen48 = _Screen48(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen49 screen49 = _Screen49(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen50 screen50 = _Screen50(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen51 screen51 = _Screen51(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : "",
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : "",
  );

  _Screen52 screen52 = _Screen52(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen53 screen53 = _Screen53(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen54 screen54 = _Screen54(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : "",
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : "",
  );

  _Screen55 screen55 = _Screen55(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen56 screen56 = _Screen56(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen57 screen57 = _Screen57(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : "",
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : "",
  );

  _Screen58 screen58 = _Screen58(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen59 screen59 = _Screen59(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen60 screen60 = _Screen60(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : "",
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : "",
  );

  _Screen61 screen61 = _Screen61(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen62 screen62 = _Screen62(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen63 screen63 = _Screen63(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : "",
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : "",
  );

  _Screen64 screen64 = _Screen64(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen65 screen65 = _Screen65(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen67 screen67 = _Screen67(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen68 screen68 = _Screen68(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen69 screen69 = _Screen69(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen70 screen70 = _Screen70(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen71 screen71 = _Screen71(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen72 screen72 = _Screen72(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen73 screen73 = _Screen73(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen74 screen74 = _Screen74(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen75 screen75 = _Screen75(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen76 screen76 = _Screen76(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen77 screen77 = _Screen77(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen78 screen78 = _Screen78(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen79 screen79 = _Screen79(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen81 screen81 = _Screen81(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen82 screen82 = _Screen82(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen83 screen83 = _Screen83(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen84 screen84 = _Screen84(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen85 screen85 = _Screen85(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen86 screen86 = _Screen86(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen87 screen87 = _Screen87(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen88 screen88 = _Screen88(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen89 screen89 = _Screen89(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen90 screen90 = _Screen90(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen91 screen91 = _Screen91(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen92 screen92 = _Screen92(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen93 screen93 = _Screen93(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen94 screen94 = _Screen94(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen95 screen95 = _Screen95(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen96 screen96 = _Screen96(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen97 screen97 = _Screen97(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen98 screen98 = _Screen98(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen99 screen99 = _Screen99(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen100 screen100 = _Screen100(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen101 screen101 = _Screen101(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen102 screen102 = _Screen102(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen103 screen103 = _Screen103(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen104 screen104 = _Screen104(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen105 screen105 = _Screen105(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen106 screen106 = _Screen106(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen107 screen107 = _Screen107(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen109 screen109 = _Screen109(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen111 screen111 = _Screen111(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen112 screen112 = _Screen112(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen113 screen113 = _Screen113(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen114 screen114 = _Screen114(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen115 screen115 = _Screen115(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen116 screen116 = _Screen116(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen117 screen117 = _Screen117(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen118 screen118 = _Screen118(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen119 screen119 = _Screen119(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen120 screen120 = _Screen120(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen121 screen121 = _Screen121(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen122 screen122 = _Screen122(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen123 screen123 = _Screen123(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen124 screen124 = _Screen124(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : "",
    sound3                             : "",
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : "",
    sound_led3                         : "",
  );

  _Screen125 screen125 = _Screen125(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : "",
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen126 screen126 = _Screen126(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : "",
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen127 screen127 = _Screen127(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen128 screen128 = _Screen128(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen129 screen129 = _Screen129(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen130 screen130 = _Screen130(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : "",
    sound3                             : "",
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : "",
    sound_led3                         : "",
  );

  _Screen131 screen131 = _Screen131(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen132 screen132 = _Screen132(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : "",
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen133 screen133 = _Screen133(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen134 screen134 = _Screen134(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : "",
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen135 screen135 = _Screen135(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen136 screen136 = _Screen136(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen137 screen137 = _Screen137(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen138 screen138 = _Screen138(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen139 screen139 = _Screen139(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen140 screen140 = _Screen140(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen141 screen141 = _Screen141(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen144 screen144 = _Screen144(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen145 screen145 = _Screen145(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen146 screen146 = _Screen146(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen147 screen147 = _Screen147(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen148 screen148 = _Screen148(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _Screen149 screen149 = _Screen149(
    title                              : "",
    msg1                               : "",
    msg2                               : "",
    msg1_size                          : 0,
    msg2_size                          : 0,
    sound1                             : 0,
    sound2                             : 0,
    sound3                             : 0,
    snd_timer                          : 0,
    timer1                             : 0,
    timer2                             : 0,
    timer3                             : 0,
    dsp_flg1                           : 0,
    dsp_flg2                           : 0,
    movie01_ext                        : 0,
    movie02_ext                        : 0,
    movie03_ext                        : 0,
    movie04_ext                        : 0,
    line_title                         : "",
    line_title_ex                      : "",
    line1                              : "",
    line2                              : "",
    line3                              : "",
    line4                              : "",
    line1_ex                           : "",
    line2_ex                           : "",
    line3_ex                           : "",
    line4_ex                           : "",
    sound_led1                         : 0,
    sound_led2                         : 0,
    sound_led3                         : 0,
  );

  _AActSetUp ActSetUp = _AActSetUp(
    ReadAlertTime                      : 0,
    AutoReadInterval                   : 0,
    InterruptPrint                     : 0,
    InterruptPay                       : 0,
    UpdGetFtpTimer                     : 0,
  );

  _HHiddenSetUp HiddenSetUp = _HHiddenSetUp(
    TableReadInterval                  : 0,
  );

  _Customer customer = _Customer(
    cust_card_max                      : 0,
    cust_card_type1                    : 0,
    cust_card_type2                    : 0,
    cust_card_type3                    : 0,
    cust_card_type4                    : 0,
    cust_card_type5                    : 0,
    cust_card_type6                    : 0,
  );

  _SShopAndGo ShopAndGo = _SShopAndGo(
    shop_and_go_nonfile_plucd          : 0,
    shop_and_go_nonscan_plucd          : 0,
    shop_and_go_limit1                 : 0,
    shop_and_go_limit2                 : 0,
    shop_and_go_limit3                 : 0,
    shop_and_go_test_srv_flg           : 0,
    shop_and_go_companycode            : 0,
    shop_and_go_storecode              : 0,
    shop_and_go_mbr_chk_dsp            : 0,
    shop_and_go_server_timeout         : 0,
    shop_and_go_proxy                  : "",
    shop_and_go_proxy_port             : 0,
    shop_and_go_n_money_btn_dsp        : 0,
    shop_and_go_domain                 : "",
    shop_and_go_mbr_card_dsp           : 0,
    shop_and_go_cr50_domain            : "",
    shop_and_go_point_domain           : "",
    shop_and_go_cr50_plucd             : 0,
    shop_and_go_eatin_dsp              : 0,
    shop_and_go_cogca_read_twice       : 0,
    shop_and_go_use_class              : 0,
    shop_and_go_expensive_mark_prn     : 0,
    shop_and_go_regbag_dsp             : 0,
    shop_and_go_use_preset_grp_code    : 0,
    shop_and_go_mente_nonplu_btn_reference : 0,
    shop_and_go_mbr_auto_cncl_time     : 0,
    shop_and_go_rcpt_ttlnmbr_bold      : 0,
    shop_and_go_apl_dl_qr_print        : 0,
    shop_and_go_rcpt_msg_use_no        : 0,
    shop_and_go_apl_dl_qr_print_normal : 0,
    shop_and_go_qr_print_chk_itmcnt_fs : 0,
    shop_and_go_qr_print_chk_itmcnt_ss : 0,
    shop_and_go_thread_timeout         : 0,
  );

  _PPaymentGroup PaymentGroup = _PPaymentGroup(
    pay_grp_name1                      : "",
    pay_grp_name2                      : "",
    pay_grp_name3                      : "",
    pay_grp_name4                      : "",
    pay_grp_name5                      : "",
    pay_grp_name6                      : "",
    pay_grp_name7                      : "",
    pay_grp_name8                      : "",
    pay_grp_name9                      : "",
    pay_typ1_grp                       : 0,
    pay_typ2_grp                       : 0,
    pay_typ3_grp                       : 0,
    pay_typ4_grp                       : 0,
    pay_typ5_grp                       : 0,
    pay_typ6_grp                       : 0,
    pay_typ7_grp                       : 0,
    pay_typ8_grp                       : 0,
    pay_typ9_grp                       : 0,
    pay_typ10_grp                      : 0,
    pay_typ11_grp                      : 0,
    pay_typ12_grp                      : 0,
    pay_typ13_grp                      : 0,
    pay_typ14_grp                      : 0,
    pay_typ15_grp                      : 0,
    pay_typ16_grp                      : 0,
    pay_grp_name1_ex                   : "",
    pay_grp_name2_ex                   : "",
    pay_grp_name3_ex                   : "",
    pay_grp_name4_ex                   : "",
    pay_grp_name5_ex                   : "",
    pay_grp_name6_ex                   : "",
    pay_grp_name7_ex                   : "",
    pay_grp_name8_ex                   : "",
    pay_grp_name9_ex                   : "",
  );
}

@JsonSerializable()
class _Common {
  factory _Common.fromJson(Map<String, dynamic> json) => _$CommonFromJson(json);
  Map<String, dynamic> toJson() => _$CommonToJson(this);

  _Common({
    required this.item_disp,
    required this.logo_typ,
    required this.disp_typ,
    required this.spdsp_use,
    required this.fix_max,
    required this.fix_typ,
    required this.ptn_max,
    required this.ptn_typ,
    required this.spe_typ,
    required this.chara_typ,
    required this.language_typ,
    required this.page_max,
    required this.typ_max,
    required this.pay_typ1,
    required this.pay_typ2,
    required this.pay_typ3,
    required this.pay_typ4,
    required this.pay_typ5,
    required this.pay_typ6,
    required this.pay_typ7,
    required this.pay_typ8,
    required this.demo_disp_btn,
    required this.rcpt_limit_time,
    required this.next_rcpt_limit,
    required this.auto_susdsp,
    required this.susdsp_time,
    required this.rfm_receipt,
    required this.signp_typ,
    required this.select_typ,
    required this.select_str_msg,
    required this.regbag1_plucd,
    required this.regbag2_plucd,
    required this.regbag3_plucd,
    required this.autocash_operation,
    required this.autocash_equaltime,
    required this.autocash_overtime,
    required this.fip_disp,
    required this.crdtcard_gettimer,
    required this.charge_plucd1,
    required this.charge_plucd2,
    required this.charge_plucd3,
    required this.charge_plucd4,
    required this.charge_plucd5,
    required this.charge_plucd6,
    required this.crdtcard_warntime,
    required this.acx_recalc_btn,
    required this.lang_chg_max,
    required this.lang_select1,
    required this.lang_select2,
    required this.lang_select3,
    required this.lang_select4,
    required this.lang_select5,
    required this.lang_select6,
    required this.lang_select7,
    required this.lang_select8,
    required this.autocrdt_operation,
    required this.autocrdt_time,
    required this.preca_charge_only,
    required this.preca_charge_plucd1,
    required this.preca_charge_plucd2,
    required this.preca_charge_plucd3,
    required this.preca_charge_plucd4,
    required this.preca_charge_plucd5,
    required this.preca_charge_plucd6,
    required this.select_dsp_ccin,
    required this.cancel_btn_dsp,
    required this.clinic_mode,
    required this.clinic_receipt,
    required this.clinic_greeting,
    required this.clinic_greeting_sound,
    required this.fin_btn_chg,
    required this.startdsp_btn_single,
    required this.startdsp_scan_enable,
    required this.pay_typ9,
    required this.pay_typ10,
    required this.pay_typ11,
    required this.pay_typ12,
    required this.pay_typ13,
    required this.pay_typ14,
    required this.pay_typ15,
    required this.pay_typ16,
    required this.verifone_nfc_crdt,
    required this.hs_dualdisp_chk,
    required this.back_btn_dsp,
    required this.NoOperationWarning,
    required this.NoOperationSignpaul_time,
    required this.NoOperationVoicesound_time,
    required this.NoOperationSound,
    required this.NoOperationPayWarning,
    required this.cin_dsp_wait,
    required this.clinic_auto_stl,
    required this.acracb_stlmode,
    required this.apbf_regbag_plucd,
    required this.apbf_dlgdisp_time,
    required this.mybag_plu_point_add,
    required this.video_jpqr_scanner,
    required this.chg_warn_timer_use,
    required this.cin_cnl_btn_show,
    required this.regs_use_class,
    required this.sg_eatin_chk,
    required this.selfmode1_auto_cancel,
    required this.point_use_unit,
    required this.selfmode1_wav_qty,
    required this.age_chk_notice,
    required this.verifone_nfc_repika_crdt,
    required this.regbag1_default,
    required this.regbag2_default,
    required this.regbag3_default,
    required this.regbag_timing,
    required this.regbag_disp_back_btn,
    required this.self_disp_preca_ref,
    required this.fs_cashless_dsp_change,
    required this.hs_fs_scanning_guide,
    required this.hs_fs_twice_read_stop,
    required this.cashin_sound,
    required this.sound_change_flg,
    required this.hs_fs_auto_preset_dsp,
    required this.cashless_dsp_return,
    required this.regbag_screen_scan_input,
    required this.g3_pay_btn_blink,
    required this.g3_employee_call_btn,
    required this.g3_pay_slct_btn_ptn,
    required this.video_jpqr_sidescanner,
    required this.mente_itemlist_type,
    required this.rg_self_noteplu_perm,
    required this.g3_self_itemlist_scrvoid,
    required this.g3_fs_presetgroup_custom,
    required this.g3_fs_presetgroup_btn1,
    required this.g3_fs_presetgroup_btn2,
    required this.g3_fs_presetgroup_btn3,
    required this.g3_fs_presetgroup_btn4,
    required this.g3_fs_presetgroup_btn5,
    required this.g3_fs_presetgroup_btn6,
    required this.g3_fs_presetgroup_btn7,
    required this.g3_fs_presetgroup_btn8,
    required this.callBuzzer_sound_change_flg,
    required this.top_map_display,
    required this.start_payselect_display,
    required this.idle_signp_state,
    required this.jpqr_paybtn_image,
    required this.vega_credit_forget_chk,
    required this.cash_only_setting,
    required this.cash_only_border,
    required this.cashback_auto_cancel,
    required this.force_agecheck,
    required this.lang_switch_display,
    required this.self_edy_balance,
    required this.regbag_clscd,
    required this.select_dsp_scan_ctrl,
    required this.cashback_call_limit,
    required this.preca_image_btn,
    required this.change_after_receipt,
    required this.total_amt_voice_ctrl,
    required this.check_change_signp,
    required this.jpqr_paybtn_image2,
    required this.fs_bag_set_dsp,
    required this.cashless_dsp_show,
    required this.arcs_payment_mbr_read,
  });

  @JsonKey(defaultValue: 1)
  int    item_disp;
  @JsonKey(defaultValue: 0)
  int    logo_typ;
  @JsonKey(defaultValue: 1)
  int    disp_typ;
  @JsonKey(defaultValue: 1)
  int    spdsp_use;
  @JsonKey(defaultValue: 10)
  int    fix_max;
  @JsonKey(defaultValue: 1)
  int    fix_typ;
  @JsonKey(defaultValue: 6)
  int    ptn_max;
  @JsonKey(defaultValue: 1)
  int    ptn_typ;
  @JsonKey(defaultValue: 1)
  int    spe_typ;
  @JsonKey(defaultValue: 0)
  int    chara_typ;
  @JsonKey(defaultValue: 0)
  int    language_typ;
  @JsonKey(defaultValue: 145)
  int    page_max;
  @JsonKey(defaultValue: 1)
  int    typ_max;
  @JsonKey(defaultValue: 0)
  int    pay_typ1;
  @JsonKey(defaultValue: 1)
  int    pay_typ2;
  @JsonKey(defaultValue: 0)
  int    pay_typ3;
  @JsonKey(defaultValue: 0)
  int    pay_typ4;
  @JsonKey(defaultValue: 0)
  int    pay_typ5;
  @JsonKey(defaultValue: 0)
  int    pay_typ6;
  @JsonKey(defaultValue: 0)
  int    pay_typ7;
  @JsonKey(defaultValue: 0)
  int    pay_typ8;
  @JsonKey(defaultValue: 0)
  int    demo_disp_btn;
  @JsonKey(defaultValue: 10)
  int    rcpt_limit_time;
  @JsonKey(defaultValue: 60)
  int    next_rcpt_limit;
  @JsonKey(defaultValue: 0)
  int    auto_susdsp;
  @JsonKey(defaultValue: 2200)
  int    susdsp_time;
  @JsonKey(defaultValue: 1)
  int    rfm_receipt;
  @JsonKey(defaultValue: 0)
  int    signp_typ;
  @JsonKey(defaultValue: 0)
  int    select_typ;
  @JsonKey(defaultValue: 0)
  int    select_str_msg;
  @JsonKey(defaultValue: 0)
  int    regbag1_plucd;
  @JsonKey(defaultValue: 0)
  int    regbag2_plucd;
  @JsonKey(defaultValue: 0)
  int    regbag3_plucd;
  @JsonKey(defaultValue: 0)
  int    autocash_operation;
  @JsonKey(defaultValue: 10)
  int    autocash_equaltime;
  @JsonKey(defaultValue: 0)
  int    autocash_overtime;
  @JsonKey(defaultValue: 0)
  int    fip_disp;
  @JsonKey(defaultValue: 0)
  int    crdtcard_gettimer;
  @JsonKey(defaultValue: 0)
  int    charge_plucd1;
  @JsonKey(defaultValue: 0)
  int    charge_plucd2;
  @JsonKey(defaultValue: 0)
  int    charge_plucd3;
  @JsonKey(defaultValue: 0)
  int    charge_plucd4;
  @JsonKey(defaultValue: 0)
  int    charge_plucd5;
  @JsonKey(defaultValue: 0)
  int    charge_plucd6;
  @JsonKey(defaultValue: 6)
  int    crdtcard_warntime;
  @JsonKey(defaultValue: 0)
  int    acx_recalc_btn;
  @JsonKey(defaultValue: 0)
  int    lang_chg_max;
  @JsonKey(defaultValue: 0)
  int    lang_select1;
  @JsonKey(defaultValue: 0)
  int    lang_select2;
  @JsonKey(defaultValue: 0)
  int    lang_select3;
  @JsonKey(defaultValue: 0)
  int    lang_select4;
  @JsonKey(defaultValue: 0)
  int    lang_select5;
  @JsonKey(defaultValue: 0)
  int    lang_select6;
  @JsonKey(defaultValue: 0)
  int    lang_select7;
  @JsonKey(defaultValue: 0)
  int    lang_select8;
  @JsonKey(defaultValue: 0)
  int    autocrdt_operation;
  @JsonKey(defaultValue: 10)
  int    autocrdt_time;
  @JsonKey(defaultValue: 0)
  int    preca_charge_only;
  @JsonKey(defaultValue: 0)
  int    preca_charge_plucd1;
  @JsonKey(defaultValue: 0)
  int    preca_charge_plucd2;
  @JsonKey(defaultValue: 0)
  int    preca_charge_plucd3;
  @JsonKey(defaultValue: 0)
  int    preca_charge_plucd4;
  @JsonKey(defaultValue: 0)
  int    preca_charge_plucd5;
  @JsonKey(defaultValue: 0)
  int    preca_charge_plucd6;
  @JsonKey(defaultValue: 0)
  int    select_dsp_ccin;
  @JsonKey(defaultValue: 0)
  int    cancel_btn_dsp;
  @JsonKey(defaultValue: 0)
  int    clinic_mode;
  @JsonKey(defaultValue: 1)
  int    clinic_receipt;
  @JsonKey(defaultValue: 1)
  int    clinic_greeting;
  @JsonKey(defaultValue: 1)
  int    clinic_greeting_sound;
  @JsonKey(defaultValue: 0)
  int    fin_btn_chg;
  @JsonKey(defaultValue: 1)
  int    startdsp_btn_single;
  @JsonKey(defaultValue: 0)
  int    startdsp_scan_enable;
  @JsonKey(defaultValue: 0)
  int    pay_typ9;
  @JsonKey(defaultValue: 0)
  int    pay_typ10;
  @JsonKey(defaultValue: 0)
  int    pay_typ11;
  @JsonKey(defaultValue: 0)
  int    pay_typ12;
  @JsonKey(defaultValue: 0)
  int    pay_typ13;
  @JsonKey(defaultValue: 0)
  int    pay_typ14;
  @JsonKey(defaultValue: 0)
  int    pay_typ15;
  @JsonKey(defaultValue: 0)
  int    pay_typ16;
  @JsonKey(defaultValue: 0)
  int    verifone_nfc_crdt;
  @JsonKey(defaultValue: 1)
  int    hs_dualdisp_chk;
  @JsonKey(defaultValue: 1)
  int    back_btn_dsp;
  @JsonKey(defaultValue: 0)
  int    NoOperationWarning;
  @JsonKey(defaultValue: 0)
  int    NoOperationSignpaul_time;
  @JsonKey(defaultValue: 0)
  int    NoOperationVoicesound_time;
  @JsonKey(defaultValue: 0)
  int    NoOperationSound;
  @JsonKey(defaultValue: 0)
  int    NoOperationPayWarning;
  @JsonKey(defaultValue: 0)
  int    cin_dsp_wait;
  @JsonKey(defaultValue: 0)
  int    clinic_auto_stl;
  @JsonKey(defaultValue: 1)
  int    acracb_stlmode;
  @JsonKey(defaultValue: 0)
  int    apbf_regbag_plucd;
  @JsonKey(defaultValue: 30)
  int    apbf_dlgdisp_time;
  @JsonKey(defaultValue: "")
  String    mybag_plu_point_add;
  @JsonKey(defaultValue: 0)
  int    video_jpqr_scanner;
  @JsonKey(defaultValue: 0)
  int    chg_warn_timer_use;
  @JsonKey(defaultValue: 0)
  int    cin_cnl_btn_show;
  @JsonKey(defaultValue: 0)
  int    regs_use_class;
  @JsonKey(defaultValue: 0)
  int    sg_eatin_chk;
  @JsonKey(defaultValue: 0)
  int    selfmode1_auto_cancel;
  @JsonKey(defaultValue: 1)
  int    point_use_unit;
  @JsonKey(defaultValue: 0)
  int    selfmode1_wav_qty;
  @JsonKey(defaultValue: 1)
  int    age_chk_notice;
  @JsonKey(defaultValue: 0)
  int    verifone_nfc_repika_crdt;
  @JsonKey(defaultValue: 0)
  int    regbag1_default;
  @JsonKey(defaultValue: 0)
  int    regbag2_default;
  @JsonKey(defaultValue: 0)
  int    regbag3_default;
  @JsonKey(defaultValue: 0)
  int    regbag_timing;
  @JsonKey(defaultValue: 1)
  int    regbag_disp_back_btn;
  @JsonKey(defaultValue: 0)
  int    self_disp_preca_ref;
  @JsonKey(defaultValue: 0)
  int    fs_cashless_dsp_change;
  @JsonKey(defaultValue: 0)
  int    hs_fs_scanning_guide;
  @JsonKey(defaultValue: 0)
  int    hs_fs_twice_read_stop;
  @JsonKey(defaultValue: 0)
  int    cashin_sound;
  @JsonKey(defaultValue: 0)
  int    sound_change_flg;
  @JsonKey(defaultValue: 0)
  int    hs_fs_auto_preset_dsp;
  @JsonKey(defaultValue: 0)
  int    cashless_dsp_return;
  @JsonKey(defaultValue: 0)
  int    regbag_screen_scan_input;
  @JsonKey(defaultValue: 0)
  int    g3_pay_btn_blink;
  @JsonKey(defaultValue: 1)
  int    g3_employee_call_btn;
  @JsonKey(defaultValue: 0)
  int    g3_pay_slct_btn_ptn;
  @JsonKey(defaultValue: 0)
  int    video_jpqr_sidescanner;
  @JsonKey(defaultValue: 0)
  int    mente_itemlist_type;
  @JsonKey(defaultValue: 0)
  int    rg_self_noteplu_perm;
  @JsonKey(defaultValue: 0)
  int    g3_self_itemlist_scrvoid;
  @JsonKey(defaultValue: 0)
  int    g3_fs_presetgroup_custom;
  @JsonKey(defaultValue: 0)
  int    g3_fs_presetgroup_btn1;
  @JsonKey(defaultValue: 0)
  int    g3_fs_presetgroup_btn2;
  @JsonKey(defaultValue: 0)
  int    g3_fs_presetgroup_btn3;
  @JsonKey(defaultValue: 0)
  int    g3_fs_presetgroup_btn4;
  @JsonKey(defaultValue: 0)
  int    g3_fs_presetgroup_btn5;
  @JsonKey(defaultValue: 0)
  int    g3_fs_presetgroup_btn6;
  @JsonKey(defaultValue: 0)
  int    g3_fs_presetgroup_btn7;
  @JsonKey(defaultValue: 0)
  int    g3_fs_presetgroup_btn8;
  @JsonKey(defaultValue: 0)
  int    callBuzzer_sound_change_flg;
  @JsonKey(defaultValue: 0)
  int    top_map_display;
  @JsonKey(defaultValue: 0)
  int    start_payselect_display;
  @JsonKey(defaultValue: 0)
  int    idle_signp_state;
  @JsonKey(defaultValue: 0)
  int    jpqr_paybtn_image;
  @JsonKey(defaultValue: 1)
  int    vega_credit_forget_chk;
  @JsonKey(defaultValue: 0)
  int    cash_only_setting;
  @JsonKey(defaultValue: 0)
  int    cash_only_border;
  @JsonKey(defaultValue: 20)
  int    cashback_auto_cancel;
  @JsonKey(defaultValue: 0)
  int    force_agecheck;
  @JsonKey(defaultValue: 0)
  int    lang_switch_display;
  @JsonKey(defaultValue: 1)
  int    self_edy_balance;
  @JsonKey(defaultValue: 0)
  int    regbag_clscd;
  @JsonKey(defaultValue: 0)
  int    select_dsp_scan_ctrl;
  @JsonKey(defaultValue: 100000)
  int    cashback_call_limit;
  @JsonKey(defaultValue: 0)
  int	   preca_image_btn;
  @JsonKey(defaultValue: 0)
  int	   change_after_receipt;
  @JsonKey(defaultValue: 0)
  int	   total_amt_voice_ctrl;
  @JsonKey(defaultValue: 0)
  int    check_change_signp;
  @JsonKey(defaultValue: 0)
  int	   jpqr_paybtn_image2;
  @JsonKey(defaultValue: 0)
  int	   fs_bag_set_dsp;
  @JsonKey(defaultValue: 0)
  int	   cashless_dsp_show;
  @JsonKey(defaultValue: 0)
  int	   arcs_payment_mbr_read;
}

@JsonSerializable()
class _Chg_info {
  factory _Chg_info.fromJson(Map<String, dynamic> json) => _$Chg_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Chg_infoToJson(this);

  _Chg_info({
    required this.chg_info,
    required this.chg_5000,
    required this.chg_2000,
    required this.chg_1000,
    required this.chg_500,
    required this.chg_100,
    required this.chg_50,
    required this.chg_10,
    required this.chg_5,
    required this.chg_1,
    required this.chg_info_full_chk,
    required this.chg_signp_full_chk,
  });

  @JsonKey(defaultValue: 1)
  int    chg_info;
  @JsonKey(defaultValue: 0)
  int    chg_5000;
  @JsonKey(defaultValue: 0)
  int    chg_2000;
  @JsonKey(defaultValue: 9)
  int    chg_1000;
  @JsonKey(defaultValue: 0)
  int    chg_500;
  @JsonKey(defaultValue: 9)
  int    chg_100;
  @JsonKey(defaultValue: 0)
  int    chg_50;
  @JsonKey(defaultValue: 9)
  int    chg_10;
  @JsonKey(defaultValue: 0)
  int    chg_5;
  @JsonKey(defaultValue: 9)
  int    chg_1;
  @JsonKey(defaultValue: 30)
  int    chg_info_full_chk;
  @JsonKey(defaultValue: 10)
  int    chg_signp_full_chk;
}

@JsonSerializable()
class _Period {
  factory _Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);
  Map<String, dynamic> toJson() => _$PeriodToJson(this);

  _Period({
    required this.spr_str,
    required this.spr_end,
    required this.sum_str,
    required this.sum_end,
    required this.aut_str,
    required this.aut_end,
    required this.win1_str,
    required this.win1_end,
    required this.win2_str,
    required this.win2_end,
    required this.sp1_flg,
    required this.sp2_flg,
    required this.sp3_flg,
    required this.sp4_flg,
    required this.sp5_flg,
    required this.sp6_flg,
    required this.sp7_flg,
    required this.sp8_flg,
    required this.sp9_flg,
    required this.sp10_flg,
    required this.sp11_flg,
    required this.sp12_flg,
    required this.sp13_flg,
    required this.sp14_flg,
    required this.sp15_flg,
    required this.sp16_flg,
    required this.sp17_flg,
    required this.sp18_flg,
    required this.sp1_str,
    required this.sp1_end,
    required this.sp2_str,
    required this.sp2_end,
    required this.sp3_str,
    required this.sp3_end,
    required this.sp4_str,
    required this.sp4_end,
    required this.sp5_str,
    required this.sp5_end,
    required this.sp6_str,
    required this.sp6_end,
    required this.sp7_str,
    required this.sp7_end,
    required this.sp8_str,
    required this.sp8_end,
    required this.sp9_str,
    required this.sp9_end,
    required this.sp10_str,
    required this.sp10_end,
    required this.sp11_str,
    required this.sp11_end,
    required this.sp12_str,
    required this.sp12_end,
    required this.sp13_str,
    required this.sp13_end,
    required this.sp14_str,
    required this.sp14_end,
    required this.sp15_str,
    required this.sp15_end,
    required this.sp16_str,
    required this.sp16_end,
    required this.sp17_str,
    required this.sp17_end,
    required this.sp18_str,
    required this.sp18_end,
    required this.spr_time1,
    required this.spr_time2,
    required this.sum_time1,
    required this.sum_time2,
    required this.aut_time1,
    required this.aut_time2,
    required this.win_time1,
    required this.win_time2,
  });

  @JsonKey(defaultValue: 301)
  int    spr_str;
  @JsonKey(defaultValue: 531)
  int    spr_end;
  @JsonKey(defaultValue: 601)
  int    sum_str;
  @JsonKey(defaultValue: 831)
  int    sum_end;
  @JsonKey(defaultValue: 901)
  int    aut_str;
  @JsonKey(defaultValue: 1130)
  int    aut_end;
  @JsonKey(defaultValue: 1201)
  int    win1_str;
  @JsonKey(defaultValue: 1231)
  int    win1_end;
  @JsonKey(defaultValue: 101)
  int    win2_str;
  @JsonKey(defaultValue: 229)
  int    win2_end;
  @JsonKey(defaultValue: 1)
  int    sp1_flg;
  @JsonKey(defaultValue: 0)
  int    sp2_flg;
  @JsonKey(defaultValue: 1)
  int    sp3_flg;
  @JsonKey(defaultValue: 1)
  int    sp4_flg;
  @JsonKey(defaultValue: 0)
  int    sp5_flg;
  @JsonKey(defaultValue: 1)
  int    sp6_flg;
  @JsonKey(defaultValue: 1)
  int    sp7_flg;
  @JsonKey(defaultValue: 0)
  int    sp8_flg;
  @JsonKey(defaultValue: 0)
  int    sp9_flg;
  @JsonKey(defaultValue: 1)
  int    sp10_flg;
  @JsonKey(defaultValue: 0)
  int    sp11_flg;
  @JsonKey(defaultValue: 1)
  int    sp12_flg;
  @JsonKey(defaultValue: 0)
  int    sp13_flg;
  @JsonKey(defaultValue: 1)
  int    sp14_flg;
  @JsonKey(defaultValue: 0)
  int    sp15_flg;
  @JsonKey(defaultValue: 1)
  int    sp16_flg;
  @JsonKey(defaultValue: 1)
  int    sp17_flg;
  @JsonKey(defaultValue: 0)
  int    sp18_flg;
  @JsonKey(defaultValue: 101)
  int    sp1_str;
  @JsonKey(defaultValue: 107)
  int    sp1_end;
  @JsonKey(defaultValue: "")
  String sp2_str;
  @JsonKey(defaultValue: "")
  String sp2_end;
  @JsonKey(defaultValue: 201)
  int    sp3_str;
  @JsonKey(defaultValue: 214)
  int    sp3_end;
  @JsonKey(defaultValue: 215)
  int    sp4_str;
  @JsonKey(defaultValue: 303)
  int    sp4_end;
  @JsonKey(defaultValue: "")
  String sp5_str;
  @JsonKey(defaultValue: "")
  String sp5_end;
  @JsonKey(defaultValue: 325)
  int    sp6_str;
  @JsonKey(defaultValue: 410)
  int    sp6_end;
  @JsonKey(defaultValue: 425)
  int    sp7_str;
  @JsonKey(defaultValue: 505)
  int    sp7_end;
  @JsonKey(defaultValue: "")
  String sp8_str;
  @JsonKey(defaultValue: "")
  String sp8_end;
  @JsonKey(defaultValue: "")
  String sp9_str;
  @JsonKey(defaultValue: "")
  String sp9_end;
  @JsonKey(defaultValue: 627)
  int    sp10_str;
  @JsonKey(defaultValue: 707)
  int    sp10_end;
  @JsonKey(defaultValue: "")
  String sp11_str;
  @JsonKey(defaultValue: "")
  String sp11_end;
  @JsonKey(defaultValue: 825)
  int    sp12_str;
  @JsonKey(defaultValue: 920)
  int    sp12_end;
  @JsonKey(defaultValue: "")
  String sp13_str;
  @JsonKey(defaultValue: "")
  String sp13_end;
  @JsonKey(defaultValue: 1015)
  int    sp14_str;
  @JsonKey(defaultValue: 1030)
  int    sp14_end;
  @JsonKey(defaultValue: "")
  String sp15_str;
  @JsonKey(defaultValue: "")
  String sp15_end;
  @JsonKey(defaultValue: 1201)
  int    sp16_str;
  @JsonKey(defaultValue: 1225)
  int    sp16_end;
  @JsonKey(defaultValue: 1226)
  int    sp17_str;
  @JsonKey(defaultValue: 1231)
  int    sp17_end;
  @JsonKey(defaultValue: "")
  String sp18_str;
  @JsonKey(defaultValue: "")
  String sp18_end;
  @JsonKey(defaultValue: 600)
  int    spr_time1;
  @JsonKey(defaultValue: 1700)
  int    spr_time2;
  @JsonKey(defaultValue: 600)
  int    sum_time1;
  @JsonKey(defaultValue: 1800)
  int    sum_time2;
  @JsonKey(defaultValue: 600)
  int    aut_time1;
  @JsonKey(defaultValue: 1700)
  int    aut_time2;
  @JsonKey(defaultValue: 600)
  int    win_time1;
  @JsonKey(defaultValue: 1700)
  int    win_time2;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "スタート画面")
  String title;
  @JsonKey(defaultValue: "お会計券を読ませるとスタートします")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 6091)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "お会計券を")
  String line2;
  @JsonKey(defaultValue: "読ませてください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "Insert the ticket")
  String line2_ex;
  @JsonKey(defaultValue: "into the scanner.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 0)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 6091)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "スキャン中画面")
  String title;
  @JsonKey(defaultValue: "お会計券を読ませるとスタートします")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6003)
  int    sound1;
  @JsonKey(defaultValue: 6097)
  int    sound2;
  @JsonKey(defaultValue: 6096)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 2)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 10)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6003)
  int    sound_led1;
  @JsonKey(defaultValue: 6097)
  int    sound_led2;
  @JsonKey(defaultValue: 6096)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "会計選択画面")
  String title;
  @JsonKey(defaultValue: "お支払方法のボタンを押して下さい")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6004)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 60)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 10)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払方法を")
  String line1;
  @JsonKey(defaultValue: "押してください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Please select your")
  String line1_ex;
  @JsonKey(defaultValue: "payment method.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6129)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "現金入金画面")
  String title;
  @JsonKey(defaultValue: "お買上金額を確認し             お金をいれてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6005)
  int    sound1;
  @JsonKey(defaultValue: 6006)
  int    sound2;
  @JsonKey(defaultValue: 6015)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "現金でお支払い")
  String line_title;
  @JsonKey(defaultValue: "Cash Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お金を")
  String line1;
  @JsonKey(defaultValue: "入れてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Please insert the cash.")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6180)
  int    sound_led1;
  @JsonKey(defaultValue: 6130)
  int    sound_led2;
  @JsonKey(defaultValue: 6015)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "現金支払画面")
  String title;
  @JsonKey(defaultValue: "お買上金額を確認し             お金をいれてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6016)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "When ready, ")
  String line1_ex;
  @JsonKey(defaultValue: "press \"finish\"")
  String line2_ex;
  @JsonKey(defaultValue: "to complete payment.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "現金支払完了画面")
  String title;
  @JsonKey(defaultValue: "お釣りとレシートを             お取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6017)
  int    sound1;
  @JsonKey(defaultValue: "")
  String sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 2)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "おつりを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Please take your change.")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6132)
  int    sound_led1;
  @JsonKey(defaultValue: 6132)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
    required this.line2_1,
    required this.line2_2,
    required this.line2_3,
    required this.line2_4,
  });

  @JsonKey(defaultValue: "支払完了(お釣り０円)")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6018)
  int    sound1;
  @JsonKey(defaultValue: 6129)
  int    sound2;
  @JsonKey(defaultValue: 6548)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Thank you.")
  String line1_ex;
  @JsonKey(defaultValue: "Please take your receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 6132)
  int    sound_led2;
  @JsonKey(defaultValue: 6548)
  int    sound_led3;
  @JsonKey(defaultValue: "レシートを")
  String line2_1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2_2;
  @JsonKey(defaultValue: "お大事にして下さい")
  String line2_3;
  @JsonKey(defaultValue: "")
  String line2_4;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "アイテム明細画面")
  String title;
  @JsonKey(defaultValue: "確認が終わりましたら、お会計ボタンを押してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6027)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 1)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6027)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ｸﾚｼﾞｯﾄﾘｰﾄﾞ画面")
  String title;
  @JsonKey(defaultValue: "お買上金額を確認し             クレジットカードを読ませて下さい")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6007)
  int    sound1;
  @JsonKey(defaultValue: 6008)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "クレジットでお支払い")
  String line_title;
  @JsonKey(defaultValue: "Credit Card Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "クレジットカードを")
  String line1;
  @JsonKey(defaultValue: "読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Please swipe")
  String line1_ex;
  @JsonKey(defaultValue: "your credit card.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6007)
  int    sound_led1;
  @JsonKey(defaultValue: 6008)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ｸﾚｼﾞｯﾄ支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6018)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Thank you.")
  String line1_ex;
  @JsonKey(defaultValue: "Please take your receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ありがとうございました画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6025)
  int    sound1;
  @JsonKey(defaultValue: 6098)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 4)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6025)
  int    sound_led1;
  @JsonKey(defaultValue: 6098)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "店員呼び出し選択画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6034)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6034)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "店員呼び出し中画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6035)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 15)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6178)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "パスワード入力")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6036)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6036)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "メンテナンス画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6031)
  int    sound1;
  @JsonKey(defaultValue: 1008)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6031)
  int    sound_led1;
  @JsonKey(defaultValue: 1008)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "商品取消画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 1054)
  int    sound1;
  @JsonKey(defaultValue: 5089)
  int    sound2;
  @JsonKey(defaultValue: 5090)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 1054)
  int    sound_led1;
  @JsonKey(defaultValue: 5089)
  int    sound_led2;
  @JsonKey(defaultValue: 5090)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
    required this.msg_max,
    required this.line2_1,
    required this.line2_2,
    required this.line2_3,
    required this.line2_4,
    required this.line2_1_ex,
    required this.line2_2_ex,
    required this.line2_3_ex,
    required this.line2_4_ex,
  });

  @JsonKey(defaultValue: "クレジットリード完了画面")
  String title;
  @JsonKey(defaultValue: "よろしければ決済ボタンを       押してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6119)
  int    sound1;
  @JsonKey(defaultValue: "")
  String sound2;
  @JsonKey(defaultValue: "")
  String sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "When ready, ")
  String line1_ex;
  @JsonKey(defaultValue: "press \"finish\"")
  String line2_ex;
  @JsonKey(defaultValue: "to complete payment.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: "")
  String sound_led2;
  @JsonKey(defaultValue: "")
  String sound_led3;
  @JsonKey(defaultValue: 1)
  int    msg_max;
  @JsonKey(defaultValue: "クレジット決済できませんでした")
  String line2_1;
  @JsonKey(defaultValue: "会計中止ボタンを押して")
  String line2_2;
  @JsonKey(defaultValue: "再度お会計を行ってください")
  String line2_3;
  @JsonKey(defaultValue: "")
  String line2_4;
  @JsonKey(defaultValue: "Payment failed.")
  String line2_1_ex;
  @JsonKey(defaultValue: "Press \"Swipe again\"")
  String line2_2_ex;
  @JsonKey(defaultValue: "and try it again.")
  String line2_3_ex;
  @JsonKey(defaultValue: "")
  String line2_4_ex;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Edyタッチ画面")
  String title;
  @JsonKey(defaultValue: "お会計金額を確認し             “Ｅｄｙ”をタッチしてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6124)
  int    sound1;
  @JsonKey(defaultValue: 6125)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "Ｅｄｙでお支払い")
  String line_title;
  @JsonKey(defaultValue: "Edy Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お会計金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Please read")
  String line1_ex;
  @JsonKey(defaultValue: "Card on the Reader.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6124)
  int    sound_led1;
  @JsonKey(defaultValue: 6125)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Edy支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6019)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Thank you.")
  String line1_ex;
  @JsonKey(defaultValue: "Please take your receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6019)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Edyタッチ完了画面")
  String title;
  @JsonKey(defaultValue: "レシート発行ボタンを              押してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6126)
  int    sound1;
  @JsonKey(defaultValue: "")
  String sound2;
  @JsonKey(defaultValue: "")
  String sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "When ready, ")
  String line1_ex;
  @JsonKey(defaultValue: "press \"finish\"")
  String line2_ex;
  @JsonKey(defaultValue: "to complete payment.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: "")
  String sound_led2;
  @JsonKey(defaultValue: "")
  String sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "電子マネー確認選択画面")
  String title;
  @JsonKey(defaultValue: "確認する電子マネーを選択してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6028)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6028)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "電子マネー確認Edyタッチ画面")
  String title;
  @JsonKey(defaultValue: "Ｅｄｙをタッチしてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6009)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6009)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "電子マネー確認Edy完了画面")
  String title;
  @JsonKey(defaultValue: "確認が終わりましたら、とじるボタンをおしてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6029)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6029)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "返金画面")
  String title;
  @JsonKey(defaultValue: "お金とレシートを　             お取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6127)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "お金を")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Please take the money.")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6098)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "交通系ICタッチ画面")
  String title;
  @JsonKey(defaultValue: "お会計金額を確認し             “交通系IC”をタッチしてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6153)
  int    sound1;
  @JsonKey(defaultValue: 6070)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "交通系ICでお支払い")
  String line_title;
  @JsonKey(defaultValue: "IC Card Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お会計金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6153)
  int    sound_led1;
  @JsonKey(defaultValue: 6070)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "交通系IC支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6219)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Please take your card")
  String line1_ex;
  @JsonKey(defaultValue: "and the receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "Thank you.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6219)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "交通系ICタッチ完了画面")
  String title;
  @JsonKey(defaultValue: "レシート発行ボタンを              押してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6126)
  int    sound1;
  @JsonKey(defaultValue: "")
  String sound2;
  @JsonKey(defaultValue: "")
  String sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "When ready, ")
  String line1_ex;
  @JsonKey(defaultValue: "press \"finish\"")
  String line2_ex;
  @JsonKey(defaultValue: "to complete payment.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: "")
  String sound_led2;
  @JsonKey(defaultValue: "")
  String sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "電子マネー確認交通系ICタッチ画面")
  String title;
  @JsonKey(defaultValue: "交通系ICをタッチしてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6153)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6153)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "電子マネー確認交通系IC完了画面")
  String title;
  @JsonKey(defaultValue: "確認が終わりましたら、とじるボタンをおしてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6029)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6029)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "レジ袋登録画面")
  String title;
  @JsonKey(defaultValue: "レジ袋登録")
  String msg1;
  @JsonKey(defaultValue: "レジ袋は有料となっております。枚数を入力してください。")
  String msg2;
  @JsonKey(defaultValue: 1)
  int    msg1_size;
  @JsonKey(defaultValue: 1)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 0)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "おつりチャージ画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6183)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6183)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "現金チャージ選択画面")
  String title;
  @JsonKey(defaultValue: "チャージ金額を選択してください")
  String msg1;
  @JsonKey(defaultValue: "Select the amount you want to add to your card.")
  String msg2;
  @JsonKey(defaultValue: 30)
  int    msg1_size;
  @JsonKey(defaultValue: 47)
  int    msg2_size;
  @JsonKey(defaultValue: 6198)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6198)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ｎｉｍｏｃａカード確認画面")
  String title;
  @JsonKey(defaultValue: "★ｎｉｍｏｃａカード、または")
  String msg1;
  @JsonKey(defaultValue: "クレジットｎｉｍｏｃａカードはお持ちですか？")
  String msg2;
  @JsonKey(defaultValue: 28)
  int    msg1_size;
  @JsonKey(defaultValue: 44)
  int    msg2_size;
  @JsonKey(defaultValue: 6214)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6214)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "交通系ICチャージ画面")
  String title;
  @JsonKey(defaultValue: "チャージ金額を確認しお金をいれてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6005)
  int    sound1;
  @JsonKey(defaultValue: 6006)
  int    sound2;
  @JsonKey(defaultValue: 6015)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "交通系ICチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "お金を")
  String line1;
  @JsonKey(defaultValue: "入れてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Insert the payment.")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6216)
  int    sound_led1;
  @JsonKey(defaultValue: 6216)
  int    sound_led2;
  @JsonKey(defaultValue: 6015)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "交通系ICチャージタッチ画面")
  String title;
  @JsonKey(defaultValue: "チャージ金額を確認し“交通系IC”をタッチしてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6153)
  int    sound1;
  @JsonKey(defaultValue: 6070)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "交通系ICチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "チャージ金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6153)
  int    sound_led1;
  @JsonKey(defaultValue: 6070)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "チャージする、しない確認画面")
  String title;
  @JsonKey(defaultValue: "残額が不足しています。チャージしますか？")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 42)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6218)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6218)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "残額不足！！現金併用する？しない？確認画面")
  String title;
  @JsonKey(defaultValue: "残額が不足している為、支払いが完了出来ません")
  String msg1;
  @JsonKey(defaultValue: "不足額を現金でお支払いください")
  String msg2;
  @JsonKey(defaultValue: 44)
  int    msg1_size;
  @JsonKey(defaultValue: 30)
  int    msg2_size;
  @JsonKey(defaultValue: 6224)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6224)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "領収書？レシート？発行確認画面")
  String title;
  @JsonKey(defaultValue: "どちらか一方のボタンを選択してください")
  String msg1;
  @JsonKey(defaultValue: "Please touch either of the buttons.")
  String msg2;
  @JsonKey(defaultValue: 38)
  int    msg1_size;
  @JsonKey(defaultValue: 35)
  int    msg2_size;
  @JsonKey(defaultValue: 6225)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6225)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "交通系ICチャージ入金完了画面")
  String title;
  @JsonKey(defaultValue: "よろしければチャージボタンを押してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6217)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "交通系ICチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "チャージボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to reload")
  String line2_ex;
  @JsonKey(defaultValue: "your card.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "未精算支払画面")
  String title;
  @JsonKey(defaultValue: "よろしければ未精算支払へを押してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6226)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "未精算支払へを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the")
  String line1_ex;
  @JsonKey(defaultValue: "\"Pay remaining balance\"")
  String line2_ex;
  @JsonKey(defaultValue: "button.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6226)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ポイント機能なしカード通知画面")
  String title;
  @JsonKey(defaultValue: "ポイント機能なしカードです")
  String msg1;
  @JsonKey(defaultValue: "You cannot use this card to earn points.")
  String msg2;
  @JsonKey(defaultValue: 26)
  int    msg1_size;
  @JsonKey(defaultValue: 40)
  int    msg2_size;
  @JsonKey(defaultValue: 6632)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6632)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "チケットお取り下さい画面")
  String title;
  @JsonKey(defaultValue: "チケットをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6228)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "チケットとレシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Thank you.")
  String line1_ex;
  @JsonKey(defaultValue: "Please take your receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6228)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "クレジット利用画面<verifone>")
  String title;
  @JsonKey(defaultValue: "クレジットでお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6007)
  int    sound1;
  @JsonKey(defaultValue: 6008)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "クレジットでお支払い")
  String line_title;
  @JsonKey(defaultValue: "Credit Card Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードを読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Please swipe")
  String line1_ex;
  @JsonKey(defaultValue: "your credit card.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6007)
  int    sound_led1;
  @JsonKey(defaultValue: 6008)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
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
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Edy利用画面<verifone>")
  String title;
  @JsonKey(defaultValue: "Edyでお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6124)
  int    sound1;
  @JsonKey(defaultValue: 6125)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "Ｅｄｙでお支払い")
  String line_title;
  @JsonKey(defaultValue: "Edy Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6124)
  int    sound_led1;
  @JsonKey(defaultValue: 6125)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen44 {
  factory _Screen44.fromJson(Map<String, dynamic> json) => _$Screen44FromJson(json);
  Map<String, dynamic> toJson() => _$Screen44ToJson(this);

  _Screen44({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "iD利用画面<verifone>")
  String title;
  @JsonKey(defaultValue: "iDでお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6124)
  int    sound1;
  @JsonKey(defaultValue: 6255)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ｉＤでお支払い")
  String line_title;
  @JsonKey(defaultValue: "iD Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6124)
  int    sound_led1;
  @JsonKey(defaultValue: 6255)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen45 {
  factory _Screen45.fromJson(Map<String, dynamic> json) => _$Screen45FromJson(json);
  Map<String, dynamic> toJson() => _$Screen45ToJson(this);

  _Screen45({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "交通系IC利用画面<verifone>")
  String title;
  @JsonKey(defaultValue: "交通系ICでお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6124)
  int    sound1;
  @JsonKey(defaultValue: 6153)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "交通系ＩＣでお支払い")
  String line_title;
  @JsonKey(defaultValue: "IC Card Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6124)
  int    sound_led1;
  @JsonKey(defaultValue: 6153)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen46 {
  factory _Screen46.fromJson(Map<String, dynamic> json) => _$Screen46FromJson(json);
  Map<String, dynamic> toJson() => _$Screen46ToJson(this);

  _Screen46({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "QUICPay利用画面<verifone>")
  String title;
  @JsonKey(defaultValue: "QUICPayでお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6124)
  int    sound1;
  @JsonKey(defaultValue: 6254)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ＱＵＩＣＰａｙでお支払い")
  String line_title;
  @JsonKey(defaultValue: "QUICPay Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6124)
  int    sound_led1;
  @JsonKey(defaultValue: 6254)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen47 {
  factory _Screen47.fromJson(Map<String, dynamic> json) => _$Screen47FromJson(json);
  Map<String, dynamic> toJson() => _$Screen47ToJson(this);

  _Screen47({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "WAON利用画面<verifone>")
  String title;
  @JsonKey(defaultValue: "WAONでお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6124)
  int    sound1;
  @JsonKey(defaultValue: 6256)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ＷＡＯＮでお支払い")
  String line_title;
  @JsonKey(defaultValue: "WAON Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6124)
  int    sound_led1;
  @JsonKey(defaultValue: 6256)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen48 {
  factory _Screen48.fromJson(Map<String, dynamic> json) => _$Screen48FromJson(json);
  Map<String, dynamic> toJson() => _$Screen48ToJson(this);

  _Screen48({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "nanaco利用画面<verifone>")
  String title;
  @JsonKey(defaultValue: "nanacoでお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6124)
  int    sound1;
  @JsonKey(defaultValue: 6257)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ｎａｎａｃｏでお支払い")
  String line_title;
  @JsonKey(defaultValue: "nanaco Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6124)
  int    sound_led1;
  @JsonKey(defaultValue: 6257)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen49 {
  factory _Screen49.fromJson(Map<String, dynamic> json) => _$Screen49FromJson(json);
  Map<String, dynamic> toJson() => _$Screen49ToJson(this);

  _Screen49({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "銀聯利用画面<verifone>")
  String title;
  @JsonKey(defaultValue: "銀聯でお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6258)
  int    sound1;
  @JsonKey(defaultValue: 6252)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "銀聯でお支払い")
  String line_title;
  @JsonKey(defaultValue: "UnionPay Card Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードを読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Please swipe")
  String line1_ex;
  @JsonKey(defaultValue: "your unionpay card.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6258)
  int    sound_led1;
  @JsonKey(defaultValue: 6252)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen50 {
  factory _Screen50.fromJson(Map<String, dynamic> json) => _$Screen50FromJson(json);
  Map<String, dynamic> toJson() => _$Screen50ToJson(this);

  _Screen50({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "プリカ利用画面<verifone>")
  String title;
  @JsonKey(defaultValue: "プリペイドカードでお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6258)
  int    sound1;
  @JsonKey(defaultValue: 6253)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "プリカでお支払い")
  String line_title;
  @JsonKey(defaultValue: "Prepaid Card Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードを読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Please swipe")
  String line1_ex;
  @JsonKey(defaultValue: "your prepaid card.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6258)
  int    sound_led1;
  @JsonKey(defaultValue: 6253)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen51 {
  factory _Screen51.fromJson(Map<String, dynamic> json) => _$Screen51FromJson(json);
  Map<String, dynamic> toJson() => _$Screen51ToJson(this);

  _Screen51({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Edy入金画面<verifone>")
  String title;
  @JsonKey(defaultValue: "チャージ金額を確認しお金をいれてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6216)
  int    sound1;
  @JsonKey(defaultValue: 6216)
  int    sound2;
  @JsonKey(defaultValue: "")
  String sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "Ｅｄｙチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "お金を")
  String line1;
  @JsonKey(defaultValue: "入れてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Insert the payment.")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6216)
  int    sound_led1;
  @JsonKey(defaultValue: 6216)
  int    sound_led2;
  @JsonKey(defaultValue: "")
  String sound_led3;
}

@JsonSerializable()
class _Screen52 {
  factory _Screen52.fromJson(Map<String, dynamic> json) => _$Screen52FromJson(json);
  Map<String, dynamic> toJson() => _$Screen52ToJson(this);

  _Screen52({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Edyチャージ画面<verifone>")
  String title;
  @JsonKey(defaultValue: "“Edy”をタッチしてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6009)
  int    sound1;
  @JsonKey(defaultValue: 6009)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "Ｅｄｙチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "チャージ金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6009)
  int    sound_led1;
  @JsonKey(defaultValue: 6009)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen53 {
  factory _Screen53.fromJson(Map<String, dynamic> json) => _$Screen53FromJson(json);
  Map<String, dynamic> toJson() => _$Screen53ToJson(this);

  _Screen53({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Edy入金終了画面<verifone>")
  String title;
  @JsonKey(defaultValue: "よろしければチャージボタンを押してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6217)
  int    sound1;
  @JsonKey(defaultValue: 6217)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "Ｅｄｙチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "チャージボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to reload")
  String line2_ex;
  @JsonKey(defaultValue: "your card.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6217)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen54 {
  factory _Screen54.fromJson(Map<String, dynamic> json) => _$Screen54FromJson(json);
  Map<String, dynamic> toJson() => _$Screen54ToJson(this);

  _Screen54({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "交通系IC入金画面<verifone>")
  String title;
  @JsonKey(defaultValue: "チャージ金額を確認しお金をいれてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6216)
  int    sound1;
  @JsonKey(defaultValue: 6216)
  int    sound2;
  @JsonKey(defaultValue: "")
  String sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "交通系ＩＣチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "お金を")
  String line1;
  @JsonKey(defaultValue: "入れてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Insert the payment.")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6216)
  int    sound_led1;
  @JsonKey(defaultValue: 6216)
  int    sound_led2;
  @JsonKey(defaultValue: "")
  String sound_led3;
}

@JsonSerializable()
class _Screen55 {
  factory _Screen55.fromJson(Map<String, dynamic> json) => _$Screen55FromJson(json);
  Map<String, dynamic> toJson() => _$Screen55ToJson(this);

  _Screen55({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "交通系ICチャージ画面<verifone>")
  String title;
  @JsonKey(defaultValue: "“交通系IC”をタッチしてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6009)
  int    sound1;
  @JsonKey(defaultValue: 6009)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "交通系ＩＣチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "チャージ金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6009)
  int    sound_led1;
  @JsonKey(defaultValue: 6009)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen56 {
  factory _Screen56.fromJson(Map<String, dynamic> json) => _$Screen56FromJson(json);
  Map<String, dynamic> toJson() => _$Screen56ToJson(this);

  _Screen56({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "交通系IC入金終了画面<verifone>")
  String title;
  @JsonKey(defaultValue: "よろしければチャージボタンを押してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6217)
  int    sound1;
  @JsonKey(defaultValue: 6217)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "交通系ＩＣチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "チャージボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to reload")
  String line2_ex;
  @JsonKey(defaultValue: "your card.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6217)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen57 {
  factory _Screen57.fromJson(Map<String, dynamic> json) => _$Screen57FromJson(json);
  Map<String, dynamic> toJson() => _$Screen57ToJson(this);

  _Screen57({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "WAON入金画面<verifone>")
  String title;
  @JsonKey(defaultValue: "チャージ金額を確認しお金をいれてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6216)
  int    sound1;
  @JsonKey(defaultValue: 6216)
  int    sound2;
  @JsonKey(defaultValue: "")
  String sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ＷＡＯＮチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "お金を")
  String line1;
  @JsonKey(defaultValue: "入れてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Insert the payment.")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6216)
  int    sound_led1;
  @JsonKey(defaultValue: 6216)
  int    sound_led2;
  @JsonKey(defaultValue: "")
  String sound_led3;
}

@JsonSerializable()
class _Screen58 {
  factory _Screen58.fromJson(Map<String, dynamic> json) => _$Screen58FromJson(json);
  Map<String, dynamic> toJson() => _$Screen58ToJson(this);

  _Screen58({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "WAONチャージ画面<verifone>")
  String title;
  @JsonKey(defaultValue: "“WAON”をタッチしてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6009)
  int    sound1;
  @JsonKey(defaultValue: 6009)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ＷＡＯＮチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "チャージ金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6009)
  int    sound_led1;
  @JsonKey(defaultValue: 6009)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen59 {
  factory _Screen59.fromJson(Map<String, dynamic> json) => _$Screen59FromJson(json);
  Map<String, dynamic> toJson() => _$Screen59ToJson(this);

  _Screen59({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "WAON入金終了画面<verifone>")
  String title;
  @JsonKey(defaultValue: "よろしければチャージボタンを押してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6217)
  int    sound1;
  @JsonKey(defaultValue: 6217)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ＷＡＯＮチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "チャージボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to reload")
  String line2_ex;
  @JsonKey(defaultValue: "your card.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6217)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen60 {
  factory _Screen60.fromJson(Map<String, dynamic> json) => _$Screen60FromJson(json);
  Map<String, dynamic> toJson() => _$Screen60ToJson(this);

  _Screen60({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "nanaco入金画面<verifone>")
  String title;
  @JsonKey(defaultValue: "チャージ金額を確認しお金をいれてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6216)
  int    sound1;
  @JsonKey(defaultValue: 6216)
  int    sound2;
  @JsonKey(defaultValue: "")
  String sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ｎａｎａｃｏチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "お金を")
  String line1;
  @JsonKey(defaultValue: "入れてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Insert the payment.")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6216)
  int    sound_led1;
  @JsonKey(defaultValue: 6216)
  int    sound_led2;
  @JsonKey(defaultValue: "")
  String sound_led3;
}

@JsonSerializable()
class _Screen61 {
  factory _Screen61.fromJson(Map<String, dynamic> json) => _$Screen61FromJson(json);
  Map<String, dynamic> toJson() => _$Screen61ToJson(this);

  _Screen61({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "nanacoチャージ画面<verifone>")
  String title;
  @JsonKey(defaultValue: "“nanaco”をタッチしてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6009)
  int    sound1;
  @JsonKey(defaultValue: 6009)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ｎａｎａｃｏチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "チャージ金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6009)
  int    sound_led1;
  @JsonKey(defaultValue: 6009)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen62 {
  factory _Screen62.fromJson(Map<String, dynamic> json) => _$Screen62FromJson(json);
  Map<String, dynamic> toJson() => _$Screen62ToJson(this);

  _Screen62({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "nanaco入金終了画面<verifone>")
  String title;
  @JsonKey(defaultValue: "よろしければチャージボタンを押してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6217)
  int    sound1;
  @JsonKey(defaultValue: 6217)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ｎａｎａｃｏチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "チャージボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to reload")
  String line2_ex;
  @JsonKey(defaultValue: "your card.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6217)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen63 {
  factory _Screen63.fromJson(Map<String, dynamic> json) => _$Screen63FromJson(json);
  Map<String, dynamic> toJson() => _$Screen63ToJson(this);

  _Screen63({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "プリカ入金画面<verifone>")
  String title;
  @JsonKey(defaultValue: "チャージ金額を確認しお金をいれてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6216)
  int    sound1;
  @JsonKey(defaultValue: 6216)
  int    sound2;
  @JsonKey(defaultValue: "")
  String sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "プリカチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "お金を")
  String line1;
  @JsonKey(defaultValue: "入れてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Insert the payment.")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6216)
  int    sound_led1;
  @JsonKey(defaultValue: 6216)
  int    sound_led2;
  @JsonKey(defaultValue: "")
  String sound_led3;
}

@JsonSerializable()
class _Screen64 {
  factory _Screen64.fromJson(Map<String, dynamic> json) => _$Screen64FromJson(json);
  Map<String, dynamic> toJson() => _$Screen64ToJson(this);

  _Screen64({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "プリカチャージ画面<verifone>")
  String title;
  @JsonKey(defaultValue: "“プリペイドカード”を読ませてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6258)
  int    sound1;
  @JsonKey(defaultValue: 6258)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "プリカチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "チャージ金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードを読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Please swipe")
  String line1_ex;
  @JsonKey(defaultValue: "your prepaid card.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6258)
  int    sound_led1;
  @JsonKey(defaultValue: 6258)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen65 {
  factory _Screen65.fromJson(Map<String, dynamic> json) => _$Screen65FromJson(json);
  Map<String, dynamic> toJson() => _$Screen65ToJson(this);

  _Screen65({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "プリカ入金終了画面<verifone>")
  String title;
  @JsonKey(defaultValue: "よろしければチャージボタンを押してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6217)
  int    sound1;
  @JsonKey(defaultValue: 6217)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "プリカチャージ")
  String line_title;
  @JsonKey(defaultValue: "Reload Card")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "チャージボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to reload")
  String line2_ex;
  @JsonKey(defaultValue: "your card.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6217)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen67 {
  factory _Screen67.fromJson(Map<String, dynamic> json) => _$Screen67FromJson(json);
  Map<String, dynamic> toJson() => _$Screen67ToJson(this);

  _Screen67({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "店員操作中画面<対面>")
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
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "店員操作中です")
  String line1;
  @JsonKey(defaultValue: "お待ちください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 0)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen68 {
  factory _Screen68.fromJson(Map<String, dynamic> json) => _$Screen68FromJson(json);
  Map<String, dynamic> toJson() => _$Screen68ToJson(this);

  _Screen68({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "プリカチャージ入金完了画面")
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
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "チャージボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen69 {
  factory _Screen69.fromJson(Map<String, dynamic> json) => _$Screen69FromJson(json);
  Map<String, dynamic> toJson() => _$Screen69ToJson(this);

  _Screen69({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "チャージ完了画面<印字なし>")
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
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "チャージしました")
  String line1;
  @JsonKey(defaultValue: "お支払いを続けて")
  String line2;
  @JsonKey(defaultValue: "ください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 0)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen70 {
  factory _Screen70.fromJson(Map<String, dynamic> json) => _$Screen70FromJson(json);
  Map<String, dynamic> toJson() => _$Screen70ToJson(this);

  _Screen70({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "あいさつ画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6547)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6547)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen71 {
  factory _Screen71.fromJson(Map<String, dynamic> json) => _$Screen71FromJson(json);
  Map<String, dynamic> toJson() => _$Screen71ToJson(this);

  _Screen71({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "会員カード選択画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6547)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6547)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen72 {
  factory _Screen72.fromJson(Map<String, dynamic> json) => _$Screen72FromJson(json);
  Map<String, dynamic> toJson() => _$Screen72ToJson(this);

  _Screen72({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "会員リード画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6143)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6143)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen73 {
  factory _Screen73.fromJson(Map<String, dynamic> json) => _$Screen73FromJson(json);
  Map<String, dynamic> toJson() => _$Screen73ToJson(this);

  _Screen73({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "dポイント支払画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6534)
  int    sound1;
  @JsonKey(defaultValue: 6534)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "ポイント数を入力して")
  String line1;
  @JsonKey(defaultValue: "決定を押してください")
  String line2;
  @JsonKey(defaultValue: "訂正する場合はクリア")
  String line3;
  @JsonKey(defaultValue: "ボタンを押してください")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6534)
  int    sound_led1;
  @JsonKey(defaultValue: 6534)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen74 {
  factory _Screen74.fromJson(Map<String, dynamic> json) => _$Screen74FromJson(json);
  Map<String, dynamic> toJson() => _$Screen74ToJson(this);

  _Screen74({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "dﾎﾟｲﾝﾄ支払確認画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6179)
  int    sound1;
  @JsonKey(defaultValue: 6179)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to complete")
  String line2_ex;
  @JsonKey(defaultValue: "the payment.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: 6179)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen75 {
  factory _Screen75.fromJson(Map<String, dynamic> json) => _$Screen75FromJson(json);
  Map<String, dynamic> toJson() => _$Screen75ToJson(this);

  _Screen75({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "dﾎﾟｲﾝﾄ支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6133)
  int    sound1;
  @JsonKey(defaultValue: 6133)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Thank you.")
  String line1_ex;
  @JsonKey(defaultValue: "Please take your receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 6133)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen76 {
  factory _Screen76.fromJson(Map<String, dynamic> json) => _$Screen76FromJson(json);
  Map<String, dynamic> toJson() => _$Screen76ToJson(this);

  _Screen76({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "LINE Pay読取画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "LINE Payでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "バーコードを読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6273)
  int    sound_led1;
  @JsonKey(defaultValue: 6273)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen77 {
  factory _Screen77.fromJson(Map<String, dynamic> json) => _$Screen77FromJson(json);
  Map<String, dynamic> toJson() => _$Screen77ToJson(this);

  _Screen77({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Alipay読取画面")
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
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "Alipayでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "QRコードを読み込んでください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6272)
  int    sound_led1;
  @JsonKey(defaultValue: 6272)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen78 {
  factory _Screen78.fromJson(Map<String, dynamic> json) => _$Screen78FromJson(json);
  Map<String, dynamic> toJson() => _$Screen78ToJson(this);

  _Screen78({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "バーコード決済支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 6133)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen79 {
  factory _Screen79.fromJson(Map<String, dynamic> json) => _$Screen79FromJson(json);
  Map<String, dynamic> toJson() => _$Screen79ToJson(this);

  _Screen79({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "バーコード決済残高不足画面")
  String title;
  @JsonKey(defaultValue: "残高が不足しています")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6280)
  int    sound_led1;
  @JsonKey(defaultValue: 6280)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen81 {
  factory _Screen81.fromJson(Map<String, dynamic> json) => _$Screen81FromJson(json);
  Map<String, dynamic> toJson() => _$Screen81ToJson(this);

  _Screen81({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Alipay読取画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "Alipayでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "バーコードを読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6273)
  int    sound_led1;
  @JsonKey(defaultValue: 6273)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen82 {
  factory _Screen82.fromJson(Map<String, dynamic> json) => _$Screen82FromJson(json);
  Map<String, dynamic> toJson() => _$Screen82ToJson(this);

  _Screen82({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "WeChatPay読取画面")
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
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "WeChatPayでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "QRコードを読み込んでください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6272)
  int    sound_led1;
  @JsonKey(defaultValue: 6272)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen83 {
  factory _Screen83.fromJson(Map<String, dynamic> json) => _$Screen83FromJson(json);
  Map<String, dynamic> toJson() => _$Screen83ToJson(this);

  _Screen83({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "WeChatPay読取画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "WeChatPayでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "バーコードを読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6273)
  int    sound_led1;
  @JsonKey(defaultValue: 6273)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen84 {
  factory _Screen84.fromJson(Map<String, dynamic> json) => _$Screen84FromJson(json);
  Map<String, dynamic> toJson() => _$Screen84ToJson(this);

  _Screen84({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "JPQR PAY 読取画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "JPQRでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "バーコードを読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6273)
  int    sound_led1;
  @JsonKey(defaultValue: 6273)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen85 {
  factory _Screen85.fromJson(Map<String, dynamic> json) => _$Screen85FromJson(json);
  Map<String, dynamic> toJson() => _$Screen85ToJson(this);

  _Screen85({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "コード決済 読取画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "コード決済でお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "バーコードを読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6273)
  int    sound_led1;
  @JsonKey(defaultValue: 6273)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen86 {
  factory _Screen86.fromJson(Map<String, dynamic> json) => _$Screen86FromJson(json);
  Map<String, dynamic> toJson() => _$Screen86ToJson(this);

  _Screen86({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "イートインアイテム画面")
  String title;
  @JsonKey(defaultValue: "店内でご飲食される商品はありますか？")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6715)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen87 {
  factory _Screen87.fromJson(Map<String, dynamic> json) => _$Screen87FromJson(json);
  Map<String, dynamic> toJson() => _$Screen87ToJson(this);

  _Screen87({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾌﾟﾘﾍﾟｲﾄﾞｶｰﾄﾞ読取画面<IC>")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 20)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "CoGCaでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "CoGCaカードを")
  String line1;
  @JsonKey(defaultValue: "タッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6283)
  int    sound_led1;
  @JsonKey(defaultValue: 6283)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen88 {
  factory _Screen88.fromJson(Map<String, dynamic> json) => _$Screen88FromJson(json);
  Map<String, dynamic> toJson() => _$Screen88ToJson(this);

  _Screen88({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾌﾟﾘﾍﾟｲﾄﾞ支払画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6179)
  int    sound1;
  @JsonKey(defaultValue: 6179)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: 6179)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen89 {
  factory _Screen89.fromJson(Map<String, dynamic> json) => _$Screen89FromJson(json);
  Map<String, dynamic> toJson() => _$Screen89ToJson(this);

  _Screen89({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾌﾟﾘﾍﾟｲﾄﾞ支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6133)
  int    sound1;
  @JsonKey(defaultValue: 6133)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 6133)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen90 {
  factory _Screen90.fromJson(Map<String, dynamic> json) => _$Screen90FromJson(json);
  Map<String, dynamic> toJson() => _$Screen90ToJson(this);

  _Screen90({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾌﾟﾘﾍﾟｲﾄﾞ置数支払画面")
  String title;
  @JsonKey(defaultValue: "お支払金額を入力してください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6285)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen91 {
  factory _Screen91.fromJson(Map<String, dynamic> json) => _$Screen91FromJson(json);
  Map<String, dynamic> toJson() => _$Screen91ToJson(this);

  _Screen91({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾌﾟﾘﾍﾟｲﾄﾞ残高不足確認画面")
  String title;
  @JsonKey(defaultValue: "残高が不足しています")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6284)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen92 {
  factory _Screen92.fromJson(Map<String, dynamic> json) => _$Screen92FromJson(json);
  Map<String, dynamic> toJson() => _$Screen92ToJson(this);

  _Screen92({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾎﾟｲﾝﾄ支払画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6534)
  int    sound1;
  @JsonKey(defaultValue: 6534)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "ポイント数を入力して")
  String line1;
  @JsonKey(defaultValue: "決定を押してください")
  String line2;
  @JsonKey(defaultValue: "訂正する場合はクリア")
  String line3;
  @JsonKey(defaultValue: "ボタンを押してください")
  String line4;
  @JsonKey(defaultValue: "ポイント利用単位：")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6534)
  int    sound_led1;
  @JsonKey(defaultValue: 6534)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen93 {
  factory _Screen93.fromJson(Map<String, dynamic> json) => _$Screen93FromJson(json);
  Map<String, dynamic> toJson() => _$Screen93ToJson(this);

  _Screen93({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾎﾟｲﾝﾄ支払確認画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6016)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to complete")
  String line2_ex;
  @JsonKey(defaultValue: "the payment.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen94 {
  factory _Screen94.fromJson(Map<String, dynamic> json) => _$Screen94FromJson(json);
  Map<String, dynamic> toJson() => _$Screen94ToJson(this);

  _Screen94({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾎﾟｲﾝﾄ支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6018)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Thank you.")
  String line1_ex;
  @JsonKey(defaultValue: "Please take your receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen95 {
  factory _Screen95.fromJson(Map<String, dynamic> json) => _$Screen95FromJson(json);
  Map<String, dynamic> toJson() => _$Screen95ToJson(this);

  _Screen95({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾌﾟﾘｶﾎﾟｲﾝﾄ支払画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6534)
  int    sound1;
  @JsonKey(defaultValue: 6534)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "ポイント数を入力して")
  String line1;
  @JsonKey(defaultValue: "決定を押してください")
  String line2;
  @JsonKey(defaultValue: "訂正する場合はクリア")
  String line3;
  @JsonKey(defaultValue: "ボタンを押してください")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6534)
  int    sound_led1;
  @JsonKey(defaultValue: 6534)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen96 {
  factory _Screen96.fromJson(Map<String, dynamic> json) => _$Screen96FromJson(json);
  Map<String, dynamic> toJson() => _$Screen96ToJson(this);

  _Screen96({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾌﾟﾘｶﾎﾟｲﾝﾄ支払確認画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6016)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to complete")
  String line2_ex;
  @JsonKey(defaultValue: "the payment.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen97 {
  factory _Screen97.fromJson(Map<String, dynamic> json) => _$Screen97FromJson(json);
  Map<String, dynamic> toJson() => _$Screen97ToJson(this);

  _Screen97({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾌﾟﾘｶﾎﾟｲﾝﾄ支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6018)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Thank you.")
  String line1_ex;
  @JsonKey(defaultValue: "Please take your receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen98 {
  factory _Screen98.fromJson(Map<String, dynamic> json) => _$Screen98FromJson(json);
  Map<String, dynamic> toJson() => _$Screen98ToJson(this);

  _Screen98({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "社員証決済画面")
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
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "When ready, ")
  String line1_ex;
  @JsonKey(defaultValue: "press \"finish\"")
  String line2_ex;
  @JsonKey(defaultValue: "to complete payment.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen99 {
  factory _Screen99.fromJson(Map<String, dynamic> json) => _$Screen99FromJson(json);
  Map<String, dynamic> toJson() => _$Screen99ToJson(this);

  _Screen99({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "社員証決済完了画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6133)
  int    sound1;
  @JsonKey(defaultValue: 6133)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Thank you.")
  String line1_ex;
  @JsonKey(defaultValue: "Please take your receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 6133)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen100 {
  factory _Screen100.fromJson(Map<String, dynamic> json) => _$Screen100FromJson(json);
  Map<String, dynamic> toJson() => _$Screen100ToJson(this);

  _Screen100({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾌﾟﾘｶﾎﾟｲﾝﾄｶｰﾄﾞ読取画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 20)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6258)
  int    sound1;
  @JsonKey(defaultValue: 6292)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "プリペイドでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "プリペイドカードを")
  String line1;
  @JsonKey(defaultValue: "読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6258)
  int    sound_led1;
  @JsonKey(defaultValue: 6292)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen101 {
  factory _Screen101.fromJson(Map<String, dynamic> json) => _$Screen101FromJson(json);
  Map<String, dynamic> toJson() => _$Screen101ToJson(this);

  _Screen101({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "会員読込画面(フルセルフ)")
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
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 0)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen102 {
  factory _Screen102.fromJson(Map<String, dynamic> json) => _$Screen102FromJson(json);
  Map<String, dynamic> toJson() => _$Screen102ToJson(this);

  _Screen102({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "アイテムリスト画面(フルセルフ)")
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
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 0)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen103 {
  factory _Screen103.fromJson(Map<String, dynamic> json) => _$Screen103FromJson(json);
  Map<String, dynamic> toJson() => _$Screen103ToJson(this);

  _Screen103({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "カード選択画面")
  String title;
  @JsonKey(defaultValue: "ポイントカードの種類を選択して下さい")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6270)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6281)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen104 {
  factory _Screen104.fromJson(Map<String, dynamic> json) => _$Screen104FromJson(json);
  Map<String, dynamic> toJson() => _$Screen104ToJson(this);

  _Screen104({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "カード読込画面")
  String title;
  @JsonKey(defaultValue: "カードを読ませてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6270)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "CoGCaカードを")
  String line1;
  @JsonKey(defaultValue: "タッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6283)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen105 {
  factory _Screen105.fromJson(Map<String, dynamic> json) => _$Screen105FromJson(json);
  Map<String, dynamic> toJson() => _$Screen105ToJson(this);

  _Screen105({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "カード読込画面")
  String title;
  @JsonKey(defaultValue: "カードを読ませてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6270)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "カードを端末に")
  String line1;
  @JsonKey(defaultValue: "通してください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6282)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen106 {
  factory _Screen106.fromJson(Map<String, dynamic> json) => _$Screen106FromJson(json);
  Map<String, dynamic> toJson() => _$Screen106ToJson(this);

  _Screen106({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "カード読込画面")
  String title;
  @JsonKey(defaultValue: "カードを読ませてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6270)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "CoGCaカードを")
  String line1;
  @JsonKey(defaultValue: "タッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6283)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen107 {
  factory _Screen107.fromJson(Map<String, dynamic> json) => _$Screen107FromJson(json);
  Map<String, dynamic> toJson() => _$Screen107ToJson(this);

  _Screen107({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "カード読込画面")
  String title;
  @JsonKey(defaultValue: "カードを読ませてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6270)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "CoGCaカードを")
  String line1;
  @JsonKey(defaultValue: "タッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6283)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen109 {
  factory _Screen109.fromJson(Map<String, dynamic> json) => _$Screen109FromJson(json);
  Map<String, dynamic> toJson() => _$Screen109ToJson(this);

  _Screen109({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "プリカチャージ入金画面")
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
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "プリカチャージ")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "お金を")
  String line1;
  @JsonKey(defaultValue: "入れてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6180)
  int    sound_led1;
  @JsonKey(defaultValue: 6130)
  int    sound_led2;
  @JsonKey(defaultValue: 6015)
  int    sound_led3;
}

@JsonSerializable()
class _Screen111 {
  factory _Screen111.fromJson(Map<String, dynamic> json) => _$Screen111FromJson(json);
  Map<String, dynamic> toJson() => _$Screen111ToJson(this);

  _Screen111({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "プリカ利用画面")
  String title;
  @JsonKey(defaultValue: "プリペイドカードでお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "プリカでお支払い")
  String line_title;
  @JsonKey(defaultValue: "Prepaid Card Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードを読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Please swipe")
  String line1_ex;
  @JsonKey(defaultValue: "your prepaid card.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 0)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen112 {
  factory _Screen112.fromJson(Map<String, dynamic> json) => _$Screen112FromJson(json);
  Map<String, dynamic> toJson() => _$Screen112ToJson(this);

  _Screen112({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "釣銭チャージ")
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
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "釣銭チャージ中")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "釣銭チャージ中です。")
  String line1;
  @JsonKey(defaultValue: "しばらくお待ちください。")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 0)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen113 {
  factory _Screen113.fromJson(Map<String, dynamic> json) => _$Screen113FromJson(json);
  Map<String, dynamic> toJson() => _$Screen113ToJson(this);

  _Screen113({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "プリカ残高照会読取画面")
  String title;
  @JsonKey(defaultValue: "カードを読ませてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6289)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6289)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen114 {
  factory _Screen114.fromJson(Map<String, dynamic> json) => _$Screen114FromJson(json);
  Map<String, dynamic> toJson() => _$Screen114ToJson(this);

  _Screen114({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "プリカ残高照会完了画面")
  String title;
  @JsonKey(defaultValue: "確認が終わりましたら、とじるボタンをおしてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6578)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6578)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen115 {
  factory _Screen115.fromJson(Map<String, dynamic> json) => _$Screen115FromJson(json);
  Map<String, dynamic> toJson() => _$Screen115ToJson(this);

  _Screen115({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾎﾟｲﾝﾄ支払確認画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6016)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to complete")
  String line2_ex;
  @JsonKey(defaultValue: "the payment.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen116 {
  factory _Screen116.fromJson(Map<String, dynamic> json) => _$Screen116FromJson(json);
  Map<String, dynamic> toJson() => _$Screen116ToJson(this);

  _Screen116({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾎﾟｲﾝﾄ支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6018)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Thank you.")
  String line1_ex;
  @JsonKey(defaultValue: "Please take your receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen117 {
  factory _Screen117.fromJson(Map<String, dynamic> json) => _$Screen117FromJson(json);
  Map<String, dynamic> toJson() => _$Screen117ToJson(this);

  _Screen117({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ﾎﾟｲﾝﾄ支払画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6534)
  int    sound1;
  @JsonKey(defaultValue: 6534)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "ポイント数を入力して")
  String line1;
  @JsonKey(defaultValue: "決定を押してください")
  String line2;
  @JsonKey(defaultValue: "訂正する場合はクリア")
  String line3;
  @JsonKey(defaultValue: "ボタンを押してください")
  String line4;
  @JsonKey(defaultValue: "ポイント利用単位：")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6534)
  int    sound_led1;
  @JsonKey(defaultValue: 6534)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen118 {
  factory _Screen118.fromJson(Map<String, dynamic> json) => _$Screen118FromJson(json);
  Map<String, dynamic> toJson() => _$Screen118ToJson(this);

  _Screen118({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "暗証番号入力画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 20)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 0)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "暗証番号を入力")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "暗証番号を")
  String line1;
  @JsonKey(defaultValue: "入力してください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Enter the passcode.")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6239)
  int    sound_led1;
  @JsonKey(defaultValue: 6239)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen119 {
  factory _Screen119.fromJson(Map<String, dynamic> json) => _$Screen119FromJson(json);
  Map<String, dynamic> toJson() => _$Screen119ToJson(this);

  _Screen119({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "iD利用画面")
  String title;
  @JsonKey(defaultValue: "iDでお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6124)
  int    sound1;
  @JsonKey(defaultValue: 6255)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ｉＤでお支払い")
  String line_title;
  @JsonKey(defaultValue: "iD Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6124)
  int    sound_led1;
  @JsonKey(defaultValue: 6255)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen120 {
  factory _Screen120.fromJson(Map<String, dynamic> json) => _$Screen120FromJson(json);
  Map<String, dynamic> toJson() => _$Screen120ToJson(this);

  _Screen120({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "QUICPay利用画面")
  String title;
  @JsonKey(defaultValue: "QUICPayでお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6124)
  int    sound1;
  @JsonKey(defaultValue: 6254)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ＱＵＩＣＰａｙでお支払い")
  String line_title;
  @JsonKey(defaultValue: "QUICPay Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6124)
  int    sound_led1;
  @JsonKey(defaultValue: 6254)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen121 {
  factory _Screen121.fromJson(Map<String, dynamic> json) => _$Screen121FromJson(json);
  Map<String, dynamic> toJson() => _$Screen121ToJson(this);

  _Screen121({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ID支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6133)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Thank you.")
  String line1_ex;
  @JsonKey(defaultValue: "Please take your receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 6133)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen122 {
  factory _Screen122.fromJson(Map<String, dynamic> json) => _$Screen122FromJson(json);
  Map<String, dynamic> toJson() => _$Screen122ToJson(this);

  _Screen122({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "QUICPay支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6133)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Thank you.")
  String line1_ex;
  @JsonKey(defaultValue: "Please take your receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 6133)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen123 {
  factory _Screen123.fromJson(Map<String, dynamic> json) => _$Screen123FromJson(json);
  Map<String, dynamic> toJson() => _$Screen123ToJson(this);

  _Screen123({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Verifone支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6133)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Please take your card")
  String line1_ex;
  @JsonKey(defaultValue: "and the receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "Thank you.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen124 {
  factory _Screen124.fromJson(Map<String, dynamic> json) => _$Screen124FromJson(json);
  Map<String, dynamic> toJson() => _$Screen124ToJson(this);

  _Screen124({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Verifone支払確認画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6179)
  int    sound1;
  @JsonKey(defaultValue: "")
  String sound2;
  @JsonKey(defaultValue: "")
  String sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to complete")
  String line2_ex;
  @JsonKey(defaultValue: "the payment.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: "")
  String sound_led2;
  @JsonKey(defaultValue: "")
  String sound_led3;
}

@JsonSerializable()
class _Screen125 {
  factory _Screen125.fromJson(Map<String, dynamic> json) => _$Screen125FromJson(json);
  Map<String, dynamic> toJson() => _$Screen125ToJson(this);

  _Screen125({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "楽天ポイントカード確認画面")
  String title;
  @JsonKey(defaultValue: "楽天ポイントカードはお持ちですか？")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 44)
  int    msg1_size;
  @JsonKey(defaultValue: "")
  String msg2_size;
  @JsonKey(defaultValue: 6603)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6603)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen126 {
  factory _Screen126.fromJson(Map<String, dynamic> json) => _$Screen126FromJson(json);
  Map<String, dynamic> toJson() => _$Screen126ToJson(this);

  _Screen126({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "楽天ポイントカード読込画面")
  String title;
  @JsonKey(defaultValue: "楽天ポイントカードの登録を行ってください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 44)
  int    msg1_size;
  @JsonKey(defaultValue: "")
  String msg2_size;
  @JsonKey(defaultValue: 6604)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6604)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen127 {
  factory _Screen127.fromJson(Map<String, dynamic> json) => _$Screen127FromJson(json);
  Map<String, dynamic> toJson() => _$Screen127ToJson(this);

  _Screen127({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "PiTaPa利用画面<verifone>")
  String title;
  @JsonKey(defaultValue: "PiTaPaでお会計ですね")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6124)
  int    sound1;
  @JsonKey(defaultValue: 6048)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ＰｉＴａＰａでお支払い")
  String line_title;
  @JsonKey(defaultValue: "PiTaPa Payment")
  String line_title_ex;
  @JsonKey(defaultValue: "お支払い金額を確認し")
  String line1;
  @JsonKey(defaultValue: "カードをタッチしてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Tap your IC card")
  String line1_ex;
  @JsonKey(defaultValue: "on the terminal.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6124)
  int    sound_led1;
  @JsonKey(defaultValue: 6048)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen128 {
  factory _Screen128.fromJson(Map<String, dynamic> json) => _$Screen128FromJson(json);
  Map<String, dynamic> toJson() => _$Screen128ToJson(this);

  _Screen128({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "カード読込画面")
  String title;
  @JsonKey(defaultValue: "カードを読ませてください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6270)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "友の会カードを")
  String line1;
  @JsonKey(defaultValue: "読ませてください")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6720)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen129 {
  factory _Screen129.fromJson(Map<String, dynamic> json) => _$Screen129FromJson(json);
  Map<String, dynamic> toJson() => _$Screen129ToJson(this);

  _Screen129({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "友の会でお支払画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 20)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6258)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "友の会でお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "あああ")
  String line1;
  @JsonKey(defaultValue: "いいい")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6258)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen130 {
  factory _Screen130.fromJson(Map<String, dynamic> json) => _$Screen130FromJson(json);
  Map<String, dynamic> toJson() => _$Screen130ToJson(this);

  _Screen130({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "友の会支払確認画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6179)
  int    sound1;
  @JsonKey(defaultValue: "")
  String sound2;
  @JsonKey(defaultValue: "")
  String sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to complete")
  String line2_ex;
  @JsonKey(defaultValue: "the payment.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: "")
  String sound_led2;
  @JsonKey(defaultValue: "")
  String sound_led3;
}

@JsonSerializable()
class _Screen131 {
  factory _Screen131.fromJson(Map<String, dynamic> json) => _$Screen131FromJson(json);
  Map<String, dynamic> toJson() => _$Screen131ToJson(this);

  _Screen131({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "友の会支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6133)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Please take your card")
  String line1_ex;
  @JsonKey(defaultValue: "and the receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "Thank you.")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen132 {
  factory _Screen132.fromJson(Map<String, dynamic> json) => _$Screen132FromJson(json);
  Map<String, dynamic> toJson() => _$Screen132ToJson(this);

  _Screen132({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Tクーポン確認画面")
  String title;
  @JsonKey(defaultValue: "クーポンはお持ちですか？")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 44)
  int    msg1_size;
  @JsonKey(defaultValue: "")
  String msg2_size;
  @JsonKey(defaultValue: 6552)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6552)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen133 {
  factory _Screen133.fromJson(Map<String, dynamic> json) => _$Screen133FromJson(json);
  Map<String, dynamic> toJson() => _$Screen133ToJson(this);

  _Screen133({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Tクーポン読取画面")
  String title;
  @JsonKey(defaultValue: "クーポンバーコードを")
  String msg1;
  @JsonKey(defaultValue: "スキャンしてください")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6553)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6553)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen134 {
  factory _Screen134.fromJson(Map<String, dynamic> json) => _$Screen134FromJson(json);
  Map<String, dynamic> toJson() => _$Screen134ToJson(this);

  _Screen134({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "楽天ポイント利用確認画面")
  String title;
  @JsonKey(defaultValue: "楽天ポイントを利用しますか？")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 44)
  int    msg1_size;
  @JsonKey(defaultValue: "")
  String msg2_size;
  @JsonKey(defaultValue: 6631)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6631)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen135 {
  factory _Screen135.fromJson(Map<String, dynamic> json) => _$Screen135FromJson(json);
  Map<String, dynamic> toJson() => _$Screen135ToJson(this);

  _Screen135({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "Edyリトライ画面")
  String title;
  @JsonKey(defaultValue: "もう一度カードを")
  String msg1;
  @JsonKey(defaultValue: "タッチしてください")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6277)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "Ｅｄｙでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "カードの読取が不十分です")
  String line1;
  @JsonKey(defaultValue: "もう一度カードを")
  String line2;
  @JsonKey(defaultValue: "タッチしてください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6277)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen136 {
  factory _Screen136.fromJson(Map<String, dynamic> json) => _$Screen136FromJson(json);
  Map<String, dynamic> toJson() => _$Screen136ToJson(this);

  _Screen136({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "iDリトライ画面")
  String title;
  @JsonKey(defaultValue: "もう一度カードを")
  String msg1;
  @JsonKey(defaultValue: "タッチしてください")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6277)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ｉＤでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "カードの読取が不十分です")
  String line1;
  @JsonKey(defaultValue: "もう一度カードを")
  String line2;
  @JsonKey(defaultValue: "タッチしてください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6277)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen137 {
  factory _Screen137.fromJson(Map<String, dynamic> json) => _$Screen137FromJson(json);
  Map<String, dynamic> toJson() => _$Screen137ToJson(this);

  _Screen137({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "交通系ICリトライ画面")
  String title;
  @JsonKey(defaultValue: "もう一度カードを")
  String msg1;
  @JsonKey(defaultValue: "タッチしてください")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6277)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "交通系ＩＣでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "カードの読取が不十分です")
  String line1;
  @JsonKey(defaultValue: "もう一度カードを")
  String line2;
  @JsonKey(defaultValue: "タッチしてください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6277)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen138 {
  factory _Screen138.fromJson(Map<String, dynamic> json) => _$Screen138FromJson(json);
  Map<String, dynamic> toJson() => _$Screen138ToJson(this);

  _Screen138({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "QUICPayリトライ画面")
  String title;
  @JsonKey(defaultValue: "もう一度カードを")
  String msg1;
  @JsonKey(defaultValue: "タッチしてください")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6277)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ＱＵＩＣＰａｙでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "カードの読取が不十分です")
  String line1;
  @JsonKey(defaultValue: "もう一度カードを")
  String line2;
  @JsonKey(defaultValue: "タッチしてください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6277)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen139 {
  factory _Screen139.fromJson(Map<String, dynamic> json) => _$Screen139FromJson(json);
  Map<String, dynamic> toJson() => _$Screen139ToJson(this);

  _Screen139({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "nanacoリトライ画面")
  String title;
  @JsonKey(defaultValue: "もう一度カードを")
  String msg1;
  @JsonKey(defaultValue: "タッチしてください")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6277)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ｎａｎａｃｏでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "カードの読取が不十分です")
  String line1;
  @JsonKey(defaultValue: "もう一度カードを")
  String line2;
  @JsonKey(defaultValue: "タッチしてください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6277)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen140 {
  factory _Screen140.fromJson(Map<String, dynamic> json) => _$Screen140FromJson(json);
  Map<String, dynamic> toJson() => _$Screen140ToJson(this);

  _Screen140({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "PiTaPaリトライ画面")
  String title;
  @JsonKey(defaultValue: "もう一度カードを")
  String msg1;
  @JsonKey(defaultValue: "タッチしてください")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6277)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ＰｉＴａＰａでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "カードの読取が不十分です")
  String line1;
  @JsonKey(defaultValue: "もう一度カードを")
  String line2;
  @JsonKey(defaultValue: "タッチしてください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6277)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen141 {
  factory _Screen141.fromJson(Map<String, dynamic> json) => _$Screen141FromJson(json);
  Map<String, dynamic> toJson() => _$Screen141ToJson(this);

  _Screen141({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "WAONリトライ画面")
  String title;
  @JsonKey(defaultValue: "もう一度カードを")
  String msg1;
  @JsonKey(defaultValue: "タッチしてください")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6277)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "ＷＡＯＮでお支払い")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "カードの読取が不十分です")
  String line1;
  @JsonKey(defaultValue: "もう一度カードを")
  String line2;
  @JsonKey(defaultValue: "タッチしてください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6277)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen144 {
  factory _Screen144.fromJson(Map<String, dynamic> json) => _$Screen144FromJson(json);
  Map<String, dynamic> toJson() => _$Screen144ToJson(this);

  _Screen144({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "会員解除確認画面")
  String title;
  @JsonKey(defaultValue: "会員様優待が適用されません。")
  String msg1;
  @JsonKey(defaultValue: "よろしいでしょうか？")
  String msg2;
  @JsonKey(defaultValue: 28)
  int    msg1_size;
  @JsonKey(defaultValue: 44)
  int    msg2_size;
  @JsonKey(defaultValue: 6606)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6606)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen145 {
  factory _Screen145.fromJson(Map<String, dynamic> json) => _$Screen145FromJson(json);
  Map<String, dynamic> toJson() => _$Screen145ToJson(this);

  _Screen145({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ｄポイント利用確認画面")
  String title;
  @JsonKey(defaultValue: "ｄポイントを利用しますか？。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 44)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6752)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 30)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6752)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen146 {
  factory _Screen146.fromJson(Map<String, dynamic> json) => _$Screen146FromJson(json);
  Map<String, dynamic> toJson() => _$Screen146ToJson(this);

  _Screen146({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "カード読込画面")
  String title;
  @JsonKey(defaultValue: "カードを読ませてください。")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 28)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6289)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 10)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "")
  String line1;
  @JsonKey(defaultValue: "")
  String line2;
  @JsonKey(defaultValue: "")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6289)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen147 {
  factory _Screen147.fromJson(Map<String, dynamic> json) => _$Screen147FromJson(json);
  Map<String, dynamic> toJson() => _$Screen147ToJson(this);

  _Screen147({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ｸｰﾎﾟﾝ一覧画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 24)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6761)
  int    sound1;
  @JsonKey(defaultValue: 6761)
  int    sound2;
  @JsonKey(defaultValue: 1)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 10)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "一覧からクーポンを選択して")
  String line1;
  @JsonKey(defaultValue: "決定を押してください")
  String line2;
  @JsonKey(defaultValue: "訂正する場合はクリア")
  String line3;
  @JsonKey(defaultValue: "ボタンを押してください")
  String line4;
  @JsonKey(defaultValue: "")
  String line1_ex;
  @JsonKey(defaultValue: "")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6761)
  int    sound_led1;
  @JsonKey(defaultValue: 6761)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen148 {
  factory _Screen148.fromJson(Map<String, dynamic> json) => _$Screen148FromJson(json);
  Map<String, dynamic> toJson() => _$Screen148ToJson(this);

  _Screen148({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ｸｰﾎﾟﾝ支払確認画面")
  String title;
  @JsonKey(defaultValue: "")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6016)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 20)
  int    snd_timer;
  @JsonKey(defaultValue: 0)
  int    timer1;
  @JsonKey(defaultValue: 0)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "よろしければ")
  String line1;
  @JsonKey(defaultValue: "おわりボタンを")
  String line2;
  @JsonKey(defaultValue: "押してください")
  String line3;
  @JsonKey(defaultValue: "")
  String line4;
  @JsonKey(defaultValue: "Touch the \"Confirm\"")
  String line1_ex;
  @JsonKey(defaultValue: "button to complete")
  String line2_ex;
  @JsonKey(defaultValue: "the payment")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6179)
  int    sound_led1;
  @JsonKey(defaultValue: 6217)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _Screen149 {
  factory _Screen149.fromJson(Map<String, dynamic> json) => _$Screen149FromJson(json);
  Map<String, dynamic> toJson() => _$Screen149ToJson(this);

  _Screen149({
    required this.title,
    required this.msg1,
    required this.msg2,
    required this.msg1_size,
    required this.msg2_size,
    required this.sound1,
    required this.sound2,
    required this.sound3,
    required this.snd_timer,
    required this.timer1,
    required this.timer2,
    required this.timer3,
    required this.dsp_flg1,
    required this.dsp_flg2,
    required this.movie01_ext,
    required this.movie02_ext,
    required this.movie03_ext,
    required this.movie04_ext,
    required this.line_title,
    required this.line_title_ex,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.line1_ex,
    required this.line2_ex,
    required this.line3_ex,
    required this.line4_ex,
    required this.sound_led1,
    required this.sound_led2,
    required this.sound_led3,
  });

  @JsonKey(defaultValue: "ｸｰﾎﾟﾝ支払完了画面")
  String title;
  @JsonKey(defaultValue: "レシートをお取りください")
  String msg1;
  @JsonKey(defaultValue: "")
  String msg2;
  @JsonKey(defaultValue: 0)
  int    msg1_size;
  @JsonKey(defaultValue: 0)
  int    msg2_size;
  @JsonKey(defaultValue: 6018)
  int    sound1;
  @JsonKey(defaultValue: 0)
  int    sound2;
  @JsonKey(defaultValue: 0)
  int    sound3;
  @JsonKey(defaultValue: 0)
  int    snd_timer;
  @JsonKey(defaultValue: 5)
  int    timer1;
  @JsonKey(defaultValue: 10)
  int    timer2;
  @JsonKey(defaultValue: 0)
  int    timer3;
  @JsonKey(defaultValue: 0)
  int    dsp_flg1;
  @JsonKey(defaultValue: 0)
  int    dsp_flg2;
  @JsonKey(defaultValue: 0)
  int    movie01_ext;
  @JsonKey(defaultValue: 0)
  int    movie02_ext;
  @JsonKey(defaultValue: 0)
  int    movie03_ext;
  @JsonKey(defaultValue: 0)
  int    movie04_ext;
  @JsonKey(defaultValue: "")
  String line_title;
  @JsonKey(defaultValue: "")
  String line_title_ex;
  @JsonKey(defaultValue: "レシートを")
  String line1;
  @JsonKey(defaultValue: "お受け取りください")
  String line2;
  @JsonKey(defaultValue: "ありがとう")
  String line3;
  @JsonKey(defaultValue: "ございました")
  String line4;
  @JsonKey(defaultValue: "Thank you")
  String line1_ex;
  @JsonKey(defaultValue: "Please take your receipt.")
  String line2_ex;
  @JsonKey(defaultValue: "")
  String line3_ex;
  @JsonKey(defaultValue: "")
  String line4_ex;
  @JsonKey(defaultValue: 6133)
  int    sound_led1;
  @JsonKey(defaultValue: 0)
  int    sound_led2;
  @JsonKey(defaultValue: 0)
  int    sound_led3;
}

@JsonSerializable()
class _AActSetUp {
  factory _AActSetUp.fromJson(Map<String, dynamic> json) => _$AActSetUpFromJson(json);
  Map<String, dynamic> toJson() => _$AActSetUpToJson(this);

  _AActSetUp({
    required this.ReadAlertTime,
    required this.AutoReadInterval,
    required this.InterruptPrint,
    required this.InterruptPay,
    required this.UpdGetFtpTimer,
  });

  @JsonKey(defaultValue: 60)
  int    ReadAlertTime;
  @JsonKey(defaultValue: 3)
  int    AutoReadInterval;
  @JsonKey(defaultValue: 0)
  int    InterruptPrint;
  @JsonKey(defaultValue: 0)
  int    InterruptPay;
  @JsonKey(defaultValue: 10)
  int    UpdGetFtpTimer;
}

@JsonSerializable()
class _HHiddenSetUp {
  factory _HHiddenSetUp.fromJson(Map<String, dynamic> json) => _$HHiddenSetUpFromJson(json);
  Map<String, dynamic> toJson() => _$HHiddenSetUpToJson(this);

  _HHiddenSetUp({
    required this.TableReadInterval,
  });

  @JsonKey(defaultValue: 500)
  int    TableReadInterval;
}

@JsonSerializable()
class _Customer {
  factory _Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  _Customer({
    required this.cust_card_max,
    required this.cust_card_type1,
    required this.cust_card_type2,
    required this.cust_card_type3,
    required this.cust_card_type4,
    required this.cust_card_type5,
    required this.cust_card_type6,
  });

  @JsonKey(defaultValue: 0)
  int    cust_card_max;
  @JsonKey(defaultValue: 0)
  int    cust_card_type1;
  @JsonKey(defaultValue: 0)
  int    cust_card_type2;
  @JsonKey(defaultValue: 0)
  int    cust_card_type3;
  @JsonKey(defaultValue: 0)
  int    cust_card_type4;
  @JsonKey(defaultValue: 0)
  int    cust_card_type5;
  @JsonKey(defaultValue: 0)
  int    cust_card_type6;
}

@JsonSerializable()
class _SShopAndGo {
  factory _SShopAndGo.fromJson(Map<String, dynamic> json) => _$SShopAndGoFromJson(json);
  Map<String, dynamic> toJson() => _$SShopAndGoToJson(this);

  _SShopAndGo({
    required this.shop_and_go_nonfile_plucd,
    required this.shop_and_go_nonscan_plucd,
    required this.shop_and_go_limit1,
    required this.shop_and_go_limit2,
    required this.shop_and_go_limit3,
    required this.shop_and_go_test_srv_flg,
    required this.shop_and_go_companycode,
    required this.shop_and_go_storecode,
    required this.shop_and_go_mbr_chk_dsp,
    required this.shop_and_go_server_timeout,
    required this.shop_and_go_proxy,
    required this.shop_and_go_proxy_port,
    required this.shop_and_go_n_money_btn_dsp,
    required this.shop_and_go_domain,
    required this.shop_and_go_mbr_card_dsp,
    required this.shop_and_go_cr50_domain,
    required this.shop_and_go_point_domain,
    required this.shop_and_go_cr50_plucd,
    required this.shop_and_go_eatin_dsp,
    required this.shop_and_go_cogca_read_twice,
    required this.shop_and_go_use_class,
    required this.shop_and_go_expensive_mark_prn,
    required this.shop_and_go_regbag_dsp,
    required this.shop_and_go_use_preset_grp_code,
    required this.shop_and_go_mente_nonplu_btn_reference,
    required this.shop_and_go_mbr_auto_cncl_time,
    required this.shop_and_go_rcpt_ttlnmbr_bold,
    required this.shop_and_go_apl_dl_qr_print,
    required this.shop_and_go_rcpt_msg_use_no,
    required this.shop_and_go_apl_dl_qr_print_normal,
    required this.shop_and_go_qr_print_chk_itmcnt_fs,
    required this.shop_and_go_qr_print_chk_itmcnt_ss,
    required this.shop_and_go_thread_timeout,
  });

  @JsonKey(defaultValue: 999999)
  int    shop_and_go_nonfile_plucd;
  @JsonKey(defaultValue: 999998)
  int    shop_and_go_nonscan_plucd;
  @JsonKey(defaultValue: 999)
  int    shop_and_go_limit1;
  @JsonKey(defaultValue: 499)
  int    shop_and_go_limit2;
  @JsonKey(defaultValue: 299)
  int    shop_and_go_limit3;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_test_srv_flg;
  @JsonKey(defaultValue: 999999998)
  int    shop_and_go_companycode;
  @JsonKey(defaultValue: 123456789)
  int    shop_and_go_storecode;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_mbr_chk_dsp;
  @JsonKey(defaultValue: 3)
  int    shop_and_go_server_timeout;
  @JsonKey(defaultValue: "")
  String shop_and_go_proxy;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_proxy_port;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_n_money_btn_dsp;
  @JsonKey(defaultValue: "https://api.digi-cr.com")
  String shop_and_go_domain;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_mbr_card_dsp;
  @JsonKey(defaultValue: "")
  String shop_and_go_cr50_domain;
  @JsonKey(defaultValue: "")
  String shop_and_go_point_domain;
  @JsonKey(defaultValue: 999997)
  int    shop_and_go_cr50_plucd;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_eatin_dsp;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_cogca_read_twice;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_use_class;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_expensive_mark_prn;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_regbag_dsp;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_use_preset_grp_code;
  @JsonKey(defaultValue: 1)
  int    shop_and_go_mente_nonplu_btn_reference;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_mbr_auto_cncl_time;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_rcpt_ttlnmbr_bold;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_apl_dl_qr_print;
  @JsonKey(defaultValue: 31)
  int    shop_and_go_rcpt_msg_use_no;
  @JsonKey(defaultValue: 0)
  int    shop_and_go_apl_dl_qr_print_normal;
  @JsonKey(defaultValue: 6)
  int    shop_and_go_qr_print_chk_itmcnt_fs;
  @JsonKey(defaultValue: 16)
  int    shop_and_go_qr_print_chk_itmcnt_ss;
  @JsonKey(defaultValue: 10)
  int    shop_and_go_thread_timeout;
}

@JsonSerializable()
class _PPaymentGroup {
  factory _PPaymentGroup.fromJson(Map<String, dynamic> json) => _$PPaymentGroupFromJson(json);
  Map<String, dynamic> toJson() => _$PPaymentGroupToJson(this);

  _PPaymentGroup({
    required this.pay_grp_name1,
    required this.pay_grp_name2,
    required this.pay_grp_name3,
    required this.pay_grp_name4,
    required this.pay_grp_name5,
    required this.pay_grp_name6,
    required this.pay_grp_name7,
    required this.pay_grp_name8,
    required this.pay_grp_name9,
    required this.pay_typ1_grp,
    required this.pay_typ2_grp,
    required this.pay_typ3_grp,
    required this.pay_typ4_grp,
    required this.pay_typ5_grp,
    required this.pay_typ6_grp,
    required this.pay_typ7_grp,
    required this.pay_typ8_grp,
    required this.pay_typ9_grp,
    required this.pay_typ10_grp,
    required this.pay_typ11_grp,
    required this.pay_typ12_grp,
    required this.pay_typ13_grp,
    required this.pay_typ14_grp,
    required this.pay_typ15_grp,
    required this.pay_typ16_grp,
    required this.pay_grp_name1_ex,
    required this.pay_grp_name2_ex,
    required this.pay_grp_name3_ex,
    required this.pay_grp_name4_ex,
    required this.pay_grp_name5_ex,
    required this.pay_grp_name6_ex,
    required this.pay_grp_name7_ex,
    required this.pay_grp_name8_ex,
    required this.pay_grp_name9_ex,
  });

  @JsonKey(defaultValue: "会計グループ１")
  String pay_grp_name1;
  @JsonKey(defaultValue: "会計グループ２")
  String pay_grp_name2;
  @JsonKey(defaultValue: "会計グループ３")
  String pay_grp_name3;
  @JsonKey(defaultValue: "会計グループ４")
  String pay_grp_name4;
  @JsonKey(defaultValue: "会計グループ５")
  String pay_grp_name5;
  @JsonKey(defaultValue: "会計グループ６")
  String pay_grp_name6;
  @JsonKey(defaultValue: "会計グループ７")
  String pay_grp_name7;
  @JsonKey(defaultValue: "会計グループ８")
  String pay_grp_name8;
  @JsonKey(defaultValue: "会計グループ９")
  String pay_grp_name9;
  @JsonKey(defaultValue: 0)
  int    pay_typ1_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ2_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ3_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ4_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ5_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ6_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ7_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ8_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ9_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ10_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ11_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ12_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ13_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ14_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ15_grp;
  @JsonKey(defaultValue: 0)
  int    pay_typ16_grp;
  @JsonKey(defaultValue: "Payment Group １")
  String pay_grp_name1_ex;
  @JsonKey(defaultValue: "Payment Group ２")
  String pay_grp_name2_ex;
  @JsonKey(defaultValue: "Payment Group ３")
  String pay_grp_name3_ex;
  @JsonKey(defaultValue: "Payment Group ４")
  String pay_grp_name4_ex;
  @JsonKey(defaultValue: "Payment Group ５")
  String pay_grp_name5_ex;
  @JsonKey(defaultValue: "Payment Group ６")
  String pay_grp_name6_ex;
  @JsonKey(defaultValue: "Payment Group ７")
  String pay_grp_name7_ex;
  @JsonKey(defaultValue: "Payment Group ８")
  String pay_grp_name8_ex;
  @JsonKey(defaultValue: "Payment Group ９")
  String pay_grp_name9_ex;
}

