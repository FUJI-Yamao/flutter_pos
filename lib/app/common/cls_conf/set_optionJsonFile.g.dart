// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_optionJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Set_optionJsonFile _$Set_optionJsonFileFromJson(Map<String, dynamic> json) =>
    Set_optionJsonFile()
      ..stm = _Stm.fromJson(json['stm'] as Map<String, dynamic>)
      ..smlcls = _Smlcls.fromJson(json['smlcls'] as Map<String, dynamic>)
      ..plu = _Plu.fromJson(json['plu'] as Map<String, dynamic>);

Map<String, dynamic> _$Set_optionJsonFileToJson(Set_optionJsonFile instance) =>
    <String, dynamic>{
      'stm': instance.stm.toJson(),
      'smlcls': instance.smlcls.toJson(),
      'plu': instance.plu.toJson(),
    };

_Stm _$StmFromJson(Map<String, dynamic> json) => _Stm(
      def_sch_qty: json['def_sch_qty'] as int? ?? 1,
      def_item_qty: json['def_item_qty'] as int? ?? 1,
    );

Map<String, dynamic> _$StmToJson(_Stm instance) => <String, dynamic>{
      'def_sch_qty': instance.def_sch_qty,
      'def_item_qty': instance.def_item_qty,
    };

_Smlcls _$SmlclsFromJson(Map<String, dynamic> json) => _Smlcls(
      def_tax_cd: json['def_tax_cd'] as int? ?? 2,
    );

Map<String, dynamic> _$SmlclsToJson(_Smlcls instance) => <String, dynamic>{
      'def_tax_cd': instance.def_tax_cd,
    };

_Plu _$PluFromJson(Map<String, dynamic> json) => _Plu(
      sims_cnct_new_plu: json['sims_cnct_new_plu'] as int? ?? 0,
    );

Map<String, dynamic> _$PluToJson(_Plu instance) => <String, dynamic>{
      'sims_cnct_new_plu': instance.sims_cnct_new_plu,
    };
