// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_sksJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scale_sksJsonFile _$Scale_sksJsonFileFromJson(Map<String, dynamic> json) =>
    Scale_sksJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>)
      ..info = _Info.fromJson(json['info'] as Map<String, dynamic>);

Map<String, dynamic> _$Scale_sksJsonFileToJson(Scale_sksJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
      'info': instance.info.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? '',
      baudrate: json['baudrate'] as int? ?? 38400,
      databit: json['databit'] as int? ?? 8,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 1,
      parity: json['parity'] as String? ?? 'even',
      bill: json['bill'] as String? ?? 'no',
      id: json['id'] as int? ?? 1,
      collect_num: json['collect_num'] as int? ?? 4,
      span_switch: json['span_switch'] as int? ?? 0,
      protect_span_spec: json['protect_span_spec'] as int? ?? 0,
      protect_count: json['protect_count'] as int? ?? 0,
      protect_data: json['protect_data'] as int? ?? 0,
      data_auth: json['data_auth'] as int? ?? 0,
      decimal_point_shape: json['decimal_point_shape'] as int? ?? 0,
      decimal_point_pos: json['decimal_point_pos'] as String? ?? '00',
      tare_auto_clear: json['tare_auto_clear'] as int? ?? 0,
      preset_tare: json['preset_tare'] as int? ?? 1,
      digital_tare_subtraction: json['digital_tare_subtraction'] as int? ?? 1,
      digital_tare_addition: json['digital_tare_addition'] as int? ?? 1,
      digital_tare: json['digital_tare'] as int? ?? 1,
      onetouch_tare_subtraction: json['onetouch_tare_subtraction'] as int? ?? 1,
      onetouch_tare_addition: json['onetouch_tare_addition'] as int? ?? 1,
      tare_range: json['tare_range'] as int? ?? 1,
      priority_preset_digital: json['priority_preset_digital'] as int? ?? 1,
      priority_preset_onetouch: json['priority_preset_onetouch'] as int? ?? 0,
      priority_digital_preset: json['priority_digital_preset'] as int? ?? 1,
      priority_digital_onetouch: json['priority_digital_onetouch'] as int? ?? 0,
      priority_onetouch_preset: json['priority_onetouch_preset'] as int? ?? 0,
      priority_onetouch_digital: json['priority_onetouch_digital'] as int? ?? 0,
      zero_tracking_when_tare: json['zero_tracking_when_tare'] as int? ?? 1,
      zero_reset_when_tare: json['zero_reset_when_tare'] as int? ?? 1,
      tare_disp_mode: json['tare_disp_mode'] as int? ?? 1,
      negative_disp: json['negative_disp'] as String? ?? '00',
      interval_typw: json['interval_typw'] as int? ?? 1,
      input_sensitivity: json['input_sensitivity'] as int? ?? 1100,
      reg_mode_print_range: json['reg_mode_print_range'] as String? ?? '000',
      pricing_mode_print_range:
          json['pricing_mode_print_range'] as String? ?? '000',
      kg_lb_switching: json['kg_lb_switching'] as int? ?? 0,
      percentage_tare_rounding: json['percentage_tare_rounding'] as int? ?? 0,
      tare_rounding_for_upper_range:
          json['tare_rounding_for_upper_range'] as int? ?? 0,
      onetouch_tare: json['onetouch_tare'] as int? ?? 0,
      zero_reset_range_at_start: json['zero_reset_range_at_start'] as int? ?? 0,
      zero_reset_range: json['zero_reset_range'] as int? ?? 0,
      use_area: json['use_area'] as int? ?? 0,
      setting_area: json['setting_area'] as int? ?? 0,
      price_decimal_point: json['price_decimal_point'] as int? ?? 0,
      unit_price_decimal_point: json['unit_price_decimal_point'] as int? ?? 0,
      price_decimal_point_pos:
          json['price_decimal_point_pos'] as String? ?? '00',
      unit_price_decimal_point_pos:
          json['unit_price_decimal_point_pos'] as String? ?? '00',
      second_price_calc: json['second_price_calc'] as String? ?? '0000',
      price_calc: json['price_calc'] as String? ?? '0000',
      special_rounding: json['special_rounding'] as String? ?? '0000',
      quote: json['quote'] as String? ?? '000',
      label_issuance_during_tare:
          json['label_issuance_during_tare'] as int? ?? 0,
      tare_automatic_update: json['tare_automatic_update'] as int? ?? 0,
      sws_f_to_f_scale_spec: json['sws_f_to_f_scale_spec'] as int? ?? 0,
      zero_lamp_pos: json['zero_lamp_pos'] as int? ?? 0,
      disp_print_type: json['disp_print_type'] as int? ?? 0,
      programmed_tare_clear: json['programmed_tare_clear'] as int? ?? 0,
      print_pre_discount_price: json['print_pre_discount_price'] as int? ?? 0,
      unit_price_digit: json['unit_price_digit'] as int? ?? 0,
      inverse_calc_of_unit_price:
          json['inverse_calc_of_unit_price'] as int? ?? 0,
      weight_manual_input: json['weight_manual_input'] as int? ?? 0,
      weight_key_in: json['weight_key_in'] as int? ?? 0,
      ad_type: json['ad_type'] as int? ?? 0,
      weighing: json['weighing'] as String? ?? '00000',
      price_printing_in_barcode: json['price_printing_in_barcode'] as int? ?? 0,
      quarter_round: json['quarter_round'] as String? ?? '00',
      round_price_type: json['round_price_type'] as int? ?? 0,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'port': instance.port,
      'baudrate': instance.baudrate,
      'databit': instance.databit,
      'startbit': instance.startbit,
      'stopbit': instance.stopbit,
      'parity': instance.parity,
      'bill': instance.bill,
      'id': instance.id,
      'collect_num': instance.collect_num,
      'span_switch': instance.span_switch,
      'protect_span_spec': instance.protect_span_spec,
      'protect_count': instance.protect_count,
      'protect_data': instance.protect_data,
      'data_auth': instance.data_auth,
      'decimal_point_shape': instance.decimal_point_shape,
      'decimal_point_pos': instance.decimal_point_pos,
      'tare_auto_clear': instance.tare_auto_clear,
      'preset_tare': instance.preset_tare,
      'digital_tare_subtraction': instance.digital_tare_subtraction,
      'digital_tare_addition': instance.digital_tare_addition,
      'digital_tare': instance.digital_tare,
      'onetouch_tare_subtraction': instance.onetouch_tare_subtraction,
      'onetouch_tare_addition': instance.onetouch_tare_addition,
      'tare_range': instance.tare_range,
      'priority_preset_digital': instance.priority_preset_digital,
      'priority_preset_onetouch': instance.priority_preset_onetouch,
      'priority_digital_preset': instance.priority_digital_preset,
      'priority_digital_onetouch': instance.priority_digital_onetouch,
      'priority_onetouch_preset': instance.priority_onetouch_preset,
      'priority_onetouch_digital': instance.priority_onetouch_digital,
      'zero_tracking_when_tare': instance.zero_tracking_when_tare,
      'zero_reset_when_tare': instance.zero_reset_when_tare,
      'tare_disp_mode': instance.tare_disp_mode,
      'negative_disp': instance.negative_disp,
      'interval_typw': instance.interval_typw,
      'input_sensitivity': instance.input_sensitivity,
      'reg_mode_print_range': instance.reg_mode_print_range,
      'pricing_mode_print_range': instance.pricing_mode_print_range,
      'kg_lb_switching': instance.kg_lb_switching,
      'percentage_tare_rounding': instance.percentage_tare_rounding,
      'tare_rounding_for_upper_range': instance.tare_rounding_for_upper_range,
      'onetouch_tare': instance.onetouch_tare,
      'zero_reset_range_at_start': instance.zero_reset_range_at_start,
      'zero_reset_range': instance.zero_reset_range,
      'use_area': instance.use_area,
      'setting_area': instance.setting_area,
      'price_decimal_point': instance.price_decimal_point,
      'unit_price_decimal_point': instance.unit_price_decimal_point,
      'price_decimal_point_pos': instance.price_decimal_point_pos,
      'unit_price_decimal_point_pos': instance.unit_price_decimal_point_pos,
      'second_price_calc': instance.second_price_calc,
      'price_calc': instance.price_calc,
      'special_rounding': instance.special_rounding,
      'quote': instance.quote,
      'label_issuance_during_tare': instance.label_issuance_during_tare,
      'tare_automatic_update': instance.tare_automatic_update,
      'sws_f_to_f_scale_spec': instance.sws_f_to_f_scale_spec,
      'zero_lamp_pos': instance.zero_lamp_pos,
      'disp_print_type': instance.disp_print_type,
      'programmed_tare_clear': instance.programmed_tare_clear,
      'print_pre_discount_price': instance.print_pre_discount_price,
      'unit_price_digit': instance.unit_price_digit,
      'inverse_calc_of_unit_price': instance.inverse_calc_of_unit_price,
      'weight_manual_input': instance.weight_manual_input,
      'weight_key_in': instance.weight_key_in,
      'ad_type': instance.ad_type,
      'weighing': instance.weighing,
      'price_printing_in_barcode': instance.price_printing_in_barcode,
      'quarter_round': instance.quarter_round,
      'round_price_type': instance.round_price_type,
    };

_Info _$InfoFromJson(Map<String, dynamic> json) => _Info(
      version: json['version'] as int? ?? 0,
    );

Map<String, dynamic> _$InfoToJson(_Info instance) => <String, dynamic>{
      'version': instance.version,
    };