// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'f_self_imgJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

F_self_imgJsonFile _$F_self_imgJsonFileFromJson(Map<String, dynamic> json) =>
    F_self_imgJsonFile()
      ..org_ini_name =
          _Org_ini_name.fromJson(json['org_ini_name'] as Map<String, dynamic>)
      ..png_name = _Png_name.fromJson(json['png_name'] as Map<String, dynamic>)
      ..all_offset =
          _All_offset.fromJson(json['all_offset'] as Map<String, dynamic>)
      ..avi_size = _Avi_size.fromJson(json['avi_size'] as Map<String, dynamic>);

Map<String, dynamic> _$F_self_imgJsonFileToJson(F_self_imgJsonFile instance) =>
    <String, dynamic>{
      'org_ini_name': instance.org_ini_name.toJson(),
      'png_name': instance.png_name.toJson(),
      'all_offset': instance.all_offset.toJson(),
      'avi_size': instance.avi_size.toJson(),
    };

_Org_ini_name _$Org_ini_nameFromJson(Map<String, dynamic> json) =>
    _Org_ini_name(
      img_no: json['img_no'] as String? ?? 'f_self_img1',
    );

Map<String, dynamic> _$Org_ini_nameToJson(_Org_ini_name instance) =>
    <String, dynamic>{
      'img_no': instance.img_no,
    };

_Png_name _$Png_nameFromJson(Map<String, dynamic> json) => _Png_name(
      image_start_name: json['image_start_name'] as int? ?? 1,
      image_bese_name: json['image_bese_name'] as String? ?? 'base.png',
      image_item_name: json['image_item_name'] as String? ?? 'item.png',
      image_itembig_name:
          json['image_itembig_name'] as String? ?? 'itembig.png',
      image_list3_name: json['image_list3_name'] as String? ?? 'list3.png',
      image_subtotal_name:
          json['image_subtotal_name'] as String? ?? 'subtotal.png',
      image_total_name: json['image_total_name'] as String? ?? 'total.png',
      image_totalbig_name:
          json['image_totalbig_name'] as String? ?? 'totalbig.png',
      image_ttl_off_name:
          json['image_ttl_off_name'] as String? ?? 'ttl_off.png',
      image_ttl_ok_name: json['image_ttl_ok_name'] as String? ?? 'ttl_ok.png',
      image_ttl_total_name:
          json['image_ttl_total_name'] as String? ?? 'ttl_total.png',
      image_ttl_unpaid_name:
          json['image_ttl_unpaid_name'] as String? ?? 'ttl_unpaid.png',
      image_txt_name: json['image_txt_name'] as String? ?? 'txt.png',
      image_itemanytime_name:
          json['image_itemanytime_name'] as String? ?? 'item_anytime.png',
      image_totalbig_anytime_name:
          json['image_totalbig_anytime_name'] as String? ??
              'totalbig_anytime.png',
      image_btn_bigcheck_1_name:
          json['image_btn_bigcheck_1_name'] as String? ?? 'btn_bigcheck_1.png',
      image_btn_bigcheck_2_name:
          json['image_btn_bigcheck_2_name'] as String? ?? 'btn_bigcheck_2.png',
      image_btn_bigcheck_down_name:
          json['image_btn_bigcheck_down_name'] as String? ??
              'btn_bigcheck_down.png',
      image_btn_check_1_name:
          json['image_btn_check_1_name'] as String? ?? 'btn_check_1.png',
      image_btn_check_2_name:
          json['image_btn_check_2_name'] as String? ?? 'btn_check_2.png',
      image_btn_check_down_name:
          json['image_btn_check_down_name'] as String? ?? 'btn_check_down.png',
      image_btn_norcpt_1_name:
          json['image_btn_norcpt_1_name'] as String? ?? 'btn_norcpt_1.png',
      image_btn_norcpt_2_name:
          json['image_btn_norcpt_2_name'] as String? ?? 'btn_norcpt_1.png',
      image_btn_norcpt_down_name:
          json['image_btn_norcpt_down_name'] as String? ??
              'btn_norcpt_down.png',
      image_btn_receipt_1_name:
          json['image_btn_receipt_1_name'] as String? ?? 'btn_rcpt_1.png',
      image_btn_receipt_2_name:
          json['image_btn_receipt_2_name'] as String? ?? 'btn_rcpt_1.png',
      image_btn_receipt_down_name:
          json['image_btn_receipt_down_name'] as String? ?? 'btn_rcpt_down.png',
      image_btn_minicheck_1_name:
          json['image_btn_minicheck_1_name'] as String? ??
              'btn_minicheck_1.png',
      image_btn_minicheck_2_name:
          json['image_btn_minicheck_2_name'] as String? ??
              'btn_minicheck_2.png',
      image_btn_minicheck_down_name:
          json['image_btn_minicheck_down_name'] as String? ??
              'btn_minicheck_down.png',
      image_btn_mini_norcpt_1_name:
          json['image_btn_mini_norcpt_1_name'] as String? ?? 'btn_right_1.png',
      image_btn_mini_norcpt_2_name:
          json['image_btn_mini_norcpt_2_name'] as String? ?? 'btn_right_1.png',
      image_btn_mini_norcpt_down_name:
          json['image_btn_mini_norcpt_down_name'] as String? ??
              'btn_right_down.png',
      image_btn_mini_receipt_1_name:
          json['image_btn_mini_receipt_1_name'] as String? ?? 'btn_left_1.png',
      image_btn_mini_receipt_2_name:
          json['image_btn_mini_receipt_2_name'] as String? ?? 'btn_left_1.png',
      image_btn_mini_receipt_down_name:
          json['image_btn_mini_receipt_down_name'] as String? ??
              'btn_left_down.png',
    );

Map<String, dynamic> _$Png_nameToJson(_Png_name instance) => <String, dynamic>{
      'image_start_name': instance.image_start_name,
      'image_bese_name': instance.image_bese_name,
      'image_item_name': instance.image_item_name,
      'image_itembig_name': instance.image_itembig_name,
      'image_list3_name': instance.image_list3_name,
      'image_subtotal_name': instance.image_subtotal_name,
      'image_total_name': instance.image_total_name,
      'image_totalbig_name': instance.image_totalbig_name,
      'image_ttl_off_name': instance.image_ttl_off_name,
      'image_ttl_ok_name': instance.image_ttl_ok_name,
      'image_ttl_total_name': instance.image_ttl_total_name,
      'image_ttl_unpaid_name': instance.image_ttl_unpaid_name,
      'image_txt_name': instance.image_txt_name,
      'image_itemanytime_name': instance.image_itemanytime_name,
      'image_totalbig_anytime_name': instance.image_totalbig_anytime_name,
      'image_btn_bigcheck_1_name': instance.image_btn_bigcheck_1_name,
      'image_btn_bigcheck_2_name': instance.image_btn_bigcheck_2_name,
      'image_btn_bigcheck_down_name': instance.image_btn_bigcheck_down_name,
      'image_btn_check_1_name': instance.image_btn_check_1_name,
      'image_btn_check_2_name': instance.image_btn_check_2_name,
      'image_btn_check_down_name': instance.image_btn_check_down_name,
      'image_btn_norcpt_1_name': instance.image_btn_norcpt_1_name,
      'image_btn_norcpt_2_name': instance.image_btn_norcpt_2_name,
      'image_btn_norcpt_down_name': instance.image_btn_norcpt_down_name,
      'image_btn_receipt_1_name': instance.image_btn_receipt_1_name,
      'image_btn_receipt_2_name': instance.image_btn_receipt_2_name,
      'image_btn_receipt_down_name': instance.image_btn_receipt_down_name,
      'image_btn_minicheck_1_name': instance.image_btn_minicheck_1_name,
      'image_btn_minicheck_2_name': instance.image_btn_minicheck_2_name,
      'image_btn_minicheck_down_name': instance.image_btn_minicheck_down_name,
      'image_btn_mini_norcpt_1_name': instance.image_btn_mini_norcpt_1_name,
      'image_btn_mini_norcpt_2_name': instance.image_btn_mini_norcpt_2_name,
      'image_btn_mini_norcpt_down_name':
          instance.image_btn_mini_norcpt_down_name,
      'image_btn_mini_receipt_1_name': instance.image_btn_mini_receipt_1_name,
      'image_btn_mini_receipt_2_name': instance.image_btn_mini_receipt_2_name,
      'image_btn_mini_receipt_down_name':
          instance.image_btn_mini_receipt_down_name,
    };

_All_offset _$All_offsetFromJson(Map<String, dynamic> json) => _All_offset(
      offset_zero_x: json['offset_zero_x'] as int? ?? 0,
      offset_zero_y: json['offset_zero_y'] as int? ?? 0,
      offset_list_item_main_x: json['offset_list_item_main_x'] as int? ?? 0,
      offset_list_item_main_y: json['offset_list_item_main_y'] as int? ?? 150,
      offset_list_item_tend_x: json['offset_list_item_tend_x'] as int? ?? 0,
      offset_list_item_tend_y: json['offset_list_item_tend_y'] as int? ?? 370,
      offset_item_tend_x: json['offset_item_tend_x'] as int? ?? 0,
      offset_item_tend_y: json['offset_item_tend_y'] as int? ?? 240,
      offset_stl1_cashin_x: json['offset_stl1_cashin_x'] as int? ?? 0,
      offset_stl1_cashin_y: json['offset_stl1_cashin_y'] as int? ?? 190,
      offset_stl2_tend_x: json['offset_stl2_tend_x'] as int? ?? 0,
      offset_stl2_tend_y: json['offset_stl2_tend_y'] as int? ?? 120,
      offset_stl2_chg_x: json['offset_stl2_chg_x'] as int? ?? 0,
      offset_stl2_chg_y: json['offset_stl2_chg_y'] as int? ?? 244,
      offset_message_x: json['offset_message_x'] as int? ?? 0,
      offset_message_y: json['offset_message_y'] as int? ?? 390,
      offset_btn1_x: json['offset_btn1_x'] as int? ?? 508,
      offset_btn1_y: json['offset_btn1_y'] as int? ?? 0,
      offset_btn2_x: json['offset_btn2_x'] as int? ?? 508,
      offset_btn2_y: json['offset_btn2_y'] as int? ?? 245,
      offset_btn3_x: json['offset_btn3_x'] as int? ?? 508,
      offset_btn3_y: json['offset_btn3_y'] as int? ?? 236,
      offset_btn4_x: json['offset_btn4_x'] as int? ?? 640,
      offset_btn4_y: json['offset_btn4_y'] as int? ?? 236,
      offset_item_anytime_tend_x:
          json['offset_item_anytime_tend_x'] as int? ?? 0,
      offset_item_anytime_tend_y:
          json['offset_item_anytime_tend_y'] as int? ?? 120,
      offset_lang_btn_x: json['offset_lang_btn_x'] as int? ?? 0,
      offset_lang_btn_y: json['offset_lang_btn_y'] as int? ?? 407,
      offset_explain_x: json['offset_explain_x'] as int? ?? 28,
      offset_translate_x: json['offset_translate_x'] as int? ?? 0,
      offset_translate_y: json['offset_translate_y'] as int? ?? 390,
    );

Map<String, dynamic> _$All_offsetToJson(_All_offset instance) =>
    <String, dynamic>{
      'offset_zero_x': instance.offset_zero_x,
      'offset_zero_y': instance.offset_zero_y,
      'offset_list_item_main_x': instance.offset_list_item_main_x,
      'offset_list_item_main_y': instance.offset_list_item_main_y,
      'offset_list_item_tend_x': instance.offset_list_item_tend_x,
      'offset_list_item_tend_y': instance.offset_list_item_tend_y,
      'offset_item_tend_x': instance.offset_item_tend_x,
      'offset_item_tend_y': instance.offset_item_tend_y,
      'offset_stl1_cashin_x': instance.offset_stl1_cashin_x,
      'offset_stl1_cashin_y': instance.offset_stl1_cashin_y,
      'offset_stl2_tend_x': instance.offset_stl2_tend_x,
      'offset_stl2_tend_y': instance.offset_stl2_tend_y,
      'offset_stl2_chg_x': instance.offset_stl2_chg_x,
      'offset_stl2_chg_y': instance.offset_stl2_chg_y,
      'offset_message_x': instance.offset_message_x,
      'offset_message_y': instance.offset_message_y,
      'offset_btn1_x': instance.offset_btn1_x,
      'offset_btn1_y': instance.offset_btn1_y,
      'offset_btn2_x': instance.offset_btn2_x,
      'offset_btn2_y': instance.offset_btn2_y,
      'offset_btn3_x': instance.offset_btn3_x,
      'offset_btn3_y': instance.offset_btn3_y,
      'offset_btn4_x': instance.offset_btn4_x,
      'offset_btn4_y': instance.offset_btn4_y,
      'offset_item_anytime_tend_x': instance.offset_item_anytime_tend_x,
      'offset_item_anytime_tend_y': instance.offset_item_anytime_tend_y,
      'offset_lang_btn_x': instance.offset_lang_btn_x,
      'offset_lang_btn_y': instance.offset_lang_btn_y,
      'offset_explain_x': instance.offset_explain_x,
      'offset_translate_x': instance.offset_translate_x,
      'offset_translate_y': instance.offset_translate_y,
    };

_Avi_size _$Avi_sizeFromJson(Map<String, dynamic> json) => _Avi_size(
      movie_normal_w: json['movie_normal_w'] as int? ?? 800,
      movie_normal_h: json['movie_normal_h'] as int? ?? 390,
      movie_cashin_w: json['movie_cashin_w'] as int? ?? 800,
      movie_cashin_h: json['movie_cashin_h'] as int? ?? 200,
      movie_cashinout_w: json['movie_cashinout_w'] as int? ?? 292,
      movie_cashinout_h: json['movie_cashinout_h'] as int? ?? 390,
    );

Map<String, dynamic> _$Avi_sizeToJson(_Avi_size instance) => <String, dynamic>{
      'movie_normal_w': instance.movie_normal_w,
      'movie_normal_h': instance.movie_normal_h,
      'movie_cashin_w': instance.movie_cashin_w,
      'movie_cashin_h': instance.movie_cashin_h,
      'movie_cashinout_w': instance.movie_cashinout_w,
      'movie_cashinout_h': instance.movie_cashinout_h,
    };
