// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fjssJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FjssJsonFile _$FjssJsonFileFromJson(Map<String, dynamic> json) => FjssJsonFile()
  ..fjss_system =
      _Fjss_system.fromJson(json['fjss_system'] as Map<String, dynamic>)
  ..csv_dly = _Csv_dly.fromJson(json['csv_dly'] as Map<String, dynamic>)
  ..max_item = _Max_item.fromJson(json['max_item'] as Map<String, dynamic>)
  ..page = _Page.fromJson(json['page'] as Map<String, dynamic>)
  ..item0 = _Item0.fromJson(json['item0'] as Map<String, dynamic>)
  ..item1 = _Item1.fromJson(json['item1'] as Map<String, dynamic>);

Map<String, dynamic> _$FjssJsonFileToJson(FjssJsonFile instance) =>
    <String, dynamic>{
      'fjss_system': instance.fjss_system.toJson(),
      'csv_dly': instance.csv_dly.toJson(),
      'max_item': instance.max_item.toJson(),
      'page': instance.page.toJson(),
      'item0': instance.item0.toJson(),
      'item1': instance.item1.toJson(),
    };

_Fjss_system _$Fjss_systemFromJson(Map<String, dynamic> json) => _Fjss_system(
      send_start: json['send_start'] as int? ?? 0,
      sendcnt: json['sendcnt'] as int? ?? 0,
      senditemcnt: json['senditemcnt'] as int? ?? 0,
    );

Map<String, dynamic> _$Fjss_systemToJson(_Fjss_system instance) =>
    <String, dynamic>{
      'send_start': instance.send_start,
      'sendcnt': instance.sendcnt,
      'senditemcnt': instance.senditemcnt,
    };

_Csv_dly _$Csv_dlyFromJson(Map<String, dynamic> json) => _Csv_dly(
      dly_clothes: json['dly_clothes'] as int? ?? 1,
      dlyclothes_week: json['dlyclothes_week'] as int? ?? 0,
      dlyclothes_day: json['dlyclothes_day'] as int? ?? 1,
    );

Map<String, dynamic> _$Csv_dlyToJson(_Csv_dly instance) => <String, dynamic>{
      'dly_clothes': instance.dly_clothes,
      'dlyclothes_week': instance.dlyclothes_week,
      'dlyclothes_day': instance.dlyclothes_day,
    };

_Max_item _$Max_itemFromJson(Map<String, dynamic> json) => _Max_item(
      total_item: json['total_item'] as int? ?? 2,
    );

Map<String, dynamic> _$Max_itemToJson(_Max_item instance) => <String, dynamic>{
      'total_item': instance.total_item,
    };

_Page _$PageFromJson(Map<String, dynamic> json) => _Page(
      total_page: json['total_page'] as int? ?? 1,
      onoff0: json['onoff0'] as int? ?? 0,
    );

Map<String, dynamic> _$PageToJson(_Page instance) => <String, dynamic>{
      'total_page': instance.total_page,
      'onoff0': instance.onoff0,
    };

_Item0 _$Item0FromJson(Map<String, dynamic> json) => _Item0(
      onoff: json['onoff'] as int? ?? 0,
      page: json['page'] as int? ?? 1,
      position: json['position'] as int? ?? 1,
      table1: json['table1'] as String? ?? '衣料商品',
      total: json['total'] as int? ?? 1,
      t_exe1: json['t_exe1'] as String? ?? 'KEDI',
      section: json['section'] as String? ?? 'csv_dly',
      keyword: json['keyword'] as String? ?? 'dly_clothes',
      backup_day: json['backup_day'] as String? ?? '0000-00-00',
      select_dsp: json['select_dsp'] as int? ?? 0,
    );

Map<String, dynamic> _$Item0ToJson(_Item0 instance) => <String, dynamic>{
      'onoff': instance.onoff,
      'page': instance.page,
      'position': instance.position,
      'table1': instance.table1,
      'total': instance.total,
      't_exe1': instance.t_exe1,
      'section': instance.section,
      'keyword': instance.keyword,
      'backup_day': instance.backup_day,
      'select_dsp': instance.select_dsp,
    };

_Item1 _$Item1FromJson(Map<String, dynamic> json) => _Item1(
      onoff: json['onoff'] as int? ?? 0,
      page: json['page'] as int? ?? 1,
      position: json['position'] as int? ?? 13,
      table1: json['table1'] as String? ?? '電子ｼﾞｬｰﾅﾙ累計',
      total: json['total'] as int? ?? 1,
      t_exe1: json['t_exe1'] as String? ?? 'c_ejlog',
      section: json['section'] as String? ?? 'csv_dly',
      keyword: json['keyword'] as String? ?? 'dly_ejlog_manual',
      keyword2: json['keyword2'] as String? ?? 'dlyejlog_week',
      backup_day: json['backup_day'] as String? ?? '0000-00-00',
      select_dsp: json['select_dsp'] as int? ?? 0,
    );

Map<String, dynamic> _$Item1ToJson(_Item1 instance) => <String, dynamic>{
      'onoff': instance.onoff,
      'page': instance.page,
      'position': instance.position,
      'table1': instance.table1,
      'total': instance.total,
      't_exe1': instance.t_exe1,
      'section': instance.section,
      'keyword': instance.keyword,
      'keyword2': instance.keyword2,
      'backup_day': instance.backup_day,
      'select_dsp': instance.select_dsp,
    };
