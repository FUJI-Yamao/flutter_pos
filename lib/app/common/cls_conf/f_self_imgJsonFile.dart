/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'f_self_imgJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class F_self_imgJsonFile extends ConfigJsonFile {
  static final F_self_imgJsonFile _instance = F_self_imgJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "f_self_img.json";

  F_self_imgJsonFile(){
    setPath(_confPath, _fileName);
  }
  F_self_imgJsonFile._internal();

  factory F_self_imgJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$F_self_imgJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$F_self_imgJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$F_self_imgJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        org_ini_name = _$Org_ini_nameFromJson(jsonD['org_ini_name']);
      } catch(e) {
        org_ini_name = _$Org_ini_nameFromJson({});
        ret = false;
      }
      try {
        png_name = _$Png_nameFromJson(jsonD['png_name']);
      } catch(e) {
        png_name = _$Png_nameFromJson({});
        ret = false;
      }
      try {
        all_offset = _$All_offsetFromJson(jsonD['all_offset']);
      } catch(e) {
        all_offset = _$All_offsetFromJson({});
        ret = false;
      }
      try {
        avi_size = _$Avi_sizeFromJson(jsonD['avi_size']);
      } catch(e) {
        avi_size = _$Avi_sizeFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Org_ini_name org_ini_name = _Org_ini_name(
    img_no                             : "",
  );

  _Png_name png_name = _Png_name(
    image_start_name                   : 0,
    image_bese_name                    : "",
    image_item_name                    : "",
    image_itembig_name                 : "",
    image_list3_name                   : "",
    image_subtotal_name                : "",
    image_total_name                   : "",
    image_totalbig_name                : "",
    image_ttl_off_name                 : "",
    image_ttl_ok_name                  : "",
    image_ttl_total_name               : "",
    image_ttl_unpaid_name              : "",
    image_txt_name                     : "",
    image_itemanytime_name             : "",
    image_totalbig_anytime_name        : "",
    image_btn_bigcheck_1_name          : "",
    image_btn_bigcheck_2_name          : "",
    image_btn_bigcheck_down_name       : "",
    image_btn_check_1_name             : "",
    image_btn_check_2_name             : "",
    image_btn_check_down_name          : "",
    image_btn_norcpt_1_name            : "",
    image_btn_norcpt_2_name            : "",
    image_btn_norcpt_down_name         : "",
    image_btn_receipt_1_name           : "",
    image_btn_receipt_2_name           : "",
    image_btn_receipt_down_name        : "",
    image_btn_minicheck_1_name         : "",
    image_btn_minicheck_2_name         : "",
    image_btn_minicheck_down_name      : "",
    image_btn_mini_norcpt_1_name       : "",
    image_btn_mini_norcpt_2_name       : "",
    image_btn_mini_norcpt_down_name    : "",
    image_btn_mini_receipt_1_name      : "",
    image_btn_mini_receipt_2_name      : "",
    image_btn_mini_receipt_down_name   : "",
  );

  _All_offset all_offset = _All_offset(
    offset_zero_x                      : 0,
    offset_zero_y                      : 0,
    offset_list_item_main_x            : 0,
    offset_list_item_main_y            : 0,
    offset_list_item_tend_x            : 0,
    offset_list_item_tend_y            : 0,
    offset_item_tend_x                 : 0,
    offset_item_tend_y                 : 0,
    offset_stl1_cashin_x               : 0,
    offset_stl1_cashin_y               : 0,
    offset_stl2_tend_x                 : 0,
    offset_stl2_tend_y                 : 0,
    offset_stl2_chg_x                  : 0,
    offset_stl2_chg_y                  : 0,
    offset_message_x                   : 0,
    offset_message_y                   : 0,
    offset_btn1_x                      : 0,
    offset_btn1_y                      : 0,
    offset_btn2_x                      : 0,
    offset_btn2_y                      : 0,
    offset_btn3_x                      : 0,
    offset_btn3_y                      : 0,
    offset_btn4_x                      : 0,
    offset_btn4_y                      : 0,
    offset_item_anytime_tend_x         : 0,
    offset_item_anytime_tend_y         : 0,
    offset_lang_btn_x                  : 0,
    offset_lang_btn_y                  : 0,
    offset_explain_x                   : 0,
    offset_translate_x                 : 0,
    offset_translate_y                 : 0,
  );

  _Avi_size avi_size = _Avi_size(
    movie_normal_w                     : 0,
    movie_normal_h                     : 0,
    movie_cashin_w                     : 0,
    movie_cashin_h                     : 0,
    movie_cashinout_w                  : 0,
    movie_cashinout_h                  : 0,
  );
}

@JsonSerializable()
class _Org_ini_name {
  factory _Org_ini_name.fromJson(Map<String, dynamic> json) => _$Org_ini_nameFromJson(json);
  Map<String, dynamic> toJson() => _$Org_ini_nameToJson(this);

  _Org_ini_name({
    required this.img_no,
  });

  @JsonKey(defaultValue: "f_self_img1")
  String img_no;
}

@JsonSerializable()
class _Png_name {
  factory _Png_name.fromJson(Map<String, dynamic> json) => _$Png_nameFromJson(json);
  Map<String, dynamic> toJson() => _$Png_nameToJson(this);

  _Png_name({
    required this.image_start_name,
    required this.image_bese_name,
    required this.image_item_name,
    required this.image_itembig_name,
    required this.image_list3_name,
    required this.image_subtotal_name,
    required this.image_total_name,
    required this.image_totalbig_name,
    required this.image_ttl_off_name,
    required this.image_ttl_ok_name,
    required this.image_ttl_total_name,
    required this.image_ttl_unpaid_name,
    required this.image_txt_name,
    required this.image_itemanytime_name,
    required this.image_totalbig_anytime_name,
    required this.image_btn_bigcheck_1_name,
    required this.image_btn_bigcheck_2_name,
    required this.image_btn_bigcheck_down_name,
    required this.image_btn_check_1_name,
    required this.image_btn_check_2_name,
    required this.image_btn_check_down_name,
    required this.image_btn_norcpt_1_name,
    required this.image_btn_norcpt_2_name,
    required this.image_btn_norcpt_down_name,
    required this.image_btn_receipt_1_name,
    required this.image_btn_receipt_2_name,
    required this.image_btn_receipt_down_name,
    required this.image_btn_minicheck_1_name,
    required this.image_btn_minicheck_2_name,
    required this.image_btn_minicheck_down_name,
    required this.image_btn_mini_norcpt_1_name,
    required this.image_btn_mini_norcpt_2_name,
    required this.image_btn_mini_norcpt_down_name,
    required this.image_btn_mini_receipt_1_name,
    required this.image_btn_mini_receipt_2_name,
    required this.image_btn_mini_receipt_down_name,
  });

  @JsonKey(defaultValue: 1)
  int    image_start_name;
  @JsonKey(defaultValue: "base.png")
  String image_bese_name;
  @JsonKey(defaultValue: "item.png")
  String image_item_name;
  @JsonKey(defaultValue: "itembig.png")
  String image_itembig_name;
  @JsonKey(defaultValue: "list3.png")
  String image_list3_name;
  @JsonKey(defaultValue: "subtotal.png")
  String image_subtotal_name;
  @JsonKey(defaultValue: "total.png")
  String image_total_name;
  @JsonKey(defaultValue: "totalbig.png")
  String image_totalbig_name;
  @JsonKey(defaultValue: "ttl_off.png")
  String image_ttl_off_name;
  @JsonKey(defaultValue: "ttl_ok.png")
  String image_ttl_ok_name;
  @JsonKey(defaultValue: "ttl_total.png")
  String image_ttl_total_name;
  @JsonKey(defaultValue: "ttl_unpaid.png")
  String image_ttl_unpaid_name;
  @JsonKey(defaultValue: "txt.png")
  String image_txt_name;
  @JsonKey(defaultValue: "item_anytime.png")
  String image_itemanytime_name;
  @JsonKey(defaultValue: "totalbig_anytime.png")
  String image_totalbig_anytime_name;
  @JsonKey(defaultValue: "btn_bigcheck_1.png")
  String image_btn_bigcheck_1_name;
  @JsonKey(defaultValue: "btn_bigcheck_2.png")
  String image_btn_bigcheck_2_name;
  @JsonKey(defaultValue: "btn_bigcheck_down.png")
  String image_btn_bigcheck_down_name;
  @JsonKey(defaultValue: "btn_check_1.png")
  String image_btn_check_1_name;
  @JsonKey(defaultValue: "btn_check_2.png")
  String image_btn_check_2_name;
  @JsonKey(defaultValue: "btn_check_down.png")
  String image_btn_check_down_name;
  @JsonKey(defaultValue: "btn_norcpt_1.png")
  String image_btn_norcpt_1_name;
  @JsonKey(defaultValue: "btn_norcpt_1.png")
  String image_btn_norcpt_2_name;
  @JsonKey(defaultValue: "btn_norcpt_down.png")
  String image_btn_norcpt_down_name;
  @JsonKey(defaultValue: "btn_rcpt_1.png")
  String image_btn_receipt_1_name;
  @JsonKey(defaultValue: "btn_rcpt_1.png")
  String image_btn_receipt_2_name;
  @JsonKey(defaultValue: "btn_rcpt_down.png")
  String image_btn_receipt_down_name;
  @JsonKey(defaultValue: "btn_minicheck_1.png")
  String image_btn_minicheck_1_name;
  @JsonKey(defaultValue: "btn_minicheck_2.png")
  String image_btn_minicheck_2_name;
  @JsonKey(defaultValue: "btn_minicheck_down.png")
  String image_btn_minicheck_down_name;
  @JsonKey(defaultValue: "btn_right_1.png")
  String image_btn_mini_norcpt_1_name;
  @JsonKey(defaultValue: "btn_right_1.png")
  String image_btn_mini_norcpt_2_name;
  @JsonKey(defaultValue: "btn_right_down.png")
  String image_btn_mini_norcpt_down_name;
  @JsonKey(defaultValue: "btn_left_1.png")
  String image_btn_mini_receipt_1_name;
  @JsonKey(defaultValue: "btn_left_1.png")
  String image_btn_mini_receipt_2_name;
  @JsonKey(defaultValue: "btn_left_down.png")
  String image_btn_mini_receipt_down_name;
}

@JsonSerializable()
class _All_offset {
  factory _All_offset.fromJson(Map<String, dynamic> json) => _$All_offsetFromJson(json);
  Map<String, dynamic> toJson() => _$All_offsetToJson(this);

  _All_offset({
    required this.offset_zero_x,
    required this.offset_zero_y,
    required this.offset_list_item_main_x,
    required this.offset_list_item_main_y,
    required this.offset_list_item_tend_x,
    required this.offset_list_item_tend_y,
    required this.offset_item_tend_x,
    required this.offset_item_tend_y,
    required this.offset_stl1_cashin_x,
    required this.offset_stl1_cashin_y,
    required this.offset_stl2_tend_x,
    required this.offset_stl2_tend_y,
    required this.offset_stl2_chg_x,
    required this.offset_stl2_chg_y,
    required this.offset_message_x,
    required this.offset_message_y,
    required this.offset_btn1_x,
    required this.offset_btn1_y,
    required this.offset_btn2_x,
    required this.offset_btn2_y,
    required this.offset_btn3_x,
    required this.offset_btn3_y,
    required this.offset_btn4_x,
    required this.offset_btn4_y,
    required this.offset_item_anytime_tend_x,
    required this.offset_item_anytime_tend_y,
    required this.offset_lang_btn_x,
    required this.offset_lang_btn_y,
    required this.offset_explain_x,
    required this.offset_translate_x,
    required this.offset_translate_y,
  });

  @JsonKey(defaultValue: 0)
  int    offset_zero_x;
  @JsonKey(defaultValue: 0)
  int    offset_zero_y;
  @JsonKey(defaultValue: 0)
  int    offset_list_item_main_x;
  @JsonKey(defaultValue: 150)
  int    offset_list_item_main_y;
  @JsonKey(defaultValue: 0)
  int    offset_list_item_tend_x;
  @JsonKey(defaultValue: 370)
  int    offset_list_item_tend_y;
  @JsonKey(defaultValue: 0)
  int    offset_item_tend_x;
  @JsonKey(defaultValue: 240)
  int    offset_item_tend_y;
  @JsonKey(defaultValue: 0)
  int    offset_stl1_cashin_x;
  @JsonKey(defaultValue: 190)
  int    offset_stl1_cashin_y;
  @JsonKey(defaultValue: 0)
  int    offset_stl2_tend_x;
  @JsonKey(defaultValue: 120)
  int    offset_stl2_tend_y;
  @JsonKey(defaultValue: 0)
  int    offset_stl2_chg_x;
  @JsonKey(defaultValue: 244)
  int    offset_stl2_chg_y;
  @JsonKey(defaultValue: 0)
  int    offset_message_x;
  @JsonKey(defaultValue: 390)
  int    offset_message_y;
  @JsonKey(defaultValue: 508)
  int    offset_btn1_x;
  @JsonKey(defaultValue: 0)
  int    offset_btn1_y;
  @JsonKey(defaultValue: 508)
  int    offset_btn2_x;
  @JsonKey(defaultValue: 245)
  int    offset_btn2_y;
  @JsonKey(defaultValue: 508)
  int    offset_btn3_x;
  @JsonKey(defaultValue: 236)
  int    offset_btn3_y;
  @JsonKey(defaultValue: 640)
  int    offset_btn4_x;
  @JsonKey(defaultValue: 236)
  int    offset_btn4_y;
  @JsonKey(defaultValue: 0)
  int    offset_item_anytime_tend_x;
  @JsonKey(defaultValue: 120)
  int    offset_item_anytime_tend_y;
  @JsonKey(defaultValue: 0)
  int    offset_lang_btn_x;
  @JsonKey(defaultValue: 407)
  int    offset_lang_btn_y;
  @JsonKey(defaultValue: 28)
  int    offset_explain_x;
  @JsonKey(defaultValue: 0)
  int    offset_translate_x;
  @JsonKey(defaultValue: 390)
  int    offset_translate_y;
}

@JsonSerializable()
class _Avi_size {
  factory _Avi_size.fromJson(Map<String, dynamic> json) => _$Avi_sizeFromJson(json);
  Map<String, dynamic> toJson() => _$Avi_sizeToJson(this);

  _Avi_size({
    required this.movie_normal_w,
    required this.movie_normal_h,
    required this.movie_cashin_w,
    required this.movie_cashin_h,
    required this.movie_cashinout_w,
    required this.movie_cashinout_h,
  });

  @JsonKey(defaultValue: 800)
  int    movie_normal_w;
  @JsonKey(defaultValue: 390)
  int    movie_normal_h;
  @JsonKey(defaultValue: 800)
  int    movie_cashin_w;
  @JsonKey(defaultValue: 200)
  int    movie_cashin_h;
  @JsonKey(defaultValue: 292)
  int    movie_cashinout_w;
  @JsonKey(defaultValue: 390)
  int    movie_cashinout_h;
}

