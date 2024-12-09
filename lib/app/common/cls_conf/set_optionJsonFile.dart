/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'set_optionJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Set_optionJsonFile extends ConfigJsonFile {
  static final Set_optionJsonFile _instance = Set_optionJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "set_option.json";

  Set_optionJsonFile(){
    setPath(_confPath, _fileName);
  }
  Set_optionJsonFile._internal();

  factory Set_optionJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Set_optionJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Set_optionJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Set_optionJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        stm = _$StmFromJson(jsonD['stm']);
      } catch(e) {
        stm = _$StmFromJson({});
        ret = false;
      }
      try {
        smlcls = _$SmlclsFromJson(jsonD['smlcls']);
      } catch(e) {
        smlcls = _$SmlclsFromJson({});
        ret = false;
      }
      try {
        plu = _$PluFromJson(jsonD['plu']);
      } catch(e) {
        plu = _$PluFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Stm stm = _Stm(
    def_sch_qty                        : 0,
    def_item_qty                       : 0,
  );

  _Smlcls smlcls = _Smlcls(
    def_tax_cd                         : 0,
  );

  _Plu plu = _Plu(
    sims_cnct_new_plu                  : 0,
  );
}

@JsonSerializable()
class _Stm {
  factory _Stm.fromJson(Map<String, dynamic> json) => _$StmFromJson(json);
  Map<String, dynamic> toJson() => _$StmToJson(this);

  _Stm({
    required this.def_sch_qty,
    required this.def_item_qty,
  });

  @JsonKey(defaultValue: 1)
  int    def_sch_qty;
  @JsonKey(defaultValue: 1)
  int    def_item_qty;
}

@JsonSerializable()
class _Smlcls {
  factory _Smlcls.fromJson(Map<String, dynamic> json) => _$SmlclsFromJson(json);
  Map<String, dynamic> toJson() => _$SmlclsToJson(this);

  _Smlcls({
    required this.def_tax_cd,
  });

  @JsonKey(defaultValue: 2)
  int    def_tax_cd;
}

@JsonSerializable()
class _Plu {
  factory _Plu.fromJson(Map<String, dynamic> json) => _$PluFromJson(json);
  Map<String, dynamic> toJson() => _$PluToJson(this);

  _Plu({
    required this.sims_cnct_new_plu,
  });

  @JsonKey(defaultValue: 0)
  int    sims_cnct_new_plu;
}

