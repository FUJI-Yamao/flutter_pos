// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qc_start_dspJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Qc_start_dspJsonFile _$Qc_start_dspJsonFileFromJson(
        Map<String, dynamic> json) =>
    Qc_start_dspJsonFile()
      ..common = _Common.fromJson(json['common'] as Map<String, dynamic>)
      ..Private = _PPrivate.fromJson(json['Private'] as Map<String, dynamic>);

Map<String, dynamic> _$Qc_start_dspJsonFileToJson(
        Qc_start_dspJsonFile instance) =>
    <String, dynamic>{
      'common': instance.common.toJson(),
      'Private': instance.Private.toJson(),
    };

_Common _$CommonFromJson(Map<String, dynamic> json) => _Common(
      select_typ: json['select_typ'] as int? ?? 0,
      select_str_msg: json['select_str_msg'] as int? ?? 0,
    );

Map<String, dynamic> _$CommonToJson(_Common instance) => <String, dynamic>{
      'select_typ': instance.select_typ,
      'select_str_msg': instance.select_str_msg,
    };

_PPrivate _$PPrivateFromJson(Map<String, dynamic> json) => _PPrivate(
      TranReceiveQty: json['TranReceiveQty'] as int? ?? 0,
      ChangeChk: json['ChangeChk'] as int? ?? 1,
    );

Map<String, dynamic> _$PPrivateToJson(_PPrivate instance) => <String, dynamic>{
      'TranReceiveQty': instance.TranReceiveQty,
      'ChangeChk': instance.ChangeChk,
    };
