/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'consistency_acxJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Consistency_acxJsonFile extends ConfigJsonFile {
  static final Consistency_acxJsonFile _instance = Consistency_acxJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "consistency_acx.json";

  Consistency_acxJsonFile(){
    setPath(_confPath, _fileName);
  }
  Consistency_acxJsonFile._internal();

  factory Consistency_acxJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Consistency_acxJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Consistency_acxJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Consistency_acxJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        version = _$VersionFromJson(jsonD['version']);
      } catch(e) {
        version = _$VersionFromJson({});
        ret = false;
      }
      try {
        acr_cnct = _$Acr_cnctFromJson(jsonD['acr_cnct']);
      } catch(e) {
        acr_cnct = _$Acr_cnctFromJson({});
        ret = false;
      }
      try {
        acb_deccin = _$Acb_deccinFromJson(jsonD['acb_deccin']);
      } catch(e) {
        acb_deccin = _$Acb_deccinFromJson({});
        ret = false;
      }
      try {
        acb_select = _$Acb_selectFromJson(jsonD['acb_select']);
      } catch(e) {
        acb_select = _$Acb_selectFromJson({});
        ret = false;
      }
      try {
        auto_deccin = _$Auto_deccinFromJson(jsonD['auto_deccin']);
      } catch(e) {
        auto_deccin = _$Auto_deccinFromJson({});
        ret = false;
      }
      try {
        acr50_ssw14_0 = _$Acr50_ssw14_0FromJson(jsonD['acr50_ssw14_0']);
      } catch(e) {
        acr50_ssw14_0 = _$Acr50_ssw14_0FromJson({});
        ret = false;
      }
      try {
        acr50_ssw14_1_2 = _$Acr50_ssw14_1_2FromJson(jsonD['acr50_ssw14_1_2']);
      } catch(e) {
        acr50_ssw14_1_2 = _$Acr50_ssw14_1_2FromJson({});
        ret = false;
      }
      try {
        acr50_ssw14_3_4 = _$Acr50_ssw14_3_4FromJson(jsonD['acr50_ssw14_3_4']);
      } catch(e) {
        acr50_ssw14_3_4 = _$Acr50_ssw14_3_4FromJson({});
        ret = false;
      }
      try {
        acr50_ssw14_5 = _$Acr50_ssw14_5FromJson(jsonD['acr50_ssw14_5']);
      } catch(e) {
        acr50_ssw14_5 = _$Acr50_ssw14_5FromJson({});
        ret = false;
      }
      try {
        acr50_ssw14_7 = _$Acr50_ssw14_7FromJson(jsonD['acr50_ssw14_7']);
      } catch(e) {
        acr50_ssw14_7 = _$Acr50_ssw14_7FromJson({});
        ret = false;
      }
      try {
        pick_end = _$Pick_endFromJson(jsonD['pick_end']);
      } catch(e) {
        pick_end = _$Pick_endFromJson({});
        ret = false;
      }
      try {
        acxreal_system = _$Acxreal_systemFromJson(jsonD['acxreal_system']);
      } catch(e) {
        acxreal_system = _$Acxreal_systemFromJson({});
        ret = false;
      }
      try {
        acxreal_interval = _$Acxreal_intervalFromJson(jsonD['acxreal_interval']);
      } catch(e) {
        acxreal_interval = _$Acxreal_intervalFromJson({});
        ret = false;
      }
      try {
        ecs_pick_positn10000 = _$Ecs_pick_positn10000FromJson(jsonD['ecs_pick_positn10000']);
      } catch(e) {
        ecs_pick_positn10000 = _$Ecs_pick_positn10000FromJson({});
        ret = false;
      }
      try {
        ecs_pick_positn5000 = _$Ecs_pick_positn5000FromJson(jsonD['ecs_pick_positn5000']);
      } catch(e) {
        ecs_pick_positn5000 = _$Ecs_pick_positn5000FromJson({});
        ret = false;
      }
      try {
        ecs_pick_positn2000 = _$Ecs_pick_positn2000FromJson(jsonD['ecs_pick_positn2000']);
      } catch(e) {
        ecs_pick_positn2000 = _$Ecs_pick_positn2000FromJson({});
        ret = false;
      }
      try {
        ecs_pick_positn1000 = _$Ecs_pick_positn1000FromJson(jsonD['ecs_pick_positn1000']);
      } catch(e) {
        ecs_pick_positn1000 = _$Ecs_pick_positn1000FromJson({});
        ret = false;
      }
      try {
        acx_pick_data10000 = _$Acx_pick_data10000FromJson(jsonD['acx_pick_data10000']);
      } catch(e) {
        acx_pick_data10000 = _$Acx_pick_data10000FromJson({});
        ret = false;
      }
      try {
        acx_pick_data5000 = _$Acx_pick_data5000FromJson(jsonD['acx_pick_data5000']);
      } catch(e) {
        acx_pick_data5000 = _$Acx_pick_data5000FromJson({});
        ret = false;
      }
      try {
        acx_pick_data2000 = _$Acx_pick_data2000FromJson(jsonD['acx_pick_data2000']);
      } catch(e) {
        acx_pick_data2000 = _$Acx_pick_data2000FromJson({});
        ret = false;
      }
      try {
        acx_pick_data1000 = _$Acx_pick_data1000FromJson(jsonD['acx_pick_data1000']);
      } catch(e) {
        acx_pick_data1000 = _$Acx_pick_data1000FromJson({});
        ret = false;
      }
      try {
        acx_pick_data500 = _$Acx_pick_data500FromJson(jsonD['acx_pick_data500']);
      } catch(e) {
        acx_pick_data500 = _$Acx_pick_data500FromJson({});
        ret = false;
      }
      try {
        acx_pick_data100 = _$Acx_pick_data100FromJson(jsonD['acx_pick_data100']);
      } catch(e) {
        acx_pick_data100 = _$Acx_pick_data100FromJson({});
        ret = false;
      }
      try {
        acx_pick_data50 = _$Acx_pick_data50FromJson(jsonD['acx_pick_data50']);
      } catch(e) {
        acx_pick_data50 = _$Acx_pick_data50FromJson({});
        ret = false;
      }
      try {
        acx_pick_data10 = _$Acx_pick_data10FromJson(jsonD['acx_pick_data10']);
      } catch(e) {
        acx_pick_data10 = _$Acx_pick_data10FromJson({});
        ret = false;
      }
      try {
        acx_pick_data5 = _$Acx_pick_data5FromJson(jsonD['acx_pick_data5']);
      } catch(e) {
        acx_pick_data5 = _$Acx_pick_data5FromJson({});
        ret = false;
      }
      try {
        acx_pick_data1 = _$Acx_pick_data1FromJson(jsonD['acx_pick_data1']);
      } catch(e) {
        acx_pick_data1 = _$Acx_pick_data1FromJson({});
        ret = false;
      }
      try {
        ecs_recalc_reject = _$Ecs_recalc_rejectFromJson(jsonD['ecs_recalc_reject']);
      } catch(e) {
        ecs_recalc_reject = _$Ecs_recalc_rejectFromJson({});
        ret = false;
      }
      try {
        sst1_error_disp = _$Sst1_error_dispFromJson(jsonD['sst1_error_disp']);
      } catch(e) {
        sst1_error_disp = _$Sst1_error_dispFromJson({});
        ret = false;
      }
      try {
        sst1_cin_retry = _$Sst1_cin_retryFromJson(jsonD['sst1_cin_retry']);
      } catch(e) {
        sst1_cin_retry = _$Sst1_cin_retryFromJson({});
        ret = false;
      }
      try {
        acx_resv_min5000 = _$Acx_resv_min5000FromJson(jsonD['acx_resv_min5000']);
      } catch(e) {
        acx_resv_min5000 = _$Acx_resv_min5000FromJson({});
        ret = false;
      }
      try {
        acx_resv_min2000 = _$Acx_resv_min2000FromJson(jsonD['acx_resv_min2000']);
      } catch(e) {
        acx_resv_min2000 = _$Acx_resv_min2000FromJson({});
        ret = false;
      }
      try {
        acx_resv_min1000 = _$Acx_resv_min1000FromJson(jsonD['acx_resv_min1000']);
      } catch(e) {
        acx_resv_min1000 = _$Acx_resv_min1000FromJson({});
        ret = false;
      }
      try {
        acx_resv_min500 = _$Acx_resv_min500FromJson(jsonD['acx_resv_min500']);
      } catch(e) {
        acx_resv_min500 = _$Acx_resv_min500FromJson({});
        ret = false;
      }
      try {
        acx_resv_min100 = _$Acx_resv_min100FromJson(jsonD['acx_resv_min100']);
      } catch(e) {
        acx_resv_min100 = _$Acx_resv_min100FromJson({});
        ret = false;
      }
      try {
        acx_resv_min50 = _$Acx_resv_min50FromJson(jsonD['acx_resv_min50']);
      } catch(e) {
        acx_resv_min50 = _$Acx_resv_min50FromJson({});
        ret = false;
      }
      try {
        acx_resv_min10 = _$Acx_resv_min10FromJson(jsonD['acx_resv_min10']);
      } catch(e) {
        acx_resv_min10 = _$Acx_resv_min10FromJson({});
        ret = false;
      }
      try {
        acx_resv_min5 = _$Acx_resv_min5FromJson(jsonD['acx_resv_min5']);
      } catch(e) {
        acx_resv_min5 = _$Acx_resv_min5FromJson({});
        ret = false;
      }
      try {
        acx_resv_min1 = _$Acx_resv_min1FromJson(jsonD['acx_resv_min1']);
      } catch(e) {
        acx_resv_min1 = _$Acx_resv_min1FromJson({});
        ret = false;
      }
      try {
        acb50_ssw13_0 = _$Acb50_ssw13_0FromJson(jsonD['acb50_ssw13_0']);
      } catch(e) {
        acb50_ssw13_0 = _$Acb50_ssw13_0FromJson({});
        ret = false;
      }
      try {
        acb50_ssw13_1_2 = _$Acb50_ssw13_1_2FromJson(jsonD['acb50_ssw13_1_2']);
      } catch(e) {
        acb50_ssw13_1_2 = _$Acb50_ssw13_1_2FromJson({});
        ret = false;
      }
      try {
        acb50_ssw13_3_4 = _$Acb50_ssw13_3_4FromJson(jsonD['acb50_ssw13_3_4']);
      } catch(e) {
        acb50_ssw13_3_4 = _$Acb50_ssw13_3_4FromJson({});
        ret = false;
      }
      try {
        acb50_ssw13_5 = _$Acb50_ssw13_5FromJson(jsonD['acb50_ssw13_5']);
      } catch(e) {
        acb50_ssw13_5 = _$Acb50_ssw13_5FromJson({});
        ret = false;
      }
      try {
        acb50_ssw13_6 = _$Acb50_ssw13_6FromJson(jsonD['acb50_ssw13_6']);
      } catch(e) {
        acb50_ssw13_6 = _$Acb50_ssw13_6FromJson({});
        ret = false;
      }
      try {
        chgdrw_inout_tran = _$Chgdrw_inout_tranFromJson(jsonD['chgdrw_inout_tran']);
      } catch(e) {
        chgdrw_inout_tran = _$Chgdrw_inout_tranFromJson({});
        ret = false;
      }
      try {
        chgdrw_loan_tran = _$Chgdrw_loan_tranFromJson(jsonD['chgdrw_loan_tran']);
      } catch(e) {
        chgdrw_loan_tran = _$Chgdrw_loan_tranFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Version version = _Version(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acr_cnct acr_cnct = _Acr_cnct(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acb_deccin acb_deccin = _Acb_deccin(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acb_select acb_select = _Acb_select(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Auto_deccin auto_deccin = _Auto_deccin(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acr50_ssw14_0 acr50_ssw14_0 = _Acr50_ssw14_0(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acr50_ssw14_1_2 acr50_ssw14_1_2 = _Acr50_ssw14_1_2(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acr50_ssw14_3_4 acr50_ssw14_3_4 = _Acr50_ssw14_3_4(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acr50_ssw14_5 acr50_ssw14_5 = _Acr50_ssw14_5(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acr50_ssw14_7 acr50_ssw14_7 = _Acr50_ssw14_7(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pick_end pick_end = _Pick_end(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acxreal_system acxreal_system = _Acxreal_system(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acxreal_interval acxreal_interval = _Acxreal_interval(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Ecs_pick_positn10000 ecs_pick_positn10000 = _Ecs_pick_positn10000(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Ecs_pick_positn5000 ecs_pick_positn5000 = _Ecs_pick_positn5000(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Ecs_pick_positn2000 ecs_pick_positn2000 = _Ecs_pick_positn2000(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Ecs_pick_positn1000 ecs_pick_positn1000 = _Ecs_pick_positn1000(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_pick_data10000 acx_pick_data10000 = _Acx_pick_data10000(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_pick_data5000 acx_pick_data5000 = _Acx_pick_data5000(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_pick_data2000 acx_pick_data2000 = _Acx_pick_data2000(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_pick_data1000 acx_pick_data1000 = _Acx_pick_data1000(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_pick_data500 acx_pick_data500 = _Acx_pick_data500(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_pick_data100 acx_pick_data100 = _Acx_pick_data100(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_pick_data50 acx_pick_data50 = _Acx_pick_data50(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_pick_data10 acx_pick_data10 = _Acx_pick_data10(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_pick_data5 acx_pick_data5 = _Acx_pick_data5(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_pick_data1 acx_pick_data1 = _Acx_pick_data1(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Ecs_recalc_reject ecs_recalc_reject = _Ecs_recalc_reject(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Sst1_error_disp sst1_error_disp = _Sst1_error_disp(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Sst1_cin_retry sst1_cin_retry = _Sst1_cin_retry(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_resv_min5000 acx_resv_min5000 = _Acx_resv_min5000(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_resv_min2000 acx_resv_min2000 = _Acx_resv_min2000(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_resv_min1000 acx_resv_min1000 = _Acx_resv_min1000(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_resv_min500 acx_resv_min500 = _Acx_resv_min500(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_resv_min100 acx_resv_min100 = _Acx_resv_min100(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_resv_min50 acx_resv_min50 = _Acx_resv_min50(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_resv_min10 acx_resv_min10 = _Acx_resv_min10(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_resv_min5 acx_resv_min5 = _Acx_resv_min5(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acx_resv_min1 acx_resv_min1 = _Acx_resv_min1(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acb50_ssw13_0 acb50_ssw13_0 = _Acb50_ssw13_0(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acb50_ssw13_1_2 acb50_ssw13_1_2 = _Acb50_ssw13_1_2(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acb50_ssw13_3_4 acb50_ssw13_3_4 = _Acb50_ssw13_3_4(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acb50_ssw13_5 acb50_ssw13_5 = _Acb50_ssw13_5(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Acb50_ssw13_6 acb50_ssw13_6 = _Acb50_ssw13_6(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Chgdrw_inout_tran chgdrw_inout_tran = _Chgdrw_inout_tran(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Chgdrw_loan_tran chgdrw_loan_tran = _Chgdrw_loan_tran(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );
}

@JsonSerializable()
class _Version {
  factory _Version.fromJson(Map<String, dynamic> json) => _$VersionFromJson(json);
  Map<String, dynamic> toJson() => _$VersionToJson(this);

  _Version({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "バージョン")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/version.json")
  String file;
  @JsonKey(defaultValue: "apl")
  String section;
  @JsonKey(defaultValue: "ver")
  String keyword;
}

@JsonSerializable()
class _Acr_cnct {
  factory _Acr_cnct.fromJson(Map<String, dynamic> json) => _$Acr_cnctFromJson(json);
  Map<String, dynamic> toJson() => _$Acr_cnctToJson(this);

  _Acr_cnct({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "自動釣銭釣札機接続")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "internal_flg")
  String section;
  @JsonKey(defaultValue: "acr_cnct")
  String keyword;
}

@JsonSerializable()
class _Acb_deccin {
  factory _Acb_deccin.fromJson(Map<String, dynamic> json) => _$Acb_deccinFromJson(json);
  Map<String, dynamic> toJson() => _$Acb_deccinToJson(this);

  _Acb_deccin({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣銭釣札機接続時の入金確定処理")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "internal_flg")
  String section;
  @JsonKey(defaultValue: "acb_deccin")
  String keyword;
}

@JsonSerializable()
class _Acb_select {
  factory _Acb_select.fromJson(Map<String, dynamic> json) => _$Acb_selectFromJson(json);
  Map<String, dynamic> toJson() => _$Acb_selectToJson(this);

  _Acb_select({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "自動釣銭釣札機の種類")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "internal_flg")
  String section;
  @JsonKey(defaultValue: "acb_select")
  String keyword;
}

@JsonSerializable()
class _Auto_deccin {
  factory _Auto_deccin.fromJson(Map<String, dynamic> json) => _$Auto_deccinFromJson(json);
  Map<String, dynamic> toJson() => _$Auto_deccinToJson(this);

  _Auto_deccin({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣銭釣札機モード変更")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "internal_flg")
  String section;
  @JsonKey(defaultValue: "auto_deccin")
  String keyword;
}

@JsonSerializable()
class _Acr50_ssw14_0 {
  factory _Acr50_ssw14_0.fromJson(Map<String, dynamic> json) => _$Acr50_ssw14_0FromJson(json);
  Map<String, dynamic> toJson() => _$Acr50_ssw14_0ToJson(this);

  _Acr50_ssw14_0({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "待機中スタートボタン押下による補充処理開始")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acr50_ssw14_0")
  String keyword;
}

@JsonSerializable()
class _Acr50_ssw14_1_2 {
  factory _Acr50_ssw14_1_2.fromJson(Map<String, dynamic> json) => _$Acr50_ssw14_1_2FromJson(json);
  Map<String, dynamic> toJson() => _$Acr50_ssw14_1_2ToJson(this);

  _Acr50_ssw14_1_2({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "鍵位置オぺ時の表示内容")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acr50_ssw14_1_2")
  String keyword;
}

@JsonSerializable()
class _Acr50_ssw14_3_4 {
  factory _Acr50_ssw14_3_4.fromJson(Map<String, dynamic> json) => _$Acr50_ssw14_3_4FromJson(json);
  Map<String, dynamic> toJson() => _$Acr50_ssw14_3_4ToJson(this);

  _Acr50_ssw14_3_4({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "鍵位置管理時の表示内容")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acr50_ssw14_3_4")
  String keyword;
}

@JsonSerializable()
class _Acr50_ssw14_5 {
  factory _Acr50_ssw14_5.fromJson(Map<String, dynamic> json) => _$Acr50_ssw14_5FromJson(json);
  Map<String, dynamic> toJson() => _$Acr50_ssw14_5ToJson(this);

  _Acr50_ssw14_5({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "補充処理開始")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acr50_ssw14_5")
  String keyword;
}

@JsonSerializable()
class _Acr50_ssw14_7 {
  factory _Acr50_ssw14_7.fromJson(Map<String, dynamic> json) => _$Acr50_ssw14_7FromJson(json);
  Map<String, dynamic> toJson() => _$Acr50_ssw14_7ToJson(this);

  _Acr50_ssw14_7({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "計数開始時の空転処理")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acr50_ssw14_7")
  String keyword;
}

@JsonSerializable()
class _Pick_end {
  factory _Pick_end.fromJson(Map<String, dynamic> json) => _$Pick_endFromJson(json);
  Map<String, dynamic> toJson() => _$Pick_endToJson(this);

  _Pick_end({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "回収作業終了待ち")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "pick_end")
  String keyword;
}

@JsonSerializable()
class _Acxreal_system {
  factory _Acxreal_system.fromJson(Map<String, dynamic> json) => _$Acxreal_systemFromJson(json);
  Map<String, dynamic> toJson() => _$Acxreal_systemToJson(this);

  _Acxreal_system({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣銭釣札機リアル問い合わせ")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acxreal_system")
  String keyword;
}

@JsonSerializable()
class _Acxreal_interval {
  factory _Acxreal_interval.fromJson(Map<String, dynamic> json) => _$Acxreal_intervalFromJson(json);
  Map<String, dynamic> toJson() => _$Acxreal_intervalToJson(this);

  _Acxreal_interval({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣銭釣札機　リアル問合せ間隔")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_timer")
  String section;
  @JsonKey(defaultValue: "acxreal_interval")
  String keyword;
}

@JsonSerializable()
class _Ecs_pick_positn10000 {
  factory _Ecs_pick_positn10000.fromJson(Map<String, dynamic> json) => _$Ecs_pick_positn10000FromJson(json);
  Map<String, dynamic> toJson() => _$Ecs_pick_positn10000ToJson(this);

  _Ecs_pick_positn10000({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "回収時紙幣搬送先設定　10000円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "ecs_pick_positn10000")
  String keyword;
}

@JsonSerializable()
class _Ecs_pick_positn5000 {
  factory _Ecs_pick_positn5000.fromJson(Map<String, dynamic> json) => _$Ecs_pick_positn5000FromJson(json);
  Map<String, dynamic> toJson() => _$Ecs_pick_positn5000ToJson(this);

  _Ecs_pick_positn5000({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "回収時紙幣搬送先設定　5000円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "ecs_pick_positn5000")
  String keyword;
}

@JsonSerializable()
class _Ecs_pick_positn2000 {
  factory _Ecs_pick_positn2000.fromJson(Map<String, dynamic> json) => _$Ecs_pick_positn2000FromJson(json);
  Map<String, dynamic> toJson() => _$Ecs_pick_positn2000ToJson(this);

  _Ecs_pick_positn2000({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "回収時紙幣搬送先設定　2000円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "ecs_pick_positn2000")
  String keyword;
}

@JsonSerializable()
class _Ecs_pick_positn1000 {
  factory _Ecs_pick_positn1000.fromJson(Map<String, dynamic> json) => _$Ecs_pick_positn1000FromJson(json);
  Map<String, dynamic> toJson() => _$Ecs_pick_positn1000ToJson(this);

  _Ecs_pick_positn1000({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "回収時紙幣搬送先設定　1000円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "ecs_pick_positn1000")
  String keyword;
}

@JsonSerializable()
class _Acx_pick_data10000 {
  factory _Acx_pick_data10000.fromJson(Map<String, dynamic> json) => _$Acx_pick_data10000FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_pick_data10000ToJson(this);

  _Acx_pick_data10000({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機回収ユーザー設定枚数　10000円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_pick_data10000")
  String keyword;
}

@JsonSerializable()
class _Acx_pick_data5000 {
  factory _Acx_pick_data5000.fromJson(Map<String, dynamic> json) => _$Acx_pick_data5000FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_pick_data5000ToJson(this);

  _Acx_pick_data5000({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機回収ユーザー設定枚数　5000円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_pick_data5000")
  String keyword;
}

@JsonSerializable()
class _Acx_pick_data2000 {
  factory _Acx_pick_data2000.fromJson(Map<String, dynamic> json) => _$Acx_pick_data2000FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_pick_data2000ToJson(this);

  _Acx_pick_data2000({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機回収ユーザー設定枚数　2000円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_pick_data2000")
  String keyword;
}

@JsonSerializable()
class _Acx_pick_data1000 {
  factory _Acx_pick_data1000.fromJson(Map<String, dynamic> json) => _$Acx_pick_data1000FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_pick_data1000ToJson(this);

  _Acx_pick_data1000({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機回収ユーザー設定枚数　1000円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_pick_data1000")
  String keyword;
}

@JsonSerializable()
class _Acx_pick_data500 {
  factory _Acx_pick_data500.fromJson(Map<String, dynamic> json) => _$Acx_pick_data500FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_pick_data500ToJson(this);

  _Acx_pick_data500({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機回収ユーザー設定枚数　500円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_pick_data500")
  String keyword;
}

@JsonSerializable()
class _Acx_pick_data100 {
  factory _Acx_pick_data100.fromJson(Map<String, dynamic> json) => _$Acx_pick_data100FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_pick_data100ToJson(this);

  _Acx_pick_data100({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機回収ユーザー設定枚数　100円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_pick_data100")
  String keyword;
}

@JsonSerializable()
class _Acx_pick_data50 {
  factory _Acx_pick_data50.fromJson(Map<String, dynamic> json) => _$Acx_pick_data50FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_pick_data50ToJson(this);

  _Acx_pick_data50({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機回収ユーザー設定枚数　50円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_pick_data50")
  String keyword;
}

@JsonSerializable()
class _Acx_pick_data10 {
  factory _Acx_pick_data10.fromJson(Map<String, dynamic> json) => _$Acx_pick_data10FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_pick_data10ToJson(this);

  _Acx_pick_data10({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機回収ユーザー設定枚数　10円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_pick_data10")
  String keyword;
}

@JsonSerializable()
class _Acx_pick_data5 {
  factory _Acx_pick_data5.fromJson(Map<String, dynamic> json) => _$Acx_pick_data5FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_pick_data5ToJson(this);

  _Acx_pick_data5({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機回収ユーザー設定枚数　5円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_pick_data5")
  String keyword;
}

@JsonSerializable()
class _Acx_pick_data1 {
  factory _Acx_pick_data1.fromJson(Map<String, dynamic> json) => _$Acx_pick_data1FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_pick_data1ToJson(this);

  _Acx_pick_data1({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機回収ユーザー設定枚数　1円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_pick_data1")
  String keyword;
}

@JsonSerializable()
class _Ecs_recalc_reject {
  factory _Ecs_recalc_reject.fromJson(Map<String, dynamic> json) => _$Ecs_recalc_rejectFromJson(json);
  Map<String, dynamic> toJson() => _$Ecs_recalc_rejectToJson(this);

  _Ecs_recalc_reject({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "精査終了時のﾘｼﾞｪｸﾄ貨幣発生時の動作")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "ecs_recalc_reject")
  String keyword;
}

@JsonSerializable()
class _Sst1_error_disp {
  factory _Sst1_error_disp.fromJson(Map<String, dynamic> json) => _$Sst1_error_dispFromJson(json);
  Map<String, dynamic> toJson() => _$Sst1_error_dispToJson(this);

  _Sst1_error_disp({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "エラー復旧手順画面表示")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "sst1_error_disp")
  String keyword;
}

@JsonSerializable()
class _Sst1_cin_retry {
  factory _Sst1_cin_retry.fromJson(Map<String, dynamic> json) => _$Sst1_cin_retryFromJson(json);
  Map<String, dynamic> toJson() => _$Sst1_cin_retryToJson(this);

  _Sst1_cin_retry({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "硬貨入金時の投入口繰り出し不良リトライ回数")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "sst1_cin_retry")
  String keyword;
}

@JsonSerializable()
class _Acx_resv_min5000 {
  factory _Acx_resv_min5000.fromJson(Map<String, dynamic> json) => _$Acx_resv_min5000FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_resv_min5000ToJson(this);

  _Acx_resv_min5000({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機最低必要枚数　5000円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_resv_min5000")
  String keyword;
}

@JsonSerializable()
class _Acx_resv_min2000 {
  factory _Acx_resv_min2000.fromJson(Map<String, dynamic> json) => _$Acx_resv_min2000FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_resv_min2000ToJson(this);

  _Acx_resv_min2000({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機最低必要枚数　2000円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_resv_min2000")
  String keyword;
}

@JsonSerializable()
class _Acx_resv_min1000 {
  factory _Acx_resv_min1000.fromJson(Map<String, dynamic> json) => _$Acx_resv_min1000FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_resv_min1000ToJson(this);

  _Acx_resv_min1000({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機最低必要枚数　1000円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_resv_min1000")
  String keyword;
}

@JsonSerializable()
class _Acx_resv_min500 {
  factory _Acx_resv_min500.fromJson(Map<String, dynamic> json) => _$Acx_resv_min500FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_resv_min500ToJson(this);

  _Acx_resv_min500({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機最低必要枚数　500円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_resv_min500")
  String keyword;
}

@JsonSerializable()
class _Acx_resv_min100 {
  factory _Acx_resv_min100.fromJson(Map<String, dynamic> json) => _$Acx_resv_min100FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_resv_min100ToJson(this);

  _Acx_resv_min100({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機最低必要枚数　100円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_resv_min100")
  String keyword;
}

@JsonSerializable()
class _Acx_resv_min50 {
  factory _Acx_resv_min50.fromJson(Map<String, dynamic> json) => _$Acx_resv_min50FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_resv_min50ToJson(this);

  _Acx_resv_min50({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機最低必要枚数　50円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_resv_min50")
  String keyword;
}

@JsonSerializable()
class _Acx_resv_min10 {
  factory _Acx_resv_min10.fromJson(Map<String, dynamic> json) => _$Acx_resv_min10FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_resv_min10ToJson(this);

  _Acx_resv_min10({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機最低必要枚数　10円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_resv_min10")
  String keyword;
}

@JsonSerializable()
class _Acx_resv_min5 {
  factory _Acx_resv_min5.fromJson(Map<String, dynamic> json) => _$Acx_resv_min5FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_resv_min5ToJson(this);

  _Acx_resv_min5({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機最低必要枚数　5円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_resv_min5")
  String keyword;
}

@JsonSerializable()
class _Acx_resv_min1 {
  factory _Acx_resv_min1.fromJson(Map<String, dynamic> json) => _$Acx_resv_min1FromJson(json);
  Map<String, dynamic> toJson() => _$Acx_resv_min1ToJson(this);

  _Acx_resv_min1({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣機最低必要枚数　1円")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acx_resv_min1")
  String keyword;
}

@JsonSerializable()
class _Acb50_ssw13_0 {
  factory _Acb50_ssw13_0.fromJson(Map<String, dynamic> json) => _$Acb50_ssw13_0FromJson(json);
  Map<String, dynamic> toJson() => _$Acb50_ssw13_0ToJson(this);

  _Acb50_ssw13_0({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "棒金接続")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acb50_ssw13_0")
  String keyword;
}

@JsonSerializable()
class _Acb50_ssw13_1_2 {
  factory _Acb50_ssw13_1_2.fromJson(Map<String, dynamic> json) => _$Acb50_ssw13_1_2FromJson(json);
  Map<String, dynamic> toJson() => _$Acb50_ssw13_1_2ToJson(this);

  _Acb50_ssw13_1_2({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ドロア開設定")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acb50_ssw13_1_2")
  String keyword;
}

@JsonSerializable()
class _Acb50_ssw13_3_4 {
  factory _Acb50_ssw13_3_4.fromJson(Map<String, dynamic> json) => _$Acb50_ssw13_3_4FromJson(json);
  Map<String, dynamic> toJson() => _$Acb50_ssw13_3_4ToJson(this);

  _Acb50_ssw13_3_4({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "精査フォーマット")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acb50_ssw13_3_4")
  String keyword;
}

@JsonSerializable()
class _Acb50_ssw13_5 {
  factory _Acb50_ssw13_5.fromJson(Map<String, dynamic> json) => _$Acb50_ssw13_5FromJson(json);
  Map<String, dynamic> toJson() => _$Acb50_ssw13_5ToJson(this);

  _Acb50_ssw13_5({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "500円棒金巻き数")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acb50_ssw13_5")
  String keyword;
}

@JsonSerializable()
class _Acb50_ssw13_6 {
  factory _Acb50_ssw13_6.fromJson(Map<String, dynamic> json) => _$Acb50_ssw13_6FromJson(json);
  Map<String, dynamic> toJson() => _$Acb50_ssw13_6ToJson(this);

  _Acb50_ssw13_6({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "棒金連動残置")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "acb50_ssw13_6")
  String keyword;
}

@JsonSerializable()
class _Chgdrw_inout_tran {
  factory _Chgdrw_inout_tran.fromJson(Map<String, dynamic> json) => _$Chgdrw_inout_tranFromJson(json);
  Map<String, dynamic> toJson() => _$Chgdrw_inout_tranToJson(this);

  _Chgdrw_inout_tran({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "棒金開キーでの在高増減を実績加算")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "chgdrw_inout_tran")
  String keyword;
}

@JsonSerializable()
class _Chgdrw_loan_tran {
  factory _Chgdrw_loan_tran.fromJson(Map<String, dynamic> json) => _$Chgdrw_loan_tranFromJson(json);
  Map<String, dynamic> toJson() => _$Chgdrw_loan_tranToJson(this);

  _Chgdrw_loan_tran({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "釣準備キーでの在高取得時、棒金ドロア在高を加算")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "acx_flg")
  String section;
  @JsonKey(defaultValue: "chgdrw_loan_tran")
  String keyword;
}

